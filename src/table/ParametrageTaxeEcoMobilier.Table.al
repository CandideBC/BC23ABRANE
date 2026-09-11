table 50008 "Parametrage taxe eco-mobilier"
{
    

    Caption = 'Paramétrage taxe éco-mobilier';
    DataClassification = CustomerContent;
    LookupPageID = 50012;

    fields
    {
        field(1; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Groupe compta. marché';
            TableRelation = "Gen. Business Posting Group";
        }
        field(10; "eco tax furniture code"; Code[10])
        {
            Caption = 'Code taxe éco-mobilier';
            TableRelation = "Taxe eco-mobilier";
        }
        field(15; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'Groupe compta. produit TVA';
            TableRelation = "VAT Product Posting Group";
        }
        field(20; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Groupe compta. produit';
            TableRelation = "Gen. Product Posting Group";
        }
        field(40; "Sales Account"; Code[10])
        {
            Caption = 'Compte ventes';
            TableRelation = "G/L Account" where("Direct Posting" = const(true));
        }
        field(50; "Purchase Account"; Code[10])
        {
            Caption = 'Compte achats';
            TableRelation = "G/L Account" where("Direct Posting" = const(true));
        }
    }

    keys
    {
        key(Key1; "Gen. Bus. Posting Group", "eco tax furniture code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

