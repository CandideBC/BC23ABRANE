tableextension 50047 SalesHeaderArchiveExtension extends "Sales Header Archive"
{
    fields
    {
        field(50000; "Code concept"; Code[20])
        {
            Caption = 'Code concept';
            DataClassification = ToBeClassified;
        }
        field(50010; "No. client concept"; Code[20])
        {
            Caption = 'N° client concept';
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(50020; "Surface m2"; Decimal)
        {
            Caption = 'Surface (m2)';
            DataClassification = ToBeClassified;
            Description = 'C11.01';
        }
        field(50035; "Price included Eco Tax"; Boolean)
        {
            Caption = 'Prix écotaxe compris';
            DataClassification = ToBeClassified;
            Description = 'CPT02';
        }
        field(50040; "No. And Location Name"; Text[50])
        {
            Caption = 'N° et nom du magasin';
            DataClassification = ToBeClassified;
        }
        field(50050; "Range No."; Text[30])
        {
            Caption = 'N° rayon';
            DataClassification = ToBeClassified;
        }
        field(50060; Comments; Text[250])
        {
            Caption = 'Commentaires';
            DataClassification = ToBeClassified;
            Description = 'X01';
        }
        field(50070; Prepayment; Decimal)
        {
            Caption = 'Acompte versé';
            DataClassification = ToBeClassified;
        }
        field(50072; "Prepayment deducted"; Decimal)
        {
            Caption = 'Acompte à déduire (HT)';
            DataClassification = ToBeClassified;
        }
        field(50080; Factoring; Boolean)
        {
            Caption = 'Affacturage';
            DataClassification = ToBeClassified;
            Description = 'X01';
        }
        field(50090; "Number Of Packages"; Decimal)
        {
            Caption = 'Nombre de colis';
            DataClassification = ToBeClassified;
        }
        field(50091; "Pallet Number"; Decimal)
        {
            Caption = 'Nombre de palettes';
            DataClassification = ToBeClassified;
        }
        field(50100; ASS; Boolean)
        {
            Caption = 'SAV';
            DataClassification = ToBeClassified;
            Description = 'X01';
        }
        field(50110; "Test Quote"; Boolean)
        {
            Caption = 'Devis test';
            DataClassification = ToBeClassified;
        }
        field(50120; "Amount included Ecotax"; Decimal)
        {
            BlankZero = true;
            Caption = 'Montant écotaxe inclus';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50550; "Factor Code"; Code[10])
        {
            Caption = 'Code banque';
            DataClassification = ToBeClassified;
            TableRelation = Factor."Factor Code";
        }
        field(50600; "Invoice-to Code"; Code[10])
        {
            Caption = 'Code Adresse facturation';
            DataClassification = ToBeClassified;
            TableRelation = "Ship-to Address".Code where ("Customer No." = field ("Sell-to Customer No."),
                                                          "Adresse de facturation" = filter (true));
        }

        field(60620; "Montant archive"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Montant archivé';
            DataClassification = ToBeClassified;
            Description = 'Champ 8056602 renuméroté en migrant vers BC23';
            Editable = false;
        }

    }
}

