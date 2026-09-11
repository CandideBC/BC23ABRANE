page 50097 "SF Statistique container"
{
    Caption = 'Commandes';
    Editable = false;
    PageType = ListPart;
    SourceTable = "Statistique container";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
                field("Montant charge"; Rec."Montant charge")
                {
                    ToolTip = 'Montant chargé';
                }
                field("Montant commande-Montant charge"; Rec."Montant commande" - Rec."Montant charge")
                {
                    BlankZero = true;
                    Caption = 'Montant restant à charger';
                    ToolTip = 'Montant commande-Montant chargé';
                    Editable = false;
                }
                field("Code devise"; Rec."Code devise")
                {
                    ToolTip = 'Code devise';
                }
                field("Montant charge (DS)"; Rec."Montant charge (DS)")
                {
                    ToolTip = 'Montant chargé (DS)"';
                }
                field("Montant facture papier"; Rec."Montant facture papier")
                {
                    ToolTip = 'Montant facture papier';
                }
                field("Montant facture papier-Montant charge"; Rec."Montant facture papier" - Rec."Montant charge")
                {
                    Caption = 'Mnt Papier - Mnt chargé';
                    ToolTip = 'Montant facture papier-Montant chargé';
                }
                field("Quantite totale"; Rec."Quantite totale")
                {
                    ToolTip = 'Quantité totale';
                }
            }
        }
    }

    actions
    {
    }
}

