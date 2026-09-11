tableextension 50034 ValueEntryExtension extends "Value Entry"
{
    fields
    {
        field(50000; "Document Type BOM"; Enum "Sales Document Type")
        {
            Caption = 'Type document composé';
            DataClassification = ToBeClassified;
            Description = 'BOM';
            Editable = false;
            //OptionCaption = 'Devis,Commande,Facture,Avoir,Commande ouverte,Retour';
            //OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(50010; "Document No. BOM"; Code[20])
        {
            Caption = 'N° document composé';
            DataClassification = ToBeClassified;
            Description = 'BOM';
            Editable = false;
            TableRelation = "Sales Header"."No." where ("Document Type" = field ("Document Type BOM"));
        }
        field(50020; "Document Line No. BOM"; Integer)
        {
            Caption = 'N° ligne document composé';
            DataClassification = ToBeClassified;
            Description = 'BOM';
            Editable = false;
        }
    }
    keys
    {
        key(MyKey1; "Document Type BOM","Document No. BOM","Document Line No. BOM")
        {
            
        }
    }


}

