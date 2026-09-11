pageextension 50060 StandardSalesCodeCardExtension extends "Standard Sales Code Card"
{
    layout
    {
        addafter("Currency Code")
        {
            field("Groupe prix client"; Rec."Groupe prix client")
            {
                ApplicationArea = All;
                ToolTip = 'Groupe prix client';
            }
            field("Code enseigne"; Rec."Code enseigne")
            {
                ApplicationArea = All;
            }
            
        }
    }
}

