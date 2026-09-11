pageextension 50084 SalesCreditMemoExtension extends "Sales Credit Memo"
{
    layout
    {


        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Job Queue Status")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify("Posting Description")
        {
            Visible = true;
        }
        modify("Reason Code")
        {
            Visible = true;
        }

        addbefore("No.")
        {
            field(ass; Rec.ass)
            {
                ApplicationArea = All;
                ToolTip = 'SAV';
            }

        }

        addbefore(Status)
        {
            field("Amount included Ecotax"; Rec."Amount included Ecotax")
            {
                ApplicationArea = All;
                ToolTip = 'Montant écotaxe inclus';
            }
            field("Acompte a deduire (HT)"; Rec."Acompte a deduire (HT)")
            {
                ApplicationArea = All;
                ToolTip = 'Acompte à déduire (HT)';
            }

        }
        //moveafter(General;"Reason Code")


        addafter(Status)
        {

            field(Commentaire; Rec.Commentaire)
            {
                ApplicationArea = All;
                ToolTip = 'Commentaires';
            }
            field("Commentaire factu.";Rec."Commentaire factu.")
            {
                ApplicationArea = All;
                ToolTip = 'Commentaire facturation';
            }
            


        }


        addafter("Salesperson Code")
        {

            field("Code chantier"; Rec."Code chantier")
            {
                ToolTip = 'Code chantier';

            }
            field("Code operation"; Rec."Code operation")
            {
                ApplicationArea = All;
                ToolTip = 'Code opération';
            }
            field("Code groupe"; Rec."Code groupe")
            {
                ApplicationArea = All;
                ToolTip = 'Code groupe';
            }
            field("Code enseigne"; Rec."Code enseigne")
            {
                ApplicationArea = All;
                ToolTip = 'Code enseigne';
            }
            field("Annee commande";Rec."Annee commande")
            {
                ToolTip = 'Année commande';
            }
        }

        addafter("Shipment Date")
        {
 
            field("Total Net Weight"; Rec."Total Net Weight")
            {
                ApplicationArea = All;
                ToolTip = 'Poids net total';
            }
            field("Nombre de colis"; Rec."Nombre de colis")
            {
                ApplicationArea = All;
                ToolTip = 'Nombre de colis';
            }
            field("Nombre de palettes"; Rec."Nombre de palettes")
            {
                ApplicationArea = All;
                ToolTip = 'N° palette';
            }
            
            
            
        }
        addafter("Bill-to Contact No.")
        {
            field("Invoice-to Code"; Rec."Invoice-to Code")
            {
                ApplicationArea = All;
                ToolTip = 'Code adresse facturation';
            }
        }


        addlast(Billing)
        {
            field("Factor code"; Rec."Factor code")
            {
                ApplicationArea = All;
                ToolTip = 'Code banque';
            }

        }

    }

    actions
    {
        modify(SendApprovalRequest)
        {
            Visible = false;
        }
        modify(SendApprovalRequest_Promoted)
        {
            Visible = false;
        }
        modify(CancelApprovalRequest)
        {
            Visible = false;
        }
        modify(CancelApprovalRequest_Promoted)
        {
            Visible = false;
        }
        
        
        
    }

}
