page 50094 "Lignes containers"
{
    Editable = false;
    PageType = List;
    SourceTable = "Ligne container";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. container"; Rec."No. container")
                {
                    ApplicationArea = All;
                }
                field("No. ligne"; Rec."No. ligne")
                {
                    ApplicationArea = All;
                }
                field("No. commande achat"; Rec."No. commande achat")
                {
                }
                field("No. ligne commande achat"; Rec."No. ligne commande achat")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'N°';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                }
                field(Quantite; Rec.Quantite)
                {
                    ToolTip = 'Quantité mise en container (reçue ou non)';
                }
                field("Quantite restante"; Rec."Quantite restante")
                {
                    ApplicationArea = All;
                    ToolTip = 'Quantité non réceptionnée.';
                }
                
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Fiche container")
            {
                Caption = 'Fiche container';
                ToolTip = 'Fiche container';
                Image = DocumentEdit;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Fiche container";
                RunPageLink = "No." = field ("No. container");
            }
            action("Fiche commande")
            {
                Caption = 'Fiche commande';
                ToolTip = 'Permet d''afficher la commande d''achat.';
                Image = EditLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Purchase Order";
                RunPageLink = "No." = field ("No. commande achat");
                ShortCutKey = 'Shift+F7';
            }
        }
    }
}

