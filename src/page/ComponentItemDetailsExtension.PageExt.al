pageextension 50099 ComponentItemDetailsExtension extends "Component - Item Details"
{
    layout
    {
        addafter("No. of Substitutes")
        {
            field("Net Weight";Rec."Net Weight")
            {
                ApplicationArea = All;
                ToolTip = 'Poids net';
            }
            field("Gross Weight"; Rec."Gross Weight")
            {
                ApplicationArea = All;
                ToolTip = 'Poids brut';
            }
        }
    }
    actions
    {

    }
}
