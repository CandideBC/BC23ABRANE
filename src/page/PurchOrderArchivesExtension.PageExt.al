pageextension 50054 PurchOrderArchivesExtension extends "Purchase Order Archives"
{
    layout
    {
        addafter("Shipment Method Code")
        {

            field("Comments"; Rec."Comments")
            {
                ToolTip = 'Commentaires';
            }
        }
    }
    actions
    {

    }
}
