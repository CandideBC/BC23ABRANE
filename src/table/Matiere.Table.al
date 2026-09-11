table 50002 Matiere
{
    Caption = 'Matière';
    LookupPageID = 50009;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(10; "Code eco-taxe obligatoire"; Boolean)
        {
            Caption = 'Code éco-taxe obligatoire';
            DataClassification = ToBeClassified;
        }
        
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description)
        {
        }
    }
}

