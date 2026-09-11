tableextension 50057 ItemChargeExtension extends "Item Charge"
{
    fields
    {
        field(50000; "Type de coût"; Option)
        {
            OptionMembers = " " ,"Frais d''approche",Emballage;
            OptionCaption = ' ,Frais d''approche,Emballage';
            Caption = 'Type de coût';
            DataClassification = ToBeClassified;
        }
    }
}

