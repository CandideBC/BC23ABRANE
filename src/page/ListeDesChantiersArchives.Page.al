page 50087 "Liste des chantiers archives"
{
    // InsertAllowed à Non car on doit créer un chantier depuis l'enseigne

    CardPageID = "Fiche chantier";
    Caption = 'Liste des chantiers archivés';
    UsageCategory = Lists;
    InsertAllowed = false;
    PageType = List;
    SourceTable = Chantier;
    SourceTableView = sorting ("Chantier archive")
                      where ("Chantier archive" = const (true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Code';
                }
                field("Description chantier"; Rec."Description chantier")
                {
                    ToolTip = 'Description chantier';
                }
                field("Date derniere facture vte"; Rec."Date derniere facture vte")
                {
                    ToolTip = 'Date derniere facture vte';
                }
                field("Statut chantier"; Rec."Statut chantier")
                {
                    ToolTip = 'Statut chantier';
                    Editable = false;
                }
                field("Chantier a verifier (>=2020)"; Rec."Chantier a verifier (>=2020)")
                {
                    ToolTip = 'Chantier à vérifier (>=2020)';
                }
                field("Chantier verifie"; Rec."Chantier verifie")
                {
                    ToolTip = 'Chantier vérifié';
                }
                field("Code enseigne"; Rec."Code enseigne")
                {
                    ToolTip = 'Code enseigne';
                }
                field("Code concept"; Rec."Code concept")
                {
                    ToolTip = 'Code concept';
                }
                field("No. client"; Rec."No. client")
                {
                    ToolTip = 'N° client';
                }
                field("Nom client"; Rec."Nom client")
                {
                    ToolTip = 'Nom client';
                }
                field("Code postal client"; Rec."Code postal client")
                {
                    ToolTip = 'Code postal client';
                }
                field("Ville client"; Rec."Ville client")
                {
                    ToolTip = 'Ville client';
                }
                field("Nom chantier"; Rec."Nom chantier")
                {
                    ToolTip = 'Nom chantier';
                }
                field("Nom chantier 2"; Rec."Nom chantier 2")
                {
                    ToolTip = 'Nom chantier 2';
                }
                field("Adresse chantier"; Rec."Adresse chantier")
                {
                    ToolTip = 'Adresse chantier';
                }
                field("Adresse chantier 2"; Rec."Adresse chantier 2")
                {
                    ToolTip = 'Adresse chantier 2';
                }
                field("Code postal chantier"; Rec."Code postal chantier")
                {
                    ToolTip = 'Code postal chantier';
                }
                field("Ville chantier"; Rec."Ville chantier")
                {
                    ToolTip = 'Ville chantier';
                }
                field("Code pays chantier"; Rec."Code pays chantier")
                {
                    ToolTip = 'Code pays chantier';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Recréer ce chantier")
            {
                Caption = 'Recréer ce chantier';
                tooltip = 'Recréer ce chantier';
                Image = CopyRouteVersion;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.RecreerChantier();
                end;
            }
        }
    }
}

