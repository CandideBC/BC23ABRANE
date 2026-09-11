table 50031 "Mes Chantiers"
{
    Caption = 'Mes Chantiers';

    fields
    {
        field(1; "User ID"; Code[50])
        {
            Caption = 'Code utilisateur';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(3; "Code chantier"; Code[20])
        {
            Caption = 'Code chantier';
            NotBlank = true;
            TableRelation = Chantier;

            trigger OnValidate()
            begin
                CalcFields("Nom du chantier");
            end;
        }
        field(10; "Nom du chantier"; Text[50])
        {
            CalcFormula = lookup (Chantier."Description chantier" where (Code = field ("Code chantier")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "User ID", "Code chantier")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    procedure AddEntities(FilterStr: Text[250])
    var
        Chantier: Record Chantier;
    begin
        Chantier.SetFilter(Code, FilterStr);
        if Chantier.FindSet() then
            repeat
                "User ID" := copystr(UserId(),1,50);
                "Code chantier" := Chantier.Code;
                if not Insert() then;
            until Chantier.Next() = 0;
    end;

    procedure TestsRenta()
    var
        cuTest: Codeunit "Tests Renta";
    begin
        Clear(cuTest);
        cuTest.DefChantier("Code chantier");
        cuTest.RUN();
    end;
}

