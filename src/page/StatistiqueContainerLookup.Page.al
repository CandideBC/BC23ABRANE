page 50054 StatistiqueContainerLookup
{
    ApplicationArea = All;
    Caption = 'StatistiqueContainerLookup';
    PageType = List;
    SourceTable = "Statistique container";
    UsageCategory = None;
    Editable = false;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No. container"; Rec."No. container")
                {
                    ToolTip = 'Indique le N° de container', Comment = '%';
                }
                field("No. commande achat"; Rec."No. commande achat")
                {
                    ToolTip = 'N° commande achat';
                }
                field("Commentaire AIE"; Rec."Commentaire AIE")
                {
                    ToolTip = 'Commentaire AIE';
                }
                field("Commentaire commande"; Rec."Commentaire commande")
                {
                    ToolTip = 'Commentaire commande';
                }
                field("Montant commande"; Rec."Montant commande")
                {
                    ToolTip = 'Montant commande';
                }
                field("Montant facture papier"; Rec."Montant facture papier")
                {
                    ToolTip = 'Montant facture papier';
                }
                field("Montant charge"; Rec."Montant charge")
                {
                    ToolTip = 'Montant chargé';
                }
                field("Code devise"; Rec."Code devise")
                {
                    ToolTip = 'Code devise';
                }
            }
        }
    }
}
