pageextension 50013 "SalesLinesExtension" extends "Sales Lines"
{
    layout
    {
        modify(Reserve)
        {
            Visible = false;
        }
        modify(Type)
        {
            Visible = false;
        }
        modify("Reserved Qty. (Base)")
        {
            Visible = false;
        }
        modify("Shipment Date")
        {
            Visible = false;
        }

        moveafter(Quantity; "Outstanding Quantity")

        addafter("Outstanding Quantity")
        {
            field("Montant restant HT (DS)"; Rec."Montant restant HT (DS)")
            {
                ApplicationArea = All;
                ToolTip = 'Montant restant HT (DS)';
                Visible = false;
            }
            field("Livre non facture HT (DS)"; Rec."Livre non facture HT (DS)")
            {
                ApplicationArea = All;
                ToolTip = 'Livré non facturé HT (DS)';
                Visible = false;
            }
        }
        addafter("Unit of Measure Code")
        {
            field("Date chargement"; Rec."Date chargement")
            {
                ApplicationArea = All;
            }
            field("Date livraison demandee"; Rec."Date livraison demandee")
            {
                ApplicationArea = All;
                ToolTip = 'Date livraison demandée';
            }

            field("Annee commande"; Rec."Annee commande")
            {
                ApplicationArea = All;
                ToolTip = 'Année commande';
            }
            field("Code enseigne"; Rec."Code enseigne")
            {
                ApplicationArea = All;
                ToolTip = 'Code enseigne';
            }
            field("Code groupe"; Rec."Code groupe")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Code groupe';
            }
            field("Code operation"; Rec."Code operation")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Code opération';
            }
            field("Code chantier"; Rec."Code chantier")
            {
                ApplicationArea = All;
                ToolTip = 'Code chantier';
            }
        }
        addbefore("Line Amount")
        {
            field("Unit Price"; Rec."Unit Price")
            {
                ApplicationArea = All;
            }

        }

    }
}
