page 50006 MAJFournisseursEnListe
{
    ApplicationArea = All;
    Caption = 'MAJ fournisseurs en liste';
    PageType = List;
    SourceTable = Vendor;
    UsageCategory = Lists;
    InsertAllowed = false;
    DeleteAllowed = false;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'N° fournisseur';
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Nom du fournisseur';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Adresse du fournisseur';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ToolTip = 'Adresse 2 du fournisseur';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ToolTip = 'Code postal';
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Ville du fournisseur';
                }
                field("Contact Phone No."; Rec."Contact Phone No.")
                {
                    ToolTip = 'N° téléphone contact';
                }
                field(Contact; Rec.Contact)
                {
                    ToolTip = 'Contact';
                }
                field("Contact E-Mail"; Rec."Contact E-Mail")
                {
                    ToolTip = 'E-mail contact';
                }
                field("Language Code"; Rec."Language Code")
                {
                    ToolTip = 'Code langue';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ToolTip = 'Code pays';
                }
                field("Registration Number"; Rec."Registration Number")
                {
                    ToolTip = 'N° SIRET';
                }
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                    ToolTip = 'N° TVA Intracom.';
                }
                field("EORI Number"; Rec."EORI Number")
                {
                    ToolTip = 'N° EORI';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Code magasin';
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ToolTip = 'Conditions de livraison';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Code devise, laisser vide si EUR';
                }
                field("Type fournisseur"; Rec."Type fournisseur")
                {
                    ToolTip = 'Type fournisseur';
                }
                field(Transitaire; Rec.Transitaire)
                {
                    ToolTip = 'Transitaire';
                }
                field("Suivi container"; Rec."Suivi container")
                {
                    ToolTip = 'Suivi container';
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ToolTip = 'Code conditions de paiement';
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ToolTip = 'Groupe compta. marché';
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ToolTip = 'Groupe compta. marché TVA';
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                    ToolTip = 'Groupe compta. fournisseur';
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Bloqué';
                }
            }
        }
    }
        trigger OnOpenPage()
    var
        ParamUtil: Record "User Setup";

    begin

        if not ParamUtil.get(UserId) then
            ParamUtil.Init();

        ParamUtil.TestField("Editer fournisseurs en liste");
    end;
}
