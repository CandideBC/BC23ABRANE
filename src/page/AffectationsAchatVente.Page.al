page 50043 "Affectations achat vente"
{
    Caption = 'Affectations achat vente';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Affectations achat vente";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. document achat"; Rec."No. document achat")
                {
                    ApplicationArea = All;
                    ToolTip = 'N° document achat';
                }
                field("No. ligne document achat"; Rec."No. ligne document achat")
                {
                    ApplicationArea = All;
                    ToolTip = 'N° ligne document achat';
                }
                field("Description article achete"; Rec."Description article achete")
                {
                    ApplicationArea = All;
                    ToolTip = 'Description article acheté';
                }
                field("Qte achetee"; Rec."Qte achetee")
                {
                    ApplicationArea = All;
                    ToolTip = 'Quantité achetée';
                }
                field("Qte recue"; Rec."Qte recue")
                {
                    ApplicationArea = All;
                    ToolTip = 'Quantité reçue';
                }
                field("Date reception prevue"; Rec."Date reception prevue")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date réception prévue';
                }
                field("No. donneur ordre"; Rec."No. donneur ordre")
                {
                    ApplicationArea = All;
                    ToolTip = 'N° donneur d''ordre';
                }
                field("Nom donneur ordre"; Rec."Nom donneur ordre")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nom donneur d''ordre';
                }
                field("Type document vente"; Rec."Type document vente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Type document vente';
                }
                field("No. document vente"; Rec."No. document vente")
                {
                    ApplicationArea = All;
                    ToolTip = 'N° document vente';
                }
                field("No. ligne document vente"; Rec."No. ligne document vente")
                {
                    ApplicationArea = All;
                    Caption = 'N° ligne document vente';
                    ToolTip = 'N° ligne document vente';
                }
                field("Quantite affectee"; Rec."Quantite affectee")
                {
                    ApplicationArea = All;
                    Caption = 'Quantité affectée';
                    ToolTip = 'Quantité affectée';
                }
                field("Quantite affectee totale"; Rec."Quantite affectee totale")
                {
                    ApplicationArea = All;
                    Caption = 'Quantité affectée totale';
                    ToolTip = 'Quantité affectée totale';

                }
                field("Code chantier"; Rec."Code chantier")
                {
                    ApplicationArea = All;
                    Caption = 'Code chantier';
                    ToolTip = 'Code chantier';

                }
                field("Cout unitaire (DS)"; Rec."Cout unitaire (DS)")
                {
                    ApplicationArea = All;
                    Caption = 'Coût unitaire (DS)';
                    ToolTip = 'Coût unitaire (DS)';

                }
                field("Cout total (DS)"; Rec."Cout total (DS)")
                {
                    ApplicationArea = All;
                    Caption = 'Coût total (DS)';
                    ToolTip = 'Coût total (DS)';

                }
                field("Montant frais annexes"; Rec."Montant frais annexes")
                {
                    ApplicationArea = All;
                    Caption = 'Montant frais annexes';
                    ToolTip = 'Montant frais annexes';

                }
                field("Statut commande achat"; Rec."Statut commande achat")
                {
                    ApplicationArea = All;
                    Caption = 'Statut commande achat';
                    ToolTip = 'Statut commande achat';
                    Editable = false;
                }
                field("Nombre receptions"; Rec."Nombre receptions")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre réceptions';
                    ToolTip = 'Nombre réceptions';
                }
                field("Date chargement cde achat"; Rec."Date chargement cde achat")
                {
                    ApplicationArea = All;
                    Caption = 'Date chargement cde achat';
                    ToolTip = 'Date chargement cde achat';

                }
                field("Date liv. demandee cde achat"; Rec."Date liv. demandee cde achat")
                {
                    ApplicationArea = All;
                    Caption = 'Date liv. demandee cde achat';
                    ToolTip = 'Date liv. demandee cde achat';
                }
                field("Nom fournisseur"; Rec."Nom fournisseur")
                {
                    ApplicationArea = All;
                    Caption = 'Nom fournisseur';
                    ToolTip = 'Nom fournisseur';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Commande achat")
            {
                ApplicationArea = All;
                Caption = 'Commande achat';
                ToolTip = 'Commande achat';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Purchase Order";
                RunPageLink = "No." = field ("No. document achat");
            }
            action("Document vente")
            {
                ApplicationArea = All;
                ToolTip = 'Document vente';
                Caption = 'Document vente';
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    rec.AfficherDocumentVente();
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //"Type document vente" := "Type document vente"::Order;
    end;
}

