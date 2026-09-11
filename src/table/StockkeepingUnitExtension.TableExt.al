tableextension 50060 StockkeepingUnitExtension extends "Stockkeeping Unit"
{
    
    fields
    {
        field(50000; "Réf. client"; Code[20])
        {
            CalcFormula = lookup (Item."No. 2" where ("No." = field ("Item No.")));
            Caption = 'Réf. client';
            FieldClass = FlowField;
        }

        
    }
    
}


