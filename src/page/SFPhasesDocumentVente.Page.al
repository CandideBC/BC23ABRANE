page 50106 "SF phases document vente"
{
    ApplicationArea = All;
    Caption = 'Phasage document vente';
    PageType = ListPart;
    SourceTable = "Sales Line";
    SourceTableView = sorting(TypeDocDuplique, NumDocDuplique, Phase);
    UsageCategory = None;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'N° de la ligne du document';
                }

                field("No."; Rec."No.")
                {
                    ToolTip = 'N° de l''article';
                    StyleExpr = MonStyle;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Désignation de l''article';
                    StyleExpr = MonStyle;
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Quantité commandée.';
                    Editable = false;
                }
                field("Quantity Shipped"; Rec."Quantity Shipped")
                {
                    ApplicationArea = All;
                    ToolTip = 'Quantité ayant déjà été expédiée.';
                }

                field("Qty. to Ship"; Rec."Qty. to Ship")
                {
                    ToolTip = 'Quantité à expédier.';
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        DefinirStyle();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        DefinirStyle();
    end;

    procedure DefinirStyle()
    var

    begin
        //case
            //rec."Type phasage" of
            //Rec."Type phasage"::Compose:
            //    MonStyle := 'StrongAccent';
            //Rec."Type phasage"::Composant:
            //    MonStyle := 'Subordinate';
            //else
                MonStyle := 'Normal';
        //end;
    end;

    var
        MonStyle: Text;
}
