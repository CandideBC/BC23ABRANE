page 50016 ActivitesCompta
{
    ApplicationArea = All;
    Caption = 'Activités Comptabilité';
    RefreshOnActivate = true;
    PageType = CardPart;
    SourceTable = "Finance Cue";
    
    layout
    {
        area(content)
        {
            cuegroup(Acomptes)
            {
                Caption = 'Acomptes';
                
                field("Acomptes a creer"; Rec."Acomptes a creer")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Indique combien de factures d''acomptes doivent être créées';
                    DrillDownPageId = "Sales Order List";
                }
                field("Situations a creer"; Rec."Situations a creer")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Indique combien de factures de situaiton doivent être créées';
                    DrillDownPageId = "Sales Order List";
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
