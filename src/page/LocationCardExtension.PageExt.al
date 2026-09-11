pageextension 50017 "LocationCardExtension" extends "Location Card"
{
    layout
    {
        addafter(Contact)
        /*



                SourceExpr="Montrer stock sur creer cde" }
                SourceExpr="Magasin client" }
        */
        {
            field("Reserved Location"; Rec."Reserved Location")
            {
                ApplicationArea = All;
                ToolTip = 'Magasin réservé';
            }
            field("Linked Location Code"; Rec."Linked Location Code")
            {
                ApplicationArea = All;
                ToolTip = 'Code magasin Lié';
            }
            field("Afficher dans stock"; Rec."Afficher dans stock")
            {
                ApplicationArea = All;
                ToolTip = 'Afficher dans stock';
            }
            field("Magasin obsolete"; Rec."Magasin obsolete")
            {
                ApplicationArea = All;
                ToolTip = 'Magasin obsolete';
            }
            field("Magasin de rebut"; Rec."Magasin de rebut")
            {
                ApplicationArea = All;
                ToolTip = 'Magasin de rebut';
            }
            field("Magasin de transit"; Rec."Magasin de transit")
            {
                ApplicationArea = All;
                ToolTip = 'Magasin de transit';
            }
            field("Montrer stock sur creer cde"; Rec."Montrer stock sur creer cde")
            {
                ApplicationArea = All;
                ToolTip = 'Montrer stock sur creer cde';
            }
            field("Magasin client"; Rec."Magasin client")
            {
                ApplicationArea = All;
                ToolTip = 'Magasin client';
            }
        }


    }
}
