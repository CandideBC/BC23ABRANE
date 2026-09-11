page 50018 "Liste DEB"
{
    Caption = 'Périodes comptables';
    //CardPageID = "Fiche DEB Ventes";
    Editable = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Accounting Period";
    SourceTableView = ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Starting Date"; Rec."Starting Date")
                {
                    ToolTip = 'Date début';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Nom';
                }
                field("DEB Ventes cloturee"; Rec."DEB Ventes cloturee")
                {
                    ToolTip = 'DEB Ventes clôturée';
                }
                field("DEB Achats cloturee"; Rec."DEB Achats cloturee")
                {
                    ApplicationArea = All;
                    ToolTip = 'DEB Achats clôturée';
                }
                
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(Ventes)
            {
                Caption = 'Ventes';
                Image = Sales;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Fiche DEB Ventes";
                RunPageLink = "Starting Date" = FIELD ("Starting Date");
            }
            action(Achats)
            {
                Caption = 'Achats';
                Image = Purchase;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Fiche DEB Achats";
                RunPageLink = "Starting Date" = FIELD ("Starting Date");
            }
        }
    }

    var
        InvtPeriod: Record "Inventory Period";
}

