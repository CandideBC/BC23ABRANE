pageextension 50110 PostedReturnShipmentExtension extends "Posted Return Shipment"
{
    layout
    {
        addafter("Purchaser Code")
        {

            field("No. container";Rec."No. container")
            {
                ToolTip = 'N° container';
            }
        }
    }
    actions
    {

    }
}
