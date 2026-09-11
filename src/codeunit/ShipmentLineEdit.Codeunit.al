codeunit 50002 "Shipment Line - Edit"
{
    Permissions = TableData "Sales Shipment Header" = rm,
                  TableData "Sales Shipment Line" = rm;
    TableNo = "Sales Shipment Line";

    trigger OnRun()
    begin
        SalesShptLine := Rec;
        SalesShptLine.LockTable();
        SalesShptLine.Find();
        SalesShptLine."Quantite a remettre en stock" := Rec."Quantite a remettre en stock";
        SalesShptLine.Modify();
        Rec := SalesShptLine;
    end;

    var
        SalesShptLine: Record "Sales Shipment Line";

    procedure RemettreEnStock(pSalesShptHeader: Record "Sales Shipment Header")
    var
        lItemJnlLine: Record "Item Journal Line";
        
        InvSetup: Record "Inventory Setup";
        ItemJnlTemplate: Record "Item Journal Template";
        Batch: Record "Item Journal Batch";
        lEcr: Record "Item Ledger Entry";
        SalesShptLine2: Record "Sales Shipment Line";
        ItemJnlPostBatch: Codeunit "Item Jnl.-Post Batch";
        LineNo: Integer;
        

        BatchName: Code[20];
        ConfirmQst: Label 'Voulez-vous remettre en stock les quantités saisies [Qté à remettre en stock] ?';
        NothingToPostMsg: Label 'Il n''y a rien à remettre en stock (aucune ligne ne montre de [Qté à remettre en stock]).';

        
    begin
        if not Confirm(ConfirmQst) then
            exit;

        pSalesShptHeader.TestField("Code magasin remise en stock");
        pSalesShptHeader.TestField("Date remise en stock");

        InvSetup.Get();
        InvSetup.TestField("Mod. feuil. art. remise stk BL");

        BatchName := pSalesShptHeader."No.";

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

        SalesShptLine.Reset();
        SalesShptLine.SetRange("Document No.", pSalesShptHeader."No.");
        SalesShptLine.SetRange(Type, SalesShptLine.Type::Item);
        SalesShptLine.SetRange(Correction, false);
        SalesShptLine.SetFilter("Quantite a remettre en stock", '<>%1', 0);
        if SalesShptLine.FindSet(false) then begin
            repeat
                lEcr.Get(SalesShptLine."Item Shpt. Entry No.");

                lItemJnlLine.Init();
                lItemJnlLine."Journal Template Name" := InvSetup."Mod. feuil. art. remise stk BL";
                lItemJnlLine."Journal Batch Name" := BatchName;
                lItemJnlLine."Line No." := LineNo;
                lItemJnlLine.Insert();

                lItemJnlLine."Posting Date" := pSalesShptHeader."Date remise en stock";
                lItemJnlLine."Document Date" := WorkDate();
                lItemJnlLine."Document No." := pSalesShptHeader."No.";
                lItemJnlLine."Entry Type" := lItemJnlLine."Entry Type"::"Positive Adjmt.";
                lItemJnlLine.Validate("Item No.", SalesShptLine."No.");
                lItemJnlLine.Validate("Variant Code", SalesShptLine."Variant Code");
                lItemJnlLine."Dimension Set ID" := SalesShptLine."Dimension Set ID";
                lItemJnlLine."Location Code" := pSalesShptHeader."Code magasin remise en stock";
                lItemJnlLine.Validate("Unit of Measure Code", SalesShptLine."Unit of Measure Code");
                lItemJnlLine.Validate(Quantity, SalesShptLine."Quantite a remettre en stock");
                lItemJnlLine.Validate("Unit Cost", (lEcr."Cost Amount (Expected)" + lEcr."Cost Amount (Actual)") / lEcr.Quantity);
                lItemJnlLine."Source Code" := ItemJnlTemplate."Source Code";
                lItemJnlLine."Remis en stock depuis BL" := true;
                lItemJnlLine.Modify();
                SalesShptLine2.Get(SalesShptLine."Document No.", SalesShptLine."Line No.");
                SalesShptLine2."Quantite deja remise en stock" := SalesShptLine2."Quantite deja remise en stock" + SalesShptLine2."Quantite a remettre en stock";
                SalesShptLine2."Quantite a remettre en stock" := 0;
                SalesShptLine2.Modify();
                LineNo += 10000;
            until SalesShptLine.Next() = 0;
            ItemJnlPostBatch.Run(lItemJnlLine);
            pSalesShptHeader."Code magasin remise en stock" := '';
            pSalesShptHeader."Date remise en stock" := 0D;
            pSalesShptHeader.Modify();
            BatchName := IncStr(BatchName);
            if Batch.Get(InvSetup."Mod. feuil. art. remise stk BL", BatchName) then
                Batch.Delete(true);

        end else
            Message(NothingToPostMsg);
    end;
}

