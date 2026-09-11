table 50050 "Edit Purchase Invoice"
{
    Caption = 'Modifier facture achat';

    fields
    {
        field(1; "Posted Purchase Invoice No."; Code[20])
        {
            Caption = 'N° facture achat enregistrée';
            Editable = false;
        }
        field(2; "Buy-From Vendor No."; Code[20])
        {
            Caption = 'N° preneur d''ordre';
            Editable = false;
            NotBlank = true;
            TableRelation = Customer;
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(4; "Pay-to Vendor No."; Code[20])
        {
            Caption = 'N° fournisseur à payer';
            Editable = false;
            NotBlank = true;
            TableRelation = Vendor;
        }
        field(5; "Pay-to Name"; Text[50])
        {
            Caption = 'Nom';
        }
        field(6; "Pay-to Name 2"; Text[50])
        {
            Caption = 'Nom 2';
        }
        field(7; "Pay-to Address"; Text[50])
        {
            Caption = 'Adresse';
        }
        field(8; "Pay-to Address 2"; Text[50])
        {
            Caption = 'Adresse 2';
        }
        field(9; "Pay-to City"; Text[30])
        {
            Caption = 'Ville';
            TableRelation = "Post Code".City;
            ValidateTableRelation = false;
        }
        field(10; "Pay-to Contact"; Text[50])
        {
            Caption = 'Contact';
        }
        field(70; "VAT Registration No."; Text[20])
        {
            Caption = 'N° ident. intracomm.';
        }
        field(79; "Buy-from Vendor Name"; Text[50])
        {
            Caption = 'Nom preneur d''ordre';
        }
        field(80; "Buy-from Vendor Name 2"; Text[50])
        {
            Caption = 'Nom 2 preneur d''ordre';
        }
        field(81; "Buy-from Address"; Text[50])
        {
            Caption = 'Adresse preneur d''ordre';
        }
        field(82; "Buy-from Address 2"; Text[50])
        {
            Caption = 'Adresse 2 preneur d''ordre';
        }
        field(83; "Buy-from City"; Text[30])
        {
            Caption = 'Ville preneur d''ordre';
            TableRelation = "Post Code".City;
            ValidateTableRelation = false;
        }
        field(84; "Buy-from Contact"; Text[50])
        {
            Caption = 'Contact preneur d''ordre';
        }
        field(85; "Pay-to Post Code"; Code[20])
        {
            Caption = 'Code postal';
            TableRelation = "Post Code";
            ValidateTableRelation = false;
        }
        field(87; "Pay-to Country/Region Code"; Code[10])
        {
            Caption = 'Code pays';
            TableRelation = "Country/Region";
        }
        field(88; "Buy-from Post Code"; Code[20])
        {
            Caption = 'Code postal preneur d''ordre';
            TableRelation = "Post Code";
            ValidateTableRelation = false;
        }
        field(90; "Buy-from Country/Region Code"; Code[10])
        {
            Caption = 'Code pays preneur d''ordre';
            TableRelation = "Country/Region";
        }
        field(100; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
        }
        field(88860; "Concernee DEB"; Boolean)
        {
            Caption = 'Concernée DEB';
            Description = 'KAN.FHA 16/02/2023';
        }
    }

    keys
    {
        key(Key1; "Posted Purchase Invoice No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

