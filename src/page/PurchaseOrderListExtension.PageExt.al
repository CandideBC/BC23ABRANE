pageextension 50050 PurchaseOrderListExtension extends "Purchase Order List"
{
    layout
    {
        moveafter("No."; Status)
        modify("Buy-from Vendor No.")
        {
            Visible = false;
        }
        
        addafter(Status)
        {
            field("Achat pour stock"; Rec."Achat pour stock")
            {
                ApplicationArea = All;
                ToolTip = 'Achat pour stock';
            }
            
            field("SAV Type"; Rec."SAV Type")
            {
                ApplicationArea = All;
                ToolTip = 'Type SAV';
            }
        }

        modify("Purchaser Code")
        {
            Visible = true;
        }

        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Vendor Authorization No.")
        {
            Visible = false;
        }
        addafter("Buy-from Vendor Name")
        {
            field("Commentaires"; Rec."Commentaires")
            {
                ToolTip = 'Commentaires';
            }


            field("Code groupe"; Rec."Code groupe")
            {
                ToolTip = 'Code groupe';
                Visible = false;
            }
            field("Code chantier"; Rec."Code chantier")
            {
                ToolTip = 'Code chantier';
            }
            field("Code enseigne"; Rec."Code enseigne")
            {
                ToolTip = 'Code enseigne';
            }
            field("Code operation"; Rec."Code operation")
            {
                ToolTip = 'Code opération';
                Visible = false;
            }
            field("Annee commande"; Rec."Annee commande")
            {
                ApplicationArea = All;
                ToolTip = 'Année commande';
            }

        }
        moveafter(Commentaires; Amount, "Amount Including VAT","Purchaser Code")

        addafter(Commentaires)
        {
            field("Commentaires pour AIE"; Rec."Commentaires pour AIE")
            {
                ApplicationArea = All;
                ToolTip = 'Commentaires pour AIE';
            }
        }

        

        addafter("Purchaser Code")
        {
            field("Semaine chargement"; Rec."Semaine chargement")
            {
                ApplicationArea = All;
                ToolTip = 'Numéro de semaine de chargement';
            }
            
            field("Date chargement confirmee"; Rec."Date chargement confirmee")
            {
                ApplicationArea = All;
                ToolTip = 'Date de chargement réelle saisie par l''AIE';
            }
            
        }
        addafter("Date chargement confirmee")
        {
            field("Expected Receipt Date"; Rec."Expected Receipt Date")
            {
                ApplicationArea = All;
                ToolTip = 'Date réception prévue';
            }
            
        }

        modify("Document Date")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }

    }
    actions
    {
        modify("Send IC Purchase Order")
        {
            Visible = false;
        }
        modify(Warehouse)
        {
            Visible = false;
        }
        modify("Create &Whse. Receipt")
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
        modify("Create Inventor&y Put-away/Pick")
        {
            Visible = false;
        }
        modify(Dimensions)
        {
            Visible = false;
        }
        modify(Approvals)
        {
            Visible = false;
        }
        modify(PostBatch)
        {
            Visible = false;
        }
        modify(TestReport)
        {
            Visible = false;
        }
        modify("Delete Invoiced")
        {
            Visible = false;
        }
        modify(Preview)
        {
            Visible = false;
        }
        modify(PostedPurchaseInvoices)
        {
            Visible = false;
        }
        //moveafter(Receipts;PostedPurchasePrepmtInvoices,"Prepayment Credi&t Memos")
        modify("Prepayment Credi&t Memos")
        {
            Visible = false;
        }
        modify(PostedPurchasePrepmtInvoices)
        {
            Visible = false;
        }

        addafter(Print)
        {

            action("Etiquette palette")
            {
                ApplicationArea = All;
                ToolTip = 'Etiquette palette';
                Image = SuggestItemPrice;
                Promoted = true;
                PromotedCategory = Category5;
                trigger OnAction()
                begin
                    rec.GenererEtiquettePalette(true);
                end;
            }
        }
    }
}
