tableextension 50024 GLEntryExtension extends "G/L Entry"
{
    fields
    {
        field(50000; "Commentaire interne"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50200; "Code enseigne"; Code[20])
        {
            Caption = 'Code enseigne';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Enseigne;
        }
    }
    keys
    {
        key(MyKey1; "G/L Account No.","Applies-to ID")
        {
            SumIndexFields = Amount;
        }
    }
}

