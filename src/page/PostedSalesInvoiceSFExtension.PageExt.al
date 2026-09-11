pageextension 50029 PostedSalesInvoiceSFExtension extends "Posted Sales Invoice Subform"
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
        }

        addafter("Unit Cost (LCY)")
        {

            field("Cout unitaire force";Rec."Cout unitaire force" )
            {
                ToolTip = 'Coût unitaire forcé';
            }
            field("Cout unitaire force par";Rec."Cout unitaire force par" )
            {
                ToolTip = 'Coût unitaire forcé par';
            }
            field("Cout detaille";Rec."Cout detaille" )
            {
                ToolTip = 'Coût détaillé';
            }
        }
        addafter("Appl.-to Item Entry")
        {

            field("Code chantier";Rec."Code chantier" )
            {
                ToolTip = 'Code chantier';
            }
            field("Annee commande";Rec."Annee commande" )
            {
                ToolTip = 'Année commande';
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {

            field("Salesperson Code";Rec."Salesperson Code" )
            {
                ToolTip = 'Code vendeur';
            }

            field("Nomenclature produits";Rec."Nomenclature produits" )
            {
                ToolTip = 'Nomenclature produits';
            }
        }


    }

    actions
    {
        addafter(ItemShipmentLines)
        {
            action("Masquer composants")
            {

                Caption = 'Masquer composants';
                ToolTip = 'Masquer composants';
                Image = BOM;
                
                trigger OnAction()
                var
                    
                    
                begin
                    Rec.setrange("Linked to line",0);
                   
                end;

            }
                            /*

      { 1000000005;2 ;Action    ;
                      CaptionML=FRA=Modifier cot art. divers;
                      OnAction=BEGIN
                                 EditUnitCost;
                               END;
                                }                */
            action("Modifier coût art. divers")
            {
                Caption = 'Modifier coût art. divers';
                ToolTip = 'Modifier coût art. divers';
                trigger OnAction()
                begin
                    rec.EditUnitCost();
                end;
            }
        }
    }     
}

