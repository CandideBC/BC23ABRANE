table 50026 Operations
{
    Caption = 'Opérations';

    fields
    {
        field(1; "Code enseigne"; Code[20])
        {
            NotBlank = true;
        }
        field(10; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(20; Description; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Code enseigne", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

