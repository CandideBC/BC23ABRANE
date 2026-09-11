page 50058 "SF DEB Ventes"
{
    Caption = 'Lignes';
    PageType = ListPart;
    SourceTable = "Ligne DEB";
    SourceTableView = where ("Type ligne DEB" = const ("Expédition"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                    ToolTip = 'Date';
                    Editable = false;
                }
                field("Type document"; Rec."Type document")
                {
                    ToolTip = 'Type document';
                    Editable = false;
                }
                field("No. document"; Rec."No. document")
                {
                    ToolTip = 'N° document';
                    Editable = false;
                }
                field("No. ligne document"; Rec."No. ligne document")
                {
                    ToolTip = 'N° ligne document';
                    Editable = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'N° article';
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Nom';
                    Editable = false;
                }
                field("Tariff No."; Rec."Tariff No.")
                {
                    ToolTip = 'N° nomenclature produits';
                    Editable = false;
                }
                field("No. nomenclature reduit"; Rec."No. nomenclature reduit")
                {
                    ToolTip = 'N° nomenclature réduit';
                    Editable = false;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ToolTip = 'Désignation article';
                    Editable = false;
                }
                field("Country/Region of Origin Code"; Rec."Country/Region of Origin Code")
                {
                    ToolTip = 'Code pays origine';
                    Editable = true;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ToolTip = 'Code pays';
                    Editable = false;
                }
                field("Entry/Exit Point"; Rec."Entry/Exit Point")
                {
                    ToolTip = 'Pays destination/provenance';
                    Editable = false;
                }
                field("Area"; Rec.Area)
                {
                    ToolTip = 'Dépt destination/provenance';
                    Editable = false;
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ToolTip = 'Régime';
                    Editable = false;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ToolTip = 'Code condition livraison';
                    Editable = false;
                }
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                    ToolTip = 'N° TVA intracom.';
                    Editable = false;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Nature transaction';
                    Editable = false;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ToolTip = 'Mode de transport';
                    Editable = false;
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    ToolTip = 'Poids net';
                }
                field("Total Weight"; Rec."Total Weight")
                {
                    ToolTip = 'Poids total';
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Quantité';
                    Editable = false;
                }
                field("Montant marchandise (ligne)"; Rec."Montant marchandise (ligne)")
                {
                    ToolTip = 'Montant marchandise (ligne)';
                    Editable = false;
                }
                field("Montants autres (ligne)"; Rec."Montants autres (ligne)")
                {
                    ToolTip = 'Montants autres (ligne)';
                    Editable = false;
                }
                field("Montant total (ligne)"; Rec."Montant total (ligne)")
                {
                    ToolTip = 'Montant total (ligne)';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

