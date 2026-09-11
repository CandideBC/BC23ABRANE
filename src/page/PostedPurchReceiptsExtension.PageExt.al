pageextension 50040 PostedPurchReceiptsExtension extends "Posted Purchase Receipts"
{

    layout
    {
        //modify("Net Weight")
        //    {
        //        Visible = true;
        //        ToolTip = 'Poids net';
        //        Style = Attention;
        //        StyleExpr = true;
        //    }

        
        addafter("No.")
        {

            field("Order No.";Rec."Order No." )
            {
                ToolTip = 'N° commande';
            }
            field("Vendor Shipment No.";Rec."Vendor Shipment No." )
            {
                ToolTip = 'N° B.L. fournisseur';
            }
            field("Comments";Rec.Comments )
            {
                ToolTip = 'Commentaires';
            }

        }

        



    }

    actions
    {

    }     
}

