pageextension 50002 LocationListExtension extends "Location List"
{
    layout
    {
        addafter(Name)
        {
            field("Afficher dans stock"; Rec."Afficher dans stock")
            {
                ApplicationArea = All;
                ToolTip = 'Afficher dans stock';
            }
            field("Magasin de transit"; Rec."Magasin de transit")
            {
                ApplicationArea = All;
                ToolTip = 'Magasin de transit';
            }
            field("Magasin obsolete"; Rec."Magasin obsolete")
            {
                ApplicationArea = All;
                ToolTip = 'Magasin obsolète';
            }
            field("Magasin de rebut"; Rec."Magasin de rebut")
            {
                ApplicationArea = All;
                ToolTip = 'Magasin de rebut';
            }
            field("Magasin bloque"; Rec."Magasin bloque")
            {
                ApplicationArea = All;
                ToolTip = 'Magasin bloque';

            }
            field("Montrer stock sur creer cde"; Rec."Montrer stock sur creer cde")
            {
                ApplicationArea = All;
                ToolTip = 'Montrer stock sur créer cde';
            }
            field("Magasin client"; Rec."Magasin client")
            {
                ApplicationArea = All;
                ToolTip = 'Magasin client';
            }
        }
    }
}

