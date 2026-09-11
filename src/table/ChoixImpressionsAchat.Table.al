table 50061 "Choix impressions achat"
{
    Caption = 'Choix impressions achat';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Code utilisateur"; Code[50])
        {
            Caption = 'ID Utilisateur';
        }
        field(10; "Type document"; Option)
        {
            Caption = 'Type document';
            OptionMembers = "Commande achat";
            OptionCaption = 'Commande achat';
        }
        field(20; "No. document"; Code[20])
        {
            Caption = 'N° document';
        }
        field(30; Document; Text[30])
        {
            Caption = 'Document';
        }
        field(40; Imprimer; Boolean)
        {
            Caption = 'Imprimer';
        }
        field(50; "No. etat"; Integer)
        {
            Caption = 'N° état';
        }
    }
    keys
    {
        key(PK; "Code utilisateur","Type document","No. document",Document)
        {
            Clustered = true;
        }
    }
}
