pageextension 50022 PurchaseOrderSubformExtension extends "Purchase Order Subform"
{

    layout
    {
        modify("Item Reference No.")
        {
            Visible = false;
        }

        modify("Description 2")
        {
            Visible = true;
        }

        modify("Reserved Quantity")
        {
            Visible = false;
        }
        modify("Bin Code")
        {
            Visible = false;
        }
        modify("Over-Receipt Quantity")
        {
            Visible = false;
        }
        modify("Over-Receipt Code")
        {
            Visible = false;
        }
        modify("Tax Group Code")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }

        modify("Qty. to Assign")
        {
            Visible = false;
        }

        modify("Qty. Assigned")
        {
            Visible = false;
        }

        modify("Planned Receipt Date")
        {
            Visible = false;
        }

        modify("Expected Receipt Date")
        {
            Visible = false;
        }
        modify("Order Date")
        {
            Visible = false;
        }


        addafter("No.")
        {
            field("Reference 102 B.E."; Rec."Reference 102 B.E.")
            {
                ApplicationArea = All;
                Tooltip = 'Référence 102 donnée par le B.E.';
            }
        }
        modify("Blanket Order No.")
        {
            Visible = true;
        }
        modify("Blanket Order Line No.")
        {
            Visible = false;
        }

        moveafter("Description 2"; "Location Code", Quantity, "Unit of Measure Code", "Blanket Order No.", "Qty. to Receive", "Quantity Received")
        addafter("Qty. to Receive")
        {
            field("Quantite en container"; Rec."Quantite en container")
            {
                ToolTip = 'Quantité en container';
                Visible = false;
            }
            field("Quantite restante en container"; Rec."Quantite restante en container")
            {
                ToolTip = 'Quantité restante en container';
            }
        }
        modify("Variant Code")
        {
            Visible = true;
        }
        modify("Line Discount %")
        {
            Visible = true;
        }
        movebefore("Direct Unit Cost"; "Variant Code")

        modify("Net Weight")
        {
            Visible = true;
            ToolTip = 'Poids net';
            Style = Attention;
            StyleExpr = true;
        }
        modify("Line Discount Amount")
        {
            Visible = true;
        }
        movebefore("Line Amount"; "Line Discount Amount")
        moveafter("Line Amount"; "Net Weight")

        addafter("Net Weight")
        {
            field("Country/Region of Origin Code"; Rec."Country/Region of Origin Code")
            {
                ApplicationArea = All;
                ToolTip = 'Code pays d''origine';
            }

            field("Nomenclature produits"; Rec."Nomenclature produits")
            {
                ToolTip = 'Nomenclature produits';
            }
            field("Code enseigne"; Rec."Code enseigne")
            {
                ToolTip = 'Code enseigne';
                Visible = false;
            }
            field("Code chantier"; Rec."Code chantier")
            {
                ToolTip = 'Code chantier';
                Visible = false;
            }
        }
        modify("Item Charge Qty. to Handle")
        {
            Visible = false;
        }
        modify("Promised Receipt Date")
        {
            Visible = false;
        }
        modify("FA Posting Date")
        {
            Visible = false;
        }

        addbefore("Qty. to Invoice")
        {
            field("Outstanding Quantity"; Rec."Outstanding Quantity")
            {
                ToolTip = 'Quantité restante';
            }
        }
        addafter("Quantity Invoiced")
        {
            field("Nb lignes ventes liées"; Rec."Nb lignes ventes liees")
            {
                ToolTip = 'Nb lignes ventes liees';
                trigger OnDrillDown()
                begin
                    CurrPage.SaveRecord();
                end;
            }
            field("Quantité affectée aux ventes"; Rec."Quantite affectee aux ventes")
            {
                ToolTip = 'Quantité affectée aux ventes';
                trigger OnDrillDown()
                begin
                    CurrPage.SaveRecord();
                end;
            }
            field("Creer ligne ecart prix"; Rec."Creer ligne ecart prix")
            {
                ToolTip = 'Créer ligne écart prix';
            }

        }
        modify("Tax Liable")
        {
            Visible = false;
        }

    }

    actions
    {
        modify("Dr&op Shipment")
        {
            Visible = false;
        }
        modify(Dimensions)
        {
            Visible = false;
        }
        modify("Item Tracking Lines")
        {
            Visible = false;
        }
        modify(DocumentLineTracking)
        {
            Visible = false;
        }
        modify(DeferralSchedule)
        {
            Visible = false;
        }
        modify(RedistributeAccAllocations)
        {
            Visible = false;
        }
        modify("Insert Ext. Texts")
        {
            Visible = false;
        }
        modify(OrderTracking)
        {
            Visible = false;
        }
        modify("Co&mments")
        {
            Visible = false;
        }
        modify(SelectMultiItems)
        {
            Visible = false;
        }


        modify("O&rder")
        {
            Visible = false;
        }
        addafter(ItemChargeAssignment)
        {
            action("Imprimer fiche palette")
            {
                Caption = 'Imprimer fiche palette';
                ToolTip = 'Imprimer fiche palette';
                Image = PrintInstallment;

                trigger OnAction()
                var
                    recArticle: Record Item;
                    repFichePalette: Report "Fiche palette";
                begin
                    recArticle.Reset();
                    recArticle.SetRange("No.", Rec."No.");
                    Clear(repFichePalette);
                    repFichePalette.SetTableView(recArticle);
                    repFichePalette.Run();
                end;

            }
            action("Affectations achats/ventes")
            {
                Caption = 'Affectations achats/ventes';
                ToolTip = 'Affectations achats/ventes';
                Image = PrintInstallment;
                ShortcutKey = 'Ctrl+D';
                RunObject = page "Affectations achat vente";
                RunPageLink = "No. document achat" = field("Document No."), "No. ligne document achat" = field("Line No.");

            }
            action("Vider quantité à recevoir")
            {
                ApplicationArea = All;
                ToolTip = 'Vider quantité à recevoir';
                Image = Delete;

                trigger OnAction()
                begin
                    Rec.fctRAZQuantitearecevoir();
                end;
            }

            action("Remplir quantité à recevoir")
            {
                ApplicationArea = All;
                ToolTip = 'Remplir quantité à recevoir';
                Image = Insert;

                trigger OnAction()
                begin
                    Rec.fctRemplirQuantitearecevoir();
                end;
            }
            action("Annuler éclatement lignes transitaire")
            {
                ApplicationArea = All;
                ToolTip = 'Annuler éclatement lignes transitaire';
                trigger OnAction()
                begin
                    Rec.AnnulerEclatementLignesTransitaire();
                end;
            }

            group("Insérer ligne écart de prix")
            {
                action("Ligne active")
                {
                    ToolTip = 'Ligne active';
                    trigger OnAction()
                    begin
                        Rec.AjouterLigneEcartDePrix(Rec);
                    end;
                }
                action("Lignes sélectionnées")
                {
                    ToolTip = 'Lignes sélectionnées';
                    trigger OnAction()
                    begin
                        ;
                        Rec.AjouterLignesEcartDePrixSelection();
                    end;
                }
            }




        }
    }



}

