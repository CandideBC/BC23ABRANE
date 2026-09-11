page 50011 "Vue simplifiee doc vente SF"
{
    ApplicationArea = All;
    Caption = 'Vue simplifiée doc. vente SF';
    PageType = ListPart;
    SourceTable = "Ligne vente simplifiee";
    SourceTableView = sorting("Type document", "No. document", "Type ligne simplifiee", "No. ligne mere") where("Type ligne simplifiee" = const(Fille));
    UsageCategory = None;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                                field("No. ligne"; Rec."No. ligne")
                {
                    ToolTip = 'N° ligne';
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Type';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'N°';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                }

                field("No. fournisseur"; Rec."No. fournisseur")
                {
                    ApplicationArea = All;
                    ToolTip = 'N° fournisseur';
                }
                field("Code magasin"; Rec."Code magasin")
                {
                    ApplicationArea = All;
                    ToolTip = 'N° fournisseur';
                }

                field(Quantite; Rec.Quantite)
                {
                    ToolTip = 'Quantité';
                    Editable = false;
                }
                field("Quantite pour 1"; Rec."Quantite pour 1")
                {
                    ToolTip = 'Quantité pour 1';
                    ApplicationArea = All;
                }
                field("Prix achat prevu"; Rec."Prix achat prevu")
                {
                    ApplicationArea = All;
                    ToolTip = 'Prix achat prévu';
                }

                field("Code variante"; Rec."Code variante")
                {
                    ApplicationArea = All;
                    ToolTip = 'Code variante';
                }
                field(Phase; Rec.Phase)
                {
                    ApplicationArea = All;
                    ToolTip = 'Phase';
                }
                field("Type Fiche BE"; Rec."Type Fiche BE")
                {
                    ApplicationArea = All;
                    ToolTip = 'Type Fiche BE';
                }
                
                field("Poids unitaire"; Rec."Poids unitaire")
                {
                    ApplicationArea = All;
                    ToolTip = 'Poids unitaire';
                    BlankZero = true;
                    DecimalPlaces = 0 : 2;
                }
                field("Code pays origine"; Rec."Code pays origine")
                {
                    ApplicationArea = All;
                    ToolTip = 'Code pays origine';
                }
                field("Nomenclature produits"; Rec."Nomenclature produits")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nomenclature produit';
                }
                field("Quantite livree"; Rec."Quantite livree")
                {
                    ToolTip = 'Quantite livrée';
                    Editable = false;
                    Visible = false;
                }
                field("Quantite facturee"; Rec."Quantite facturee")
                {
                    ToolTip = 'Quantité facturée';
                    Editable = false;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Insérer composant")
            {
                ApplicationArea = All;
                ToolTip = 'Insérer composant';
                Image = Insert;
                trigger OnAction()
                var
                    LigneMere: Record "Ligne vente simplifiee";
                    ComponentInsertPage: Page "Insert Component";

                    DiaText0002Err: Label 'Vous devez vous positionner sur un composant pour pouvoir utiliser cette fonction.';

                begin
                    if (Rec."Linked to line No." = 0) then // and (Rec."BOM Item No." = '') then
                        ERROR(DiaText0002Err);

                    LigneMere.get(Rec."Type document", rec."No. document", rec."No. ligne mere");
                    CLEAR(ComponentInsertPage);
                    ComponentInsertPage.SetData(true, Rec."Linked to line No.", LigneMere."No.",
                                            Rec."Type document", Rec."No. Document", Rec."No. ligne");
                    ComponentInsertPage.LOOKUPMODE(true);
                    ComponentInsertPage.RUNMODAL();

                end;
            }

        }
    }

}
