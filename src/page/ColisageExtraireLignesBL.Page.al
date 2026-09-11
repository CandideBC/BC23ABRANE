page 50028 "Colisage : extraire lignes BL"
{
    //  Exclure les composants liés
    ApplicationArea = All;
    UsageCategory = None;
    Caption = 'Colisage : Extraire lignes BL';
    Editable = false;
    PageType = List;
    SourceTable = "Sales Shipment Line";
    SourceTableView = where (Correction = const (false), Type = const (Item), "Linked to line"=const(0));

    layout
    {
        area(content)
        {
            repeater(Control50000)
            {
                ShowCaption = false;
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'N° document';
                    HideValue = "Document No.HideValue";
                }
                field("Order No."; Rec."Order No.")
                {
                    ToolTip = 'N° commande';               
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ToolTip = 'N° client facturé';                
                    Visible = true;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'N° donneur d''ordre';                
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Type';                
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'N°';                
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ToolTip = 'Code variante';                
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';                
                }
                field("Description 2"; Rec."Description 2")
                {
                    ToolTip = 'Description 2';                
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Code devise';                
                    DrillDown = false;
                    Lookup = false;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    ToolTip = 'Axe 1';                
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    ToolTip = 'Axe 2';                
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Code magasin';                
                    Visible = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Code unité';                
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Quantité';                
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ToolTip = 'Unité';                
                    Visible = false;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    ToolTip = 'Ecriture article à lettrer';                
                    Visible = false;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ToolTip = 'Date de préparation';                
                    Visible = false;
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    ToolTip = 'Quantité facturée';                
                }
                field("Qty. Shipped Not Invoiced"; Rec."Qty. Shipped Not Invoiced")
                {
                    ToolTip = 'Qté livrée non facturée';                
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Afficher document")
            {
                Caption = 'Afficher document';
                ToolTip = 'Afficher document';
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Shift+F7';

                trigger OnAction()
                begin
                    SalesShptHeader.GET(Rec."Document No.");
                    PAGE.RUN(PAGE::"Posted Sales Shipment", SalesShptHeader);
                end;
            }
            action("&Ecritures traçabilité")
            {
                Caption = 'Ecritures traçabilité';
                ToolTip = 'Ecritures traçabilité';
                Image = ItemTrackingLedger;

                trigger OnAction()
                begin
                    Rec.ShowItemTrackingLines();
                end;
            }
        }
        area(processing)
        {
            action("Filtre &quantité")
            {
                Caption = 'Filtre quantité';
                ToolTip = 'Filtre quantité';
                Image = "Filter";
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Rec.GETFILTER(Quantity) <> '' then
                        Rec.SETRANGE(Quantity)
                    else
                        Rec.SETFILTER(Quantity, '<>0');
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        "Document No.HideValue" := false;
        DocumentNoOnFormat();
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        //-DNFR7.03 FHA 11/07/2013
        if CloseAction in [ACTION::OK, ACTION::LookupOK] then
            CreateLines();
        //+DNFR7.03 FHA 11/07/2013
    end;

    var
        SalesShptHeader: Record "Sales Shipment Header";
        EnteteColisage: Record "Entete colisage";
        TempSalesShptLine: Record "Sales Shipment Line" temporary;
        PackingMgt: Codeunit "Packing Management";
        
        "Document No.HideValue": Boolean;
        
        "Document No.Emphasize": Boolean;

    procedure SetSalesHeader(var EnteteColisage2: Record "Entete colisage")
    begin
        EnteteColisage.GET(EnteteColisage2."No.");
    end;

    local procedure IsFirstDocLine(): Boolean
    var
        SalesShptLine: Record "Sales Shipment Line";
    begin
        TempSalesShptLine.RESET();
        TempSalesShptLine.COPYFILTERS(Rec);
        TempSalesShptLine.SETRANGE("Document No.",Rec."Document No.");
        if not TempSalesShptLine.FIND('-') then begin
            SalesShptLine.COPYFILTERS(Rec);
            SalesShptLine.SETRANGE("Document No.",Rec."Document No.");
            SalesShptLine.FindFirst();
            TempSalesShptLine := SalesShptLine;
            TempSalesShptLine.INSERT();
        end;
        if Rec."Line No." = TempSalesShptLine."Line No." then
            exit(true);
    end;

    local procedure DocumentNoOnFormat()
    begin
        if IsFirstDocLine() then
            "Document No.Emphasize" := true
        else
            "Document No.HideValue" := true;
    end;

    procedure CreateLines()
    begin
        CurrPage.SETSELECTIONFILTER(Rec);
        PackingMgt.SetSalesHeader(EnteteColisage);
        PackingMgt.CreateLinesFromShpt(Rec);
    end;
}

