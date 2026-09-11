table 50010 TamponAffectationsDocVente
{

    fields
    {
        field(1; "Code utilisateur"; Code[50])
        {
            Caption = 'Code utilisateur';
            DataClassification = ToBeClassified;
        }

        field(10; "No. commande achat"; Code[20])
        {
            Caption = 'N° commande achat';
            TableRelation = "Purchase Header"."No." where("Document Type" = const(Order));
        }
        /*
        field(20; "No. ligne document achat"; Integer)
        {
            Caption = 'N° ligne document achat';
            TableRelation = "Purchase Line"."Line No." where("Document Type" = const(Order),
                                                              "Document No." = field("No. commande achat"));
        }
        */
        field(21; "No. article achete"; Code[20])
        {
            Caption = 'N° article acheté';
            Editable = false;
        }
        field(22; "Description article achete"; Text[100])
        {
            Caption = 'Description article acheté';
            Editable = false;
        }

        
        field(23; "Qte achetee"; Decimal)
        {
            Caption = 'Qté achetée';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        
        field(24; "Qte recue"; Decimal)
        {
            Caption = 'Qté reçue';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }

        field(60; "Quantite affectee"; Decimal)
        {
            Caption = 'Quantité affectée';
            DecimalPlaces = 0 : 5;

        }
        //Ceux deux champs sont là pour pouvoir faire le Drilldown de la quantité affectée, pas d'utilité sinon
        field(100; "Type document vente"; Enum "Sales Document Type")
        {
            DataClassification = ToBeClassified;
        }
        field(110; "No. doc. vente"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Code utilisateur", "No. commande achat", "No. article achete")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

