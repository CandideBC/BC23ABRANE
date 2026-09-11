table 50059 TamponBudgetApprocheDocument
{
    Caption = 'TamponBudgetApprocheDocument';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code utilisateur"; Code[50])
        {
            Caption = 'Code utilisateur';
        }
        field(2; "Type document"; Enum "Sales Document Type")
        {
            Caption = 'Type document';
        }
        field(10; "No. document"; Code[20])
        {
            Caption = 'No. document';
        }
        field(15; "Type ligne"; Option)
        {
            Caption = 'Type ligne';
            OptionMembers = "Budget approche","Poids";
            OptionCaption = 'Budget approche,Poids';
        }
        
        field(103; "Code pays origine"; Code[10])
        {
            Caption = 'Code pays d''origine';
            DataClassification = ToBeClassified;
        }
        field(130; "Montant achats prevus"; Decimal)
        {
            Caption = 'Montant achats prévus';
            DataClassification = ToBeClassified;
        }
        field(140; "% frais approche"; Decimal)
        {
            Caption = '% frais approche';
            DataClassification = ToBeClassified;
        }
        field(150; "Budget frais approche (DS)"; Decimal)
        {
            Caption = 'Budget frais approche (DS)';
            DataClassification = ToBeClassified;
        }
        field(160; "Poids net"; Decimal)
        {
            Caption = 'Poids net';
            BlankZero = true;
            DecimalPlaces = 2:2;
            DataClassification = ToBeClassified;
        }
        field(170; "Poids brut"; Decimal)
        {
            Caption = 'Poids brut';
            BlankZero = true;
            DecimalPlaces = 2:2;
            DataClassification = ToBeClassified;
        }
        field(180; "Quantite"; Decimal)
        {
            Caption = 'Quantité';
            BlankZero = true;
            DecimalPlaces = 0:2;
            DataClassification = ToBeClassified;
        }
        

    }
    keys
    {
        key(PK; "Code utilisateur", "Type document", "No. document", "Code pays origine")
        {
            Clustered = true;
        }

    }
}
