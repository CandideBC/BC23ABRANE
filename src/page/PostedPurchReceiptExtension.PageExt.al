pageextension 50043 PostedPurchReceiptExtension extends "Posted Purchase Receipt"
{

    layout
    {
        addafter("No.")
        {
            field("Annee commande"; Rec."Annee commande")
            {
                ApplicationArea = All;
                ToolTip = 'Année commande';
            }
        }
        
        addafter("Vendor Shipment No.")
        {

            field("No. facture fournisseur";Rec."No. facture fournisseur" )
            {
                ToolTip = 'N° facture fournisseur';
            }
            field("N° container";Rec."No. container" )
            {
                ToolTip = 'N° container';
            }


        }
        addafter("Purchaser Code")
        {

            field("Comments";Rec."Comments" )
            {
                ToolTip = 'Commentaires';
            }
            field("Code magasin transfert";Rec."Code magasin transfert" )
            {
                ToolTip = 'Code magasin transfert';
            }
            field("Date transfert";Rec."Date transfert" )
            {
                ToolTip = 'Date transfert';
            }
            field("Vu controle SAV / Avoir";Rec."Vu controle SAV / Avoir" )
            {
                ToolTip = 'Vu controle SAV / Avoir';
            }
        }
    }

    actions
    {
        addafter("&Navigate")
        {
            action("Transférer")
            {
                Promoted = true;
                PromotedIsBig = true;
                Image = TransferReceipt;
                PromotedCategory = Process;
 
                trigger OnAction()
                begin
                    Rec.Transferer();
                end;
            }
        }
    }     
}

