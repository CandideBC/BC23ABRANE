page 50155 "Liste documents chantier"
{
    ApplicationArea = All;
    Caption = 'Liste documents chantier';
    PageType = List;
    SourceTable = "Documents chantier";
    UsageCategory = None;
    Editable = false;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Type document"; Rec."Type document")
                {
                    ToolTip = 'Type de document', Comment = '%';
                    Visible = false;
                }
                field("No. document"; Rec."No. document")
                {
                    ToolTip = 'N° du document', Comment = '%';
                }
                field(Commentaires; Rec.Commentaires)
                {
                    ToolTip = 'Commentaires du document', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(AfficherDocument)
            {
                Caption = 'Afficher';
                ToolTip = 'Afficher le document';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Document;

                trigger OnAction()
                begin
                    Rec.AfficherDocument();
                end;
            }
        }
    }
}
