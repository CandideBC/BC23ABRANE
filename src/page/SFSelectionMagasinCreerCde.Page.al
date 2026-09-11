page 50073 "SF Selection magasin/creer cde"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "Stock dispo pour creer cde";
    SourceTableView = where ("Type ligne" = const (Magasin));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code magasin"; Rec."Code magasin")
                {
                    ToolTip = 'Code magasin';
                }
                field("Nom magasin"; Rec."Nom magasin")
                {
                    ToolTip = 'Nom du magasin';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        exit;
                    end;
                }
                field("Tenir compte du stock"; Rec."Tenir compte du stock")
                {
                    ToolTip = 'Tenir compte du stock';
                }
            }
        }
    }

    actions
    {
    }
}

