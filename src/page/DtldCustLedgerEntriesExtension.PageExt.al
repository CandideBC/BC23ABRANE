pageextension 50096 DtldCustLedgerEntriesExtension extends "Detailed Cust. Ledg. Entries"
{
    layout
    {
        addafter("Cust. Ledger Entry No.")
        {
            field("Code enseigne"; Rec."Code enseigne")
            {
                ApplicationArea = All;
                ToolTip = 'Code enseigne';
            }
            
        }
    }
    actions
    {

    }
}
