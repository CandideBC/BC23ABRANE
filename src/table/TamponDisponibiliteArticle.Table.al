table 50006 "Tampon disponibilite article"
{
    Caption = 'Item Availability Buffer';
    DataCaptionFields = "No.", Description;
    Permissions =;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'N°';
        }
        field(2; "No. 2"; Code[20])
        {
            CalcFormula = lookup (Item."No. 2" where ("No." = field ("No.")));
            Caption = 'N° 2';
            Editable = false;
            FieldClass = FlowField;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Désignation';
        }
        field(4; "Search Description"; Code[50])
        {
            Caption = 'Désignation de recherche';
        }
        field(5; "Description 2"; Text[50])
        {
            Caption = 'Désignation 2';
        }
        field(8; "Base Unit of Measure"; Code[10])
        {
            Caption = 'Unité de base';
            TableRelation = "Unit of Measure";
            ValidateTableRelation = false;
        }
        field(31; "Vendor No."; Code[20])
        {
            Caption = 'N° fournisseur';
            TableRelation = Vendor;
            ValidateTableRelation = true;
        }
        field(32; "Vendor Item No."; Text[20])
        {
            Caption = 'Référence fournisseur';
        }
        field(33; "Lead Time Calculation"; DateFormula)
        {
            Caption = 'Délai de réappro';
        }
        field(34; "Reorder Point"; Decimal)
        {
            Caption = 'Point de commande';
            DecimalPlaces = 0 : 5;
        }
        field(68; Inventory; Decimal)
        {
            Caption = 'Stocks';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50020; "Qte stock tampon"; Decimal)
        {
            BlankZero = true;
            Caption = 'Qté stock tampon';
            DecimalPlaces = 0 : 5;
        }
        field(50030; "Qte stock maxi"; Decimal)
        {
            BlankZero = true;
            Caption = 'Qté stock maxi';
            DecimalPlaces = 0 : 5;
        }
        field(50040; Indic; BLOB)
        {
            Caption = 'Indic';
            SubType = Bitmap;
        }
        field(50100; "Nom fournisseur"; Text[100])
        {
            CalcFormula = lookup (Vendor.Name where ("No." = field ("Vendor No.")));
            Caption = 'Nom fournisseur';
            Description = 'E10';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50190; "Complement ref. client"; Text[30])
        {
            CalcFormula = lookup (Item."Complement ref. client" where ("No." = field ("No.")));
            Caption = 'Complément réf. client';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50300; LocationFilter; Text[250])
        {
            Caption = 'Filtre magasin';
        }
        field(55000; "Qty. on Assembly Order Cust"; Decimal)
        {
            Caption = 'Qté sur ordre d''assemblage client';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(90000; "Input Qty 1"; Decimal)
        {
            Caption = 'Qté entrée 1';
        }
        field(90001; "Input Qty 2"; Decimal)
        {
            Caption = 'Qté entrée 2';
        }
        field(90002; "Input Qty 3"; Decimal)
        {
            Caption = 'Qté entrée 3';
        }
        field(90003; "Input Qty 4"; Decimal)
        {
            Caption = 'Qté entrée 4';
        }
        field(90004; "Input Qty 5"; Decimal)
        {
            Caption = 'Qté entrée 5';
        }
        field(90005; "Input Qty 6"; Decimal)
        {
            Caption = 'Qté entrée 6';
        }
        field(90006; "Input Qty 7"; Decimal)
        {
            Caption = 'Qté entrée 7';
        }
        field(90007; "Input Qty 8"; Decimal)
        {
            Caption = 'Qté entrée 8';
        }
        field(90008; "Input Qty 9"; Decimal)
        {
            Caption = 'Qté entrée 9';
        }
        field(90009; "Input Qty 10"; Decimal)
        {
            Caption = 'Qté entrée 10';
        }
        field(90010; "Input Qty 11"; Decimal)
        {
            Caption = 'Qté entrée 11';
        }
        field(90011; "Input Qty 12"; Decimal)
        {
            Caption = 'Qté entrée 1';
        }
        field(90012; "Input Qty 13"; Decimal)
        {
            Caption = 'Qté entrée 13';
        }
        field(90013; "Input Qty 14"; Decimal)
        {
            Caption = 'Qté entrée 14';
        }
        field(90014; "Input Qty 15"; Decimal)
        {
            Caption = 'Qté entrée 15';
        }
        field(90015; "Input Qty 16"; Decimal)
        {
            Caption = 'Qté entrée 16';
        }
        field(90016; "Input Qty 17"; Decimal)
        {
            Caption = 'Qté entrée 17';
        }
        field(90017; "Input Qty 18"; Decimal)
        {
            Caption = 'Qté entrée 18';
        }
        field(90050; "Output Qty 1"; Decimal)
        {
            Caption = 'Output Qty 1';
        }
        field(90051; "Output Qty 2"; Decimal)
        {
            Caption = 'Output Qty 2';
        }
        field(90052; "Output Qty 3"; Decimal)
        {
            Caption = 'Output Qty 3';
        }
        field(90053; "Output Qty 4"; Decimal)
        {
            Caption = 'Output Qty 4';
        }
        field(90054; "Output Qty 5"; Decimal)
        {
            Caption = 'Output Qty 5';
        }
        field(90055; "Output Qty 6"; Decimal)
        {
            Caption = 'Output Qty 6';
        }
        field(90056; "Output Qty 7"; Decimal)
        {
            Caption = 'Output Qty 7';
        }
        field(90057; "Output Qty 8"; Decimal)
        {
            Caption = 'Output Qty 8';
        }
        field(90058; "Output Qty 9"; Decimal)
        {
            Caption = 'Output Qty 9';
        }
        field(90059; "Output Qty 10"; Decimal)
        {
            Caption = 'Output Qty 10';
        }
        field(90060; "Output Qty 11"; Decimal)
        {
            Caption = 'Output Qty 11';
        }
        field(90061; "Output Qty 12"; Decimal)
        {
            Caption = 'Output Qty 1';
        }
        field(90062; "Output Qty 13"; Decimal)
        {
            Caption = 'Output Qty 13';
        }
        field(90063; "Output Qty 14"; Decimal)
        {
            Caption = 'Output Qty 14';
        }
        field(90064; "Output Qty 15"; Decimal)
        {
            Caption = 'Output Qty 15';
        }
        field(90065; "Output Qty 16"; Decimal)
        {
            Caption = 'Output Qty 16';
        }
        field(90066; "Output Qty 17"; Decimal)
        {
            Caption = 'Output Qty 17';
        }
        field(90067; "Output Qty 18"; Decimal)
        {
            Caption = 'Output Qty 18';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Description, "Base Unit of Measure")
        {
        }
    }



    var
        Item: Record Item;
        //ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";

    procedure DrillDownField("Action": Option Input,Output,Both; StartDate: Date; Enddate: Date; optIn: Option "Order","Plan & Order"; optOut: Option "Order","Forecast & Order"; QtyStartDate: Decimal; QtyEndDate: Decimal)
    var
        ForeCastName: Code[20];
        IncludeForeCast: Boolean;
        IncludePlan: Boolean;
    begin
        Item.Get("No.");
        Clear(ForeCastName);
        if optOut = optOut::"Forecast & Order" then begin
            IncludeForeCast := true;
            ForeCastName := 'OUVERTURES';
        end;
        if optIn = optIn::"Plan & Order" then
            IncludePlan := true;

        // A FINIR MIGRATION ItemAvailFormsMgt.ShowItemAvailByWeek_F(Item, StartDate, Enddate, IncludeForeCast, ForeCastName, IncludePlan, QtyStartDate, QtyEndDate, Action, LocationFilter);
    end;
}

