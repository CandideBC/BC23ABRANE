table 50019 "Reference client"
{
    Caption = 'Références clients';
    DrillDownPageID = 50037;
    LookupPageID = 50037;

    fields
    {
        field(1; "Reference client"; Code[20])
        {
            Caption = 'Référence client';
            NotBlank = true;
        }
        field(2; Libelle; Text[50])
        {
            Caption = 'Libellé';
        }
        field(10; "Code enseigne"; Code[20])
        {
            Caption = 'Code enseigne';
            DataClassification = ToBeClassified;
            TableRelation = Enseigne;
            trigger OnValidate()
            var
                Article: Record Item;
            begin
                Article.SetCurrentKey("Ref. client");
                Article.setrange("Ref. client",Rec."Reference client");
                if Article.FindSet(true) then
                    repeat
                        Article."Code enseigne" := Rec."Code enseigne";
                        Article.Modify();
                    until Article.Next() = 0;
            end;
        }
        
    }

    keys
    {
        key(Key1; "Reference client")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Reference client")
        {
        }
    }
}

