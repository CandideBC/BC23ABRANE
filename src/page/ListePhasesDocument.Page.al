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
                //KAN.FHA 30/10/2026 DEBUT
                field("Remplir qte. a exp."; Rec."Remplir qte. a exp.")
                {
                    ApplicationArea = All;
                    ToolTip = 'A cocher pour remplir automatiquement la quantité à expédier des articles de la phase.';
                    Visible = RemplirQteAExpVisible;
                }
                //KAN.FHA 30/10/2026 FIN

            }
        }
    }
    var
        AcheterVisible: Boolean;
        RemplirQteAExpVisible: Boolean;

    procedure DefinirTypeAppel(pButAppel: Text)
    begin
        case pButAppel of
            'Acheter':
                begin
                    AcheterVisible := true;
                    RemplirQteAExpVisible := false;
                end;
            'Coliser':
                begin
                    AcheterVisible := false;
                    RemplirQteAExpVisible := false;
                end;
            //KAN.FHA 30/10/2026 DEBUT
            'Remplir Qté à expédier':
                begin
                    AcheterVisible := false;
                    RemplirQteAExpVisible := true;
                end;
            //KAN.FHA 30/10/2026 FIN
        end;
    end;
}
