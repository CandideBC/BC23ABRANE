tableextension 50051 TransferLineExtension extends "Transfer Line"
{
    fields
    {
        field(50000; "No. container"; Code[20])
        {
            Caption = 'N° container';
            DataClassification = ToBeClassified;
            TableRelation = Container;
        }
    }
    keys
    {
        key(MyKey1; "No. container")
        {
            
        }
    }


}

