table 50029 "Nomenclature saisie article"
{

    fields
    {
        field(1; "Code utilisateur"; Code[50])
        {
        }
        field(10; "No. article parent"; Code[20])
        {
            TableRelation = "Creation/MAJ article";
        }
        field(15; "Line No."; Integer)
        {
        }
        field(20; "N° article"; Code[20])
        {
            TableRelation = Item;

            trigger OnLookup()
            begin
                ArticleParent.Get("No. article parent");
                Composant.Reset();
                Composant.SetCurrentKey("No. 2");
                Composant.SetRange("No. 2", ArticleParent."Ref. client");
                if PAGE.RunModal(PAGE::"Item List", Composant) = ACTION::LookupOK then
                    "N° article" := Composant."No.";
            end;

            trigger OnValidate()
            begin
                //CalcFields(Description, "Indice article");
                CalcFields(Description);
            end;
        }
        field(21; Description; Text[100])
        {
            CalcFormula = lookup (Item.Description where ("No." = field ("N° article")));
            Editable = false;
            FieldClass = FlowField;
        }
        //field(25; "Indice article"; Code[10])
        //{
        //    CalcFormula = Lookup (Item.Indice WHERE ("No." = FIELD ("N° article")));
        //    FieldClass = FlowField;
       // }
        field(30; Quantite; Decimal)
        {
            Caption = 'Quantité';
            DecimalPlaces = 0 : 5;
        }
    }

    keys
    {
        key(Key1; "No. article parent", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Code utilisateur")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Code utilisateur" := copystr(UserId,1,50);
    end;

    var
        ArticleParent: Record "Creation/MAJ article";
        Composant: Record Item;
}

