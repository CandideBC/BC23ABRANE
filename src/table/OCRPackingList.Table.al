table 50075 "OCR Packing List"
{
    Caption = 'OCR Packing List';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;"ID OCR"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"ID ligne OCR"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "No. fournisseur"; Code[20])
        {
            Caption = 'No. fournisseur';
        }
        field(20; "Nom fournisseur"; Text[100])
        {
            Caption = 'Nom fournisseur';
        }
        field(30; "No. packing list"; Code[20])
        {
            Caption = 'No. packing list';
        }
        field(40; "Date packing list"; Date)
        {
            Caption = 'Date packing list';
        }
        field(50; "Reference article"; Text[20])
        {
            Caption = 'Reference article';
        }
        field(60; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(70; Quantite; Decimal)
        {
            Caption = 'Quantite';
        }
        field(80; "No. UC"; Code[20])
        {
            Caption = 'No. UC';
        }
        field(90; "Dimensions UC"; Text[30])
        {
            Caption = 'Dimensions UC';
        }
        field(100; "Poids net UC"; Decimal)
        {
            Caption = 'Poids net UC';
        }
        field(110; "Poids brut UC"; Decimal)
        {
            Caption = 'Poids brut UC';
        }
        field(120; "HS Code"; Code[20])
        {
            Caption = 'HS Code';
        }
    }
    keys
    {
        key(PK; "ID OCR","ID ligne OCR")
        {
            Clustered = true;
        }
    }
}
