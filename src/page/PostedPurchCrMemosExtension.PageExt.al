pageextension 50042 PostedPurchCrMemosExtension extends "Posted Purchase Credit Memos"
{

    layout
    {
        addafter("No. Printed")
        {

            field("Concernee DEB";Rec."Concerne DEB" )
            {
                ToolTip = 'Concernée DEB';
            }
            field("Periode validation DEB";Rec."Periode validation DEB" )
            {
                ToolTip = 'Période validation DEB';
            }
        }
        addafter("Applies-to Doc. Type")
        {
            field("Comments";Rec.Comments )
            {
                ToolTip = 'Commentaires';
            }
        }
        addafter("Posting Date")
        {
            field("Code groupe";Rec."Code groupe")
            {
                ApplicationArea = All;
                ToolTip = 'Code groupe';
            }
            field("Code enseigne";Rec."Code enseigne")
            {
                ApplicationArea = All;
                ToolTip = 'Code enseigne';
            }
            field("Code operation";Rec."Code operation")
            {
                ApplicationArea = All;
                ToolTip = 'Code opération';
            }
            field("Code chantier";Rec."Code chantier")
            {
                ApplicationArea = All;
                ToolTip = 'Code chantier';
            }
            field("Annee commande";Rec."Annee commande")
            {
                ApplicationArea = All;
                ToolTip = 'Année commmande';
            }
            field("Achat pour stock";Rec."Achat pour stock")
            {
                ApplicationArea = All;
                ToolTip = 'Achat pour stock';
            }
           
        }
    }
    actions
    {

    }     
}

