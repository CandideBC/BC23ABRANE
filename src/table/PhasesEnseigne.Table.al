table 50056 "Phases enseigne"
{
    Caption = 'Phases enseigne';
    DataClassification = ToBeClassified;
    LookupPageId = "Phases enseigne";
    
    fields
    {
        field(10; "Code enseigne"; Code[20])
        {
            Caption = 'Code enseigne';
            NotBlank = true;
        }
        field(20; Phase; Integer)
        {
            Caption = 'Phase';
            NotBlank = true;
            MinValue = 1;
            MaxValue = 98;
        }
        field(30; Description; Text[50])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; "Code enseigne",Phase)
        {
            Clustered = true;
        }
    }
}
