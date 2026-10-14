page 50129 "SFFicheUniteColisage"
{
    Caption = 'Préparation';
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Detail UC Commande";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No. commande"; Rec."No. commande")
                {
                    ApplicationArea = All;
                    ToolTip = 'N° de la commande en cours de préparation.';
                }
                field("No. ligne commande"; Rec."No. ligne commande")
                {
                    ApplicationArea = All;
                    ToolTip = 'N° de la ligne de commande en cours de préparation.';
                }


                field("No. article"; Rec."No. article")
                {
                    ApplicationArea = All;
                    ToolTip = 'N° article';
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Désignation de l''article';
                }

                field("Quantite dans UC"; Rec."Quantite dans UC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Quantité de cet article dans cette unité de colisage.';
                }

            }
        }
    }




    actions
    {
    }
}



