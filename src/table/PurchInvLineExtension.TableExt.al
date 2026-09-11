tableextension 50014 PurchInvLineExtension extends "Purch. Inv. Line"
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
        field(50120; "Annee commande"; Integer)
        {
            Caption = 'Année commande';
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
            TableRelation = Chantier;
        }
        field(88887; "SAV fournisseur"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(88888; "Montant ligne HT (DS)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
        }
        field(88889; "Type SAV"; Option)
        {
            CalcFormula = lookup ("Purch. Inv. Header"."SAV Type" where ("No." = field ("Document No.")));
            Editable = false;
            FieldClass = FlowField;
            OptionMembers = " ",FOURNISSEUR,ABRANE;
        }
    }
    keys
    {
        key(MyKey1; "Code chantier","Achat pour stock")
        {
            
        }
        key(MyKey2; "Code enseigne","Achat pour stock")
        {
            
        }
        key(MyKey3; Type,"No.","Posting Date")
        {
            
        }
    }

}

