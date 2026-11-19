page 50156 WSLignesCommandesAchat
{
    ApplicationArea = All;
    Caption = 'WSLignesCommandesAchat';
    PageType = List;
    SourceTable = "Purchase Line";
    SourceTableView = sorting("Document Type", "Buy-from Vendor No.") where ("Document Type"=const(Order));
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'N° document';
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ToolTip = 'N° preneur d''ordre';
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'N° ligne';
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Type';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'N°';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                }
                field("Description 2"; Rec."Description 2")
                {
                    ToolTip = 'Désignation 2';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Quantité';
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                    ToolTip = 'Quantité restante';
                }
            }
        }
    }
}
