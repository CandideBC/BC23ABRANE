table 50009 "Eco Tax Furniture posted"
{

    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'N° de ligne';
        }
        field(2; "Document Type"; Option)
        {
            Caption = 'Type de document';
            OptionCaption = 'Invoice, Credit Memo';
            OptionMembers = Invoice," Credit Memo";
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'N° de document';
        }
        field(4; "Eco Tax Furniture Code"; Code[20])
        {
            Caption = 'Code taxe éco mobilier';
        }
        field(5; Quantity; Decimal)
        {
            Caption = 'Quantité';
        }
        field(6; "Unit Tax Amount"; Decimal)
        {
            Caption = 'Montant unitaire taxe';
        }
        field(7; "Net Weight"; Decimal)
        {
            Caption = 'Poids net';
        }
        field(8; "Tax Amount"; Decimal)
        {
            Caption = 'Montant de la taxe';
            DecimalPlaces = 2 : 4;
        }
        field(9; "Family tax"; Text[50])
        {
            Caption = 'Famille taxe';
        }
        field(10; "Sub Family Tax"; Text[50])
        {
            Caption = 'Sous famille taxe';
        }
        field(100; "Date Debut"; Date)
        {
        }
        field(110; "Date fin"; Date)
        {
        }
        field(111; "Code matiere"; Code[20])
        {
            Caption = 'Code matière';
        }
        field(112; "Item No"; Code[20])
        {
            Caption = 'Item No';
        }
        field(113; "Product Code"; Code[10])
        {
            Caption = 'Product Code';
        }
        field(120; Description; Text[100])
        {
            Description = 'KAN.FHA 28/10/2020';
        }
        field(130; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
            Description = 'KAN.FHA 08/04/2021';
        }
        field(140; "Salesperson Code"; Code[20])
        {
            Caption = 'Code vendeur';
            Description = 'KAN.FHA 08/04/2021';
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        recSalesInvoiceLine: Record "Sales Invoice Line";
        recCrMemoLine: Record "Sales Cr.Memo Line";
        Item: Record Item;
        recSalesInvoiceLine2: Record "Sales Invoice Line";
        recCrMemoLine2: Record "Sales Cr.Memo Line";
        EnteteFacture: Record "Sales Invoice Header";
        EnteteAvoir: Record "Sales Cr.Memo Header";

    procedure UpdateBoard(DateFilterDebut: Date; DateFilterFin: Date)
    begin
        Init();
        DeleteAll();
        "Date Debut" := DateFilterDebut;
        "Date fin" := DateFilterFin;

        "Line No." := 0;

        // Traitement des factures vente
        recSalesInvoiceLine.SetFilter("Posting Date", '%1..%2', DateFilterDebut, DateFilterFin);
        recSalesInvoiceLine.SetRange("Eco Tax Furniture Line", true);
        recSalesInvoiceLine.SetFilter(Quantity, '<>%1', 0);
        if recSalesInvoiceLine.FindSet() then
            repeat
                "Code matiere" := '';
                "Item No" := '';
                "Product Code" := '';
                "Line No." := "Line No." + 10000;
                "Document Type" := 0;
                "Document No." := recSalesInvoiceLine."Document No.";
                //KAN.FHA 08/04/2021 DEBUT
                "Document Line No." := recSalesInvoiceLine."Line No.";
                EnteteFacture.Get(recSalesInvoiceLine."Document No.");
                "Salesperson Code" := EnteteFacture."Salesperson Code";
                //KAN.FHA 08/04/2021 FIN
                "Eco Tax Furniture Code" := recSalesInvoiceLine."Eco Tax Furniture Code";
                Quantity := recSalesInvoiceLine.Quantity;
                "Unit Tax Amount" := recSalesInvoiceLine."Eco Tax Furniture Amount";
                "Net Weight" := recSalesInvoiceLine."Eco Tax Furniture Qty Per";
                "Tax Amount" := recSalesInvoiceLine.Amount;
                recSalesInvoiceLine.CalcFields("Eco Tax Furniture Family", "Eco Tax Furniture Sub Family");
                "Family tax" := recSalesInvoiceLine."Eco Tax Furniture Family";
                "Sub Family Tax" := recSalesInvoiceLine."Eco Tax Furniture Sub Family";

                if recSalesInvoiceLine2.Get(recSalesInvoiceLine."Document No.", recSalesInvoiceLine."Attached to Line No.") then begin
                    "Item No" := recSalesInvoiceLine2."No.";
                    if Item.Get(recSalesInvoiceLine2."No.") then begin
                        "Code matiere" := Item."Code matiere";
                        "Product Code" := PadStr(Item."Tariff No.", 6);
                    end;
                end;
                //KAN.FHA 28/10/2020 DEBUT
                Description := recSalesInvoiceLine2.Description;
                //KAN.FHA 28/10/2020 FIN
                Insert();
            until recSalesInvoiceLine.Next() = 0;

        // Traitement des avoirs vente
        recCrMemoLine.SetFilter("Posting Date", '%1..%2', DateFilterDebut, DateFilterFin);
        recCrMemoLine.SetRange("Eco Tax Furniture Line", true);
        recCrMemoLine.SetFilter(Quantity, '<>%1', 0);
        if recCrMemoLine.FindSet() then
            repeat
                "Code matiere" := '';
                "Item No" := '';
                "Product Code" := '';
                "Line No." := "Line No." + 10000;
                "Document Type" := 1;
                "Document No." := recCrMemoLine."Document No.";
                //KAN.FHA 08/04/2021 DEBUT
                "Document Line No." := recCrMemoLine."Line No.";
                EnteteAvoir.Get(recCrMemoLine."Document No.");
                "Salesperson Code" := EnteteAvoir."Salesperson Code";
                //KAN.FHA 08/04/2021 FIN
                "Eco Tax Furniture Code" := recCrMemoLine."Eco Tax Furniture Code";
                Quantity := -1 * recCrMemoLine.Quantity;
                "Unit Tax Amount" := recCrMemoLine."Eco Tax Furniture Amount";
                "Net Weight" := recCrMemoLine."Eco Tax Furniture Qty Per";
                "Tax Amount" := recCrMemoLine.Amount * -1;
                recCrMemoLine.CalcFields("Eco Tax Furniture Family", "Eco Tax Furniture Sub Family");
                "Family tax" := recCrMemoLine."Eco Tax Furniture Family";
                "Sub Family Tax" := recCrMemoLine."Eco Tax Furniture Sub Family";
                if recCrMemoLine2.Get(recCrMemoLine."Document No.", recCrMemoLine."Attached to Line No.") then begin
                    "Item No" := recCrMemoLine2."No.";
                    if Item.Get(recCrMemoLine2."No.") then begin
                        "Code matiere" := Item."Code matiere";
                        "Product Code" := PadStr(Item."Tariff No.", 6)
                    end;
                end;
                //KAN.FHA 28/10/2020 DEBUT
                Description := recCrMemoLine2.Description;
                //KAN.FHA 28/10/2020 FIN
                Insert();
            until recCrMemoLine.Next() = 0;
    end;
}

