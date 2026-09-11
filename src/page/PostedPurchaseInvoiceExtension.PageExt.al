pageextension 50032 PostedPurchaseInvoiceExtension extends "Posted Purchase Invoice"
{
    layout
    {
        addbefore("Order No.")
        {
            field("Annee commande"; Rec."Annee commande")
            {
                ToolTip = 'Année commande';
            }

        }

        addafter("Vendor Invoice No.")
        {
            field("Posting Description"; Rec."Posting Description")
            {
                ToolTip = 'Libellé écriture';
            }
        }
        addafter("Purchaser Code")
        {
            field("Code groupe"; Rec."Code groupe")
            {
                ToolTip = 'Code groupe';
            }
            field("Code enseigne"; Rec."Code enseigne")
            {
                ToolTip = 'Code enseigne';
            }
            field("Code operation"; Rec."Code operation")
            {
                ToolTip = 'Code opération';
            }
            field("Code chantier"; Rec."Code chantier")
            {
                ToolTip = 'Code chantier';
            }
            field("Achat pour stock"; Rec."Achat pour stock")
            {
                ToolTip = 'Achat pour stock';
            }
            field("Comments"; Rec.Comments)
            {
                ToolTip = 'Commentaires';
            }
        }
    }

    actions
    {
        addafter("&Navigate")
        {
            /*
            Migration : j'ai adapté le standard qui inclut maintenant une fonctionnalité de mise à jour de la facture
            action("Modifier adresses")
            {
                Caption = 'Modifier adresses';
                ToolTip = 'Modifier adresses';
                Image = AlternativeAddress;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                begin
                    Rec.EditAddress();
                end;
            }
            */
        }
    }
}

