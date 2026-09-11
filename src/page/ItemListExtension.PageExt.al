pageextension 50009 ItemListExtension extends "Item List"
{
    layout
    {
        modify(InventoryField)
        {
            Visible = false;
        }
        modify("Substitutes Exist")
        {
            Visible = false;
        }

        modify("Production BOM No.")
        {
            Visible = false;
        }
        modify("Routing No.")
        {
            Visible = false;
        }
        modify("Search Description")
        {
            Visible = false;
        }
        modify("Default Deferral Template Code")
        {
            Visible = false;
        }
        modify("VAT Prod. Posting Group")
        {
            Visible = false;
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        modify(ItemAttributesFactBox)
        {
            Visible = false;
        }
        modify(Control1906840407) //Item planning factbox
        {
            Visible = false;
        }

        //modify()
        addafter("No.")
        {
            field("Ref. client"; Rec."Ref. client")
            {
                Caption = 'Référence client';
                ToolTip = 'Référence client';
            }
            field("Complement ref. client"; Rec."Complement ref. client")
            {
                ToolTip = 'Complément réf. client';
            }
        }
        addafter(Description)
        {
            field("Dimension"; Rec.Dimension)
            {
                ToolTip = 'Dimension';
            }
            field("Miscellaneous Item"; Rec."Miscellaneous Item")
            {
                ToolTip = 'Article divers';
                Visible = false;
            }
        }

        moveafter(Dimension; "Base Unit of Measure")
        addafter("Base Unit of Measure")
        {
            field("Stock"; Rec.Stock)
            {
                ToolTip = 'Stock';
            }
            field(StockProjete;Rec.Stock + Rec."Qty. on Purch. Order" - Rec."Qty. on Sales Order")
            {
                Caption = 'Stock projeté';
                ToolTip = 'Stock + Qté sur commandes achats - Qté sur commandes ventes';
                DecimalPlaces = 0:5;
                BlankZero = true;
            }
            field("Quantite en transit"; Rec."Quantite en transit")
            {
                ApplicationArea = All;
                ToolTip = 'Quantité en transit';
            }

            field("Inventory trash"; Rec."Inventory trash")
            {
                ToolTip = 'Stock rebut';
            }
            field("Qty. on Purch. Order"; Rec."Qty. on Purch. Order")
            {
                ToolTip = 'Qté sur commandes achats';
            }
            field("Qty. on Sales Order"; Rec."Qty. on Sales Order")
            {
                ToolTip = 'Qté sur commandes ventes';
            }

        }
        moveafter("Qty. on Sales Order"; "Vendor No.")

        addafter("Vendor No.")
        {
            field("Nom fournisseur"; Rec."Nom fournisseur")
            {
                ToolTip = 'Nom fournisseur';
            }
            field("Net Weight"; Rec."Net Weight")
            {
                ToolTip = 'Poids net';
            }

            field("Code matiere"; Rec."Code matiere")
            {
                ToolTip = 'Code matière';
            }
            field("Designation matiere"; Rec."Designation matiere")
            {
                ToolTip = 'Désignation matière';
                Visible = false;
            }
            field("Eco Tax Furniture Code"; Rec."Eco Tax Furniture Code")
            {
                ToolTip = 'Code Ecotaxe';
                Visible = true;
            }
            field("Codifab"; Rec.Codifab)
            {
                ToolTip = 'Codifab';
                Visible = false;
            }

        }
        moveafter("Eco Tax Furniture Code"; "Tariff No.")

        modify("Tariff No.")
        {
            Visible = true;
        }

        modify("Unit Cost")
        {
            Visible = false;
        }

        modify("Unit Price")
        {
            Visible = false;
        }

        modify("Cost is Adjusted")
        {
            Visible = false;
        }
        modify("Assembly BOM")
        {
            Visible = false;
        }



    }
    actions
    {
        modify(CopyItem)
        {
            Visible = false;
        }
        modify(PrintLabel)
        {
            Visible = false;
        }
        modify(DimensionsMultiple)
        {
            Visible = false;
        }
        modify(DimensionsSingle)
        {
            Visible = false;
        }
        modify("Co&mments")
        {
            Visible = false;
        }
        modify(ClearAttributes)
        {
            Visible = false;
        }
        modify(FilterByAttributes)
        {
            Visible = false;
        }
        modify("Item Price List")
        {
            Visible = false;
        }
        modify("Price List")
        {
            Visible = false;
        }
        modify("Inventory - Reorders")
        {
            Visible = false;
        }
        modify("Inventory Order Details")
        {
            Visible = false;
        }
        modify("Inventory - Sales Back Orders")
        {
            Visible = false;
        }
        modify("Inventory - Availability Plan")
        {
            Visible = false;
        }
        modify("Adjust Item Cost/Price")
        {
            Visible = false;
        }
        modify(Production)
        {
            Visible = false;
        }
        modify(Warehouse)
        {
            Visible = false;
        }
        modify(Service)
        {
            Visible = false;
        }
        modify(Resources)
        {
            Visible = false;
        }
        modify("Prepa&yment Percentages")
        {
            Visible = false;
        }
        modify("Ca&talog Items")
        {
            Visible = false;
        }
        modify("Inventory Valuation")
        {
            Visible = false;
        }
        modify(ApprovalEntries)
        {
            Visible = false;
        }
        modify(Structure)
        {
            Visible = false;
        }
        modify("Cost Shares")
        {
            Visible = false;
        }
        modify(Attributes)
        {
            Visible = false;
        }
        modify(Reports)
        {
            Visible = false;
        }
        modify(ApplyTemplate)
        {
            Visible = false;
        }
        modify(Workflow)
        {
            Visible = false;
        }
        modify("Requisition Worksheet")
        {
            Visible = false;
        }
        modify(RequestApproval)
        {
            Visible = false;
        }
        modify("Item Tracing")
        {
            Visible = false;
        }
        //modify()
        addafter("Item Refe&rences")
        {
            action(CalculerStockDispo)
            {
                ApplicationArea = All;
                Caption = 'Disponibilité';
                ToolTip = 'Afficher le détail de la disponibilité de l''article.';
                Image = InventoryCalculation;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                
                trigger OnAction()
                var
                    MaQteDispo:Decimal;
                begin
                    Rec.CalculerDispo(true,MaQteDispo);
                end;
            }
            action("Imprimer fiche palette")
            {
                Caption = 'Imprimer fiche palette';
                ToolTip = 'Imprimer fiche palette';
                Image = PrintInstallment;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    recArticle: Record Item;
                    repFichePalette: Report "Fiche palette";
                begin
                    //DIA£NBE 02/01/2015 DEBUT
                    recArticle.Reset();
                    recArticle.SetRange("No.", Rec."No.");
                    Clear(repFichePalette);
                    repFichePalette.SetTableView(recArticle);
                    repFichePalette.Run();
                    //DIA£NBE 02/01/2015 FIN
                end;
            }

            action("Supprimer articles annulés")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category8;
                RunObject = report "Supprimer Articles ANNULE";
                ToolTip = 'Supprime tous les articles dont le champ [Ref. client] vaut ANNULE';
                Image = Delete;
            }

        }

    }
}

