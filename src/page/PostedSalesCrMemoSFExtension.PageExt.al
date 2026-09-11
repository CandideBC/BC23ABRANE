pageextension 50030 PostedSalesCrMemoSFExtension extends "Posted Sales Cr. Memo Subform"
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

        
        addbefore(Type)
        {

            field("Line No.";Rec."Line No." )
            {
                ToolTip = 'N° ligne';
            }

        }

        addafter("Return Reason Code")
        {

            field("Reason Code";Rec."Reason Code" )
            {
                ToolTip = 'Code motif';
            }
            field("Annee commande"; Rec."Annee commande")
            {
                ToolTip = 'Année commande';
                ApplicationArea = All;
            }
            
        }



        addafter("Shortcut Dimension 2 Code")
        {

            field("Salesperson Code";Rec."Salesperson Code" )
            {
                ToolTip = 'Code vendeur';
            }
        }



    }

    actions
    {
        modify(ItemTrackingEntries)
        {
            Visible = false;
        }
        modify(Dimensions)
        {
            Visible = false;
        }
        modify(ItemReturnReceiptLines)
        {
            Visible = false;
        }
        modify(DeferralSchedule)
        {
            Visible = false;
        }
        modify(DocumentLineTracking)
        {
            Visible = false;
        }
        addafter(Comments)
        {
            action(ModifierLignes)
            {
                ApplicationArea = All;
                Caption = 'Modifier lignes';
                ToolTip = 'Permet de modifier certaines informations de la ligne d''avoir';
                
                trigger OnAction()
                var
                    EnteteAvoir: Record "Sales Cr.Memo Header";
                begin
                    EnteteAvoir.get(Rec."Document No.");
                    EnteteAvoir.EditerLignes();
                end;
            }
        }
    }     
}

