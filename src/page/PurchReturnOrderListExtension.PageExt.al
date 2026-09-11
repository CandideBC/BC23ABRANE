pageextension 50053 PurchReturnOrderListExtension extends "Purchase Return Order List"
{
    layout
    {
        addafter("Buy-from Vendor Name")
        {

            field("SAV Type"; Rec."SAV Type")
            {
                ApplicationArea = All;
                ToolTip = 'Type SAV';
            }
            field("Achat pour stock"; Rec."Achat pour stock")
            {
                ApplicationArea = All;
                ToolTip = 'Achat pour stock';
            }
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
                ToolTip = 'Date commande';
            }
            field("Code groupe";Rec."Code groupe" )
            {
                ToolTip = 'Code groupe';
            }
            field("Code enseigne";Rec."Code enseigne" )
            {
                ToolTip = 'Code enseigne';
            }
            field("Code operation";Rec."Code operation" )
            {
                ToolTip = 'Code opération';
            }
            field("Code chantier";Rec."Code chantier" )
            {
                ToolTip = 'Code chantier';
            }
        }
        addafter("Shipment Method Code")
        {
            field("Date intention chargement"; Rec."Date intention chargement")
            {
                ToolTip = 'Date du lundi de la semaine de chargement';
            }
            field("Date chargement confirmee"; Rec."Date chargement confirmee")
            {
                ToolTip = 'Date de chargement confirmée';
            }
            field("Commentaires"; Rec."Commentaires")
            {
                ToolTip = 'Commentaires';
            }
        }
    }
    actions
    {
        addafter(Print)
        {

            action("Etiquette palette")
            {
                ApplicationArea = All;
                ToolTip = 'Etiquette palette';
                Image = SuggestItemPrice;
                Promoted = true;
                PromotedCategory = Report;
                trigger OnAction()
                begin
                    rec.GenererEtiquettePalette(true);
                    
                end;
            }
        }
    }
}
