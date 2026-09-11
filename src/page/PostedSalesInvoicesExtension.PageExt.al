pageextension 50038 PostedSalesInvoicesExtension extends "Posted Sales Invoices"
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

        
        addafter("Amount Including VAT")
        {

            field("Annee commande";Rec."Annee commande" )
            {
                ToolTip = 'Année commande';
            }

        }
        addafter("Ship-to Post Code")
        {

            field("Ship-to City";Rec."Ship-to City" )
            {
                ToolTip = 'Ville destinataire';
            }

        }

        addafter("Posting Date")
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
        addafter("Shipment Date")
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

