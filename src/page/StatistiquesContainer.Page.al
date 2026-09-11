page 50096 "Statistiques container"
{
    ApplicationArea = All;
    UsageCategory = None;
    Caption = 'Statistiques container';
    PageType = Card;
    SourceTable = Container;
    
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("Montant charge (DS)"; Rec."Montant charge (DS)")
                {
                    ToolTip = 'Indique le montant chargé';
                }
                field("Montant facture (papier)";Rec."Montant facture (papier)")
                {
                    ToolTip = 'Indique le montant des factures papier';
                }
                field("Nb commandes"; Rec."Nb commandes")
                {
                    ToolTip = 'Indique le nombre de commandes';
                }
                field("Quantite totale"; Rec."Quantite totale")
                {
                    ToolTip = 'Quantité totale';
                }
            }
            part(Chantiers; "SF Statistique container")
            {
                Caption = 'Chantiers';
                SubPageLink = "No. container" = field ("No.");
            }

        }

    }
}
