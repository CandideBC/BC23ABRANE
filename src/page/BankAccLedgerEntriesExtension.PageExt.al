pageextension 50070 BankAccLedgerEntriesExtension extends "Bank Account Ledger Entries"
{
    layout
    {
        addafter("Document No.")
        {
            field(MyField; ReC."External Document No.")
            {
                ApplicationArea = All;
                ToolTip = 'N° doc. externe';
            }
        }

    }
    actions
    {

    }
}
