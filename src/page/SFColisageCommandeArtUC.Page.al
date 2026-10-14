page 50024 "SF colisage commande Art/UC"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'Articles / UC';
    PageType = ListPart;
    SourceTable = "Detail UC Commande";

    layout
    {
        area(content)
        {
            repeater(Control50000)
            {
                ShowCaption = false;
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
                field("Quantite dans UC";Rec."Quantite dans UC")
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
            group("Fonction&s")
            {
                Caption = 'Fonctions';
                Image = "Action";
                action("&Eclater")
                {
                    Caption = 'Eclater ligne';
                    ToolTip = 'Eclater ligne';
                    Image = Split;

                    trigger OnAction()
                    begin
                        
                        //CurrPage.ContenuUC.PAGE.InitializeSplit();
                    end;
                }
                /*
                action("Extraire lignes &commande")
                {
                    Caption = 'Extraire lignes commande';
                    ToolTip = 'Extraire lignes commande';
                    Image = GetLines;

                    trigger OnAction()
                    begin
                        GetSales();
                    end;
                }
                action("Extraire lignes expé&dition")
                {
                    Caption = 'Extraire lignes expédition';
                    ToolTip = 'Extraire lignes expédition';
                    Image = UndoShipment;

                    trigger OnAction()
                    begin
                        GetShipment();
                    end;
                }
                */
                action(Actualiser)
                {
                    Caption = 'Actualiser';
                    ToolTip = 'Actualiser';
                    Image = Refresh;
                    ShortCutKey = 'Ctrl+Alt+F5';

                    trigger OnAction()
                    begin
                        UpdateForm(true);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //Rec.CALCFIELDS("Quantite colisee totale", "Qte expediee");
        //QuantityOnFormat();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."No. UC" := xRec."No. UC";
    end;

    var
        fSplit: Page "Eclater detail UC commande";
        Text0001Err: Label 'La description ne peut pas être modifiée';

    procedure GetShipment()
    begin
        CODEUNIT.RUN(Codeunit::"Packing Management", Rec);
    end;

    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;

    procedure InitializeSplit()
    var
        ContenuColisage: Record "Detail UC Commande";
    begin
        //Rec.TESTFIELD(Type, Rec.Type::Item);
        CLEAR(fSplit);
        /*
        ContenuColisage.RESET();
        ContenuColisage.SETRANGE("No. colisage", Rec."No. colisage");
        ContenuColisage.SETRANGE("Shipment No.", Rec."Shipment No.");
        ContenuColisage.SETRANGE("Shipment Line No.", Rec."Shipment Line No.");
        ContenuColisage.SETRANGE("Order No.", Rec."Order No.");
        ContenuColisage.SETRANGE("Order Line No.", Rec."Order Line No.");

        fSplit.SETTABLEVIEW(ContenuColisage);
        fSplit.RUNMODAL();
        CurrPage.UPDATE();
        */
    end;

    /*
    procedure GetSales()
    var
        PackingManagement: Codeunit "Packing Management";
    begin
        CLEAR(PackingManagement);
        PackingManagement.GetSalesLines(Rec);
    end;
    */

    local procedure PackageNoOnAfterValidate()
    begin
        CurrPage.UPDATE(true);
    end;
    /*
    local procedure QuantityOnFormat()
    begin
        if Rec."Quantite colisee totale" <> Rec."Qte expediee" then;
    end;
    */
}

