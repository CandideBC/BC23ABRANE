pageextension 50044 PostedSalesCrMemoExtension extends "Posted Sales Credit Memo"
{

    layout
    {

        addafter("Salesperson Code")
        {
            field("Code groupe";Rec."Code groupe" )
            {
                ToolTip = 'Code groupe';
            }
            field("Code enseigne";Rec."Code enseigne" )
            {
                ToolTip = 'Code enseigne';
            }
            field("Code operation";Rec."Code operation" )
            {
                ToolTip = 'Code opération';
            }
            field("Code chantier";Rec."Code chantier" )
            {
                ToolTip = 'Code chantier';
            }
            field("Annee commande";Rec."Annee commande")
            {
                ToolTip = 'Année commande';
            }
            field("Commentaire";Rec.Commentaire )
            {
                ToolTip = 'Commentaires';
            }
            field("Facturation en compta"; Rec."Facturation en compta")
            {
                ToolTip = 'Facturation en compta';
            }
            field("Reason Code";Rec."Reason Code" )
            {
                ToolTip = 'Code motif';
            }
        }
        addafter("Payment Method Code")
        {

            field("Factoring";Rec.Factoring )
            {
                ToolTip = 'Factoring';
            }
            field("Factor Code";Rec."Factor Code" )
            {
                ToolTip = 'Code banque';
            }

        }

        addafter("Ship-to Contact")
        {
            /*

                SourceExpr="Number Of Packages";
                Editable=FALSE }

    { 1000000002;2;Field  ;
                SourceExpr="Pallet Number";
            */
            field("Total Net Weight";Rec."Total Net Weight" )
            {
                ToolTip = 'Poids net total';
            }
            field("Total Gross Weight";Rec."Total Gross Weight" )
            {
                ToolTip = 'Poids brut total';
            }
            field("Number Of Packages";Rec."Number Of Packages" )
            {
                ToolTip = 'Nombre de colis';
            }
            field("Pallet Number";Rec."Pallet Number" )
            {
                ToolTip = 'N° palette';
            }
        }
    }

    actions
    {
        modify("&Track Package")
        {
            Visible = false;
        }
        modify("&Track Package_Promoted")
        {
            Visible = false;
        }

    }     
}

