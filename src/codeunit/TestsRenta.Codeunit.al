codeunit 50032 "Tests Renta"
{
    Permissions = TableData "Sales Invoice Line" = rm,
                  TableData "Sales Cr.Memo Line" = rm,
                  TableData "Purch. Inv. Line" = rm;

    trigger OnRun()
    begin
        /*
        Migration
        if ServeurInstance.FINDFIRST() then begin
            BaseAutorisee := (STRPOS(UPPERCASE(ServeurInstance."Service Name"), 'TEST') <> 0);
            BaseAutorisee := BaseAutorisee or (UPPERCASE(ServeurInstance."Server Computer Name") = 'ASUS1KAN'); //Pour tester sur mon propre PC
            if not BaseAutorisee then
                ERROR('Cette fonction ne peut être utilisée que dans la base de tests.');
        end else
            exit;
        */
        
        //IF NOT (USERID IN ['ABRANE\CHARGEAFFAIRES02','ABRANE\DEVEX']) THEN
        //  ERROR('Seuls KANOPI ET CHARGEAFFAIRES02 peuvent créer des cdes de tests');

        intChoix := STRMENU(ChoixLbl, 1);
        if intChoix = 0 then
            exit;

        //CodeChantierTest := 'QUI-0046';

        case intChoix of
            1:
                CreerCommandeVente();
            2:
                CreerCommandeSAVVente();
            3:
                MAJCoutPrisSurStock();
            4:
                SupprimerEcrituresRenta(CodeChantierTest);
        end;
    end;

    var
        EnteteVente: Record "Sales Header";
        LigneVente: Record "Sales Line";
        LigneEcotaxe: Record "Sales Line";
        WEEECode: Record "Taxe eco-mobilier";
        Article: Record Item;
        LigFactVente: Record "Sales Invoice Line";
        //ServeurInstance: Record "Server Instance";
        ReportMAJCoutPrisSurStock: Report "MAJ renta du pris sur stock";
        ChoixLbl: Label 'Créer commande vente,Créer commande vente SAV,Recalculer coût pris sur stock,Réinitialiser ce chantier (Vider écritures renta ; Ventes et achats décrochées du chantier)';
        intChoix: Integer;
        CodeChantierTest: Code[20];
        

        NumArt: Code[20];

        BaseAutorisee: Boolean;

    procedure DefChantier(pChant: Code[20])
    begin
        CodeChantierTest := pChant;
    end;

    procedure CreerCommandeVente()
    var
        Chantier: Record Chantier;
        ClientDonneurOrdre: Record Customer;
        Enseigne: Record Enseigne;
    begin
        Chantier.GET(CodeChantierTest);

        ClientDonneurOrdre.GET(Chantier."No. client");
        Enseigne.GET(Chantier."Code enseigne");
        Enseigne.TESTFIELD("Code groupe");

        EnteteVente.INIT();
        EnteteVente."Document Type" := EnteteVente."Document Type"::Order;
        EnteteVente."No." := '';
        EnteteVente.INSERT(true);
        EnteteVente.DefMasquerVerifCredit(true);
        EnteteVente.VALIDATE("Sell-to Customer No.", Chantier."No. client");
        EnteteVente.VALIDATE("Code chantier", CodeChantierTest);
        EnteteVente.VALIDATE("Salesperson Code", 'JORDAN J.');
        EnteteVente."External Document No." := 'TEST RENTA';
        EnteteVente.VALIDATE("Location Code", 'D_1');
        EnteteVente.MODIFY();

        AjouterLigneVente(EnteteVente);
        PAGE.RUN(42, EnteteVente);
    end;

    procedure CreerCommandeSAVVente()
    var
        lEnteteVente: Record "Sales Header";
        Enseigne: Record Enseigne;
        ClientDonneurOrdre: Record Customer;
        Chantier: Record Chantier;
        ShipToAddr: Record "Ship-to Address";
    begin
        Chantier.GET(CodeChantierTest);

        ClientDonneurOrdre.GET(Chantier."No. client");
        Enseigne.GET(Chantier."Code enseigne");
        Enseigne.TESTFIELD("Code groupe");

        lEnteteVente.INIT();
        lEnteteVente."Document Type" := lEnteteVente."Document Type"::Order;
        lEnteteVente."No." := '';
        lEnteteVente.ASS := true;

        lEnteteVente.INSERT(true);

        lEnteteVente."Document Date" := TODAY;
        lEnteteVente."Code enseigne" := Chantier."Code enseigne";
        lEnteteVente."Code groupe" := Enseigne."Code groupe";

        lEnteteVente.VALIDATE("Sell-to Customer No.", Chantier."No. client");
        lEnteteVente.VALIDATE("Location Code", 'D_1');

        if ClientDonneurOrdre."Payment Terms Code" <> '' then
            lEnteteVente.VALIDATE("Payment Terms Code", ClientDonneurOrdre."Payment Terms Code")
        else
            lEnteteVente.VALIDATE("Payment Terms Code", Enseigne."Code conditions paiement");

        lEnteteVente.VALIDATE("Code enseigne", Chantier."Code enseigne");
        lEnteteVente.VALIDATE("Code chantier", Chantier.Code);

        if ShipToAddr.GET(Chantier."No. client", Chantier.Code) then
            EnteteVente.VALIDATE("Ship-to Code", Chantier.Code);

        EnteteVente."Devis Stock" := false;
        EnteteVente.VALIDATE("Salesperson Code", 'JORDAN J.');
        EnteteVente."External Document No." := 'TEST RENTA';

        EnteteVente.MODIFY();

        AjouterLigneVente(EnteteVente);

        PAGE.RUN(42, EnteteVente);

        MESSAGE('La commande ' + EnteteVente."No." + ' a été créée.');
    end;

    procedure MAJCoutPrisSurStock()
    begin
        ReportMAJCoutPrisSurStock.DefFiltreChantier(CodeChantierTest);
        ReportMAJCoutPrisSurStock.RUN();
    end;

    procedure AjouterLigneVente(pEnteteVente: Record "Sales Header")
    var
        PrixUnit: Decimal;
    begin
        //On va chercher un article pour lequel on a du stock sur le magasin D1 car c'est le cas permettant de prendre sur stock ou sur achat
        NumArt := '';

        Article.SETRANGE("Location Filter", 'D_1');
        Article.SETFILTER(Inventory, '>%1', 0);
        LigFactVente.SETCURRENTKEY(Type, "No.");
        LigFactVente.SETRANGE(Type, LigFactVente.Type::Item);
        if Article.FINDSET(false) then
            repeat
                LigFactVente.SETRANGE("No.", Article."No.");
                LigFactVente.SETFILTER("Unit Price", '>0');
                if LigFactVente.FINDLAST() then begin
                    NumArt := Article."No.";
                    PrixUnit := LigFactVente."Unit Price";
                end;
            until (Article.NEXT() = 0) or (NumArt <> '');

        if NumArt = '' then begin
            NumArt := '1023111357_C';
            PrixUnit := 100;
        end;

        LigneVente.INIT();
        LigneVente."Document Type" := pEnteteVente."Document Type";
        LigneVente."Document No." := pEnteteVente."No.";
        LigneVente."Line No." := 10000;
        LigneVente.INSERT();
        LigneVente.VALIDATE(Type, LigneVente.Type::Item);
        //LigneVente.VALIDATE("No.",'1024330474_F');
        LigneVente.VALIDATE("No.", NumArt);
        LigneVente.VALIDATE(Quantity, 10);
        if pEnteteVente.ASS then begin
            LigneVente.VALIDATE("Unit Price", 0);
            LigneVente.SAV := true;
        end else
            LigneVente.VALIDATE("Unit Price", PrixUnit);

        LigneVente.MODIFY();

        if not pEnteteVente.ASS then 
            if WEEECode.GET(LigneVente."Eco Tax Furniture Code", 0D) then begin

                LigneEcotaxe.INIT();
                LigneEcotaxe.SetHideValidationDialog(true);

                LigneEcotaxe."Document Type" := pEnteteVente."Document Type";
                LigneEcotaxe."Document No." := pEnteteVente."No.";
                LigneEcotaxe."Line No." := 20000;
                LigneEcotaxe.INSERT();
                LigneEcotaxe.VALIDATE("Sell-to Customer No.", pEnteteVente."Sell-to Customer No.");
                LigneEcotaxe.VALIDATE(Type, LigneEcotaxe.Type::"G/L Account");
                LigneEcotaxe.VALIDATE("No.", WEEECode."Account No.");
                WEEECode.GET(LigneVente."Eco Tax Furniture Code");
                LigneEcotaxe.Description := STRSUBSTNO('%1 %2', '  ', WEEECode.Description);
                LigneEcotaxe.VALIDATE("Prepayment VAT Identifier", LigneEcotaxe."VAT Identifier");
                LigneEcotaxe.VALIDATE("Prepayment VAT %", LigneEcotaxe."VAT %");
                LigneEcotaxe."Allow Invoice Disc." := false;
                LigneEcotaxe."Allow Line Disc." := false;
                LigneEcotaxe."Allow Item Charge Assignment" := false;
                LigneEcotaxe."Eco Tax Furniture Line" := true;
                LigneEcotaxe.VALIDATE(Quantity, LigneVente."Quantity (Base)");
                LigneEcotaxe."Eco Tax Furniture Code" := LigneVente."Eco Tax Furniture Code";
                LigneEcotaxe."Eco Tax Furniture Qty Per" := LigneVente."Eco Tax Furniture Qty Per";
                LigneEcotaxe."Eco Tax Furniture Amount" := WEEECode."Unit Amount";
                LigneEcotaxe.VALIDATE("Unit Price", WEEECode."Unit Amount" * LigneVente."Eco Tax Furniture Qty Per");
                LigneEcotaxe.VALIDATE("Unit Cost (LCY)", LigneEcotaxe."Unit Price");
                LigneEcotaxe."Attached to Line No." := LigneVente."Line No.";
                LigneEcotaxe.MODIFY();
            end;
        
    end;

    procedure SupprimerEcrituresRenta(pCodeChantier: Code[20])
    var
        EcrtureRenta: Record "Ecriture rentabilite";
        LigneFactureVente: Record "Sales Invoice Line";
        MAJLigneFactVente: Record "Sales Invoice Line";
        LigneAvoirVente: Record "Sales Cr.Memo Line";
        MAJLigneAvoirVente: Record "Sales Cr.Memo Line";
        LigneFactAchat: Record "Purch. Inv. Line";
        MAJLigneFactAchat: Record "Purch. Inv. Line";
        LigneCdeAchat: Record "Purchase Line";
        MAJLigneCdeAchat: Record "Purchase Line";
    begin
        EcrtureRenta.SETCURRENTKEY("Code chantier", "Type de cout");
        EcrtureRenta.SETRANGE("Code chantier", pCodeChantier);
        EcrtureRenta.DELETEALL();
        MESSAGE('Les écritures de renta du chantier ' + pCodeChantier + ' ont été supprimées.');

        LigneFactureVente.SETCURRENTKEY("Code chantier", "Exclure de la rentabilite", "Posting Date");
        LigneFactureVente.SETRANGE("Code chantier", pCodeChantier);
        if LigneFactureVente.FINDSET(false) then
            repeat
                MAJLigneFactVente.GET(LigneFactureVente."Document No.", LigneFactureVente."Line No.");
                MAJLigneFactVente."Code chantier" := '';
                MAJLigneFactVente."Code groupe" := '';
                MAJLigneFactVente."Code enseigne" := '';
                MAJLigneFactVente."Code operation" := '';
                MAJLigneFactVente.MODIFY();
            until LigneFactureVente.NEXT() = 0;

        LigneAvoirVente.SETCURRENTKEY("Code chantier", "Exclure de la rentabilite", "Posting Date");
        LigneAvoirVente.SETRANGE("Code chantier", pCodeChantier);
        if LigneAvoirVente.FINDSET(false) then
            repeat
                MAJLigneAvoirVente.GET(LigneAvoirVente."Document No.", LigneAvoirVente."Line No.");
                MAJLigneAvoirVente."Code chantier" := '';
                MAJLigneAvoirVente."Code groupe" := '';
                MAJLigneAvoirVente."Code enseigne" := '';
                MAJLigneAvoirVente."Code operation" := '';
                MAJLigneAvoirVente.MODIFY();
            until LigneAvoirVente.NEXT() = 0;

        LigneFactAchat.SETCURRENTKEY("Code chantier", "Achat pour stock", "Posting Date");
        LigneFactAchat.SETRANGE("Code chantier", pCodeChantier);
        if LigneFactAchat.FINDSET(false) then
            repeat
                MAJLigneFactAchat.GET(LigneFactAchat."Document No.", LigneFactAchat."Line No.");
                MAJLigneFactAchat."Code chantier" := '';
                MAJLigneFactAchat."Code groupe" := '';
                MAJLigneFactAchat."Code enseigne" := '';
                MAJLigneFactAchat."Code operation" := '';
                MAJLigneFactAchat.MODIFY();
            until LigneFactAchat.NEXT() = 0;

        LigneCdeAchat.SETCURRENTKEY("Code chantier");
        LigneCdeAchat.SETRANGE("Code chantier", pCodeChantier);
        if LigneCdeAchat.FINDSET(false) then
            repeat
                MAJLigneCdeAchat.GET(LigneCdeAchat."Document Type", LigneCdeAchat."Document No.", LigneCdeAchat."Line No.");
                MAJLigneCdeAchat."Code chantier" := '';
                MAJLigneCdeAchat."Code groupe" := '';
                MAJLigneCdeAchat."Code enseigne" := '';
                MAJLigneCdeAchat."Code operation" := '';
                MAJLigneCdeAchat.MODIFY();
            until LigneCdeAchat.NEXT() = 0;
    end;
}

