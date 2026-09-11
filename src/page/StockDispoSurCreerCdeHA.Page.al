page 50072 "Stock Dispo Sur Creer Cde HA"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Stock dispo pour creer cde";
    SourceTableView = where ("Type ligne" = const ("Stock dispo"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. article"; Rec."No. article")
                {
                    Caption = 'N° article';
                    ToolTip = 'N° article';
                }
                field("Designation article"; Rec."Designation article")
                {
                    Caption = 'Désignation article';
                    ToolTip = 'Désignation article';
                }
                field("Code variante"; Rec."Code variante")
                {
                    Caption = 'Code variante';
                    ToolTip = 'Code variante';

                }
                field("Designation variante"; Rec."Designation variante")
                {
                    Caption = 'Désignation variante';
                    ToolTip = 'Désignation variante';
                }
                field("Code magasin"; Rec."Code magasin")
                {
                    Caption = 'Code magasin';
                    ToolTip = 'Code magasin';
                }
                field("Nom magasin"; Rec."Nom magasin")
                {
                    Caption = 'Nom magasin';
                    ToolTip = 'Nom magasin';
                }
                field("Stock dispo"; Rec."Stock dispo")
                {
                    Caption = 'Quantité dispo';
                    ToolTip = 'Quantité dispo';
                }
            }
        }
    }

    actions
    {
    }
}

