page 50022 TmpLignesColisage
{
    ApplicationArea = All;
    Caption = 'TmpLignesColisage';
    PageType = List;
    SourceTable = "Detail colisage";
    UsageCategory = Lists;
    Editable = false;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No. colisage"; Rec."No. colisage")
                {
                    ToolTip = 'Specifies the value of the N° bon colisage field.';
                }
                field("No. UC"; Rec."No. UC")
                {
                    ToolTip = 'N° colisage';
                }
                field("Type UC"; Rec."Type UC")
                {
                    ToolTip = 'Type UC';
                }
                /*
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ToolTip = 'Poids brut';
                }
                */
                field("Poids net articles";Rec."Poids net articles")
                {
                    ToolTip = 'Poids net article';
                }
                field("Poids brut UC";Rec."Poids brut UC")
                {
                    ToolTip = 'Poids brut UC';
                }
            }
        }
    }
}
