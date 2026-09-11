page  50118 StockDispoArticle
{
    ApplicationArea = All;
    Caption = 'Stock disponible article';
    PageType = List;
    Editable = false;
    SourceTable = "Stock dispo pour creer cde";
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


                field(Stock; Rec.Stock)
                {
                    ToolTip = 'Stock';
                }

                field("Quantite reservee"; Rec."Quantite reservee")
                {
                    ApplicationArea = All;
                    ToolTip = 'Quantité prise sur stock par les ventes';
                }
                field("Stock dispo"; Rec."Stock dispo")
                {
                    DecimalPlaces = 0 : 2;
                    Caption = 'Stock dispo';
                    ToolTip = 'Stock physique moins les quantités prises sur stock par les commandes.';
                }
                field("Qte en transit" ; Rec."Qte en transit" )
                {
                    ApplicationArea = All;
                    ToolTip = 'Quantité en transit';
                }
                field("Qte sur commande achat"; Rec."Qte sur commande achat")
                {
                    ApplicationArea = All;
                    ToolTip = 'Quantité restant à recevoir sur les commandes d''achats.';
                    Caption = 'Qté sur cdes achats';
                    DecimalPlaces = 0:5;
                    BlankZero = true;
                }

                
                field("Qte sur commande vente"; Rec."Qte sur commande vente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Quantité restant à livrer sur les commandes de ventes.';
                    Visible = true;
                    DecimalPlaces = 0:5;
                    BlankZero = true;
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
                    ToolTip = 'Quantité sur devis 100%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
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
        }
    }
    trigger OnAfterGetRecord()
    begin
        //decStockDispo := Rec.Stock - Rec."Quantite reservee";
        //if decStockDispo < 0 then
        //    decStockDispo := 0;
        Rec.CalcFields("Qte sur commande achat","Qte sur commande vente");
        decStockProjete := Rec.Stock - Rec."Qte sur commande vente" + Rec."Qte sur commande achat";
    end;

    var
        //decStockDispo: Decimal;
        decStockProjete: Decimal;

}
