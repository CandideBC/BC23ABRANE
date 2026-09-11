pageextension 50079 PurchaseCreditMemoSFExtension extends "Purch. Cr. Memo Subform"
{

    layout
    {
        addafter("Line Amount")
        {
            field("Code groupe"; Rec."Code groupe")
            {
                ApplicationArea = All;
                ToolTip = 'Code groupe';
            }
            
            field("Code enseigne"; Rec."Code enseigne")
            {
                ToolTip = 'Code enseigne';
            }
            field("Code chantier"; Rec."Code chantier")
            {
                ToolTip = 'Code chantier';
            }
            field("Nature vente"; Rec."Nature vente")
            {
                ToolTip = 'Nature de vente';
            }
            field("Annee commande"; Rec."Annee commande")
            {
                ToolTip = 'Année commande';
                ApplicationArea = All;
            }
            
        }
    }

    actions
    {
        
    }
        
}

