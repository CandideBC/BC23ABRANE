page 50030 "Vue simplifiee document vente"
{
    ApplicationArea = All;
    Caption = 'Vue simplifiée document vente';
    PageType = List;
    SourceTable = "Ligne vente simplifiee";
    SourceTableView = where("Type ligne simplifiee" = const(Mere));
    UsageCategory = None;
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No. ligne"; Rec."No. ligne")
                {
                    ToolTip = 'Indique la valeur du N° ligne';
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Indique le type de ligne';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Indique la valeur du champ N°';
                }
                field("Type ligne"; Rec."Type ligne")
                {
                    ApplicationArea = All;
                    ToolTip = 'Type ligne';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Indique la valeur du champ Description';
                    StyleExpr = MonStyle;
                }
                field("No. fournisseur"; Rec."No. fournisseur")
                {
                    ApplicationArea = All;
                    ToolTip = 'N° fournisseur';
                }
                field("Code magasin"; Rec."Code magasin")
                {
                    ApplicationArea = All;
                    ToolTip = 'Code magasin';
                }

                field(Quantite; Rec.Quantite)
                {
                    ToolTip = 'Indique la valeur du champ Quantité';
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
                field("Prix unitaire"; Rec."Prix unitaire")
                {
                    ToolTip = 'Indique la valeur du champ Prix unitaire';
                }
                field("% remise ligne"; Rec."% remise ligne")
                {
                    ApplicationArea = All;
                    ToolTip = '% remise ligne';
                }
                field(Montant; Rec.Montant)
                {
                    ToolTip = 'Indique la valeur du champ Montant';
                }
                field(Phase; Rec.Phase)
                {
                    ApplicationArea = All;
                    ToolTip = 'Phase';
                }
                field("Type Fiche BE"; Rec."Type Fiche BE")
                {
                    ApplicationArea = All;
                    ToolTip = 'Type fiche BE';
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
                    ToolTip = 'Indique la valeur du champ Quantité livrée';
                    Visible = false;
                }
                field("Quantite facturee"; Rec."Quantite facturee")
                {
                    ToolTip = 'Indique la valeur du champ Quantité facturée';
                    Visible = false;
                }
            }

            part(Lignes; "Vue simplifiee doc vente SF")
            {
                Caption = 'Lignes';
                SubPageLink = "Type document" = field("Type document"),
                              "No. Document" = field("No. Document"),
                              "No. ligne mere" = field("No. ligne");
            }

            field(MAJDevisNecessaire; Rec.MAJDevisNecessaire())
            {
                ApplicationArea = All;
                ToolTip = 'Il faudra mettre à jour le devis si vous ne voulez pas perdre vos modifications.';
                Caption = 'MAJ nécessaire';
            }
        }
    }


    actions
    {
        area(Processing)
        {
            action(ReassignerNoLigne)
            {
                ApplicationArea = All;
                Caption = 'Réassigner N° ligne';
                ToolTip = 'Renumérote toutes les lignes';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ChangeToLines;

                trigger OnAction()
                begin
                    rec.ReassignerNumerosLigne();
                    CurrPage.Close();
                end;
            }


            action(ExtraireDevisTypePartiel)
            {
                ApplicationArea = Suite;
                Caption = 'Extraire devis type (partiel)';
                Ellipsis = true;
                Image = CustomerCode;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Extraire un devis type lié au client puis sélectionner les lignes qu''on souhaite ajouter.';

                trigger OnAction()

                begin
                    rec.AjouterDocumentTypePartiel();
                end;
            }
            action(Rouvrir)
            {
                ApplicationArea = All;
                Caption = 'Rouvrir';
                ToolTip = 'Remettre le document au statut Ouvert';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ReOpen;
                trigger OnAction()
                var
                    EnteteVente: Record "Sales Header";
                    StatusMgtCu: Codeunit "Release Sales Document";

                begin
                    EnteteVente.get(rec."Type document", Rec."No. document");
                    StatusMgtCu.Reopen(EnteteVente);
                end;
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
    //MAJDevisQst: Label 'Voulez-vous mettre à jour le devis ? Si vous ne le faites pas, certaines modifications seront perdues.';
    begin
        if rec.MAJDevisNecessaire() then
            rec.CreerLignesVentes();
    end;

    trigger OnAfterGetRecord()
    begin
        DefinirStyle();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        DefinirStyle();
    end;

    procedure DefinirStyle()
    var
        LigneVente: Record "Sales Line";
        CuFonctionsAbrane: Codeunit "Fonctions ABRANE";

    begin
        if LigneVente.get(rec."Type document", Rec."No. document", Rec."No. ligne") then
            MonStyle := CuFonctionsAbrane.StyleLigneDevisCommande(LigneVente)
        else
            MonStyle := 'Standard';
    end;

    var
        MonStyle: Text;

}
