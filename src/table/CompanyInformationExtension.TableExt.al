tableextension 50030 CompanyInformationExtension extends "Company Information"
{
    fields
    {

        field(50001; "Logo simple"; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(50010; "No. registre producteurs"; Code[20])
        {
            Caption = 'N° registre producteurs';
            DataClassification = ToBeClassified;
        }
    }


}

