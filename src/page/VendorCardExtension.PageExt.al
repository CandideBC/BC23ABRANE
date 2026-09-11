pageextension 50019 VendorCardExtension extends "Vendor Card"
{
    layout
    {
        modify(County)
        {
            Visible = false;
        }
        modify("Company Size Code")
        {
            Visible = false;
        }
        modify("Language Code")
        {
            Importance = Standard;
        }
        modify("Phone No.")
        {
            Visible = false;
        }
        modify(Blocked)
        {
            ToolTip = 'Specifies that the related record is blocked from being posted in transactions, for example a vendor that is declared insolvent or an item that is placed in quarantine.';
        }
        modify(ShowMap)
        {
            ToolTip = 'Specifies you can view the vendor''s address on your preferred map website.';
        }
        modify("Primary Contact No.")
        {
            ToolTip = 'Specifies the primary contact number for the vendor.';
        }
        modify("Purchaser Code")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("IC Partner Code")
        {
            Visible = false;
        }
        modify("Prices Including VAT")
        {
            Visible = false;
        }
        modify("Invoice Disc. Code")
        {
            Visible = false;
        }
        modify("Prepayment %")
        {
            Visible = false;
        }
        modify("Application Method")
        {
            Visible = false;
        }
        modify("Partner Type")
        {
            Visible = false;
        }
        modify("Block Payment Tolerance")
        {
            Visible = false;
        }
        modify("Privacy Blocked")
        {
            Visible = false;
        }
        modify("Creditor No.")
        {
            Visible = false;
        }
        modify("Tax Liable")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        moveafter("Vendor Posting Group";"VAT Registration No.")
        moveafter("Vendor Posting Group";"Registration Number")
        addafter("Registration Number")
        {
            field("Fournisseur divers"; Rec."Fournisseur divers")
            {
                ApplicationArea = All;
                ToolTip = 'Fournisseur divers. Imposera notamment la saisie du pays origine lorsqu''on crée une commande d''achat depuis une vente';
            }
            field("% acompte demande"; Rec."% acompte demande")
            {
                ApplicationArea = All;
                ToolTip = '% acompte demandé';
            }
            field("Code cond. paiement acomptes"; Rec."Code cond. paiement acomptes")
            {
                ApplicationArea = All;
                ToolTip = 'Code cond. paiement acomptes';
            }
            
            
        }
        
        addafter("Purchaser Code")
        {
            field("Type fournisseur";rec."Type fournisseur")
            {
                ToolTip = '"Type fournisseur"';
            }
            field(Transitaire; Rec.Transitaire)
            {
                ApplicationArea = All;
                ToolTip = 'Transitaire';
            }

        }
        addafter("Location Code")
        {
            field("Suivi container"; Rec."Suivi container")
            {
                ApplicationArea = All;
                ToolTip = 'Suivi container';
            }
        }

        moveafter("Address 2"; "Country/Region Code")
        moveafter("Post Code"; City)
        addafter(Contact)
        {
            field("Contact Phone No.";rec."Contact Phone No.")
            {
                ToolTip = 'N° téléphone contact';
            }
            field("Contact E-Mail";rec."Contact E-Mail")
            {
                ToolTip = 'E-mail contact';
            }
        }
        moveafter("Last Date Modified";"Search Name")
        moveafter("Search Name";"Lead Time Calculation")
    }
    actions
    {
        modify(PayVendor_Promoted)
        {
            Visible = false;
        }
        modify(Dimensions)
        {
            Visible = false;
        }
        modify(RemitAddresses)
        {
            Visible = false;
        }
        modify(OrderAddresses)
        {
            Visible = false;
        }
        modify("&Payment Addresses")
        {
            Visible = false;
        }
        
        
        modify(Dimensions_Promoted)
        {
            Visible = false;
        }
        modify("Invoice &Discounts")
        {
            ToolTip = 'Set up different discounts that are applied to invoices for the vendor. An invoice discount is automatically granted to the vendor when the total on a sales invoice exceeds a certain amount.';
        }
        modify("Blanket Orders")
        {
            Caption = 'Commandes ouvertes';
            ToolTip = 'Ouvre la liste des commandes ouvertes';
        }
        modify(NewBlanketPurchaseOrder)
        {
            Caption = 'Commande ouverte';
            ToolTip = 'Crée une nouvelle commande ouverte pour le fournisseur.';
        }
        modify("Request Approval")
        {
            Visible = false;
        }
        modify(MergeDuplicate_Promoted)
        {
            Visible = false;
        }
        modify(ApplyTemplate_Promoted)
        {
            Visible = false;
        }
    }



}

