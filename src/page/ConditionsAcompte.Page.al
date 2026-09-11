page 50085 "Conditions acompte"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = List;
    SourceTable = "Conditions acompte";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ToolTip = 'Type';
                    Visible = false;
                }
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Code';
                }
                field("Montant minimum"; Rec."Montant minimum")
                {
                    ToolTip = 'Montant minimum';
                }
                field("% acompte demande"; Rec."% acompte demande")
                {
                    ToolTip = '% acompte demandé';
                }
            }
        }
    }

    actions
    {
    }
}

