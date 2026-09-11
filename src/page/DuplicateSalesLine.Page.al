page 50036 "Duplicate Sales Line"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = Worksheet;
    SourceTable = "Sales Line";
    SourceTableView = sorting("Eco Tax Furniture Line",TypeDocDuplique,NumDocDuplique,"Linked to line") where("Eco Tax Furniture Line" = const(true));

    layout
    {
        area(content)
        {
            field(NombreDuplications; NombreDuplications)
            {
                Caption = 'A dupliquer n fois :';
                ToolTip = 'A dupliquer n fois :';
            }
            repeater(Control1)
            {
                ShowCaption = false;
                field("Duplicate Line"; Rec."Duplicate Line")
                {
                    Caption = 'Dupliquer ligne';
                    ToolTip = 'Dupliquer ligne';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Type';
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'N°';
                    Editable = false;
                }
                field("Item Reference No."; Rec."Item Reference No.")
                {
                    ToolTip = 'N° référence article';
                    Editable = false;
                }

                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                    Editable = false;
                }
                field("Type ligne"; Rec."Type ligne")
                {
                    ToolTip = 'Type ligne';
                    Editable = false;
                }
                field("Type Fiche BE"; Rec."Type Fiche BE")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Type Fiche BE';
                }
                field(Phase; Rec.Phase)
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Phase';
                }
                
                
                field("Location Code"; Rec."Location Code")
                {
                    Caption = 'Code magasin';
                    ToolTip = 'Code magasin';
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Quantité';
                    BlankZero = true;
                    Editable = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Code unité';
                    Editable = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ToolTip = 'Unité';
                    Editable = false;
                    Visible = false;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ToolTip = 'Coût unitaire (DS)';
                    Editable = false;
                    Visible = false;
                }
                field(PriceExists; Rec.PriceExists())
                {
                    ToolTip = 'Prix vente existe';
                    Caption = 'Prix vente existe';
                    Editable = false;
                    Visible = false;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Prix unitaire';
                    BlankZero = true;
                    Editable = false;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ToolTip = '% remise ligne';
                    BlankZero = true;
                    Editable = false;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ToolTip = 'Montant remise ligne';
                    Editable = false;
                    Visible = false;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ToolTip = 'Montant ligne';
                    BlankZero = true;
                    Editable = false;
                }
                field("Eco Tax Furniture Line"; Rec."Eco Tax Furniture Line")
                {
                    ToolTip = 'Ligne taxe éco-mobilier';
                }
            }
        }
    }

    actions
    {
    }


    trigger OnOpenPage()
    begin
        Rec.SETRANGE("Eco Tax Furniture Line", false);
        Rec.SETRANGE("Document Type", DocType);
        Rec.SETRANGE("Document No.", DocNo);
        Rec.SETRANGE("Linked to line", 0);
        Rec.SETRANGE("Eco Tax Furniture Line", false);
        NombreDuplications := 1;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        LignesComposants: Record "Sales Line";
        NewSalesLine: Record "Sales Line";
        NouvelleLigneComposant: Record "Sales Line";
        LineNo: Integer;
        iDuplication: Integer;
        DiaText0001Qst: Label 'Confirmez-vous la duplication des lignes sélectionnées ?';
        DiaText0002Msg: Label 'Action annulée.';

    begin
        if NombreDuplications < 1 then
            exit;

        CurrPage.SAVERECORD();

        if CloseAction = ACTION::LookupOK then begin
            if CONFIRM(DiaText0001Qst) then begin
                LigneADupliquer.RESET();
                LigneADupliquer.SETRANGE("Document Type", Rec."Document Type");
                LigneADupliquer.SETRANGE("Document No.", Rec."Document No.");
                LigneADupliquer.SETRANGE("Duplicate Line", true);
                if LigneADupliquer.FINDSET(false) then begin
                    NewSalesLine.SETRANGE("Document Type", Rec."Document Type");
                    NewSalesLine.SETRANGE("Document No.", Rec."Document No.");
                    NewSalesLine.FINDLAST();
                    LineNo := NewSalesLine."Line No." + 10000;
                    LignesComposants.SETRANGE(Type, LignesComposants.Type::Item);
                    LignesComposants.SETRANGE("Document Type", Rec."Document Type");
                    LignesComposants.SETRANGE("Document No.", Rec."Document No.");
                    for iDuplication := 1 to NombreDuplications do begin
                        LigneADupliquer.FINDFIRST();
                        repeat
                            NewSalesLine.INIT();
                            NewSalesLine."Document Type" := Rec."Document Type";
                            NewSalesLine."Document No." := Rec."Document No.";
                            NewSalesLine."Line No." := LineNo;
                            NewSalesLine.Type := LigneADupliquer.Type;
                            NewSalesLine.VALIDATE("No.", LigneADupliquer."No.");

                            if LigneADupliquer.Quantity <> 0 then
                                NewSalesLine.VALIDATE(Quantity, LigneADupliquer.Quantity);

                            NewSalesLine."Type ligne" := LigneADupliquer."Type ligne";
                            //KAN.FHA 03/12/2025 DEBUT
                            NewSalesLine."Type Fiche BE" := LigneADupliquer."Type Fiche BE";
                            NewSalesLine.Phase := LigneADupliquer.Phase;
                            //KAN.FHA 03/12/2025 FIN
                            if LigneADupliquer."Unit Price" <> 0 then
                                NewSalesLine.VALIDATE("Unit Price", LigneADupliquer."Unit Price");
                            NewSalesLine.INSERT(true);
                            LineNo := LineNo + 10000;

                            NewSalesLine.Description := LigneADupliquer.Description;
                            NewSalesLine."Ligne eclatee" := LigneADupliquer."Ligne eclatee";
                            NewSalesLine.MODIFY();

                            if NewSalesLine."Eco Tax Furniture Code" <> '' then
                                AjouterLigneEcotaxe(NewSalesLine);

                            //FHA.20/02/2020 DEBUT Pour recalcul du montant de la ligne d'EcoTaxe, cette ligne ne peut pas être mise avant
                            NewSalesLine.VALIDATE("Net Weight", LigneADupliquer."Net Weight");
                            NewSalesLine.MODIFY();
                            //FHA.20/02/2020 FIN

                            //FHA 09/01/2020 Les lignes de composants doivent etre copiees aussi s'il y en a
                            LignesComposants.SETRANGE("Linked to line", LigneADupliquer."Line No.");
                            if LignesComposants.FINDSET(false) then
                                repeat
                                    NouvelleLigneComposant.INIT();
                                    NouvelleLigneComposant."Document Type" := Rec."Document Type";
                                    NouvelleLigneComposant."Document No." := Rec."Document No.";
                                    NouvelleLigneComposant."Line No." := LineNo;
                                    NouvelleLigneComposant.Type := LigneADupliquer.Type;
                                    NouvelleLigneComposant.VALIDATE("No.", LignesComposants."No.");

                                    if LignesComposants.Quantity <> 0 then
                                        NouvelleLigneComposant.VALIDATE(Quantity, LignesComposants.Quantity);
                                    //NouvelleLigneComposant.SubTotal := LignesComposants.SubTotal;
                                    NouvelleLigneComposant."Type ligne" := LignesComposants."Type ligne";
                                    //KAN.FHA 05/12/2025 DEBUT
                                    NouvelleLigneComposant."Type Fiche BE" := LignesComposants."Type Fiche BE";
                                    NouvelleLigneComposant.Phase := LignesComposants.Phase;
                                    //KAN.FHA 05/12/2025 FIN
                                    NouvelleLigneComposant.VALIDATE("Unit Price", 0);
                                    NouvelleLigneComposant."Location Code" := LignesComposants."Location Code";
                                    if LignesComposants."Variant Code" <> '' then
                                        NouvelleLigneComposant.VALIDATE("Variant Code", LignesComposants."Variant Code");

                                    NouvelleLigneComposant."Drop Shipment" := LignesComposants."Drop Shipment";
                                    NouvelleLigneComposant.VALIDATE("Shipment Date", LignesComposants."Shipment Date");
                                    NouvelleLigneComposant.Description := LignesComposants.Description;
                                    NouvelleLigneComposant."BOM Item No." := LignesComposants."BOM Item No.";
                                    NouvelleLigneComposant."Prix bloque" := LignesComposants."Prix bloque";
                                    NouvelleLigneComposant."Duplicate Line" := LignesComposants."Duplicate Line";
                                    NouvelleLigneComposant."Linked to line" := NewSalesLine."Line No.";
                                    NouvelleLigneComposant.INSERT(true);

                                    LineNo := LineNo + 10000;

                                    if LignesComposants."Eco Tax Furniture Code" <> '' then
                                        AjouterLigneEcotaxe(NouvelleLigneComposant);
                                until LignesComposants.NEXT() = 0;
                        until LigneADupliquer.NEXT() = 0;
                    end;
                    LigneADupliquer.RESET();
                    LigneADupliquer.SETRANGE("Document Type", Rec."Document Type");
                    LigneADupliquer.SETRANGE("Document No.", Rec."Document No.");
                    LigneADupliquer.MODIFYALL("Duplicate Line", false);

                end;
            end else
                MESSAGE(DiaText0002Msg);
        end else
            MESSAGE(DiaText0002Msg);
    end;

    var
        SalesLine: Record "Sales Line";
        LigneADupliquer: Record "Sales Line";


        DocNo: Code[20];
        DocType: Integer;


        NombreDuplications: Integer;


    procedure SetDatA(PDocNo: Code[20]; PDocType: Integer)
    begin
        DocNo := PDocNo;
        DocType := PDocType;
    end;

    procedure AjouterLigneEcotaxe(pSalesLine: Record "Sales Line")
    var
        EcoTaxSalesLine: Record "Sales Line";
        dCompanySetup: Record "Company Information";
        CurrencyExchRate: Record "Currency Exchange Rate";
        lHeader: Record "Sales Header";

        GlAcc: Record "G/L Account";
        WEEECode: Record "Taxe eco-mobilier";
        NextLineNo: Integer;
        Text001Err: Label 'Posting Setup for WEEE Code %1 not available for Business Posting Group %2.', Comment = '%1 = Code écotaxe ; %2 = Groupe compta. marché';
    //Text002Err: Label 'There is not enough space to insert WEEE line.';
    begin
        NextLineNo := pSalesLine."Line No." + 100;

        lHeader.GET(pSalesLine."Document Type", pSalesLine."Document No.");
        //InitCurrency(lHeader."Currency Code", lHeader."Currency Factor");
        if not WEEECode.GET(pSalesLine."Eco Tax Furniture Code", 0D) then
            ERROR(Text001Err, pSalesLine."Eco Tax Furniture Code", pSalesLine."Gen. Bus. Posting Group");

        GlAcc.GET(WEEECode."Account No.");
        GlAcc.CheckGLAcc();

        if not SalesLine."System-Created Entry" then begin
            GlAcc.TESTFIELD("Direct Posting", true);
            GlAcc.TESTFIELD("Gen. Posting Type", GlAcc."Gen. Posting Type"::Sale);
            GlAcc.TESTFIELD("VAT Bus. Posting Group");
            GlAcc.TESTFIELD("VAT Prod. Posting Group");
        end;

        EcoTaxSalesLine.INIT();

        EcoTaxSalesLine.SetHideValidationDialog(true);

        EcoTaxSalesLine."Document Type" := pSalesLine."Document Type";
        EcoTaxSalesLine."Document No." := pSalesLine."Document No.";
        EcoTaxSalesLine."Line No." := NextLineNo;
        EcoTaxSalesLine.INSERT();
        //EcoTaxSalesLine.VALIDATE("Sell-to Customer No.",SalesLine."Sell-to Customer No.");
        EcoTaxSalesLine.VALIDATE(Type, EcoTaxSalesLine.Type::"G/L Account");
        EcoTaxSalesLine.VALIDATE("No.", WEEECode."Account No.");//
        WEEECode.GET(pSalesLine."Eco Tax Furniture Code");
        EcoTaxSalesLine.Description := STRSUBSTNO('%1 %2', '  ', WEEECode.Description);
        //EcoTaxSalesLine.VALIDATE("Prepayment VAT Identifier",EcoTaxSalesLine."VAT Identifier");
        //EcoTaxSalesLine.VALIDATE("Prepayment VAT %",EcoTaxSalesLine."VAT %");
        //EcoTaxSalesLine."Allow Invoice Disc." := FALSE;
        //EcoTaxSalesLine."Allow Line Disc." := FALSE;
        //EcoTaxSalesLine."Allow Item Charge Assignment" := FALSE;
        EcoTaxSalesLine."Eco Tax Furniture Line" := true;
        EcoTaxSalesLine.VALIDATE(Quantity, pSalesLine."Quantity (Base)");
        EcoTaxSalesLine."Eco Tax Furniture Code" := pSalesLine."Eco Tax Furniture Code";
        EcoTaxSalesLine."Eco Tax Furniture Qty Per" := pSalesLine."Eco Tax Furniture Qty Per";
        EcoTaxSalesLine."Eco Tax Furniture Amount" := WEEECode."Unit Amount";

        dCompanySetup.GET();
        //if dCompanySetup."Ecotax Method" = dCompanySetup."Ecotax Method"::Extra then begin
        if lHeader."Currency Code" <> '' then
            EcoTaxSalesLine.VALIDATE("Unit Price",
              CurrencyExchRate.ExchangeAmtLCYToFCY(
                lHeader."Document Date", lHeader."Currency Code", WEEECode."Unit Amount", lHeader."Currency Factor")
             )
        else
            EcoTaxSalesLine.VALIDATE("Unit Price", WEEECode."Unit Amount" * pSalesLine."Eco Tax Furniture Qty Per");
        EcoTaxSalesLine.VALIDATE("Unit Cost (LCY)", WEEECode."Unit Amount" * pSalesLine."Eco Tax Furniture Qty Per");

        /*FHA
        end else begin
            if lHeader."Currency Code" <> '' then
                EcoTaxSalesLine.VALIDATE("Eco Tax Furniture Amount",
                  CurrencyExchRate.ExchangeAmtLCYToFCY(
                    lHeader."Document Date", lHeader."Currency Code", WEEECode."Unit Amount", lHeader."Currency Factor")
                 )
            else
                EcoTaxSalesLine.VALIDATE("Eco Tax Furniture Amount", WEEECode."Unit Amount");
            EcoTaxSalesLine.VALIDATE("Unit Cost (LCY)", 0);

        end;
        */
        EcoTaxSalesLine."Attached to Line No." := pSalesLine."Line No.";
        EcoTaxSalesLine.MODIFY();
    end;
}

