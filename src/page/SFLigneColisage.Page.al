page 50026 "SF Ligne Colisage"
{
    ApplicationArea = All;
    Caption = 'Palettes / Colis';
    PageType = ListPart;
    SourceTable = "Detail colisage";

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
                
                
                /*
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ToolTip = 'Poids brut';
                    BlankZero = true;
                    DecimalPlaces = 0 : 2;
                }
                */
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

    trigger OnDeleteRecord(): Boolean
    begin
        fctCheckPackingStatus();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        fctCheckPackingStatus();
    end;

    procedure fctCheckPackingStatus()
    var
        lEnteteColisage: Record "Entete colisage";
        Text000001Err: Label 'Mise à jour non autorisée avec ce statut de colisage';
    begin
        if lEnteteColisage.Get(Rec."No. colisage") and (lEnteteColisage."Packing Status" <> 0) then
            Error(Text000001Err);
    end;


}

