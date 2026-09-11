pageextension 50011 "SalesListExtension" extends "Sales List"
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            field("Code enseigne"; Rec."Code enseigne")
            {
                ApplicationArea = All;
                ToolTip = 'Code enseigne';
            }
            field(Commentaire; Rec.Commentaire)
            {
                ApplicationArea = All;
                ToolTip = 'Commentaires';
            }
        }
        addafter("Bill-to Contact")
        {
            field("Requested Delivery Date"; Rec."Requested Delivery Date")
            {
                ApplicationArea = All;
                ToolTip = 'Date de livraison demandée';
            }
        }

    }
}
