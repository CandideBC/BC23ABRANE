tableextension 50022 ShiptoAddressExtension extends "Ship-to Address"
{
    fields
    {
        field(50000; "Adresse de facturation"; Boolean)
        {
            Caption = 'Adresse de facturation';
            DataClassification = ToBeClassified;
            Description = 'C07.01';
        }
        field(50040; "No. And Location Name"; Text[50])
        {
            Caption = 'N° et nom magasin';
            DataClassification = ToBeClassified;
            Description = 'X01';
        }
        field(50100; "Management Control Mail"; Text[30])
        {
            Caption = 'Mail Contrôleur de gestion';
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;
        }
    }



}

