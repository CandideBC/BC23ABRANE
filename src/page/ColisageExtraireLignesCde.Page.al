page 50027 "Colisage : extraire lignes cde"
{
    ApplicationArea = All;
    Caption = 'Colisage : extraire lignes commande';
    Editable = false;
    PageType = List;
    SourceTable = "Sales Line";
    SourceTableView = where (Type = const (Item), "Linked to line"=const(0));

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
                    ToolTip = 'Axe 1';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Axe 2';
                    Visible = false;
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
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                    ToolTip = 'Quantité restante';
                }
                field("Qty. to Ship"; Rec."Qty. to Ship")
                {
                    ToolTip = 'Qté. à expédier';
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    ToolTip = 'Quantité facturée';
                }
                field("Qty. Shipped Not Invoiced"; Rec."Qty. Shipped Not Invoiced")
                {
                    ToolTip = 'Qté. livrée non facturée';
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
                    SalesOrderHeader.GET(Rec."Document Type", Rec."Document No.");
                    PAGE.RUN(PAGE::"Sales Order", SalesOrderHeader);
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
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Rec.GETFILTER("Outstanding Quantity") <> '' then
                        Rec.SETRANGE("Outstanding Quantity")
                    else
                        Rec.SETFILTER("Outstanding Quantity", '<>0');
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
        SalesOrderHeader: Record "Sales Header";
        EnteteColisage: Record "Entete colisage";
        TempSalesLine: Record "Sales Line" temporary;
        PackingMgt: Codeunit "Packing Management";
        
        "Document No.HideValue": Boolean;
        
        "Document No.Emphasize": Boolean;

    procedure SetSalesHeader(var EnteteColisage2: Record "Entete colisage")
    begin
        EnteteColisage.GET(EnteteColisage2."No.");
    end;

    local procedure IsFirstDocLine(): Boolean
    var
        SalesLine: Record "Sales Line";
    begin
        TempSalesLine.RESET();
        TempSalesLine.COPYFILTERS(Rec);
        TempSalesLine.SETRANGE("Document No.", Rec."Document No.");
        if not TempSalesLine.FIND('-') then begin
            SalesLine.COPYFILTERS(Rec);
            SalesLine.SETRANGE("Document Type", Rec."Document Type");
            SalesLine.SETRANGE("Document No.", Rec."Document No.");
            SalesLine.FIND('-');
            TempSalesLine := SalesLine;
            TempSalesLine.INSERT();
        end;
        if Rec."Line No." = TempSalesLine."Line No." then
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
        PackingMgt.CreateLinesFromOrder(Rec);
    end;
}

