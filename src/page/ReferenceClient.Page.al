page 50037 "Reference client"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = List;
    SourceTable = "Reference client";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Reference client"; Rec."Reference client")
                {
                    ApplicationArea = All;
                    ToolTip = 'Référence client';
                }
                field(Libelle; Rec.Libelle)
                {
                    ApplicationArea = All;
                    ToolTip = 'Libellé';
                    Visible = false;
                }
                field("Code enseigne";Rec."Code enseigne")
                {
                    ApplicationArea = All;
                }
                
            }
        }
    }

    actions
    {
    }
}

