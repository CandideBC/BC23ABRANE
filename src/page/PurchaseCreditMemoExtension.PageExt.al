pageextension 50089 PurchaseCreditMemoExtension extends "Purchase Credit Memo"
{
    layout
    {
        modify("Campaign No.")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Job Queue Status")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }

        modify("Prices Including VAT")
        {
            Visible = false;
        }

        addafter("Posting Date")
        {
            field("Date limite reponse"; Rec."Date limite reponse")
            {
                ToolTip = 'Date limite réponse';
            }
        }

        addafter("Purchaser Code")
        {
            field("Code chantier"; Rec."Code chantier")
            {
                ToolTip = 'Chantier';

            }
            field("Code groupe"; Rec."Code groupe")
            {
                ToolTip = 'Groupe';
            }
            field("Code enseigne"; Rec."Code enseigne")
            {
                ToolTip = 'Enseigne';
            }
            field("Code operation"; Rec."Code operation")
            {
                ToolTip = 'Opération';
            }

            field(Commentaires; Rec.Commentaires)
            {
                ToolTip = 'Commentaires';
            }

            field("Annee commande";Rec."Annee commande")
            {
                ToolTip = 'Année commande';
            }
        }
        moveafter(Commentaires; "Posting Description")

    }

    actions
    {

    }










    var





}
