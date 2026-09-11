page 50132 SFSuiviAchatsParDocVente
{
    ApplicationArea = All;
    Caption = 'Affectations';
    PageType = ListPart;
    SourceTable = TamponAffectationsDocVente;
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No. article achete"; Rec."No. article achete")
                {
                    ToolTip = 'N° article acheté';
                }
                field("Description article achete"; Rec."Description article achete")
                {
                    ToolTip = 'Description article acheté';
                }
                field("Qte achetee"; Rec."Qte achetee")
                {
                    ToolTip = 'Quantité achetée';
                }
                field("Qte recue"; Rec."Qte recue")
                {
                    ToolTip = 'Quantité reçue';
                }
                field("Quantite affectee"; Rec."Quantite affectee")
                {
                    ApplicationArea = All;
                    ToolTip = 'Quantité affectée';

                    trigger OnDrillDown()
                    begin

                    end;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(OuvrirCommande)
            {
                ApplicationArea = All;
                Caption = 'Commande achat';
                ToolTip = 'Ouvrir la commande achat';

                RunObject = page "Purchase Order";
                RunPageLink = "No." = field("No. commande achat");

            }
        }
    }

}
