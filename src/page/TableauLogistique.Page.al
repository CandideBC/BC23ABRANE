page 50133 "Tableau logistique"
{
    ApplicationArea = All;
    Caption = 'Tableau logistique';
    PageType = Card;
    SourceTable = "Date";
    SourceTableView = where("Period Type" = const(Week));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Period Type"; Rec."Period Type")
                {
                    ToolTip = 'Type de période';
                }
                field("Period No."; Rec."Period No.")
                {
                    ToolTip = 'N° période';
                }
                field("Period Start"; Rec."Period Start")
                {
                    ToolTip = 'Date début période';
                }
            }
            part(TachesLogistiques; "SF TBL Taches logistiques")
            {
                SubPageLink = "Date semaine" = field("Period Start");
            }
            part(Containers; "SF TBL containers attendus")
            {
                SubPageLink = "Date semaine reception prevue" = field("Period Start");
            }
            
            part(Receptions; "SF TBL Semainier recep prevue")
            {
                SubPageLink = "Date semaine reception prevue" =field("Period Start");
            }
            
            part(Expeditions; "SF TBL Phases a preparer")
            {
                SubPageLink = "Date semaine chargement" =field("Period Start");
            }
        }
    }
    trigger OnOpenPage()
    var
        CurrentDate: Date;
    begin
        CurrentDate := Today;

        // 1. On filtre sur la date du jour pour trouver la période correspondante
        Rec.SetRange("Period Start", 0D, CurrentDate);
        Rec.SetRange("Period End", CurrentDate, DMY2Date(31, 12, 9999));

        // 2. Si on trouve la semaine, on se positionne dessus et on nettoie les filtres
        if Rec.FindFirst() then begin
            Rec.Reset();
            Rec.SetRange("Period Type", Rec."Period Type"::Week);
            // On force l'affichage sur cet enregistrement précis
            Rec.Get(Rec."Period Type"::Week, Rec."Period Start");
        end;
    end;
}
