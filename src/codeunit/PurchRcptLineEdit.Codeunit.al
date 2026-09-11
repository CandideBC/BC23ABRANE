codeunit 50004 "Purch. Rcpt. Line - Edit"
{
    Permissions = TableData "Purch. Rcpt. Header" = rm,
                  TableData "Purch. Rcpt. Line" = rm;
    TableNo = "Purch. Rcpt. Line";

    trigger OnRun()
    begin
        PurchRcptLine := Rec;
        PurchRcptLine.LockTable();
        PurchRcptLine.Find();
        PurchRcptLine."Quantite a transferer" := Rec."Quantite a transferer";
        PurchRcptLine.Modify();
        Rec := PurchRcptLine;
    end;

    var
        PurchRcptLine: Record "Purch. Rcpt. Line";

    procedure Transferer(pPurchRcptHeader: Record "Purch. Rcpt. Header")
    var
        lItemJnlLine: Record "Item Journal Line";
        
        InvSetup: Record "Inventory Setup";
        ItemJnlTemplate: Record "Item Journal Template";
        Batch: Record "Item Journal Batch";
        PurchRcptLine2: Record "Purch. Rcpt. Line";
        lEcr: Record "Item Ledger Entry";
        ItemJnlPostBatch: Codeunit "Item Jnl.-Post Batch";

        LineNo: Integer;
                
        BatchName: Code[20];
        ConfirmQst: Label 'Voulez-vous transférer les quantités saisies [Qté à transférer] ?';
        NothingToPostMsg: Label 'Il n''y a rien à transférer (aucune ligne ne montre de [Qté à transférer]).';
        
        
    begin
        if not Confirm(ConfirmQst) then
            exit;

        pPurchRcptHeader.TestField("Code magasin transfert");
        pPurchRcptHeader.TestField("Date transfert");

        InvSetup.Get();
        InvSetup.TestField("Mod. feuil. recl. transf. rcpt");

        BatchName := pPurchRcptHeader."No.";

        if StrLen(BatchName) > 10 then
            BatchName := CopyStr(BatchName, StrLen(BatchName) - 9, 10);  //9 derniers caracteres

        ItemJnlTemplate.Get(InvSetup."Mod. feuil. recl. transf. rcpt");

        if Batch.Get(InvSetup."Mod. feuil. recl. transf. rcpt", BatchName) then
            Batch.Delete(true);

        Batch.Init();
        Batch."Journal Template Name" := InvSetup."Mod. feuil. recl. transf. rcpt";
        Batch.Name := BatchName;
        Batch.Insert();

        LineNo := 10000;

        PurchRcptLine.Reset();
        PurchRcptLine.SetRange("Document No.", pPurchRcptHeader."No.");
        PurchRcptLine.SetRange(Type, PurchRcptLine.Type::Item);
        PurchRcptLine.SetRange(Correction, false);
        PurchRcptLine.SetFilter("Quantite a transferer", '<>%1', 0);
        if PurchRcptLine.FindSet(false) then begin
            repeat
                lEcr.Get(PurchRcptLine."Item Rcpt. Entry No.");

                lItemJnlLine.Init();
                lItemJnlLine."Journal Template Name" := InvSetup."Mod. feuil. recl. transf. rcpt";
                lItemJnlLine."Journal Batch Name" := BatchName;
                lItemJnlLine."Line No." := LineNo;
                lItemJnlLine.Insert();
                lItemJnlLine."Posting Date" := pPurchRcptHeader."Date transfert";
                lItemJnlLine."Document Date" := WorkDate();
                lItemJnlLine."Document No." := pPurchRcptHeader."No.";
                lItemJnlLine."Entry Type" := lItemJnlLine."Entry Type"::Transfer;
                lItemJnlLine.Validate("Item No.", PurchRcptLine."No.");
                lItemJnlLine.Validate("Variant Code", PurchRcptLine."Variant Code");
                lItemJnlLine."Dimension Set ID" := PurchRcptLine."Dimension Set ID";
                lItemJnlLine."Location Code" := PurchRcptLine."Location Code";
                lItemJnlLine."New Location Code" := pPurchRcptHeader."Code magasin transfert";
                lItemJnlLine.Validate("Unit of Measure Code", PurchRcptLine."Unit of Measure Code");
                lItemJnlLine.Validate(Quantity, PurchRcptLine."Quantite a transferer");
                lItemJnlLine.Validate("Unit Cost", (lEcr."Cost Amount (Expected)" + lEcr."Cost Amount (Actual)") / lEcr.Quantity);
                lItemJnlLine."Source Code" := ItemJnlTemplate."Source Code";
                lItemJnlLine."Transfert reception achat" := true;
                lItemJnlLine.Modify();
                PurchRcptLine2.Get(PurchRcptLine."Document No.", PurchRcptLine."Line No.");
                PurchRcptLine2."Quantite deja transferee" := PurchRcptLine2."Quantite deja transferee" + PurchRcptLine2."Quantite a transferer";
                PurchRcptLine2."Quantite a transferer" := 0;
                PurchRcptLine2.Modify();
                LineNo += 10000;
            until PurchRcptLine.Next() = 0;
            ItemJnlPostBatch.Run(lItemJnlLine);
            pPurchRcptHeader."Code magasin transfert" := '';
            pPurchRcptHeader."Date transfert" := 0D;
            pPurchRcptHeader.Modify();
            BatchName := IncStr(BatchName);
            if Batch.Get(InvSetup."Mod. feuil. recl. transf. rcpt", BatchName) then
                Batch.Delete(true);

        end else
            Message(NothingToPostMsg);
    end;
}

