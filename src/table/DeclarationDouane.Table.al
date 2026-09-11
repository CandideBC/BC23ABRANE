table 50064 "Declaration douane"
{
    Caption = 'Declaration douane';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(10; "No."; Code[20])
        {
            Caption = 'N°';
        }
        field(20; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(30; "No. client"; Code[20])
        {
            Caption = 'N° client';
            TableRelation = Customer;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
