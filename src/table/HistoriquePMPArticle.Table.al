table 50001 "Historique PMP article"
{

    fields
    {
        field(10; "No. article"; Code[20])
        {
            Caption = 'N° article';
            TableRelation = Item;
        }
        field(11; Date; Date)
        {
        }
        field(12; Designation; Text[50])
        {
            Caption = 'Désignation';
        }
        field(15; "Ref client"; Code[20])
        {
            TableRelation = "Reference client";
        }
        field(22; "Date dernier mouvement"; Date)
        {
        }
        field(23; "Date dernier achat"; Date)
        {
        }
        field(30; "Quantite en stock"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(90; "PMP recalcule"; Decimal)
        {
            Caption = 'PMP recalculé';
        }
    }

    keys
    {
        key(Key1; "No. article", Date)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

