page 50103 "Piles BE"
{
    ApplicationArea = All;
    Caption = 'Piles BE';
    PageType = CardPart;
    SourceTable = "Piles ABRANE";
    RefreshOnActivate = true;
    
    layout
    {
        area(content)
        {
            cuegroup(FichesBE)
            {
                Caption = 'Fiches BE';
                field("Nouvelles fiches BE"; Rec."Nouvelles fiches BE")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Indique combien de lignes de fiches BE sont sans statut.';
                    DrillDownPageId = "Liste fiches BE";
                }
                field("Fiches BE en cours"; Rec."Fiches BE en cours")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Indique combien de lignes de fiches BE sont en cours de traitement par le BE.';
                    DrillDownPageId = "Liste fiches BE";
                }

                field("Alertes decalages date"; Rec."Alertes decalages date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indique combien de lignes de dossiers BE ont fait l''objet d''un décalage du délai de réponse sans que ces décalages n''aient été visés par le BE.';
                    DrillDownPageId = "Liste dossiers BE";
                }
                
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
