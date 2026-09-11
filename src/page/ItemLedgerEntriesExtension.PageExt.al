pageextension 50010 "ItemLedgerEntriesExtension" extends "Item Ledger Entries"
{
    layout
    {
        addafter(Description)
        {
            field("Remis en stock depuis BL"; Rec."Remis en stock depuis BL")
            {
                ApplicationArea = All;
                ToolTip = 'Remis en stock depuis BL';
            }
            field("Transfert reception achat"; Rec."Transfert reception achat")
            {
                ApplicationArea = All;
                ToolTip = 'Transfert reception achat';
            }
        }
        addafter("Sales Amount (Actual)")
        {
            field("Purchase Amount (Actual)"; Rec."Purchase Amount (Actual)")
            {
                ApplicationArea = All;
                ToolTip = 'Remis en stock depuis BL';
            }
        }
        addafter("Job Task No.")
        {    
            field("Country/Region Code"; Rec."Country/Region Code")
            {
                ApplicationArea = All;
                ToolTip = 'Transfert reception achat';
            }
            field("Entry/Exit Point"; Rec."Entry/Exit Point")
            {
                ApplicationArea = All;
                ToolTip = 'Transfert reception achat';
            }
        }

    }
}
