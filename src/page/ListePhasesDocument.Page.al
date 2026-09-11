page 50109 "Liste phases document"
{
    ApplicationArea = All;
    Caption = 'Liste phases document';
    PageType = List;
    SourceTable = "Phases document";
    UsageCategory = None;
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Phase; Rec.Phase)
                {
                    ToolTip = 'Phase';
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description de la phase';
                    Editable = false;
                }
                field("Date chargement"; Rec."Date chargement")
                {
                    ToolTip = 'Date de chargement pour les articles de la phase';
                    Editable = false;
                }
                field("Date livraison demandee"; Rec."Date livraison demandee")
                {
                    ToolTip = 'Date de livraison demandée pour la phase';
                    Editable = false;
                }

                field(Acheter; Rec.Acheter)
                {
                    ApplicationArea = All;
                    ToolTip = 'A cocher pour indiquer que les articles liés à la phase doivent être achetés.';
                    Visible = AcheterVisible;
                }

            }
        }
    }
    var
        AcheterVisible: Boolean;

    procedure DefinirTypeAppel(pType: Text)
    begin
        case pType of
            'Acheter':
                AcheterVisible := true;
            'Coliser':
                AcheterVisible := false;
        end;
    end;
}
