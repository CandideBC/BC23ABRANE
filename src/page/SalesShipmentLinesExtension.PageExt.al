pageextension 50018 "SalesShipmentLinesExtension" extends "Sales Shipment Lines"
{
    layout
    {
        addafter("Document No.")
        {
            field("Order No."; rec."Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'N° commande';
            }

        }


    }
}
