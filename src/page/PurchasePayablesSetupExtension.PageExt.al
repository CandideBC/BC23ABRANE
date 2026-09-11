pageextension 50114 PurchasePayablesSetupExtension extends "Purchases & Payables Setup"
{
    layout
    {
        addafter("Posted Prepmt. Cr. Memo Nos.")
        {
            field("No. container"; Rec."No. container")
            {
                ApplicationArea = All;
                ToolTip = 'N° container';
            }
            
        }
    }
    
}
