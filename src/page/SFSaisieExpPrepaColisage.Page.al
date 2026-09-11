page 50127 "SFSaisieExpPrepaColisage"
{
    Caption = 'UC / Commande';
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Prepa colisage";
    InsertAllowed = false;
    //DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No. article";Rec."No. article")
                {
                    ApplicationArea = All;
                    ToolTip = 'N° article';
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Désignation de l''article';
                }
                field("No. UC"; Rec."No. UC")
                {
                    ApplicationArea = All;
                    ToolTip = 'N° de l''unité de colisage';
                }

                field("Type UC"; Rec."Type UC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Type d''unité de colisage';
                    Visible = false;
                }
                
                field(Numerotation; Rec.Numerotation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Numérotation de la palette propre à l''intérieur de ce colisage.';
                }

                
                field("Quantite dans UC";Rec."Quantite dans UC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Quantité de cet article dans cette unité de colisage.';
                }
                field("Numero camion"; Rec."Numero camion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Identifiant du camion dans laquelle la palette a été chargée.';
                }

            }
        }
    }




    actions
    {
    }
}



