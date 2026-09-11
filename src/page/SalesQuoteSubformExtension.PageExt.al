pageextension 50091 SalesQuoteSubformExtension extends "Sales Quote Subform"
{

    layout
    {
        modify(Quantity)
        {
            ShowMandatory = false;
        }
        modify("Unit Price")
        {
            ShowMandatory = false;
        }
        modify("Line Amount")
        {
            ShowMandatory = false;
        }

        addbefore(Type)
        {
            field("Do not print"; Rec."Do not print")
            {
                ToolTip = 'Ne pas imprimer';
                ApplicationArea = All;
            }
        }

        addbefore(Description)
        {
            field("Type ligne"; Rec."Type ligne")
            {
                ToolTip = 'Type ligne';
                ApplicationArea = All;
            }
        }

        addafter(PriceExists)
        {
            field("Prix bloque"; Rec."Prix bloque")
            {
                ToolTip = 'Prix bloqué';
                Visible = false;
                Enabled = false;
            }
        }

        modify("Variant Code")
        {
            Visible = true;
        }
        modify("Location Code")
        {
            Visible = true;
        }

        modify("Qty. to Assign")
        {
            Visible = false;
        }
        modify("Tax Group Code")
        {
            Visible = false;
        }
        modify("Qty. Assigned")
        {
            Visible = false;
        }
        modify("Work Type Code")
        {
            Visible = false;
        }
        modify("Qty. to Assemble to Order")
        {
            Visible = false;
        }
        moveafter(Quantity;"Unit of Measure Code","Unit Price")

        addafter("Line Amount")
        {

            field("Eco Tax Furniture Amount"; Rec."Eco Tax Furniture Amount")
            {
                ToolTip = 'Montant taxe éco-mobilier';
                BlankZero = true;
            }
            field("subtotal amount"; Rec."subtotal amount")
            {
                ToolTip = 'Sous-total';
                ApplicationArea = All;
            }
            field("line no"; Rec."line no.")
            {
                ApplicationArea = All;
                ToolTip = 'N° ligne';
            }
            field("Code enseigne"; Rec."Code enseigne")
            {
                ToolTip = 'Code enseigne';
                Visible = false;
            }
            field("Operation"; Rec."Code operation")
            {
                ToolTip = 'Code opération';
                Visible = false;
            }
            field("Chantier"; Rec."Code chantier")
            {
                ToolTip = 'Code chantier';
                Visible = false;
            }


            field("Poids brut"; Rec."Gross Weight")
            {
                ToolTip = 'Poids brut';
                Visible = false;
            }
        }

        movebefore("subtotal amount";"Line Discount %", "Line Discount Amount")

        modify(Description)
        {
            StyleExpr = MonStyle;
        }

        addafter(Description)
        {
            field("Vendor No."; Rec."Vendor No.")
            {
                ToolTip = 'N° fournisseur';
                ApplicationArea = All;
            }

            field("Linked to line"; Rec."Linked to line")
            {
                ApplicationArea = All;
                ToolTip = 'Lié à la ligne N°';
                Visible = false;
            }

            field("Attached to Line No."; Rec."Attached to Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Attaché à la ligne N°';
                Visible = false;
            }

        }

        moveafter("Vendor No."; "Variant Code", "Location Code", Quantity, "Unit of Measure Code", "Net Weight")
        addafter("Unit of Measure Code")
        {
            field("Prix achat prevu"; Rec."Prix achat prevu")
            {
                ApplicationArea = All;
                ToolTip = 'Prix d''achat prévu.';
            }
        }
        moveafter("Prix achat prevu";"Variant Code","Unit Price")

        movebefore("Net Weight";"Line Amount")
        
        addafter("Line Amount")
        {
        field("Phase"; Rec.Phase)
            {
                ToolTip = 'Si l''article ne concerne qu''une seule phase, vous pouvez saisir la phase ici. Dans le cas contraire, utilisez la [Quantité phasée] pour indiquer les quantités de chaque phase.';
            }

            field("Type Fiche BE"; Rec."Type Fiche BE")
            {
                ApplicationArea = All;
                ToolTip = 'Lorsque le type est Normal, cela signifie que c''est le BE ABRANE qui est chargé des travaux.';
            }
        }

        modify("Net Weight")
        {
            Visible = true;
        }
        addafter("Net Weight")
        {
            field("Country/Region of Origin Code"; Rec."Country/Region of Origin Code")
            {
                ToolTip = 'Code pays origine';
            }
            field("Eco Tax Furniture Code"; Rec."Eco Tax Furniture Code")
            {
                ApplicationArea = All;
                ToolTip = 'Code éco-contribution';
            }
            field("Nomenclature produits"; Rec."Nomenclature produits")
            {
                ToolTip = 'Nomenclature produits';
            }
            field("Cout achats affectes"; Rec."Cout achats affectes")
            {
                ToolTip = 'Coût achats affectés';
                ApplicationArea = All;

            }
            field("Nb affectations achats"; Rec."Nb affectations achats")
            {
                ToolTip = 'Nb affectations achats';
                ApplicationArea = All;
                Visible = false;
            }

        }
        modify("Line Discount Amount")
        {
            Visible = true;
            BlankZero = true;
        }
        movebefore("Line Amount"; "Line Discount %")
        moveafter("Nb affectations achats"; "Line Discount Amount")
    }

    actions
    {
        modify("Item Charge &Assignment")
        {
            Visible = false;
        }
        modify(DocAttach)
        {
            Visible = false;
        }
        modify("Get &Price")
        {
            Visible = false;
        }
        modify("Get Li&ne Discount")
        {
            Visible = false;
        }
        modify(GetPrice)
        {
            Visible = false;
        }
        modify(GetLineDiscount)
        {
            Visible = false;
        }
        modify("E&xplode BOM")
        {
            Visible = false;
        }
        modify(Dimensions)
        {
            Visible = false;
        }
        modify("Select Item Substitution")
        {
            Visible = false;
        }
        modify(SelectMultiItems)
        {
            Visible = false;
        }
        modify("Select Nonstoc&k Items")
        {
            Visible = false;
        }

        modify("Item &Tracking Lines")
        {
            Visible = false;
        }

        modify("Assemble to Order")
        {
            Visible = false;
        }
        modify(RedistributeAccAllocations)
        {
            Visible = false;
        }
        modify(InsertExtTexts)
        {
            Visible = false;
        }
        modify("Item Availability by")
        {
            Visible = false;
        }
        modify("Co&mments")
        {
            Visible = false;
        }
        addlast("F&unctions")
        {
            action("Affectations achats/ventes")
            {
                Caption = 'Affectations achats/ventes';
                ToolTip = 'Affectations achats/ventes';
                Image = Links;
                ShortcutKey = 'Ctrl+D';
                RunObject = page "Affectations achat vente";
                RunPageView = sorting("Type document vente", "No. document vente", "No. ligne document vente")
                                  where("Type document vente" = const(Devis));
                RunPageLink = "No. document vente" = field("Document No."),
                                  "No. ligne document vente" = field("Line No.");
            }
            action("Débloquer prix article")
            {
                ApplicationArea = All;
                Image = EncryptionKeys;
                ToolTip = 'Débloquer prix article';

                trigger OnAction()
                begin
                    Rec.SetPrixBloque(false);

                end;
            }
            action("Masquer composants")
            {
                ApplicationArea = All;
                ToolTip = 'Masquer composants';
                Visible = false;
                Image = BOM;

                trigger OnAction()
                begin
                    Rec.setrange("Linked to line", 0)

                end;
            }
            action("Modifier ligne composant")
            {
                ApplicationArea = All;
                ToolTip = 'Modifier ligne composant';
                Image = Edit;
                trigger OnAction()
                var
                    ComponentModificationPage: Page "Update Component";
                    DiaText0001Err: Label 'Seuls les composants peuvent être modifiés par cette fonction.';

                begin
                    if (Rec."Linked to line" = 0) and (Rec."BOM Item No." = '') then
                        ERROR(DiaText0001Err);


                    CLEAR(ComponentModificationPage);
                    ComponentModificationPage.SetData(Rec."No.", Rec."Quantite pour 1", Rec."Linked to line", Rec."BOM Item No.", Rec."Document Type",
                                                       Rec."Document No.", Rec."Line No.", Rec."Location Code");
                    ComponentModificationPage.LOOKUPMODE(true);
                    ComponentModificationPage.RUNMODAL();

                end;
            }
            action("Insérer composant")
            {
                ApplicationArea = All;
                ToolTip = 'Insérer composant';
                Image = Insert;
                trigger OnAction()
                var
                    ComponentInsertPage: Page "Insert Component";
                    DiaText0002Err: Label 'Vous devez vous positionner sur un composant pour pouvoir utiliser cette fonction.';

                begin
                    if (Rec."Linked to line" = 0) and (Rec."BOM Item No." = '') then
                        ERROR(DiaText0002Err);

                    CLEAR(ComponentInsertPage);
                    ComponentInsertPage.SetData(false, Rec."Linked to line", Rec."BOM Item No.",
                                            Rec."Document Type", Rec."Document No.", Rec."Line No.");
                    ComponentInsertPage.LOOKUPMODE(true);
                    ComponentInsertPage.RUNMODAL();

                end;
            }


            action("Dupliquer lignes")
            {
                ApplicationArea = All;
                ToolTip = 'Dupliquer lignes';
                Image = CopyItem;
                trigger OnAction()
                var
                    RecSalesLine: Record "Sales Line";
                    DuplicatePage: page "Duplicate Sales Line";
                begin
                    RecSalesLine.SETRANGE("Document Type", Rec."Document Type");
                    RecSalesLine.SETRANGE("Document No.", Rec."Document No.");
                    RecSalesLine.SETRANGE("Linked to line", 0);
                    RecSalesLine.SETRANGE("Eco Tax Furniture Line", false);
                    if RecSalesLine.FindFirst() then begin
                        DuplicatePage.LOOKUPMODE(true);
                        DuplicatePage.SETTABLEVIEW(RecSalesLine);
                        DuplicatePage.SetDatA(Rec."Document No.", Rec."Document Type");
                        DuplicatePage.RUNMODAL();
                    end;
                end;
            }
        }
    }


    trigger OnAfterGetRecord()
    begin
        DefinirStyle();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        DefinirStyle();
    end;

    trigger OnDeleteRecord(): Boolean
    var
        ParamUtil: Record "User Setup";
        SupprLigneAcompteErr: Label 'Vous ne pouvez pas supprimer la ligne qui déduit l''acompte versé. Vous pouvez par contre demander à déplacer la ligne d''acompte vers la fin du document si elle vous gène.';

    begin
        if Rec."Ligne deduction acompte" then begin
            if not ParamUtil.GET(USERID) then
                ParamUtil.INIT();
            if not ParamUtil."Supprimer ligne acompte" then
                ERROR(SupprLigneAcompteErr);
        end;
    end;

    procedure DefinirStyle()
    var
        CuFonctionsAbrane: Codeunit "Fonctions ABRANE";

    begin
        MonStyle := CuFonctionsAbrane.StyleLigneDevisCommande(Rec);
    end;

    var
        MonStyle: Text;
}
