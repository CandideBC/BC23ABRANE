pageextension 50141 PostedPurchInvUpdateExtension extends "Posted Purch. Invoice - Update"
{
    layout
    {
        addafter(General)
        {
            group("Preneur d'ordre")
            {

                field("Vendor Invoice No."; Rec."Vendor Invoice No.") //J'ai mis ce champ à la place de [External Document No] que je ne retrouve pas.
                {
                    ToolTip = 'N° doc. externe';
                }
                field("Buy-From Vendor No."; Rec."Buy-From Vendor No.")
                {
                    ToolTip = 'N° preneur d''ordre';
                }
                field("BuyFromVendorName2"; Rec."Buy-from Vendor Name")
                {
                    ToolTip = 'Nom preneur d''ordre';
                }
                field("Buy-from Vendor Name 2"; Rec."Buy-from Vendor Name 2")
                {
                    ToolTip = 'Nom 2 preneur d''ordre';
                }
                field("Buy-from Address"; Rec."Buy-from Address")
                {
                    ToolTip = 'Adresse preneur d''ordre';
                }
                field("Buy-from Address 2"; Rec."Buy-from Address 2")
                {
                    ToolTip = 'Adresse 2 preneur d''ordre';
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    ToolTip = 'Code postal preneur d''ordre';
                }
                field("Buy-from City"; Rec."Buy-from City")
                {
                    ToolTip = 'Ville preneur d''ordre';
                }
                field("Buy-from Country/Region Code"; Rec."Buy-from Country/Region Code")
                {
                    ToolTip = 'Code pays preneur d''ordre';
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    ToolTip = 'Contact preneur d''ordre';
                }
            }
            group("Fournisseur à payer")
            {
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ToolTip = 'N° fournisseur à payer';
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ToolTip = 'Nom fournisseur à payer';
                }
                field("Pay-to Name 2"; Rec."Pay-to Name 2")
                {
                    ToolTip = 'Nom 2 fournisseur à payer';
                }
                field("Pay-to Address"; Rec."Pay-to Address")
                {
                    ToolTip = 'Adresse fournisseur à payer';
                }
                field("Pay-to Address 2"; Rec."Pay-to Address 2")
                {
                    ToolTip = 'Adresse 2 fournisseur à payer';
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    ToolTip = 'Code postal fournisseur à payer';
                }
                field("Pay-to City"; Rec."Pay-to City")
                {
                    ToolTip = 'Ville fournisseur à payer';
                }
                field("Pay-to Country/Region Code"; Rec."Pay-to Country/Region Code")
                {
                    ToolTip = 'Code pays fournisseur à payer';
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    ToolTip = 'Contact fournisseur à payer';
                }
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'N° idenfiant TVA Intracomm.';
                }
            }

            group("DEB")
            {
                Caption = 'DEB';

                field("Concernee DEB"; Rec."Concernee DEB")
                {
                    ToolTip = 'Concernée DEB';
                }
            }
        }
    }
}
