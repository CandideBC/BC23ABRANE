page 50035 "Update Description Entry"
{
    ApplicationArea = All;
    UsageCategory = None;
    Caption = 'Update Description Entry';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    Permissions = TableData "G/L Entry" = rm,
                  TableData "Cust. Ledger Entry" = rm,
                  TableData "Vendor Ledger Entry" = rm,
                  TableData "Bank Account Ledger Entry" = rm;
    SourceTable = "G/L Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date comptabilisation';
                    Editable = false;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Type document';
                    Editable = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'N° document';
                    Editable = false;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'N° doc. externe';
                    Editable = false;
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'N° compte général';
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Description';

                    trigger OnValidate()
                    begin
                        if Confirm('Souhaitez-vous modifier la description toutes les écritures du document ?', true) then begin
                            RecLedgerEntry.SetRange("Transaction No.", Rec."Transaction No.");
                            if RecLedgerEntry.FindSet(true) then
                                repeat
                                    RecLedgerEntry.Description := Rec.Description;
                                    RecLedgerEntry.Modify();
                                until RecLedgerEntry.Next() = 0;
                            RecCustLedgEntry.SetRange("Transaction No.", Rec."Transaction No.");
                            if RecCustLedgEntry.FindSet(true) then
                                repeat
                                    RecCustLedgEntry.Description := Rec.Description;
                                    RecCustLedgEntry.Modify();
                                until RecCustLedgEntry.Next() = 0;
                            RecVendorLedgEntry.SetRange("Transaction No.", Rec."Transaction No.");
                            if RecVendorLedgEntry.FindSet(true) then
                                repeat
                                    RecVendorLedgEntry.Description := Rec.Description;
                                    RecVendorLedgEntry.Modify();
                                until RecVendorLedgEntry.Next() = 0;
                            //DIA£FTS 19/01/2016 - AT0669062
                            RecBankEntry.SetRange("Transaction No.", Rec."Transaction No.");
                            if RecBankEntry.FindSet(true) then
                                repeat
                                    RecBankEntry.Description := Rec.Description;
                                    RecBankEntry.Modify();
                                until RecBankEntry.Next() = 0;
                        end else begin
                            recCustPostGroup.SetRange("Receivables Account", Rec."G/L Account No.");
                            if recCustPostGroup.FindSet() then begin
                                RecCustLedgEntry.SetRange("Transaction No.", Rec."Transaction No.");
                                if RecCustLedgEntry.FindSet(true) then
                                    repeat
                                        RecCustLedgEntry.Description := Rec.Description;
                                        RecCustLedgEntry.Modify();
                                    until RecCustLedgEntry.Next() = 0;
                            end;
                            recVendPostGroup.SetRange("Payables Account", Rec."G/L Account No.");
                            if recVendPostGroup.FindSet() then begin
                                RecVendorLedgEntry.SetRange("Transaction No.", Rec."Transaction No.");
                                if RecVendorLedgEntry.FindSet(true) then
                                    repeat
                                        RecVendorLedgEntry.Description := Rec.Description;
                                        RecVendorLedgEntry.Modify();
                                    until RecVendorLedgEntry.Next() = 0;
                            end;
                            recBankPostGroup.SetRange("G/L Account No.", Rec."G/L Account No.");
                            if recBankPostGroup.FindSet() then begin
                                RecBankEntry.SetRange("Transaction No.", Rec."Transaction No.");
                                if RecBankEntry.FindSet(true) then
                                    repeat
                                        RecBankEntry.Description := Rec.Description;
                                        RecBankEntry.Modify();
                                    until RecBankEntry.Next() = 0;
                            end;
                            CurrPage.SaveRecord();
                        end;

                        CurrPage.Update(false);
                    end;
                }
                field("Commentaire interne"; Rec."Commentaire interne")
                {
                    ApplicationArea = All;
                    ToolTip = 'Commentaire interne';
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Montant débit';
                    Editable = false;
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Montant crédit';
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Montant';
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Code Axe 1';
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Code Axe 2';
                    Editable = false;
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Code journal';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnDeleteRecord(): Boolean
    begin
        Error('Vous en pouvez pas supprimer d''écritures comptables');
    end;

    var
        RecLedgerEntry: Record "G/L Entry";
        RecCustLedgEntry: Record "Cust. Ledger Entry";
        RecVendorLedgEntry: Record "Vendor Ledger Entry";
        RecBankEntry: Record "Bank Account Ledger Entry";
        recCustPostGroup: Record "Customer Posting Group";
        recVendPostGroup: Record "Vendor Posting Group";
        recBankPostGroup: Record "Bank Account Posting Group";
}

