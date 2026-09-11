page 50144 "SF Contenu colisage container"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'Articles / UC';
    PageType = ListPart;
    SourceTable = "Contenu colisage container";

    layout
    {
        area(content)
        {
            repeater(Control50000)
            {
                ShowCaption = false;

                field(Type; Rec.Type)
                {
                    ToolTip = 'Type';
                    Visible = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'N° article';
                }
                field("Attached to Line No."; Rec."Attached to Line No.")
                {
                    ToolTip = 'Attaché à la ligne N°';
                    Visible = false;
                }

                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                }
                field("Description 2"; Rec."Description 2")
                {
                    ToolTip = 'Description 2';
                    Visible = false;
                }
                field("Designation article"; Rec."Designation article")
                {
                    Visible = false;
                    ToolTip = 'Désignation article';
                }

                field("No. UC"; Rec."No. UC")
                {
                    ToolTip = 'N° UC';
                    Style = Strong;
                    StyleExpr = true;

                    trigger OnValidate()
                    begin
                        PackageNoOnAfterValidate();
                    end;
                }
                field("Quantite UC"; Rec."Quantite UC")
                {
                    ToolTip = 'Quantité UC';
                    BlankZero = true;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
                action("&Eclater")
                {
                    Caption = 'Eclater ligne';
                    ToolTip = 'Eclater ligne';
                    Image = Split;

                    trigger OnAction()
                    begin
                        Rec.EclaterLigne();
                        //CurrPage.ContenuUC.PAGE.InitializeSplit();
                    end;
                }
        }
    }



    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."No. UC" := xRec."No. UC";
    end;

    local procedure PackageNoOnAfterValidate()
    begin
        CurrPage.UPDATE(true);
    end;


}

