page 50111 "Phases enseigne"
{
    ApplicationArea = All;
    Caption = 'Phases enseigne';
    PageType = List;
    SourceTable = "Phases enseigne";
    UsageCategory = None;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code enseigne"; Rec."Code enseigne")
                {
                    Visible = false;
                    ToolTip = 'Indique pour quelle enseigne la phase est rattachée';
                }
                field(Phase; Rec.Phase)
                {
                    ToolTip = 'Indique le numéro de la phase';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Indique le libellé de la phase.';
                }
            }
        }
    }
}
