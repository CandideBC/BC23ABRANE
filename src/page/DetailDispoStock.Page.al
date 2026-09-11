page 50117 DetailDispoStock
{
    ApplicationArea = All;
    Caption = 'Détail disponibilité stock';
    PageType = List;
    SourceTable = TamponDetailDispoStock;
    UsageCategory = None;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No. article"; Rec."No. article")
                {
                }
                field("No. document"; Rec."No. document")
                {
                }
                field(Commentaires; Rec.Commentaires)
                {
                    ApplicationArea = All;
                }

                field("No. ligne"; Rec."No. ligne")
                {
                    Visible = false;
                }
                field("Quantite reservee"; Rec."Quantite reservee")
                {
                }
                field("Date chargement"; Rec."Date chargement")
                {
                    ApplicationArea = All;
                }
                field("Date livraison demandee"; Rec."Date livraison demandee")
                {
                    ApplicationArea = All;
                }


                field("Quantite sur devis"; Rec."Quantite sur devis")
                {
                    ApplicationArea = All;
                }
                field("Code vendeur"; Rec."Code vendeur")
                {
                    ApplicationArea = All;
                }
                field("Proba transformation"; Rec."Proba transformation")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(OuvrirDocument)
            {
                Caption ='Ouvrir document';
                ToolTip = 'Affiche le document';
                Promoted = true;
                PromotedCategory = Process;
                Image = Document;
                ApplicationArea = All;

                trigger OnAction()
                var
                    EnteteVente: Record "Sales Header";
                begin
                    if EnteteVente.Get(EnteteVente."Document Type"::Quote, Rec."No. document") then
                        Page.Run(Page::"Sales Quote", EnteteVente)
                    else
                        if EnteteVente.Get(EnteteVente."Document Type"::Order, Rec."No. document") then
                            Page.Run(Page::"Sales Order", EnteteVente);
                end;
            }
        }
    }
}
