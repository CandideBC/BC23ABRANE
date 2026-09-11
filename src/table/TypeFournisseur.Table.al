table 50021 "Type fournisseur"
{
    DrillDownPageID = 50039;
    LookupPageID = 50039;

    fields
    {
        field(1; "Code type"; Code[10])
        {
            NotBlank = true;
        }
        field(2; "Libellé"; Text[30])
        {
        }
        field(10; "Annee cde ach = annee chargt"; Boolean)
        {
            Caption = 'Année cde achat = année chargement';
            DataClassification = ToBeClassified;
        }
        
    }

    keys
    {
        key(Key1; "Code type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code type", "Libellé")
        {
        }
    }
}

