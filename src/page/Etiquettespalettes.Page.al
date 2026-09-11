page 50002 "Etiquettes palettes"
{
    PageType = List;
    SourceTable = "Etiquettes palettes";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. packing list"; Rec."No. packing list")
                {
                    ToolTip = 'N° de packing list';
                }
                field("No. palette"; Rec."No. palette")
                {
                    ToolTip = 'N° palette';
                }
                field(Phase; Rec.Phase)
                {
                    ToolTip = 'Phase';
                }
                field("Code enseigne"; Rec."Code enseigne")
                {
                    ToolTip = 'Code enseigne';
                }
                field("Code chantier"; Rec."Code chantier")
                {
                    ToolTip = 'Code chantier';
                }
                field("No. commande achat"; Rec."No. commande achat")
                {
                    ToolTip = 'N° commande achat';
                }
                field("Nb etiquettes"; Rec."Nb etiquettes")
                {
                    ToolTip = 'Nombre d''étiquettes';
                }
                field("Nom chantier"; Rec."Nom chantier")
                {
                    ToolTip = 'Nom du chantier';
                }
                field("Nom chantier 2"; Rec."Nom chantier 2")
                {
                    ToolTip = 'Nom 2 du chantier';
                }
                field("Adresse chantier"; Rec."Adresse chantier")
                {
                    ToolTip = 'Adresse chantier';
                }
                field("Adresse chantier 2"; Rec."Adresse chantier 2")
                {
                    ToolTip = 'Adresse 2 chantier';
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
                field("Contact/No. tel chantier"; Rec."Contact/No. tel chantier")
                {
                    ToolTip = 'Contact / N° tél. chantier';
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action(Imprimer)
            {
                Caption = 'Imprimer';
                ToolTip = 'Imprimer';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Etiquette.SetRange("Code utilisateur", UserId);
                    REPORT.Run(REPORT::"Etiquette palette", true, false, Etiquette);
                end;
            }
        }
    }

    var
        Etiquette: Record "Etiquettes palettes";
}

