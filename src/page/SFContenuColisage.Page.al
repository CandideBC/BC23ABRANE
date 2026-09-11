page 50024 "SF Contenu colisage"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'Articles / UC';
    PageType = ListPart;
    SourceTable = "Contenu colisage";

    layout
    {
        area(content)
        {
            repeater(Control50000)
            {
                ShowCaption = false;
                field("Shipment No."; Rec."Shipment No.")
                {
                    ToolTip = 'N° expédition';
                }
                field("Shipment Line No."; Rec."Shipment Line No.")
                {
                    ToolTip = 'N° ligne expédition';
                }
                field("Order No."; Rec."Order No.")
                {
                    ToolTip = 'N° commande';

                    trigger OnValidate()
                    begin
                        //-DNFR7.03 FHA 15/07/2013
                        CurrPage.SAVERECORD();
                        //+DNFR7.03 FHA 15/07/2013
                    end;
                }
                field("Order Line No."; Rec."Order Line No.")
                {
                    ToolTip = 'N° ligne commande';
                }
                field("Attached to Line No."; Rec."Attached to Line No.")
                {
                    ToolTip = 'Attaché à la ligne N°';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Type';
                    Visible = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'N° article';
                }
                
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';

                    trigger OnValidate()
                    begin
                        if (xRec.Description <> Rec.Description) and
                           ((Rec."Item No." <> '') or (Rec."Attached to Line No." <> 0))
                        then
                            ERROR(Text0001Err)
                    end;
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
                field("Qte commandee"; Rec."Qte commandee")
                {
                    ApplicationArea = All;
                    ToolTip = 'Quantité figurant sur la commande.';
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
                field("Quantite UC";Rec."Quantite UC")
                {
                    ToolTip = 'Quantité UC';
                    BlankZero = true;
                }
                
                
                field("Quantite colisee totale";Rec."Quantite colisee totale")
                {
                    ToolTip = 'Quantité colisée totale';
                    BlankZero = true;
                    //Visible = false;
                }
                field("Qte expediee"; Rec."Qte expediee")
                {
                    ToolTip = 'Quantité expédiée';
                    BlankZero = true;
                    Visible = false;
                }
                field("Poids net unitaire"; Rec."Poids net unitaire")
                {
                    ToolTip = 'Poids net article';
                }
                field("Poids net ligne"; Rec."Poids net ligne")
                {
                    ToolTip = 'Poids net';
                    BlankZero = true;
                }
                field("Poids brut unitaire"; Rec."Poids brut unitaire")
                {
                    ApplicationArea = All;
                    ToolTip = 'Poids brut unitaire (calculé).';
                }

                field("Poids brut ligne"; Rec."Poids brut ligne")
                {
                    ToolTip = 'Poids brut ligne';
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
        Rec.CALCFIELDS("Quantite colisee totale", "Qte expediee");
        QuantityOnFormat();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."No. UC" := xRec."No. UC";
    end;

    var
        fSplit: Page "Eclater contenu colisage";
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
        ContenuColisage: Record "Contenu colisage";
    begin
        Rec.TESTFIELD(Type, Rec.Type::Item);
        CLEAR(fSplit);
        ContenuColisage.RESET();
        ContenuColisage.SETRANGE("No. colisage", Rec."No. colisage");
        ContenuColisage.SETRANGE("Shipment No.", Rec."Shipment No.");
        ContenuColisage.SETRANGE("Shipment Line No.", Rec."Shipment Line No.");
        ContenuColisage.SETRANGE("Order No.", Rec."Order No.");
        ContenuColisage.SETRANGE("Order Line No.", Rec."Order Line No.");

        fSplit.SETTABLEVIEW(ContenuColisage);
        fSplit.RUNMODAL();
        CurrPage.UPDATE();
    end;

    procedure GetSales()
    var
        PackingManagement: Codeunit "Packing Management";
    begin
        CLEAR(PackingManagement);
        PackingManagement.GetSalesLines(Rec);
    end;

    local procedure PackageNoOnAfterValidate()
    begin
        CurrPage.UPDATE(true);
    end;

    local procedure QuantityOnFormat()
    begin
        if Rec."Quantite colisee totale" <> Rec."Qte expediee" then;
    end;
}

