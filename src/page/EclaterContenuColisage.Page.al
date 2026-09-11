page 50025 "Eclater contenu colisage"
{
    ApplicationArea = All;
    UsageCategory = None;
    Caption = 'Eclater contenu colisage';
    DataCaptionFields = "No. colisage", "No. ligne";
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Contenu colisage";
    SourceTableView = sorting ("No. colisage", "No. ligne")
                      order(ascending)
                      where (Type = const (Item));

    layout
    {
        area(content)
        {
            repeater(Control8056003)
            {
                ShowCaption = false;
                field(Type; Rec.Type)
                {
                    ToolTip = 'Type';
                    Editable = false;
                    Visible = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'N° article';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                    Editable = false;

                    trigger OnValidate()
                    begin
                        if (xRec.Description <> Rec.Description) and
                           ((Rec."Item No." <> '') or (Rec."Attached to Line No." <> 0))
                        then
                            Error(Text0001Err)
                    end;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ToolTip = 'Description 2';
                    Editable = false;
                }
                field("Designation article";Rec."Designation article")
                {
                    ToolTip = 'Désignation article';
                    Editable = false;
                    Visible = false;
                }
                /*
                field("Cross-Reference No."; Rec."Cross-Reference No.")
                {
                    ToolTip = 'N° référence externe';
                    Editable = false;
                    Visible = false;
                }
                */
                field("Shipment No."; Rec."Shipment No.")
                {
                    ToolTip = 'N° BL';
                    Editable = false;
                }
                field("Shipment Line No."; Rec."Shipment Line No.")
                {
                    ToolTip = 'N° Ligne BL';
                    Editable = false;
                }
                field("No. ligne"; Rec."No. ligne")
                {
                    ToolTip = 'N° ligne';
                    Editable = false;
                }
                field("Attached to Line No."; Rec."Attached to Line No.")
                {
                    ToolTip = 'Attaché à la ligne N°';
                    Editable = false;
                    Visible = false;
                }
                field("Package No."; Rec."No. UC")
                {
                    ToolTip = 'N° UC';
                }

                field("Quantite UC"; Rec."Quantite UC")
                {
                    ToolTip = 'Quantité';
                    BlankZero = true;
                    Editable = true;
                    Style = Strong;
                    StyleExpr = true;

                    trigger OnValidate()
                    begin
                        QuantityOnAfterValidate();
                    end;
                }
                field("Quantite colisee totale";Rec."Quantite colisee totale")
                {
                    ToolTip = 'Quantité colisée totale';
                    BlankZero = true;
                    Visible = true;
                }
                field("Qte expediee"; Rec."Qte expediee")
                {
                    ToolTip = 'Quantité expédiée';
                    BlankZero = true;
                    Editable = false;
                    Visible = true;
                }
                field("Poids brut ligne";Rec."Poids brut ligne")
                {
                    ToolTip = 'Poids brut';
                    BlankZero = true;
                }
                field("Poids net ligne";Rec."Poids net ligne")
                {
                    ToolTip = 'Poids net';
                    BlankZero = true;
                }



            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Quantite colisee totale", "Qte expediee");
        //QuantityOnFormat();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        ContenuColisage.Reset();
        // recup 1ère ligne
        ContenuColisage.SetRange("No. colisage", Rec."No. colisage");
        ContenuColisage.SetRange("Shipment No.", Rec."Shipment No.");
        ContenuColisage.SetRange("Shipment Line No.", Rec."Shipment Line No.");
        ContenuColisage.SetRange("Order No.", Rec."Order No.");
        ContenuColisage.SetRange("Order Line No.", Rec."Order Line No.");
        ContenuColisage.SetRange(Type, Rec.Type);
        ContenuColisage.SetRange("Item No.", Rec."Item No.");
        if ContenuColisage.Find('-') then begin
            ContenuColisageLiee.Reset();
            ContenuColisageLiee.SetRange("No. colisage", ContenuColisage."No. colisage");
            // recup n° ligne
            ContenuColisageLiee.SetRange("Attached to Line No.", ContenuColisage."No. ligne");
            NumRec := Rec."No. ligne";
            if ContenuColisageLiee.FindSet() then
                repeat
                    //copier la ligne
                    ContenuColisageNew.Init();
                    ContenuColisageNew.TransferFields(ContenuColisageLiee);
                    ContenuColisageNew."No. ligne" := NumRec + 1000;
                    NumRec := ContenuColisageNew."No. ligne";
                    ContenuColisageNew."Attached to Line No." := Rec."No. ligne";
                    ContenuColisageNew."No. UC" := Rec."No. UC";
                    ContenuColisageNew.Insert(true);
                until ContenuColisageLiee.Next() = 0;
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Item No." := xRec."Item No.";
        Rec.Description := xRec.Description;
        //Rec."Cross-Reference No." := xRec."Cross-Reference No.";
        Rec."No. UC" := '';
        Rec."Quantite UC" := xRec."Qte expediee" - xRec."Quantite colisee totale";
        if Rec."Quantite UC" < 0 then
            Rec."Quantite UC" := 0;
        Rec."Shipment No." := xRec."Shipment No.";
        Rec."Shipment Line No." := xRec."Shipment Line No.";
        Rec."Order No." := xRec."Order No.";
        Rec."Order Line No." := xRec."Order Line No.";
        Rec.Type := xRec.Type;
        Rec."Description 2" := xRec."Description 2";
        Rec."Designation article" := xRec."Designation article";
        Rec."Attached to Line No." := 0;
        //Rec."Quantite colisee totale" := 0;
        //Rec."Qte expediee" := xRec."Qte expediee";
        Rec."Poids net unitaire" := xRec."Poids net unitaire";
        Rec."No. ligne" := InsertLineNo(xRec);
        Rec.CalcFields("Quantite colisee totale", "Qte expediee");
    end;

    var
        ContenuColisage: Record "Contenu colisage";
        ContenuColisageNew: Record "Contenu colisage";
        ContenuColisageLiee: Record "Contenu colisage";
        NumRec: Decimal;
        Text0001Err: Label 'Description can''t be modified';

    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.Update(SetSaveRecord);
    end;

    procedure Initialize()
    begin
        Rec.SetRange("Shipment No.", Rec."Shipment No.");
        Rec.SetRange("Shipment Line No.", Rec."Shipment Line No.");
        Rec.SetRange("Order No.", Rec."Order No.");
        Rec.SetRange("Order Line No.", Rec."Order Line No.");
    end;

    /*
    procedure GetLastLineNo(pRec: Record "Contenu colisage"): Decimal
    var
        lContenuColisage: Record "Contenu colisage";
    begin
        lContenuColisage.Reset();
        lContenuColisage.SetRange("No. colisage", pRec."No. colisage");
        if lContenuColisage.FindLast() then
            exit(lContenuColisage."No. ligne" + 10000)
        else
            exit(10000);
    end;
    */

    procedure InsertLineNo(pRec: Record "Contenu colisage"): Decimal
    var
        lContenuColisage: Record "Contenu colisage";
        Num: Decimal;
    begin
        lContenuColisage.Reset();
        lContenuColisage.SetRange("No. colisage", pRec."No. colisage");
        lContenuColisage.SetFilter("No. ligne", '>%1', pRec."No. ligne");
        if lContenuColisage.FindFirst() then begin
            Num := Round((lContenuColisage."No. ligne" - pRec."No. ligne") / 2, 1);
            exit(pRec."No. ligne" + Num);
        end else begin
            lContenuColisage.SetRange("No. ligne");
            if lContenuColisage.FindLast() then
                exit(lContenuColisage."No. ligne" + 10000)
            else
                exit(10000);
        end;
    end;

    procedure InsertNewLine()
    var
        lContenuColisage: Record "Contenu colisage";
    begin
        Rec.CalcFields("Quantite colisee totale", "Qte expediee");
        if Rec."Qte expediee" - Rec."Quantite colisee totale" > 0 then begin
            lContenuColisage."Item No." := Rec."Item No.";
            lContenuColisage.Description := Rec.Description;
            //lContenuColisage."Cross-Reference No." := Rec."Cross-Reference No.";
            lContenuColisage."No. UC" := '';
            lContenuColisage."Quantite UC" := Rec."Qte expediee" - Rec."Quantite colisee totale";
            lContenuColisage."Shipment No." := Rec."Shipment No.";
            lContenuColisage."Shipment Line No." := Rec."Shipment Line No.";
            lContenuColisage."Order No." := Rec."Order No.";
            lContenuColisage."Order Line No." := Rec."Order Line No.";
            lContenuColisage.Type := Rec.Type;
            lContenuColisage."Description 2" := Rec."Description 2";
            lContenuColisage."Designation article" := Rec."Designation article";
            lContenuColisage."Attached to Line No." := 0;
            //lContenuColisage."Quantite colisee totale" := 0;
            //lContenuColisage."Qte expediee" := Rec."Qte expediee";
            lContenuColisage."No. colisage" := Rec."No. colisage";
            lContenuColisage."No. ligne" := InsertLineNo(Rec);

            lContenuColisage.Insert(true);

            CurrPage.Update();
        end;
    end;

    local procedure QuantityOnAfterValidate()
    begin
        CurrPage.Update();
        InsertNewLine();
    end;

    /*
    local procedure QuantityOnFormat()
    begin
        if Rec."Assigned Qty." <> Rec."Qte expediee" then;
    end;
    */
}

