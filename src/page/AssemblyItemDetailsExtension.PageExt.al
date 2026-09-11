pageextension 50098 AssemblyItemDetailsExtension extends "Assembly Item - Details"
{
    layout
    {
        addafter("Unit Price")
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
