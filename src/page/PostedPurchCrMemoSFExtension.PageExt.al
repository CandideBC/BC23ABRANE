pageextension 50035 PostedPurchCrMemoSFExtension extends "Posted Purch. Cr. Memo Subform"
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

        modify("Deferral Code")
        {
            Visible = false;
        }

        addafter("Shortcut Dimension 2 Code")
        {

            field("Purchaser Code";Rec."Purchaser Code" )
            {
                ToolTip = 'Code acheteur';
            }
            field("Annee commande"; Rec."Annee commande")
            {
                ApplicationArea = All;
                ToolTip = 'Année commande';
            }
            field("Nomenclature produits"; Rec."Nomenclature produits")
            {
                ApplicationArea = All;
                ToolTip = 'Nomenclature produits';
            }

        }

    }

    actions
    {
        modify(DeferralSchedule)
        {
            Visible = false;
        }
        modify(Dimensions)
        {
            Visible = false;
        }
        modify(ItemTrackingEntries)
        {
            Visible = false;
        }
        modify(DocumentLineTracking)
        {
            Visible = false;
        }
        modify(ItemReturnShipmentLines)
        {
            Visible = false;
        }
        addlast(processing)
        {
            action(ModifierLignes)
            {
                ApplicationArea = All;
                Caption = 'Modifier lignes';
                ToolTip = 'Permet de modifier certaines informations de la ligne d''avoir';
                
                trigger OnAction()
                var
                    EnteteAvoir: Record "Purch. Cr. Memo Hdr.";
                begin
                    EnteteAvoir.get(Rec."Document No.");
                    EnteteAvoir.EditerLignes();
                end;
            }
        }
    }     
}

