table 50007 "Taxe eco-mobilier"
{
    Caption = 'Taxe éco-mobilier';
    DataClassification = CustomerContent;
    LookupPageID = 50012;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; "Code matiere associe"; Code[20])
        {
            Caption = 'Code matière associé';
            TableRelation = Matiere;
        }
        field(5; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(10; Family; Text[50])
        {
            Caption = 'Famille';

        }
        field(20; "Sub Family"; Text[50])
        {
            Caption = 'Sous-Famille';

        }
        field(30; "Unit Amount"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Montant unitaire';
            MinValue = 0;
        }
        field(40; "Beginning Date"; Date)
        {
            Caption = 'Date début';
        }
        field(50; "Account No."; Code[20])
        {
            Caption = 'N° de compte';
            TableRelation = "G/L Account"."No." where("Direct Posting" = const(true));
        }
    }

    keys
    {
        key(Key1; "Code", "Beginning Date")
        {
            Clustered = true;
        }
        key(Key2; "Code matiere associe")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Family, "Sub Family", "Unit Amount")
        {
        }
    }

    trigger OnDelete()
    begin
        WEEESetup.SetRange("eco tax furniture code");
        WEEESetup.DeleteAll();
    end;

    trigger OnInsert()
    begin
        TestField(Code);
    end;

    trigger OnRename()
    begin
        WEEESetup.SetRange("eco tax furniture code", rec.Code);
        if not WEEESetup.IsEmpty then
            Error(Text001Lbl);
    end;

    var
        WEEESetup: Record "Parametrage taxe eco-mobilier";
        Text001Lbl: Label 'Posting Setup must be deleted';
}

