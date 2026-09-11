tableextension 50025 DetailedCustLedgEntryExtension extends "Detailed Cust. Ledg. Entry"
{
    fields
    {
        field(50000; "Code enseigne"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Enseigne;
        }
    }

    keys
    {
        key(MyKey1; "Code enseigne")
        {
            
        }
    }

}

