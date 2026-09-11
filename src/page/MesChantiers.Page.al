page 50079 "Mes chantiers"
{
    Caption = 'Mes chantiers';
    PageType = ListPart;
    SourceTable = "Mes Chantiers";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code chantier"; Rec."Code chantier")
                {
                }
                field("Nom du chantier"; Rec."Nom du chantier")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Ouvrir)
            {
                Caption = 'Open';
                Image = Edit;
                RunPageMode = View;
                ShortCutKey = 'Return';

                trigger OnAction()
                begin
                    OuvrirFicheChantier();
                end;
            }
            action("Tests renta")
            {
                Caption = 'Tests renta';

                trigger OnAction()
                begin
                    Rec.TestsRenta();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange("User ID", UserId);
    end;

    var
        Chantier: Record Chantier;

    procedure OuvrirFicheChantier()
    begin
        if Chantier.Get(Rec."Code chantier") then
            PAGE.Run(PAGE::"Fiche chantier", Chantier);
    end;
}

