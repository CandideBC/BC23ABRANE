tableextension 50048 SalesLineArchiveExtension extends "Sales Line Archive"
{
    fields
    {
        field(50000; "Prix bloque"; Boolean)
        {
            Caption = 'Prix bloqué';
            DataClassification = ToBeClassified;
            Description = 'C02.01';
            Editable = false;
        }
        field(50001; "Prix debloque par"; Code[50])
        {
            Caption = 'Prix débloqué par';
            DataClassification = ToBeClassified;
            Description = 'C02.01';
            Editable = false;
            NotBlank = true;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50002; "Prix avant deblocage"; Decimal)
        {
            Caption = 'Prix avant déblocage';
            DataClassification = ToBeClassified;
            Description = 'C02.01';
            Editable = false;
        }
        field(50160; "Price included Eco Tax"; Boolean)
        {
            Caption = 'Prix écotaxe inclus';
            DataClassification = ToBeClassified;
            Description = 'CPT02';
        }
        field(50200; "Linked to line"; Integer)
        {
            Caption = 'Lié à la ligne N°';
            DataClassification = ToBeClassified;
            Description = 'BOM';
        }
        field(50210; "Explode Line"; Boolean)
        {
            Caption = 'Ligne éclatée';
            DataClassification = ToBeClassified;
            Description = 'BOM';
        }
        field(50230; "Prepayment Deducted Line"; Boolean)
        {
            Caption = 'Ligne acompte déductible';
            DataClassification = ToBeClassified;
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
            Caption = 'Code motif';
            DataClassification = ToBeClassified;
            Description = 'DIA£LBO modification caption';
            TableRelation = "Reason Code";
        }
    }



}

