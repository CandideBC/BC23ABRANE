page 50120 TmpDetailDispoStock
{
    ApplicationArea = All;
    Caption = 'TmpDétail disponibilité stock';
    PageType = List;
    SourceTable = TamponDetailDispoStock;
    UsageCategory = Lists;
    Editable = false;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code utilisateur"; Rec."Code utilisateur")
                {
                    ApplicationArea = All;
                }
                
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
}
