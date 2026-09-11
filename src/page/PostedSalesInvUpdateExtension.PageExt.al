pageextension 50140 PostedSalesInvUpdateExtension extends "Posted Sales Inv. - Update"
{
    layout
    {
        addafter(General)
        {
            group("Donneur d'ordre")
            {

                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'N° doc. externe';
                }
                field("SelltoCustomerNo2"; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'N° donneur d''ordre';
                }
                field("SelltoCustomerName2"; Rec."Sell-to Customer Name")
                {
                    ToolTip = 'Nom donneur d''ordre';
                }
                field("Sell-to Customer Name 2"; Rec."Sell-to Customer Name 2")
                {
                    ToolTip = 'Nom 2 donneur d''ordre';
                }
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    ToolTip = 'Adresse donneur d''ordre';
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                    ToolTip = 'Adresse 2 donneur d''ordre';
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ToolTip = 'Code postal donneur d''ordre';
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    ToolTip = 'Ville donneur d''ordre';
                }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
                {
                    ToolTip = 'Code pays donneur d''ordre';
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ToolTip = 'Contact donneur d''ordre';
                }
            }
            group("Client facturé")
            {
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ToolTip = 'N° client facturé';
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ToolTip = 'Nom client facturé';
                }
                field("Bill-to Name 2"; Rec."Bill-to Name 2")
                {
                    ToolTip = 'Nom 2 client facturé';
                }
                field("Bill-to Address"; Rec."Bill-to Address")
                {
                    ToolTip = 'Adresse client facturé';
                }
                field("Bill-to Address 2"; Rec."Bill-to Address 2")
                {
                    ToolTip = 'Adresse 2 client facturé';
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    ToolTip = 'Code postal client facturé';
                }
                field("Bill-to City"; Rec."Bill-to City")
                {
                    ToolTip = 'Ville client facturé';
                }
                field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code")
                {
                    ToolTip = 'Code pays client facturé';
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    ToolTip = 'Contact client facturé';
                }
                field("Montant deja verse TTC"; Rec."Montant deja verse TTC")
                {
                    ToolTip = 'Montant déjà versé TTC';
                }
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'N° identifiant TVA Intracomm.';
                }

            }
            group(Livraison)
            {
                Caption = 'Livraison';
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ToolTip = 'Nom destinataire';
                }
                field("Ship-to Name 2"; Rec."Ship-to Name 2")
                {
                    ToolTip = 'Nom 2 destinataire';
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ToolTip = 'Adresse destinataire';
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ToolTip = 'Adresse 2 destinataire';
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ToolTip = 'Code postal destinataire';
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ToolTip = 'Ville destinataire';
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ToolTip = 'Code pays destinataire';
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ToolTip = 'Contact destinataire';
                }
            }
            group("Logistique/DEB")
            {
                Caption = 'Logistique/DEB';
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ToolTip = 'Code condition livraison';
                }
                field("Number Of Packages"; Rec."Number Of Packages")
                {
                    ToolTip = 'Nombre de colis';
                }
                field("Pallet Number"; Rec."Pallet Number")
                {
                    ToolTip = 'N° palette';
                }
                field("Total Net Weight"; Rec."Total Net Weight")
                {
                    ToolTip = 'Poids net total';
                }
                field("Total Gross Weight"; Rec."Total Gross Weight")
                {
                    ToolTip = 'Poids brut total';
                }
                field("Concernee DEB"; Rec."Concernee DEB")
                {
                    ToolTip = 'Concernée DEB';
                }
            }

        }
    }
}
