pageextension 50051 PurchaseInvoicesExtension extends "Purchase Invoices"
{
    layout
    {
        addafter("Buy-from Vendor Name")
        {


            field("Code groupe";Rec."Code groupe" )
            {
                ToolTip = 'Code groupe';
            }
            field("Code enseigne";Rec."Code enseigne" )
            {
                ToolTip = 'Code enseigne';
            }
            field("Code operation";Rec."Code operation" )
            {
                ToolTip = 'Code opération';
            }
            field("Code chantier";Rec."Code chantier" )
            {
                ToolTip = 'Code chantier';
            }
        }

    }
    actions
    {

    }
}
