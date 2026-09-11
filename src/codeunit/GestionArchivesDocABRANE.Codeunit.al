codeunit 50005 "Gestion archives doc ABRANE"
{
    procedure CreateSalesDocument(SalesHeaderArchive: Record 5107): Boolean;
    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSerieMgt: Codeunit NoSeriesManagement;
        DocumentSelectionQst: Label 'Devis,Commande';
        NewDocumentNo: Code[20];
        NewDocumentType: Enum "Sales Document Type";
        Selection: Integer;
        DevisCreeMsg: Label 'Le devis n° %1 a été créé.',Comment = '%1 = N° devis';
        CommandeCreeeMsg: Label 'La commande n° %1 a été créée.',Comment = '%1 = N° commande';

    begin
        SalesSetup.GET();

        Selection := STRMENU(DocumentSelectionQst, 1);

        if not (Selection in [1, 2]) then
            exit(false);

        if Selection = 1 then begin
            SalesSetup.TESTFIELD("Quote Nos.");

            NewDocumentType := SalesHeaderArchive."Document Type"::Quote;
            //DIAFTS 07/01/2019 - AT0694017 - Gestion des doc SAV sur une autre souche
            if SalesHeaderArchive.ASS then
                NewDocumentNo := NoSerieMgt.GetNextNo(SalesSetup."Quote Nos.", TODAY, true)
            else
                //DIAFTS 07/01/2019
                NewDocumentNo := NoSerieMgt.GetNextNo(SalesSetup."Quote Nos.", TODAY, true);
        end
        else begin
            SalesSetup.TESTFIELD("Order Nos.");

            NewDocumentType := SalesHeaderArchive."Document Type"::Order;
            //DIAFTS 07/01/2019 - AT0694017 - Gestion des doc SAV sur une autre souche
            if SalesHeaderArchive.ASS then
                NewDocumentNo := NoSerieMgt.GetNextNo(SalesSetup."ASS Order Nos.", TODAY, true)
            else
                //DIAFTS 07/01/2019
                NewDocumentNo := NoSerieMgt.GetNextNo(SalesSetup."Order Nos.", TODAY, true);
        end;

        CreateSalesDocumentHeader(SalesHeaderArchive, NewDocumentType, NewDocumentNo);

        if NewDocumentType = NewDocumentType::Quote then
            MESSAGE(DevisCreeMsg, NewDocumentNo)
        else
            MESSAGE(CommandeCreeeMsg, NewDocumentNo);

        exit(true);
    end;

    local procedure CreateSalesDocumentHeader(SalesHearderArchive: Record 5107; DocumentType: Enum "Sales Document Type"; DocumentNo: Code[20]): Boolean;
    var
        SalesHeader: Record "Sales Header";
        SalesSetup: Record "Sales & Receivables Setup";

    begin
        SalesSetup.GET();
        if DocumentNo = '' then
            exit(false);

        SalesHeader.INIT();

        SalesHeader.VALIDATE("Document Type", DocumentType);
        SalesHeader.VALIDATE("No.", DocumentNo);

        //DIA@FTS 07/01/2019 - AT0694017 - Gestion des doc SAV sur une autre souche
        if SalesHearderArchive.ASS then begin
            SalesHeader."Posting No. Series" := SalesSetup."ASS Posted Invoice Nos.";
            SalesHeader."No. Series" := SalesSetup."ASS Order Nos.";
            SalesHeader.ASS := SalesHearderArchive.ASS;
        end;
        //DIA@FTS 07/01/2019

        SalesHeader.INSERT();

        SalesHeader.VALIDATE("Document Date", TODAY);
        SalesHeader.VALIDATE("Order Date", TODAY);
        if SalesSetup."Default Posting Date" = SalesSetup."Default Posting Date"::"No Date" then
            SalesHeader."Posting Date" := 0D
        else
            SalesHeader.VALIDATE("Posting Date", TODAY);
        SalesHeader.VALIDATE("Sell-to Customer No.", SalesHearderArchive."Sell-to Customer No.");
        SalesHeader.VALIDATE("Bill-to Customer No.", SalesHearderArchive."Bill-to Customer No.");
        SalesHeader.VALIDATE("Posting Description", SalesHearderArchive."Posting Description");
        SalesHeader.VALIDATE("Payment Terms Code", SalesHearderArchive."Payment Terms Code");
        SalesHeader.VALIDATE("Shipment Method Code", SalesHearderArchive."Shipment Method Code");
        SalesHeader.VALIDATE("Ship-to Code", SalesHearderArchive."Ship-to Code");
        SalesHeader.VALIDATE("Location Code", SalesHearderArchive."Location Code");
        SalesHeader.VALIDATE("Shortcut Dimension 1 Code", SalesHearderArchive."Shortcut Dimension 1 Code");
        SalesHeader.VALIDATE("Shortcut Dimension 2 Code", SalesHearderArchive."Shortcut Dimension 2 Code");
        SalesHeader.VALIDATE("Currency Code", SalesHearderArchive."Currency Code");
        SalesHeader.VALIDATE("Salesperson Code", SalesHearderArchive."Salesperson Code");
        SalesHeader.VALIDATE("Responsibility Center", SalesHearderArchive."Responsibility Center");
        SalesHeader.VALIDATE("Responsibility Center", SalesHearderArchive."Responsibility Center");
        SalesHeader.VALIDATE("Dimension Set ID", SalesHearderArchive."Dimension Set ID");

        SalesHeader.MODIFY();

        exit(CreateSalesDocumentLine(SalesHearderArchive, DocumentType, DocumentNo));
    end;

    local procedure CreateSalesDocumentLine(SalesHearderArchive: Record 5107; DocumentType: Enum "Sales Document Type"; DocumentNo: Code[20]): Boolean;
    var
        SalesLineArchive: Record "Sales Line Archive";
        SalesLine: Record "Sales Line";
        LineNo: Integer;
    begin
        SalesLineArchive.RESET();

        SalesLineArchive.SETRANGE("Document Type", SalesHearderArchive."Document Type");
        SalesLineArchive.SETRANGE("Document No.", SalesHearderArchive."No.");
        SalesLineArchive.SETRANGE("Doc. No. Occurrence", SalesHearderArchive."Doc. No. Occurrence");
        SalesLineArchive.SETRANGE("Version No.", SalesHearderArchive."Version No.");

        if SalesHearderArchive.FINDFIRST() then
            repeat
                LineNo += 10000;
                SalesLine.INIT();
                SalesLine.VALIDATE("Document Type", DocumentType);
                SalesLine.VALIDATE("Document No.", DocumentNo);
                SalesLine.VALIDATE("Line No.", LineNo);
                SalesLine.VALIDATE(Type, SalesLineArchive.Type);

                if SalesLineArchive.Type = SalesLineArchive.Type::" " then
                    SalesLine.VALIDATE(Description, SalesLineArchive.Description)
                else begin
                    SalesLine.VALIDATE("No.", SalesLineArchive."No.");
                    SalesLine.VALIDATE(Description, SalesLineArchive.Description);
                    SalesLine.VALIDATE("Location Code", SalesLineArchive."Location Code");
                    SalesLine.VALIDATE("Unit of Measure", SalesLineArchive."Unit of Measure");
                    SalesLine.VALIDATE(Quantity, SalesLineArchive.Quantity);
                    SalesLine.VALIDATE("Line Discount %", SalesLineArchive."Line Discount %");
                    SalesLine.VALIDATE("Line Discount Amount", SalesLineArchive."Line Discount Amount");
                    SalesLine.VALIDATE("Unit Volume", SalesLineArchive."Unit Volume");
                    SalesLine.VALIDATE("Gross Weight", SalesLineArchive."Gross Weight");
                    SalesLine.VALIDATE("Net Weight", SalesLineArchive."Net Weight");

                    SalesLine.INSERT();

                    SalesLine.VALIDATE("Shortcut Dimension 1 Code", SalesLineArchive."Shortcut Dimension 1 Code");
                    SalesLine.VALIDATE("Shortcut Dimension 2 Code", SalesLineArchive."Shortcut Dimension 2 Code");
                    SalesLine.VALIDATE("Dimension Set ID", SalesLineArchive."Dimension Set ID");

                    SalesLine.MODIFY();
                end;

            until SalesLineArchive.NEXT() = 0;

        exit(true);
    end;

    PROCEDURE CreatePurchDocument(PurchHearderArchive: Record 5109): Boolean;
    VAR

        PurchSetup: Record "Purchases & Payables Setup";
        NoSerieMgt: Codeunit NoSeriesManagement;
        NewDocumentNo: Code[20];
        NewDocumentType: Enum "Purchase Document Type";
        Selection: Integer;
        SelectionDocumentQst: Label 'Devis,Commande';
        DevisCreeMsg: Label 'Le devis N°%1 a été créé.',Comment = '%1 = N° devis';
        CommandeCreeeMsg: Label 'La commande N°%1 a été créée.',Comment = '%1 = N° commande';
    BEGIN
        PurchSetup.GET();

        Selection := STRMENU(SelectionDocumentQst, 1);

        IF NOT (Selection IN [1, 2]) THEN
            EXIT(FALSE);

        IF Selection = 1 THEN BEGIN
            PurchSetup.TESTFIELD("Quote Nos.");

            NewDocumentType := PurchHearderArchive."Document Type"::Quote;
            NewDocumentNo := NoSerieMgt.GetNextNo(PurchSetup."Quote Nos.", TODAY, TRUE);
        END
        ELSE BEGIN
            PurchSetup.TESTFIELD("Order Nos.");

            NewDocumentType := PurchHearderArchive."Document Type"::Order;
            NewDocumentNo := NoSerieMgt.GetNextNo(PurchSetup."Order Nos.", TODAY, TRUE);
        END;

        CreatePurchDocumentHeader(PurchHearderArchive, NewDocumentType, NewDocumentNo);

        IF NewDocumentType = NewDocumentType::Quote then
            MESSAGE(DevisCreeMsg, NewDocumentNo)
        ELSE
            MESSAGE(CommandeCreeeMsg, NewDocumentNo);

        EXIT(TRUE);
    END;

    LOCAL PROCEDURE CreatePurchDocumentHeader(PurchHearderArchive: Record 5109; DocumentType: Enum "Purchase Document Type"; DocumentNo: Code[20]): Boolean;
    VAR
        PurchHeader: Record "Purchase Header";
        PurchSetup: Record "Purchases & Payables Setup";
        //SelectionDocumentQst: Label 'Devis,Commande';

    BEGIN
        PurchSetup.GET();
        IF DocumentNo = '' THEN
            EXIT(FALSE);

        PurchHeader.INIT();

        PurchHeader.VALIDATE("Document Type", DocumentType);
        PurchHeader.VALIDATE("No.", DocumentNo);

        PurchHeader.INSERT();

        PurchHeader.VALIDATE("Document Date", TODAY);
        PurchHeader.VALIDATE("Order Date", TODAY);
        IF PurchSetup."Default Posting Date" = PurchSetup."Default Posting Date"::"No Date" THEN
            PurchHeader."Posting Date" := 0D
        ELSE
            PurchHeader.VALIDATE("Posting Date", TODAY);
        PurchHeader.VALIDATE("Buy-from Vendor No.", PurchHearderArchive."Buy-from Vendor No.");
        PurchHeader.VALIDATE("Pay-to Vendor No.", PurchHearderArchive."Pay-to Vendor No.");
        PurchHeader.VALIDATE("Posting Description", PurchHearderArchive."Posting Description");
        PurchHeader.VALIDATE("Payment Terms Code", PurchHearderArchive."Payment Terms Code");
        PurchHeader.VALIDATE("Shipment Method Code", PurchHearderArchive."Shipment Method Code");
        IF PurchHearderArchive."Sell-to Customer No." <> '' THEN
            PurchHeader.VALIDATE("Sell-to Customer No.", PurchHearderArchive."Sell-to Customer No.");
        IF PurchHearderArchive."Ship-to Code" <> '' THEN
            PurchHeader.VALIDATE("Ship-to Code", PurchHearderArchive."Ship-to Code");
        PurchHeader.VALIDATE("Location Code", PurchHearderArchive."Location Code");
        PurchHeader.VALIDATE("Shortcut Dimension 1 Code", PurchHearderArchive."Shortcut Dimension 1 Code");
        PurchHeader.VALIDATE("Shortcut Dimension 2 Code", PurchHearderArchive."Shortcut Dimension 2 Code");
        PurchHeader.VALIDATE("Currency Code", PurchHearderArchive."Currency Code");
        PurchHeader.VALIDATE("Purchaser Code", PurchHearderArchive."Purchaser Code");
        PurchHeader.VALIDATE("Responsibility Center", PurchHearderArchive."Responsibility Center");
        PurchHeader.VALIDATE("Responsibility Center", PurchHearderArchive."Responsibility Center");
        PurchHeader.VALIDATE("Dimension Set ID", PurchHearderArchive."Dimension Set ID");
        //DIAG-NBR-20190715- AT0700670- ADDIT Nø SERIES -START
        PurchHeader.VALIDATE("Posting No. Series", PurchHearderArchive."Posting No. Series");
        PurchHeader.VALIDATE("Receiving No. Series", PurchHearderArchive."Receiving No. Series");
        //DIAG-NBR-20190715- AT0700670- ADDIT Nø SERIES- STOP

        PurchHeader.MODIFY();

        EXIT(CreatePurchDocumentLine(PurchHearderArchive, DocumentType, DocumentNo));
    END;

    LOCAL PROCEDURE CreatePurchDocumentLine(PurchHearderArchive : Record 5109; DocumentType: Enum "Purchase Document Type"; DocumentNo : Code[20]): Boolean;
    VAR
      purchLineArchive : Record "Purchase Line Archive";
      PurchLine : Record "Purchase Line";
      //SelectionDocumentQst : Label 'Devis,Commande';
      LineNo : Integer;

    BEGIN
        purchLineArchive.RESET();

        purchLineArchive.SETRANGE("Document Type", PurchHearderArchive."Document Type");
        purchLineArchive.SETRANGE("Document No.", PurchHearderArchive."No.");
        purchLineArchive.SETRANGE("Doc. No. Occurrence", PurchHearderArchive."Doc. No. Occurrence");
        purchLineArchive.SETRANGE("Version No.", PurchHearderArchive."Version No.");

        IF PurchHearderArchive.FINDFIRST() then
            REPEAT
            
                LineNo += 10000;

                PurchLine.INIT();
                PurchLine.VALIDATE("Document Type", DocumentType);
                PurchLine.VALIDATE("Document No.", DocumentNo);
                PurchLine.VALIDATE("Line No.", LineNo);
                PurchLine.VALIDATE(Type, purchLineArchive.Type);

                IF purchLineArchive.Type = purchLineArchive.Type::" " THEN BEGIN
                    PurchLine.VALIDATE(Description, purchLineArchive.Description);
                    PurchLine.INSERT();
                END
                ELSE BEGIN
                    PurchLine.VALIDATE("No.", purchLineArchive."No.");
                    PurchLine.VALIDATE(Description, purchLineArchive.Description);
                    PurchLine.VALIDATE("Location Code", purchLineArchive."Location Code");
                    PurchLine.VALIDATE("Unit of Measure", purchLineArchive."Unit of Measure");
                    PurchLine.VALIDATE(Quantity, purchLineArchive.Quantity);
                    PurchLine.VALIDATE("Line Discount %", purchLineArchive."Line Discount %");
                    PurchLine.VALIDATE("Line Discount Amount", purchLineArchive."Line Discount Amount");
                    PurchLine.VALIDATE("Unit Volume", purchLineArchive."Unit Volume");
                    PurchLine.VALIDATE("Gross Weight", purchLineArchive."Gross Weight");
                    PurchLine.VALIDATE("Net Weight", purchLineArchive."Net Weight");

                    PurchLine.INSERT();

                    PurchLine.VALIDATE("Shortcut Dimension 1 Code", purchLineArchive."Shortcut Dimension 1 Code");
                    PurchLine.VALIDATE("Shortcut Dimension 2 Code", purchLineArchive."Shortcut Dimension 2 Code");
                    PurchLine.VALIDATE("Dimension Set ID", purchLineArchive."Dimension Set ID");

                    PurchLine.MODIFY();
                END;
            
            UNTIL purchLineArchive.NEXT() = 0;

        EXIT(TRUE);
    END;
}
