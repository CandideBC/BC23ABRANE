codeunit 50003 "Packing Management"
{
    Permissions = TableData "Sales Line" = rm,
                  TableData "Sales Shipment Line" = rm;
    TableNo = "Contenu colisage";

    trigger OnRun()
    begin
        /*FHA 03/02/2026
        EnteteColisage.Get(Rec."No. colisage");
        EnteteColisage.TestField("Packing Status",EnteteColisage."Packing Status"::" ");

        SalesShptLine.SetCurrentKey("Sell-to Customer No.");

        if recEnteteListeColisage.Get(Rec."No. colisage") then 
            if recEnteteListeColisage."No. commande" <> '' then
                SalesShptLine.SetRange("Order No.", recEnteteListeColisage."No. commande");

        SalesShptLine.SetRange("Sell-to Customer No.", EnteteColisage."Sell-to Customer No.");
        //SalesShptLine.SetRange("Bill-to Customer No.", EnteteColisage."Bill-To Customer No.");
        SalesShptLine.SetRange("No. colisage", '');
        SalesShptLine.SetRange("Packing in Progress", false);

        GetShipments.SetTableView(SalesShptLine);
        GetShipments.SetSalesHeader(EnteteColisage);
        GetShipments.LookupMode := true;
        if GetShipments.RunModal() <> ACTION::Cancel then;
        */
    end;

    var
        EnteteColisage: Record "Entete colisage";

        SalesShptHeader: Record "Sales Shipment Header";
        //SalesShptLine: Record "Sales Shipment Line";
        recEnteteListeColisage: Record "Entete colisage";
        ContenuColisage: Record "Contenu colisage";
        ShptLineAtt: Record "Sales Shipment Line";
        Item: Record Item;
        //GetShipmentsPage: Page "Colisage : extraire lignes BL";

        LastLineNo: Integer;
        SavLineNo: Integer;

        Text002Msg: Label 'Creating Packing Lines\';
        Text003Msg: Label 'Inserted lines             #1######', Comment = '%1 = Compteur';

    procedure CreateLinesFromShpt(var SalesShptLine2: Record "Sales Shipment Line")
    var
        Window: Dialog;
        LineCount: Integer;

    begin
        LastLineNo := 0;
        if SalesShptLine2.FindSet() then begin
            ContenuColisage.LockTable();
            ContenuColisage.SetRange("No. colisage", EnteteColisage."No.");
            if ContenuColisage.FindLast() then
                LastLineNo := ContenuColisage."No. ligne";

            Window.Open(Text002Msg + Text003Msg);

            repeat
                LineCount := LineCount + 1;
                Window.Update(1, LineCount);
                if SalesShptHeader."No." <> SalesShptLine2."Document No." then
                    SalesShptHeader.Get(SalesShptLine2."Document No.");

                if not Item.Get(SalesShptLine2."No.") then
                    Item.Init();

                //Créer ligne colisage
                LastLineNo += 10000;
                ContenuColisage.Init();
                ContenuColisage."No. colisage" := EnteteColisage."No.";
                ContenuColisage."No. ligne" := LastLineNo;
                ContenuColisage."Shipment No." := SalesShptLine2."Document No.";
                ContenuColisage.Validate("Shipment Line No.", SalesShptLine2."Line No.");
                ContenuColisage.Insert(true);
                SavLineNo := LastLineNo;

                //recherche des lignes commentaires attachées à la ligne de BL
                //------------------------------------------------------------
                ShptLineAtt.SetRange("Document No.", SalesShptLine2."Document No.");
                ShptLineAtt.SetRange(Type, ShptLineAtt.Type::" ");
                ShptLineAtt.SetRange("Attached to Line No.", SalesShptLine2."Line No.");
                if ShptLineAtt.FindSet() then
                    repeat
                        LastLineNo += 10000;
                        ContenuColisage."No. ligne" := LastLineNo;
                        ContenuColisage."Attached to Line No." := SavLineNo;
                        ContenuColisage."Item No." := ShptLineAtt."No.";
                        ContenuColisage.Description := ShptLineAtt.Description;
                        ContenuColisage."Description 2" := ShptLineAtt."Description 2";
                        ContenuColisage."Designation article" := '';
                        //ContenuColisage."Cross-Reference No." := ShptLineAtt."Item Reference No.";
                        ContenuColisage."Quantite UC" := 0;
                        ContenuColisage."Shipment No." := ShptLineAtt."Document No.";
                        ContenuColisage."Shipment Line No." := ShptLineAtt."Line No.";
                        case ShptLineAtt.Type of
                            ShptLineAtt.Type::" ":
                                ContenuColisage.Type := ContenuColisage.Type::" ";
                            ShptLineAtt.Type::"Charge (Item)":
                                ContenuColisage.Type := ContenuColisage.Type::"Charge (Item)";
                            ShptLineAtt.Type::"Fixed Asset":
                                ContenuColisage.Type := ContenuColisage.Type::"Fixed Asset";
                            ShptLineAtt.Type::"G/L Account":
                                ContenuColisage.Type := ContenuColisage.Type::"G/L Account";
                            ShptLineAtt.Type::Item:
                                ContenuColisage.Type := ContenuColisage.Type::Item;
                        end;
                        //ContenuColisage.Type := ShptLineAtt.Type;
                        ContenuColisage."Order No." := ShptLineAtt."Order No.";
                        ContenuColisage."Order Line No." := ShptLineAtt."Order Line No.";
                        ContenuColisage.Insert(true);

                    until ShptLineAtt.Next() = 0;
            until SalesShptLine2.Next() = 0;
        end;

    end;

    procedure SetSalesHeader(var EnteteColisage2: Record "Entete colisage")
    begin
        EnteteColisage.Get(EnteteColisage2."No.");
    end;

    procedure CreateLinesFromOrder(var SalesLine2: Record "Sales Line")
    var
        SalesOrderHeader: Record "Sales Header";
        Window: Dialog;
        LineCount: Integer;

    begin
        LastLineNo := 0;
        if SalesLine2.FindSet() then begin
            ContenuColisage.LockTable();
            ContenuColisage.SetRange("No. colisage", EnteteColisage."No.");
            if ContenuColisage.FindLast() then
                LastLineNo := ContenuColisage."No. ligne";

            Window.Open(Text002Msg + Text003Msg);

            repeat
                LineCount := LineCount + 1;
                Window.Update(1, LineCount);
                if SalesOrderHeader."No." <> SalesLine2."Document No." then
                    SalesOrderHeader.Get(SalesLine2."Document Type", SalesLine2."Document No.");

                if not Item.Get(SalesLine2."No.") then
                    Item.Init();

                //Créer ligne colisage
                LastLineNo += 10000;
                ContenuColisage.Init();
                ContenuColisage."No. colisage" := EnteteColisage."No.";
                ContenuColisage."No. ligne" := LastLineNo;
                ContenuColisage."Order No." := SalesLine2."Document No.";
                ContenuColisage.Validate("Order Line No.", SalesLine2."Line No.");
                ContenuColisage.Insert(true);
                SavLineNo := LastLineNo;
            until SalesLine2.Next() = 0;
        end;
    end;

    procedure GetSalesLines(pContenuColisage: Record "Contenu colisage")
    var
        lSalesLine: Record "Sales Line";
        GetOrderLines: Page "Colisage : extraire lignes cde";
    begin
        EnteteColisage.Get(pContenuColisage."No. colisage");
        EnteteColisage.TestField("Packing Status", EnteteColisage."Packing Status"::" ");
        lSalesLine.SetCurrentKey("Document Type", "Sell-to Customer No.");
        lSalesLine.SetRange("Document Type", lSalesLine."Document Type"::Order);

        if recEnteteListeColisage.Get(pContenuColisage."No. colisage") then
            if recEnteteListeColisage."No. commande" <> '' then
                lSalesLine.SetRange("Document No.", recEnteteListeColisage."No. commande");

        lSalesLine.SetRange("Sell-to Customer No.", EnteteColisage."Sell-to Customer No.");
        //lSalesLine.SetRange("Bill-to Customer No.", EnteteColisage."Bill-To Customer No.");
        lSalesLine.SetRange("Packing in Progress", false);
        lSalesLine.SetFilter("Outstanding Quantity", '<>0');
        GetOrderLines.SetTableView(lSalesLine);
        GetOrderLines.SetSalesHeader(EnteteColisage);
        GetOrderLines.LookupMode := true;
        if GetOrderLines.RunModal() <> ACTION::Cancel then;
    end;

    procedure MAJContenuColisage(var pShptLine: Record "Sales Shipment Line")
    var

        Packing: Record "Entete colisage";
        lSalesLine: Record "Sales Line";
        ContenuColisageLiee: Record "Contenu colisage";
        LignePrepa: Record "Prepa colisage";
    begin
        //Maj depuis validation ligne BL cu 80
        if pShptLine.Quantity = 0 then
            exit;
        if lSalesLine.Get(lSalesLine."Document Type"::Order, pShptLine."Order No.", pShptLine."Order Line No.") then begin
            Packing.Reset();
            Packing.SetCurrentKey("Packing Status", "Sell-to Customer No.");
            Packing.SetRange("Packing Status", Packing."Packing Status"::" ");
            Packing.SetRange("Sell-to Customer No.", pShptLine."Sell-to Customer No.");

            if Packing.FindSet() then
                repeat
                    ContenuColisage.SetRange("No. colisage", Packing."No.");
                    ContenuColisage.SetRange("Order No.", pShptLine."Order No.");
                    ContenuColisage.SetRange("Order Line No.", pShptLine."Order Line No.");
                    ContenuColisage.SetRange("Shipment No.", '');
                    ContenuColisage.SetRange("Shipment Line No.", 0);
                    if ContenuColisage.FindSet(true) then begin
                        //KAN.FHA 06/03/2026 DEBUT
                        LignePrepa.SetRange("No. commande",ContenuColisage."Order No.");
                        LignePrepa.SetRange("No. ligne commande",ContenuColisage."Order Line No.");
                        LignePrepa.DeleteAll();
                        //KAN.FHA 06/03/2026 FIN
                        repeat
                            ContenuColisage."Shipment No." := pShptLine."Document No.";
                            ContenuColisage."Shipment Line No." := pShptLine."Line No.";
                            ContenuColisage."Qte expediee" := pShptLine.Quantity;
                            pShptLine."Packing in Progress" := true;
                            ContenuColisage.Modify();

                            ContenuColisageLiee.SetRange("Order No.", pShptLine."Order No.");
                            ContenuColisageLiee.SetRange(Type, ContenuColisageLiee.Type::" ");
                            ContenuColisageLiee.SetRange("Attached to Line No.", ContenuColisage."No. ligne");
                            if ContenuColisageLiee.FindSet(true) then
                                repeat
                                    ContenuColisageLiee."Shipment No." := pShptLine."Document No.";
                                    ContenuColisageLiee."Shipment Line No." := pShptLine."Order Line No.";
                                    ContenuColisageLiee.Modify();
                                until ContenuColisageLiee.Next() = 0;
                        until ContenuColisage.Next() = 0;
                    end;
                until Packing.Next() = 0;
        end;
    end;
}

