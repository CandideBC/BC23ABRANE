pageextension 50137 PurchaseListArchiveExtension extends "Purchase List Archive"
{
    layout
    {
        addafter("Version No.")
        {
            field("Montant archive"; Rec."Montant archive")
            {
                ApplicationArea = All;
                ToolTip = 'Montant archivé';
            }
        }
    }

}
