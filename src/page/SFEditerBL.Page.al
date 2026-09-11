page 50034 "SF Editer BL"
{
    ApplicationArea = All;
    Caption = 'SF Editer BL';
    PageType = ListPart;
    SourceTable = "Sales Shipment Line";
    InsertAllowed = false;
    DeleteAllowed = false;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Indique le type de ligne';
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Indique le N° article /  de compte / de ressource';
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Désignation de la ligne';
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Indique la quantité expédiée';
                    Editable = false;
                }
                field("Quantite a remettre en stock"; Rec."Quantite a remettre en stock")
                {
                    ToolTip = 'Quantité à remettre en stock';
                    
                }
                field("Quantite deja remise en stock"; Rec."Quantite deja remise en stock")
                {
                    ToolTip = 'Quantité déja remise en stock';
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'N° ligne';
                    Editable = false;
                }
            }
        }
    }
}
