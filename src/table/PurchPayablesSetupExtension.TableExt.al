tableextension 50029 PurchPayablesSetupExtension extends "Purchases & Payables Setup"
{
    fields
    {
        field(50000; "No. container"; Code[10])
        {
            Caption = 'N° container';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }



}

