pageextension 50102 ItemChargesExtension extends "Item Charges"
{
    layout
    {
        addafter("Search Description")
        {
            field("Type de coût";Rec."Type de coût")
            {
                ApplicationArea = All;
                ToolTip = 'Type de coût';
            }
            
        }
    }
    actions
    {

    }
}
