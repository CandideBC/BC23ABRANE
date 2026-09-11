pageextension 50082 AssemblyBOMExtension extends "Assembly BOM"
{
    layout
    {
        addafter("No.")
        {
            field("Reference externe client";rec."Reference externe client")
            {
                ToolTip = 'Référence externe client';
            }
        }
    }
    
    actions
    {
        modify(CalcUnitPrice)
        {
            Visible = false;
        }

        addafter(CalcUnitPrice)
        {
            action(CalculerPoids)

            {
                ApplicationArea = All;
                ToolTip = 'Calculer poids';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = SuggestNumber;
                                    
                trigger OnAction()
                begin
                    rec.CalcPoids(true);
                end;
            }
        }
    }
}
