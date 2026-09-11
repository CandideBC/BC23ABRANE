codeunit 50019 ConsommerEventsTables
{
    Permissions = TableData "Sales Shipment Line" = rm;

    trigger OnRun()
    begin
    end;

    [EventSubscriber(ObjectType::Table, 9, OnAfterInsertEvent, '', false, false)]

    local procedure CountryRegionOnInsert(var Rec: Record "Country/Region"; RunTrigger: Boolean)
    var
        EntryPointRecord: Record "Entry/Exit Point";
    begin
        if not EntryPointRecord.GET(Rec.Code) then begin
            EntryPointRecord.INIT();
            EntryPointRecord.Code := Rec.Code;
            EntryPointRecord.Description := Rec.Name;
            EntryPointRecord.INSERT();
        end;
    end;

    [EventSubscriber(ObjectType::Table, 9, OnAfterModifyEvent, '', false, false)]

    local procedure CountryRegionOnModify(var Rec: Record "Country/Region"; RunTrigger: Boolean)
    var
        EntryPointRecord: Record "Entry/Exit Point";
    begin
        if not EntryPointRecord.GET(Rec.Code) then begin
            EntryPointRecord.INIT();
            EntryPointRecord.Code := Rec.Code;
            EntryPointRecord.INSERT();
        end;
        EntryPointRecord.Description := Rec.Name;
        EntryPointRecord.MODIFY();
    end;


    [EventSubscriber(ObjectType::Table, 17, OnAfterCopyGLEntryFromGenJnlLine, '', false, false)]
    local procedure GLEntryOnAfterCopyGLEntryFromGenJnlLine(var GLEntry: Record "G/L Entry"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GLEntry."Code enseigne" := GenJournalLine."Code enseigne";
    end;



    [EventSubscriber(ObjectType::Table, 18, OnAfterInsertEvent, '', false, false)]
    local procedure CustomerOnAfterInsert(var Rec: Record Customer)
    var
        SalesSetup: Record "Sales & Receivables Setup";
        InfoSoc: Record "Company Information";
    begin
        //KAN.FHA 08/02/2021 DEBUT
        SalesSetup.GET();
        Rec."Reminder Terms Code" := SalesSetup."Code cond. relance par def.";
        Rec."Fin. Charge Terms Code" := SalesSetup."Code cond. interets par def.";
        //KAN.FHA 08/02/2021 FIN
        //KAN.FHA 04/03/2021 DEBUT
        Rec."Payment Method Code" := SalesSetup."Code mode reglement par def.";
        Rec."Allow Line Disc." := true;

        //KAN.FHA 13/03/25 DEBUT
        InfoSoc.get();
        Rec.Validate("Location Code", InfoSoc."Location Code");
        //KAN.FHA 13/03/25 FIN

        Rec.Modify();
        //KAN.FHA 04/03/2021 FIN
    end;

    [EventSubscriber(ObjectType::Table, 18, OnAfterValidateEvent, "Customer Price Group", false, false)]
    local procedure CustomerOnAfterValidateCustomerPriceGroup(var Rec: Record Customer)
    var
        StdSalesCode: Record "Standard Sales Code";
        CustStdSalesCode: Record "Standard Customer Sales Code";
    begin
        //KAN.FHA 14/05/2020 DEBUT
        if Rec."Customer Price Group" <> '' then begin

            StdSalesCode.SETRANGE("Groupe prix client", Rec."Customer Price Group");
            if StdSalesCode.FINDSET(false) then
                repeat
                    if not CustStdSalesCode.GET(Rec."No.", StdSalesCode.Code) then begin
                        CustStdSalesCode.INIT();
                        CustStdSalesCode."Customer No." := Rec."No.";
                        CustStdSalesCode.Code := StdSalesCode.Code;
                        CustStdSalesCode.INSERT();

                    end;
                until StdSalesCode.NEXT() = 0;
        end;
        //KAN.FHA 14/05/2020 FIN

    end;

    [EventSubscriber(ObjectType::Table, 18, OnAfterValidateEvent, "Country/Region Code", false, false)]
    local procedure CustomerOnAfterValidateCountry(var Rec: Record Customer)
    var
        Pays: Record "Country/Region";
    begin
        //KAN.FHA 29/09/2021 DEBUT
        if Pays.GET(Rec."Country/Region Code") then begin
            Rec."Language Code" := Pays."Language Code";
            //KAN.FHA 29/09/2021 FIN
            Rec."Eco Tax Furniture Liable" := Pays."Soumis eco-contribution";
        end;

    end;

    [EventSubscriber(ObjectType::Table, 18, OnAfterValidateEvent, "Customer Price Group", false, false)]
    local procedure Customer_OnAfterValidateCustomerPriceGroup(var Rec: Record Customer; var xRec: Record Customer)
    var

    begin
        IF (reC."Customer Price Group" <> xRec."Customer Price Group") and (xRec."Customer Price Group" <> '') then
            rec.SupprimerReferencesArticles();

        IF rec."Customer Price Group" <> '' then
            rec.DupliquerReferencesArticles();
    end;

    [EventSubscriber(ObjectType::Table, 18, OnAfterValidateEvent, "Language Code", false, false)]
    local procedure Customer_OnAfterValidateLanguageCode(var Rec: Record Customer; var xRec: Record Customer)
    var

    begin
        IF (reC."Customer Price Group" <> xRec."Customer Price Group") and (xRec."Customer Price Group" <> '') then
            rec.SupprimerReferencesArticles();

        IF rec."Customer Price Group" <> '' then
            rec.DupliquerReferencesArticles();
    end;

    [EventSubscriber(ObjectType::Table, 18, OnAfterValidateEvent, "Gen. Bus. Posting Group", false, false)]
    local procedure CustomerOnAfterValidateGenBusPostingGroup(var Rec: Record Customer)
    var
        GpteComptaMarche: Record "Gen. Business Posting Group";
    begin
        //KAN.FHA 12/03/2021 DEBUT
        if GpteComptaMarche.GET(Rec."Gen. Bus. Posting Group") then begin
            Rec."Eco Tax Furniture Liable" := GpteComptaMarche."Soumis Eco-Taxe";
            if Rec."Payment Terms Code" = '' then
                Rec."Payment Terms Code" := GpteComptaMarche."Code conditions de paiement";
            //rec.Modify();
        end;
        //KAN.FHA 12/03/2021 FIN
    end;

    [EventSubscriber(ObjectType::Table, 18, OnAfterValidateEvent, "Registration Number", false, false)]
    local procedure CustomerOnAfterValidateRegistrationNo(var Rec: Record Customer)
    var
        Client: Record Customer;
        SIRETDoublonErr: Label 'Le client %1 a le même N° SIRET', Comment = '%1 = N° client';
    begin
        if Rec."Registration Number" = '' then
            exit;

        Client.SetCurrentKey("Registration Number");
        Client.SetRange("Registration Number", Rec."Registration Number");
        Client.SetFilter("No.", '<>%1', Rec."No.");
        if Client.FindFirst() then
            Error(SIRETDoublonErr, Client."No.");
    end;

    [EventSubscriber(ObjectType::Table, 18, OnAfterValidateEvent, "VAT Registration No.", false, false)]
    local procedure CustomerOnAfterValidateVATRegNo(var Rec: Record Customer)
    var
        Client: Record Customer;
        NoTVADoublonErr: Label 'Le client %1 a le même N° TVA', Comment = '%1 = N° client';
    begin
        if Rec."VAT Registration No." = '' then
            exit;

        Client.SetCurrentKey("VAT Registration No.");
        Client.SetRange("Registration Number", Rec."Registration Number");
        Client.SetFilter("No.", '<>%1', Rec."No.");
        if Client.FindFirst() then
            Error(NoTVADoublonErr, Client."No.");
    end;

    [EventSubscriber(ObjectType::Table, 21, OnAfterCopyCustLedgerEntryFromGenJnlLine, '', false, false)]
    local procedure GLEntryOnAfterCopyCustLedgerFromGenJnlLine(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        //KAN.FHA 12/06/2020 DEBUT
        CustLedgerEntry."Facture acompte" := GenJournalLine."Facture acompte";
        CustLedgerEntry."Code groupe" := GenJournalLine."Code groupe";
        CustLedgerEntry."Nouveau Code enseigne" := GenJournalLine."Code enseigne";
        CustLedgerEntry."Code operation" := GenJournalLine."Code operation";
        CustLedgerEntry."Code chantier" := GenJournalLine."Code chantier";
        //KAN.FHA 12/06/2020 FIN
    end;

    [EventSubscriber(ObjectType::Table, 23, OnAfterValidateEvent, "Country/Region Code", false, false)]
    local procedure VendorOnAfterValidateCountryCode(var Rec: Record Vendor)
    var
        CompanyInfo: Record "Company Information";
        Pays: Record "Country/Region";
    begin
        //KAN.FHA 02/06/2021 DEBUT
        if (CompanyInfo."Country/Region Code" <> Rec."Country/Region Code") and (Rec."Country/Region Code" <> '') then begin
            Rec."Suivi container" := true;
            Rec.Modify();
        end;
        //KAN.FHA 02/06/2021 FIN

        if Pays.GET(Rec."Country/Region Code") then
            Rec."Language Code" := Pays."Language Code";
    end;

    [EventSubscriber(ObjectType::Table, 23, OnAfterValidateEvent, "Registration Number", false, false)]
    local procedure VendorOnAfterValidateRegistrationNo(var Rec: Record Vendor)
    var
        Fournisseur: Record Vendor;
        SIRETDoublonErr: Label 'Le fournisseur %1 a le même N° SIRET', Comment = '%1 = N° fournisseur';
    begin
        if Rec."Registration Number" = '' then
            exit;

        Fournisseur.SetCurrentKey("Registration Number");
        Fournisseur.SetRange("Registration Number", Rec."Registration Number");
        Fournisseur.SetFilter("No.", '<>%1', Rec."No.");
        if Fournisseur.FindFirst() then
            Error(SIRETDoublonErr, Fournisseur."No.");
    end;

    [EventSubscriber(ObjectType::Table, 23, OnAfterValidateEvent, "VAT Registration No.", false, false)]
    local procedure VendorOnAfterValidateVATRegNo(var Rec: Record Vendor)
    var
        Fournisseur: Record Vendor;
        SIRETDoublonErr: Label 'Le fournisseur %1 a le même N° SIRET', Comment = '%1 = N° fournisseur';
    begin
        if Rec."VAT Registration No." = '' then
            exit;

        Fournisseur.SetCurrentKey("VAT Registration No.");
        Fournisseur.SetRange("VAT Registration No.", Rec."VAT Registration No.");
        Fournisseur.SetFilter("No.", '<>%1', Rec."No.");
        if Fournisseur.FindFirst() then
            Error(SIRETDoublonErr, Fournisseur."No.");
    end;

    [EventSubscriber(ObjectType::Table, 27, OnAfterInsertEvent, '', false, false)]
    local procedure ItemOnAfterInsert(var Rec: Record Item)
    var

    begin
        Rec."Costing Method" := Rec."Costing Method"::Average;
        Rec.Modify();
    end;

    [EventSubscriber(ObjectType::Table, 27, OnAfterValidateEvent, "Vendor No.", false, false)]
    local procedure ItemOnAfterValidateVendorNo(var Rec: Record Item; var xRec: Record Item)
    var
        VendorRecord: Record Vendor;

    begin
        //DIANBE 23/12/2014 DEBUT
        Rec."Country/Region of Origin Code" := '';

        if (xRec."Vendor No." <> Rec."Vendor No.") and
            (Rec."Vendor No." <> '')
        then
            if VendorRecord.GET(Rec."Vendor No.") then begin
                Rec."Country/Region of Origin Code" := VendorRecord."Country/Region Code";
                Rec.Modify();
            end;
        //DIANBE 23/12/2014 FIN
    end;

    [EventSubscriber(ObjectType::Table, 27, OnAfterValidateEvent, "Vendor No.", false, false)]
    local procedure ItemOnAfterValidateNetWeight(var Rec: Record Item; var xRec: Record Item)
    var

    begin
        //DIANBE 23/12/2014 DEBUT
        Rec."Gross Weight" := Rec."Net Weight";
        Rec.Modify();
        //DIANBE 23/12/2014 FIN
    end;

    [EventSubscriber(ObjectType::Table, 36, OnAfterDeleteEvent, '', false, false)]
    local procedure SalesHeaderOnAfterDelete(var Rec: Record "Sales Header")
    var
        EnteteVente: record "Sales Header";
        DossierBE: Record "Dossier BE";
        LigneFicheBE: Record "Ligne fiche BE";
        LigneFicheBE2: Record "Ligne fiche BE";
        PhasesDocument: Record "Phases document";
    begin
        //KAN.FHA 09/06/2020 DEBUT Gestion des acomptes
        if Rec."Facture acompte" and (Rec."Acompte pour No. document" <> '') then
            if EnteteVente.GET(Rec."Acompte pour type doc.", Rec."Acompte pour No. document") then
                if EnteteVente."No. facture acompte enregistre" = '' then begin
                    EnteteVente."No. facture acompte" := '';
                    if Rec."Acompte pour type doc." = Rec."Acompte pour type doc."::Commande then
                        EnteteVente."Acompte a creer" := true;
                    EnteteVente.MODIFY();
                end;
        //KAN.FHA 09/06/2020 FIN
        //KAN.FHA 24/06/2025 DEBUT
        if rec."No. dossier BE" <> '' then
            if DossierBE.get(Rec."No. dossier BE") then begin
                //Si aucune ligne n'a encore ete entamée par le BE, on supprime la fiche et les lignes 
                LigneFicheBE.SetRange("No. dossier BE", DossierBE."No.");
                LigneFicheBE.SetFilter("Statut ligne", '<>%1', LigneFicheBE."Statut ligne"::" ");
                if LigneFicheBE.IsEmpty then begin
                    LigneFicheBE.Setrange("Statut ligne");
                    LigneFicheBE.DeleteAll();
                    DossierBE.Delete();
                end else begin
                    //Au moins une des lignes a été "travaillée" par le BE.
                    //On va mettre les lignes travaillées au statut "Annulée" et les lignes non travaillées on les supprime
                    //La fiche BE passe au statut Annulé et ne garde donc que les lignes qui avaient ete travaillées
                    LigneFicheBE.Setrange("Statut ligne");
                    if LigneFicheBE.FindSet() then
                        repeat
                            if LigneFicheBE."Statut ligne" = LigneFicheBE."Statut ligne"::" " then begin
                                LigneFicheBE2.get(LigneFicheBE."No. dossier BE", LigneFicheBE."No. ligne");
                                LigneFicheBE2.Delete();
                            end else
                                if LigneFicheBE."Statut ligne" <> LigneFicheBE."Statut ligne"::"Terminé" then begin
                                    LigneFicheBE."Statut ligne" := LigneFicheBE."Statut ligne"::"Annnulé";
                                    LigneFicheBE.Modify();
                                end;
                        until LigneFicheBE.Next() = 0;
                    DossierBE.Annule := true;
                    DossierBE.Modify();
                end;
            end;
        //KAN.FHA 24/06/2025 FIN

        //KAN.FHA 28/10/2025 DEBUT
        if Rec."Document Type" in [Rec."Document Type"::Quote, Rec."Document Type"::Order] then begin
            PhasesDocument.SetRange("Type document", PhasesDocument."Type document");
            PhasesDocument.SetRange("No. document", Rec."No.");
            PhasesDocument.DeleteAll();
        end;
        //KAN.FHA 28/10/2025 FIN
    end;

    [EventSubscriber(ObjectType::Table, 36, OnAfterInitRecord, '', false, false)]
    local procedure SalesHeaderOnAfterInitRecord(var SalesHeader: Record "Sales Header")
    var
        ParamVente: Record "Sales & Receivables Setup";
        Vendeur: Record "Salesperson/Purchaser";
    begin
        ParamVente.GET();
        //KAN.FHA 23/01/2023 DEBUT
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then
            SalesHeader."Annee commande" := DATE2DMY(SalesHeader."Order Date", 3)
        else
            if SalesHeader."Document Type" = SalesHeader."Document Type"::Quote then
                SalesHeader."Annee commande" := DATE2DMY(TODAY, 3);

        //KAN.FHA 24/08/2022 DEBUT
        if SalesHeader."Document Type" in [SalesHeader."Document Type"::Quote, SalesHeader."Document Type"::Order] then begin
            SalesHeader."Transaction Type" := ParamVente."Nature transaction vente";
            SalesHeader.Area := ParamVente."Departement destination";
            SalesHeader."Transaction Specification" := ParamVente."Regime vente";
            //KAN.FHA 03/02/2026 DEBUT
            Vendeur.SetRange("Code utilisateur lie", UserId);
            if Vendeur.FindFirst() then
                SalesHeader.Validate("Salesperson Code", Vendeur.Code);
            //KAN.FHA 03/02/2026 FIN
        end;
        //KAN.FHA 24/08/2022 fin

        SalesHeader."Posting Description" := SalesHeader."Bill-to Name";
        //KAN.FHA 23/01/2023 FIN
    end;

    [EventSubscriber(ObjectType::Table, 36, OnAfterRecreateSalesLines, '', false, false)]
    local procedure SalesHeaderOnAfterRecreateSalesLines(SalesHeader: Record "Sales Header")
    var
        LigneVente: Record "Sales Line";
        WEEEMgt: Codeunit "Gestion Ecopart";
    begin
        LigneVente.RESET();
        LigneVente.SETRANGE("Document Type", SalesHeader."Document Type");
        LigneVente.SETRANGE("Document No.", SalesHeader."No.");

        LigneVente.SETRANGE(Type, LigneVente.Type::Item);
        if LigneVente.FINDSET(true) then
            repeat

                if LigneVente.Type = LigneVente.Type::Item then
                    if WEEEMgt.SalesCheckIfAnyWEEE(LigneVente) then
                        WEEEMgt.InsertWEEELine(LigneVente);

            until LigneVente.NEXT() = 0;

    end;

    [EventSubscriber(ObjectType::Table, 36, OnAfterSelltoCustomerNoOnAfterValidate, '', false, false)]
    local procedure SalesHeaderOnAfterSelltoCustomerNoOnAfterValidate(var SalesHeader: Record "Sales Header")
    var
        Client: record Customer;
    begin
        if Client.GET(SalesHeader."Sell-to Customer No.") then begin
            Client.TESTFIELD("Country/Region Code");
            //KAN.FHA 20/04/2026 DEBUT
            Client.TestField("Payment Terms Code");
            //KAN.FHA 20/04/2026 FIN
            SalesHeader."Eco Tax Furniture Liable" := Client."Eco Tax Furniture Liable";
            SalesHeader."Price included Eco Tax" := Client."Price Included Eco Tax";

            if Client."Code enseigne" <> '' then
                SalesHeader.VALIDATE("Code enseigne", Client."Code enseigne");

            SalesHeader.DefinirConditionsPaiement();

            SalesHeader.Modify();

        end;
    end;

    [EventSubscriber(ObjectType::Table, 36, OnAfterValidateEvent, "Sell-to Customer No.", false, false)]
    local procedure SalesHeaderOnAfterValidateSellToCustNo(var Rec: Record "Sales Header"; var xRec: Record "Sales Header")
    var
    begin
        if (xRec."Salesperson Code" <> '') and (Rec."Salesperson Code" = '') then begin
            Rec."Salesperson Code" := xRec."Salesperson Code";
            rec.Modify();
        end;
    end;


    [EventSubscriber(ObjectType::Table, 36, OnAfterValidateEvent, "Bill-to Customer No.", false, false)]
    local procedure SalesHeaderOnAfterValidateBillToCustNo(var Rec: Record "Sales Header"; var xRec: Record "Sales Header")
    var
        Client: record customer;
        GenBusPostingGrp: Record "Gen. Business Posting Group";
    begin
        if Client.GET(rec."Bill-to Customer No.") then begin
            Rec."Posting Description" := Client.Name;
            Rec.Factoring := Client.Factoring;
            Rec."Factor Code" := Client."Factor Code";

            Rec."Eco Tax Furniture Liable" := Client."Eco Tax Furniture Liable";
            Rec."Price included Eco Tax" := Client."Price Included Eco Tax";

            //KAN.FHA 12/03/2021 DEBUT
            if (Rec."Payment Terms Code" = '') and (Rec."Document Type" in [Rec."Document Type"::Quote, Rec."Document Type"::Order]) then
                if GenBusPostingGrp.GET(Rec."Gen. Bus. Posting Group") then
                    Rec."Payment Terms Code" := GenBusPostingGrp."Code conditions de paiement";
            //KAN.FHA 12/03/2021 FIN

            Rec.Modify();
        end;

    end;

    [EventSubscriber(ObjectType::Table, 36, OnAfterSetFieldsBilltoCustomer, '', false, false)]
    local procedure SalesHeader_OnAfterSetFieldsBilltoCustomer(var SalesHeader: Record "Sales Header"; Customer: Record Customer)
    begin
        SalesHeader."Prepayment %" := 0;
        SalesHeader."% acompte demande" := Customer."Prepayment %";
    end;

    [EventSubscriber(ObjectType::Table, 36, OnAfterValidateEvent, "Bill-to Name", false, false)]
    local procedure SalesHeaderOnAfterValidateBillToName(var Rec: Record "Sales Header"; var xRec: Record "Sales Header")
    var
    begin
        Rec."Posting Description" := Rec."Bill-to Name";
        Rec.Modify();
    end;

    [EventSubscriber(ObjectType::Table, 36, OnBeforeCopyShipToCustomerAddressFieldsFromShipToAddr, '', false, false)]
    local procedure SalesHeaderOnBeforeCopyShipToCustomerAddressFieldsFromCustomer(ShipToAddress: Record "Ship-to Address")
    var
    begin
        //KAN.FHA 18/04/2023 DEBUT
        ShipToAddress.TESTFIELD("Country/Region Code");
        //KAN.FHA 18/04/2023 FIN

    end;

    [EventSubscriber(ObjectType::Table, 36, OnAfterCopyShipToCustomerAddressFieldsFromShipToAddr, '', false, false)]
    local procedure SalesHeaderOnAfterCopyShipToCustomerAddressFieldsFromShipToAddr(var SalesHeader: Record "Sales Header"; ShipToAddress: Record "Ship-to Address")
    var

    begin
        SalesHeader."No. And Location Name" := ShipToAddress."No. And Location Name";

        if SalesHeader."Ship-to Code" <> '' then
            if (SalesHeader."Document Type" <> SalesHeader."Document Type"::"Return Order") and (SalesHeader."Document Type" <> SalesHeader."Document Type"::"Blanket Order") then
                if ShipToAddress."Adresse de facturation" then begin
                    SalesHeader."Bill-to Name" := ShipToAddress.Name;
                    SalesHeader."Bill-to Name 2" := ShipToAddress."Name 2";
                    SalesHeader."Bill-to Address" := ShipToAddress.Address;
                    SalesHeader."Bill-to Address 2" := ShipToAddress."Address 2";
                    SalesHeader."Bill-to City" := ShipToAddress.City;
                    SalesHeader."Bill-to Post Code" := ShipToAddress."Post Code";
                    SalesHeader."Bill-to County" := ShipToAddress.County;
                    SalesHeader.VALIDATE("Bill-to Country/Region Code", ShipToAddress."Country/Region Code");
                    SalesHeader."Bill-to Contact" := ShipToAddress.Contact;
                end;
        SalesHeader.Modify();
    end;

    [EventSubscriber(ObjectType::Table, 36, OnAfterValidateEvent, "Posting Date", false, false)]
    local procedure SalesHeaderOnAfterValidatePostingDate(var Rec: Record "Sales Header"; var xRec: Record "Sales Header")
    var
        Enseigne: Record Enseigne;
    begin
        //KAN.FHA 12/01/2022 DEBUT
        if Enseigne.GET(Rec."Code enseigne") then
            if Enseigne."Enseigne interne" then begin
                Rec."Code chantier" := Enseigne.ChantierAnnuel(Rec."Posting Date");
                Rec.Modify();
            end;
        //KAN.FHA 12/01/2022 FIN
    end;

    [EventSubscriber(ObjectType::Table, 36, OnAfterValidateEvent, "Location Code", false, false)]
    local procedure SalesHeaderOnAfterValidateLocationCode(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        LigneVente: Record "Sales Line";
        ChangerMagasinQst: Label 'Souhaitez-vous mettre à jour les lignes avec le code magasin %1 ?', Comment = '%1 = Code magasin';
    begin
        if CurrFieldNo = Rec.FIELDNO("Location Code") then
            if CONFIRM(STRSUBSTNO(ChangerMagasinQst, Rec."Location Code")) then begin
                LigneVente.RESET();
                LigneVente.SETRANGE("Document Type", Rec."Document Type");
                LigneVente.SETRANGE("Document No.", Rec."No.");
                LigneVente.SETFILTER(Type, '<>0');
                LigneVente.SETFILTER("Location Code", '<>%1', Rec."Location Code");
                if LigneVente.FINDSET(true) then
                    repeat
                        LigneVente."Location Code" := Rec."Location Code";
                        //FHA Migration LigneVente.fctSetFieldNo(7);
                        LigneVente.CheckItemAvailable(7);
                        //KAN.FHA 11/09/2020 DEBUT
                        if LigneVente.Type = LigneVente.Type::Item then
                            LigneVente.GetUnitCost();
                        //KAN.FHA 11/09/2020 FIN
                        LigneVente.MODIFY();//(True);
                        COMMIT();
                    until LigneVente.NEXT() = 0;
            end else
                Rec.MessageIfSalesLinesExist(copystr(Rec.FIELDCAPTION("Location Code"), 1, 100));
    end;

    [EventSubscriber(ObjectType::Table, 36, OnAfterValidateEvent, "Ship-to Country/Region Code", false, false)]
    local procedure SalesHeaderOnAfterValidateShipToCountryCode(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        InfoSoc: Record "Company Information";
    begin
        //KAN.FHA 24/08/2022 DEBUT
        Rec.VALIDATE("Exit Point", Rec."Ship-to Country/Region Code");
        Rec.Modify();
        //KAN.FHA 24/08/2022 FIN
        //KAN.FHA 28/04/2026 DEBUT
        if not InfoSoc.Get() then
            InfoSoc.Init();
        Rec."Commande export" := not ((Rec."Ship-to Country/Region Code" = '') or (Rec."Ship-to Country/Region Code" = InfoSoc."Country/Region Code"));
        //KAN.FHA 28/04/2026 FIN
    end;

    [EventSubscriber(ObjectType::Table, 36, OnAfterValidateEvent, "External Document No.", false, false)]
    local procedure SalesHeaderOnAfterValidateExternalDocNo(var Rec: Record "Sales Header")
    var
        EnteteVente: Record "Sales Header";
        PhasesDocument: Record "Phases document";
        Text50000Qst: Label 'Ce numéro de document externe est déjà saisi sur la commande %1. Voulez-vous consulter cette commande ?', Comment = '%1 = N° commande';

    begin
        //DIALBO 28/10/2016
        if (Rec."Document Type" = Rec."Document Type"::Order) and (Rec."External Document No." <> '') then begin
            EnteteVente.SETCURRENTKEY("Sell-to Customer No.", "External Document No.");
            EnteteVente.SETRANGE("Sell-to Customer No.", Rec."Sell-to Customer No.");
            EnteteVente.SETRANGE("External Document No.", Rec."External Document No.");
            EnteteVente.SETRANGE("Document Type", EnteteVente."Document Type"::Order);
            EnteteVente.SETFILTER("No.", '<>%1', Rec."No.");
            if EnteteVente.FINDFIRST() then
                if GUIALLOWED and CONFIRM(STRSUBSTNO(Text50000Qst, EnteteVente."No.")) then
                    PAGE.RUN(Page::"Sales Order", EnteteVente);
        end;
        //DIALBO 28/10/2016
        PhasesDocument.SetRange("Type document", PhasesDocument."Type document"::Quote);
        PhasesDocument.SetRange("No. document", Rec."No.");
        PhasesDocument.ModifyAll("No. doc externe", Rec."External Document No.");
    end;

    [EventSubscriber(ObjectType::Table, 36, OnAfterValidateEvent, "Requested Delivery Date", false, false)]
    local procedure SalesHeaderOnAfterValidateRequestedDeliveryDate(var Rec: Record "Sales Header"; var xRec: Record "Sales Header")
    var
        Pays: Record "Country/Region";
        DemanderConfirm: Boolean;
        NouvelleDate: date;
        ConfirmQst: Label 'En changeant la date de livraison demandée, la date de chargement théorique devrait être au %1.\Voulez-vous modifier la date de chargement ?', Comment = '%1 = Nouvelle date de chargement';
        DelaiTransit: Text;
        DelaiTransitLbl: Label '<-%1D>', Comment = '%1 = nombre de jours';
        JourSemaine: Integer;
    begin
        //KAN.FHA 15/01/2026 DEBUT
        /*FHA L'année commande doit etre calculée sur la date de chargement maintenant, code déplacé vers l'OnValidate(Date chargement)
        //KAN.FHA 23/11/2023 DEBUT
        Rec."Annee commande" := DATE2DMY(Rec."Requested Delivery Date", 3);
        SalesLine.Reset();
        SalesLine.SetRange("Document Type", Rec."Document Type");
        SalesLine.SetRange("Document No.", Rec."No.");
        if SalesLine.FindSet(true) then
            SalesLine.ModifyAll("Annee commande", Rec."Annee commande");
        //KAN.FHA 23/11/2023 FIN
        FHA*/
        //KAN.FHA 15/01/2026 FIN

        //KAN.FHA 02/06/2025 DEBUT
        if Rec."Document Type" in [Rec."Document Type"::Quote, Rec."Document Type"::Order] then begin
            if Rec."Requested Delivery Date" = 0D then
                exit;

            if not pays.get(rec."Ship-to Country/Region Code") then
                Pays.Init();

            Pays.TestField("Delai transit (jours)");
            DelaiTransit := StrSubstNo(DelaiTransitLbl, Pays."Delai transit (jours)");
            NouvelleDate := CalcDate(DelaiTransit, Rec."Requested Delivery Date");
            JourSemaine := Date2DWY(NouvelleDate, 1);
            //On veut une date de chargement qui ne soit pas un samedi ou un dimanche
            while JourSemaine > 5 do begin
                NouvelleDate := CalcDate('<-1D>', NouvelleDate);
                JourSemaine := Date2DWY(NouvelleDate, 1);
            end;

            DemanderConfirm := (xrec."Requested Delivery Date" <> 0D);
            if DemanderConfirm then
                if not confirm(ConfirmQst, false, NouvelleDate) then
                    exit;

            rec.Validate("Date chargement", NouvelleDate);

        end;
        //KAN.FHA 02/06/2025 FIN
    end;

    [EventSubscriber(ObjectType::Table, 36, OnAfterValidateEvent, "Salesperson Code", false, false)]
    local procedure SalesHeader_OnAfterValidateSalespersonCode(var Rec: Record "Sales Header")
    var
        PhasesDocument: Record "Phases document";
    begin
        PhasesDocument.SetRange("Type document", PhasesDocument."Type document"::Quote);
        PhasesDocument.SetRange("No. document", Rec."No.");
        PhasesDocument.ModifyAll("Code vendeur", Rec."Salesperson Code");
    end;

    [EventSubscriber(ObjectType::Table, 36, OnAfterValidateEvent, "External Document No.", false, false)]
    local procedure SalesHeader_OnAfterValidateExtDocNo(var Rec: Record "Sales Header")
    var
        PhasesDocument: Record "Phases document";
    begin
        //KAN.FHA 27/10/2025 DEBUT
        if Rec."Document Type" in [Rec."Document Type"::Quote, Rec."Document Type"::Order] then begin
            PhasesDocument.SetRange("Type document", PhasesDocument."Type document");
            PhasesDocument.SetRange("No. document", Rec."No.");
            if PhasesDocument.FindSet(true) then
                repeat
                    PhasesDocument."Code chantier" := Rec."Code chantier";
                    PhasesDocument.Modify();
                until PhasesDocument.Next() = 0;
        end;
        //KAN.FHA 27/10/2025 FIN
    end;

    [EventSubscriber(ObjectType::Table, 36, OnAfterValidateEvent, "Payment Terms Code", false, false)]
    local procedure SalesHeader_OnAfterValidatePaymentTerms(var Rec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        ParamUtil: Record "User Setup";
        PasAutoriseErr: Label 'Vous n''êtes pas autorisé(e) à modifier ce champ.';
    begin
        if not (rec."Document Type" in [Rec."Document Type"::Quote, Rec."Document Type"::Order]) then
            exit;

        if CurrFieldNo = Rec.FieldNo("Payment Terms Code") then begin
            if not ParamUtil.get(UserId) then
                ParamUtil.Init();
            if not ParamUtil."MAJ Cond. pmnt/Devis+Cde" then
                error(PasAutoriseErr);
        end;
    end;

    [EventSubscriber(ObjectType::Table, 37, OnBeforeDeleteEvent, '', false, false)]
    local procedure SalesLineOnBeforeDeleteEvent(var Rec: Record "Sales Line")
    var
        LigneVente2: Record "Sales Line";
        lrecPurchaseLine: Record "Purchase Line";
        ContenuColisage: Record "Contenu colisage";
        Text50001Err: Label 'Vous ne pouvez pas supprimer une ligne "Composant".';
    begin
        //KAN.FHA 03/04/2025 DEBUT
        if Rec.IsTemporary then
            exit;
        //KAN.FHA 03/04/2025 FIN

        if (Rec."Linked to line" <> 0) and not rec.GetHideValidationDialog() then begin
            LigneVente2.RESET();
            LigneVente2.SETCURRENTKEY("Document Type", "Blanket Order No.", "Blanket Order Line No.");
            LigneVente2.SETRANGE("Document No.", Rec."Document No.");
            LigneVente2.SETRANGE("Document Type", Rec."Document Type");
            LigneVente2.SETRANGE("Line No.", Rec."Linked to line");
            LigneVente2.SETRANGE("No.", Rec."BOM Item No.");
            if not LigneVente2.IsEmpty then
                ERROR(Text50001Err);
        end;

        if (Rec."Line No." <> 0) and (Rec."Ligne eclatee") then begin
            LigneVente2.RESET();
            LigneVente2.SETCURRENTKEY("Document Type", "Document No.", "Linked to line");
            LigneVente2.SETRANGE("Document Type", Rec."Document Type");
            LigneVente2.SETRANGE("Document No.", Rec."Document No.");
            LigneVente2.SETRANGE("Linked to line", Rec."Line No.");
            if LigneVente2.FINDSET(true) then
                repeat
                    LigneVente2.SetHideValidationDialog(true);
                    LigneVente2.DELETE(true);
                    LigneVente2.SetHideValidationDialog(false);
                until LigneVente2.NEXT() = 0;
        end;

        if Rec."Special Order" and lrecPurchaseLine.GET(lrecPurchaseLine."Document Type"::Order, rec."Special Order Purchase No.", Rec."Special Order Purch. Line No.") then begin
            lrecPurchaseLine."Special Order" := false;
            lrecPurchaseLine."Special Order Sales No." := '';
            lrecPurchaseLine."Special Order Sales Line No." := 0;
            lrecPurchaseLine.MODIFY();
        end;

        //KAN.FHA 03/02/2026 DEBUT
        if Rec."Document Type" = Rec."Document Type"::Order then begin
            ContenuColisage.SetCurrentKey("Order No.", "Order Line No.");
            ContenuColisage.SetRange("Order No.", Rec."Document No.");
            ContenuColisage.SetRange("Order Line No.", Rec."Line No.");
            ContenuColisage.SetRange("Shipment No.", '');
            ContenuColisage.DeleteAll();
        end;
        //KAN.FHA 03/02/2026 FIN
    end;

    [EventSubscriber(ObjectType::Table, 37, OnAfterDeleteEvent, '', false, false)]
    local procedure SalesLine_OnAfterDeleteEvent(var Rec: Record "Sales Line"; RunTrigger: Boolean)
    //var
    //    PhasageLigneVente: Record "Phasage ligne vente";
    begin
        //Ne surtout pas mettre le code de suppression du phasage dans l'event SalesLine_OnAfterDeleteEvent car la suppression a lieu pas uniquement 
        //dans le cas d'un delete normal
        /*
        if not (Rec."Document Type" in [Rec."Document Type"::Quote, Rec."Document Type"::Order]) then
            exit;

        if Rec."Document Type" = Rec."Document Type"::Quote then
            PhasageLigneVente.Setrange("Type document", PhasageLigneVente."Type document"::"Devis vente")
        else
            PhasageLigneVente.Setrange("Type document", PhasageLigneVente."Type document"::"Commande vente");

        PhasageLigneVente.SetRange("No. document", Rec."Document No.");
        PhasageLigneVente.DeleteAll();
        */

    end;

    [EventSubscriber(ObjectType::Table, 37, OnValidateTypeOnCopyFromTempSalesLine, '', false, false)]
    local procedure SalesLineOnValidateTypeOnCopyFromTempSalesLine(var SalesLine: Record "Sales Line"; var TempSalesLine: Record "Sales Line" temporary)
    begin
        //KAN.FHA 14/05/2020 DEBUT
        SalesLine."Type ligne" := TempSalesLine."Type ligne";
        //KAN.FHA 14/05/2020 FIN
        //KAN.FHA 03/12/2025 DEBUT
        SalesLine."Type Fiche BE" := TempSalesLine."Type Fiche BE";
        SalesLine.Phase := TempSalesLine.Phase;
        //message('OnValidateTypeOnCopyFromTempSalesLine ' + format(SalesLine.Phase));
        //KAN.FHA 03/12/2025 FIN
    end;

    [EventSubscriber(ObjectType::Table, 37, OnBeforeValidateNo, '', false, false)]
    local procedure SalesLineOnBeforeValidateNo(SalesLine: Record "Sales Line"; CurrentFieldNo: Integer)
    var
        Text50000Err: Label 'Vous ne pouvez pas modifier le champ suivant pour une ligne "Composant". : ';
        ErrorTxt: Text;
    begin
        //DIA.ABRA.BOM SCH 17/03/2015 DEBUT
        if (CurrentFieldNo = SalesLine.FIELDNO("No.")) and (SalesLine."Linked to line" <> 0) then begin
            ErrorTxt := Text50000Err + ' ' + SalesLine.FIELDCAPTION("No.");
            ERROR(ErrorTxt);
        end;
        //DIA.ABRA.BOM SCH 17/03/2015 FIN
    end;

    [EventSubscriber(ObjectType::Table, 37, OnValidateNoOnAfterInitHeaderDefaults, '', false, false)]
    local procedure SalesLineOnValidateNoOnAfterInitHeaderDefaults(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    begin
        if not SalesHeader."Devis Stock" then begin
            SalesHeader.TestField("Code chantier");
            SalesHeader.TestField("Code groupe");
            SalesHeader.TestField("Code enseigne");
        end;

        SalesLine."Code groupe" := SalesHeader."Code groupe";
        SalesLine."Code enseigne" := SalesHeader."Code enseigne";
        SalesLine."Code operation" := SalesHeader."Code operation";
        SalesLine."Code chantier" := SalesHeader."Code chantier";
        SalesLine.TypeDocDuplique := SalesHeader."Document Type";
        SalesLine.NumDocDuplique := SalesHeader."No.";

        if SalesLine."Document Type" in [SalesLine."Document Type"::Order, SalesLine."Document Type"::"Return Order"] then
            SalesHeader.TESTFIELD("Salesperson Code");
        SalesLine."Salesperson Code" := SalesHeader."Salesperson Code";
        SalesLine."Reason Code" := SalesHeader."Reason Code";
        SalesLine."Return Reason Code" := SalesHeader."Return Reason Code";
        SalesLine.SAV := SalesHeader.ASS;
        if SalesLine."Document Type" = SalesLine."Document Type"::Order then
            SalesLine."Annee commande" := SalesHeader."Annee commande";

        SalesLine."Released Status" := (SalesHeader.Status = SalesHeader.Status::Released);
        SalesLine."Price included Eco Tax" := SalesHeader."Price included Eco Tax";
    end;

    [EventSubscriber(ObjectType::Table, 37, OnAfterAssignGLAccountValues, '', false, false)]
    local procedure SalesLineOnAfterAssignGLAccountValues(var SalesLine: Record "Sales Line"; GLAccount: Record "G/L Account")
    begin
        SalesLine."Exclure de la rentabilite" := GLAccount."Exclure de la rentabilite";
        SalesLine."Nature vente" := SalesLine."Nature vente"::Indéfini;
    end;

    [EventSubscriber(ObjectType::Table, 37, OnBeforeCopyFromItem, '', false, false)]
    local procedure SalesLine_OnBeforeCopyFromItem(var SalesLine: Record "Sales Line"; Item: Record Item)
    var
        Matiere: Record Matiere;
    begin
        if item."Poids obligatoire" then begin
            Item.TestField("Code matiere");
            Item.TestField("Tariff No.");
            Item.TestField("Country/Region of Origin Code");
        end;

        If Matiere.get(Item."Code matiere") then
            if Matiere."Code eco-taxe obligatoire" then
                Item.TestField("Eco Tax Furniture Code");

        if not item."Miscellaneous Item" then
            Item.TestField("Net Weight");
    end;

    [EventSubscriber(ObjectType::Table, 37, OnCopyFromItemOnAfterCheck, '', false, false)]
    local procedure SalesLineOnCopyFromItemOnAfterCheck(var SalesLine: Record "Sales Line"; Item: Record Item)
    var
        Fournisseur: Record Vendor;
        EnteteVente: Record "Sales Header";
        PhaseDocument: Record "Phases document";
        TypeDocPhase: Enum "Sales Document Type";
    begin
        SalesLine."Prix bloque" := Item."Prix bloque";

        SalesLine."Article divers" := Item."Miscellaneous Item";

        if SalesLine."Article divers" then
            if (Item."Nature vente" = Item."Nature vente"::Mobilier) then
                SalesLine."Type Fiche BE" := SalesLine."Type Fiche BE"::"BE Abrane";

        Item.CalcFields("Assembly BOM");
        SalesLine."Article nomenclature" := Item."Assembly BOM";
        if SalesLine."Article divers" or Item."Assembly BOM" then begin
            SalesLine."Country/Region of Origin Code" := Item."Country/Region of Origin Code";
            SalesLine."Nomenclature produits" := Item."Tariff No.";
        end else begin
            SalesLine."Vendor No." := Item."Vendor No.";
            SalesLine.Validate("Prix achat prevu", Item.PrixAchatActuel(SalesLine."Vendor No."));
            if Fournisseur.GET(Item."Vendor No.") then
                SalesLine."Country/Region of Origin Code" := Fournisseur."Country/Region Code";
        end;
        SalesLine."Poids obligatoire" := Item."Poids obligatoire";
        EnteteVente.GET(SalesLine."Document Type", SalesLine."Document No.");
        if EnteteVente.ASS then
            SalesLine."Nature vente" := SalesLine."Nature vente"::SAV
        else
            SalesLine."Nature vente" := Item."Nature vente";

        SalesLine."Eco Tax Furniture Code" := Item."Eco Tax Furniture Code";
        if not SalesLine."Article divers" then
            SalesLine."Eco Tax Furniture Qty Per" := Item."Net Weight";

        TypeDocPhase := SalesLine."Document Type";
        SalesLine.Phase := Item.Phase;

        //KAN.FHA 09/03/2026 DEBUT
        SalesLine."Valeur douane unitaire" := Item.PrixVenteActuel(SalesLine."Sell-to Customer No.");
        //KAN.FHA 09/03/2026 FIN

        if not PhaseDocument.Get(TypeDocPhase, SalesLine."Document No.", SalesLine.Phase) then begin
            PhaseDocument.Init();
            PhaseDocument."Type document" := TypeDocPhase;
            PhaseDocument."No. document" := SalesLine."Document No.";
            PhaseDocument.Phase := SalesLine.Phase;
            PhaseDocument.Insert();
        end;
    end;

    [EventSubscriber(ObjectType::Table, 37, OnBeforeValidateQuantity, '', false, false)]
    local procedure SalesLineOnBeforeValidateQuantity(var SalesLine: Record "Sales Line"; CallingFieldNo: Integer)
    var
        Text50000Err: Label 'Vous ne pouvez pas modifier le champ suivant pour une ligne "Composant". :';
        ErrorText: Text;
    begin
        if (CallingFieldNo = SalesLine.FIELDNO(Quantity)) and (SalesLine."Linked to line" <> 0) then begin
            ErrorText := Text50000Err + ' ' + SalesLine.FIELDCAPTION(Quantity);
            ERROR(ErrorText);
        end;
    end;

    [EventSubscriber(ObjectType::Table, 37, OnAfterValidateEvent, Quantity, false, false)]
    local procedure SalesLineOnAfterValidateQuantity(var Rec: Record "Sales Line")
    var
        ContenuColisage: Record "Contenu colisage";
        WEEEMgt: Codeunit "Gestion Ecopart";
        LigneColisageEclateeMsg: Label 'Cette ligne de commande a déjà été éclatée sur le colisage, le système ne peut pas reporter la modification de quantité vers le colisage.\Voir avec la logistique.';

    begin
        WEEEMgt.SalesUpdateWEEE(Rec, Rec.FIELDNO(Quantity));

        Rec.Validate("Prix achat prevu");

        Rec.fctMajQuantiteComposant(Rec);

        if rec."Document Type" = Rec."Document Type"::Order then begin
            ContenuColisage.SetCurrentKey("Order No.", "Order Line No.");
            ContenuColisage.SetRange("Order No.", Rec."Document No.");
            ContenuColisage.SetRange("Order Line No.", Rec."Line No.");
            if not ContenuColisage.IsEmpty then
                if ContenuColisage.Count = 1 then begin
                    ContenuColisage.FindFirst();
                    ContenuColisage."Quantite UC" := Rec.Quantity;
                    ContenuColisage.Modify();
                end else
                    Message(LigneColisageEclateeMsg);

        end;
    end;

    [EventSubscriber(ObjectType::Table, 37, OnAfterInitOutstandingAmount, '', false, false)]
    local procedure SalesLineOnAfterInitOutstandingAmount(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")
    var
        CurrExchRate: Record "Currency Exchange Rate";
    begin
        if SalesLine.Quantity = 0 then
            SalesLine."Montant restant HT (DS)" := 0
        else
            if SalesHeader."Currency Code" = '' then
                SalesLine."Montant restant HT (DS)" := ROUND(SalesLine.Amount * SalesLine."Outstanding Quantity" / SalesLine.Quantity, 0.01)
            else
                SalesLine."Montant restant HT (DS)" :=
                    CurrExchRate.ExchangeAmtFCYToLCY(
                        SalesHeader."Document Date", SalesHeader."Currency Code", SalesLine.Amount * SalesLine."Outstanding Quantity" / SalesLine.Quantity, SalesHeader."Currency Factor");

        //SalesLine.Modify();
    end;

    [EventSubscriber(ObjectType::Table, 37, OnAfterGetUnitCost, '', false, false)]
    local procedure SalesLineOnAfterGetUnitCost(var SalesLine: Record "Sales Line"; Item: Record Item)
    var
        AffectationsAchats: Record "Affectations achat vente";
        Location: Record Location;
        TotalAchatsPourCetteLigne: Decimal;
    begin
        //KAN.FHA 27/05/2020 DEBUT
        if Item."Miscellaneous Item" then begin
            SalesLine.CALCFIELDS("Nb affectations achats");
            if (SalesLine."Nb affectations achats" = 0) or (SalesLine.Quantity = 0) then
                SalesLine.VALIDATE("Unit Cost (LCY)", 0)
            else begin
                AffectationsAchats.RESET();
                AffectationsAchats.SETCURRENTKEY("Type document vente", "No. document vente", "No. ligne document vente");
                AffectationsAchats.SETRANGE("Type document vente", SalesLine."Document Type");
                AffectationsAchats.SETRANGE("No. document vente", SalesLine."Document No.");
                AffectationsAchats.SETRANGE("No. ligne document vente", SalesLine."Line No.");
                if AffectationsAchats.FINDSET(false) then begin
                    TotalAchatsPourCetteLigne := 0;
                    repeat
                        TotalAchatsPourCetteLigne := TotalAchatsPourCetteLigne + AffectationsAchats."Cout total (DS)";
                    until AffectationsAchats.NEXT() = 0;
                end;

                SalesLine.VALIDATE("Unit Cost (LCY)", ROUND(TotalAchatsPourCetteLigne / SalesLine.Quantity, 0.01));
            end;
            //SalesLine.Modify();
        end else
            //KAN.FHA 11/09/2020 DEBUT
            if Location.GET(SalesLine."Location Code") then
                if Location."Magasin client" then begin
                    SalesLine.VALIDATE("Unit Cost (LCY)", 0);
                    //KAN.FHA 19/02/2021 DEBUT
                    SalesLine.VALIDATE("Line Discount %", 100);
                    SalesLine.Modify();
                    //KAN.FHA 19/02/2021 FIN
                end;
        //KAN.FHA 11/09/2020 FIN
        //KAN.FHA 27/05/2020 FIN

    end;

    [EventSubscriber(ObjectType::Table, 37, OnAfterValidateEvent, "Qty. to Invoice", false, false)]
    local procedure SalesLineOnAfterValidateQtyToInvoice(var Rec: Record "Sales Line")
    var
        LigneEcotaxe: Record "Sales Line";
        WEEEMgt: Codeunit "Gestion Ecopart";
    begin
        //KAN.FHA 16/07/2021 DEBUT
        if Rec."Document Type" = Rec."Document Type"::"Credit Memo" then begin
            if (Rec.Type = Rec.Type::Item) and (Rec."Eco Tax Furniture Code" <> '') then begin
                LigneEcotaxe.RESET();
                LigneEcotaxe.SETCURRENTKEY("Document Type", "Document No.", "Eco Tax Furniture Line");
                LigneEcotaxe.SETRANGE("Document Type", Rec."Document Type");
                LigneEcotaxe.SETRANGE("Document No.", Rec."Document No.");
                LigneEcotaxe.SETRANGE("Attached to Line No.", Rec."Line No.");
                LigneEcotaxe.SETRANGE("Eco Tax Furniture Line", true);
                if LigneEcotaxe.FIND('-') then begin
                    LigneEcotaxe.VALIDATE("Qty. to Invoice", Rec."Quantity (Base)");// * "Eco Tax Furniture Qty Per");
                    LigneEcotaxe.MODIFY();
                end;
            end;
        end else
            //KAN.FHA 16/07/2021 FIN
            WEEEMgt.SalesUpdateWEEE(Rec, Rec.FIELDNO("Qty. to Invoice"));
        //+DIA.SCH - CPT02
    end;

    [EventSubscriber(ObjectType::Table, 37, OnAfterValidateEvent, "Qty. to Ship", false, false)]
    local procedure SalesLineOnAfterValidateQtyToShip(var Rec: Record "Sales Line"; CurrFieldNo: Integer)
    var
        WEEEMgt: Codeunit "Gestion Ecopart";
        Text50002Qst: Label 'Voulez-vous mettre à jour les quantités à expédier des composants ?';
    begin
        //KAN.FHA 02/02/2026 DEBUT
        if CurrFieldNo = Rec.FieldNo("Qty. to Ship") then
            //KAN.FHA 02/02/2026 FIN
            WEEEMgt.SalesUpdateWEEE(Rec, Rec.FIELDNO("Qty. to Ship"));

        if (CurrFieldNo = Rec.FIELDNO("Qty. to Ship")) and (Rec."Ligne eclatee") then
            if Confirm(Text50002Qst) then
                Rec.fctMajQuantiteAExpedierComposant();

    end;

    [EventSubscriber(ObjectType::Table, 37, OnAfterValidateEvent, "Unit Price", false, false)]
    local procedure SalesLineOnAfterValidateUnitPrice(var Rec: Record "Sales Line"; CurrFieldNo: Integer)
    var
        PrixBloqueErr: Label 'Le prix unitaire de cet article est bloqué. Vous pouvez utiliser la fonction " Débloquer prix article " si vous souhaitez forcer le prix.';
    begin
        //<C02.01 DIAG.RGO 24/07/2014>
        if CurrFieldNo = Rec.FIELDNO("Unit Price") then
            if Rec."Prix bloque" then
                ERROR(PrixBloqueErr);
        //</C02.01 DIAG.RGO 24/07/2014>
    end;

    [EventSubscriber(ObjectType::Table, 37, OnAfterValidateEvent, Description, false, false)]
    local procedure SalesLineOnAfterValidateDescription(var Rec: Record "Sales Line"; CurrFieldNo: Integer)
    var
        LigneFicheBE: Record "Ligne fiche BE";
    //PrixBloqueErr: Label 'Le prix unitaire de cet article est bloqué. Vous pouvez utiliser la fonction " Débloquer prix article " si vous souhaitez forcer le prix.';
    begin
        if CurrFieldNo = Rec.FIELDNO(Description) then
            if Rec."Reference Fiche BE" <> '' then begin
                LigneFicheBE.SetCurrentKey(Reference);
                LigneFicheBE.SetRange(Reference, Rec."Reference Fiche BE");
                if LigneFicheBE.FindSet(true) then begin
                    LigneFicheBE."Description de la demande" := Rec.Description;
                    LigneFicheBE.Modify();
                end;
            end;
    end;

    [EventSubscriber(ObjectType::Table, 37, OnBeforeValidateUnitCostLCY, '', false, false)]
    local procedure SalesLineOnAfterValidateUnitCostLCY(var SalesLine: Record "Sales Line"; CurrentFieldNo: Integer)
    var
        UserSetup: record "User Setup";
        MAJCoutUnitaireErr: Label 'Vous ne pouvez pas modifier le coût unitaire.';
        MAJCoutUnitaireArtDiversErr: Label 'Seuls les utilisateurs autorisés peuvent modifier le coût unitaire d''un article divers.';
    begin
        if CurrentFieldNo = SalesLine.FieldNo("Unit Cost (LCY)") then
            //KAN.FHA 03/06/2020 DEBUT
            if not SalesLine."Article divers" then
                ERROR(MAJCoutUnitaireErr)
            else begin
                if not UserSetup.GET(USERID) then
                    UserSetup.INIT();
                if not UserSetup."Forcer cout sur document vente" then
                    ERROR(MAJCoutUnitaireArtDiversErr);
                SalesLine."Cout unitaire force" := true;
                SalesLine."Cout unitaire force par" := copystr(USERID, 1, 50);
                SalesLine.Modify();
            end;
        //KAN.FHA 03/06/2020 FIN

    end;

    [EventSubscriber(ObjectType::Table, 37, OnAfterValidateEvent, "Net Weight", false, false)]
    local procedure SalesLineOnAfterValidateNetWeight(var Rec: Record "Sales Line"; var xRec: Record "Sales Line")
    var
        Item: Record Item;
        RecSalesLine: Record "Sales Line";
        LienAchatVente: Record "Affectations achat vente";
        LigneAchat: Record "Purchase Line";
        LigneContainer: Record "Ligne container";
        PoidsNetObligatoireErr: Label 'Vous devez obligatoirement saisir un poids pour l''article divers %1.', Comment = '%1 = N° article';
        Text1Qst: Label 'Confirmez-vous la mise à jour du poids net et donc du recalcul de la taxe écomobilier ?';
        Text2Err: Label 'Action interrompue.';

    begin
        //KAN.FHA 16/10/2020 DEBUT
        if (Rec."Net Weight" = 0) and (Rec.Type = Rec.Type::Item) and (Rec."No." <> '') then begin
            Rec.GetItem(Item);
            if (Item."Miscellaneous Item") and (Item."Poids obligatoire") then
                Error(PoidsNetObligatoireErr, Rec."No.");
        end;
        //KAN.FHA 16/10/2020 FIN

        // ECO TAXE sur article divers
        if (Rec."Eco Tax Furniture Qty Per" = 0) and (Rec.Type = Rec.Type::Item) and (Rec."Eco Tax Furniture Code" <> '')
        then begin
            RecSalesLine.SetRange("Document Type", Rec."Document Type");
            RecSalesLine.SetRange("Document No.", Rec."Document No.");
            RecSalesLine.SetRange("Attached to Line No.", Rec."Line No.");
            if RecSalesLine.FindFirst() then begin
                Rec."Eco Tax Furniture Qty Per" := Rec."Net Weight";
                RecSalesLine."Eco Tax Furniture Qty Per" := Rec."Net Weight";
                RecSalesLine.Validate("Unit Price", (Rec."Net Weight" * RecSalesLine."Eco Tax Furniture Amount"));
                RecSalesLine.Modify();
            end;
        end else
            if (Rec."Net Weight" <> xRec."Net Weight") and (Rec.Type = Rec.Type::Item) and (Rec."Eco Tax Furniture Code" <> '') then
                if Confirm(Text1Qst) then begin
                    RecSalesLine.SetRange("Document Type", Rec."Document Type");
                    RecSalesLine.SetRange("Document No.", Rec."Document No.");
                    RecSalesLine.SetRange("Attached to Line No.", Rec."Line No.");
                    if RecSalesLine.FindFirst() then begin
                        Rec."Eco Tax Furniture Qty Per" := Rec."Net Weight";
                        RecSalesLine."Eco Tax Furniture Qty Per" := Rec."Net Weight";
                        RecSalesLine.Validate("Unit Price", (Rec."Net Weight" * RecSalesLine."Eco Tax Furniture Amount"));
                        RecSalesLine.Modify();
                    end;
                end else
                    Error(Text2Err);


        //KAN.FHA 24/10/2022 DEBUT
        if Rec."Document Type" = Rec."Document Type"::Order then begin
            LienAchatVente.Reset();
            LienAchatVente.SetCurrentKey("Type document vente", "No. document vente", "No. ligne document vente");
            LienAchatVente.SetRange("Type document vente", LienAchatVente."Type document vente"::Commande);
            LienAchatVente.SetRange("No. document vente", Rec."Document No.");
            LienAchatVente.SetRange("No. ligne document vente", Rec."Line No.");
            if LienAchatVente.FindSet(true) then
                repeat
                    if LigneAchat.Get(LigneAchat."Document Type"::Order, LienAchatVente."No. document achat", LienAchatVente."No. ligne document achat") then begin
                        LigneAchat."Net Weight" := Rec."Net Weight";
                        LigneAchat.Modify();
                        LigneContainer.Reset();
                        LigneContainer.SetCurrentKey("No. commande achat", "No. ligne commande achat");
                        LigneContainer.SetRange("No. commande achat", LigneAchat."Document No.");
                        LigneContainer.SetRange("No. ligne commande achat", LigneAchat."Line No.");
                        if LigneContainer.FindSet(true) then
                            repeat
                                LigneContainer."Poids net unitaire" := LigneAchat."Net Weight";
                                LigneContainer.Modify();
                            until LigneContainer.Next() = 0;
                    end;

                until LienAchatVente.Next() = 0;
        end;
        //KAN.FHA 24/10/2022 FIN
    end;

    [EventSubscriber(ObjectType::table, 37, OnAfterValidateEvent, "Shipped Not Invoiced", false, false)]
    local procedure OnAfterValidateEventShippedNotInvoiced(var Rec: Record "Sales Line")
    var
        EnteteVente: Record "Sales Header";
        CurrExchRate: Record "Currency Exchange Rate";
        Currency2: Record Currency;
    begin
        //KAN.FHA 22/03/2020 DEBUT
        EnteteVente.GET(Rec."Document Type", Rec."Document No.");
        if Rec."Quantity (Base)" = 0 then
            Rec."Livre non facture HT (DS)" := 0
        else begin
            Rec."Livre non facture HT (DS)" := ROUND((Rec."Line Amount" - Rec."Inv. Discount Amount") * Rec."Qty. Shipped Not Invd. (Base)" / (Rec."Quantity (Base)"));
            if EnteteVente."Currency Code" <> '' then
                Rec."Prepayment VAT %" :=
                    ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                        Rec.GetDate(), Rec."Currency Code",
                        Rec."Livre non facture HT (DS)", EnteteVente."Currency Factor"),
                        Currency2."Amount Rounding Precision")
        end;
        //rec.Modify();
        //KAN.FHA 22/03/2020 FIN

    end;

    [EventSubscriber(ObjectType::Table, 37, OnAfterValidateEvent, "Qty. to Assemble to Order", false, false)]
    local procedure SalesLineOnAfterValidateQtyToAssembleToOrder(var Rec: Record "Sales Line")
    var
        Article: Record Item;
        EnteteVente: Record "Sales Header";

        ATOLink: Record "Assemble-to-Order Link";
    begin
        EnteteVente.GET(Rec."Document Type", Rec."Document No.");
        //DIA@OAI
        if ((Rec.Quantity <> 0) and (Rec."Document Type" = Rec."Document Type"::Order)) then begin
            Rec.GetItem(Article);
            if Article."Prix/Cout relation" = true then begin
                ATOLink.SetHideConfirm(true);
                ATOLink.RollUpCost(Rec);
                ATOLink.RollupPrice(EnteteVente, Rec);
                ATOLink.SetHideConfirm(false);
            end;
        end;
        //DIA@OAI

    end;

    [EventSubscriber(ObjectType::Table, 37, OnAfterValidateEvent, "Item Reference No.", false, false)]
    local procedure SalesLineOnAfterValidateItemReferenceNo(var Rec: Record "Sales Line")
    var
        Text50000Err: label 'Vous ne pouvez pas modifier le champ [Référence article] pour une ligne "Composant".';
    begin
        if ((Rec."Linked to line" <> 0)) then
            ERROR(Text50000Err);
    end;

    [EventSubscriber(ObjectType::Table, 37, OnAfterValidateEvent, "Purchasing Code", false, false)]
    local procedure SalesLineOnAfterValidatePurchasingCode(var Rec: Record "Sales Line")
    var
        Article: Record Item;
    begin
        Rec.GetItem(Article);
        if Rec."Special Order" then begin
            Rec."Vendor No." := Article."Vendor No.";
            rec.modify();
        end;
    end;

    [EventSubscriber(ObjectType::Table, 37, OnAfterValidateEvent, "Return Qty. to Receive", false, false)]
    local procedure SalesLineOnAfterValidateReturnQtyToReceive(var Rec: Record "Sales Line")
    var
        WEEEMgt: codeunit "Gestion Ecopart";
    begin
        WEEEMgt.SalesUpdateWEEE(Rec, Rec.FIELDNO("Return Qty. to Receive"));
    end;

    [EventSubscriber(ObjectType::Table, 37, OnBeforeCheckShipmentDateBeforeWorkDate, '', false, false)]
    local procedure SalesLine_OnBeforeCheckShipmentDateBeforeWorkDate(var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, 38, OnAfterCopyBuyFromVendorFieldsFromVendor, '', false, false)]
    local procedure PurchHeaderOnAfterCopyBuyFromVendorFieldsFromVendor(var PurchaseHeader: Record "Purchase Header"; Vendor: Record Vendor)
    var
        SemainierChargement: Record "Semainier chargement import";
        Pays: Record "Country/Region";
        PremierLundiVoulu: date;
        DernierLundiVoulu: date;
        NouvelleDate: Date;
        JourSemaine: Integer;
        DelaiTransit: Text;
        DelaiTransitLbl: Label '<%1D>', Comment = '%1 = nombre de jours';
    begin
        //KAN.FHA 19/04/2021 DEBUT Gestion des containers
        PurchaseHeader."Suivi container" := Vendor."Suivi container";
        PurchaseHeader."No. fournisseur" := Vendor."No.";
        //KAN.FHA 19/04/2021 FIN
        //KAN.FHA 04/05/2026 DEBUT
        if PurchaseHeader."Suivi container" then begin
            PremierLundiVoulu := CalcDate('<-CW>', Today);
            DernierLundiVoulu := CalcDate('<+52W>', PremierLundiVoulu);
            while PremierLundiVoulu <= DernierLundiVoulu do begin
                if not SemainierChargement.get(PremierLundiVoulu, PurchaseHeader."No. fournisseur") then begin
                    SemainierChargement.Init();
                    SemainierChargement."Date debut semaine" := PremierLundiVoulu;
                    SemainierChargement."No. fournisseur" := PurchaseHeader."No. fournisseur";
                    SemainierChargement."No. semaine" := Date2DWY(PremierLundiVoulu, 2);
                    if not Pays.get(PurchaseHeader."Buy-from Country/Region Code") then
                        Pays.Init();
                    if Pays."Delai transit (jours)" <> 0 then begin
                        DelaiTransit := StrSubstNo(DelaiTransitLbl, Pays."Delai transit (jours)");
                        NouvelleDate := CalcDate(DelaiTransit, SemainierChargement."Date debut semaine");
                        JourSemaine := Date2DWY(NouvelleDate, 1);
                        //On affiche des semaines donc la date de reception prevue calculée doit être le lundi de la semaine
                        while JourSemaine <> 1 do begin
                            NouvelleDate := CalcDate('<+1D>', NouvelleDate);
                            JourSemaine := Date2DWY(NouvelleDate, 1);
                        end;
                        SemainierChargement."Date semaine reception prevue" := NouvelleDate;
                    end else
                        SemainierChargement."Date semaine reception prevue" := SemainierChargement."Date debut semaine";
                    SemainierChargement."No. semaine reception prevue" := Date2DWY(SemainierChargement."Date semaine reception prevue", 2);

                    SemainierChargement.Insert();
                end;
                PremierLundiVoulu := CalcDate('<+1W>', PremierLundiVoulu);
            end;
        end;
        //KAN.FHA 04/05/2026 FIN
    end;

    [EventSubscriber(ObjectType::Table, 38, OnAfterCopyPayToVendorFieldsFromVendor, '', false, false)]
    local procedure PurchHeaderOnAfterCopyPayToVendorFieldsFromVendor(var PurchaseHeader: Record "Purchase Header"; Vendor: Record Vendor)
    begin
        PurchaseHeader."Posting Description" := Vendor.Name;
        //PurchaseHeader.Modify();
    end;

    [EventSubscriber(ObjectType::Table, 38, OnAfterValidateEvent, "Pay-to Vendor No.", false, false)]
    local procedure PurchHeaderOnAfterValidatePayToVendorNo(var Rec: Record "Purchase Header")
    begin
        Rec."Posting Description" := Rec."Pay-to Name";
    end;

    [EventSubscriber(ObjectType::Table, 38, OnAfterValidateEvent, "Pay-to Vendor No.", false, false)]
    local procedure PurchHeaderOnAfterValidatePostingDate(var Rec: Record "Purchase Header")
    var
        Enseigne: Record Enseigne;
    begin
        //KAN.FHA 12/01/2022 DEBUT
        if Enseigne.GET(Rec."Code enseigne") then
            if Enseigne."Enseigne interne" then begin
                Rec."Code chantier" := Enseigne.ChantierAnnuel(Rec."Posting Date");
                Rec.Modify();
            end;
        //KAN.FHA 12/01/2022 FIN
    end;

    [EventSubscriber(ObjectType::Table, 38, OnAfterValidateEvent, "Expected Receipt Date", false, false)]
    local procedure PurchHeaderOnAfterValidateExpectedReceiptDate(var Rec: Record "Purchase Header")
    begin
        //KAN.FHA 20/04/2023 DEBUT
        if Rec."Expected Receipt Date" <> 0D then
            Rec."Semaine reception prevue" := DATE2DWY(Rec."Expected Receipt Date", 2)
        else
            Rec."Semaine reception prevue" := 0;
        Rec.Modify();
        //KAN.FHA 20/04/2023 FIN
    end;

    [EventSubscriber(ObjectType::Table, 38, OnAfterValidateEvent, "Payment terms code", false, false)]
    local procedure PurchHeaderOnAfterValidate(var Rec: Record "Purchase Header")
    begin
        if rec."Document Type" = Rec."Document Type"::Order then
            if rec."Payment Terms Code" <> '' then
                rec.Validate("Date chargement confirmee"); //Va recalculer la date d'échéance
    end;

    [EventSubscriber(ObjectType::Table, 38, OnInitRecordOnAfterAssignDates, '', false, false)]
    local procedure PurchHeaderOnInitRecordOnAfterAssignDates(var PurchaseHeader: Record "Purchase Header")
    begin
        //KAN.FHA 23/01/2023 DEBUT
        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then
            PurchaseHeader."Annee commande" := DATE2DMY(PurchaseHeader."Order Date", 3);
        //KAN.FHA 23/01/2023 FIN
        //KAN.FHA 11/03/2026 DEBUT
        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Blanket Order" then
            PurchaseHeader."Date validite" := CalcDate('<+1Y>', Today);

        //KAN.FHA 11/03/2026 FIN

    end;

    [EventSubscriber(ObjectType::Table, 38, OnBeforePrintRecords, '', false, false)]
    local procedure T38_OnBeforePrintRecords(var PurchaseHeader: Record "Purchase Header")
    var
        ReleasePurchDoc: Codeunit "Release Purchase Document";
        LancerLaCommandeQst: Label 'Voulez-vous lancer la commande ?';
        Text50000Lbl: Label 'La commande achat doit avoir subi le contrôle d''approbation pour être envoyée au fournisseur.';
    begin
        //KAN.FHA 07/06/2021 DEBUT
        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then begin
            if PurchaseHeader.Status = PurchaseHeader.Status::Open then
                if CONFIRM(LancerLaCommandeQst) then begin
                    ReleasePurchDoc.PerformManualRelease(PurchaseHeader);
                    COMMIT();
                end;

            PurchaseHeader.Archiver();

            if (PurchaseHeader.Status <> PurchaseHeader.Status::Released) and (PurchaseHeader.Status <> PurchaseHeader.Status::"Pending Prepayment") then
                ERROR(Text50000Lbl);
        end;
        //KAN.FHA 07/06/2021 FIN
    end;

    [EventSubscriber(ObjectType::Table, 39, OnAfterInitQtyToReceive, '', false, false)]
    local procedure T39_OnAfterInitQtyToReceive(var PurchLine: Record "Purchase Line")
    var
        QteRestante: Decimal;
    begin
        if PurchLine."Document Type" <> PurchLine."Document Type"::"Blanket Order" then
            exit;
        PurchLine.CalcFields("Qte sur commande");
        QteRestante := PurchLine.Quantity - (PurchLine."Qte sur commande" + PurchLine."Quantity Received");
        if QteRestante < 0 then
            QteRestante := 0;
        PurchLine."Qty. to Receive" := QteRestante;
        PurchLine."Qty. to Receive (Base)" := QteRestante; //Pas terrible, il faudrait convertir 
    end;

    [EventSubscriber(ObjectType::Table, 39, OnDeleteOnBeforeTestStatusOpen, '', false, false)]
    local procedure T39_OnDeleteOnBeforeTestStatusOpen(var PurchaseLine: Record "Purchase Line")
    var
        lrecSalesLine: Record "Sales Line";
        LigneContainer: Record "Ligne container";
        LienAchatVente: record "Affectations achat vente";
        LigneEnContainerErr: Label 'Cette ligne de commande a été mise dans un ou plusieurs containers, il faut supprimer les lignes de container avant de pouvoir supprimer la ligne de commande d''achat (et évidemment s''assurer que le container n''a pas été chargé...).';
        LigneRetourEnContainerErr: Label 'Cette ligne de commande a été mise en container (%1), il faut supprimer la ligne de container avant de pouvoir saisir la ligne de commande d''achat (et évidemment s''assurer que le container n''a pas été chargé...).', Comment = '%1 = Container';

    begin
        //KAN.FHA 01/03/2023 DEBUT
        PurchaseLine.CALCFIELDS("Quantite en container");
        if PurchaseLine."Quantite en container" <> 0 then
            ERROR(LigneEnContainerErr);
        //KAN.FHA 01/03/2023 FIN

        //KAN.FHA 01/03/2023 DEBUT
        if PurchaseLine."No. container" <> '' then
            if PurchaseLine."Quantity Received" = 0 then //Il faut qu'on puisse supprimer un document compltement factur, ce controle ne doit avoir lieu que sur des commandes non encore recues
                ERROR(LigneRetourEnContainerErr, PurchaseLine."No. container");
        //KAN.FHA 01/03/2023 FIN


        //-DIA.MAN 05/06/2017 Commande speciale
        if PurchaseLine."Special Order" and lrecSalesLine.GET(lrecSalesLine."Document Type"::Order, PurchaseLine."Special Order Sales No.",
                                                PurchaseLine."Special Order Sales Line No.") then begin
            lrecSalesLine."Special Order Purchase No." := '';
            lrecSalesLine."Special Order Purch. Line No." := 0;
            lrecSalesLine.MODIFY();
        end;
        //+DIA.MAN 05/06/2017 Commande speciale

        //KAN>> On supprime les affectations si c'est une suppression par l'utilisateur (il annule son document) mais si c'est une suppression par le systeme (commande entierement facturee), on ne supprime pas.
        if (PurchaseLine."Quantity Received" = 0) and (PurchaseLine."Document Type" in [PurchaseLine."Document Type"::Order, PurchaseLine."Document Type"::Quote]) then begin
            LienAchatVente.SETRANGE("No. document achat", PurchaseLine."Document No.");
            LienAchatVente.SETRANGE("No. ligne document achat", PurchaseLine."Line No.");
            LienAchatVente.DELETEALL();
        end;
        //<<KAN

        //KAN.FHA 06/05/2021 DEBUT
        if PurchaseLine."Document Type" = PurchaseLine."Document Type"::Order then
            if PurchaseLine."Quantity Received" = 0 then begin //Au cas o on supprimerait une commande compltement recue et facture
                LigneContainer.RESET();
                LigneContainer.SETCURRENTKEY("No. commande achat", "No. ligne commande achat");
                LigneContainer.SETRANGE("No. commande achat", PurchaseLine."Document No.");
                LigneContainer.SETRANGE("No. ligne commande achat", PurchaseLine."Line No.");
                LigneContainer.DELETEALL();
            end;
        //KAN.FHA 06/05/2021 FIN
    end;

    //Validate du No.
    [EventSubscriber(ObjectType::Table, 39, OnAfterAssignHeaderValues, '', false, false)]
    local procedure T39_OnAfterAssignHeaderValues(PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line")
    begin
        //DIALBO 12/12/2016
        if PurchLine."Document Type" in [PurchLine."Document Type"::Order, PurchLine."Document Type"::"Return Order"] then begin
            PurchHeader.TESTFIELD("Purchaser Code");
            //KAN.FHA 05/06/2025 DEBUT
            if not PurchHeader."Achat pour stock" then begin
                PurchHeader.TestField("Code chantier");
                PurchHeader.TestField("Code groupe");
                PurchHeader.TestField("Code enseigne");
            end;
            //KAN.FHA 05/06/2025 FIN
            //KAN.FHA 05/06/2025 FIN
            //KAN.FHA 25/06/2025 DEBUT
            PurchHeader.TestField("Buy-from Country/Region Code");
            PurchHeader.TestField("Pay-to Country/Region Code");
            //KAN.FHA 25/06/2025 FIN

        end;

        //KAN.31/01/2020 DEBUT
        PurchLine."Code groupe" := PurchHeader."Code groupe";
        PurchLine."Code enseigne" := PurchHeader."Code enseigne";
        PurchLine."Code operation" := PurchHeader."Code operation";
        PurchLine."Code chantier" := PurchHeader."Code chantier";
        PurchLine.TypeDoc := PurchHeader."Document Type";
        PurchLine.NumDoc := PurchHeader."No.";
        PurchLine.GrpComptaMarche := PurchHeader."Gen. Bus. Posting Group";
        //KAN.31/01/2020 FIN

        //KAN.FHA 31/10/2023 DEBUT
        //On commence par dire que la nature de vente n'est pas connue
        //Mais cela sera ecrase par la valeur se trouvant sur l'article dans le cas d'un article
        PurchLine."Nature vente" := PurchLine."Nature vente"::"Indéfinie";
        //KAN.FHA 31/10/2023 FIN

        //KAN.FHA 23/01/2023 DEBUT
        PurchLine."Annee commande" := PurchHeader."Annee commande";
        //KAN.FHA 23/01/2023 FIN

        //KAN.FHA 24/09/2020 DEBUT
        PurchLine."Achat pour stock" := PurchHeader."Achat pour stock";
        //KAN.FHA 24/09/2020 FIN

        //KAN.FHA 04/05/21 DEBUT
        if PurchLine.Type <> PurchLine.Type::" " then
            PurchLine."Suivi container" := PurchHeader."Suivi container";
        //KAN.FHA 04/05/21 FIN

        PurchLine."Purchaser Code" := PurchHeader."Purchaser Code";
        //DIALBO 12/12/2016

    end;

    //Validate du No
    [EventSubscriber(ObjectType::Table, 39, OnAfterAssignGLAccountValues, '', false, false)]
    local procedure T39_OnAfterAssignGLAccountValues(var PurchLine: Record "Purchase Line")
    begin
        //KAN.FHA 29/09/2023 DEBUT
        //Pas top, on va coder en dur le fait que c'est un acompte...
        //Le montant à charger par container ne doit pas prendre en compte les lignes d'acompte
        PurchLine."Ligne acompte" := (COPYSTR(PurchLine."No.", 1, 3) = '409');
        //KAN.FHA 29/09/2023 FIN
        //KAN.FHA 08/01/2024 DEBUT
        PurchLine."Nature vente" := PurchLine."Nature vente"::"Indéfinie";
        //KAN.FHA 08/01/2024 FIN
    end;

    [EventSubscriber(ObjectType::Table, 39, OnBeforeCopyFromItem, '', false, false)]
    local procedure T39_OnBeforeCopyFromItem(Item: Record Item)
    var
        Matiere: Record Matiere;
    begin
        Item.TESTFIELD("Purchasing Blocked", false);

        Item.TestField("Code matiere");

        If Matiere.get(Item."Code matiere") then
            if Matiere."Code eco-taxe obligatoire" then
                Item.TestField("Eco Tax Furniture Code");

        if not item."Miscellaneous Item" then
            Item.TestField("Net Weight");

        Item.TestField("Tariff No.");

        Item.TestField("Country/Region of Origin Code");

    end;

    [EventSubscriber(ObjectType::Table, 39, OnBeforeGetItemTranslation, '', false, false)]
    local procedure T39_OnBeforeGetItemTranslation(var IsHandled: Boolean)
    begin
        //KAN.FHA 21/02/2025 DEBUT
        //On ne veut pas que les desi articles soient traduites de base (on peut ensuite le demander avec une action sur la cde achat)
        IsHandled := true;
    end;

    //Validate du N°
    [EventSubscriber(ObjectType::Table, 39, OnAfterAssignItemValues, '', false, false)]
    local procedure T39_OnAfterAssignItemValues(var PurchLine: Record "Purchase Line"; Item: Record Item; PurchHeader: Record "Purchase Header")
    var
        ItemVend: Record "Item Vendor";
    begin
        //DIA@OAI
        if ItemVend.GET(PurchHeader."Buy-from Vendor No.", PurchLine."No.") = true then begin
            PurchLine."Indirect Cost %" := ItemVend."% Frais d'approche";
            PurchLine."Overhead Rate" := ItemVend."Montant Frais d'approche";
        end;
        //DIA@OAI

        //<C12.01 DIAG.RGO 24/07/2014>
        //Migration champ supprimé PurchLine.Indice := Item.Indice;
        //</C12.01 DIAG.RGO 24/07/2014>

        //KAN 05/12/2019>> Rentabilite / Articles divers
        PurchLine."Article divers" := Item."Miscellaneous Item";
        //KAN 05/12/2019<<
        //KAN.FHA 22/04/2021 DEBUT
        //KAN.FHA 08/10/2021 "Nomenclature produits" := Item."Tariff No.";
        //KAN.FHA 22/04/2021 FIN

        //KAN.FHA 31/10/2023 DEBUT
        PurchLine."Nature vente" := Item."Nature vente";
        //KAN.FHA 31/10/2023 FIN

    end;

    [EventSubscriber(ObjectType::Table, 39, OnBeforeValidateDescription, '', false, false)]
    local procedure T39_OnBeforeValidateDescription(var PurchaseLine: Record "Purchase Line")
    begin
        //KAN>>
        PurchaseLine.MAJLiensAchatVentes();
        //<<KAN
    end;

    [EventSubscriber(ObjectType::table, 39, OnValidateUnitCostLCYOnAfterUpdateUnitCostCurrency, '', false, false)]
    local procedure T39_OnValidateUnitCostLCYOnAfterUpdateUnitCostCurrency(var PurchaseLine: Record "Purchase Line")
    begin
        //KAN>>
        PurchaseLine.MAJLiensAchatVentes();
        //<<KAN
    end;

    //KAN.FHA 17/03/2026 DEBUT
    /* On désactive cet event car cela génère des effets indésirables lorsqu'on a plusieurs lignes de ventes affectées à une ligne achat.
    //Exemple : une ligne de 4 articles A1 et une autre de 6 articles A1. L'achat cumulé est de 10 articles A1. 
    //Dans le "Créer Commande achat" depuis une vente, on cumule les quantités vendues et cela met alors la pagaille dans les affectations
    [EventSubscriber(ObjectType::Table, 39, OnAfterValidateEvent, Quantity, false, false)]
    local procedure T39_OnAfterValidateQuantity(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line")
    var
        LienAchatVente: Record "Affectations achat vente";
    begin
        if Rec."Document Type" = Rec."Document Type"::Order then begin
            LienAchatVente.RESET();
            LienAchatVente.SETRANGE("No. document achat", Rec."Document No.");
            LienAchatVente.SETRANGE("No. ligne document achat", Rec."Line No.");
            if LienAchatVente.FINDSET(true) then
                repeat
                    if xRec.Quantity = LienAchatVente."Quantite affectee" then begin
                        LienAchatVente."Quantite affectee" := Rec.Quantity;
                        LienAchatVente.Validate("Cout unitaire (DS)");
                        LienAchatVente.Modify();
                    end;
                until LienAchatVente.NEXT() = 0;
        end;
    end;
    //KAN.FHA 17/03/2026 FIN
    */

    [EventSubscriber(ObjectType::Table, 39, OnAfterValidateEvent, "Net Weight", false, false)]
    local procedure T39_OnAfterValidateNetWeight(var Rec: Record "Purchase Line")
    var
        LigneVente: Record "Sales Line";
        LigneContainer: Record "Ligne container";
        LienAchatVente: Record "Affectations achat vente";
    begin
        //KAN.FHA 06/09/2022 DEBUT
        Rec.TESTFIELD("Article divers", true);

        if Rec."Document Type" = Rec."Document Type"::Order then begin
            LienAchatVente.RESET();
            LienAchatVente.SETRANGE("No. document achat", Rec."Document No.");
            LienAchatVente.SETRANGE("No. ligne document achat", Rec."Line No.");
            if LienAchatVente.FINDSET(true) then
                repeat
                    if LigneVente.GET(LienAchatVente."Type document vente", LienAchatVente."No. document vente", LienAchatVente."No. ligne document vente") then begin
                        LigneVente."Net Weight" := Rec."Net Weight";
                        LigneVente.MODIFY();
                    end;
                until LienAchatVente.NEXT() = 0;
        end;
        //KAN.FHA 06/09/2022 FIN

        //KAN.FHA 17/10/2022 DEBUT
        if (Rec."Document Type" = Rec."Document Type"::Order) then begin
            LigneContainer.RESET();
            LigneContainer.SETCURRENTKEY("No. commande achat", "No. ligne commande achat");
            LigneContainer.SETRANGE("No. commande achat", Rec."Document No.");
            LigneContainer.SETRANGE("No. ligne commande achat", Rec."Line No.");
            if LigneContainer.FINDSET(true) then
                repeat
                    LigneContainer."Poids net unitaire" := Rec."Net Weight";
                    LigneContainer.MODIFY();
                until LigneContainer.NEXT() = 0;
        end;
        //KAN.FHA 17/10/2022 FIN

    end;

    [EventSubscriber(ObjectType::Table, 39, OnInitOutstandingOnBeforeInitOutstandingAmount, '', false, false)]
    local procedure T39_OnInitOutstandingOnBeforeInitOutstandingAmount(var PurchaseLine: Record "Purchase Line")
    begin
        //KAN.FHA 16/04/2020 DEBUT
        PurchaseLine.MAJStatutCdeSurAffectation();
        //KAN.FHA 16/04/2020 FIN
    end;

    [EventSubscriber(ObjectType::Table, 39, OnAfterInitOutstandingAmount, '', false, false)]
    local procedure T39_OnAfterInitOutstandingAmount(var PurchLine: Record "Purchase Line"; PurchHeader: Record "Purchase Header")
    var
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";

    begin
        //KAN 10/01/2020 Gestion affaires
        if PurchHeader."Currency Code" = '' then
            Currency.InitRoundingPrecision()
        else begin
            PurchHeader.TESTFIELD("Currency Factor");
            Currency.GET(PurchHeader."Currency Code");
        end;

        if PurchLine.Quantity = 0 then
            PurchLine."Montant restant HT (DS)" := 0
        else begin
            //KAN 10/01/2020 Gestion affaires
            PurchLine."Montant restant HT (DS)" := ROUND(PurchLine.Amount * PurchLine."Outstanding Quantity" / PurchLine.Quantity, Currency."Amount Rounding Precision");
            if PurchHeader."Currency Code" <> '' then
                PurchLine."Montant restant HT (DS)" :=
                    CurrExchRate.ExchangeAmtFCYToLCY(PurchHeader."Document Date", PurchHeader."Currency Code", PurchLine."Montant restant HT (DS)", PurchHeader."Currency Factor");
            //Fin KAN 10/01/2020

        end;
        //Fin KAN 10/01/2020

    end;

    [EventSubscriber(ObjectType::Table, 39, OnAfterUpdateUnitCost, '', false, false)]
    local procedure T39_OnAfterUpdateUnitCost(var PurchLine: Record "Purchase Line")
    var
        LigneContainer: Record "Ligne container";
    begin
        //KAN>>
        PurchLine.MAJLiensAchatVentes();
        //<<KAN

        //KAN.FHA 01/03/2022 DEBUT
        //Migration
        //if (PurchLine."Document Type" = PurchLine."Document Type"::Order) and (not MiseAjourCoutDepuisContainer) then begin
        //Rempplacee par :    
        if PurchLine."Document Type" = PurchLine."Document Type"::Order then begin
            LigneContainer.RESET();
            LigneContainer.SETCURRENTKEY("No. commande achat", "No. ligne commande achat");
            LigneContainer.SETRANGE("No. commande achat", PurchLine."Document No.");
            LigneContainer.SETRANGE("No. ligne commande achat", PurchLine."Line No.");
            if LigneContainer.FINDSET(true) then
                repeat
                    LigneContainer."Cout unitaire direct" := PurchLine."Direct Unit Cost";
                    LigneContainer.MODIFY();
                until LigneContainer.NEXT() = 0;
        end;
        //KAN.FHA 01/03/2022 FIN

    end;

    [EventSubscriber(ObjectType::Table, 112, OnAfterValidateEvent, "Payment Terms Code", false, false)]

    local procedure SalesInvoiceHeaderOnAfterValidatePaymentTerms(var Rec: Record "Sales Invoice Header")
    var
        AutresTriggersTablesCodeunit: codeunit AutresTriggersTable;
    begin
        AutresTriggersTablesCodeunit.SalesInvoiceHeaderOnAfterValidatePaymentTermsCode(Rec);
    end;

    [EventSubscriber(ObjectType::Table, 112, OnAfterValidateEvent, "Due Date", false, false)]

    local procedure SalesInvoiceHeaderOnAfterValidateDueDate(var Rec: Record "Sales Invoice Header")
    var
        AutresTriggersTablesCodeunit: codeunit AutresTriggersTable;
    begin
        AutresTriggersTablesCodeunit.SalesInvoiceHeaderOnAfterValidateDueDate(Rec);
    end;

    [EventSubscriber(ObjectType::Table, 112, OnAfterValidateEvent, "Pmt. Discount Date", false, false)]
    local procedure SalesInvoiceHeaderOnAfterValidatePaymentDiscountDate(var Rec: Record "Sales Invoice Header")
    var
        AutresTriggersTablesCodeunit: codeunit AutresTriggersTable;
    begin
        AutresTriggersTablesCodeunit.SalesInvoiceHeaderOnAfterValidatePaymentDiscDate(Rec);
    end;

    [EventSubscriber(ObjectType::Table, 112, OnAfterValidateEvent, "Pmt. Discount Date", false, false)]
    local procedure SalesInvoiceHeaderOnAfterValidatePaymentMethodCode(var Rec: Record "Sales Invoice Header")
    var
        AutresTriggersTablesCodeunit: codeunit AutresTriggersTable;
    begin
        AutresTriggersTablesCodeunit.SalesInvoiceHeaderOnAfterValidatePaymentMethodCode(Rec);
    end;

    [EventSubscriber(ObjectType::Table, 121, OnInsertInvLineFromRcptLineOnAfterRoundLineDiscountAmount, '', false, false)]
    local procedure PurchRcptLineOnInsertInvLineFromRcptLineOnAfterRoundLineDiscountAmount(var PurchaseLine: Record "Purchase Line")
    var
        EnteteAchat: record "Purchase Header";

    begin
        //KAN.FHA 25/03/2022 DEBUT
        EnteteAchat.GET(PurchaseLine."Document Type", PurchaseLine."Document No.");
        PurchaseLine.CALCFIELDS("Nb lignes ventes liees");
        if (PurchaseLine."Nb lignes ventes liees" = 0) and (not EnteteAchat."Achat pour stock") then
            PurchaseLine."Affectation manquante" := true //Ce champ est ensuite copié vers la ligne de facture, il ne m'interesse pas sur la ligne de commande
        else
            PurchaseLine."Affectation manquante" := false;
        //PurchaseLine.Modify();
        //KAN.FHA 25/03/2022 FIN
    end;

    [EventSubscriber(ObjectType::Table, 171, OnAfterDeleteEvent, '', false, false)]
    local procedure StandardSalesLine_OnAfterDeleteEvent(var Rec: Record "Standard Sales Line")
    var
        CustStdSalesLines: Record "Standard Customer Sales Code";

    begin
        CustStdSalesLines.SetCurrentKey(Code);
        CustStdSalesLines.SetRange(Code, Rec."Standard Sales Code");
        CustStdSalesLines.DeleteAll(true);
    end;

    [EventSubscriber(ObjectType::Table, 171, OnAfterValidateEvent, Type, false, false)]
    local procedure StandardSalesLineOnAfterValidateType(var Rec: Record "Standard Sales Line"; var xRec: Record "Standard Sales Line")
    var
    begin
        //KAN.FHA 10/04/2020 DEBUT
        if rec."Line No." <> 0 then
            IF Rec.Type <> xRec.Type then begin
                rec."Poids net" := 0;
                rec."Prix unitaire" := 0;
                rec.Modify();
            end;
        //KAN.FHA 10/04/2020 FIN
    end;

    [EventSubscriber(ObjectType::Table, 171, OnAfterValidateEvent, "No.", false, false)]
    local procedure StandardSalesLineOnAfterValidateNo(var Rec: Record "Standard Sales Line"; xrec: Record "Standard Sales Line")
    var
        CodeVenteStd: record "Standard Sales Code";
        Article: Record Item;
    begin
        //KAN.FHA 10/04/2020 DEBUT
        if rec."Line No." <> 0 then
            if Rec."No." <> xRec."No." then begin
                Rec."Poids net" := 0;
                Rec."Prix unitaire" := 0;
                rec.Modify();
            end;
        //KAN.FHA 10/04/2020 FIN
        //KAN.FHA 04/12/2025 DEBUT
        if CodeVenteStd.get(Rec."Standard Sales Code") then
            Rec."Code enseigne" := CodeVenteStd."Code enseigne";

        if Rec.Type = Rec.Type::Item then begin
            if not Article.get(Rec."No.") then
                Article.Init();
            if rec.Phase = 0 then //On peut avoir récupéré une phase du devis type    
                Rec.Phase := Article.Phase;
            if rec."No. fournisseur" = '' then //On peut avoir récupéré une phase du devis type
                Rec."No. fournisseur" := Article."Vendor No.";
        end;
    end;

    [EventSubscriber(ObjectType::Table, 172, OnBeforeApplyStdCodesToSalesLines, '', false, false)]
    local procedure StandardCustomerSalesCodeOnInsertSalesLines(var SalesLine: Record "Sales Line"; StdSalesLine: Record "Standard Sales Line")
    var
        EnteteVente: Record "Sales Header";
    begin
        //KAN.FHA 14/05/2020 DEBUT
        EnteteVente.get(SalesLine."Document Type", SalesLine."Document No.");
        EnteteVente.TESTFIELD("Location Code");
        SalesLine."Type ligne" := StdSalesLine."Type ligne";
        //KAN.FHA 14/05/2020 FIN
        //KAN.FHA 03/12/2025 DEBUT
        SalesLine."Type Fiche BE" := StdSalesLine."Type Fiche BE";
        SalesLine.Phase := StdSalesLine.Phase;
        //message('PPoint 4 SalesLine.Phase := StdSalesLine.Phase' + format(SalesLine.Phase));
        //KAN.FHA 03/12/2025 FIN
    end;

    [EventSubscriber(ObjectType::Table, 172, OnApplyStdCodesToSalesLinesOnAfterInsertExtendedText, '', false, false)]
    local procedure StandardCustomerSalesCodeOnpplyStdCodesToSalesLines(var StdSalesLine: Record "Standard Sales Line"; var SalesLine: Record "Sales Line")
    var
        Article: Record Item;
        EnteteVente: Record "Sales Header";
        dNegDEEE: Codeunit "Gestion Ecopart";
    begin
        //KAN.FHA 22/04/2020 DEBUT
        EnteteVente.GET(SalesLine."Document Type", SalesLine."Document No.");
        if StdSalesLine.Type = StdSalesLine.Type::Item then
            if Article.GET(StdSalesLine."No.") then begin
                Article.CALCFIELDS("Assembly BOM");
                //KAN.FHA 18/01/2021 DEBUT
                if EnteteVente."Eco Tax Furniture Liable" then
                    //KAN.FHA 18/01/2021 FIN
                    if (SalesLine."Eco Tax Furniture Code" <> '') and (not Article."Assembly BOM") then
                        dNegDEEE.InsertWEEELine(SalesLine);

                if Article."Miscellaneous Item" then begin
                    SalesLine.VALIDATE("Net Weight", StdSalesLine."Poids net");
                    SalesLine.VALIDATE(Quantity);
                    SalesLine.VALIDATE("Unit Price", StdSalesLine."Prix unitaire");
                    SalesLine.Validate("Prix achat prevu", StdSalesLine."Prix achat prevu");
                    SalesLine."Nomenclature produits" := StdSalesLine."Nomenclature produits";
                    SalesLine."Country/Region of Origin Code" := StdSalesLine."Country/Region of Origin Code";
                    //KAN.FHA 15/01/2026 DEBUT
                    SalesLine."Vendor No." := StdSalesLine."No. fournisseur";
                    if StdSalesLine.Phase <> 0 then
                        SalesLine.Phase := StdSalesLine.Phase;

                    SalesLine."Net Weight" := StdSalesLine."Poids net";
                    SalesLine.Validate(Quantity, StdSalesLine.Quantity);
                    SalesLine.Validate("Unit Price", StdSalesLine."Prix unitaire");
                    //KAN.FHA 15/01/2026 FIN
                    SalesLine.MODIFY();
                end;

                if Article."Assembly BOM" then
                    CODEUNIT.RUN(CODEUNIT::"Eclater nomenclature ABRANE", SalesLine)
                else
                    ;
            end;
        //KAN.FHA 22/04/2020 FIN
    end;

    [EventSubscriber(ObjectType::Table, 282, OnAfterInsertEvent, '', false, false)]
    local procedure EntryExitPointOnAfterInsert(Rec: Record "Entry/Exit Point")
    var
        Pays: Record "Country/Region";
    begin
        //KAN.FHA 18/10/2022 DEBUT
        if not Pays.GET(Rec.Code) then begin
            Pays.INIT();
            Pays.Code := Rec.Code;
            Pays.Name := COPYSTR(Rec.Description, 1, 50);
            Pays.INSERT();
        end;
        //KAN.FHA 18/10/2022 FIN
    end;

    //Item References
    [EventSubscriber(ObjectType::Table, 5777, OnInsertTriggerOnBeforeCreateItemVendor, '', false, false)]
    local procedure T5777_OnInsertTriggerOnBeforeCreateItemVendor(var Rec: Record "Item Reference")
    begin
        Rec.DuplicateFromItemCrossReference_T(true);
    end;

    [EventSubscriber(ObjectType::Table, 5777, OnAfterRenameEvent, '', false, false)]
    local procedure ItemReferenceOnRename(var Rec: Record "Item Reference")
    var
        NotRenameErr: label 'Vous ne pouvez pas renommer l''enregistrement %1.', Comment = '%1 = Nom de la table';
    begin
        //- DIA.160527-P2/BPE
        if Rec."Reference Type" = Rec."Reference Type"::Customer then
            ERROR(NotRenameErr, Rec.TABLECAPTION());
        //- DIA.160527-P2/BPE

    end;

    [EventSubscriber(ObjectType::Table, 5777, OnAfterValidateEvent, "Item No.", false, false)]
    local procedure ItemReferenceOnValidateItemNo(var Rec: Record "Item Reference")
    var
        Item: Record Item;
    begin
        //DIANBE 02/01/2015 DEBUT
        Item.GET(Rec."Item No.");
        Rec.Description := Item.Description;
        //DIANBE 02/01/2015 FIN

        //- DIA.160527-P2/BPE
        Rec."Unit of Measure" := Item."Base Unit of Measure";
        //- DIA.160527-P2/BPE

        /// Rec.Modify();
    end;

    [EventSubscriber(ObjectType::Table, 5777, OnAfterValidateEvent, Description, false, false)]
    local procedure ItemReference_OnValidateDescription(var Rec: Record "Item Reference")
    var
        Client: Record Customer;
        Client2: Record Customer;
        ReferenceArticle: Record "Item Reference";
        Window: Dialog;
        AttenteLbl: Label 'Mise à jour de la table %1 en cours. Merci de patienter ...', Comment = '%1 = Nom de la table';

    begin
        //- DIA.160527-P2/BPE
        if rec."Reference Type" <> rec."Reference Type"::Customer then
            exit;

        if not Client.GET(Rec."Reference Type No.") then
            exit;

        if Client."Customer Price Group" = '' then
            exit;

        window.OPEN(STRSUBSTNO(AttenteLbl, Rec.TABLECAPTION()));

        Client2.SETRANGE("Customer Price Group", Client."Customer Price Group");
        Client2.SETFILTER("No.", '<>%1', Client."No.");
        //KAN.FHA 25/02/2022 DEBUT
        Client2.SETRANGE("Language Code", Client."Language Code");
        //KAN.FHA 25/02/2022 FIN

        if Client2.FINDSET(false) then
            repeat
                //Sub_Duplicate_T(Rec, Cust_lrc, OnInsertAction)

                //- DIA.160527-P2/BPE
                ReferenceArticle.SETRANGE("Item No.", Rec."Item No.");
                ReferenceArticle.SETRANGE("Variant Code", Rec."Variant Code");
                ReferenceArticle.SETRANGE("Unit of Measure", Rec."Unit of Measure");
                ReferenceArticle.SETRANGE("Reference Type", Rec."Reference Type");
                ReferenceArticle.SETRANGE("Reference Type No.", Client2."No.");
                ReferenceArticle.SETRANGE("Reference No.", Rec."Reference No.");

                if ReferenceArticle.FINDSET(true) then begin
                    ReferenceArticle.Description := Rec.Description;
                    //ItemCrossRef_lrc."Discontinue Bar Code" := ItemCrossRef_prc."Discontinue Bar Code" ;
                    ReferenceArticle.MODIFY();
                end;

            //+ DIA.160527-P2/BPE
            until Client2.NEXT() = 0;
        window.CLOSE();

        //+ DIA.160527-P2/BPE
    end;

    [EventSubscriber(ObjectType::Table, 5777, OnAfterValidateEvent, "Reference Type No.", false, false)]
    local procedure ItemReferenceOnValidateReferenceTypeNo(var Rec: Record "Item Reference")
    var
        recClient: Record Customer;
        recFournisseur: Record Vendor;
    begin
        //DIANBE 02/01/2015 DEBUT
        Rec."Nom client/fournisseur" := '';
        if Rec."Reference Type" = Rec."Reference Type"::Customer then
            if recClient.GET(Rec."Reference Type No.") then
                Rec."Nom client/fournisseur" := recClient.Name;

        if Rec."Reference Type" = Rec."Reference Type"::Vendor then
            if recFournisseur.GET(Rec."Reference Type No.") then
                Rec."Nom client/fournisseur" := recFournisseur.Name;

        //DIANBE 02/01/2015 FIN
    end;

}

