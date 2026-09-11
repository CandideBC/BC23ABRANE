pageextension 50033 PostedPurchInvoiceSFExtension extends "Posted Purch. Invoice Subform"
{

    layout
    {
        //modify("Reserved Quantity")
        //{
        //    Visible = false;
        //}



        //modify("Net Weight")
        //    {
        //        Visible = true;
        //        ToolTip = 'Poids net';
        //        Style = Attention;
        //        StyleExpr = true;
        //    }

        
        addafter("Allow Invoice Disc.")
        {

            field("Annee commande";Rec."Annee commande" )
            {
                ToolTip = 'Année commande';
            }
            field("Nomenclature produits"; Rec."Nomenclature produits")
            {
                ApplicationArea = All;
                ToolTip = 'Nomenclature produits';
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {

            field("Purchaser Code";Rec."Purchaser Code" )
            {
                ToolTip = 'Code acheteur';
            }

        }

    }

    actions
    {

    }     
}

