pageextension 50020 VendorListExtension extends "Vendor List"
{
    layout
    {
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Payment Terms Code")
        {
            Visible = true;
        }
        modify("Currency Code")
        {
            Visible = true;
        }
        modify(Blocked)
        {
            Visible = true;
        }
        modify("Last Date Modified")
        {
            Visible = true;
        }
        addafter(Name)
        {
            field(Address; rec.Address)
            {
                ApplicationArea = All;
                ToolTip = 'Adresse';
            }
            field("Address 2"; rec."Address 2")
            {
                ApplicationArea = All;
                ToolTip = 'Adresse 2';
            }
        }
        

        //moveafter("Vendor Posting Group";"VAT Registration No.")
        //moveafter("Vendor Posting Group";"Registration Number")
        
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
        addafter("Post Code")
        {
            field("City"; Rec.City)
            {
                ApplicationArea = All;
                ToolTip = 'Ville';
            }
        }
        addafter("Country/Region Code")
        {
            field("Suivi container"; Rec."Suivi container")
            {
                ApplicationArea = All;
                ToolTip = 'Suivi container';
            }
        }

        //moveafter("Address 2"; "Country/Region Code")
        //moveafter("Post Code"; City)
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
        //moveafter("Last Date Modified";"Search Name")
        //moveafter("Search Name";"Lead Time Calculation")
    }
    actions
    {
        modify("Recurring Purchase Lines")
        {
            Caption = 'Commandes achats types';
            Promoted = true;
            PromotedIsBig = true;
            PromotedCategory = Process;
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
        modify(Dimensions)
        {
            Visible = false;
        }
        modify(ApprovalEntries)
        {
            Visible = false;
        }
        modify("Item &Tracking Entries")
        {
            Visible = false;
        }
    }



}

