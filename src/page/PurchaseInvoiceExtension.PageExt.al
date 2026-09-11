pageextension 50088 PurchaseInvoiceExtension extends "Purchase invoice"
{
    layout
    {
        
        
        modify("On Hold")
        {
            Visible = false;
            Editable = false;
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

        modify("Prices Including VAT")
        {
            Visible = false;
        }   

        moveafter("Document Date";"Vendor Invoice No.")

        addafter("Buy-from Contact")
        {
            field("Date limite reponse";Rec."Date limite reponse")
            {
                ToolTip = 'Date limite réponse';
            }
        }        

        addafter("Document Date")
        {
            field("Code chantier";Rec."Code chantier")
            {
                ToolTip = 'Chantier';
                Editable = not Rec."Achat pour stock";
            }
            field("Code groupe";Rec."Code groupe")
            {
                ToolTip = 'Groupe';
            }    
            field("Code enseigne";Rec."Code enseigne")
            {
                ToolTip = 'Enseigne';
            }    
            field("Code operation";Rec."Code operation")
            {
                ToolTip = 'Opération';
            }    
        }
        addafter("Purchaser Code")
        {
            field(Commentaires;Rec.Commentaires)
            {
                ToolTip = 'Commentaires';
            }    
        }   
        
        addafter(Status)
        {
            field("Affectations manquantes";Rec."Affectations manquantes")
            {
                ToolTip = 'Affectations manquantes';
            }

            // field(Amount;Rec.Amount)
            // {
            //     ToolTip = 'Montant';
            // }
       
        }     
        addbefore("VAT Bus. Posting Group")
        {
            field("Gen. Bus. Posting Group";Rec."Gen. Bus. Posting Group")
            {
                ToolTip = 'Groupe compta marché';
            }
        }    
        addafter("VAT Bus. Posting Group")
        {
            field("Applies-to Doc. Type";Rec."Applies-to Doc. Type")
            {
                ToolTip = 'Type doc. lettrage';
            }
            field("Applies-to Doc. No.";Rec."Applies-to Doc. No.")
            {
                ToolTip = 'N° doc. lettrage';
            }
        }     
    }
    
    actions
    {
            
    }

}
