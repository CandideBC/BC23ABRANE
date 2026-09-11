codeunit 50008 "Apply entries"
{

    trigger OnRun()
    begin
    end;

    var
        TempBuff: Record "Line Number Buffer" temporary;
        LettrageErr: Label 'Erreur de calcul dans le lettrage, écriture %1.',Comment = '%1 = Ecriture';

    procedure NumberToLetterCust(CustLedgerEntry: Record "Cust. Ledger Entry") Letter: Text[30]
    var
        i: Integer;
        Sequence: Text[30];
        Char: Char;
        j: Integer;
    begin
        j := 0;
        if not CustLedgerEntry.Reversed then
            while ((CustLedgerEntry."Closed by Entry No." <> 0) and (j < 1000)) do begin
                CustLedgerEntry.Get(CustLedgerEntry."Closed by Entry No.");
                j += 1;
            end;

        if j >= 1000 then
            Error(LettrageErr);

        CustLedgerEntry.CalcFields("Applied Cust. Ledger Entry No.");
        if (CustLedgerEntry."Applied Cust. Ledger Entry No." = 0) then
            exit('');

        Sequence := Format(CustLedgerEntry."Applied Cust. Ledger Entry No.");

        for i := 1 to StrLen(Sequence) do begin
            Char := Sequence[i] + 17;
            Letter := Letter + Format(Char);
        end;

        CustLedgerEntry.SetCurrentKey("Customer No.", Open);
        CustLedgerEntry.SetRange("Customer No.", CustLedgerEntry."Customer No.");
        CustLedgerEntry.SetRange(Open, true);
        CustLedgerEntry.SetRange("Applied Cust. Ledger Entry No.", CustLedgerEntry."Applied Cust. Ledger Entry No.");
        if not CustLedgerEntry.IsEmpty then
            Letter := LowerCase(Letter);
    end;

    procedure NumberToLetterVend(VendLedgerEntry: Record "Vendor Ledger Entry") Letter: Text[30]
    var
        i: Integer;
        Sequence: Text[30];
        Char: Char;
        j: Integer;
    begin
        j := 0;
        if not VendLedgerEntry.Reversed then
            while ((VendLedgerEntry."Closed by Entry No." <> 0) and (j < 1000)) do begin
                VendLedgerEntry.Get(VendLedgerEntry."Closed by Entry No.");
                j += 1;
            end;

        if j >= 1000 then
            Error(LettrageErr);

        VendLedgerEntry.CalcFields("Applied Vend. Ledger Entry No.");
        if (VendLedgerEntry."Applied Vend. Ledger Entry No." = 0) then
            exit('');

        Sequence := Format(VendLedgerEntry."Applied Vend. Ledger Entry No.");

        for i := 1 to StrLen(Sequence) do begin
            Char := Sequence[i] + 17;
            Letter := Letter + Format(Char);
        end;

        VendLedgerEntry.SetCurrentKey("Vendor No.", Open);
        VendLedgerEntry.SetRange("Vendor No.", VendLedgerEntry."Vendor No.");
        VendLedgerEntry.SetRange(Open, true);
        VendLedgerEntry.SetRange("Applied Vend. Ledger Entry No.", VendLedgerEntry."Applied Vend. Ledger Entry No.");
        if not VendLedgerEntry.IsEmpty then
            Letter := LowerCase(Letter);
    end;

    procedure CustFilterOnApply(var CustLedgerEntry: Record "Cust. Ledger Entry")
    begin
        CustLedgerEntry.ClearMarks();

        if CustLedgerEntry.MarkedOnly then begin
            CustLedgerEntry.MarkedOnly(false);
            exit;
        end;
        //Rechercher les lettrages ascendants
        while (CustLedgerEntry."Closed by Entry No." <> 0) do 
            CustLedgerEntry.Get(CustLedgerEntry."Closed by Entry No.");

        CustLedgerEntry.Mark(true);
        TempBuff.DeleteAll();
        SearchFinalCustEntry(CustLedgerEntry."Entry No.");
        if TempBuff.FindSet() then
            repeat
                CustLedgerEntry.Get(TempBuff."Old Line Number");
                CustLedgerEntry.Mark(true);
            until TempBuff.Next() = 0;

        CustLedgerEntry.MarkedOnly(true);
    end;

    local procedure SearchFinalCustEntry(EntryNo: Integer)
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgerEntry.SetCurrentKey("Closed by Entry No.");
        CustLedgerEntry.SetRange("Closed by Entry No.", EntryNo);
        CustLedgerEntry.SetFilter("Entry No.", '<>%1', EntryNo);
        if CustLedgerEntry.FindSet() then
            repeat
                if not TempBuff.Get(CustLedgerEntry."Entry No.") then begin
                    TempBuff."Old Line Number" := CustLedgerEntry."Entry No.";
                    TempBuff.Insert();
                end;

                SearchFinalCustEntry(CustLedgerEntry."Entry No.");
            until CustLedgerEntry.Next() = 0;
    end;

    procedure VendFilterOnApply(var VendLedgerEntry: Record "Vendor Ledger Entry")
    begin
        VendLedgerEntry.ClearMarks();

        if VendLedgerEntry.MarkedOnly then begin
            VendLedgerEntry.MarkedOnly(false);
            exit;
        end;
        //Rechercher les lettrages ascendants
        while (VendLedgerEntry."Closed by Entry No." <> 0) do
            VendLedgerEntry.Get(VendLedgerEntry."Closed by Entry No.");
        

        VendLedgerEntry.Mark(true);
        TempBuff.DeleteAll();

        SearchFinalVendEntry(VendLedgerEntry."Entry No.");
        if TempBuff.FindSet() then
            repeat
                VendLedgerEntry.Get(TempBuff."Old Line Number");
                VendLedgerEntry.Mark(true);
            until TempBuff.Next() = 0;

        VendLedgerEntry.MarkedOnly(true);
    end;

    local procedure SearchFinalVendEntry(EntryNo: Integer)
    var
        VendLedgerEntry: Record "Vendor Ledger Entry";
    begin
        VendLedgerEntry.SetCurrentKey("Closed by Entry No.");
        VendLedgerEntry.SetRange("Closed by Entry No.", EntryNo);
        VendLedgerEntry.SetFilter("Entry No.", '<>%1', EntryNo);
        if VendLedgerEntry.FindSet() then
            repeat
                if not TempBuff.Get(VendLedgerEntry."Entry No.") then begin
                    TempBuff."Old Line Number" := VendLedgerEntry."Entry No.";
                    TempBuff.Insert();
                end;

                SearchFinalVendEntry(VendLedgerEntry."Entry No.");
            until VendLedgerEntry.Next() = 0;
    end;
}

