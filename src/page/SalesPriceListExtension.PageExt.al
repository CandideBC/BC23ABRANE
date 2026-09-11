pageextension 50125 "SalesPriceListExtension" extends "Sales Prices"
{
    layout
    {
        addbefore("Currency Code")
        {
            field(Inventory;Rec.Inventory)
            {
                ApplicationArea = All;
                ToolTip = 'Stock';
            }
            field("Item Description";Rec."Item Description")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Désignation article';
            }

        }
    }
}
