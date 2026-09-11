pageextension 50090 PurchaseInvoiceSFExtension extends "Purch. Invoice Subform"
{

    layout
    {
        movebefore(Type;"Line No.")
        
        moveafter("Variant Code";"Gen. Prod. Posting Group")
        
        addafter(Description)
        {
            field("Affectation manquante"; Rec."Affectation manquante")
            {
                ApplicationArea = All;
                ToolTip = 'Affectation manquante';
            }
            
        }
        addafter("Allow Item Charge Assignment")
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
            field("Code operation";Rec."Code operation")
            {
                ToolTip = 'Code opération';
            }
            field("Code chantier"; Rec."Code chantier")
            {
                ToolTip = 'Code chantier';
            }

            field("Nomenclature produits";Rec."Nomenclature produits")
            {
                ToolTip = 'Nomenclature produits';
            }

            
        }


        
    }

    actions
    {
        
    }
}

