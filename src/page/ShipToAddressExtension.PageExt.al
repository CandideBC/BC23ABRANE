pageextension 50066 ShipToAddressExtension extends "Ship-to Address"
{
    layout
    {
        /*
        modify(Description)
        {
            Caption = 'Désignation ligne';
        }
        */
        addafter("Last Date Modified")
        {
            field("Adresse de facturation"; Rec."Adresse de facturation")
            {
                ApplicationArea = All;
                Caption = 'Adresse de facturation';
                ToolTip = 'Adresse de facturation';
            }
            field("No. And Location Name"; Rec."No. And Location Name")
            {
                ApplicationArea = All;
                Caption = 'N° et nom magasin';
                ToolTip = 'N° et nom magasin';
            }
            field("Management Control Mail"; Rec."Management Control Mail")
            {
                ApplicationArea = All;
                Caption = 'Mail Contrôleur de gestion';
                ToolTip = 'Mail Contrôleur de gestion';
            }            



        }

    }
    actions
    {


    }
}
