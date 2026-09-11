page 50075 "Selection fns/creer cde"
{
    // Cette page est appelée depuis un devis ou cde de vente lorsque l'utilisation fait "Créer commande achat" pour que l'utilisateur puisse choisir pour quels fournisseurs il souhaite créer
    // une commande d'achat.
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Selection fns pour creer cde";
    Caption = 'Sélection des fns pour créer commande';
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. fournisseur"; Rec."No. fournisseur")
                {
                    ToolTip = 'N° fournisseur';
                    Caption = 'N° fournisseur';
                }
                field("Nom fournisseur"; Rec."Nom fournisseur")
                {
                    ToolTip = 'Nom fournisseur';
                }
                field("Code pays origine"; Rec."Code pays origine")
                {
                    ApplicationArea = All;
                    ToolTip = 'Code pays d''origine';
                    Editable = rec."Fournisseur divers";
                }

                field("Creer nouvelle commande"; Rec."Creer nouvelle commande")
                {
                    ToolTip = 'Créer nouvelle commande ?';

                    trigger OnValidate()
                    begin
                        if not Fournisseur.Get(Rec."No. fournisseur") then begin
                            Rec."Creer nouvelle commande" := false;
                            CurrPage.Update(false);
                        end;
                    end;
                }
                field("Ajouter a la cde No."; Rec."Ajouter a la cde No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ajouter à une commande existante';
                }

                field("Nombre lignes concernees"; Rec."Nombre lignes concernees")
                {
                    ToolTip = 'Nombre lignes concernées';
                }
            }
            part(Lignes; "SF Selection fns/creer cde")
            {
                Caption = 'Lignes';
                SubPageLink = "Document Type" = field("Document Type"),
                              "Document No." = field("Document No."),
                              Type = const(Item),
                              "Vendor No." = field("No. fournisseur"),
                              "A acheter" = const(true);
            }
            part(Magasins; "SF Selection magasin/creer cde")
            {
                Caption = 'Magasins';
                SubPageLink = "Code utilisateur" = field("Code utilisateur"),
                              "Document Type" = field("Document Type"),
                              "Document No." = field("Document No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SelectionnerTous)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = AllLines;
                Caption = 'Sélectionner tout';
                ToolTip = 'Sélectionner tout';
                trigger OnAction()
                begin
                    rec.SelectionnerTous();
                end;
            }
            action(DeselectionnerTous)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = CancelAllLines;
                Caption = 'Désélectionner tout';
                ToolTip = 'Désélectionner tout';
                trigger OnAction()
                begin
                    rec.DeSelectionnerTous();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        rec.FilterGroup(2);
        rec.SetRange("Code utilisateur", UserId);
        rec.FilterGroup(0);
    end;

    var
        Fournisseur: Record Vendor;
}

