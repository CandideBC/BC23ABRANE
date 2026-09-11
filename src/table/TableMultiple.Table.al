table 50022 "Table multiple"
{
    DrillDownPageID = 50041;
    LookupPageID = 50041;

    fields
    {
        field(1; Type; Option)
        {
            OptionMembers = "Mode de transport","Heure de réception",Fonction;
        }
        field(2; "Code"; Code[20])
        {
        }
        field(3; "Libellé"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; Type, "Code")
        {
            Clustered = true;
        }
        key(Key2; "Code")
        {
        }
        key(Key3; "Libellé")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", "Libellé")
        {
        }
    }
}

