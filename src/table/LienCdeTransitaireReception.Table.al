table 50042 "Lien cde transitaire-reception"
{
    // Une commande/facture transitaire concerne plusieurs réceptions d'achat. Cette table va permettre à l'utilisateur de dire quelles sont les réceptions
    // concernées par une facture transitaire et cela permettra au système d'éclater les frais annexes achetés au transitaire en autant de lignes
    // qu'on a de réceptions liées tout en éclatant les montants au prorata de chaque ligne.

    Caption = 'Lien cde transitaire-reception';

    fields
    {
        field(10; "No. commande transitaire"; Code[20])
        {
            Caption = 'N° commande transitaire';
            TableRelation = "Purchase Header"."No." where ("Document Type" = const (Order));
        }
        field(30; "No. bon de reception"; Code[20])
        {
            Caption = 'N° bon de réception';
            TableRelation = "Purch. Rcpt. Header";
        }
        field(40; "No. ligne bon reception"; Integer)
        {
            Caption = 'N° ligne bon réception';
        }
        field(45; "No. commande marchandise"; Code[20])
        {
            Caption = 'N° commande marchandise';
            TableRelation = "Purchase Header"."No." where ("Document Type" = const (Order));
        }
        field(48; "No. container"; Code[20])
        {
            Caption = 'N° container';
            TableRelation = Container;
        }
        field(50; "No. article"; Code[20])
        {
            Caption = 'N° article';
        }
        field(60; Description; Text[100])
        {
        }
        field(70; "Quantite recue"; Decimal)
        {
            Caption = 'Quantité reçue';
            DecimalPlaces = 0 : 5;
        }
        field(80; "Cout unitaire direct (DS)"; Decimal)
        {
            Caption = 'Coût unitaire direct (DS)';
            DecimalPlaces = 2 : 2;
        }
        field(90; "Montant recu ligne (DS)"; Decimal)
        {
            Caption = 'Montant reçu ligne (DS)';
            DecimalPlaces = 2 : 2;
        }
        field(100; "Montant recu ce BR (DS)"; Decimal)
        {
            CalcFormula = sum ("Lien cde transitaire-reception"."Montant recu ligne (DS)" where ("No. commande transitaire" = field ("No. commande transitaire"),
                                                                                                "No. bon de reception" = field ("No. bon de reception")));
            Caption = 'Montant reçu ce BR (DS)';
            Description = 'Somme des montants reçus pour la même commande de marchandise (pour proratiser les frais) ; Sum("Lien cde transitaire-reception"."Montant recu ligne DS" WHERE (No. commande transitaire=FIELD(No. commande transitaire),No. commande marchandise=FIELD(No. commande marchandise)))';
            Editable = false;
            FieldClass = FlowField;
        }
        field(110; "Montant recu total (DS)"; Decimal)
        {
            CalcFormula = sum ("Lien cde transitaire-reception"."Montant recu ligne (DS)" where ("No. commande transitaire" = field ("No. commande transitaire")));
            Caption = 'Montant reçu total (DS)';
            Description = 'Somme des montants reçus totale (pour proratiser les frais)';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No. commande transitaire", "No. bon de reception", "No. ligne bon reception")
        {
            Clustered = true;
            SumIndexFields = "Montant recu ligne (DS)";
        }
        key(Key2; "No. commande transitaire", "No. commande marchandise")
        {
            SumIndexFields = "Montant recu ligne (DS)";
        }
    }

    fieldgroups
    {
    }



    var
        Container: Record Container;

    procedure ExtraireContainer(pNumCdeAchat: Code[20])
    var
        EnteteReception: Record "Purch. Rcpt. Header";
        LigneReception: Record "Purch. Rcpt. Line";
        Lien: Record "Lien cde transitaire-reception";
        PageListContainer: Page "Liste containers";

        
    begin
        if pNumCdeAchat = '' then
            exit;

        Container.Reset();
        Container.SetRange("Statut container", Container."Statut container"::"Réceptionné");
        Clear(PageListContainer);
        PageListContainer.SETTABLEVIEW(Container);
        PageListContainer.LOOKUPMODE(true);

        if PageListContainer.RUNMODAL() = ACTION::LookupOK then begin
            PageListContainer.GETRECORD(Container);
            //Clé de la table de liens : No. commande achat,No. ligne document achat,No. bon de reception,No. ligne bon reception
            EnteteReception.Reset();
            EnteteReception.SetCurrentKey("No. container");
            EnteteReception.SetRange("No. container", Container."No.");
            if EnteteReception.FindSet(false) then
                repeat
                    LigneReception.SetRange("Document No.", EnteteReception."No.");
                    LigneReception.SetRange(Type, LigneReception.Type::Item);
                    if LigneReception.FindSet(false) then
                        repeat
                            if LigneReception.Quantity <> 0 then begin
                                Lien.Init();
                                Lien."No. commande transitaire" := pNumCdeAchat;
                                Lien."No. bon de reception" := EnteteReception."No.";
                                Lien."No. ligne bon reception" := LigneReception."Line No.";
                                Lien."No. commande marchandise" := EnteteReception."Order No.";
                                Lien."No. article" := LigneReception."No.";
                                Lien.Description := LigneReception.Description;
                                Lien."Quantite recue" := LigneReception.Quantity;
                                Lien."Cout unitaire direct (DS)" := LigneReception."Unit Cost (LCY)";
                                Lien."Montant recu ligne (DS)" := Round(Lien."Quantite recue" * Lien."Cout unitaire direct (DS)", 0.01);
                                Lien."No. container" := EnteteReception."No. container";
                                Lien.Insert();
                            end;
                        until LigneReception.Next() = 0;
                until EnteteReception.Next() = 0;
        end;
    end;

    procedure EclaterLignesTransitaire()
    var
        LigneAchatActuelle: Record "Purchase Line";
        Liens: Record "Lien cde transitaire-reception";
        NouvelleLigneAchat: Record "Purchase Line";
        EnteteAchatTransitaire: Record "Purchase Header";
        AffectationFraisAnnexe: Record "Item Charge Assignment (Purch)";
        LigneReception: Record "Purch. Rcpt. Line";
        Devise: Record Currency;
        LigneAchatPourEcartArrondi: Record "Purchase Line";
        
        cuSuggererFraisAnnexe: Codeunit "Item Charge Assgnt. (Purch.)";

        NumCdeAchatTransitaire: Code[20];
        NumCde: Code[20];
        
        NumLigneMaxActuel: Integer;
        NumLigne: Integer;
        NumLigneFraisAnnexe: Integer;   
        
        PrecisionArrondi: Decimal;
        MontantTransitaireAffecteLigne: Decimal;
        MontantTransitaireAffecteTotal: Decimal;
        
        FraisDejaEclatesErr: Label 'Les frais annexes ont déjà été éclatés. Si vous voulez modifier les frais annexes, vous pouvez soit le faire manuellement, soit décocher le champ [Frais transitaire éclatés], accepter la suppression des lignes et re-saisir manuellemenent les frais annexes avant de demander à les rééclater.';
        
        PlusGrosMontantAffecte: Decimal;
        NumLignePlusGrosMontantAffecte: Integer;
        
    begin
        //Cette fonction va dupliquer sur la commande d'achat au transitaire les lignes de frais annexes autant de fois qu'on a de commandes
        //d'achats de marchandises qui ont été réceptionnées via les containers liés à la commande du transitaire et ensuite affecter les frais annexes
        //aux lignes de réception correspondantes.
        NumCdeAchatTransitaire := "No. commande transitaire";

        if NumCdeAchatTransitaire = '' then
            exit;

        EnteteAchatTransitaire.Get(EnteteAchatTransitaire."Document Type"::Order, NumCdeAchatTransitaire);

        if EnteteAchatTransitaire."Frais transitaire eclates" then
            Error(FraisDejaEclatesErr);

        if EnteteAchatTransitaire."Currency Code" = '' then
            PrecisionArrondi := 0.01
        else begin
            Devise.Get(EnteteAchatTransitaire."Currency Code");
            PrecisionArrondi := Devise."Amount Rounding Precision";
        end;

        LigneAchatActuelle.Reset();
        LigneAchatActuelle.SetRange("Document Type", LigneAchatActuelle."Document Type"::Order);
        LigneAchatActuelle.SetRange("Document No.", NumCdeAchatTransitaire);
        if LigneAchatActuelle.FindLast() then
            NumLigneMaxActuel := LigneAchatActuelle."Line No.";

        NumLigne := NumLigneMaxActuel + 10000;
        NumLigneFraisAnnexe := 10000;

        LigneAchatActuelle.SetRange(Type, LigneAchatActuelle.Type::"Charge (Item)");
        LigneAchatActuelle.SetRange("Line No.", 0, NumLigneMaxActuel);

        if LigneAchatActuelle.FindSet(false) then
            repeat
                //On va parcourir les lignes de réceptions par N° cde achat marchandise.
                //A chaque fois qu'on change de N° cde achat marchandise, on cherche les frais annexes présents sur la commande d'achat au transitaire et on crée les mêmes lignes pour la commande d'achat marchandise
                //Donc si on avait 3 frais annexes sur la commande d'achat au transitaire et qu'on a extrait des lignes de réception (via containers) provenant de 4 commandes d'achats de marchandises différentes,
                //on va créer 12 lignes de frais annexes (et supprimer les lignes de départ).
                Liens.Reset();
                Liens.SetCurrentKey("No. commande transitaire", "No. bon de reception", "No. ligne bon reception");
                Liens.SetRange("No. commande transitaire", NumCdeAchatTransitaire);
                if Liens.FindSet(false) then begin
                    NumCde := '';
                    MontantTransitaireAffecteTotal := 0;
                    PlusGrosMontantAffecte := 0;
                    NumLignePlusGrosMontantAffecte := 0;

                    repeat
                        if NumCde <> Liens."No. bon de reception" then begin
                            MontantTransitaireAffecteLigne := 0;

                            Liens.CalcFields("Montant recu ce BR (DS)", "Montant recu total (DS)");
                            if not LigneReception.Get(Liens."No. bon de reception", Liens."No. ligne bon reception") then
                                LigneReception.Init();
                            if Liens."Montant recu ce BR (DS)" <> 0 then begin
                                MontantTransitaireAffecteLigne := Round(Liens."Montant recu ce BR (DS)" / Liens."Montant recu total (DS)" * LigneAchatActuelle."Line Amount", PrecisionArrondi);
                                if MontantTransitaireAffecteLigne <> 0 then begin
                                    NouvelleLigneAchat.Init();
                                    NouvelleLigneAchat."Document Type" := NouvelleLigneAchat."Document Type"::Order;
                                    NouvelleLigneAchat."Document No." := NumCdeAchatTransitaire;
                                    NouvelleLigneAchat."Line No." := NumLigne;
                                    NouvelleLigneAchat.Validate(Type, NouvelleLigneAchat.Type::" ");
                                    NouvelleLigneAchat.Validate("No.", '');
                                    NouvelleLigneAchat.Description := Liens."No. commande marchandise" + ' / ' + Liens."No. bon de reception";
                                    NouvelleLigneAchat.Insert();
                                    NumLigne := NumLigne + 10000;

                                    NouvelleLigneAchat.Init();
                                    NouvelleLigneAchat."Document Type" := NouvelleLigneAchat."Document Type"::Order;
                                    NouvelleLigneAchat."Document No." := NumCdeAchatTransitaire;
                                    NouvelleLigneAchat."Line No." := NumLigne;
                                    NouvelleLigneAchat.Validate(Type, NouvelleLigneAchat.Type::"Charge (Item)");
                                    NouvelleLigneAchat.Validate("No.", LigneAchatActuelle."No.");
                                    NouvelleLigneAchat.Validate(Quantity, LigneAchatActuelle.Quantity);
                                    MontantTransitaireAffecteTotal := MontantTransitaireAffecteTotal + MontantTransitaireAffecteLigne;
                                    NouvelleLigneAchat.Validate("Direct Unit Cost", MontantTransitaireAffecteLigne);
                                    NouvelleLigneAchat."Code groupe" := LigneReception."Code groupe";
                                    NouvelleLigneAchat."Code enseigne" := LigneReception."Code enseigne";
                                    NouvelleLigneAchat."Code operation" := LigneReception."Code operation";
                                    NouvelleLigneAchat."Code chantier" := LigneReception."Code chantier";
                                    NouvelleLigneAchat.Insert();
                                    NumLigne := NumLigne + 10000;

                                    if MontantTransitaireAffecteLigne > PlusGrosMontantAffecte then begin
                                        PlusGrosMontantAffecte := MontantTransitaireAffecteLigne;
                                        NumLignePlusGrosMontantAffecte := NouvelleLigneAchat."Line No.";
                                    end;
                                end;
                            end;
                        end;
                        //KAN.FHA 21/09/2022 DEBUT
                        if MontantTransitaireAffecteLigne <> 0 then begin
                            //KAN.FHA 21/09/2022 FIN
                            AffectationFraisAnnexe.Init();
                            AffectationFraisAnnexe."Document Type" := EnteteAchatTransitaire."Document Type";
                            AffectationFraisAnnexe."Document No." := EnteteAchatTransitaire."No.";
                            AffectationFraisAnnexe."Document Line No." := NouvelleLigneAchat."Line No.";
                            AffectationFraisAnnexe."Line No." := NumLigneFraisAnnexe;
                            AffectationFraisAnnexe."Item Charge No." := NouvelleLigneAchat."No.";
                            AffectationFraisAnnexe."Item No." := Liens."No. article";
                            AffectationFraisAnnexe.Description := Liens.Description;
                            AffectationFraisAnnexe."Unit Cost" := NouvelleLigneAchat."Direct Unit Cost";
                            AffectationFraisAnnexe."Applies-to Doc. Type" := AffectationFraisAnnexe."Applies-to Doc. Type"::Receipt;
                            AffectationFraisAnnexe."Applies-to Doc. No." := Liens."No. bon de reception";
                            AffectationFraisAnnexe."Applies-to Doc. Line No." := Liens."No. ligne bon reception";
                            AffectationFraisAnnexe.Insert();
                            NumLigneFraisAnnexe := NumLigneFraisAnnexe + 10000;
                        end;
                        NumCde := Liens."No. bon de reception";
                        //KAN.FHA 01/03/2023 DEBUT
                        if Liens."No. container" <> '' then begin
                            Container.Get(Liens."No. container");
                            if not Container."Frais transport ventiles" then begin
                                Container."Frais transport ventiles" := true;
                                Container.Modify();
                            end;
                        end;
                        //KAN.FHA 01/03/2023 FIN
                    until Liens.Next() = 0;

                    if MontantTransitaireAffecteTotal <> LigneAchatActuelle."Line Amount" then begin
                        LigneAchatPourEcartArrondi.Get(NouvelleLigneAchat."Document Type", NouvelleLigneAchat."Document No.", NumLignePlusGrosMontantAffecte);
                        LigneAchatPourEcartArrondi.Validate("Direct Unit Cost", LigneAchatPourEcartArrondi."Direct Unit Cost" + (LigneAchatActuelle."Line Amount" - MontantTransitaireAffecteTotal));
                        LigneAchatPourEcartArrondi.Modify();
                        AffectationFraisAnnexe."Unit Cost" := AffectationFraisAnnexe."Unit Cost" + (LigneAchatActuelle."Line Amount" - MontantTransitaireAffecteTotal);
                        AffectationFraisAnnexe.Modify();
                    end;
                end;
            until LigneAchatActuelle.Next() = 0;

        //On supprime les lignes de commande d'achat d'origine
        LigneAchatActuelle.DeleteAll();

        //A ce stade, on a les lignes d'affectation Frais annexes mais ils ne sont pas encore affectés au prorata des montants.
        //On va donc parcourir les nouvelles lignes de frais annexes et simuler le "Suggérer affectation frais annexes" pour chaque ligne
        NouvelleLigneAchat.Reset();
        NouvelleLigneAchat.SetRange("Document Type", LigneAchatActuelle."Document Type"::Order);
        NouvelleLigneAchat.SetRange("Document No.", NumCdeAchatTransitaire);
        NouvelleLigneAchat.SetRange(Type, LigneAchatActuelle.Type::"Charge (Item)");
        NouvelleLigneAchat.SetFilter("Line No.", '>%1', NumLigneMaxActuel);
        if NouvelleLigneAchat.FindSet(true) then
            repeat
                //Migration
                //cuSuggererFraisAnnexe.SuggestAssgnt2(NouvelleLigneAchat, NouvelleLigneAchat.Quantity, NouvelleLigneAchat."Line Amount", 2);
                //Remplacé par : (non testé)
                cuSuggererFraisAnnexe.AssignItemCharges(NouvelleLigneAchat, NouvelleLigneAchat.Quantity, NouvelleLigneAchat."Line Amount", 2);
                
            until NouvelleLigneAchat.Next() = 0;

        Message('Eclatement effectué');
    end;
}

