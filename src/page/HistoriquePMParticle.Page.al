page 50000 "Historique PMP article"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Historique PMP article';
    Editable = false;
    PageType = List;
    SourceTable = "Historique PMP article";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. article"; Rec."No. article")
                {
                    ToolTip = 'N° article';
                }
                field(Date; Rec.Date)
                {
                    ToolTip = 'Date';
                }
                field(Designation; Rec.Designation)
                {
                    ToolTip = 'Désignation';
                }
                field("Ref client"; Rec."Ref client")
                {
                    ToolTip = 'Réf. client';
                }
                field("Date dernier mouvement"; Rec."Date dernier mouvement")
                {
                    ToolTip = 'Date dernier mouvement';
                }
                field("Date dernier achat"; Rec."Date dernier achat")
                {
                    ToolTip = 'Date dernier achat';
                }
                field("Quantite en stock"; Rec."Quantite en stock")
                {
                    ToolTip = 'Quantité en stock';
                }
                field("PMP recalcule"; Rec."PMP recalcule")
                {
                    ToolTip = 'PMP recalculé';
                }
            }
        }
    }

    actions
    {
    }
}

