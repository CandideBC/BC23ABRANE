codeunit 50018 ConsommerEventsPages
{
    trigger OnRun()
    begin
    end;

    [EventSubscriber(ObjectType::Page, 42, OnDeleteRecordEvent, '', false, false)]
    local procedure Page42_OnDeleteRecordEvent(var Rec: Record "Sales Header")
    var 
        Colisage: Record "Entete colisage";
        
    begin
        Colisage.SetCurrentKey("No. commande", "No. expedition enregistree");
        Colisage.SetRange("No. commande",Rec."No.");
        Colisage.SetRange("No. expedition enregistree",'');
        if Colisage.FindSet(true) then
            Colisage.DeleteAll(true);
    end;

    [EventSubscriber(ObjectType::Page, 42, OnBeforePostSalesOrder, '', false, false)]
    local procedure Page42_OnBeforePostSalesOrder(var SalesHeader: Record "Sales Header")
    var
        PhasesDocVente: Record "Phases document";
        PhaseNonChoisieErr: Label 'Vous devez choisir une phase.';
    begin
        SalesHeader.CalcSubTotal(SalesHeader);
        PhasesDocVente.SetRange("Type document", PhasesDocVente."Type document"::Order);
        PhasesDocVente.SetRange("No. document", SalesHeader."No.");
        if PhasesDocVente.Count <= 1 then
            exit
        else begin
            Commit();
            if page.RunModal(Page::"Phases document vente", PhasesDocVente) = Action::LookupOK then begin
                SalesHeader."Phase a expedier" := PhasesDocVente.Phase;
                SalesHeader."Libelle phase a expedier" := PhasesDocVente.Description;
                SalesHeader.Modify();
                Commit();
                SalesHeader.ViderQteAExpedierAutresPhases(PhasesDocVente.Phase);
            end else
                error(PhaseNonChoisieErr);
        end;
    end;

    [EventSubscriber(ObjectType::Page, 46, OnAfterQuantityOnAfterValidate, '', false, false)]
    local procedure P46_OnAfterQuantityOnAfterValidate(var SalesLine: Record "Sales Line")
    var
        WEEEMgt: Codeunit "Gestion Ecopart";
    begin
        IF WEEEMgt.SalesCheckIfAnyWEEE(SalesLine) THEN
            WEEEMgt.InsertWEEELine(SalesLine);

        IF WEEEMgt.MakeUpdate() THEN;
    end;

    [EventSubscriber(ObjectType::Page, 46, OnBeforeQuantityOnAfterValidate, '', false, false)]
    local procedure Page46_OnBeforeQuantityOnAfterValidate(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line")
    var
        recItem: Record item;
    begin
        if SalesLine."Ligne eclatee" = false then
            if (SalesLine.Type = SalesLine.Type::Item) and (SalesLine.Quantity <> xSalesLine.Quantity) and (Salesline.Quantity > 0) then begin
                recItem.GET(SalesLine."No.");
                recItem.CALCFIELDS(recItem."Assembly BOM");
                if (recItem."Assembly BOM") then begin
                    SalesLine."Ligne eclatee" := true;
                    SalesLine.MODIFY();
                    CODEUNIT.RUN(CODEUNIT::"Eclater nomenclature ABRANE", SalesLine);
                end;
            end;
    end;

    [EventSubscriber(ObjectType::Page, 95, OnAfterValidateEvent, "No.", false, false)]
    local procedure Page95_OnAfterValidateNo(var Rec: Record "Sales Line")
    var
        WEEEMgt: Codeunit "Gestion Ecopart";
    begin
        if WEEEMgt.SalesCheckIfAnyWEEE(Rec) then
            WEEEMgt.InsertWEEELine(Rec);
        if WEEEMgt.MakeUpdate() then;
    end;

    [EventSubscriber(ObjectType::Page, 95, OnAfterQuantityOnAfterValidate, '', false, false)]
    local procedure Page95_OnAfterQuantityOnAfterValidate(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; sender: Page "Sales Quote Subform")
    var
        recItem: Record item;
    begin
        if SalesLine."Ligne eclatee" = false then
            if (SalesLine.Type = SalesLine.Type::Item) and (SalesLine.Quantity <> xSalesLine.Quantity) and (Salesline.Quantity > 0) then begin
                recItem.GET(SalesLine."No.");
                recItem.CALCFIELDS("Assembly BOM");
                if (recItem."Assembly BOM") then begin
                    SalesLine.MODIFY();
                    CODEUNIT.RUN(CODEUNIT::"Eclater nomenclature ABRANE", SalesLine);
                    sender.Update();
                end;
            end;
    end;

    [EventSubscriber(ObjectType::Page, 96, OnAfterNoOnAfterValidate, '', false, false)]
    local procedure Page96_OnAfterNoOnAfterValidate(var SalesLine: Record "Sales Line")
    var
        WEEEMgt: Codeunit "Gestion Ecopart";
    begin
        if WEEEMgt.SalesCheckIfAnyWEEE(SalesLine) then
            WEEEMgt.InsertWEEELine(SalesLine);
        if WEEEMgt.MakeUpdate() then;
    end;

    [EventSubscriber(ObjectType::Page, 96, OnAfterValidateEvent, Quantity, false, false)]
    local procedure Page96_OnAfterValidateQuantity(var Rec: Record "Sales Line"; xRec: Record "Sales Line")
    var
        recItem: Record item;
    begin
        //DIA.ABRA.BOM NBE 03/12/2014 DEBUT
        if Rec."Ligne eclatee" = false then
            if (Rec.Type = Rec.Type::Item) and (Rec.Quantity <> xRec.Quantity) and (Rec.Quantity > 0) then begin
                recItem.GET(Rec."No.");
                recItem.CALCFIELDS(recItem."Assembly BOM");
                if (recItem."Assembly BOM") then begin
                    Rec.MODIFY();
                    CODEUNIT.RUN(CODEUNIT::"Eclater nomenclature ABRANE", Rec);
                end;
            end;
        //DIA.ABRA.BOM NBE 03/12/2014 FIN
    end;

    [EventSubscriber(ObjectType::Page, 372, 'OnOpenPageEvent', '', false, false)]
    local procedure Page372OnOpenPage(var Rec: Record "Bank Account Ledger Entry")
    var
        ParamUtil: Record "User Setup";
        EcranInterditErrLbl: Label 'Vous n''êtes pas autorisé(e) à ouvrir cette page.';
    begin
        if not ParamUtil.Get(UserId) then
            ParamUtil.Init();

        if not ParamUtil."Voir ecritures comptables" then
            Error(EcranInterditErrLbl);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales invoice subform", OnDeleteRecordEvent, '', false, false)]
    local procedure PageSalesInvoiceSFOnDeleteRecord(var Rec: record "Sales Line")
    begin
        Rec.TESTFIELD("Eco Tax Furniture Line", false);

    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Invoice subform", OnAfterValidateEvent, "No.", false, false)]
    local procedure PageSalesInvoiceSFOnAfterNoAfterValidate(var Rec: Record "Sales Line")
    var
        WeeeMgtCodeunit: Codeunit "Gestion Ecopart";
    begin
        WeeeMgtCodeunit.InsertWEEELine(Rec);

    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Invoice subform", OnAfterValidateEvent, Quantity, false, false)]
    local procedure PageSalesInvoiceSFOnAfterValidateQuantity(var Rec: Record "Sales Line")
    var
        recItem: Record Item;
    begin
        //DIA.ABRA.BOM NBE 03/12/2014 DEBUT
        if Rec."Ligne eclatee" = false then
            if (Rec.Type = Rec.Type::Item) and (Rec.Quantity > 0) then begin
                recItem.GET(Rec."No.");
                recItem.CALCFIELDS("Assembly BOM");
                if recItem."Assembly BOM" then begin
                    Rec.MODIFY();
                    CODEUNIT.RUN(Codeunit::"Eclater nomenclature ABRANE", Rec);
                    Rec.FIND();

                end;
            end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Order", OnBeforeActionEvent, "&Print", false, false)]
    local procedure PagePurchOrderOnBeforePrintEvent(var Rec: Record "Purchase Header")
    var
        ReleasePurchDoc: Codeunit "Release Purchase Document";
        Text50000Msg: Label 'La commande achat doit avoir subi le contrôle d''approbation pour être envoyée au fournisseur.';

    begin
        //KAN.FHA 17/08/2026 DEBUT
        Rec.VerifierLigneArticleSansNum();
        //KAN.FHA 17/08/2026 FIN
        
        if Rec.Status = Rec.Status::Open then begin
            ReleasePurchDoc.PerformManualRelease(Rec);
            Commit();
        end;

        if (Rec.Status <> Rec.Status::Released) and (Rec.Status <> Rec.Status::"Pending Prepayment") then
            ERROR(Text50000Msg);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Order", OnAfterActionEvent, "&Print", false, false)]
    local procedure PagePurchOrderOnAfterPrintEvent(var Rec: Record "Purchase Header")
    var
        ImprimerEtiquettePaletteQst: Label 'Voulez-vous imprimer une étiquette palette ?';

    begin
        //KAN.FHA 31/08/2022 DEBUT Imprimer une etiquette palette
        Commit();
        if Confirm(ImprimerEtiquettePaletteQst) then
            Rec.GenererEtiquettePalette(true);
        //KAN.FHA 31/08/2022 FIN
    end;

    [EventSubscriber(ObjectType::Page, Page::"Posted Sales Shipment - Update", OnAfterRecordChanged, '', false, false)]
    local procedure PagePostedSalesShtUpdate_OnAfterRecordChanged(var IsChanged: Boolean; var SalesShipmentHeader: Record "Sales Shipment Header"; xSalesShipmentHeader: Record "Sales Shipment Header")

    begin
        IsChanged := IsChanged OR (SalesShipmentHeader."Annee commande" <> xSalesShipmentHeader."Annee commande");
    end;

    [EventSubscriber(ObjectType::Page, 6631, OnAfterNoOnAfterValidate, '', false, false)]
    local procedure Page6631_OnAfterNoOnAfterValidate(var SalesLine: Record "Sales Line")
    var
        WEEEMgt: Codeunit "Gestion Ecopart";
    begin
        if WEEEMgt.SalesCheckIfAnyWEEE(SalesLine) then
            WEEEMgt.InsertWEEELine(SalesLine);
        if WEEEMgt.MakeUpdate() then;
    end;

    [EventSubscriber(ObjectType::Page, 1351, OnAfterRecordChanged, '', false, false)]
    local procedure P1351_OnAfterRecordChanged(var PurchInvHeader: Record "Purch. Inv. Header"; var IsChanged: Boolean;xPurchInvHeaderGlobal: Record "Purch. Inv. Header")
    begin
        IsChanged := IsChanged or
                (PurchInvHeader."Pay-to Name" <> xPurchInvHeaderGlobal."Pay-to Name") or
                (PurchInvHeader."Pay-to Name 2" <> xPurchInvHeaderGlobal."Pay-to Name 2") or
                (PurchInvHeader."Pay-to Address" <> xPurchInvHeaderGlobal."Pay-to Address") or
                (PurchInvHeader."Pay-to Address 2" <> xPurchInvHeaderGlobal."Pay-to Address 2") or
                (PurchInvHeader."Pay-to Post Code" <> xPurchInvHeaderGlobal."Pay-to Post Code") or
                (PurchInvHeader."Pay-to City" <> xPurchInvHeaderGlobal."Pay-to City") or
                (PurchInvHeader."Pay-to Contact" <> xPurchInvHeaderGlobal."Pay-to Contact") or
                (PurchInvHeader."Pay-to Country/Region Code" <> xPurchInvHeaderGlobal."Pay-to Country/Region Code") or
                (PurchInvHeader."Buy-from Vendor Name" <> xPurchInvHeaderGlobal."Buy-from Vendor Name") or
                (PurchInvHeader."Buy-from Vendor Name 2" <> xPurchInvHeaderGlobal."Buy-from Vendor Name 2") or
                (PurchInvHeader."Buy-from Address" <> xPurchInvHeaderGlobal."Buy-from Address") or
                (PurchInvHeader."Buy-from Address 2" <> xPurchInvHeaderGlobal."Buy-from Address 2") or
                (PurchInvHeader."Buy-from Post Code" <> xPurchInvHeaderGlobal."Buy-from Post Code") or
                (PurchInvHeader."Buy-from City" <> xPurchInvHeaderGlobal."Buy-from City") or
                (PurchInvHeader."Buy-from Country/Region Code" <> xPurchInvHeaderGlobal."Buy-from Country/Region Code") or
                (PurchInvHeader."Buy-from Contact" <> xPurchInvHeaderGlobal."Buy-from Contact") or
                (PurchInvHeader."VAT Registration No." <> xPurchInvHeaderGlobal."VAT Registration No.") or
                (PurchInvHeader."Concernee DEB" <> xPurchInvHeaderGlobal."Concernee DEB");

    end;

    [EventSubscriber(ObjectType::Page, 1355, OnAfterRecordChanged, '', false, false)] //Editer Facture vente enregistrée
    local procedure P1355_OnAfterRecordChanged(var SalesInvoiceHeader: Record "Sales Invoice Header"; var IsChanged: Boolean; xSalesInvoiceHeader: Record "Sales Invoice Header")
    begin
        IsChanged := IsChanged or
                (SalesInvoiceHeader."Bill-to Name" <> xSalesInvoiceHeader."Bill-to Name") or
                (SalesInvoiceHeader."Bill-to Name 2" <> xSalesInvoiceHeader."Bill-to Name 2") or
                (SalesInvoiceHeader."Bill-to Address" <> xSalesInvoiceHeader."Bill-to Address") or
                (SalesInvoiceHeader."Bill-to Address 2" <> xSalesInvoiceHeader."Bill-to Address 2") or
                (SalesInvoiceHeader."Bill-to Post Code" <> xSalesInvoiceHeader."Bill-to Post Code") or
                (SalesInvoiceHeader."Bill-to City" <> xSalesInvoiceHeader."Bill-to City") or
                (SalesInvoiceHeader."Bill-to Contact" <> xSalesInvoiceHeader."Bill-to Contact") or
                (SalesInvoiceHeader."Bill-to Country/Region Code" <> xSalesInvoiceHeader."Bill-to Country/Region Code") or
                (SalesInvoiceHeader."Sell-to Customer Name" <> xSalesInvoiceHeader."Sell-to Customer Name") or
                (SalesInvoiceHeader."Sell-to Customer Name 2" <> xSalesInvoiceHeader."Sell-to Customer Name 2") or
                (SalesInvoiceHeader."Sell-to Address" <> xSalesInvoiceHeader."Sell-to Address") or
                (SalesInvoiceHeader."Sell-to Address 2" <> xSalesInvoiceHeader."Sell-to Address 2") or
                (SalesInvoiceHeader."Sell-to Post Code" <> xSalesInvoiceHeader."Sell-to Post Code") or
                (SalesInvoiceHeader."Sell-to City" <> xSalesInvoiceHeader."Sell-to City") or
                (SalesInvoiceHeader."Sell-to Country/Region Code" <> xSalesInvoiceHeader."Sell-to Country/Region Code") or
                (SalesInvoiceHeader."Sell-to Contact" <> xSalesInvoiceHeader."Sell-to Contact") or
                (SalesInvoiceHeader."VAT Registration No." <> xSalesInvoiceHeader."VAT Registration No.") or
                (SalesInvoiceHeader."Shipment Method Code" <> xSalesInvoiceHeader."Shipment Method Code") or
                (SalesInvoiceHeader."Number Of Packages" <> xSalesInvoiceHeader."Number Of Packages") or
                (SalesInvoiceHeader."Pallet Number" <> xSalesInvoiceHeader."Pallet Number") or
                (SalesInvoiceHeader."Total Net Weight" <> xSalesInvoiceHeader."Total Net Weight") or
                (SalesInvoiceHeader."Total Gross Weight" <> xSalesInvoiceHeader."Total Gross Weight") or
                (SalesInvoiceHeader."Montant deja verse TTC" <> xSalesInvoiceHeader."Montant deja verse TTC") or
                (SalesInvoiceHeader."External Document No." <> xSalesInvoiceHeader."External Document No.") or
                (SalesInvoiceHeader."Ship-to Name" <> xSalesInvoiceHeader."Ship-to Name") or
                (SalesInvoiceHeader."Ship-to Name 2" <> xSalesInvoiceHeader."Ship-to Name 2") or
                (SalesInvoiceHeader."Ship-to Address" <> xSalesInvoiceHeader."Ship-to Address") or
                (SalesInvoiceHeader."Ship-to Address 2" <> xSalesInvoiceHeader."Ship-to Address 2") or
                (SalesInvoiceHeader."Ship-to City" <> xSalesInvoiceHeader."Ship-to City") or
                (SalesInvoiceHeader."Ship-to Contact" <> xSalesInvoiceHeader."Ship-to Contact") or
                (SalesInvoiceHeader."Ship-to Post Code" <> xSalesInvoiceHeader."Ship-to Post Code") or
                (SalesInvoiceHeader."Ship-to Country/Region Code" <> xSalesInvoiceHeader."Ship-to Country/Region Code") or
                (SalesInvoiceHeader."Concernee DEB" <> xSalesInvoiceHeader."Concernee DEB");

    end;



}

