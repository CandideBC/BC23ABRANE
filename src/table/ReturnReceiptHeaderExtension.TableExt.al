tableextension 50052 ReturnReceiptHeaderExtension extends "Return Receipt Header"
{
    fields
    {
        field(50035; "Price included Eco Tax"; Boolean)
        {
            Caption = 'Prix écotaxe compris';
            DataClassification = ToBeClassified;
            Description = 'CPT02';
        }
        field(50120; "Amount included Ecotax"; Decimal)
        {
            BlankZero = true;
            Caption = 'Montant écotaxe inclus';
            DataClassification = ToBeClassified;
            Description = 'CPTO2';
            Editable = false;
        }
    }

}

