pageextension 50012 "PurchaseListExtension" extends "Purchase List"
{
    layout
    {
        addafter("Currency Code")
        {
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
                ToolTip = 'Montant';
            }
            field("Amount Including VAT"; Rec."Amount Including VAT")
            {
                ApplicationArea = All;
                ToolTip = 'Montant TTC';
            }
        }
    }
}
