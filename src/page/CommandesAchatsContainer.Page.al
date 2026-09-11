page 50141 "Commandes achats container"
{
    Caption = 'Commandes achats';
    Editable = false;
    PageType = List;
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
                field("No. Doc. Vente Lie"; NoDocVenteTxt)
                {
                    Caption = 'N° doc. vente lié';
                    ToolTip = 'N° document vente lié';
                    ApplicationArea = All;
                }
                field("Date chargement doc. vente"; DateChargementTxt)
                {
                    Caption = 'Date chargement doc. vente';
                    ToolTip = 'Date chargement doc. vente';
                    ApplicationArea = All;
                }
                field("Date liv. demandee doc. vente"; DateLivraisonDemandeeTxt)
                {
                    Caption = 'Date livraison demandée doc. vente';
                    ToolTip = 'Date livraison demandée doc. vente';
                    ApplicationArea = All;
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

    trigger OnAfterGetRecord()
    var
        EnteteAchat: Record "Purchase Header";
    begin
        NoDocVenteTxt := '';
        DateChargementTxt := '';
        DateLivraisonDemandeeTxt := '';
        if EnteteAchat.Get(EnteteAchat."Document Type"::Order, rec."No. commande achat") then
            EnteteAchat.ObtenirInfosDocumentVenteLie(NoDocVenteTxt, DateChargementTxt, DateLivraisonDemandeeTxt);
    end;

    var
        NoDocVenteTxt: Text;
        DateChargementTxt: Text;
        DateLivraisonDemandeeTxt: Text;
}
