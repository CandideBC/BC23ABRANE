page 50143 "SF Ligne Colisage container"
{
    ApplicationArea = All;
    Caption = 'Palettes / Colis container';
    PageType = ListPart;
    SourceTable = "UC container";

    layout
    {
        area(content)
        {
            repeater(Control50000)
            {
                ShowCaption = false;
                field("No. UC"; Rec."No. UC")
                {
                    ToolTip = 'N° colisage';
                    Editable = false;
                }

                field("Type UC"; Rec."Type UC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Type UC';
                }
                field(Numerotation; Rec.Numerotation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Vous permet d''attribuer un numéro à chaque UC au sein du colisage, P1 ou C1 par exemple';
                }
                field("Numero camion"; Rec."Numero camion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Vous permet d''indiquer dans quel camion l''UC a été mise lorsqu''un même colisage nécessite d''être expédié avec plusieurs camions.';
                }
                field("No. commande achat"; Rec."No. commande achat")
                {
                    ApplicationArea = All;
                    //Caption = 'No. commande achat';
                    ToolTip = 'La palette est normalement rattachée à une seule commande d''achat qu''il faut indiquer ici.';
                }
                
                field(Longueur; Rec.Longueur)
                {
                    ApplicationArea = All;
                    ToolTip = 'Longueur de l''UC';
                }
                field(Largeur; Rec.Largeur)
                {
                    ApplicationArea = All;
                    ToolTip = 'Largeur de l''UC';
                }
                field(Hauteur; Rec.Hauteur)
                {
                    ApplicationArea = All;
                    ToolTip = 'Hauteur de l''UC';
                }
                field(Dimensions; Rec.Dimensions)
                {
                    ApplicationArea = All;
                    ToolTip = 'Dimensions de l''UC';
                }

                field("Poids net articles"; Rec."Poids net articles")
                {
                    ToolTip = 'Poids net des articles';
                    BlankZero = true;
                    DecimalPlaces = 0 : 2;
                }
                field("Poids brut UC"; Rec."Poids brut UC")
                {
                    ToolTip = 'Poids brut UC';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            /*
            action("Calculer poids palette")
            {
                Caption = 'Calculer poids';
                ToolTip = 'Calculer poids';;
                trigger OnAction()
                begin
                    Rec.CalcWeight(Rec."No. colisage", Rec."No. UC")
                end;
            }
            */
        }
    }








}

