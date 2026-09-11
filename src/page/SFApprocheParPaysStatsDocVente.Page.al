page 50038 SFApprocheParPaysStatsDocVente
{
    ApplicationArea = All;
    Caption = 'Approche par pays';
    PageType = ListPart;
    SourceTable = TamponBudgetApprocheDocument;
    SourceTableView = where ("Type ligne"=const("Budget approche"));
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code pays origine"; Rec."Code pays origine")
                {
                    ToolTip = 'Indique le pays pour lequel les frais d''approche, la quantité totale et les poids ont été calculés.';
                }
                field(Quantite; Rec.Quantite)
                {
                    ApplicationArea = All;
                    ToolTip = 'Indique la quantité totale d''articles pour le pays.';
                }
                field("Poids net"; Rec."Poids net")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indique le poids net total des articles venant de ce pays.';
                }
                field("Poids brut"; Rec."Poids brut")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indique le poids brut total des articles venant de ce pays.';
                }
                
                field("Montant achats prevus"; Rec."Montant achats prevus")
                {
                    ToolTip = 'Indique le montant d''achat des articles venant de ce pays.';
                }
                field("% frais approche"; Rec."% frais approche")
                {
                    ToolTip = 'Indique le % de frais d''approches estimés pour ce pays.';
                }
                field("Budget frais approche"; Rec."Budget frais approche (DS)")
                {
                    ToolTip = 'Indique le montant estimé de frais d''approches pour les articles venant de ce pays.';
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        rec.SetRange("Code utilisateur",UserId);
    end;
}
