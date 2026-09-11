tableextension 50016 PurchRcptLineExtension extends "Purch. Rcpt. Line"
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
        field(78550; "Quantite a transferer"; Decimal)
        {
            BlankZero = true;
            Caption = 'Quantité à transférer';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'DV0035';
            Editable = true;

            trigger OnValidate()
            var
                QteTropGrandeErr: Label 'Vous ne pouvez pas transférer plus de %1.',Comment = '%1 = quantité';
            begin
                TestField(Type, Type::Item);
                TestField(Correction, false);
                if "Quantite a transferer" > (Quantity - "Quantite deja transferee") then
                    Error(QteTropGrandeErr, Quantity - "Quantite deja transferee");
            end;
        }
        field(78560; "Quantite deja transferee"; Decimal)
        {
            BlankZero = true;
            Caption = 'Quantité déjà transférée';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'DV0035';
            Editable = false;
        }
    }
}

