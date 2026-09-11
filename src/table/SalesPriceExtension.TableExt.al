tableextension 50054 SalesPriceExtension extends "Sales Price"
{
    fields
    {
        field(50000; "Item Description"; Text[100])
        {
            CalcFormula = lookup (Item.Description where ("No." = field ("Item No.")));
            Caption = 'Désignation article';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50010; Inventory; Decimal)
        {
            CalcFormula = sum ("Item Ledger Entry".Quantity where ("Item No." = field ("Item No."),
                                                                  "Variant Code" = field ("Variant Code")));
            Caption = 'Stocks';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
    }



}

