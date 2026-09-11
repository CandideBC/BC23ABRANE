codeunit 50000 "Gestion Ecopart"
{
    
    trigger OnRun()
    begin
    end;

    var
        dCompanySetup: Record "Company Information";
        Currency: Record Currency;
        CurrencyExchRate: Record "Currency Exchange Rate";

        CurrencyCode: Code[10];
        MakeUpdateRequired: Boolean;

    procedure InitCurrency(pCurrencyCode: Code[10]; pCurrencyFactor: Decimal)
    begin
        CurrencyCode := pCurrencyCode;
        if CurrencyCode = '' then
            Currency.InitRoundingPrecision()
        else
            Currency.Get(CurrencyCode);
        /*Migration FHA Inutilisées ?
        UnitAmountRoundPrecision := Currency."Unit-Amount Rounding Precision";
        AmountRoundPrecision := Currency."Amount Rounding Precision";
        CurrencyFactor := pCurrencyFactor;
        */
    end;

    procedure SalesCheckIfAnyWEEE(var SalesLine: Record "Sales Line"): Boolean
    var
        SalesHeader: Record "Sales Header";
    begin
        MakeUpdateRequired := false;
        if SalesLine."Line No." <> 0 then
            MakeUpdateRequired := DeleteWEEELine(SalesLine);

        SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.");
        if not SalesHeader."Eco Tax Furniture Liable" then
            exit(false);
        if (SalesLine.Type = SalesLine.Type::Item) and (SalesLine."Eco Tax Furniture Code" <> '') then
            exit(true)
        else
            exit(false);
    end;

    procedure DeleteWEEELine(pSalesLine: Record "Sales Line"): Boolean
    var
        lSalesLineWEEE: Record "Sales Line";
    begin
        lSalesLineWEEE.Reset();
        lSalesLineWEEE.SetRange("Document Type", pSalesLine."Document Type");
        lSalesLineWEEE.SetRange("Document No.", pSalesLine."Document No.");
        lSalesLineWEEE.SetRange("Attached to Line No.", pSalesLine."Line No.");
        lSalesLineWEEE.SetRange("Eco Tax Furniture Line", true);
        if not lSalesLineWEEE.IsEmpty then begin
            lSalesLineWEEE.DeleteAll(true);
            exit(true);
        end;
    end;

    procedure InsertWEEELine(var SalesLine: Record "Sales Line")
    var
        lHeader: Record "Sales Header";
        ToSalesLine: Record "Sales Line";

        GlAcc: Record "G/L Account";
        WEEECode: Record "Taxe eco-mobilier";
        NextLineNo: Integer;
        LineSpacing: Integer;
        Text001Err: Label 'Les paramètres de comptabilisation du code  %1 ne sont pas disponibles pour le groupe %2.', Comment = '%1 = Code taxe ; %2 = Groupe';
        Text002Err: Label 'Impossible d''insérer une nouvelle ligne';
    begin
        Commit();
        ToSalesLine.Reset();
        ToSalesLine.SetRange("Document Type", SalesLine."Document Type");
        ToSalesLine.SetRange("Document No.", SalesLine."Document No.");
        ToSalesLine := SalesLine;
        if ToSalesLine.Find('>') then begin
            LineSpacing :=
              (ToSalesLine."Line No." - SalesLine."Line No.") div 2;
            if LineSpacing = 0 then
                Error(Text002Err);
        end else
            LineSpacing := 5;
        NextLineNo := SalesLine."Line No." + LineSpacing;
        lHeader.Get(SalesLine."Document Type", SalesLine."Document No.");
        InitCurrency(lHeader."Currency Code", lHeader."Currency Factor");
        if not WEEECode.Get(SalesLine."Eco Tax Furniture Code", 0D) then
            Error(Text001Err, SalesLine."Eco Tax Furniture Code", SalesLine."Gen. Bus. Posting Group");

        GlAcc.Get(WEEECode."Account No.");
        GlAcc.CheckGLAcc();

        if not SalesLine."System-Created Entry" then begin
            GlAcc.TestField("Direct Posting", true);
            GlAcc.TestField("Gen. Posting Type", GlAcc."Gen. Posting Type"::Sale);
            GlAcc.TestField("VAT Bus. Posting Group");
            GlAcc.TestField("VAT Prod. Posting Group");
        end;

        ToSalesLine.SetRange("Eco Tax Furniture Line");
        ToSalesLine.Init();

        ToSalesLine.SetHideValidationDialog(true);

        ToSalesLine."Document Type" := SalesLine."Document Type";
        ToSalesLine."Document No." := SalesLine."Document No.";
        ToSalesLine."Line No." := NextLineNo;
        ToSalesLine.Insert();
        ToSalesLine.Validate("Sell-to Customer No.", SalesLine."Sell-to Customer No.");
        ToSalesLine.Validate(Type, ToSalesLine.Type::"G/L Account");
        ToSalesLine.Validate("No.", WEEECode."Account No.");//
        WEEECode.Get(SalesLine."Eco Tax Furniture Code");
        ToSalesLine.Description := StrSubstNo('%1 %2', '  ', WEEECode.Description);
        ToSalesLine.Validate("Prepayment VAT Identifier", ToSalesLine."VAT Identifier");
        ToSalesLine.Validate("Prepayment VAT %", ToSalesLine."VAT %");
        ToSalesLine."Allow Invoice Disc." := false;
        ToSalesLine."Allow Line Disc." := false;
        ToSalesLine."Allow Item Charge Assignment" := false;
        ToSalesLine."Eco Tax Furniture Line" := true;
        ToSalesLine.Validate(Quantity, SalesLine."Quantity (Base)");
        ToSalesLine."Eco Tax Furniture Code" := SalesLine."Eco Tax Furniture Code";
        ToSalesLine."Eco Tax Furniture Qty Per" := SalesLine."Eco Tax Furniture Qty Per";
        ToSalesLine."Eco Tax Furniture Amount" := WEEECode."Unit Amount";
        //KAN.FHA 30/01/2026 DEBUT
        ToSalesLine.Phase := SalesLine.Phase;
        //KAN.FHA 30/01/2026 FIN

        dCompanySetup.Get();
        if lHeader."Currency Code" <> '' then
            ToSalesLine.Validate("Unit Price",
              CurrencyExchRate.ExchangeAmtLCYToFCY(
                lHeader."Document Date", lHeader."Currency Code", WEEECode."Unit Amount", lHeader."Currency Factor")
             )
        else
            ToSalesLine.Validate("Unit Price", WEEECode."Unit Amount" * SalesLine."Eco Tax Furniture Qty Per");
        ToSalesLine.Validate("Unit Cost (LCY)", WEEECode."Unit Amount" * SalesLine."Eco Tax Furniture Qty Per");

        /*
        end else begin
            if lHeader."Currency Code" <> '' then
                ToSalesLine.Validate("Eco Tax Furniture Amount",
                  CurrencyExchRate.ExchangeAmtLCYToFCY(
                    lHeader."Document Date", lHeader."Currency Code", WEEECode."Unit Amount", lHeader."Currency Factor")
                 )
            else
                ToSalesLine.Validate("Eco Tax Furniture Amount", WEEECode."Unit Amount");
            ToSalesLine.Validate("Unit Cost (LCY)", 0);

        end;
        */
        ToSalesLine."Attached to Line No." := SalesLine."Line No.";

        ToSalesLine.Modify();
        MakeUpdateRequired := true;
    end;

    procedure MakeUpdate(): Boolean
    begin
        exit(MakeUpdateRequired);
    end;

    procedure PurchCheckIfAnyWEEE(var PurchLine: Record "Purchase Line"): Boolean
    var


    begin


    end;

    procedure PurchDeleteWEEELine(pPurchLine: Record "Purchase Line"): Boolean
    var

    begin


    end;

    procedure PurchUpdateWEEE(pPurchLine: Record "Purchase Line"; CurrFieldNo: Integer)
    var

    begin

    end;

    procedure SalesUpdateWEEE(pSalesLine: Record "Sales Line"; CurrFieldNo: Integer)
    var
        lSalesLineWEEE: Record "Sales Line";
    begin
        if (pSalesLine.Type = pSalesLine.Type::Item) and (pSalesLine."Eco Tax Furniture Code" <> '') then begin
            lSalesLineWEEE.SetCurrentKey("Document Type", "Document No.", "Eco Tax Furniture Line");
            lSalesLineWEEE.SetRange("Document Type", pSalesLine."Document Type");
            lSalesLineWEEE.SetRange("Document No.", pSalesLine."Document No.");
            lSalesLineWEEE.SetRange("Attached to Line No.", pSalesLine."Line No.");
            lSalesLineWEEE.SetRange("Eco Tax Furniture Line", true);
            if lSalesLineWEEE.FindSet(true) then begin
                if CurrFieldNo = pSalesLine.FieldNo(Quantity) then begin
                    lSalesLineWEEE.Validate(Quantity, pSalesLine."Quantity (Base)");// * "Eco Tax Furniture Qty Per");
                    lSalesLineWEEE.Modify();
                end;
                if CurrFieldNo = pSalesLine.FieldNo("Qty. to Invoice") then begin
                    lSalesLineWEEE.Validate("Qty. to Invoice", pSalesLine."Qty. to Invoice (Base)");// * "Eco Tax Furniture Qty Per");
                    lSalesLineWEEE.Modify();
                end;
                if CurrFieldNo = pSalesLine.FieldNo("Qty. to Ship") then begin
                    //la qté à livrer peut être décencher par UpdatewarehouseShip avant que la qté cdée soit renseignée
                    //        lSalesLineWEEE.VALIDATE(Quantity , "Quantity (Base)" * "Eco Tax Furniture Qty Per");
                    //-DIA£YCH 07/06/2018 Ne pas mettre à jour la quantité cdée de la ligne . abrance n'utilise pas de doc entreprot
                    //SInon il faut reouvrir la commande
                    //KAN.FHA 30/01/2026 DEBUT
                    //A REMETTRE SI SOUCI :
                    // lSalesLineWEEE.Validate(Quantity, pSalesLine."Quantity (Base)");// * "Eco Tax Furniture Qty Per");
                                                                                    //+DIA£YCH 07/06/2018 Ne pas mettre à jour la qté cdée de la ligne
                    //KAN.FHA 30/01/2026 FIN                                                                                
                    lSalesLineWEEE.Validate("Qty. to Ship", pSalesLine."Qty. to Ship (Base)");// * "Eco Tax Furniture Qty Per");
                    lSalesLineWEEE.Modify();
                end;
                if CurrFieldNo = pSalesLine.FieldNo(pSalesLine."Return Qty. to Receive") then begin
                    lSalesLineWEEE.Validate(Quantity, pSalesLine."Return Qty. to Receive (Base)");

                    lSalesLineWEEE.Validate("Return Qty. to Receive", pSalesLine."Return Qty. to Receive (Base)");// * "Eco Tax Furniture Qty Per");
                    lSalesLineWEEE.Modify();
                end;
                //KAN.FHA 30/01/2026 DEBUT
                if CurrFieldNo = pSalesLine.FieldNo(Phase) then begin
                    lSalesLineWEEE.Phase := pSalesLine.Phase;
                    lSalesLineWEEE.Modify();
                end;
                //KAN.FHA 30/01/2026 FIN
            end;
        end;
    end;
}

