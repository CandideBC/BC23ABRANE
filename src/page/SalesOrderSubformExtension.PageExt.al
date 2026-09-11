pageextension 50083 SalesOrderSubformExtension extends "Sales Order Subform"
{

    layout
    {
        addbefore(Type)
        {
            field("Do not print"; Rec."Do not print")
            {
                ToolTip = 'Ne pas imprimer';
                ApplicationArea = All;
            }

        }
        modify(Description)
        {
            StyleExpr = MonStyle;
        }
        modify("Qty. to Assemble to Order")
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

        modify("Reserved Quantity")
        {
            Visible = false;
        }
        modify("Qty. to Ship")
        {
            BlankZero = false;
        }

        modify("IC Partner Code")
        {
            Visible = false;
        }
        modify("IC Partner Ref. Type")
        {
            Visible = false;
        }
        modify("IC Partner Reference")
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
        modify("Planned Delivery Date")
        {
            Visible = false;
        }
        modify("Planned Shipment Date")
        {
            Visible = false;
        }
        modify("Shipment Date")
        {
            Visible = false;
        }

        /*
                    field("line no"; Rec."line no.")
            {
                ApplicationArea = All;
                ToolTip = 'N° ligne';
            }
        */
        addbefore(Description)
        {
            field("Type ligne"; Rec."Type ligne")
            {
                ToolTip = 'Type ligne';
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {

            field("Vendor No."; Rec."Vendor No.")
            {
                ToolTip = 'N° fournisseur';
                ApplicationArea = All;
            }
        }
        addafter("Unit of Measure Code")
        {
            field("Prix achat prevu"; Rec."Prix achat prevu")
            {
                ApplicationArea = All;
                ToolTip = 'Prix d''achat prévu.';
            }

        }
        modify("Variant Code")
        {
            Visible = true;
        }
        moveafter("Prix achat prevu"; "Variant Code", "Unit Price", "Line Discount %", "Line Amount")
        addafter("Line Amount")
        {
            field("Phase"; Rec.Phase)
            {
                ToolTip = 'Phase';
            }

            field("Type Fiche BE"; Rec."Type Fiche BE")
            {
                ApplicationArea = All;
                ToolTip = 'Lorsque le type est Normal, cela signifie que c''est le BE ABRANE qui est chargé des travaux.';
            }


        }
        moveafter("Type Fiche BE"; "Net Weight")
        modify("Net Weight")
        {
            Visible = true;
        }

        addafter("Net Weight")
        {
            field("Country/Region of Origin Code"; Rec."Country/Region of Origin Code")
            {
                ApplicationArea = All;
            }
            field("Eco Tax Furniture Code"; Rec."Eco Tax Furniture Code")
            {
                ApplicationArea = All;
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
            field("Prix bloque"; Rec."Prix bloque")
            {
                ToolTip = 'Prix bloqué';
                Visible = false;
                Enabled = false;
            }
            field("Prix debloque par"; Rec."Prix debloque par")
            {
                ToolTip = 'Prix débloqué par';
                Visible = false;
                Enabled = false;
            }
            field("Prix avant deblocage"; Rec."Prix avant deblocage")
            {
                ToolTip = 'Prix avant deblocage';
                Visible = false;
                Enabled = false;
            }
        }
        modify("Line Discount Amount")
        {
            Visible = true;
            BlankZero = true;
        }
        moveafter("Cout achats affectes"; "Line Discount Amount")

        moveafter("Unit Price"; "Line Discount %")

        addafter("Quantity Shipped")
        {
            field("Outstanding Quantity"; Rec."Outstanding Quantity")
            {
                ToolTip = 'Quantité restante';
                ApplicationArea = All;
            }
        }
        moveafter("Outstanding Quantity"; "Line No.")

        addbefore("Line No.")
        {
            field("Nb affectations achats"; Rec."Nb affectations achats")
            {
                ToolTip = 'Nb affectations achats';
                ApplicationArea = All;
            }
        }
        modify("Item Charge Qty. to Handle")
        {
            Visible = false;
        }
    }

    actions
    {
        modify(GetPrice)
        {
            Visible = false;
        }
        modify("Get Li&ne Discount")
        {
            Visible = false;
        }
        modify(GetLineDiscount)
        {
            Visible = false;
        }
        modify(GetPrices)
        {
            Visible = false;
        }
        modify(ExplodeBOM_Functions)
        {
            Visible = false;
        }
        modify("Select Nonstoc&k Items")
        {
            Visible = false;
        }
        modify(ItemTrackingLines)
        {
            Visible = false;
        }
        modify(Dimensions)
        {
            Visible = false;
        }
        modify(DocumentLineTracking)
        {
            Visible = false;
        }
        modify(RedistributeAccAllocations)
        {
            Visible = false;
        }
        modify(OrderPromising)
        {
            Visible = false;
        }
        modify(SelectItemSubstitution)
        {
            Visible = false;
        }

        addafter(OrderPromising)
        {
            action("Sélectionner/Déselectionner [Ne pas imprimer]")
            {
                Caption = 'Sélectionner/Déselectionner "Ne pas imprimer"';
                ToolTip = 'Sélectionner/Déselectionner "Ne pas imprimer"';

                trigger OnAction()
                var

                begin
                    Rec.SelectOrDeselectDoNotPrint();
                end;

            }
            action("Affectations achats/ventes")
            {
                Caption = 'Affectations achats/ventes';
                ToolTip = 'Affectations achats/ventes';
                Image = Links;
                ShortcutKey = 'Ctrl+D';
                RunObject = page "Affectations achat vente";
                RunPageView = sorting("Type document vente", "No. document vente", "No. ligne document vente")
                                  where("Type document vente" = const(Commande));
                RunPageLink = "No. document vente" = field("Document No."),
                                  "No. ligne document vente" = field("Line No.");
            }
        }
        addafter(OrderPromising)
        {
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
        }

        addafter("Select Nonstoc&k Items")
        {
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
                    DiaText0001Err: Label 'Seuls les composants peuvent tre modifis par cette fonction.';

                begin
                    if (Rec."Linked to line" = 0) and (Rec."BOM Item No." = '') then
                        ERROR(DiaText0001Err);

                    CLEAR(ComponentModificationPage);
                    ComponentModificationPage.SetData(Rec."No.", Rec.Quantity, Rec."Linked to line", Rec."BOM Item No.", Rec."Document Type",
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
            action("Vider quantité à expédier")
            {
                ApplicationArea = All;
                ToolTip = 'Vider quantité à expédier';
                Image = Delete;
                trigger OnAction()
                begin
                    Rec.fctRAZQuantiteaexpedier();
                end;
            }
            /*08/09/2025
            action("Remplir quantité à expédier")
            {
                ApplicationArea = All;
                ToolTip = 'Remplir quantité à expédier';
                Image = Insert;
                trigger OnAction()
                begin
                    Rec.fctRemplirQuantiteaexpedier();
                end;
            }
            08/09/2025*/
            action("Dupliquer lignes")
            {
                ApplicationArea = All;
                ToolTip = 'Remplir quantité à expédier';
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
                    //KAN.FHA 26/03/2025
                    //if RecSalesLine.FindFirst() then begin
                    if not RecSalesLine.IsEmpty() then begin
                        DuplicatePage.LOOKUPMODE(true);
                        DuplicatePage.SetDatA(Rec."Document No.", Rec."Document Type");
                        DuplicatePage.RUNMODAL();
                    end;
                end;
            }
            action("Extraire traduction")
            {
                ApplicationArea = All;
                ToolTip = 'Extraire traduction';

                trigger OnAction()
                begin
                    rec.traduire();
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
        //KAN.FHA 06/07/2020 DEBUT
        if Rec."Ligne deduction acompte" then begin
            if not ParamUtil.Get(UserId) then
                ParamUtil.Init();
            if not ParamUtil."Supprimer ligne acompte" then
                Error(SupprLigneAcompteErr);
        end;
        //KAN.FHA 06/07/2020 FIN
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
