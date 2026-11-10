table 50076 "OCR Facture PL"
{
    Caption = 'OCR Facture de Packing List';
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
        field(30; "No. facture"; Code[20])
        {
            Caption = 'N° facture';
        }
        field(40; "Date facture"; Date)
        {
            Caption = 'Date facture';
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
        field(75; "Prix unitaire"; Decimal)
        {
            Caption = 'Prix unitaire';
        }
        field(78; "Prix total"; Decimal)
        {
            Caption = 'Prix total';
        }
        field(80; Incoterm; Text[30])
        {
            DataClassification = ToBeClassified;
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
