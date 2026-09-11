page 50021 Factor
{
    PageType = List;
    SourceTable = Factor;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Factor Code"; Rec."Factor Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Code Factor';
                }
                field("Text 1"; Rec."Text 1")
                {
                    ApplicationArea = All;
                    ToolTip = 'Texte 1';
                }
                field("Text 2"; Rec."Text 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Texte 2';
                }
                field("Text 3"; Rec."Text 3")
                {
                    ApplicationArea = All;
                    ToolTip = 'Texte 3';
                }
            }
        }
    }

    actions
    {
    }
}

