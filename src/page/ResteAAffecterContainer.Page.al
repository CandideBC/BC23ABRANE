page 50093 "Reste à affecter container"
{
    Editable = false;
    PageType = List;
    SourceTable = "Purchase Line";
    SourceTableView = SORTING("Document Type", "Suivi container", "Suivi container OK")
                      WHERE("Suivi container" = CONST(true),
                            "Suivi container OK" = CONST(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'N° document';
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'N° ligne';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Type';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'N°';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Désignation';
                }
                field("Description 2"; Rec."Description 2")
                {
                    ToolTip = 'Désignation 2';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Quantité';
                }
                field("Quantite en container"; Rec."Quantite en container")
                {
                    ToolTip = 'Quantité en container';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Fiche commande")
            {
                Caption = 'Commande';
                ToolTip = 'Afficher la commande';
                Image = EditLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Purchase Order";
                RunPageLink = "No." = field("Document No.");
                ShortCutKey = 'Shift+F7';
            }
        }
    }
}

