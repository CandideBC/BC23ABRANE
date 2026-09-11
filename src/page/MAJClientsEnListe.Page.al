page 50001 MAJClientsEnListe
{
    ApplicationArea = All;
    Caption = 'MAJ Clients en liste';
    PageType = List;
    SourceTable = Customer;
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
                    ToolTip = 'N° client';
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Nom du client';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Adresse du client';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ToolTip = 'Adresse complémentaire du client.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ToolTip = 'Code postal du client';
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Ville du client';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ToolTip = 'Code pays du client';
                }
                field("Registration Number"; Rec."Registration Number")
                {
                    ToolTip = 'N° SIRET du client';
                }
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                    ToolTip = 'N° TVA Intracom. du client';
                }
                field("Preferred Bank Account Code"; Rec."Preferred Bank Account Code")
                {
                    ToolTip = 'Code banque';
                }
                field("Code enseigne"; Rec."Code enseigne")
                {
                    ToolTip = 'Code enseigne';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Code magasin';
                }
                field("Customer Price Group"; Rec."Customer Price Group")
                {
                    ToolTip = 'Groupe prix client';
                }
                field("Language Code"; Rec."Language Code")
                {
                    ToolTip = 'Code langue';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Code devise';
                }
                field("Code cond. paiement acomptes"; Rec."Code cond. paiement acomptes")
                {
                    ToolTip = 'Code cond. paiement acomptes';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ToolTip = 'Code conditions de paiement';
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ToolTip = 'Code mode de règlement';
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ToolTip = 'Groupe compta. marché';
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ToolTip = 'Groupe compta. marché TVA';
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ToolTip = 'Groupe compta. client';
                }
                field("Eco Tax Furniture Liable"; Rec."Eco Tax Furniture Liable")
                {
                    ToolTip = 'Soumis taxe éco-mobilier';
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

        ParamUtil.TestField("Editer clients en liste");
    end;
}
