tableextension 50023 ReturnShipmentLineExtension extends "Return Shipment Line"
{
    fields
    {
        field(50020; "No. container"; Code[20])
        {
            Caption = 'N° container';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 26/08/2022';
            TableRelation = Container;
        }
        field(50021; "No. ligne container"; Integer)
        {
            Caption = 'N° ligne container';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 26/08/2022';
            TableRelation = "Ligne container"."No. ligne" where ("No. container" = field ("No. container"));
        }
        field(50090; "Nomenclature produits"; Code[20])
        {
            Caption = 'Nomenclature produits';
            DataClassification = ToBeClassified;
            TableRelation = "Tariff Number";
        }
        field(50240; "Purchaser Code"; Code[10])
        {
            Caption = 'Code acheteur';
            DataClassification = ToBeClassified;
            Description = 'DIA£LBO';
            TableRelation = "Salesperson/Purchaser";
        }
        field(51010; "Country/Region of Origin Code"; Code[10])
        {
            Caption = 'Code pays origine';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 25/08/2022. Pour la DEB. Pour les articles DIVERS, il faut que la donnée soit saisie sur la ligne de commande.';
            TableRelation = "Country/Region";
        }
    }

    keys
    {
        key(MyKey1; "No. container","No. ligne container")
        {
        }
    }
}

