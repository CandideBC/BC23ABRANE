tableextension 50039 ItemVendorExtension extends "Item Vendor"
{
    fields
    {
        field(50000; "% Frais d'approche"; Decimal)
        {
            BlankZero = true;
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(50010; "Montant Frais d'approche"; Decimal)
        {
            BlankZero = true;
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
    }
}

