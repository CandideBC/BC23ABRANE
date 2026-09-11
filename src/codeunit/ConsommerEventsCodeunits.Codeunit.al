codeunit 50017 ConsommerEventsCodeunits
{
    //Permissions = TableData "Sales Shipment Line" = rm;
    Permissions = tabledata "Sales Invoice Header" = rm,
                TableData "Purch. Inv. Header" = rm;

    [EventSubscriber(ObjectType::Codeunit, 12, OnBeforeInsertDtldCustLedgEntry, '', false, false)]
    local procedure CU12_OnBeforeInsertDtldCustLedgEntry(var DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        DtldCustLedgEntry."Code enseigne" := GenJournalLine."Code enseigne";
    end;

    [EventSubscriber(ObjectType::Codeunit, 22, OnAfterInitItemLedgEntry, '', false, false)]
    local procedure CU22_OnAfterInitItemLedgEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line")
    begin
        NewItemLedgEntry."Document Type BOM" := ItemJournalLine."Document Type BOM";
        NewItemLedgEntry."Document No. BOM" := ItemJournalLine."Document No. BOM";
        NewItemLedgEntry."Document Line No. BOM" := ItemJournalLine."Document Line No. BOM";

        NewItemLedgEntry."Remis en stock depuis BL" := ItemJournalLine."Remis en stock depuis BL";
        NewItemLedgEntry."Transfert reception achat" := ItemJournalLine."Transfert reception achat";

        NewItemLedgEntry."SAV fournisseur" := ItemJournalLine."SAV fournisseur";
        NewItemLedgEntry."Exclure DEB" := ItemJournalLine."Exclure DEB";
    end;

    [EventSubscriber(ObjectType::codeunit, 22, OnAfterInitValueEntry, '', false, false)]
    local procedure CU22_OnAfterInitValueEntry(var ValueEntry: Record "Value Entry"; var ItemJournalLine: Record "Item Journal Line")
    begin
        ValueEntry."Document Type BOM" := ItemJournalLine."Document Type BOM";
        ValueEntry."Document No. BOM" := ItemJournalLine."Document No. BOM";
        ValueEntry."Document Line No. BOM" := ItemJournalLine."Document Line No. BOM";
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, OnBeforePostSalesDoc, '', false, false)]
    local procedure CU80_OnBeforePostSalesDoc(var SalesHeader: Record "Sales Header")
    var
        LigneVente: Record "Sales Line";
        TextCheckItemErr: Label 'La ligne %1 est de type Article mais le champ N° est vide. Vous devez supprimer la ligne ou mettre une référence article.', Comment = '%1 = N° ligne';
        ComposantAvecMontantErr: Label 'Validation impossible, car il existe un composant valorisé %1, sur la ligne du document %2 %3 %4', Comment = '%1 = Montant ; %2 = Type docuùent ; %3 = N° document ; %4 = N° ligne document';
    begin

        LigneVente.RESET();
        LigneVente.SETRANGE("Document Type", SalesHeader."Document Type");
        LigneVente.SETRANGE("Document No.", SalesHeader."No.");
        LigneVente.SETFILTER(Type, '<> %1', LigneVente.Type::" ");
        LigneVente.SETFILTER("No.", '= %1 ', ' ');

        if not LigneVente.IsEmpty then
            Error(TextCheckItemErr, LigneVente."Line No.");

        LigneVente.Reset();
        LigneVente.SETRANGE("Document Type", SalesHeader."Document Type");
        LigneVente.SETRANGE("Document No.", SalesHeader."No.");
        LigneVente.SETFILTER("Linked to line", '>%1', 0);
        LigneVente.SETFILTER(Amount, '<>%1', 0);
        if LigneVente.FINDFIRST() then
            ERROR(ComposantAvecMontantErr, LigneVente.Amount, LigneVente."Document Type", LigneVente."Document No.", LigneVente."Line No.");


    end;

    /*KAN.FHA 15/09/2025 On revient au standard : on doit saisir une date de compta !!
    [EventSubscriber(ObjectType::Codeunit, 80, OnBeforeValidatePostingAndDocumentDate, '', false, false)]
    local procedure CU80_OnBeforeValidatePostingAndDocumentDate(var SalesHeader: Record "Sales Header")
    var
        MAJ_DateComptaQst: label 'Vous n''avez pas saisi de date de comptabilisation, souhaitez-vous valider en date du %1?', Comment = '%1 = Date de travail';
        ProcessusInterrompuErr: label 'Opération annulée à la demande de l''utilisateur.';
    begin
        //<C05.01 DIAG.RGO 05/08/2014>
        if SalesHeader."Posting Date" = 0D then
            if Confirm(StrSubstNo(MAJ_DateComptaQst, WorkDate())) then begin
                SalesHeader.VALIDATE("Posting Date", WORKDATE());

                if SalesHeader."Document Date" = 0D then
                    SalesHeader.VALIDATE("Document Date", SalesHeader."Posting Date");
                SalesHeader.Modify();
            end else
                ERROR(ProcessusInterrompuErr);
        //</C05.01 DIAG.RGO 05/08/2014>

    end;
    KAN.FHA 15/09/2025
    */

    [EventSubscriber(ObjectType::Codeunit, 80, OnBeforeCheckAndUpdate, '', false, false)]
    local procedure CU80_OnBeforeCheckAndUpdate(var SalesHeader: Record "Sales Header")
    var
        Pays: Record "Country/Region";
        Client: Record Customer;
    begin
        if SalesHeader.Invoice then begin
            SalesHeader.VerifChampsAffaire();
            Client.get(SalesHeader."Bill-to Customer No.");
            Pays.Get(Client."Country/Region Code");
            if Pays."SIRET obligatoire" then
                Client.TestField("Registration Number");
            if Pays."No. TVA intracom. oblig." then
                Client.TestField("VAT Registration No.");
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, 80, OnInsertInvoiceHeaderOnAfterSalesInvHeaderTransferFields, '', false, false)]
    local procedure CU80_OnInsertInvoiceHeaderOnAfterSalesInvHeaderTransferFields(var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesHeader: Record "Sales Header")
    var
        Pays: Record "Country/Region";

    begin
        if not Pays.GET(SalesInvoiceHeader."Bill-to Country/Region Code") then
            Pays.INIT();

        if (SalesInvoiceHeader."Bill-to Country/Region Code" <> 'FR') and (SalesInvoiceHeader."Bill-to Country/Region Code" <> '') then
            SalesInvoiceHeader."Concernee DEB" := (Pays."Intrastat Code" <> '') and not SalesHeader."Facture acompte" and not SalesHeader."Facture situation" and SalesInvoiceHeader.ASS;

    end;

    [EventSubscriber(ObjectType::Codeunit, 80, OnInsertCrMemoHeaderOnAfterSalesCrMemoHeaderTransferFields, '', false, false)]
    local procedure CU80_OnInsertCrMemoHeaderOnAfterSalesCrMemoHeaderTransferFields(var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var SalesHeader: Record "Sales Header")
    var
        Pays: Record "Country/Region";
    begin
        if not Pays.GET(SalesCrMemoHeader."Bill-to Country/Region Code") then
            Pays.INIT();

        if (SalesCrMemoHeader."Bill-to Country/Region Code" <> 'FR') and (SalesCrMemoHeader."Bill-to Country/Region Code" <> '') then begin
            SalesCrMemoHeader."Concerne DEB" := (Pays."Intrastat Code" <> '') and not SalesHeader."Facture acompte";
            SalesCrMemoHeader.Modify();
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, 80, OnAfterSalesInvHeaderInsert, '', false, false)]
    local procedure CU80_OnAfterSalesInvHeaderInsert(var SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header")
    var
        EnteteVente: Record "Sales Header";
        LigneVente: Record "Sales Line";
        GroupeComptaMarche: Record "Gen. Business Posting Group";
        ReleaseSalesDocCodeunit: codeunit "Release Sales Document";
        LigneAcompteDeduitTxt: label 'Acompte %1', Comment = '%1 = N° facture';
        Ligne1NonDisponibleErr: Label 'Le système ne peut pas créer la ligne de déduction de l''acompte sur le document d''origine car le N° ligne 1 est déjà utilisé.';
        Ligne2NonDisponibleErr: Label 'Le système ne peut pas créer la ligne de déduction de la facture de situation sur le document d''origine car le N° ligne 2 est déjà utilisé.';
    begin
        //KAN.FHA 09/06/2020 DEBUT Gestion des acomptes
        if SalesHeader."Facture acompte" and (SalesHeader."Acompte pour No. document" <> '') then begin
            SalesHeader.CALCFIELDS(Amount);
            if EnteteVente.GET(SalesHeader."Acompte pour type doc.", SalesHeader."Acompte pour No. document") then begin
                ReleaseSalesDocCodeunit.Reopen(EnteteVente);
                EnteteVente."No. facture acompte" := '';
                EnteteVente."No. facture acompte enregistre" := SalesInvHeader."No.";
                EnteteVente."Acompte a creer" := false;
                EnteteVente."Acompte a deduire (HT)" := SalesHeader.Amount;
                EnteteVente.MODIFY();
                GroupeComptaMarche.GET(EnteteVente."Gen. Bus. Posting Group");
                GroupeComptaMarche.TESTFIELD("Compte acompte");
                //On va déduire l'acompte du document d'origine (ligne dans le doc origine sur le compte d'acompte 419 avec montant négatif)
                //On va dédier le N° ligne 1 à la ligne d'acompte et le N° ligne 2 à la facture de situation
                if LigneVente.get(EnteteVente."Document Type", EnteteVente."No.", 1) then
                    error(Ligne1NonDisponibleErr);

                LigneVente.INIT();
                LigneVente."Document Type" := EnteteVente."Document Type";
                LigneVente."Document No." := EnteteVente."No.";
                LigneVente."Line No." := 1;
                LigneVente.VALIDATE(Type, LigneVente.Type::"G/L Account");
                LigneVente.VALIDATE("No.", GroupeComptaMarche."Compte acompte");
                LigneVente.Description := STRSUBSTNO(LigneAcompteDeduitTxt, SalesInvHeader."No.");
                LigneVente.VALIDATE(Quantity, 1);
                LigneVente.VALIDATE("Unit Price", -SalesHeader.Amount);
                LigneVente."Ligne deduction acompte" := true;
                LigneVente.INSERT();
                EnteteVente.Status := EnteteVente.Status::Released;
            end;
        end;
        //KAN.FHA 06/07/2020 DEBUT Gestion des factures de situation
        if SalesHeader."Facture situation" and (SalesHeader."Fact. situation : No. document" <> '') then begin
            SalesHeader.CALCFIELDS(Amount);
            if EnteteVente.GET(SalesHeader."Fact. situation : type doc.", SalesHeader."Fact. situation : No. document") then begin
                ReleaseSalesDocCodeunit.Reopen(EnteteVente);
                EnteteVente."No. facture situation" := '';
                EnteteVente."No. facture situat. enregistre" := SalesInvHeader."No.";
                EnteteVente.MODIFY();
                GroupeComptaMarche.GET(EnteteVente."Gen. Bus. Posting Group");
                GroupeComptaMarche.TESTFIELD("Compte acompte");
                //On va deduire l'acompte du document d'origine (ligne dans le doc origine sur le compte d'acompte 419 avec quantite -1)
                if ligneVente.GET(EnteteVente."Document Type", EnteteVente."No.", 2) then
                    error(Ligne2NonDisponibleErr);

                LigneVente.INIT();
                LigneVente."Document Type" := EnteteVente."Document Type";
                LigneVente."Document No." := EnteteVente."No.";
                LigneVente."Line No." := 2;
                LigneVente.VALIDATE(Type, LigneVente.Type::"G/L Account");
                LigneVente.VALIDATE("No.", GroupeComptaMarche."Compte acompte");
                LigneVente.Description := STRSUBSTNO(LigneAcompteDeduitTxt, SalesInvHeader."No.");
                LigneVente.VALIDATE(Quantity, 1);
                LigneVente.VALIDATE("Unit Price", -SalesHeader.Amount);
                LigneVente."Ligne deduction situation" := true;
                LigneVente.INSERT();
                EnteteVente.Status := EnteteVente.Status::Released;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, OnPostSalesLineOnBeforeInsertShipmentLine, '', false, false)]
    local procedure CU80_OnPostSalesLineOnBeforeInsertShipmentLine(SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line")
    var
        CompanyInfo: Record "Company Information";
        Article: Record item;
    begin
        CompanyInfo.GET();
        if (SalesLine.Type = SalesLine.Type::Item) and (SalesLine."Qty. to Ship" <> 0) then
            if SalesHeader."Ship-to Country/Region Code" <> CompanyInfo."Country/Region Code" then begin
                if SalesLine."Nomenclature produits" <> '99999999' then
                    SalesLine.TESTFIELD("Country/Region of Origin Code");
                if not SalesLine."Article divers" then
                    SalesLine.TESTFIELD("Net Weight");
                if SalesLine."Article divers" then
                    if Article.GET(SalesLine."No.") then
                        if Article."Poids obligatoire" then
                            SalesLine.TESTFIELD("Nomenclature produits"); //Renseign que sur les divers ; la feuille intracomm va chercher la nomenc produit sur l'article pour les non Divers
            end;

        if (SalesLine."Article divers") and (SalesLine."Qty. to Ship" <> 0) then
            if Article.GET(SalesLine."No.") then
                if Article."Poids obligatoire" then
                    SalesLine.TESTFIELD("Net Weight");

    end;

    [EventSubscriber(ObjectType::Codeunit, 80, OnInsertShipmentLineOnAfterInitQuantityFields, '', false, false)]
    local procedure CU80_OnInsertShipmentLineOnAfterInitQuantityFields(var SalesShptLine: Record "Sales Shipment Line"; var xSalesLine: Record "Sales Line")
    begin
        SalesShptLine."Quantite commandee" := xSalesLine.Quantity;
        SalesShptLine."Quantite deja livree" := xSalesLine."Quantity Shipped";
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, OnBeforeSalesShptLineInsert, '', false, false)]
    local procedure CU80_OnBeforeSalesShptLineInsert(var SalesShptLine: Record "Sales Shipment Line"; SalesShptHeader: Record "Sales Shipment Header")
    var
        dNegPackingMgt: Codeunit "Packing Management";

    begin
        dNegPackingMgt.MAJContenuColisage(SalesShptLine);


    end;

    [EventSubscriber(ObjectType::Codeunit, 80, OnBeforeSalesInvLineInsert, '', false, false)]
    local procedure CU80_OnBeforeSalesInvLineInsert(var SalesInvLine: Record "Sales Invoice Line"; SalesLine: Record "Sales Line"; SalesInvHeader: Record "Sales Invoice Header")
    var
        EcritureRentabilite: record "Ecriture rentabilite";
        EcritureRentaCoutPrisSurStock: Record "Ecriture rentabilite";
        Chantier: Record Chantier;
        Magasin: Record Location;
        CurrExchRate: Record "Currency Exchange Rate";
        Article: Record Item;
        Pays: Record "Country/Region";
        ParamCodifab: Record "Parametrage articles Codifab";
        SalesSetup: record "Sales & Receivables Setup";
        NumEcrRentabilite: Integer;

    begin
        SalesInvLine."Cout unitaire force" := SalesLine."Cout unitaire force";

        if (not SalesInvLine."Eco Tax Furniture Line") and (SalesLine.Quantity <> 0) then
            if Chantier.GET(SalesInvLine."Code chantier") then
                if Chantier."Activer rentabilite" then begin //FHA BEGIN 3
                    if not Magasin.GET(SalesInvLine."Location Code") then
                        Magasin.INIT(); //On n'a pas forcement de magasin sur les lignes de compte
                    if not Magasin."Magasin client" then begin //FHA BEGIN 4
                        //Creer une ecriture de rentabilite de type "Chiffre d'affaires".
                        if EcritureRentabilite.FindLast() then
                            NumEcrRentabilite := EcritureRentabilite."No. sequence" + 1
                        else
                            NumEcrRentabilite := 1;

                        EcritureRentabilite.INIT();
                        EcritureRentabilite."No. sequence" := NumEcrRentabilite;
                        EcritureRentabilite."Type ecriture" := EcritureRentabilite."Type ecriture"::CA;
                        EcritureRentabilite."Type document" := EcritureRentabilite."Type document"::Facture;
                        EcritureRentabilite."No. document" := SalesInvLine."Document No.";
                        EcritureRentabilite."No. ligne document" := SalesInvLine."Line No.";
                        EcritureRentabilite."No. commande vente" := SalesLine."Document No.";
                        EcritureRentabilite."No. ligne commande vente" := SalesLine."Line No.";
                        EcritureRentabilite."Type de cout" := EcritureRentabilite."Type de cout"::" ";
                        EcritureRentabilite."Nature vente" := SalesInvLine."Nature vente";
                        EcritureRentabilite."Date comptabilisation" := SalesInvHeader."Posting Date";
                        EcritureRentabilite."No." := SalesInvLine."No.";
                        EcritureRentabilite.Description := SalesInvLine.Description;
                        EcritureRentabilite."Code chantier" := SalesInvLine."Code chantier";
                        EcritureRentabilite."Code groupe" := SalesInvLine."Code groupe";
                        EcritureRentabilite."Code enseigne" := SalesInvLine."Code enseigne";
                        EcritureRentabilite."Code operation" := SalesInvLine."Code operation";
                        EcritureRentabilite.Quantite := SalesInvLine.Quantity;
                        if SalesInvHeader."Currency Code" = '' then begin
                            EcritureRentabilite."Montant unitaire (DS)" := SalesInvLine."Unit Price";
                            EcritureRentabilite."Montant total (DS)" := SalesInvLine.Amount;
                        end else begin
                            EcritureRentabilite."Montant unitaire (DS)" :=
                              CurrExchRate.ExchangeAmtFCYToLCY(SalesInvHeader."Posting Date", SalesInvHeader."Currency Code", SalesInvLine."Unit Price", SalesInvHeader."Currency Factor");
                            EcritureRentabilite."Montant total (DS)" :=
                              CurrExchRate.ExchangeAmtFCYToLCY(SalesInvHeader."Posting Date", SalesInvHeader."Currency Code", SalesInvLine.Amount, SalesInvHeader."Currency Factor");
                        end;
                        EcritureRentabilite.INSERT();
                        NumEcrRentabilite := NumEcrRentabilite + 1;

                        //Si la quantite vendue a ete prise entierement sur achat (affectee), on n'enregistre pas de cout supplementaire
                        //En revanche, si on a pris sur stock (quantite affectee en achat inferieure a la quantite vendue), alors on doit ajouter une ligne de cout correspondant a la quantite prise sur stock
                        if SalesInvLine.Type = SalesInvLine.Type::Item then
                            if Article.GET(SalesInvLine."No.") then begin //FHA BEGIN 5
                                SalesLine.CALCFIELDS("Cout achats affectes");
                                if SalesLine."Cout achats affectes" <> 0 then
                                    if Article."Miscellaneous Item" then
                                        SalesInvLine."Unit Cost (LCY)" := ROUND(SalesLine."Cout achats affectes" / SalesLine.Quantity, 0.01);


                                //Si la quantite achetee est inferieure a la quantite vendue, cela veut dire qu'on a pris sur stock.
                                if not Article."Miscellaneous Item" then begin //FHA BEGIN 6
                                    SalesLine.CALCFIELDS("Quantite affectee");
                                    //On supprime les couts pris sur stock
                                    EcritureRentaCoutPrisSurStock.SetCurrentKey("No. commande vente", "No. ligne commande vente", "Type de cout");
                                    EcritureRentaCoutPrisSurStock.SetRange("No. commande vente", SalesLine."Document No.");
                                    EcritureRentaCoutPrisSurStock.SetRange("No. ligne commande vente", SalesLine."Line No.");
                                    EcritureRentaCoutPrisSurStock.SetRange("Type de cout", EcritureRentaCoutPrisSurStock."Type de cout"::Stock);
                                    EcritureRentaCoutPrisSurStock.DeleteAll();

                                    if SalesLine."Quantite affectee" < (SalesInvLine.Quantity + SalesLine."Quantity Invoiced") then begin   //BEGIN 7
                                        EcritureRentabilite.Init();
                                        EcritureRentabilite."No. sequence" := NumEcrRentabilite + 1;
                                        EcritureRentabilite."Type ecriture" := EcritureRentabilite."Type ecriture"::"Coût";
                                        EcritureRentabilite."Type document" := EcritureRentabilite."Type document"::Facture;
                                        EcritureRentabilite."No. document" := SalesInvLine."Document No.";
                                        EcritureRentabilite."No. ligne document" := SalesInvLine."Line No.";
                                        EcritureRentabilite."No. commande vente" := SalesLine."Document No.";
                                        EcritureRentabilite."No. ligne commande vente" := SalesLine."Line No.";
                                        EcritureRentabilite."Type de cout" := EcritureRentabilite."Type de cout"::Stock;
                                        EcritureRentabilite."Nature vente" := SalesInvLine."Nature vente";
                                        EcritureRentabilite."Date comptabilisation" := SalesInvHeader."Posting Date";
                                        EcritureRentabilite."No." := SalesInvLine."No.";
                                        EcritureRentabilite.Description := SalesInvLine.Description;
                                        EcritureRentabilite."Code chantier" := SalesInvLine."Code chantier";
                                        EcritureRentabilite."Code groupe" := SalesInvLine."Code groupe";
                                        EcritureRentabilite."Code enseigne" := SalesInvLine."Code enseigne";
                                        EcritureRentabilite."Code operation" := SalesInvLine."Code operation";
                                        EcritureRentabilite."Montant unitaire (DS)" := Article."Unit Cost";
                                        EcritureRentabilite.Quantite := (SalesInvLine.Quantity + SalesLine."Quantity Invoiced" - SalesLine."Quantite affectee");
                                        EcritureRentabilite."Montant total (DS)" := EcritureRentabilite.Quantite * Article."Unit Cost";
                                        EcritureRentabilite.INSERT();
                                        NumEcrRentabilite := NumEcrRentabilite + 1;
                                    end;  //FHA BEGIN 7
                                end;  //FHA BEGIN 6
                            end; //FHA BEGIN 5
                    end; //FHA BEGIN 4
                end; //FHA BEGIN 3
                     //<<KAN.FHA

        if SalesInvHeader."Currency Code" = '' then
            SalesInvLine."Montant ligne HT (DS)" := SalesInvLine.Amount
        else
            SalesInvLine."Montant ligne HT (DS)" :=
              CurrExchRate.ExchangeAmtFCYToLCY(SalesInvHeader."Posting Date", SalesInvHeader."Currency Code", SalesInvLine.Amount, SalesInvHeader."Currency Factor");


        if (SalesInvLine.Type = SalesInvLine.Type::Item) and (SalesLine.Quantity <> 0) then begin
            if Article.GET(SalesInvLine."No.") then
                if Article.Codifab then
                    if not Pays.GET(SalesInvHeader."Bill-to Country/Region Code") then
                        Pays.INIT();
            if Pays."Pays Codifab" and Article.Codifab and not (SalesInvHeader.ASS) and (STRPOS(SalesInvHeader."No.", 'SAV') = 0) then
                if ParamCodifab.GET(Article."Code matiere", Article."Eco Tax Furniture Code") then begin
                    SalesInvLine."Eco Tax Furniture Code" := Article."Eco Tax Furniture Code";
                    SalesInvLine."Code matiere article" := Article."Code matiere";
                    SalesInvLine."Montant taxe Codifab" := ROUND(SalesSetup."% taxe Codifab" / 100 * SalesInvLine."Montant ligne HT (DS)", 0.01);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, OnBeforeSalesCrMemoLineInsert, '', false, false)]
    local procedure CU80_OnBeforeSalesCrMemoLineInsert(var SalesCrMemoLine: Record "Sales Cr.Memo Line"; SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    var
        CurrExchRate: Record "Currency Exchange Rate";
        Article: Record Item;
        Pays: Record "Country/Region";
        ParamCodifab: Record "Parametrage articles Codifab";
        ParamVente: Record "Sales & Receivables Setup";
    begin
        ParamVente.GET();
        //Gestion affaire
        SalesCrMemoLine."Cout ligne HT (DS)" := SalesCrMemoLine.Quantity * SalesCrMemoLine."Unit Cost (LCY)";
        if SalesCrMemoHeader."Currency Code" = '' then
            SalesCrMemoLine."Montant ligne HT (DS)" := SalesCrMemoLine.Amount
        else
            SalesCrMemoLine."Montant ligne HT (DS)" :=
              CurrExchRate.ExchangeAmtFCYToLCY(SalesCrMemoHeader."Posting Date", SalesCrMemoHeader."Currency Code", SalesCrMemoLine.Amount, SalesCrMemoHeader."Currency Factor");
        SalesCrMemoLine."Cout ligne au PMP recalc" := SalesCrMemoLine."Cout ligne HT (DS)";
        if (SalesCrMemoLine.Type = SalesCrMemoLine.Type::Item) and (SalesCrMemoLine.Quantity <> 0) then begin
            if Article.GET(SalesCrMemoLine."No.") then
                if Article.Codifab then
                    if not Pays.GET(SalesCrMemoHeader."Bill-to Country/Region Code") then
                        Pays.INIT();
            if Pays."Pays Codifab" and Article.Codifab and not (SalesCrMemoHeader.ASS) and (STRPOS(SalesCrMemoHeader."No.", 'SAV') = 0) then
                if ParamCodifab.GET(Article."Code matiere", Article."Eco Tax Furniture Code") then begin
                    SalesCrMemoLine."Eco Tax Furniture Code" := Article."Eco Tax Furniture Code";
                    SalesCrMemoLine."Code matiere article" := Article."Code matiere";
                    SalesCrMemoLine."Montant taxe Codifab" := ROUND(ParamVente."% taxe Codifab" / 100 * SalesCrMemoLine."Montant ligne HT (DS)", 0.01);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, OnAfterSalesCrMemoLineInsert, '', false, false)]
    local procedure CU80_OnAfterSalesCrMemoLineInsert(var SalesCrMemoLine: Record "Sales Cr.Memo Line"; SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    var
        Chantier: record Chantier;
        Magasin: Record Location;
        EcritureRentabilite: record "Ecriture rentabilite";
        CurrExchRate: Record "Currency Exchange Rate";
        NumEcrRentabilite: Integer;
    begin
        SalesCrMemoLine."Annee commande" := SalesCrMemoHeader."Annee commande";
        SalesCrMemoLine.Modify();
        //Gestion de la rentabilite
        if (SalesCrMemoLine.Quantity <> 0) and (not SalesCrMemoLine."Eco Tax Furniture Line") then
            if Chantier.GET(SalesCrMemoLine."Code chantier") then
                if Chantier."Activer rentabilite" then begin
                    if not Magasin.GET(SalesCrMemoLine."Location Code") then
                        Magasin.INIT();
                    if not Magasin."Magasin client" then begin
                        if EcritureRentabilite.FindLast() then
                            NumEcrRentabilite := EcritureRentabilite."No. sequence" + 1
                        else
                            NumEcrRentabilite := 1;
                        //Chiffre d'affaires
                        EcritureRentabilite.INIT();
                        EcritureRentabilite."No. sequence" := NumEcrRentabilite;
                        EcritureRentabilite."Type document" := EcritureRentabilite."Type document"::Avoir;
                        EcritureRentabilite."No. document" := SalesCrMemoLine."Document No.";
                        EcritureRentabilite."No. ligne document" := SalesCrMemoLine."Line No.";
                        EcritureRentabilite."Type ecriture" := EcritureRentabilite."Type ecriture"::CA;
                        EcritureRentabilite."Type de cout" := EcritureRentabilite."Type de cout"::" ";
                        EcritureRentabilite."Nature vente" := SalesCrMemoLine."Nature vente";
                        EcritureRentabilite."Date comptabilisation" := SalesCrMemoHeader."Posting Date";
                        EcritureRentabilite."Code groupe" := SalesCrMemoLine."Code groupe";
                        EcritureRentabilite."Code enseigne" := SalesCrMemoLine."Code enseigne";
                        EcritureRentabilite."Code operation" := SalesCrMemoLine."Code operation";
                        EcritureRentabilite."Code chantier" := SalesCrMemoLine."Code chantier";
                        EcritureRentabilite.Quantite := -SalesCrMemoLine."Quantity (Base)";
                        if SalesCrMemoHeader."Currency Code" = '' then begin
                            EcritureRentabilite."Montant unitaire (DS)" := SalesCrMemoLine."Unit Price";
                            EcritureRentabilite."Montant total (DS)" := -SalesCrMemoLine.Amount;
                        end else begin
                            EcritureRentabilite."Montant unitaire (DS)" :=
                              CurrExchRate.ExchangeAmtFCYToLCY(SalesCrMemoHeader."Posting Date", SalesCrMemoHeader."Currency Code", SalesCrMemoLine."Unit Price", SalesCrMemoHeader."Currency Factor");
                            EcritureRentabilite."Montant total (DS)" :=
                              CurrExchRate.ExchangeAmtFCYToLCY(SalesCrMemoHeader."Posting Date", SalesCrMemoHeader."Currency Code", SalesCrMemoLine.Amount, SalesCrMemoHeader."Currency Factor");
                        end;
                        EcritureRentabilite.INSERT();
                        NumEcrRentabilite := NumEcrRentabilite + 1;

                        //Charges
                        EcritureRentabilite.INIT();
                        EcritureRentabilite."No. sequence" := NumEcrRentabilite + 1;

                        EcritureRentabilite."Type document" := EcritureRentabilite."Type document"::Avoir;
                        EcritureRentabilite."No. document" := SalesCrMemoLine."Document No.";
                        EcritureRentabilite."No. ligne document" := SalesCrMemoLine."Line No.";
                        EcritureRentabilite."Type ecriture" := EcritureRentabilite."Type ecriture"::"Coût";
                        EcritureRentabilite."Type de cout" := EcritureRentabilite."Type de cout"::Stock;
                        EcritureRentabilite."Nature vente" := SalesCrMemoLine."Nature vente";
                        EcritureRentabilite."Date comptabilisation" := SalesCrMemoHeader."Posting Date";
                        EcritureRentabilite."No." := SalesCrMemoLine."No.";
                        EcritureRentabilite.Description := SalesCrMemoLine.Description;
                        EcritureRentabilite."Code chantier" := SalesCrMemoLine."Code chantier";
                        EcritureRentabilite."Code groupe" := SalesCrMemoLine."Code groupe";
                        EcritureRentabilite."Code enseigne" := SalesCrMemoLine."Code enseigne";
                        EcritureRentabilite."Code operation" := SalesCrMemoLine."Code operation";
                        EcritureRentabilite."Montant unitaire (DS)" := SalesCrMemoLine."Unit Cost (LCY)";
                        EcritureRentabilite.Quantite := -SalesCrMemoLine.Quantity;
                        EcritureRentabilite."Montant total (DS)" := ROUND(EcritureRentabilite.Quantite * SalesCrMemoLine."Unit Cost (LCY)", 0.01);
                        EcritureRentabilite.INSERT();
                        NumEcrRentabilite := NumEcrRentabilite + 1;
                    end;
                end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, OnAfterInsertShipmentHeader, '', false, false)]
    local procedure CU80_OnAfterInsertShipmentHeader(var SalesShipmentHeader: Record "Sales Shipment Header")
    begin
        SalesShipmentHeader."Annee commande" := Date2DMY(SalesShipmentHeader."Posting Date", 3);
    end;

    [EventSubscriber(ObjectType::Codeunit, 81, OnBeforeConfirmSalesPost, '', false, false)]
    local procedure CU81_OnBeforeConfirmSalesPost(var SalesHeader: Record "Sales Header"; var HideDialog: Boolean)
    begin
        HideDialog := true;
        NewConfirmPostSales(SalesHeader)
    end;

    [EventSubscriber(ObjectType::Codeunit, 82, OnBeforeConfirmPost, '', false, false)]
    local procedure CU82_OnBeforeConfirmPost(var SalesHeader: Record "Sales Header"; var HideDialog: Boolean)
    begin
        HideDialog := true;
        NewConfirmPostSales(SalesHeader)
    end;

    local procedure NewConfirmPostSales(var SalesHeader: Record "Sales Header"): Boolean
    var
        ConfirmManagement: Codeunit "Confirm Management";
        Selection: Integer;
        ShipInvoiceQst: Label '&Expédier,&Facturer';
        PostConfirmQst: Label 'Voulez-vous valider le document %1?', Comment = '%1 = Type document';
        ReceiveInvoiceQst: Label '&Réceptionner,&Facturer';
    begin
        case SalesHeader."Document Type" of
            SalesHeader."Document Type"::Order:
                begin
                    Selection := StrMenu(ShipInvoiceQst, 1);
                    SalesHeader.Ship := Selection in [1, 3];
                    SalesHeader.Invoice := Selection in [2, 3];
                    if Selection = 0 then
                        exit(false);
                end;
            SalesHeader."Document Type"::"Return Order":
                begin
                    Selection := StrMenu(ReceiveInvoiceQst, 1);
                    if Selection = 0 then
                        exit(false);
                    SalesHeader.Receive := Selection in [1, 3];
                    SalesHeader.Invoice := Selection in [2, 3];
                end
            else
                if not ConfirmManagement.GetResponseOrDefault(
                     StrSubstNo(PostConfirmQst, LowerCase(Format(SalesHeader."Document Type"))), true)
                then
                    exit(false);
        end;
        SalesHeader."Print Posted Documents" := false;
        exit(true);
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, OnAfterInsertReceiptHeader, '', false, false)]
    local procedure CU90_OnAfterInsertReceiptHeader(var PurchRcptHeader: Record "Purch. Rcpt. Header")
    begin
        PurchRcptHeader."Annee commande" := Date2DMY(PurchRcptHeader."Posting Date", 3);
        PurchRcptHeader.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, 91, OnBeforeConfirmPost, '', false, false)]
    local procedure CU91_OnBeforeConfirmPost(var PurchaseHeader: Record "Purchase Header"; var HideDialog: Boolean)
    begin
        HideDialog := true;
        NewConfirmPostPurchase(PurchaseHeader);

    end;

    local procedure NewConfirmPostPurchase(var PurchHeader: Record "Purchase Header"): Boolean
    var
        ConfirmManagement: Codeunit "Confirm Management";
        Selection: Integer;
        ShipInvoiceQst: Label '&Expédier,&Facturer';
        PostConfirmQst: Label 'Voulez-vous valider le document %1?', Comment = '%1 = Type document';
        ReceiveInvoiceQst: Label '&Recevoir,&Facturer';
    begin
        case PurchHeader."Document Type" of
            PurchHeader."Document Type"::Order:
                begin
                    Selection := StrMenu(ReceiveInvoiceQst, 1);
                    PurchHeader.Receive := Selection = 1;
                    PurchHeader.Invoice := Selection = 2;
                    if Selection = 0 then
                        exit(false);
                end;
            PurchHeader."Document Type"::"Return Order":
                begin
                    Selection := StrMenu(ShipInvoiceQst, 1);
                    if Selection = 0 then
                        exit(false);
                    PurchHeader.Ship := Selection = 1;
                    PurchHeader.Invoice := Selection = 2;
                end
            else
                if not ConfirmManagement.GetResponseOrDefault(
                     StrSubstNo(PostConfirmQst, LowerCase(Format(PurchHeader."Document Type"))), true)
                then
                    exit(false);
        end;
        PurchHeader."Print Posted Documents" := false;
        exit(true);
    end;

    [EventSubscriber(ObjectType::Codeunit, 94, OnAfterCreatePurchOrder, '', false, false)] //Commande cadre achat==>Creer commande achat
    local procedure CU94_OnAfterCreatePurchOrder(var PurchaseHeader: Record "Purchase Header"; var SkipMessage: Boolean)
    var
        OuvrirCommandeAchatQst: Label 'Voulez-vous afficher la commande achat créée ?';
    begin
        PurchaseHeader."Achat pour stock" := true;
        PurchaseHeader.Modify();
        SkipMessage := true;
        if Confirm(OuvrirCommandeAchatQst) then
            Page.Run(Page::"Purchase Order", PurchaseHeader);


    end;

    [EventSubscriber(ObjectType::Codeunit, 97, OnBeforePurchOrderHeaderModify, '', false, false)]
    local procedure CU97_OnBeforePurchOrderHeaderModify(var PurchOrderHeader: Record "Purchase Header")
    begin
        PurchOrderHeader."Order Date" := Today;
    end;

    [EventSubscriber(ObjectType::Codeunit, 97, OnBeforeRun, '', false, false)] ////Commande cadre achat==>Creer commande achat
    local procedure CU97_OnBeforeRun(PurchaseHeader: Record "Purchase Header")
    begin
        //KAN.FHA 27/05/2026 DEBUT
        if PurchaseHeader."Suivi container" then
            //KAN.FHA 27/05/2026 FIN
            PurchaseHeader.TestField("Date intention chargement");
    end;

    [EventSubscriber(ObjectType::Codeunit, 97, OnAfterRun, '', false, false)] ////Commande cadre achat==>Creer commande achat
    local procedure CU97_OnAfterRun(var PurchaseHeader: Record "Purchase Header")
    begin
        PurchaseHeader."Date intention chargement" := 0D;
        //PurchaseHeader."Order Date" := 0D;
    end;

    [EventSubscriber(ObjectType::Codeunit, 150, OnAfterLogin, '', false, false)]
    local procedure SystemInitialization_OnAfterLogin()
    var
        ParamVente: Record "Sales & Receivables Setup";
        EnteteVente: Record "Sales Header";
    begin
        ParamVente.Get();
        if ParamVente."Date dern. verif situ." < Today then begin
            EnteteVente.SetCurrentKey("Situation a creer", "Fact. situation creee", "Creer facture situation le");
            EnteteVente.SetRange("Situation a creer", true);
            EnteteVente.SetRange("Fact. situation creee", false);
            EnteteVente.SetFilter("Creer facture situation le", '<=%1&<>%2', Today, 0D);
            if EnteteVente.FindSet(true) then
                repeat
                    EnteteVente."Demander situ. a la compta" := true;
                    EnteteVente.Modify();
                until EnteteVente.Next() = 0;
            ParamVente."Date dern. verif situ." := today;
            ParamVente.modify();
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, 825, OnBeforeInitGenJnlLine, '', false, false)]
    //Car l'event OnBeforeInitNewLineFromInvoicePostBuffer du CU80 est marque par Microsoft comme etant supprime dans une prochaine version
    local procedure CU825_OnBeforeInitGenJnlLine(var GenJnlLine: Record "Gen. Journal Line"; SalesHeader: Record "Sales Header")
    begin
        //KAN.FHA 21/10/2022 DEBUT
        GenJnlLine."Code enseigne" := SalesHeader."Code enseigne";
        //KAN.FHA 21/10/2022 FIN
        GenJnlLine.Modify();

    end;

    [EventSubscriber(ObjectType::Codeunit, 80, OnPostUpdateOrderLineOnBeforeInitOutstanding, '', false, false)]
    local procedure CU80_OnPostUpdateOrderLineOnBeforeInitOutstanding(var TempSalesLine: Record "Sales Line" temporary)
    begin
        //DIA.ABRA.COL NBE 26/11/2014 DEBUT
        if TempSalesLine."Qty. to Ship" <> 0 then begin
            TempSalesLine."Packing in Progress" := false;
            //DIA.ABRA.COL NBE 26/11/2014 FIN
            TempSalesLine.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, OnAfterFinalizePosting, '', false, false)]
    local procedure CU80_OnAfterFinalizePosting(var SalesHeader: Record "Sales Header"; var SalesShipmentHeader: Record "Sales Shipment Header")
    var
        lItemJnlLine: Record "Item Journal Line";
        //EnteteVente: Record "Sales Header";
        LigneVente: Record "Sales Line";
        InvSetup: Record "Inventory Setup";
        ItemJnlTemplate: Record "Item Journal Template";
        Batch: Record "Item Journal Batch";
        ItemJnlPostBatch: Codeunit "Item Jnl.-Post Batch";
        LineNo: Integer;
        BatchName: Code[20];
    begin
        if SalesHeader."Document Type" <> SalesHeader."Document Type"::Order then
            exit;

        //KAN.FHA 19/01/2026 DEBUT
        SalesHeader."Poids brut total" := 0;
        SalesHeader."Posting Date" := 0D;
        SalesHeader."Nombre de colis" := 0;
        SalesHeader."Nombre de palettes" := 0;
        //KAN.FHA 19/01/2026 FIN

        InvSetup.Get();
        InvSetup.TestField("Mod. feuil. art. remise stk BL");

        BatchName := SalesHeader."No.";

        if StrLen(BatchName) > 10 then
            BatchName := CopyStr(BatchName, StrLen(BatchName) - 9, 10);  //9 derniers caracteres

        ItemJnlTemplate.Get(InvSetup."Mod. feuil. art. remise stk BL");

        if Batch.Get(InvSetup."Mod. feuil. art. remise stk BL", BatchName) then
            Batch.Delete(true);

        Batch.Init();
        Batch."Journal Template Name" := InvSetup."Mod. feuil. art. remise stk BL";
        Batch.Name := BatchName;
        Batch.Insert();

        LineNo := 10000;

        LigneVente.Setrange("Document Type", SalesHeader."Document Type");
        LigneVente.SetRange("Document No.", SalesHeader."No.");
        if LigneVente.FindSet(true) then
            repeat
                if (LigneVente."Qty. to Ship" <> 0) and LigneVente."Article nomenclature" then begin
                    lItemJnlLine.Init();
                    lItemJnlLine."Journal Template Name" := InvSetup."Mod. feuil. art. remise stk BL";
                    lItemJnlLine."Journal Batch Name" := BatchName;
                    lItemJnlLine."Line No." := LineNo;
                    lItemJnlLine.Insert();

                    lItemJnlLine."Posting Date" := SalesHeader."Posting Date";
                    lItemJnlLine."Document Date" := WorkDate();
                    lItemJnlLine."Document No." := SalesShipmentHeader."No.";
                    lItemJnlLine."Entry Type" := lItemJnlLine."Entry Type"::"Positive Adjmt.";
                    lItemJnlLine.Validate("Item No.", LigneVente."No.");
                    lItemJnlLine.Validate("Variant Code", LigneVente."Variant Code");
                    //lItemJnlLine."Dimension Set ID" := LigneVente."Dimension Set ID";
                    lItemJnlLine."Location Code" := SalesHeader."Location Code";
                    lItemJnlLine.Validate("Unit of Measure Code", LigneVente."Unit of Measure Code");
                    lItemJnlLine.Validate(Quantity, LigneVente."Qty. to Ship (Base)");
                    lItemJnlLine.Validate("Unit Cost", LigneVente."Unit Cost");
                    lItemJnlLine."Source Code" := ItemJnlTemplate."Source Code";
                    lItemJnlLine.Modify();
                    LineNo += 10000;
                    ItemJnlPostBatch.Run(lItemJnlLine);
                end;
            until LigneVente.Next() = 0;

        if Batch.Get(InvSetup."Mod. feuil. art. remise stk BL", BatchName) then
            Batch.Delete(true);
        //KAN.FHA 15/12/2022 DEBUT
        /*FHA
        IF Ship THEN BEGIN
            cuPDF.GenererPDFBL(SalesShptHeader,FALSE);
            COMMIT;
        END;
        IF Invoice THEN BEGIN
            cuPDF.GenererPDFFacture(SalesInvHeader,FALSE);
            COMMIT;
        END;
        //KAN.FHA 15/12/2022 FIN
            */
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, OnAfterPostItemJnlLine, '', false, false)]
    local procedure CU80_OnAfterPostItemJnlLine(var ItemJournalLine: Record "Item Journal Line"; SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")
    begin
        ItemJournalLine."Document Type BOM" := SalesLine."Document Type";
        ItemJournalLine."Document No. BOM" := SalesLine."Document No.";
        if SalesLine."Ligne eclatee" then
            ItemJournalLine."Document Line No. BOM" := SalesLine."Line No."
        else
            ItemJournalLine."Document Line No. BOM" := SalesLine."Linked to line";

        ItemJournalLine."Exclure DEB" := (SalesHeader.ASS); //Tout SAV Vente ne doit pas etre pris en compte dans la DEB
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, OnAfterDeleteAfterPosting, '', false, false)]
    local procedure CU80_OnAfterDeleteAfterPosting(SalesHeader: Record "Sales Header")
    var
        PhasesDocument: Record "Phases document";
    begin
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
            PhasesDocument.SetRange("Type document", PhasesDocument."Type document"::Order);
            PhasesDocument.SetRange("No. document", SalesHeader."No.");
            PhasesDocument.DeleteAll();

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 825, OnPostLedgerEntryOnBeforeGenJnlPostLine, '', false, false)]
    local procedure CU825_OnPostLedgerEntryOnBeforeGenJnlPostLine(var GenJnlLine: Record "Gen. Journal Line"; var SalesHeader: Record "Sales Header")
    //L'event OnBeforePostCustomerEntry du CU80 est marque obosole par Microsoft
    begin
        //KAN.FHA 12/06/2020 DEBUT Gestion des acomptes
        GenJnlLine."Facture acompte" := SalesHeader."Facture acompte";
        GenJnlLine."Facture situation" := SalesHeader."Facture situation";
        GenJnlLine."Code groupe" := SalesHeader."Code groupe";
        GenJnlLine."Code enseigne" := SalesHeader."Code enseigne";
        GenJnlLine."Code operation" := SalesHeader."Code operation";
        GenJnlLine."Code chantier" := SalesHeader."Code chantier";
        //KAN.FHA 12/06/2020 FIN
        GenJnlLine.Modify()
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, OnCheckCustBlockageOnAfterTempLinesSetFilters, '', false, false)]
    local procedure CU80_OnCheckCustBlockageOnAfterTempLinesSetFilters(SalesHeader: Record "Sales Header"; var TempSalesLine: Record "Sales Line" temporary)
    var
        Client: Record Customer;
        ShipmentBlockedErr: Label 'Vous ne pouvez pas livrer lorsque le client est bloqué en expédition.';
    begin
        if not TempSalesLine.ISEMPTY then
            if Client.GET(TempSalesLine."Sell-to Customer No.") then
                if Client."Shipment Blocked" then
                    ERROR(ShipmentBlockedErr);
    end;


    [EventSubscriber(ObjectType::Codeunit, 80, OnAfterPostSalesDoc, '', false, false)]
    local procedure CU80_OnAfterPostSalesDoc(var SalesHeader: Record "Sales Header"; SalesShptHdrNo: Code[20])
    var
    //EnteteExpedVente: Record "Sales Shipment Header";
    //EnteteColisage: Record "Entete colisage";
    begin
        /*
        On renonce pour le moment à générer un colisage quand on génère un BL
        if SalesHeader."Document Type" <> SalesHeader."Document Type"::Order then
            exit;
        if not SalesHeader.ship then
            exit;
        
        //SalesHeader.CalcFields("Colisage en cours");
        if SalesHeader.ColisageEnAttente(SalesHeader."Phase a expedier") then begin
            EnteteColisage.SetCurrentKey("No. commande", "No. expedition enregistree");
            EnteteColisage.SetRange("No. commande",SalesHeader."No.");
            EnteteColisage.SetFilter("No. expedition enregistree",'');
            if EnteteColisage.FindFirst() then begin
                EnteteColisage."No. expedition enregistree" := SalesShptHdrNo;
                EnteteColisage.Modify();
            end;
        end else begin
            EnteteExpedVente.Get(SalesShptHdrNo);
            EnteteExpedVente.CreerColisage(false);
            EnteteColisage.SetCurrentKey("No. expedition enregistree");
            EnteteColisage.SetRange("No. expedition enregistree", SalesShptHdrNo);
            if EnteteColisage.FindFirst() then
                EnteteColisage.MAJPoidsSurContenuColisage();
        end;
        */
    end;


    [EventSubscriber(ObjectType::Codeunit, 83, OnBeforeRun, '', false, false)]
    local procedure CU83_OnBeforeRun(SalesHeader: Record "Sales Header")
    var
        DevisStockErr: Label 'Il n''est pas possible de transformer en commande un devis pour stock.';
    begin
        //KAN.FHA 09/06/2020 DEBUT
        if SalesHeader."Devis Stock" then
            ERROR(DevisStockErr);
        //KAN.FHA 09/06/2020 FIN
    end;

    [EventSubscriber(ObjectType::Codeunit, 86, OnBeforeOnRun, '', false, false)]
    local procedure CU86OnBeforeOnRun(SalesHeader: Record "Sales Header")
    begin
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Quote then
            SalesHeader.TestField("Annee commande");
    end;

    [EventSubscriber(ObjectType::Codeunit, 86, OnBeforeModifySalesOrderHeader, '', false, false)]
    local procedure CU86_OnBeforeModifySalesOrderHeader(var SalesOrderHeader: Record "Sales Header"; SalesQuoteHeader: Record "Sales Header")
    var
        EnteteAchat: Record "Purchase Header";
        EnteteAchatMAJ: Record "Purchase Header";
    begin
        SalesQuoteHeader.CalcFields("Commentaires dossier BE", "Commentaires prepa");
        SalesOrderHeader."Commentaires dossier BE" := SalesQuoteHeader."Commentaires dossier BE";
        SalesOrderHeader."Commentaires prepa" := SalesQuoteHeader."Commentaires prepa";
        //KAN.FHA 20/05/2026 DEBUT
        EnteteAchat.SetCurrentKey("No. doc. vente");
        EnteteAchat.SetRange("No. doc. vente", SalesQuoteHeader."No.");
        if EnteteAchat.FindSet(false) then
            repeat
                EnteteAchatMAJ.get(EnteteAchat."Document Type", EnteteAchat."No.");
                EnteteAchatMAJ."Type doc. vente" := EnteteAchatMAJ."Type doc. vente"::Order;
                EnteteAchatMAJ."No. doc. vente" := SalesOrderHeader."No.";
                EnteteAchatMAJ.Modify();
            until EnteteAchat.Next() = 0;
        //KAN.FHA 20/05/2026 FIN
    end;

    [EventSubscriber(ObjectType::Codeunit, 86, OnAfterInsertSalesOrderHeader, '', false, false)]
    local procedure CU86_OnAfterInsertSalesOrderHeader(SalesOrderHeader: Record "Sales Header"; SalesQuoteHeader: Record "Sales Header")
    var
        FactureAcompte: Record "Sales Header";
        Chantier: Record Chantier;
        DossierBE: Record "Dossier BE";

    begin
        SalesOrderHeader."Annee commande" := SalesQuoteHeader."Annee commande";
        SalesOrderHeader."Posting Date" := WORKDATE();
        SalesOrderHeader."Document Date" := WORKDATE();
        //KAN.FHA 06/01/2021 On ne veut pas perdre la date d'expedition
        //Remplace par :
        SalesOrderHeader."Shipment Date" := SalesQuoteHeader."Shipment date";
        SalesOrderHeader.modify();
        //KAN.FHA 06/01/2021 FIN
        //KAN.FHA 11/06/2020 DEBUT
        //Si une facture d'acompte (non enregistrée) fait mention du devis, il faut maintenant qu'elle fasse mention de la commande.
        if (SalesQuoteHeader."No. facture acompte" <> '') and (SalesQuoteHeader."No. facture acompte enregistre" = '') then  //La facture d'acompte n'a pas encore été validée
            if FactureAcompte.GET(FactureAcompte."Document Type"::Invoice, SalesQuoteHeader."No. facture acompte") then begin
                FactureAcompte."Acompte pour type doc." := FactureAcompte."Acompte pour type doc."::Commande;
                FactureAcompte."Acompte pour No. document" := SalesOrderHeader."No.";
                FactureAcompte.MODIFY();
            end;
        //KAN.FHA 11/06/2020 FIN
        //KAN.FHA 03/04/2025 DEBUT
        if (SalesQuoteHeader."No. facture situat. enregistre" <> '') and (SalesQuoteHeader."No. facture situat. enregistre" = '') then  //La facture de situation n'a pas encore été validée
            if FactureAcompte.GET(FactureAcompte."Document Type"::Invoice, SalesQuoteHeader."No. facture situation") then begin
                FactureAcompte."Acompte pour type doc." := FactureAcompte."Acompte pour type doc."::Commande;
                FactureAcompte."Acompte pour No. document" := SalesOrderHeader."No.";
                FactureAcompte.MODIFY();
            end;
        //KAN.FHA 03/04/2025 FIN
        //KAN.FHA 12/06/2020 DEBUT
        if Chantier.GET(SalesQuoteHeader."Code chantier") then begin
            Chantier."Statut chantier" := Chantier."Statut chantier"::"En cours";
            Chantier.MODIFY();
        end;
        //KAN.FHA 12/06/2020 FIN
        //KAN.FHA 23/06/2025 DEBUT
        If SalesQuoteHeader."No. dossier BE" <> '' then begin
            DossierBE.Get(SalesQuoteHeader."No. dossier BE");
            DossierBE."Type document" := DossierBE."Type document"::Commande;
            DossierBE."No. document" := SalesOrderHeader."No.";
            DossierBE.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 86, OnBeforeInsertSalesOrderLine, '', false, false)]
    local procedure CU86_OnBeforeInsertSalesOrderLine(var SalesOrderLine: record "Sales line"; SalesOrderHeader: Record "Sales Header"; SalesQuoteHeader: Record "Sales Header"; SalesQuoteLine: Record "Sales Line")

    begin
        SalesOrderLine."Do not print" := false;
        //KAN.FHA 18/11/2020 DEBUT
        if SalesQuoteLine."Article divers" then begin
            SalesQuoteLine.CALCFIELDS("Cout achats affectes");
            if SalesOrderLine.Quantity <> 0 then
                SalesOrderLine.VALIDATE(SalesOrderLine."Unit Cost (LCY)", SalesQuoteLine."Cout achats affectes");
        end;
        //KAN.FHA 18/11/2020 FIN
        //KAN.FHA 30/01/23 DEBUT
        SalesOrderLine."Annee commande" := SalesQuoteHeader."Annee commande";
        //KAN.FHA 30/01/23 FIN
    end;

    [EventSubscriber(ObjectType::Codeunit, 86, OnAfterInsertSalesOrderLine, '', false, false)]
    local procedure CU86_OnAfterInsertSalesOrderLine(var SalesOrderLine: record "Sales line"; SalesOrderHeader: Record "Sales Header"; SalesQuoteHeader: Record "Sales Header"; SalesQuoteLine: Record "Sales Line")
    var
        AffectationsAchat: record "Affectations achat vente";
        NouvelleAffectationAchat: record "Affectations achat vente";

    begin
        //KAN.FHA 06/04/2020 DEBUT
        //Si des achats étaient affectés au devis qu'on transforme en commande, il faut qu'ils soient affectés à la commande créée.
        AffectationsAchat.RESET();
        AffectationsAchat.SETCURRENTKEY("Type document vente", "No. document vente", "No. ligne document vente");
        AffectationsAchat.SETRANGE("Type document vente", AffectationsAchat."Type document vente"::Devis);
        AffectationsAchat.SETRANGE("No. document vente", SalesQuoteHeader."No.");
        //KAN.FHA 22/05/2026 DEBUT
        AffectationsAchat.SetRange("No. ligne document vente", SalesQuoteLine."Line No.");
        //KAN.FHA 22/05/2026 FIN
        if AffectationsAchat.FindSet(false) then
            repeat
                NouvelleAffectationAchat := AffectationsAchat;
                NouvelleAffectationAchat."Type document vente" := NouvelleAffectationAchat."Type document vente"::Commande;
                NouvelleAffectationAchat."No. document vente" := SalesOrderHeader."No.";
                NouvelleAffectationAchat."No. ligne document vente" := SalesOrderLine."Line No.";
                NouvelleAffectationAchat.INSERT();
            until AffectationsAchat.Next() = 0;
        //KAN.FHA 06/04/2020 FIN

        //KAN.FHA 21/08/2025 DEBUT
        SalesOrderLine.TypeDocDuplique := SalesOrderLine.TypeDocDuplique::Order;
        SalesOrderLine.NumDocDuplique := SalesOrderLine."Document No.";
        SalesOrderLine.Modify();
        //KAN.FHA 21/08/2025 FIN
    end;

    [EventSubscriber(ObjectType::Codeunit, 86, OnAfterInsertAllSalesOrderLines, '', false, false)]

    local procedure CU86_OnAfterInsertAllSalesOrderLines(var SalesOrderHeader: Record "Sales Header"; SalesQuoteHeader: Record "Sales Header")
    var
        PhasesDevis: Record "Phases document";
        PhasesCommande: Record "Phases document";
    begin
        SalesOrderHeader."% acompte demande" := SalesOrderHeader.DefinirPctAcompte();
        SalesOrderHeader."Acompte a creer" := (SalesOrderHeader."% acompte demande" <> 0);
        SalesOrderHeader.MODIFY();

        //KAN.FHA 20/08/2025 DEBUT
        //Si des phases etaient associees aux lignes, il faut que les phases soient reportees sur la commande
        PhasesDevis.Reset();
        PhasesDevis.SetRange("Type document", PhasesDevis."Type document"::Quote);
        PhasesDevis.SetRange("No. document", SalesQuoteHeader."No.");
        if PhasesDevis.FindSet(false) then
            repeat
                PhasesCommande := PhasesDevis;
                PhasesCommande."Type document" := PhasesCommande."Type document"::Order;
                PhasesCommande."No. document" := SalesOrderHeader."No.";
                PhasesCommande.Insert();
            until PhasesDevis.Next() = 0;
    end;

    [EventSubscriber(ObjectType::codeunit, 86, OnBeforeDeleteSalesQuote, '', false, false)]
    local procedure CU86_OnBeforeDeleteSalesQuote(QuoteSalesHeader: Record "Sales Header")
    var
        AffectationsAchat: Record "Affectations achat vente";
        PhasesDocument: Record "Phases document";
    begin
        AffectationsAchat.Reset();
        AffectationsAchat.SetCurrentKey("Type document vente", "No. document vente", "No. ligne document vente");
        AffectationsAchat.SetRange("Type document vente", AffectationsAchat."Type document vente"::Devis);
        AffectationsAchat.SetRange("No. document vente", QuoteSalesHeader."No.");
        AffectationsAchat.DeleteAll(false);

        PhasesDocument.SetRange("Type document", PhasesDocument."Type document"::Quote);
        PhasesDocument.SetRange("No. document", QuoteSalesHeader."No.");
        PhasesDocument.DeleteAll(false);
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, OnBeforePostPurchaseDoc, '', false, false)]
    local procedure CU90_OnBeforePostPurchaseDoc(var PurchaseHeader: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
        TextCheckItemErr: Label 'Sur la ligne %1 de la commande %2, on a un N° article vide, vous devez supprimer la ligne ou mettre une référence article.', Comment = '%1 = N° ligne ; %2 = N° commande';
        RemplacerDateComptaQst: label 'Vous n''avez pas saisi de date de comptabilisation, souhaitez-vous valider en date du jour';
        ArretValidationErr: label 'Opération annulée à la demande de l''utilisateur.';
    begin
        if PurchaseHeader."Posting Date" = 0D then
            if CONFIRM(RemplacerDateComptaQst) then begin
                PurchaseHeader."Posting Date" := WORKDATE();

                if PurchaseHeader."Document Date" = 0D then
                    PurchaseHeader.VALIDATE("Document Date", PurchaseHeader."Posting Date");
                PurchaseHeader.Modify();
            end
            else
                ERROR(ArretValidationErr);
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, OnCheckAndUpdateOnAfterSetPostingFlags, '', false, false)]
    local procedure CU90_OnCheckAndUpdateOnAfterSetPostingFlags(var PurchHeader: Record "Purchase Header")
    var
        Pays: Record "Country/Region";
        Fournisseur: Record Vendor;
        //DiversNonAffecteQst: label 'L''article Divers de la ligne %1 n''est pas affecté à une vente, voulez-vous valider la facture malgré tout ?', Comment = '%1 = N° ligne';
        //txtcDiversNonAffecteMsg: Label 'Une ou plusieurs lignes sont sans affectation. Vous pouvez regarder sur chaque ligne, le champ [Affectation manquante] vous indiquera les lignes concernées.';
        ArticleSansPrixAchatErr: Label 'Il n''est pas possible de réceptionner un article sans coût unitaire direct. Cette alerte a été déclenchée depuis la ligne %1.', Comment = '%1 = N° ligne';
        NumLigne: Integer;
    begin
        //KAN.FHA 18/05/2020 DEBUT Alerter si on a achete un divers sans dire pour quelle vente on l'achte.
        /*KAN.FHA 16/06/2025 DEBUT On ne peut plus ce controle
        if PurchHeader.Invoice then
            if PurchHeader.DiversNonAffecte(NumLigne) then
                if not CONFIRM(DiversNonAffecteQst, false, NumLigne) then begin
                    //KAN.FHA 25/03/2022 DEBUT
                    if purchheader."Document Type" = purchheader."Document Type"::Invoice then
                        MESSAGE(txtcDiversNonAffecteMsg);
                    exit;
                end;
        KAN.FHA 16/06/2025 FIN*/

        //KAN.FHA 18/05/2020 FIN

        //KAN.FHA 19/02/2021 DEBUT
        if PurchHeader.Receive then
            if PurchHeader.LigneSansCout(NumLigne) then
                ERROR(ArticleSansPrixAchatErr, NumLigne);
        //KAN.FHA 19/02/2021 FIN

        //KAN.FHA 26/03/2025 DEBUT
        if PurchHeader.Invoice then begin
            Fournisseur.Get(PurchHeader."Buy-from Vendor No.");
            Pays.Get(PurchHeader."Buy-from Country/Region Code");
            if Pays."SIRET obligatoire" then
                Fournisseur.TestField("Registration Number");
            if Pays."No. TVA intracom. oblig." then
                Fournisseur.TestField("VAT Registration No.");
            //KAN.FHA 26/03/2025 FIN
            //KAN.FHA 16/06/2025 DEBUT
            PurchHeader.TestField("Code chantier");
            //KAN.FHA 16/06/2025 FIN
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, OnBeforePurchRcptHeaderInsert, '', false, false)]
    local procedure CU90_OnBeforePurchRcptHeaderInsert(var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchaseHeader: Record "Purchase Header")
    begin
        //KAN.FHA 14/10/2022 DEBUT
        PurchRcptHeader."No. facture fournisseur" := PurchaseHeader."Vendor Invoice No.";
        //KAN.FHA 14/10/2022 FIN
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, OnBeforePurchInvHeaderInsert, '', false, false)]
    local procedure CU90_OnBeforePurchInvHeaderInsert(var PurchInvHeader: Record "Purch. Inv. Header")
    var
        Pays: Record "Country/Region";

    begin
        //KAN.FHA 16/02/2023 DEBUT
        if not Pays.GET(PurchInvHeader."Pay-to Country/Region Code") then
            Pays.Init();

        if (PurchInvHeader."Pay-to Country/Region Code" <> 'FR') and (PurchInvHeader."Pay-to Country/Region Code" <> '') then
            PurchInvHeader."Concernee DEB" := (Pays."Intrastat Code" <> '');
        //KAN.FHA 16/02/2023 FIN
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, OnBeforePurchCrMemoHeaderInsert, '', false, false)]
    local procedure CU90_OnBeforePurchCrMemoHeaderInsert(var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.")
    var
        Pays: Record "Country/Region";
    begin
        //KAN.FHA 16/02/2023 DEBUT
        if not Pays.GET(PurchCrMemoHdr."Pay-to Country/Region Code") then
            Pays.INIT();

        if (PurchCrMemoHdr."Pay-to Country/Region Code" <> 'FR') and (PurchCrMemoHdr."Pay-to Country/Region Code" <> '') then
            PurchCrMemoHdr."Concerne DEB" := (Pays."Intrastat Code" <> '');
        //KAN.FHA 16/02/2023 FIN

    end;

    [EventSubscriber(ObjectType::Codeunit, 90, OnBeforePurchRcptLineInsert, '', false, false)]
    local procedure CU90_OnBeforePurchRcptLineInsert(var PurchLine: Record "Purchase Line"; var PurchRcptHeader: Record "Purch. Rcpt. Header")
    var
        CompanyInfo: record "Company Information";
        Article: Record Item;
    begin
        //KAN.FHA 17/10/2022 DEBUT
        CompanyInfo.GET();
        if (PurchLine.Type = PurchLine.Type::Item) and (PurchLine."Qty. to Receive" <> 0) then
            if (PurchRcptHeader."Buy-from Country/Region Code" <> CompanyInfo."Country/Region Code") and (purchRcptHeader."Buy-from Country/Region Code" <> '') then begin
                if not PurchLine."Article divers" then
                    PurchLine.TESTFIELD("Net Weight");
                if PurchLine."Article divers" then
                    if Article.GET(PurchLine."No.") then
                        if Article."Poids obligatoire" then begin
                            PurchLine.TESTFIELD("Nomenclature produits"); //Renseign que sur les divers ; la feuille intracomm va chercher la nomenc produit sur l'article pour les non Divers
                            PurchLine.TESTFIELD("Net Weight");
                        end;
            end;
        //KAN.FHA 17/10/2022 FIN
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, OnAfterProcessPurchLines, '', false, false)]
    local procedure CU90_OnAfterProcessPurchLines(var PurchHeader: Record "Purchase Header"; var PurchInvHeader: Record "Purch. Inv. Header")
    begin
        //KAN.FHA 09/01/2023 DEBUT
        if Purchheader.Invoice then
            AffecterFraisAnnexeAuChantier(PurchHeader, PurchInvHeader);
        //KAN.FHA 09/01/2023 FIN    
    end;

    local procedure AffecterFraisAnnexeAuChantier(pEnteteAchat: Record "Purchase Header"; pEnteteFactAchat: record "Purch. Inv. Header")
    var
        AffectationFraisAnnexe: Record "Item Charge Assignment (Purch)";
        EcritureRentabilite: Record "Ecriture rentabilite";
        LigneRecept: Record "Purch. Rcpt. Line";
        TypeFraisAnnexe: Record "Item Charge";
        LigneAchatFraisAnnexe: Record "Purchase Line";
        LienAchatVente: Record "Affectations achat vente";
        LigneCommande: Record "Purchase Line";
        CurrExchRate: Record "Currency Exchange Rate";
        NumEcrRentabilite: Integer;
        MontantAffecteChantier: Decimal;

    begin
        LigneAchatFraisAnnexe.RESET();
        LigneAchatFraisAnnexe.SETRANGE("Document Type", pEnteteAchat."Document Type");
        LigneAchatFraisAnnexe.SETRANGE("Document No.", pEnteteAchat."No.");
        LigneAchatFraisAnnexe.SETRANGE(Type, LigneAchatFraisAnnexe.Type::"Charge (Item)");
        LigneAchatFraisAnnexe.SETFILTER("Qty. to Invoice", '<>0');

        if LigneAchatFraisAnnexe.FINDSET(false) then begin
            EcritureRentabilite.LOCKTABLE();
            NumEcrRentabilite := 0;
            if EcritureRentabilite.FINDLAST() then
                NumEcrRentabilite := EcritureRentabilite."No. sequence";

            repeat
                TypeFraisAnnexe.GET(LigneAchatFraisAnnexe."No.");
                TypeFraisAnnexe.TESTFIELD("Type de coût");
                AffectationFraisAnnexe.SETRANGE("Document Type", pEnteteAchat."Document Type");
                AffectationFraisAnnexe.SETRANGE("Document No.", pEnteteAchat."No.");
                AffectationFraisAnnexe.SETRANGE("Document Line No.", LigneAchatFraisAnnexe."Line No.");
                //KAN.FHA 05/01/2024 DEBUT
                //AffectationFraisAnnexe.SETRANGE("Applies-to Doc. Type",AffectationFraisAnnexe."Applies-to Doc. Type"::Receipt);
                //KAN.FHA 05/01/2024 FIN
                if AffectationFraisAnnexe.FINDSET(false) then
                    repeat
                        case AffectationFraisAnnexe."Applies-to Doc. Type" of
                            AffectationFraisAnnexe."Applies-to Doc. Type"::Receipt:
                                begin
                                    //Toute la quantte n'etait peut-etre pas destinee a un chantier (a du stock).
                                    //Il faut retrouver la commande d'achat et n'affecter au chantier que le prorata
                                    //Exemple :
                                    //  - Les frais d'approche sont de 1000Eur pour 20 pieces receptionnees.
                                    //  - Sur ces 20 pieces, 4 avaient ete affectees a une commande de vente (donc a un chantier)
                                    //  ==>On ne doit imputer au chantier que 4/20e des 1000EUR

                                    LigneRecept.GET(AffectationFraisAnnexe."Applies-to Doc. No.", AffectationFraisAnnexe."Applies-to Doc. Line No.");

                                    LienAchatVente.RESET();
                                    LienAchatVente.SETRANGE("No. document achat", LigneRecept."Order No.");
                                    LienAchatVente.SETRANGE("No. ligne document achat", LigneRecept."Order Line No.");
                                    if LienAchatVente.FINDSET(false) then
                                        repeat
                                            NumEcrRentabilite := NumEcrRentabilite + 1;
                                            EcritureRentabilite.INIT();
                                            EcritureRentabilite."No. sequence" := NumEcrRentabilite;
                                            EcritureRentabilite."Type ecriture" := EcritureRentabilite."Type ecriture"::"Coût";
                                            EcritureRentabilite."Code chantier" := LigneRecept."Code chantier";
                                            EcritureRentabilite."Code groupe" := LigneRecept."Code groupe";
                                            EcritureRentabilite."Code enseigne" := LigneRecept."Code enseigne";
                                            EcritureRentabilite."Code operation" := LigneRecept."Code operation";
                                            EcritureRentabilite."Date comptabilisation" := pEnteteAchat."Posting Date";
                                            EcritureRentabilite."Nature vente" := EcritureRentabilite."Nature vente"::"Indéfini"; //Un coet n'a pas de nature de vente
                                            case TypeFraisAnnexe."Type de coût" of
                                                TypeFraisAnnexe."Type de coût"::"Frais d''approche":
                                                    EcritureRentabilite."Type de cout" := EcritureRentabilite."Type de cout"::Approche;
                                                TypeFraisAnnexe."Type de coût"::Emballage:
                                                    EcritureRentabilite."Type de cout" := EcritureRentabilite."Type de cout"::Emballage;
                                            end;
                                            EcritureRentabilite."Type document" := EcritureRentabilite."Type document"::Facture;
                                            EcritureRentabilite."No. document" := pEnteteFactAchat."No.";
                                            EcritureRentabilite."No. ligne document" := LigneRecept."Line No.";
                                            EcritureRentabilite."No." := LigneAchatFraisAnnexe."No.";
                                            EcritureRentabilite.Description := LigneAchatFraisAnnexe.Description;
                                            EcritureRentabilite.Quantite := LienAchatVente."Quantite affectee" / LigneRecept.Quantity * AffectationFraisAnnexe."Qty. to Assign";
                                            MontantAffecteChantier := ROUND(LienAchatVente."Quantite affectee" / LigneRecept.Quantity * AffectationFraisAnnexe."Amount to Assign", 0.01);

                                            if pEnteteAchat."Currency Code" = '' then begin
                                                if EcritureRentabilite.Quantite <> 0 then
                                                    EcritureRentabilite."Montant unitaire (DS)" := ROUND(MontantAffecteChantier / EcritureRentabilite.Quantite, 0.01);
                                                EcritureRentabilite."Montant total (DS)" := MontantAffecteChantier;
                                            end else begin
                                                if EcritureRentabilite.Quantite <> 0 then
                                                    EcritureRentabilite."Montant unitaire (DS)" := ROUND(
                                                      CurrExchRate.ExchangeAmtFCYToLCY(
                                                        pEnteteAchat."Posting Date", pEnteteAchat."Currency Code",
                                                        MontantAffecteChantier / EcritureRentabilite.Quantite, pEnteteAchat."Currency Factor"));
                                                EcritureRentabilite."Montant total (DS)" := ROUND(
                                                  CurrExchRate.ExchangeAmtFCYToLCY(
                                                    pEnteteAchat."Posting Date", pEnteteAchat."Currency Code",
                                                    MontantAffecteChantier, pEnteteAchat."Currency Factor"));
                                            end;
                                            EcritureRentabilite.INSERT();
                                        until LienAchatVente.NEXT() = 0;
                                end;
                            AffectationFraisAnnexe."Applies-to Doc. Type"::Order:
                                begin

                                    //Toute la quantite n'etait peut-etre pas destinee a un chantier (a du stock).
                                    //Il faut n'affecter au chantier que le prorata
                                    //Exemple :
                                    //  - Les frais d'approche sont de 1000Eur pour 20 pieces commandees.
                                    //  - Sur ces 20 pieces, 4 avaient ete affectees a une commande de vente (donc a un chantier)
                                    //  ==>On ne doit imputer au chantier que 4/20e des 1000EUR

                                    //LigneRecept.GET(AffectationFraisAnnexe."Applies-to Doc. No.",AffectationFraisAnnexe."Applies-to Doc. Line No.");

                                    LienAchatVente.RESET();
                                    LienAchatVente.SETRANGE("No. document achat", AffectationFraisAnnexe."Applies-to Doc. No.");
                                    LienAchatVente.SETRANGE("No. ligne document achat", AffectationFraisAnnexe."Applies-to Doc. Line No.");
                                    if LienAchatVente.FINDSET(false) then
                                        repeat
                                            NumEcrRentabilite := NumEcrRentabilite + 1;
                                            if not LigneCommande.GET(LigneCommande."Document Type"::Order, AffectationFraisAnnexe."Applies-to Doc. No.", AffectationFraisAnnexe."Applies-to Doc. Line No.") then
                                                LigneCommande.INIT();

                                            EcritureRentabilite.INIT();
                                            EcritureRentabilite."No. sequence" := NumEcrRentabilite;
                                            EcritureRentabilite."Type ecriture" := EcritureRentabilite."Type ecriture"::"Coût";
                                            EcritureRentabilite."Code chantier" := LigneCommande."Code chantier";
                                            EcritureRentabilite."Code groupe" := LigneCommande."Code groupe";
                                            EcritureRentabilite."Code enseigne" := LigneCommande."Code enseigne";
                                            EcritureRentabilite."Code operation" := LigneCommande."Code operation";
                                            EcritureRentabilite."Date comptabilisation" := pEnteteAchat."Posting Date";
                                            EcritureRentabilite."Nature vente" := EcritureRentabilite."Nature vente"::Indéfini; //Un cout n'a pas de nature de vente
                                            case TypeFraisAnnexe."Type de coût" of
                                                TypeFraisAnnexe."Type de coût"::"Frais d''approche":
                                                    EcritureRentabilite."Type de cout" := EcritureRentabilite."Type de cout"::Approche;
                                                TypeFraisAnnexe."Type de coût"::Emballage:
                                                    EcritureRentabilite."Type de cout" := EcritureRentabilite."Type de cout"::Emballage;
                                            end;
                                            EcritureRentabilite."Type document" := EcritureRentabilite."Type document"::Facture;
                                            EcritureRentabilite."No. document" := pEnteteFactAchat."No.";
                                            EcritureRentabilite."No. ligne document" := LigneCommande."Line No."; //BOF
                                            EcritureRentabilite."No." := LigneAchatFraisAnnexe."No.";
                                            EcritureRentabilite.Description := LigneAchatFraisAnnexe.Description;
                                            EcritureRentabilite.Quantite := LienAchatVente."Quantite affectee" / LigneRecept.Quantity * AffectationFraisAnnexe."Qty. to Assign";
                                            MontantAffecteChantier := ROUND(LienAchatVente."Quantite affectee" / LigneRecept.Quantity * AffectationFraisAnnexe."Amount to Assign", 0.01);

                                            if pEnteteAchat."Currency Code" = '' then begin
                                                if EcritureRentabilite.Quantite <> 0 then
                                                    EcritureRentabilite."Montant unitaire (DS)" := ROUND(MontantAffecteChantier / EcritureRentabilite.Quantite, 0.01);
                                                EcritureRentabilite."Montant total (DS)" := MontantAffecteChantier;
                                            end else begin
                                                if EcritureRentabilite.Quantite <> 0 then
                                                    EcritureRentabilite."Montant unitaire (DS)" := ROUND(
                                                      CurrExchRate.ExchangeAmtFCYToLCY(
                                                        pEnteteAchat."Posting Date", pEnteteAchat."Currency Code",
                                                        MontantAffecteChantier / EcritureRentabilite.Quantite, pEnteteAchat."Currency Factor"));
                                                EcritureRentabilite."Montant total (DS)" := ROUND(
                                                  CurrExchRate.ExchangeAmtFCYToLCY(
                                                    pEnteteAchat."Posting Date", pEnteteAchat."Currency Code",
                                                    MontantAffecteChantier, pEnteteAchat."Currency Factor"));
                                            end;
                                            EcritureRentabilite.INSERT();
                                        until LienAchatVente.NEXT() = 0;
                                end;

                        end //CASE
                    until AffectationFraisAnnexe.NEXT() = 0;
            until LigneAchatFraisAnnexe.NEXT() = 0;
        end;
    end;



    //Morceau de CU90 deplace vers nouveau CU
    [EventSubscriber(ObjectType::Codeunit, 826, OnPostLedgerEntryOnBeforeGenJnlPostLine, '', false, false)]
    local procedure CU826_OnPostLedgerEntryOnBeforeGenJnlPostLine(var GenJnlLine: Record "Gen. Journal Line"; var PurchHeader: Record "Purchase Header")
    begin
        //KAN.FHA 21/10/2022 DEBUT
        GenJnlLine."Code enseigne" := PurchHeader."Code enseigne";
        //KAN.FHA 21/10/2022 FIN
        GenJnlLine.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, OnAfterUpdateLastPostingNos, '', false, false)]
    local procedure CU90_OnAfterUpdateLastPostingNos(var PurchHeader: Record "Purchase Header")
    begin
        //KAN.FHA 06/07/2020 DEBUT
        PurchHeader."Vendor Invoice No." := '';
        //KAN.FHA 06/07/2020 FIN
        PurchHeader.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, OnPostItemJnlLineOnAfterPrepareItemJnlLine, '', false, false)]
    local procedure CU90_OnPostItemJnlLineOnAfterPrepareItemJnlLine(var ItemJournalLine: Record "Item Journal Line"; PurchaseHeader: Record "Purchase Header")
    begin
        //KAN.FHA 29/10/2021 DEBUT
        ItemJournalLine."SAV fournisseur" := (PurchaseHeader."SAV Type" = PurchaseHeader."SAV Type"::FOURNISSEUR);
        //KAN.FHA 29/10/2021 FIN

        //KAN.FHA 18/10/2022 DEBUT
        ItemJournalLine."Exclure DEB" := ItemJournalLine."SAV fournisseur";
        //KAN.FHA 18/10/2022 FIN
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, OnAfterPurchInvLineInsert, '', false, false)]
    local procedure CU90_OnAfterPurchInvLineInsert(var PurchInvLine: Record "Purch. Inv. Line"; PurchHeader: Record "Purchase Header"; PurchLine: Record "Purchase Line")
    var
        CurrExchRate: record "Currency Exchange Rate";
        Chantier: Record Chantier;
    begin
        //KAN 31/01/2020 DEBUT Gestion affaire
        if PurchHeader."Currency Code" = '' then
            PurchInvLine."Montant ligne HT (DS)" := PurchInvLine.Amount
        else
            PurchInvLine."Montant ligne HT (DS)" :=
              CurrExchRate.ExchangeAmtFCYToLCY(PurchHeader."Posting Date", PurchHeader."Currency Code", PurchInvLine.Amount, PurchHeader."Currency Factor");
        //KAN 31/01/2020 FIN
        //KAN.FHA 22/06/2023 DEBUT
        if not Chantier.GET(PurchInvLine."Code chantier") then
            Chantier.INIT();

        if Chantier."Activer rentabilite" then begin
            if (PurchHeader."SAV Type" <> PurchHeader."SAV Type"::FOURNISSEUR) and (not PurchHeader."Achat pour stock") and (PurchInvLine.Type <> PurchInvLine.Type::"Charge (Item)") then //Les frais annexes font l'objet d'une autre procdure d'enregistrement
                AffecterLigneFactureAuChantier(PurchHeader, PurchInvLine, PurchLine);
            MAJEcritureRentabilite(PurchLine);
        end;
        //KAN.FHA 22/06/2023 FIN

    end;

    local procedure MAJEcritureRentabilite(pTempPurchLine: Record "Purchase Line");
    var
        EcritureRenta: Record 50003;
    begin
        EcritureRenta.SETCURRENTKEY("Type ecriture", "Type document", "No. document", "No. ligne document");
        EcritureRenta.SETRANGE("Type ecriture", EcritureRenta."Type ecriture"::Coût);
        EcritureRenta.SETRANGE("Type document", EcritureRenta."Type document"::Facture);
        EcritureRenta.SETRANGE("No. document", pTempPurchLine."Document No.");
        EcritureRenta.SETRANGE("No. ligne document", pTempPurchLine."Line No.");
        if EcritureRenta.FINDSET(true) then
            repeat
                if EcritureRenta."Montant unitaire (DS)" <> pTempPurchLine."Unit Cost (LCY)" then begin
                    EcritureRenta.VALIDATE("Montant unitaire (DS)", pTempPurchLine."Unit Cost (LCY)");
                    EcritureRenta.MODIFY();
                end;
            until EcritureRenta.NEXT() = 0;
    end;

    local procedure AffecterLigneFactureAuChantier(pEnteteAchat: Record "Purchase Header"; pPurchInvLine: Record "Purch. Inv. Line"; pPurchLine: Record "Purchase Line");
    var
        EcritureRentabilite: Record "Ecriture rentabilite";
        EnteteFactAchat: record "Purch. Inv. Header";
        LienAchatVente: Record "Affectations achat vente";
        LigneCommandeVente: Record "Sales Line";
        LigneFactureVente: Record "Sales Invoice Line";
        CurrExchRate: record "Currency Exchange Rate";
        Montant: Decimal;
        NumEcrRentabilite: Integer;

    begin
        //On ne va affecter aux chantiers que les quantites affectees (lien achat - vente = Table des affectations)
        //Si la commande d'achat fait 20 pieces, peut-etre que 6 pieces sont destinees a un chantier (les autres au stock) et ce sont ces 6 pieces
        //qu'on va imputer a la rentabilite du chantier.
        EnteteFactAchat.GET(pPurchInvLine."Document No.");
        EcritureRentabilite.LOCKTABLE();
        NumEcrRentabilite := 0;
        if EcritureRentabilite.FINDLAST() then
            NumEcrRentabilite := EcritureRentabilite."No. sequence";

        if (pPurchLine."Article divers") or (pPurchInvLine.Type = pPurchInvLine.Type::"G/L Account") then begin //Affection ou non, on impute l'achat 100%
            NumEcrRentabilite := NumEcrRentabilite + 1;
            EcritureRentabilite.INIT();
            EcritureRentabilite."No. sequence" := NumEcrRentabilite;
            EcritureRentabilite."Type ecriture" := EcritureRentabilite."Type ecriture"::"Coût";
            EcritureRentabilite."Type de cout" := EcritureRentabilite."Type de cout"::Achat;
            EcritureRentabilite."Code chantier" := pPurchLine."Code chantier";
            EcritureRentabilite."Code groupe" := pPurchLine."Code groupe";
            EcritureRentabilite."Code enseigne" := pPurchLine."Code enseigne";
            EcritureRentabilite."Code operation" := pPurchLine."Code operation";
            EcritureRentabilite."Date comptabilisation" := pEnteteAchat."Posting Date";
            EcritureRentabilite."Nature vente" := pPurchLine."Nature vente";
            EcritureRentabilite."Type document" := EcritureRentabilite."Type document"::Facture;
            EcritureRentabilite."No. document" := EnteteFactAchat."No.";
            EcritureRentabilite."No. ligne document" := pPurchInvLine."Line No.";
            EcritureRentabilite."No." := pPurchInvLine."No.";
            EcritureRentabilite.Description := pPurchInvLine.Description;
            EcritureRentabilite.Quantite := pPurchInvLine.Quantity;
            Montant := pPurchInvLine.Amount;

            if pEnteteAchat."Currency Code" = '' then begin
                EcritureRentabilite."Montant unitaire (DS)" := pPurchInvLine."Direct Unit Cost";
                EcritureRentabilite."Montant total (DS)" := Montant;
            end else begin
                EcritureRentabilite."Montant unitaire (DS)" := ROUND(
                    CurrExchRate.ExchangeAmtFCYToLCY(
                    pEnteteAchat."Posting Date", pEnteteAchat."Currency Code",
                    pPurchInvLine."Direct Unit Cost", pEnteteAchat."Currency Factor"));

                EcritureRentabilite."Montant total (DS)" := ROUND(
                    CurrExchRate.ExchangeAmtFCYToLCY(
                    pEnteteAchat."Posting Date", pEnteteAchat."Currency Code",
                    Montant, pEnteteAchat."Currency Factor"));
            end;
            EcritureRentabilite.INSERT();

        end else begin
            LienAchatVente.RESET();
            LienAchatVente.SETRANGE("No. document achat", pPurchLine."Document No.");
            LienAchatVente.SETRANGE("No. ligne document achat", pPurchLine."Line No.");
            if LienAchatVente.FINDSET(false) then
                repeat
                    NumEcrRentabilite := NumEcrRentabilite + 1;
                    EcritureRentabilite.INIT();
                    EcritureRentabilite."No. sequence" := NumEcrRentabilite;
                    EcritureRentabilite."Type ecriture" := EcritureRentabilite."Type ecriture"::"Coût";
                    EcritureRentabilite."Type de cout" := EcritureRentabilite."Type de cout"::Achat;

                    EcritureRentabilite."Code chantier" := pPurchLine."Code chantier";
                    EcritureRentabilite."Code groupe" := pPurchLine."Code groupe";
                    EcritureRentabilite."Code enseigne" := pPurchLine."Code enseigne";
                    EcritureRentabilite."Code operation" := pPurchLine."Code operation";
                    EcritureRentabilite."Date comptabilisation" := pEnteteAchat."Posting Date";

                    case LienAchatVente."Type document vente" of
                        LienAchatVente."Type document vente"::Commande:

                            if LigneCommandeVente.GET(LigneCommandeVente."Document Type"::Order, LienAchatVente."No. document vente", LienAchatVente."No. ligne document vente") then
                                EcritureRentabilite."Nature vente" := LigneCommandeVente."Nature vente"
                            else
                                EcritureRentabilite."Nature vente" := EcritureRentabilite."Nature vente"::"Indéfini";

                        LienAchatVente."Type document vente"::"Facture enregistrée":

                            if LigneFactureVente.GET(LienAchatVente."No. document vente", LienAchatVente."No. ligne document vente") then
                                EcritureRentabilite."Nature vente" := LigneFactureVente."Nature vente"
                            else
                                EcritureRentabilite."Nature vente" := EcritureRentabilite."Nature vente"::"Indéfini";

                        else
                            EcritureRentabilite."Nature vente" := EcritureRentabilite."Nature vente"::"Indéfini";
                    end;

                    EcritureRentabilite."Type document" := EcritureRentabilite."Type document"::Facture;
                    EcritureRentabilite."No. document" := EnteteFactAchat."No.";
                    EcritureRentabilite."No. ligne document" := pPurchInvLine."Line No.";
                    EcritureRentabilite."No." := pPurchInvLine."No.";
                    EcritureRentabilite.Description := pPurchInvLine.Description;
                    EcritureRentabilite.Quantite := LienAchatVente."Quantite affectee";

                    Montant := ROUND(LienAchatVente."Quantite affectee" / pPurchLine.Quantity * pPurchInvLine.Amount, 0.01);

                    if pEnteteAchat."Currency Code" = '' then begin
                        EcritureRentabilite."Montant unitaire (DS)" := pPurchInvLine."Direct Unit Cost";
                        EcritureRentabilite."Montant total (DS)" := Montant;
                    end else begin
                        EcritureRentabilite."Montant unitaire (DS)" := ROUND(
                            CurrExchRate.ExchangeAmtFCYToLCY(
                            pEnteteAchat."Posting Date", pEnteteAchat."Currency Code",
                            pPurchInvLine."Direct Unit Cost", pEnteteAchat."Currency Factor"));

                        EcritureRentabilite."Montant total (DS)" := ROUND(
                            CurrExchRate.ExchangeAmtFCYToLCY(
                            pEnteteAchat."Posting Date", pEnteteAchat."Currency Code",
                            Montant, pEnteteAchat."Currency Factor"));
                    end;
                    EcritureRentabilite.INSERT();

                until LienAchatVente.NEXT() = 0;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, OnAfterPurchCrMemoLineInsert, '', false, false)]
    local procedure CU90_OnAfterPurchCrMemoLineInsert(var PurchaseHeader: Record "Purchase Header"; var PurchCrMemoLine: Record "Purch. Cr. Memo Line"; var PurchLine: Record "Purchase Line")
    var
        CurrexchRate: Record "Currency Exchange Rate";

    begin
        //KAN 31/01/2020 DEBUT Gestion affaire
        if PurchaseHeader."Currency Code" = '' then
            PurchCrMemoLine."Montant ligne HT (DS)" := PurchCrMemoLine.Amount
        else
            PurchCrMemoLine."Montant ligne HT (DS)" :=
              CurrExchRate.ExchangeAmtFCYToLCY(PurchaseHeader."Posting Date", PurchaseHeader."Currency Code", PurchCrMemoLine.Amount, PurchaseHeader."Currency Factor");
        //KAN 31/01/2020 DEBUT

        //KAN.FHA 30/10/2023 DEBUT
        if (PurchaseHeader."SAV Type" <> PurchaseHeader."SAV Type"::FOURNISSEUR) and (not PurchaseHeader."Achat pour stock") and (PurchCrMemoLine.Type <> PurchCrMemoLine.Type::"Charge (Item)") then //Les frais annexes font l'objet d'une autre procdure d'enregistrement
            AffecterLigneAvoirAuChantier(PurchaseHeader, PurchCrMemoLine, PurchLine);
        //KAN.FHA 30/10/2023 FIN

        //KAN.FHA 13/03/2025 DEBUT
        PurchCrMemoLine."Annee commande" := PurchaseHeader."Annee commande";
        PurchCrMemoLine.Modify();
        //KAN.FHA 13/03/2025 FIN

    end;

    local procedure AffecterLigneAvoirAuChantier(pEnteteAchat: Record "Purchase Header"; pPurchCrMemoLine: Record "Purch. Cr. Memo Line"; pPurchLine: Record "Purchase Line");
    var
        EcritureRentabilite: Record "Ecriture rentabilite";
        EnteteAvoirAchat: record "Purch. Cr. Memo Hdr.";
        CurrExchRate: record "Currency Exchange Rate";
        NumEcrRentabilite: Integer;
        Montant: Decimal;

    begin
        EnteteAvoirAchat.GET(pPurchCrMemoLine."Document No.");

        //Pas d'affectation entre achat et vente pour un avoir
        EcritureRentabilite.LOCKTABLE();
        NumEcrRentabilite := 0;
        if EcritureRentabilite.FINDLAST() then
            NumEcrRentabilite := EcritureRentabilite."No. sequence" + 1
        else
            NumEcrRentabilite := 1;

        EcritureRentabilite.INIT();
        EcritureRentabilite."No. sequence" := NumEcrRentabilite;
        EcritureRentabilite."Type ecriture" := EcritureRentabilite."Type ecriture"::"Coût";
        EcritureRentabilite."Type de cout" := EcritureRentabilite."Type de cout"::Achat;

        EcritureRentabilite."Code chantier" := pPurchLine."Code chantier";
        EcritureRentabilite."Code groupe" := pPurchLine."Code groupe";
        EcritureRentabilite."Code enseigne" := pPurchLine."Code enseigne";
        EcritureRentabilite."Code operation" := pPurchLine."Code operation";
        EcritureRentabilite."Date comptabilisation" := pEnteteAchat."Posting Date";

        EcritureRentabilite."Nature vente" := pPurchLine."Nature vente";

        EcritureRentabilite."Type document" := EcritureRentabilite."Type document"::Avoir;
        EcritureRentabilite."No. document" := EnteteAvoirAchat."No.";
        EcritureRentabilite."No. ligne document" := pPurchCrMemoLine."Line No.";
        EcritureRentabilite."No." := pPurchCrMemoLine."No.";
        EcritureRentabilite.Description := pPurchCrMemoLine.Description;
        EcritureRentabilite.Quantite := -pPurchCrMemoLine.Quantity;

        Montant := -pPurchCrMemoLine.Amount;

        if pEnteteAchat."Currency Code" = '' then begin
            if pPurchCrMemoLine.Quantity <> 0 then
                EcritureRentabilite."Montant unitaire (DS)" := ROUND(pPurchCrMemoLine.Amount / pPurchCrMemoLine.Quantity, 0.01);
            EcritureRentabilite."Montant total (DS)" := Montant;
        end else begin
            if pPurchCrMemoLine.Quantity <> 0 then
                EcritureRentabilite."Montant unitaire (DS)" := ROUND(
                  CurrExchRate.ExchangeAmtFCYToLCY(
                    pEnteteAchat."Posting Date", pEnteteAchat."Currency Code",
                    pPurchCrMemoLine.Amount, pEnteteAchat."Currency Factor"));

            EcritureRentabilite."Montant total (DS)" := ROUND(
              CurrExchRate.ExchangeAmtFCYToLCY(
                pEnteteAchat."Posting Date", pEnteteAchat."Currency Code",
                Montant, pEnteteAchat."Currency Factor"));
        end;
        EcritureRentabilite.INSERT();
    end;

    [EventSubscriber(ObjectType::Codeunit, 1320, OnBeforeSalesCheckAllLinesHaveQuantityAssigned, '', false, false)] //Lancé quand on imprime un devis
    local procedure CU1320_OnBeforeSalesCheckAllLinesHaveQuantityAssigned(SalesHeader: Record "Sales Header")
    var
        EnteteVente: Record "Sales Header";
        ReleaseSalesDocCU: Codeunit "Release Sales Document";
    //ArchiveManagement: Codeunit ArchiveManagement;   

    begin
        EnteteVente.Get(SalesHeader."Document Type", SalesHeader."No.");
        if SalesHeader.Status <> SalesHeader.Status::Released then begin

            ReleaseSalesDocCU.PerformManualRelease(EnteteVente);
            Commit();
        end;

        SalesHeader.Archiver();

    end;

    [EventSubscriber(ObjectType::Codeunit, 229, OnBeforePrintSalesOrder, '', false, false)]
    local procedure Codeunit229_OnBeforePrintSalesOrder(var SalesHeader: Record "Sales Header")
    var
        EnteteVente: Record "Sales Header";
        ReleaseSalesDocCU: Codeunit "Release Sales Document";
    begin

        SalesHeader.CalcSubTotal(SalesHeader);
        Commit();

        EnteteVente.Get(SalesHeader."Document Type", SalesHeader."No.");
        if EnteteVente.Status <> EnteteVente.Status::Released then begin
            ReleaseSalesDocCU.PerformManualRelease(EnteteVente);
            Commit();
        end;

        EnteteVente.Archiver();
    end;

    [EventSubscriber(ObjectType::Codeunit, 365, OnBeforeSalesHeaderSellTo, '', false, false)]
    local procedure CU365_OnBeforeSalesHeaderSellTo(var SalesHeader: Record "Sales Header") //FormatAddress
    begin
        SalesHeader."Sell-to Contact" := '';
        //Pas de modify, c'est pour que le formatage de l'adresse où ne veut pas que le nom du contact apparaisse
    end;

    [EventSubscriber(ObjectType::Codeunit, 365, OnBeforeSalesHeaderBillTo, '', false, false)]
    local procedure CU365_OnBeforeSalesHeaderBilllTo(var SalesHeader: Record "Sales Header") //FormatAddress
    begin
        SalesHeader."Bill-to Contact" := '';
        //Pas de modify, c'est pour que le formatage de l'adresse où ne veut pas que le nom du contact apparaisse
    end;

    [EventSubscriber(ObjectType::Codeunit, 365, OnBeforeSalesHeaderShipTo, '', false, false)]
    local procedure CU365_OnBeforeSalesHeaderShipTo(var SalesHeader: Record "Sales Header") //FormatAddress
    begin
        SalesHeader."Ship-to Contact" := '';
        //Pas de modify, c'est pour que le formatage de l'adresse où ne veut pas que le nom du contact apparaisse
    end;

    [EventSubscriber(ObjectType::Codeunit, 365, OnBeforeSalesCrMemoSellTo, '', false, false)]
    local procedure CU365_OnBeforeSalesCrMemoSellTo(var SalesCrMemoHeader: Record "Sales Cr.Memo Header") //FormatAddress
    begin
        SalesCrMemoHeader."Sell-to Contact" := '';
        //Pas de modify, c'est pour que le formatage de l'adresse où ne veut pas que le nom du contact apparaisse
    end;

    [EventSubscriber(ObjectType::Codeunit, 365, OnBeforeSalesCrMemoBillTo, '', false, false)]
    local procedure CU365_OnBeforeSalesCrMemoBillTo(var SalesCrMemoHeader: Record "Sales Cr.Memo Header") //FormatAddress
    begin
        SalesCrMemoHeader."Bill-to Contact" := '';
        //Pas de modify, c'est pour que le formatage de l'adresse où ne veut pas que le nom du contact apparaisse
    end;

    [EventSubscriber(ObjectType::Codeunit, 365, OnBeforeSalesCrMemoShipTo, '', false, false)]
    local procedure CU365_OnBeforeSalesCrMemoShipTo(var SalesCrMemoHeader: Record "Sales Cr.Memo Header") //FormatAddress
    begin
        SalesCrMemoHeader."Ship-to Contact" := '';
        //Pas de modify, c'est pour que le formatage de l'adresse où ne veut pas que le nom du contact apparaisse
    end;

    [EventSubscriber(ObjectType::Codeunit, 365, OnBeforeSalesInvSellTo, '', false, false)]
    local procedure CU365_OnBeforeSalesInvSellTo(var SalesInvoiceHeader: Record "Sales Invoice Header") //FormatAddress
    begin
        SalesInvoiceHeader."Sell-to Contact" := '';
        //Pas de modify, c'est pour que le formatage de l'adresse où ne veut pas que le nom du contact apparaisse
    end;

    [EventSubscriber(ObjectType::Codeunit, 365, OnBeforeSalesInvBillTo, '', false, false)]
    local procedure CU365_OnBeforeSalesInvBillTo(var SalesInvHeader: Record "Sales Invoice Header") //FormatAddress
    begin
        SalesInvHeader."Bill-to Contact" := '';
        //Pas de modify, c'est pour que le formatage de l'adresse où ne veut pas que le nom du contact apparaisse
    end;

    [EventSubscriber(ObjectType::Codeunit, 365, OnBeforeSalesInvShipTo, '', false, false)]
    local procedure CU365_OnBeforeSalesInvShipTo(var SalesInvHeader: Record "Sales Invoice Header") //FormatAddress
    begin
        SalesInvHeader."Ship-to Contact" := '';
        //Pas de modify, c'est pour que le formatage de l'adresse où ne veut pas que le nom du contact apparaisse
    end;

    [EventSubscriber(ObjectType::Codeunit, 365, OnBeforeSalesShptSellTo, '', false, false)]
    local procedure CU365_OnBeforeSalesShptSellTo(var SalesShipmentHeader: Record "Sales Shipment Header") //FormatAddress
    begin
        SalesShipmentHeader."Sell-to Contact" := '';
        //Pas de modify, c'est pour que le formatage de l'adresse où ne veut pas que le nom du contact apparaisse
    end;

    [EventSubscriber(ObjectType::Codeunit, 365, OnBeforePurchHeaderBuyFrom, '', false, false)]
    local procedure CU365_OnBeforePurchHeaderBuyFrom(var PurchaseHeader: Record "Purchase Header") //FormatAddress
    begin
        PurchaseHeader."Buy-from Contact" := '';
        //Pas de modify, c'est pour que le formatage de l'adresse où ne veut pas que le nom du contact apparaisse
    end;


    [EventSubscriber(ObjectType::Codeunit, 391, OnBeforeSalesShptHeaderModify, '', false, false)]
    local procedure CU391_OnBeforeSalesShptHeaderModify(var SalesShptHeader: Record "Sales Shipment Header"; FromSalesShptHeader: Record "Sales Shipment Header")
    begin
        SalesShptHeader."No. And Location Name" := FromSalesShptHeader."No. And Location Name";
        SalesShptHeader."Range No." := FromSalesShptHeader."Range No.";
        SalesShptHeader.Comments := FromSalesShptHeader.Comments;
        SalesShptHeader."Nombre de colis" := FromSalesShptHeader."Nombre de colis";
        SalesShptHeader."Nombre de palettes" := FromSalesShptHeader."Nombre de palettes";
        SalesShptHeader."Annee commande" := FromSalesShptHeader."Annee commande";
        SalesShptHeader."Code magasin remise en stock" := FromSalesShptHeader."Code magasin remise en stock";
        SalesShptHeader."Date remise en stock" := FromSalesShptHeader."Date remise en stock";
        SalesShptHeader.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, 391, OnRunOnAfterSalesShptHeaderEdit, '', false, false)]
    local procedure CU391_OnRunOnAfterSalesShptHeaderEdit(var SalesShptHeader: Record "Sales Shipment Header")
    begin
        //KAN.FHA 13/03/2025 DEBUT
        SalesShptHeader."Annee commande" := SalesShptHeader."Annee commande";
        SalesShptHeader.Modify();
        //KAN.FHA 13/03/2025 FIN
    end;

    [EventSubscriber(ObjectType::Codeunit, 414, OnBeforeOnRun, '', false, false)]
    local procedure CU414_OnBeforeRun(var SalesHeader: Record "Sales Header")
    var
        ParamVte: Record "Sales & Receivables Setup";
        CompanyInfo: record "Company Information";
        LigneVente: Record "Sales Line";
        PhasesDocument: Record "Phases document";
        PhasesDocumentSuppr: Record "Phases document";
        Article: Record Item;
        LigneComposantAvecMontantErr: Label 'Validation impossible, car il existe un composant valorisé %1, sur la ligne du document %2 %3 %4', Comment = '%1 = Montant ; %2 = Type document ; %3 = N° document ; %4 = N° ligne document';
        DateObligatoireErr: Label 'Vérifiez la phase %1 car elle n''a pas de date de chargement ou de date de livraison confirmée.', Comment = '%1 = Code phase';

    begin
        //DIAFTS - 28/03/2019 - AT0694017 - Ctrl coherence des souches
        ParamVte.Get();
        if SalesHeader.ASS then begin
            //KAN.FHA 28/08/2020 DEBUT
            if (SalesHeader."Document Type" <> SalesHeader."Document Type"::Quote) and (SalesHeader."No. Series" <> '') then
                //KAN.FHA 28/08/2020 FIN
                if (SalesHeader."No. Series" in [ParamVte."ASS Order Nos.",
                                ParamVte."ASS Invoice Nos.",
                                ParamVte."ASS Posted Invoice Nos.",
                                ParamVte."ASS Credit Memo Nos.",
                                ParamVte."ASS Posted Credit Memo Nos."]) = false then
                    ERROR('La souche %1 du document SAV %2 ne correspond pas aux souches utilisées pour les documents SAV', SalesHeader."No. Series", SalesHeader."No.");

            if (SalesHeader."Posting No. Series" in [ParamVte."ASS Order Nos.",
                                        ParamVte."ASS Invoice Nos.",
                                        ParamVte."ASS Posted Invoice Nos.",
                                        ParamVte."ASS Credit Memo Nos.",
                                        ParamVte."ASS Posted Credit Memo Nos."]) = false
            then
                ERROR('La souche de validation %1 du document SAV %2 ne correspond pas aux souches utilisées pour les documents SAV', SalesHeader."Posting No. Series", SalesHeader."No.");

        end else begin
            if (SalesHeader."No. Series" in [ParamVte."ASS Order Nos.",
                                ParamVte."ASS Invoice Nos.",
                                ParamVte."ASS Posted Invoice Nos.",
                                ParamVte."ASS Credit Memo Nos.",
                                ParamVte."ASS Posted Credit Memo Nos."]) then
                ERROR('La souche %1 du document %2 est exclusivement réservée aux documents du SAV', SalesHeader."No. Series", SalesHeader."No.");

            if (SalesHeader."Posting No. Series" in [ParamVte."ASS Order Nos.",
                                        ParamVte."ASS Invoice Nos.",
                                        ParamVte."ASS Posted Invoice Nos.",
                                        ParamVte."ASS Credit Memo Nos.",
                                        ParamVte."ASS Posted Credit Memo Nos."]) then
                ERROR('La souche de validation %1 du document SAV %2 est exclusivement réservée aux documents du SAV', SalesHeader."Posting No. Series", SalesHeader."No.");
        end;
        //DIAFTS - 28/03/2019

        //KAN.FHA 13/04/2023 DEBUT
        SalesHeader.TESTFIELD("Ship-to Country/Region Code");
        //KAN.FHA 13/04/2023 FIN

        //KAN.FHA 08/12/2025 DEBUT
        SalesHeader.TestField("Salesperson Code");
        if not SalesHeader."Devis Stock" then
            SalesHeader.TestField("Code chantier");
        //KAN.FHA 08/12/2025 FIN

        //KAN.FHA 31/03/2025 DEBUT
        if SalesHeader."Document type" in [SalesHeader."Document Type"::Quote, SalesHeader."Document Type"::Order] then
            SalesHeader.TestField("Date chargement");
        //KAN.FHA 31/03/2025 FIN

        if SalesHeader."Document Type" = SalesHeader."Document Type"::Quote then
            SalesHeader.TestField("Requested Delivery Date");

        //KAN.FHA 21/10/2025 DEBUT
        if SalesHeader."Document Type" in [SalesHeader."Document Type"::Quote, SalesHeader."Document Type"::Order] then begin
            //KAN.FHA 16/01/2026 DEBUT
            //On va commencer par supprimer les phases qui n'ont aucun article (sauf la phase 0 qu'on va conserver pour pouvoir tjs ajouter un article qui se mettrait par défaut sur la phase 0)
            PhasesDocument.SetRange("Type document", SalesHeader."Document Type");
            PhasesDocument.SetRange("No. document", SalesHeader."No.");
            PhasesDocument.SetFilter(Phase, '>%1', 0);
            if PhasesDocument.FindSet(true) then begin
                repeat
                    PhasesDocument.CalcFields("Nb lignes dans phase");
                    if PhasesDocument."Nb lignes dans phase" = 0 then begin
                        PhasesDocumentSuppr.get(PhasesDocument."Type document", PhasesDocument."No. document", PhasesDocument.Phase);
                        PhasesDocumentSuppr.Delete();
                    end;
                until PhasesDocument.Next() = 0;

                PhasesDocument.SetRange(Phase);
                if PhasesDocument.FindSet(false) then
                    repeat
                        //KAN.FHA 26/05/2026 DEBUT
                        //Les lignes ne sont pas encore supprimées visiblement malgré le code précédent et je ne vais pas mettre de commit ici.
                        PhasesDocument.CalcFields("Nb lignes dans phase");
                        if PhasesDocument."Nb lignes dans phase" > 0 then
                            //KAN.FHA 26/05/2026 FIN
                            if (PhasesDocument."Date livraison demandee" = 0D) or (PhasesDocument."Date chargement" = 0D) then
                                error(DateObligatoireErr, PhasesDocument.Phase);
                    until PhasesDocument.Next() = 0;
            end;

        end;
        //KAN.FHA 21/10/2025 FIN

        SalesHeader.CalculerPoidsTotal();
        SalesHeader.Calcsubtotal(SalesHeader);

        //KAN.FHA 17/10/2022 DEBUT
        CompanyInfo.GET();
        LigneVente.SETRANGE("Document Type", SalesHeader."Document Type");
        LigneVente.SETRANGE("Document No.", SalesHeader."No.");
        LigneVente.SETRANGE(Type, LigneVente.Type::Item);
        LigneVente.SETFILTER(Quantity, '<>0');
        if LigneVente.FINDSET(false) then
            repeat
                if SalesHeader."Ship-to Country/Region Code" <> CompanyInfo."Country/Region Code" then
                    if not LigneVente."Article divers" then begin //On est sur un 102, certains champs doivent etre saisis sur l'article
                        LigneVente.TESTFIELD("Net Weight");
                        Article.GET(LigneVente."No.");
                        Article.TESTFIELD("Tariff No.");
                        Article.TESTFIELD(Article."Country/Region of Origin Code");
                    end else begin //On est sur un divers, les champs doivent etre saisis à la ligne
                        Article.GET(LigneVente."No.");
                        if Article."Poids obligatoire" then begin
                            LigneVente.TestField("Net Weight");
                            LigneVente.TestField("Nomenclature produits");
                            LigneVente.TestField("Country/Region of Origin Code");
                        end;
                    end
            until LigneVente.Next() = 0;

        //DIAFTS 11/09/2015 - AT0665961 Probleme de validation de ligne composant valorise
        LigneVente.Reset();
        LigneVente.SETRANGE("Document Type", SalesHeader."Document Type");
        LigneVente.SETRANGE("Document No.", SalesHeader."No.");
        LigneVente.SETFILTER("Linked to line", '>%1', 0);                //DIAFTS 01/10/2015
        LigneVente.SETFILTER(Amount, '<>%1', 0);
        if not LigneVente.IsEmpty then
            ERROR(LigneComposantAvecMontantErr, LigneVente.Amount, LigneVente."Document Type", LigneVente."Document No.", LigneVente."Line No.");
        //DIAFTS 11/09/2015

        //KAN.FHA 20/06/2025 DEBUT
        IF ((SalesHeader."Document Type" = SalesHeader."Document Type"::Quote) and (SalesHeader."Proba transformation" = SalesHeader."Proba transformation"::"100")) or
            (SalesHeader."Document Type" = SalesHeader."Document Type"::Order)
        then
            SalesHeader.MAJDossierBE();
        //KAN.FHA 20/06/2025 FIN    
    end;

    [EventSubscriber(ObjectType::Codeunit, 414, OnAfterReleaseSalesDoc, '', false, false)]
    local procedure CU414_OnAfterReleaseSalesDoc(var SalesHeader: Record "Sales Header")
    var
        pctAcompteActuel: Decimal;
        NouveauPctAcompte: Decimal;
        ConditionsAcompteModifieesMsg: Label 'Pour votre information, le % d''acompte demandé a évolué.';
    begin
        //- DIA/BPE 17/11/14
        SalesHeader.UpdateFieldReleaseStatus_T();
        //+ DIA/BPE 17/11/14
        //KAN.FHA 02/06/2021 DEBUT
        pctAcompteActuel := SalesHeader."% acompte demande";
        NouveauPctAcompte := SalesHeader.DefinirPctAcompte();
        SalesHeader."% acompte demande" := NouveauPctAcompte;
        SalesHeader.MODIFY();

        if (pctAcompteActuel <> 0) and (NouveauPctAcompte <> pctAcompteActuel) then
            MESSAGE(ConditionsAcompteModifieesMsg);
        //KAN.FHA 02/06/2021 FIN

        //KAN.FHA 08/08/2025 DEBUT
        if SalesHeader."Document Type" in [SalesHeader."Document Type"::Quote, SalesHeader."Document Type"::Order] then
            SalesHeader.ListerPhases();
        //KAN.FHA 08/08/2025 FIN
    end;

    [EventSubscriber(ObjectType::Codeunit, 414, OnAfterReopenSalesDoc, '', false, false)]
    local procedure CU414_OnAfterReopenSalesDoc(var SalesHeader: Record "Sales Header")
    begin
        //- DIA/BPE 17/11/14
        SalesHeader.UpdateFieldReleaseStatus_T();
        //+ DIA/BPE 17/11/14

    end;

    [EventSubscriber(ObjectType::Codeunit, 415, OnCodeOnAfterCheckPurchaseReleaseRestrictions, '', false, false)]
    local procedure CU415_OnCodeOnAfterCheckPurchaseReleaseRestrictions(var PurchaseHeader: Record "Purchase Header")
    var
        CompanyInfo: Record "Company Information";
        PurchLine: Record "Purchase Line";
        Article: Record Item;
        DiversNonAffecteQst: label 'L''article Divers de la ligne %1 n''est pas affecté à une vente, voulez-vous affecter votre achat à une vente ?', Comment = '%1 = N° ligne';
        NumLigne: Integer;
    begin

        //KAN.FHA 07/06/2021 DEBUT
        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then
            //KAN.FHA 18/06/2021 DEBUT
            //CompanyInfo.GET();
            //if (PurchaseHeader."Buy-from Country/Region Code" <> CompanyInfo."Country/Region Code") and (PurchaseHeader."Buy-from Country/Region Code" <> '') then
            //KAN.FHA 18/06/2021 FIN
            //KAN.FHA 27/05/2026 DEBUT
            if PurchaseHeader."Suivi container" then
                //KAN.FHA 27/05/2026 FIN
                PurchaseHeader.TESTFIELD("Date intention chargement");
        //KAN.FHA 07/06/2021 FIN

        //KAN.FHA 17/08/2026 DEBUT
        PurchaseHeader.VerifierLigneArticleSansNum();
        //KAN.FHA 17/08/2026 FIN
        
        //KAN.FHA 17/10/2022 DEBUT
        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then begin
            CompanyInfo.GET();
            PurchLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
            PurchLine.SETRANGE("Document No.", PurchaseHeader."No.");
            PurchLine.SETRANGE(Type, PurchLine.Type::Item);
            PurchLine.SETFILTER(Quantity, '<>0');
            if PurchLine.FINDSET(false) then
                repeat
                    if PurchaseHeader."Buy-from Country/Region Code" <> CompanyInfo."Country/Region Code" then begin
                        if not PurchLine."Article divers" then begin
                            PurchLine.TESTFIELD("Net Weight");
                            Article.GET(PurchLine."No.");
                            Article.TESTFIELD("Tariff No.");
                            Article.TESTFIELD("Country/Region of Origin Code");
                        end;
                        if PurchLine."Article divers" then
                            PurchLine.TESTFIELD("Nomenclature produits"); //Renseigne que sur les divers ; la feuille intracomm va chercher la nomenc produit sur l'article pour les non Divers
                    end;
                until PurchLine.NEXT() = 0;
            PurchLine.RESET();
        end;
        //KAN.FHA 17/10/2022 FIN

        //KAN.FHA 22/04/2020 DEBUT Alerter si on a achete un divers sans dire pour quelle vente on l'achete.
        if (not PurchaseHeader.Receive) and (not PurchaseHeader.Invoice) then
            if PurchaseHeader.DiversNonAffecte(NumLigne) then
                if CONFIRM(DiversNonAffecteQst, false, NumLigne) then begin
                    //On ouvre l'cran d'affectation
                    AfficherDiversSansAffectation(PurchaseHeader);
                    exit;
                end;
        //KAN.FHA 22/04/2020 FIN
    end;

    local procedure AfficherDiversSansAffectation(pPurchHeader: Record 38);
    var
        pgListeDiversSansAffectation: Page "Achats Divers sans affectation";
    begin
        CLEAR(pgListeDiversSansAffectation);
        pgListeDiversSansAffectation.DefFiltre(pPurchHeader."No.");
        pgListeDiversSansAffectation.RUNMODAL();
    end;

    [EventSubscriber(ObjectType::Codeunit, 415, OnAfterReleasePurchaseDoc, '', false, false)]
    local procedure CU415_OnAfterReleasePurchaseDoc(var PurchaseHeader: Record "Purchase Header")
    var
        AffectationsAchatsVente: Record "Affectations achat vente";
    begin
        //KAN.FHA 16/04/2020 DEBUT
        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then begin
            AffectationsAchatsVente.RESET();
            AffectationsAchatsVente.SETRANGE("No. document achat", PurchaseHeader."No.");
            if AffectationsAchatsVente.FINDSET(true) then
                repeat
                    if AffectationsAchatsVente."Statut commande achat" < AffectationsAchatsVente."Statut commande achat"::"Lancée" then begin
                        AffectationsAchatsVente."Statut commande achat" := AffectationsAchatsVente."Statut commande achat"::"Lancée";
                        AffectationsAchatsVente.MODIFY();
                    end;

                until AffectationsAchatsVente.NEXT() = 0;
        end;
        //KAN.FHA 16/04/2020 FIN

    end;

    [EventSubscriber(ObjectType::Codeunit, 415, OnAfterReopenPurchaseDoc, '', false, false)]
    local procedure CU415_OnAfterReopenPurchaseDoc(var PurchaseHeader: Record "Purchase Header")
    var
        AffectationsAchatsVente: Record "Affectations achat vente";
    begin
        //KAN.FHA 16/04/2020 DEBUT
        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then begin
            AffectationsAchatsVente.RESET();
            AffectationsAchatsVente.SETRANGE("No. document achat", PurchaseHeader."No.");
            if AffectationsAchatsVente.FINDSET(true) then
                repeat
                    if AffectationsAchatsVente."Statut commande achat" = AffectationsAchatsVente."Statut commande achat"::"Lancée" then begin
                        AffectationsAchatsVente."Statut commande achat" := AffectationsAchatsVente."Statut commande achat"::Ouverte;
                        AffectationsAchatsVente.MODIFY();
                    end;
                until AffectationsAchatsVente.NEXT() = 0;
        end;
        //KAN.FHA 16/04/2020 FIN
    end;

    [EventSubscriber(ObjectType::Codeunit, 1405, OnBeforePurchInvHeaderModify, '', false, false)]
    local procedure CU1405_OnBeforePurchInvHeaderModify(var PurchInvHeader: Record "Purch. Inv. Header"; PurchInvHeaderRec: Record "Purch. Inv. Header")
    begin
        PurchInvHeader."Pay-to Name" := PurchInvHeaderRec."Pay-to Name";
        PurchInvHeader."Pay-to Name 2" := PurchInvHeaderRec."Pay-to Name 2";
        PurchInvHeader."Pay-to Address" := PurchInvHeaderRec."Pay-to Address";
        PurchInvHeader."Pay-to Address 2" := PurchInvHeaderRec."Pay-to Address 2";
        PurchInvHeader."Pay-to Post Code" := PurchInvHeaderRec."Pay-to Post Code";
        PurchInvHeader."Pay-to City" := PurchInvHeaderRec."Pay-to City";
        PurchInvHeader."Pay-to Contact" := PurchInvHeaderRec."Pay-to Contact";
        PurchInvHeader."Pay-to Country/Region Code" := PurchInvHeaderRec."Pay-to Country/Region Code";
        PurchInvHeader."Buy-from Vendor Name" := PurchInvHeaderRec."Buy-from Vendor Name";
        PurchInvHeader."Buy-from Vendor Name 2" := PurchInvHeaderRec."Buy-from Vendor Name 2";
        PurchInvHeader."Buy-from Address" := PurchInvHeaderRec."Buy-from Address";
        PurchInvHeader."Buy-from Address 2" := PurchInvHeaderRec."Buy-from Address 2";
        PurchInvHeader."Buy-from Post Code" := PurchInvHeaderRec."Buy-from Post Code";
        PurchInvHeader."Buy-from City" := PurchInvHeaderRec."Buy-from City";
        PurchInvHeader."Buy-from Country/Region Code" := PurchInvHeaderRec."Buy-from Country/Region Code";
        PurchInvHeader."Buy-from Contact" := PurchInvHeaderRec."Buy-from Contact";
        PurchInvHeader."VAT Registration No." := PurchInvHeaderRec."VAT Registration No.";
        PurchInvHeader."Concernee DEB" := PurchInvHeaderRec."Concernee DEB";
    end;

    [EventSubscriber(ObjectType::Codeunit, 1409, OnOnRunOnBeforeTestFieldNo, '', false, false)] //"Sales Inv. Header - Edit"
    local procedure CU1409_OnOnRunOnBeforeTestFieldNo(var SalesInvoiceHeader: Record "Sales Invoice Header"; SalesInvoiceHeaderRec: Record "Sales Invoice Header")
    begin
        SalesInvoiceHeader."Bill-to Name" := SalesInvoiceHeaderRec."Bill-to Name";
        SalesInvoiceHeader."Bill-to Name 2" := SalesInvoiceHeaderRec."Bill-to Name 2";
        SalesInvoiceHeader."Bill-to Address" := SalesInvoiceHeaderRec."Bill-to Address";
        SalesInvoiceHeader."Bill-to Address 2" := SalesInvoiceHeaderRec."Bill-to Address 2";
        SalesInvoiceHeader."Bill-to Post Code" := SalesInvoiceHeaderRec."Bill-to Post Code";
        SalesInvoiceHeader."Bill-to City" := SalesInvoiceHeaderRec."Bill-to City";
        SalesInvoiceHeader."Bill-to Contact" := SalesInvoiceHeaderRec."Bill-to Contact";
        SalesInvoiceHeader."Bill-to Country/Region Code" := SalesInvoiceHeaderRec."Bill-to Country/Region Code";
        SalesInvoiceHeader."Sell-to Customer Name" := SalesInvoiceHeaderRec."Sell-to Customer Name";
        SalesInvoiceHeader."Sell-to Customer Name 2" := SalesInvoiceHeaderRec."Sell-to Customer Name 2";
        SalesInvoiceHeader."Sell-to Address" := SalesInvoiceHeaderRec."Sell-to Address";
        SalesInvoiceHeader."Sell-to Address 2" := SalesInvoiceHeaderRec."Sell-to Address 2";
        SalesInvoiceHeader."Sell-to Post Code" := SalesInvoiceHeaderRec."Sell-to Post Code";
        SalesInvoiceHeader."Sell-to City" := SalesInvoiceHeaderRec."Sell-to City";
        SalesInvoiceHeader."Sell-to Country/Region Code" := SalesInvoiceHeaderRec."Sell-to Country/Region Code";
        SalesInvoiceHeader."Sell-to Contact" := SalesInvoiceHeaderRec."Sell-to Contact";
        SalesInvoiceHeader."VAT Registration No." := SalesInvoiceHeaderRec."VAT Registration No.";
        SalesInvoiceHeader."Shipment Method Code" := SalesInvoiceHeaderRec."Shipment Method Code";
        SalesInvoiceHeader."Number Of Packages" := SalesInvoiceHeaderRec."Number Of Packages";
        SalesInvoiceHeader."Pallet Number" := SalesInvoiceHeaderRec."Pallet Number";
        SalesInvoiceHeader."Total Net Weight" := SalesInvoiceHeaderRec."Total Net Weight";
        SalesInvoiceHeader."Total Gross Weight" := SalesInvoiceHeaderRec."Total Gross Weight";
        SalesInvoiceHeader."Montant deja verse TTC" := SalesInvoiceHeaderRec."Montant deja verse TTC";
        SalesInvoiceHeader."External Document No." := SalesInvoiceHeaderRec."External Document No.";
        SalesInvoiceHeader."Ship-to Name" := SalesInvoiceHeaderRec."Ship-to Name";
        SalesInvoiceHeader."Ship-to Name 2" := SalesInvoiceHeaderRec."Ship-to Name 2";
        SalesInvoiceHeader."Ship-to Address" := SalesInvoiceHeaderRec."Ship-to Address";
        SalesInvoiceHeader."Ship-to Address 2" := SalesInvoiceHeaderRec."Ship-to Address 2";
        SalesInvoiceHeader."Ship-to City" := SalesInvoiceHeaderRec."Ship-to City";
        SalesInvoiceHeader."Ship-to Contact" := SalesInvoiceHeaderRec."Ship-to Contact";
        SalesInvoiceHeader."Ship-to Post Code" := SalesInvoiceHeaderRec."Ship-to Post Code";
        SalesInvoiceHeader."Ship-to Country/Region Code" := SalesInvoiceHeaderRec."Ship-to Country/Region Code";
        SalesInvoiceHeader."Concernee DEB" := SalesInvoiceHeaderRec."Concernee DEB";
    end;

    [EventSubscriber(ObjectType::Codeunit, 5063, OnAfterStoreSalesDocument, '', false, false)] //Archive management
    local procedure CU5063_OnAfterStoreSalesDocument(SalesHeader: Record "Sales Header"; var SalesHeaderArchive: Record "Sales Header Archive")
    begin
        SalesHeader.CalcFields(Amount);
        SalesHeaderArchive."Montant archive" := SalesHeader.Amount;
        SalesHeaderArchive.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, 5063, OnAfterStorePurchDocument, '', false, false)] //Archive management
    local procedure CU5063_OnAfterStorePurchDocument(var PurchaseHeader: Record "Purchase Header"; var PurchaseHeaderArchive: Record "Purchase Header Archive")
    begin
        PurchaseHeader.CalcFields(Amount);
        PurchaseHeaderArchive."Montant archive" := PurchaseHeader.Amount;
        PurchaseHeaderArchive.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, 5720, OnEnterSalesItemReferenceOnAfterFillDescriptionFromItemVariant, '', false, false)]
    local procedure CU5720_OnEnterSalesItemReferenceOnAfterFillDescriptionFromItemVariant(var SalesLine: Record "Sales Line";var ItemVariant: Record "Item Variant")
    var
        Article: Record Item;
    begin
        if not ItemVariant."Remplacer desi. sur vente" then 
            if Article.Get(SalesLine."No.") then
                SalesLine.Description := Article.Description;
    end;

    //Annuler réception
    [EventSubscriber(ObjectType::Codeunit, 5813, OnBeforePurchRcptLineModify, '', false, false)]
    local procedure CU5813_OnBeforePurchRcptLineModify(var PurchRcptLine: Record "Purch. Rcpt. Line")
    var
        EnteteReception: record "Purch. Rcpt. Header";
        MettreAJourContainer: Boolean;
    begin
        //KAN.FHA 31/08/2022 DEBUT
        MettreAJourContainer := false;
        EnteteReception.GET(PurchRcptLine."Document No.");
        if EnteteReception."No. container" <> '' then
            MettreAJourContainer := true;
        //KAN.FHA 31/08/2022 FIN

        //KAN.FHA 31/08/2022 DEBUT
        if MettreAJourContainer then
            MAJLigneContainer(EnteteReception, PurchRcptLine);
        //KAN.FHA 31/08/2022 FIN

    end;

    local procedure MAJLigneContainer(pEnteteReception: Record "Purch. Rcpt. Header"; pPurchRcptLine: Record 121);
    var
        LigneContainer: Record 50041;
    begin
        LigneContainer.SETCURRENTKEY("No. container", "No. commande achat");
        LigneContainer.SETRANGE("No. container", pEnteteReception."No. container");
        LigneContainer.SETRANGE("No. commande achat", pEnteteReception."Order No.");
        LigneContainer.SETRANGE("No. ligne commande achat", pPurchRcptLine."Order Line No.");
        if LigneContainer.FINDSET(true) then begin
            LigneContainer."Quantite recue" := LigneContainer."Quantite recue" - pPurchRcptLine."Quantity (Base)";
            LigneContainer."Quantite restante" := LigneContainer.Quantite - LigneContainer."Quantite recue";
            LigneContainer.MODIFY();
        end;
    end;

    //Annuler ligne BL
    [EventSubscriber(ObjectType::Codeunit, 5815, OnAfterNewSalesShptLineInsert, '', false, false)]
    local procedure CU5815_OnAfterNewSalesShptLineInsert(OldSalesShipmentLine: Record "Sales Shipment Line")
    begin
        dInsertWEEEShptLine(OldSalesShipmentLine);

    end;

    local procedure dInsertWEEEShptLine(pSalesShptLine: Record 111);
    var
        NewSalesShptLine: Record "Sales Shipment Line";
        OldSalesShptLine: Record "Sales Shipment Line";
    begin
        if (pSalesShptLine."Eco Tax Furniture Code" = '') then
            exit;
        if pSalesShptLine."Eco Tax Furniture Line" then
            exit;
        OldSalesShptLine.SETRANGE("Document No.", pSalesShptLine."Document No.");
        OldSalesShptLine.SETRANGE("Eco Tax Furniture Line", true);
        OldSalesShptLine.SETRANGE("Attached to Line No.", pSalesShptLine."Line No.");
        OldSalesShptLine.SETRANGE(Correction, false);
        if OldSalesShptLine.FINDFIRST() then begin
            NewSalesShptLine.INIT();
            NewSalesShptLine.COPY(OldSalesShptLine);
            NewSalesShptLine."Line No." := OldSalesShptLine."Line No." + 1;
            NewSalesShptLine.Quantity := -OldSalesShptLine.Quantity;
            NewSalesShptLine."Qty. Shipped Not Invoiced" := 0;
            NewSalesShptLine."Quantity (Base)" := -OldSalesShptLine."Quantity (Base)";
            NewSalesShptLine."Quantity Invoiced" := NewSalesShptLine.Quantity;
            NewSalesShptLine."Qty. Invoiced (Base)" := NewSalesShptLine."Quantity (Base)";
            NewSalesShptLine.Correction := true;
            NewSalesShptLine.INSERT();

            //UpdateOrderLine(OldSalesShptLine);
            OldSalesShptLine."Quantity Invoiced" := OldSalesShptLine.Quantity;
            OldSalesShptLine."Qty. Invoiced (Base)" := OldSalesShptLine."Quantity (Base)";
            OldSalesShptLine."Qty. Shipped Not Invoiced" := 0;
            OldSalesShptLine.Correction := true;
            OldSalesShptLine.MODIFY();
        end;
    end;


}

