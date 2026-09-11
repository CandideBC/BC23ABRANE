tableextension 50038 CustomerPostingGroupExtension extends "Customer Posting Group"
{
    fields
    {
        field(50000; "Prepayment deducted Acc."; Code[20])
        {
            Caption = 'Compte acompte à déduire';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
    }

 
}

