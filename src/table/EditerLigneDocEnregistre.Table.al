table 50011 "Editer ligne doc. enregistre"
{
    fields
    {
        field(10; "Type document"; Option)
        {
            Caption = 'Type document';
            OptionCaption = 'Avoir enreg. vente,Avoir enreg. achat';
            OptionMembers = "Avoir enreg. vente","Avoir enreg. achat";
        }
        field(20; "No. document"; Code[20])
        {
            Caption = 'N° document';
            Editable = false;
        }
        field(30; "No. ligne document"; Integer)
        {
            Caption = 'N° ligne document';
            Editable = false;
        }
        

        field(120; Type; Enum "Sales Line Type")
        {
            Caption = 'Type';
            Editable = false;
        }
        field(130; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
            TableRelation = IF (Type = CONST (Item)) Item WHERE (Type = CONST (Inventory))
            ELSE
            IF (Type = CONST (Resource)) Resource;
        }
        field(140; Description; Text[100])
        {
            Caption = 'Description';
            Editable = false;
        }


        field(200; "Annee commande"; Integer)
        {
            Caption = 'Année commande';
        }

    }

    keys
    {
        key(Key1; "Type document", "No. document", "No. ligne Document")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

