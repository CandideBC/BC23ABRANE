pageextension 50108  PurchReturnOrderSFExtension extends "Purchase Return Order Subform"
{

    layout
    {
        modify("Reserved Quantity")
        {
            Visible = false;
        }


        modify("Line Discount Amount")
        {
            Visible = false;
        }


        modify("Net Weight")
            {
                Visible = true;
                ToolTip = 'Poids net';
                Style = Attention;
                StyleExpr = true;
            }

        
        addbefore(Quantity)
        {

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

