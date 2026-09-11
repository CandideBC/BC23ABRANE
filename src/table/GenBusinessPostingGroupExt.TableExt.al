tableextension 50026 GenBusinessPostingGroupExt extends "Gen. Business Posting Group"
{
    fields
    {
        //field(50000; "Use export invoice report"; Boolean)
        //{
        //    Caption = 'Use export invoice report';
        //    DataClassification = ToBeClassified;
        //}
        field(50010; "Compte acompte"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 08/06/2020';
            TableRelation = "G/L Account";
        }
        field(50020; "Soumis Eco-Taxe"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 12/03/2021';
        }
        field(50040; "Code conditions de paiement"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 12/03/2021. Pour l''export, viendra sur les devis sauf si le client a des condtions de définies.';
            TableRelation = "Payment Terms";
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "ValidateVatBusPostingGroup(PROCEDURE 2)".

}

