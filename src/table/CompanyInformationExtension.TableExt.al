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
            Description = 'KAN.FHA 03/02/2022 VALDELIA';
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "CheckIBAN(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "DisplayMap(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "GetRegistrationNumber(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Attributes) on "GetRegistrationNumberLbl(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "GetVATRegistrationNumber(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "GetVATRegistrationNumberLbl(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "GetLegalOffice(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "GetLegalOfficeLbl(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "GetCustomGiro(PROCEDURE 20)".


    //Unsupported feature: Property Modification (Attributes) on "GetCustomGiroLbl(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "VerifyAndSetPaymentInfo(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "GetSystemIndicator(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "GetCountryRegionCode(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "GetCompanyCountryRegionCode(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "GetDevBetaModeTxt(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "GetContactUsText(PROCEDURE 23)".


    //Unsupported feature: Property Modification (Attributes) on "IsSyncEnabledForOtherCompany(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetSystemIndicator(PROCEDURE 24)".

}

