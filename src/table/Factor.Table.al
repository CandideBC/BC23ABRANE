table 50017 Factor
{
    LookupPageID = 50021;

    fields
    {
        field(1; "Factor Code"; Code[10])
        {
            Caption = 'Code Factor';
        }
        field(10; "Text 1"; Text[250])
        {
            Caption = 'Texte 1';
        }
        field(20; "Text 2"; Text[250])
        {
            Caption = 'Texte 2';
        }
        field(30; "Text 3"; Text[250])
        {
            Caption = 'Texte 3';
        }
    }

    keys
    {
        key(Key1; "Factor Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

