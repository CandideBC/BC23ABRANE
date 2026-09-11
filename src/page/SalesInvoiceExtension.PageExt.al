pageextension 50085 SalesInvoiceExtension extends "Sales Invoice"
{
    layout
    {

        modify("Incoming Document Entry No.")
        {
            Visible = false;
        }
        modify("Posting Description")
        {
            Visible = true;
        }
        modify("Campaign No.")
        {
            Visible = false;
        }
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
        modify("Direct Debit Mandate ID")
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

        addafter(Status)
        {

            field(Commentaire; Rec.Commentaire)
            {
                ApplicationArea = All;
                ToolTip = 'Commentaires';
            }
            field("Amount included Ecotax"; Rec."Amount included Ecotax")
            {
                ApplicationArea = All;
                ToolTip = 'Montant écotaxe inclus';
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
            field("Acompte pour type doc."; Rec."Acompte pour type doc.")
            {
                ApplicationArea = All;
                ToolTip = 'Acompte pour type doc.';
            }
            field("Acompte pour No. document"; Rec."Acompte pour No. document")
            {
                ApplicationArea = All;
                ToolTip = 'Acompte pour N° document';
            }
            field("Factor code"; Rec."Factor code")
            {
                ApplicationArea = All;
                ToolTip = 'Code banque';
            }
        }

        addafter("Shipment Date")
        {
            field("No. And Location Name"; Rec."No. And Location Name")
            {
                ApplicationArea = All;
                ToolTip = 'N° et nom du magasin';
            }
            
            field("Total Net Weight"; Rec."Total Net Weight")
            {
                ApplicationArea = All;
                ToolTip = 'Poids net total';
            }
            field("Poids brut total"; Rec."Poids brut total")
            {
                ApplicationArea = All;
                ToolTip = 'Poids brut total';
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
        addafter("Ship-to Name")
        {
            field("Ship-to Name 2"; Rec."Ship-to Name 2")
            {
                ApplicationArea = All;
                ToolTip = 'Nom destinataire 2';
            }
            
        }
    }

    actions
    {
        modify(SendApprovalRequest_Promoted)
        {
            Visible = false;
        }
        modify(SendApprovalRequest)
        {
            Visible = false;
        }   
        modify("Request Approval")
        {
            Visible = false;
        }
    }

    

}
