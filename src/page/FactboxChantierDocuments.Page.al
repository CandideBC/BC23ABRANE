page 50098 "Factbox chantier : documents"
{
    ApplicationArea = All;
    Caption = 'Factbox chantier : documents';
    PageType = CardPart;
    SourceTable = Chantier;
    Editable = false;
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("Commandes achat"; Rec."Commandes achat")
                {
                    ToolTip = 'Specifies the value of the Commandes achat field.', Comment = '%';
                }
                field("Factures achat"; Rec."Factures achat")
                {
                    ToolTip = 'Specifies the value of the Factures achat field.', Comment = '%';
                }
                field("Avoirs achat"; Rec."Avoirs achat")
                {
                    ToolTip = 'Specifies the value of the Avoirs achat field.', Comment = '%';
                }
                field("Devis vente"; Rec."Devis vente")
                {
                    ToolTip = 'Specifies the value of the Devis vente field.', Comment = '%';
                }
                field("Commandes vente"; Rec."Commandes vente")
                {
                    ToolTip = 'Specifies the value of the Commandes vente field.', Comment = '%';
                }
                field("Factures vente"; Rec."Factures vente")
                {
                    ToolTip = 'Specifies the value of the Factures vente field.', Comment = '%';
                }
                field("Avoirs vente"; Rec."Avoirs vente")
                {
                    ToolTip = 'Specifies the value of the Avoirs vente field.', Comment = '%';
                }
            }
        }
    }
}
