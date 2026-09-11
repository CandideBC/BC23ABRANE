tableextension 50050 PurchaseHeaderArchiveExtension extends "Purchase Header Archive"
{
    fields
    {
        field(50000; "Date limite reponse"; Date)
        {
            Caption = 'Date limite réponse fournisseur';
            DataClassification = ToBeClassified;
            Description = 'A01.01';
        }
        field(50060; Comments; Text[250])
        {
            Caption = 'Commentaires';
            DataClassification = ToBeClassified;
            Description = 'X01';
        }
        field(68532; "Montant archive"; Decimal)
        {
            Caption = 'Montant archivé';
            DataClassification = ToBeClassified;
        }
        
    }



}

