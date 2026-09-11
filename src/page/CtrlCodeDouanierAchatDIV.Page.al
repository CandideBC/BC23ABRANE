page 50098 "Ctrl. code douanier/Achat DIV"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Purchase Line";
    SourceTableView = sorting (TypeDoc, "Article divers", "Code douanier OK", GrpComptaMarche)
                      where ("Article divers" = const (true),
                            "Document Type" = const (Order),
                            Type = const (Item),
                            "Code douanier OK" = CONST (false),
                            "Gen. Bus. Posting Group" = filter (<> 'FRANCE'));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'N° document';
                    Editable = false;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ToolTip = 'N° preneur d''ordre';
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'N°';
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Quantité';
                    Editable = false;
                }
                field("Nomenclature produits"; Rec."Nomenclature produits")
                {
                    ToolTip = 'Nomenclature produits'; 
                }
                field("Code douanier OK"; Rec."Code douanier OK")
                {
                    ToolTip = 'Code douanier OK';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(Fiche)
            {
                Caption = 'Fiche';
                Image = "Order";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Purchase Order";
                RunPageLink = "No." = FIELD ("Document No.");
            }
        }
    }
}

