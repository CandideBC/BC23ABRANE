pageextension 50037 PostedSalesInvoiceExtension extends "Posted Sales Invoice"
{

    layout
    {
        modify("Responsibility Center")
        {
            Visible = false;
        }
        
        addafter("Order No.")
        {
            field("Annee commande";Rec."Annee commande" )
            {
                ToolTip = 'Année commande';
            }
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

            field("Facture acompte";Rec."Facture acompte" )
            {
                ToolTip = 'Facture acompte';
            }
            field("Acompte pour type doc.";Rec."Acompte pour type doc." )
            {
                ToolTip = 'Acompte pour type doc.';
            }
            field("Acompte pour No. document";Rec."Acompte pour No. document" )
            {
                ToolTip = 'Acompte pour No. document';
            }
        }
        addafter("No. Printed")
        {
            field("Surface m2";Rec."Surface m2" )
            {
                ToolTip = 'Surface m2';
            }
            field("Range No.";Rec."Range No." )
            {
                ToolTip = 'N° de rayon';
            }
            field(Commentaire;Rec.Commentaire )
            {
                ToolTip = 'Commentaires';
            }
            field("Montant deja verse TTC";Rec."Montant deja verse TTC" )
            {
                ToolTip = 'Montant déjà versé TTC';
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
        addafter("Shipment Date")
        {
            field("No. And Location Name";Rec."No. And Location Name" )
            {
                ToolTip = 'N° et nom du magasin';
            }
            field("Total Net Weight";Rec."Total Net Weight" )
            {
                ToolTip = 'Poids net total';
            }
            field("Gross Gross Weight";Rec."Total Gross Weight" )
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
            field("Commentaire factu."; Rec."Commentaire factu.")
            {
                ToolTip = 'Commentaire factu.';
            }

        }
        addafter("EU 3-Party Trade")
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





    }

    actions
    {
        modify(ChangePaymentService)
        {
            Visible = false;
        }
        addafter("&Navigate")
        {
            /*
            Migration : j'ai adapté le standard qui inclut maintenant une fonctionnalité de mise à jour de la facture
            action("Modifier adresses")
            {

                Caption = 'Modifier adresses';
                ToolTip = 'Modifier adresses';
                Image = AlternativeAddress;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    
                begin
                    Rec.EditAddress();
                end;

            }
            */
        }
    }     
}

