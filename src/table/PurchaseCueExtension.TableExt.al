tableextension 50058 PurchaseCueExtension extends "Purchase Cue"
{
    fields
    {
        field(50000; "Containers en cours"; Integer)
        {
            Caption = 'Containers en cours';
            
            FieldClass = FlowField;
            CalcFormula = count(Container where ("Statut container"=const("En cours")));
        }
        field(50010; "Containers réceptionnés"; Integer)
        {
            Caption = 'Containers réceptionnés';
            
            FieldClass = FlowField;
            CalcFormula = count(Container where ("Statut container"=const(Réceptionné)));
        }
    }



}

