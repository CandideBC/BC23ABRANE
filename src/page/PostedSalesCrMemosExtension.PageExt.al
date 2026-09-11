pageextension 50039 PostedSalesCrMemosExtension extends "Posted Sales Credit Memos"
{

    layout
    {




        modify("Bill-to Customer No.")
            {
                Visible = true;
        //        ToolTip = 'Poids net';
        //        Style = Attention;
        //        StyleExpr = true;
            }

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
        
            field("Concernee DEB";Rec."Concerne DEB" )
            {
                ToolTip = 'Concernée DEB';
            }
            field("Periode validation DEB";Rec."Periode validation DEB" )
            {
                ToolTip = 'Période validation DEB';
            }

        }
        addafter("Applies-to Doc. Type")
        {
            field(Commentaire;Rec.Commentaire )
            {
                ToolTip = 'Commentaires';
            }


        }

        


 



    }

    actions
    {

    }     
}

