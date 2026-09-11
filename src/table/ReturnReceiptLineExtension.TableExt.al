tableextension 50053 ReturnReceiptLineExtension extends "Return Receipt Line"
{
    fields
    {
        field(50090; "Nomenclature produits"; Code[20])
        {
            Caption = 'Nomenclature produits';
            DataClassification = ToBeClassified;
            TableRelation = "Tariff Number";
        }
        field(50160; "Price included Eco Tax"; Boolean)
        {
            Caption = 'Prix écotaxe inclus';
            DataClassification = ToBeClassified;
            Description = 'CPT02';
        }
        field(50240; "Salesperson Code"; Code[10])
        {
            Caption = 'Code vendeur';
            DataClassification = ToBeClassified;
            Description = 'DIA£LBO';
            TableRelation = "Salesperson/Purchaser";
        }
        field(50250; "Reason Code"; Code[10])
        {
            Caption = 'Code motif retour';
            DataClassification = ToBeClassified;
            Description = 'DIA£LBO modification caption';
            TableRelation = "Reason Code";
        }
        field(51010; "Country/Region of Origin Code"; Code[10])
        {
            Caption = 'Code pays origine';
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
    }


}

