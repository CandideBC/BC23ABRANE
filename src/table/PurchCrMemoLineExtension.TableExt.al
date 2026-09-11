tableextension 50019 PurchCrMemoLineExtension extends "Purch. Cr. Memo Line"
{
    fields
    {
        field(50000; Indice; Code[10])
        {
            Caption = 'Indice';
            DataClassification = ToBeClassified;
            Description = 'C12.01';
        }
        field(50090; "Nomenclature produits"; Code[20])
        {
            Caption = 'Nomenclature produits';
            TableRelation = "Tariff Number";
            DataClassification = ToBeClassified;
            
        }
        field(50240; "Purchaser Code"; Code[10])
        {
            Caption = 'Code acheteur';
            DataClassification = ToBeClassified;
            Description = 'DIA£LBO';
            TableRelation = "Salesperson/Purchaser";


        }
        field(50620; "Achat pour stock"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
        }
        field(51190; "Code groupe"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = "Groupe client";
        }
        field(51200; "Code enseigne"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = Enseigne;
        }
        field(51210; "Code operation"; Code[20])
        {
            Caption = 'Code opération';
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = Operations.Code where ("Code enseigne" = field ("Code enseigne"));
        }
        field(51220; "Code chantier"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = Enseigne;
        }
        field(88888; "Montant ligne HT (DS)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
        }
        field(88889; "Annee commande"; Integer)
        {
            Caption = 'Année commande';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(MyKey1; "Code chantier")
        {
            
        }
    }


}

