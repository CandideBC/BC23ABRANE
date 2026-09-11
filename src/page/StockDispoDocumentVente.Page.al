page 50004 StockDispoDocumentVente
{
    ApplicationArea = All;
    Caption = 'Stock disponible doc. vente';
    PageType = List;
    Editable = false;
    SourceTable = "Stock dispo pour creer cde";
    SourceTableView = sorting("Code utilisateur", "Document Type", "Document No.", "Code magasin", "Stock dispo") order(descending);
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No. article"; Rec."No. article")
                {
                    ToolTip = 'N° article';
                }
                field("Designation article"; Rec."Designation article")
                {
                    ToolTip = 'Désignation article';
                }
                field("Code variante"; Rec."Code variante")
                {
                    ToolTip = 'Code variante';
                    Visible = false;
                }
                field("Designation variante"; Rec."Designation variante")
                {
                    ToolTip = 'Désignation variante';
                    Visible = false;
                }
                field(Quantite; Rec.Quantite)
                {
                    ApplicationArea = All;
                    Caption = 'Quantité vendue';
                    ToolTip = 'Quantité vendue';
                    DrillDown = false;
                }
                field("Quantite achetee"; Rec."Quantite achetee")
                {
                    ApplicationArea = All;
                    ToolTip = 'Quantité achetée (affectations) pour cette ligne.';
                    DrillDown = false;
                }
                field("Qte prise sur stock"; Rec."Qte prise sur stock")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ecart entre la quantité vendue et la quantité achetée pour cette ligne.';
                    DrillDown = false;
                }
                field("Reste a definir (Qte)"; Rec."Reste a definir (Qte)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indique que le système ne sait pas si la quantité vendue sera achetée ou prise sur stock';
                    DrillDown = false;
                }


                field(Separateur; '|')
                {
                    Caption = ' ';
                    ToolTip = 'Séparation entre les colonnes liées à la ligne et les colonnes présentant des cumuls';
                }
                field(Stock; Rec.Stock)
                {
                    ToolTip = 'Quantité disponible';
                }

                field("Quantite reservee"; Rec."Quantite reservee")
                {
                    ApplicationArea = All;
                    ToolTip = 'Quantité prise sur stock par les devis/commandes';
                }
                field("Stock dispo"; Rec."Stock dispo")
                {
                    DecimalPlaces = 0 : 2;
                    Caption = 'Stock dispo';
                    ToolTip = 'Stock physique moins les quantités prises sur stock par les devis/commandes.';
                    BlankZero = true;
                }
                field("Qte en transit"; Rec."Qte en transit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Qté en transit';
                }
                field("Qte sur commande achat"; Rec."Qte sur commande achat")
                {
                    ApplicationArea = All;
                    ToolTip = 'Qté sur commande achat';
                }
                field("Qte sur commande vente"; Rec."Qte sur commande vente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Quantité restant à livrer sur les commandes de ventes.';
                    Visible = true;
                }
                field("Stock projete"; decStockProjete)
                {
                    Caption = 'Stock projeté';
                    DecimalPlaces = 0 : 2;
                    ToolTip = 'Stock physique + quantités sur commandes d''achats moins quantités sur commandes de ventes.';
                }
                field("Qte sur devis vente"; Rec."Qte sur devis 100%")
                {
                    ApplicationArea = All;
                    ToolTip = 'Quantité sur devis de ventes.';
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            /*
            action(AfficherCommandes)
            {
                
                ApplicationArea = All;
                Caption = 'Afficher commandes';
                ToolTip = 'Affiche la liste des commandes pour cet article';
                Image = OrderList;

                trigger OnAction()
                var
                    LigneVente: Record "Sales Line";
                begin
                    LigneVente.SetCurrentKey("Document Type", Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Shipment Date");
                    LigneVente.Setrange("Document Type", LigneVente."Document Type"::Order);
                    LigneVente.SetRange(Type, LigneVente.Type::Item);
                    LigneVente.SetRange("No.", Rec."No. article");
                    Page.RunModal(Page::"Sales Lines", LigneVente);
                end;
                
            }
            */
        }
    }
    trigger OnAfterGetRecord()
    begin
        //decStockDispo := Rec.Stock - Rec."Quantite reservee";
        //if decStockDispo < 0 then
        //    decStockDispo := 0;
        Rec.CalcFields("Qte sur commande achat", "Qte sur commande vente");
        decStockProjete := Rec.Stock - Rec."Qte sur commande vente" + Rec."Qte sur commande achat";
    end;

    var
        //decStockDispo: Decimal;
        decStockProjete: Decimal;

}
