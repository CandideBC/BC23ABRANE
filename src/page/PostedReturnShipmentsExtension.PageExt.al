pageextension 50111 PostedReturnShipmentsExtension extends "Posted Return Shipments"
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
