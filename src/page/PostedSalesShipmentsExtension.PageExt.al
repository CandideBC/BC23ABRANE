pageextension 50036 PostedSalesShipmentsExtension extends "Posted Sales Shipments"
{

    layout
    {
        modify("Posting Date")
        {
        Visible=true;
        }

        addafter("No.")
        {

            field("Order No."; Rec."Order No.")
            {
                ToolTip = 'N° commande';
            }
        }

        addafter("Shipment Date")
        {
            field("Comments"; Rec.Comments)
            {
                ToolTip = 'Commentaires';
            }
        }
        addafter("Ship-to Post Code")
        {
            field("Ship-to City"; Rec."Ship-to City")
            {
                ToolTip = 'Ville destinataire';
            }
            field("Nbre colisages"; Rec."Nbre colisages")
            {
                ApplicationArea = All;
                ToolTip = 'Indique combien de colisages ont été créés pour ce bon de livraison, normalement un BL = 1 colisage';
            }
        }
    }

    actions
    {
        modify(CertificateOfSupplyDetails)
        {
            Visible = false;
        }
        modify(PrintCertificateofSupply)
        {
            Visible = false;
        }
        modify("&Track Package")
        {
            Visible = false;
        }
    }
}

