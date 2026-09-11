codeunit 50001 "Eclater nomenclature ABRANE"
{
    TableNo = "Sales Line";

    trigger OnRun()
    var

    begin
        Rec.TestField(Type, Rec.Type::Item);
        Rec.TestField("Quantity Shipped", 0);
        Rec.TestField("Return Qty. Received", 0);
        Rec.Validate("Qty. to Assemble to Order", 0);
        if Rec."Purch. Order Line No." <> 0 then
            Error(
              Text000Err,
              Rec."Purchase Order No.");
        if Rec."Job Contract Entry No." <> 0 then begin
            Rec.TestField("Job No.", '');
            Rec.TestField("Job Contract Entry No.", 0);
        end;
        SalesHeader.Get(Rec."Document Type", Rec."Document No.");
        SalesHeader.TestField(Status, SalesHeader.Status::Open);
        FromBOMComp.SetRange("Parent Item No.", Rec."No.");
        NoOfBOMComp := FromBOMComp.Count;

        if NoOfBOMComp = 0 then
            Error(
              Text001Err,
              Rec."No.");

        if Rec."BOM Item No." = '' then
            BOMItemNo := Rec."No."
        else
            BOMItemNo := Rec."BOM Item No.";

        ToSalesLine := Rec;
        ToSalesLine.Init();
        ToSalesLine.Type := Rec.Type::Item;
        ToSalesLine.Validate("No.", Rec."No.");
        ToSalesLine.Description := Rec.Description;
        ToSalesLine."Description 2" := Rec."Description 2";
        ToSalesLine."Location Code" := Rec."Location Code";
        ToSalesLine."Variant Code" := Rec."Variant Code";
        ToSalesLine.Validate(Quantity, Rec.Quantity);
        ToSalesLine."Unit Cost" := 0;
        ToSalesLine."Unit Cost (LCY)" := 0;
        ToSalesLine.Validate("Unit Price", Rec."Unit Price");
        ToSalesLine.Validate("Qty. to Assemble to Order", 0);
        ToSalesLine."Ligne eclatee" := true;
        ToSalesLine.Modify();
        ToSalesLine2 := ToSalesLine;

        if TransferExtendedText.SalesCheckIfAnyExtText(ToSalesLine, false) then
            TransferExtendedText.InsertSalesExtText(ToSalesLine);

        ExplodeBOMCompLines(Rec);

        //KAN.FHA 06/11/2024 DEBUT
        Rec."Ligne eclatee" := true;
        //KAN.FHA 06/11/2024 FIN
    end;

    var
        ToSalesLine: Record "Sales Line";
        FromBOMComp: Record "BOM Component";
        SalesHeader: Record "Sales Header";
        ItemTranslation: Record "Item Translation";
        Item: Record Item;
        ToSalesLine2: Record "Sales Line";
        UOMMgt: Codeunit "Unit of Measure Management";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        dNegDEEE: Codeunit "Gestion Ecopart";
        Text000Err: Label 'La nomenclature ne peut pas être éclatée car elle est liée à la commande achat %1.', Comment = '%1 = N° commande achat';
        Text001Err: Label 'L''article %1 n''est pas une nomenclature', Comment = '%1 = N° article';
        Text003Err: Label 'Pas assez de place pour éclater la nomenclature';

        BOMItemNo: Code[20];
        LineSpacing: Integer;
        NextLineNo: Integer;
        NoOfBOMComp: Integer;

    local procedure ExplodeBOMCompLines(SalesLine: Record "Sales Line")
    var
        PreviousSalesLine: Record "Sales Line";
    begin
        ToSalesLine.Reset();
        ToSalesLine.SetRange("Document Type", SalesLine."Document Type");
        ToSalesLine.SetRange("Document No.", SalesLine."Document No.");
        ToSalesLine := SalesLine;
        if ToSalesLine.Find('>') then begin
            LineSpacing := (ToSalesLine."Line No." - SalesLine."Line No.") div (1 + NoOfBOMComp);
            if LineSpacing = 0 then
                Error(Text003Err);
        end else
            LineSpacing := 100;

        FromBOMComp.Reset();
        FromBOMComp.SetRange("Parent Item No.", SalesLine."No.");
        FromBOMComp.FindSet();
        NextLineNo := SalesLine."Line No.";
        repeat
            ToSalesLine.Init();
            NextLineNo := NextLineNo + LineSpacing;
            ToSalesLine."Line No." := NextLineNo;
            case FromBOMComp.Type of
                FromBOMComp.Type::" ":
                    ToSalesLine.Type := ToSalesLine.Type::" ";
                FromBOMComp.Type::Item:
                    ToSalesLine.Type := ToSalesLine.Type::Item;
                FromBOMComp.Type::Resource:
                    ToSalesLine.Type := ToSalesLine.Type::Resource;
            end;
            if ToSalesLine.Type <> ToSalesLine.Type::" " then begin
                FromBOMComp.TestField("No.");
                ToSalesLine.Validate("No.", FromBOMComp."No.");

                ToSalesLine.Validate("Location Code", SalesLine."Location Code");

                if FromBOMComp."Variant Code" <> '' then
                    ToSalesLine.Validate("Variant Code", FromBOMComp."Variant Code");
                if ToSalesLine.Type = ToSalesLine.Type::Item then begin
                    ToSalesLine."Drop Shipment" := SalesLine."Drop Shipment";
                    Item.Get(FromBOMComp."No.");
                    ToSalesLine.Validate("Unit of Measure Code", FromBOMComp."Unit of Measure Code");
                    ToSalesLine."Qty. per Unit of Measure" := UOMMgt.GetQtyPerUnitOfMeasure(Item, ToSalesLine."Unit of Measure Code");
                    ToSalesLine."Quantite pour 1" := FromBOMComp."Quantity per";
                    ToSalesLine.Validate(Quantity,
                      Round(
                        SalesLine."Quantity (Base)" * FromBOMComp."Quantity per" *
                        UOMMgt.GetQtyPerUnitOfMeasure(Item, ToSalesLine."Unit of Measure Code") /
                        ToSalesLine."Qty. per Unit of Measure",
                        0.00001));
                end else
                    ToSalesLine.Validate(Quantity, SalesLine."Quantity (Base)" * FromBOMComp."Quantity per");

                if SalesHeader."Shipment Date" <> SalesLine."Shipment Date" then
                    ToSalesLine.Validate("Shipment Date", SalesLine."Shipment Date");
            end;

            if SalesHeader."Language Code" = '' then
                ToSalesLine.Description := FromBOMComp.Description
            else
                if not ItemTranslation.Get(FromBOMComp."No.", FromBOMComp."Variant Code", SalesHeader."Language Code") then
                    ToSalesLine.Description := FromBOMComp.Description;

            ToSalesLine."BOM Item No." := BOMItemNo;

            ToSalesLine."Linked to line" := SalesLine."Line No.";
            ToSalesLine.Validate("Unit Price", 0);
            ToSalesLine."Prix bloque" := true;
            ToSalesLine.Insert();

            ToSalesLine."Shortcut Dimension 1 Code" := SalesLine."Shortcut Dimension 1 Code";
            ToSalesLine."Shortcut Dimension 2 Code" := SalesLine."Shortcut Dimension 2 Code";
            ToSalesLine."Dimension Set ID" := SalesLine."Dimension Set ID";
            ToSalesLine.Modify();

            if PreviousSalesLine."Document No." <> '' then
                if TransferExtendedText.SalesCheckIfAnyExtText(PreviousSalesLine, false) then
                    TransferExtendedText.InsertSalesExtText(PreviousSalesLine);

            PreviousSalesLine := ToSalesLine;
        until FromBOMComp.Next() = 0;

        if TransferExtendedText.SalesCheckIfAnyExtText(ToSalesLine, false) then
            TransferExtendedText.InsertSalesExtText(ToSalesLine);
        if dNegDEEE.SalesCheckIfAnyWEEE(ToSalesLine2) then
            dNegDEEE.InsertWEEELine(ToSalesLine2);
    end;
}

