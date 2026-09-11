pageextension 50041 PostedPurchInvoicesExtension extends "Posted Purchase Invoices"
{

    layout
    {
        //modify("Net Weight")
        //    {
        //        Visible = true;
        //        ToolTip = 'Poids net';
        //        Style = Attention;
        //        StyleExpr = true;
        //    }

        
        addafter("Amount Including VAT")
        {


            field("Annee commande";Rec."Annee commande" )
            {
                ToolTip = 'Année commande';
            }
        }
        addafter("Pay-to Name")
        {

            field("Posting Description";Rec."Posting Description" )
            {
                ToolTip = 'Libellé écriture';
            }
            field("SAV Type";Rec."SAV Type" )
            {
                ToolTip = 'Type SAV';
            }

        }
        addafter("No. Printed")
        {

            field("Concernee DEB";Rec."Concernee DEB" )
            {
                ToolTip = 'Concernée DEB';
            }
            field("Periode validation DEB";Rec."Periode validation DEB" )
            {
                ToolTip = 'Période validation DEB';
            }

        }
        addafter("Shipment Method Code")
        {

            field("Comments";Rec.Comments )
            {
                ToolTip = 'Commentaires';
            }
            field("Commande transitaire container";Rec."Commande transitaire container" )
            {
                ToolTip = 'Commande transitaire container';
            }
            field("No. container";Rec."No. container" )
            {
                ToolTip = 'N° container';
            }

        }


    }

    actions
    {

    }     
}

