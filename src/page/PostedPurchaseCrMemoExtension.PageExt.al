pageextension 50034 PostedPurchaseCrMemoExtension extends "Posted Purchase Credit Memo"
{

    layout
    {
        modify("Responsibility Center")
        {
            Visible = false;
        }



        //modify("Net Weight")
        //    {
        //        Visible = true;
        //        ToolTip = 'Poids net';
        //        Style = Attention;
        //        StyleExpr = true;
        //    }

        

        addafter("Posting Date")
        {
            field("Annee commande"; Rec."Annee commande")
            {
                ApplicationArea = All;
                ToolTip = 'Année commande';
            }
            

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
            field("Achat pour stock";Rec."Achat pour stock" )
            {
                ToolTip = 'Achat pour stock';
            }
        }
        addafter("Responsibility Center")
        {
            field("Comments";Rec.Comments )
            {
                ToolTip = 'Commentaires';
            }
        }



    }

    actions
    {

    }     
}

