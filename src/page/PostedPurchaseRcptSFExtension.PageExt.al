pageextension 50031 PostedPurchaseRcptSFExtension extends "Posted Purchase Rcpt. Subform"
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

        
        addafter(Quantity)
        {

            field("Quantite a transferer";Rec."Quantite a transferer" )
            {
                ToolTip = 'Quantité à transférer';
            }
            field("Quantité déjà transférée";Rec."Quantite deja transferee" )
            {
                ToolTip = 'Quantité déjà transférée';
            }
        }
    }

    actions
    {
        addafter(ItemInvoiceLines)
        {
            action("Imprimer fiche palette")
            {

                Caption = 'Imprimer fiche palette';
                ToolTip = 'Imprimer fiche palette';
                Image = PrintInstallment;

                trigger OnAction()
                var
                    recArticle: Record item;
                    repFichePalette : Report "Fiche palette";
                begin
                    Rec.TESTFIELD(Type,Rec.Type::Item);

                    recArticle.RESET();
                    recArticle.SETRANGE("No.",Rec."No.");
                    CLEAR(repFichePalette);
                    repFichePalette.SETTABLEVIEW(recArticle);
                    repFichePalette.RUN();
                   
                end;

            }


        }
    }     
}

