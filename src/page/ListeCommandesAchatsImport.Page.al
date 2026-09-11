page 50053 ListeCommandesAchatsImport
{
    ApplicationArea = All;
    Caption = 'Liste commandes achats import';
    PageType = List;
    SourceTable = "Purchase Header";
    UsageCategory = None;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'N°';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Statut';
                }
                field("Achat pour stock"; Rec."Achat pour stock")
                {
                    ToolTip = 'Achat pour stock';
                }
                field("SAV Type"; Rec."SAV Type")
                {
                    ToolTip = 'Type SAV';
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ToolTip = 'Nom preneur d''ordre';
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
                field(Commentaires; Rec.Commentaires)
                {
                    ToolTip = 'Commentaires';
                }
                field("Commentaires pour AIE"; Rec."Commentaires pour AIE")
                {
                    ToolTip = 'Commentaires pour AIE';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Montant H.T.';
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ToolTip = 'Montant TTC';
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ToolTip = 'Code acheteur';
                }
                field("Semaine chargement"; Rec."Semaine chargement")
                {
                    ToolTip = 'Semaine chargement';
                }
                field("Date chargement confirmee"; Rec."Date chargement confirmee")
                {
                    ToolTip = 'Date chargement confirmée';
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ToolTip = 'Date réception prévue';
                }
                field("Code chantier"; Rec."Code chantier")
                {
                    ToolTip = 'Chantier';
                }
                field("Code enseigne"; Rec."Code enseigne")
                {
                    ToolTip = 'Enseigne';
                }
                field("Annee commande"; Rec."Annee commande")
                {
                    ToolTip = 'Année commande';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(AfficherCommande)
            {
                ApplicationArea = All;
                Caption = 'Commande';
                RunObject = page "Purchase Order";
                RunPageLink = "No." = field("No.");
                Image = Card;
                ToolTip = 'Afficher la commande';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        EnteteAchat: Record "Purchase Header";
    begin
        NoDocVenteTxt := '';
        DateChargementTxt := '';
        DateLivraisonDemandeeTxt := '';
        if EnteteAchat.Get(EnteteAchat."Document Type"::Order, Rec."No.") then
            EnteteAchat.ObtenirInfosDocumentVenteLie(NoDocVenteTxt, DateChargementTxt, DateLivraisonDemandeeTxt);
    end;

    var
        NoDocVenteTxt: Text;
        DateChargementTxt: Text;
        DateLivraisonDemandeeTxt: Text;

}
