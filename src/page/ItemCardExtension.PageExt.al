pageextension 50008 ItemCardExtension extends "Item Card"
{

    layout
    {
        modify(Reserve)
        {
            Visible = true;
            Importance = Standard;
        }
        modify(Inventory)
        {
            Visible = false;
        }
        modify("Gross Weight")
        {
            Visible = false;
        }
        modify("Net Weight")
        {
            Visible = true;
        }
        modify("Tax Group Code")
        {
            Visible = false;
        }

        modify("Service Item Group")
        {
            Visible = false;
        }
        modify("Shelf No.")
        {
            Visible = false;
        }
        modify("Qty. on Service Order")
        {
            Visible = false;
        }
        modify("Standard Cost")
        {
            Visible = false;
        }
        modify("Indirect Cost %")
        {
            Visible = false;
        }
        modify("Net Invoiced Qty.")
        {
            Visible = false;
        }
        modify("Price Includes VAT")
        {
            Visible = false;
        }
        modify("Price/Profit Calculation")
        {
            Visible = false;
        }
        modify("Profit %")
        {
            Visible = false;
        }
        modify("Item Disc. Group")
        {
            Visible = false;
        }
        modify("VAT Bus. Posting Gr. (Price)")
        {
            Visible = false;
        }
        modify("Order Tracking Policy")
        {
            Visible = false;
        }
        modify(Critical)
        {
            Visible = false;
        }
        modify("Item Category Code")
        {
            Visible = false;
        }

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
        modify("Description 2")
        {
            Visible = true;
            Importance = Standard;
        }
        modify(GTIN)
        {
            Visible = false;
        }

        moveafter(Description; "Description 2", "Base Unit of Measure")
        moveafter("Description 2"; AssemblyBOM)
        addafter("Base Unit of Measure")
        {
            field(Phase; Rec.Phase)
            {
                ApplicationArea = All;
                ToolTip = 'Phase';
            }
            
            field("Dimension"; Rec.Dimension)
            {
                ToolTip = 'Dimension';
            }
            field("Unit Of Measure"; Rec."Unit Of Measure")
            {
                ToolTip = 'Unité';
            }
            field("Code matiere"; Rec."Code matiere")
            {
                ToolTip = 'Code matière';
            }
            field("Designation matiere"; Rec."Designation matiere")
            {
                ToolTip = 'Désignation matière';
            }
            field("Eco Tax Furniture Code"; Rec."Eco Tax Furniture Code")
            {
                ApplicationArea = All;
                ToolTip = 'Code écocontribution';
            }
        }
        moveafter("Eco Tax Furniture Code"; "Tariff No.", "Country/Region of Origin Code")
        moveafter("Unit Of Measure"; "Net Weight")
        moveafter("Net Weight"; "Vendor No.")



        modify(Type)
        {
            Importance = Additional;
        }
        modify("Last Date Modified")
        {
            Importance = Standard;
        }

        modify(VariantMandatoryDefaultNo)
        {
            Visible = false;
        }
        modify(VariantMandatoryDefaultYes)
        {
            Visible = false;
        }
        modify("Created From Nonstock Item")
        {
            Visible = false;
        }
        modify("Search Description")
        {
            Visible = false;
        }
        modify("Qty. on Prod. Order")
        {
            Visible = false;
        }
        modify("Qty. on Component Lines")
        {
            Visible = false;
        }
        modify("Qty. on Job Order")
        {
            Visible = false;
        }
        modify("Qty. on Assembly Order")
        {
            Visible = false;
        }
        modify("Qty. on Asm. Component")
        {
            Visible = false;
        }
        modify(StockoutWarningDefaultNo)
        {
            Importance = Additional;
        }
        modify(StockoutWarningDefaultYes)
        {
            Importance = Additional;
        }
        modify(PreventNegInventoryDefaultNo)
        {
            Importance = Additional;
        }
        modify(PreventNegInventoryDefaultYes)
        {
            Importance = Additional;
        }
        modify("Unit Volume")
        {
            Visible = false;
        }
        moveafter("Last Date Modified"; Blocked, "Purchasing Blocked", "Sales Blocked")


        addafter("Automatic Ext. Texts")
        {

            field("Miscellaneous Item"; Rec."Miscellaneous Item")
            {
                ToolTip = 'Article divers';
            }
            field("Poids obligatoire"; Rec."Poids obligatoire")
            {
                ToolTip = 'Poids obligatoire';
            }
            field("Article divers jamais acheté"; Rec."Article divers jamais acheté")
            {
                ToolTip = 'Article divers jamais acheté';
                Importance = Additional;
            }
            field("Ne pas regrouper sur BP"; Rec."Ne pas regrouper sur BP")
            {
                ToolTip = 'Ne pas regrouper sur BP';
            }
        }
        modify("Automatic Ext. Texts")
        {
            Visible = false;
        }
        modify("Common Item No.")
        {
            Visible = false;
        }
        modify("Purchasing Code")
        {
            Visible = false;
        }
        modify("Cost is Adjusted")
        {
            Visible = false;
        }

        addafter(InventoryNonFoundation)
        {
            field("Stock"; Rec.Stock)
            {
                ToolTip = 'Stock';
            }
            field("Quantite en transit"; Rec."Quantite en transit")
            {
                ToolTip = 'Quantité en transit';
            }


            field("Inventory trash"; Rec."Inventory trash")
            {
                ToolTip = 'Stock rebut';
            }
        }
        addafter("Qty. on Asm. Component")
        {
            field("Sales (Qty.)"; Rec."Sales (Qty.)")
            {
                ToolTip = 'Ventes (Qté)';
            }
            field("Purchases (Qty.)"; Rec."Purchases (Qty.)")
            {
                ToolTip = 'Achats (Qté)';
            }
        }
        addafter("Unit Price")
        {
            field("Prix bloque"; Rec."Prix bloque")
            {
                ToolTip = 'Prix bloqué';
            }
        }
        addafter("Application Wksh. User ID")
        {
            field(Codifab; Rec.Codifab)
            {
                ToolTip = 'Codifab';
            }
        }
        addafter("Vendor No.")
        {
            field("Nom fournisseur"; Rec."Nom fournisseur")
            {
                ToolTip = 'Nom fournisseur';
            }
        }

        moveafter("Nom fournisseur"; "Lead Time Calculation")

        addafter("Last Direct Cost")
        {
            field("Nature vente"; Rec."Nature vente")
            {
                ToolTip = 'Nature de vente';
            }
        }
        /*
        addafter(AssemblyBOM)
        {
            field("Prix/Cout relation"; Rec."Prix/Cout relation")
            {
                ToolTip = 'Prix/Cout relation';
            }
            group("Conditionnement / Palettisation")
            {
                Caption = 'Conditionnement / Palettisation';
                group(Control1000000080)
                {
                    //The GridLayout property is only supported on controls of type Grid
                    //GridLayout = Rows;
                    ShowCaption = false;
                    field("Indice plan conditionnement"; Rec."Indice plan conditionnement")
                    {
                        Caption = 'Indice du plan de conditionnement';
                        ToolTip = 'Indice plan conditionnement';
                    }
                    field(Commentaires; Rec.Commentaires)
                    {
                        ToolTip = 'Commentaires';
                    }
                    grid("Emballage individuel de la pièce :")
                    {
                        Caption = 'Emballage individuel de la pièce :';

                        GridLayout = Rows;
                        group(Control1000000076)
                        {
                            ShowCaption = false;
                            field("Film retractable"; Rec."Film retractable")
                            {
                                ToolTip = 'Film retractable';
                            }
                            field("Film bulle"; Rec."Film bulle")
                            {
                                ToolTip = 'Film bulle';
                            }
                            field(Rien; Rec.Rien)
                            {
                                ToolTip = 'Rien';
                            }
                            field("Sachet plastique"; Rec."Sachet plastique")
                            {
                                ToolTip = 'Sachet plastique';
                            }
                        }
                    }
                    grid("Conditionnement/Palettisation de la pièce :")
                    {
                        Caption = 'Conditionnement/Palettisation de la pièce :';
                        GridLayout = Rows;
                        group("-")
                        {
                            Caption = '-';
                            //The GridLayout property is only supported on controls of type Grid
                            //GridLayout = Rows;
                        }
                    }
                }
            }
            group("Conditionnement/Palettisation Carton")
            {
                Caption = 'General';
                field("Emballage par carton"; Rec."Emballage par carton")
                {
                    Caption = 'Emballage par carton';
                    ToolTip = 'Emballage par carton';
                    Importance = Standard;
                    MultiLine = false;
                    Style = None;
                    StyleExpr = false;
                }
                field(ImageCarton; recParamStock."Picture carton")
                {
                    Caption = 'Image carton';
                    ToolTip = 'Image carton';
                }
                group(Control1000000066)
                {
                    ShowCaption = false;
                    field("Nb de pièces dans carton"; Rec."Nb de pièces dans carton")
                    {
                        Caption = 'Nb pièce par carton';
                        ToolTip = 'Nb de pièces dans carton';
                    }
                    field("Nb de carton / palette"; Rec."Nb de carton / palette")
                    {
                        Caption = 'Nb cartons maxi / palette';
                        ToolTip = 'Nb cartons maxi / palette';
                    }
                }
                group("Dimension du carton (cm):")
                {
                    Caption = 'Dimension du carton (cm):';

                    field("1(larg)"; Rec."1(larg)")
                    {
                        Caption = 'Largeur carton';
                        ToolTip = 'Largeur carton';
                    }
                    field("1(Long)"; Rec."1(Long)")
                    {
                        Caption = 'Longueur carton';
                        ToolTip = 'Longueur carton';
                        ColumnSpan = 1;
                        Width = 5;
                    }
                    field("1(h)"; Rec."1(h)")
                    {
                        Caption = 'Hauteur carton';
                        ToolTip = 'Hauteur carton';
                    }
                }
                group("Dimension de la palette (cm) :")
                {
                    Caption = 'Dimension de la palette (cm) :';

                    field("2(Long)"; Rec."2(Long)")
                    {
                        Caption = 'Longueur palette';
                        ToolTip = 'Longueur palette';
                    }
                    field("2(larg)"; Rec."2(larg)")
                    {
                        Caption = 'Largeur palette';
                        ToolTip = 'Largeur palette';
                    }
                    field("2(h)"; Rec."2(h)")
                    {
                        Caption = 'Hauteur palette';
                        ToolTip = 'Hauteur palette';
                    }
                }
            }
            group("Conditionnement/Palettisation Colis sur palette")
            {
                Caption = 'General';
                field("Piece seule sur palette"; Rec."Piece seule sur palette")
                {
                    Caption = 'Pièce filmée et sur palette';
                    ToolTip = 'Pièce filmée et sur palette';
                    StyleExpr = true;
                }
                field(ImagePalette; recParamStock."Picture palette")
                {
                    Caption = 'Image palette';
                    ToolTip = 'Image palette';
                }
                group(Control1000000052)
                {
                    ShowCaption = false;
                    field("Nb de pièces sur palette"; Rec."Nb de pièces sur palette")
                    {
                        ToolTip = 'Nb de pièces sur palette';
                    }
                }
                group(Control1000000050)
                {
                    Caption = 'Dimension de la palette (cm) :';
                    field("4(Long)"; Rec."4(Long)")
                    {
                        ToolTip = 'Longueur palette pièce seule';
                        Caption = 'Longueur palette pièce seule';
                    }
                    field("4(llarg)"; Rec."4(llarg)")
                    {
                        Caption = 'Largeur palette pièce seule';
                        ToolTip = 'Largeur palette pièce seule';
                    }
                    field("4(h)"; Rec."4(h)")
                    {
                        Caption = 'Hauteur palette pièce seule';
                        ToolTip = 'Hauteur palette pièce seule';
                    }
                }
            }
            group("Conditionnement/Palettisation Caisse en bois")
            {
                Caption = 'General';
                field("Emballage caisse bois"; Rec."Emballage caisse bois")
                {
                    Caption = 'Emballage dans caisse en bois';
                    ToolTip = 'Emballage dans caisse en bois';
                }
                field(ImageCaisse; recParamStock."Picture caisse")
                {
                    Caption = 'Image caisse';
                    ToolTip = 'Image caisse';
                }
                group(Control1000000043)
                {
                    ShowCaption = false;
                    field("Nb de pièces dans caisse"; Rec."Nb de pièces dans caisse")
                    {
                        ToolTip = 'Nb de pièces dans caisse';
                    }
                }
                group("Dimension de la caisse (cm) :")
                {
                    Caption = 'Dimension de la caisse (cm) :';

                    field("3(Long)"; Rec."3(Long)")
                    {
                        Caption = 'Longueur caisse';
                        ToolTip = 'Longueur caisse';
                    }
                    field("3(larg)"; Rec."3(larg)")
                    {
                        Caption = 'Largeur caisse';
                        ToolTip = 'Largeur caisse';
                    }
                    field("3(h)"; Rec."3(h)")
                    {
                        Caption = 'Hauteur caisse';
                        ToolTip = 'Hauteur caisse';
                    }
                }
            }

        }
        */
        modify("Prices & Sales")
        {
            Visible = false;
        }


        modify(Planning)
        {
            Visible = false;
        }

        modify(Replenishment)
        {
            Visible = false;
        }

        modify(ItemTracking)
        {
            Visible = false;
        }

        modify(Warehouse)
        {
            Visible = false;
        }
        modify("Default Deferral Template Code")
        {
            Visible = false;
        }
        modify(ForeignTrade)
        {
            Visible = false;
        }
        modify("Over-Receipt Code")
        {
            Visible = false;
        }
        modify("Cost is Posted to G/L")
        {
            Visible = false;
        }
        addafter("Safety Stock Quantity")
        {
            field("Qte stock maxi"; Rec."Qte stock maxi")
            {
                ToolTip = 'Qté stock maxi';
            }
            field("Qte stock tampon"; Rec."Qte stock tampon")
            {
                ToolTip = 'Qté stock tampon';
            }
        }
        modify(ItemAttributesFactbox)
        {
            Visible = false;
        }
        modify(EntityTextFactBox)
        {
            Visible = false;
        }
        modify(ItemPicture)
        {
            Visible = false;
        }
    }

    actions
    {
        modify(Navigation_Item)
        {
            Visible = true;
        }
        modify(Production)
        {
            Visible = false;
        }
        modify("Item &Tracking Entries")
        {
            Visible = false;
        }
        modify(Sales)
        {
            Visible = false;
        }
        modify(Purchases)
        {
            Visible = false;
        }
        modify(ItemAvailabilityBy)
        {
            Visible = true;
        }
        modify("Calc. Stan&dard Cost")
        {
            Visible = false;
        }
        modify("Calc. Unit Price")
        {
            Visible = false;
        }
        modify("&Warehouse Entries")
        {
            Visible = false;
        }

        modify("Va&riants")
        {
            Promoted = true;
            PromotedIsBig = true;
            PromotedCategory = Process;
        }
        modify("Item Re&ferences")
        {
            Promoted = true;
            PromotedIsBig = true;
            PromotedCategory = Process;
        }
        modify("Co&mments")
        {
            Visible = false;
        }
        modify("&Phys. Inventory Ledger Entries")
        {
            Visible = false;
        }
        modify(Attachments)
        {
            Visible = false;
        }
        modify(Approval)
        {
            Visible = false;
        }
        modify(SendApprovalRequest)
        {
            Visible = false;
        }
        modify(CancelApprovalRequest)
        {
            Visible = false;
        }
        modify(ApprovalEntries)
        {
            Visible = false;
        }
        modify("Marketing Text")
        {
            Visible = false;
        }
        modify(Attributes)
        {
            Promoted = false;
        }
        modify(Dimensions)
        {
            Visible = false;
        }
        modify(Statistics)
        {
            Visible = false;
        }
        modify(BOMStructure)
        {
            Promoted = false;
        }
        modify(PrintLabel)
        {
            Visible = false;
        }
        modify(Flow)
        {
            Visible = false;
        }
        modify("Item Tracing")
        {
            Visible = false;
        }
        modify(Workflow)
        {
            Visible = false;
        }
        modify(ApplyTemplate)
        {
            Visible = false;
        }
        modify("&Create Stockkeeping Unit")
        {
            Promoted = false;
        }
        modify(AdjustInventory)
        {
            Visible = false;
        }
        modify(Identifiers)
        {
            Visible = false;
        }
        modify("Export Item Data")
        {
            Visible = false;
        }
        modify("Substituti&ons")
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
        modify("Requisition Worksheet")
        {
            Visible = false;
        }
        modify(Templates)
        {
            Visible = false;
        }
        modify(SaveAsTemplate)
        {
            Visible = false;
        }
        modify(CalculateCountingPeriod)
        {
            Visible = false;
        }
        modify("Cost Shares")
        {
            Visible = false;
        }
        modify(Navigation_Warehouse)
        {
            Visible = false;
        }

        modify(CopyItem)
        {
            Visible = false;
        }
        addafter(Attachments)
        {
            action("Historique PMP")
            {
                Caption = 'Historique PMP';
                ToolTip = 'Historique PMP';
                RunObject = Page "Historique PMP article";
                RunPageLink = "No. article" = field("No.");
            }
        }
        addafter("Item Tracing")
        {
            action("Imprimer fiche palette")
            {
                Caption = 'Imprimer fiche palette';
                ToolTip = 'Imprimer fiche palette';
                Image = PrintInstallment;
                Promoted = true;
                PromotedCategory = Process;
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
            action(CalculerStockDispo)
            {
                ApplicationArea = All;
                Caption = 'Afficher Dispo';
                ToolTip = 'Afficher le détail de la disponibilité de l''article.';
                Image = InventoryCalculation;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                
                trigger OnAction()
                var
                    MaQteDispo:Decimal;
                begin
                    Rec.CalculerDispo(true,MaQteDispo);
                end;
            }

        }
        modify(Translations)
        {
            Promoted = true;
            PromotedIsBig = true;
            PromotedCategory = Process;
        }
        modify("Item Journal")
        {
            Promoted = true;
            PromotedCategory = Process;
            PromotedIsBig = true;
        }
        modify("Item Reclassification Journal")
        {
            Promoted = true;
            PromotedCategory = Process;
            PromotedIsBig = true;
        }
    }

    var
        

}

