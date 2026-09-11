table 50037 "Edit Sales Invoice"
{
    // Cette table sert à deux choses :
    // - modifier l'adresse sur une facture enregistrée
    // - forcer le cout unitaire sur une ligne de facture enregistrée dans le cas d'un article divers.

    Caption = 'Edit Sales Invoice';

    fields
    {
        field(1; "Posted Sales Invoice No."; Code[20])
        {
            Caption = 'Posted Sales Invoice No.';
            Editable = false;
        }
        field(2; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            Editable = false;
            NotBlank = true;
            TableRelation = Customer;
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(4; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            Editable = false;
            NotBlank = true;
            TableRelation = Customer;
        }
        field(5; "Bill-to Name"; Text[50])
        {
            Caption = 'Bill-to Name';
        }
        field(6; "Bill-to Name 2"; Text[50])
        {
            Caption = 'Bill-to Name 2';
        }
        field(7; "Bill-to Address"; Text[50])
        {
            Caption = 'Bill-to Address';
        }
        field(8; "Bill-to Address 2"; Text[50])
        {
            Caption = 'Bill-to Address 2';
        }
        field(9; "Bill-to City"; Text[30])
        {
            Caption = 'Bill-to City';
            TableRelation = "Post Code".City;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(10; "Bill-to Contact"; Text[50])
        {
            Caption = 'Bill-to Contact';
        }
        field(13; "Ship-to Name"; Text[50])
        {
            Caption = 'Ship-to Name';
        }
        field(14; "Ship-to Name 2"; Text[50])
        {
            Caption = 'Ship-to Name 2';
        }
        field(15; "Ship-to Address"; Text[50])
        {
            Caption = 'Ship-to Address';
        }
        field(16; "Ship-to Address 2"; Text[50])
        {
            Caption = 'Ship-to Address 2';
        }
        field(17; "Ship-to City"; Text[30])
        {
            Caption = 'Ship-to City';
            TableRelation = "Post Code".City;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(18; "Ship-to Contact"; Text[50])
        {
            Caption = 'Ship-to Contact';
        }
        field(27; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";
        }
        field(70; "VAT Registration No."; Text[20])
        {
            Caption = 'N° ident. intracomm.';
        }
        field(79; "Sell-to Customer Name"; Text[50])
        {
            Caption = 'Sell-to Customer Name';
        }
        field(80; "Sell-to Customer Name 2"; Text[50])
        {
            Caption = 'Sell-to Customer Name 2';
        }
        field(81; "Sell-to Address"; Text[50])
        {
            Caption = 'Sell-to Address';
        }
        field(82; "Sell-to Address 2"; Text[50])
        {
            Caption = 'Sell-to Address 2';
        }
        field(83; "Sell-to City"; Text[30])
        {
            Caption = 'Sell-to City';
            TableRelation = "Post Code".City;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(84; "Sell-to Contact"; Text[50])
        {
            Caption = 'Sell-to Contact';
        }
        field(85; "Bill-to Post Code"; Code[20])
        {
            Caption = 'Bill-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(87; "Bill-to Country/Region Code"; Code[10])
        {
            Caption = 'Bill-to Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(88; "Sell-to Post Code"; Code[20])
        {
            Caption = 'Sell-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(90; "Sell-to Country/Region Code"; Code[10])
        {
            Caption = 'Sell-to Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(91; "Ship-to Post Code"; Code[20])
        {
            Caption = 'Ship-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(93; "Ship-to Country/Region Code"; Code[10])
        {
            Caption = 'Ship-to Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(100; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
        }
        field(50090; "Number Of Packages"; Decimal)
        {
            Caption = 'Number Of Packages';
        }
        field(50091; "Pallet Number"; Decimal)
        {
            Caption = 'Pallet Number';
        }
        field(50130; "Total Net Weight"; Decimal)
        {
            Caption = 'Total Net Weight';
        }
        field(50140; "Total Gross Weight"; Decimal)
        {
            Caption = 'Total Gross Weight';
        }
        field(50300; "Montant deja verse TTC"; Decimal)
        {
            Caption = 'Montant déjà versé TTC';
            Description = 'KAN.FHA 02/06/2021';

            trigger OnValidate()
            var
                UserSetup: Record "User Setup";
                ModifMontantVerseErr: Label 'Vous n''avez pas les autorisations pour modifier ce champ.';
            begin
                //KAN.FHA 02/06/2021 DEBUT
                if not UserSetup.Get(UserId) then
                    UserSetup.Init();

                if not UserSetup."Saisir montant deja verse" then
                    Error(ModifMontantVerseErr);
                //KAN.FHA 02/06/2021 FIN
            end;
        }
        field(76581; "Posted Sales Invoice Line No."; Integer)
        {
            Caption = 'Posted Sales Invoice Line No.';
            Editable = false;
        }
        field(76582; "Unit Cost (LCY)"; Decimal)
        {
            Caption = 'Unit Cost (LCY)';

            trigger OnValidate()
            begin
                "Total Cost" := Round(Quantity * "Unit Cost (LCY)", 0.01);
            end;
        }
        field(76583; Quantity; Decimal)
        {
            Caption = 'Quantity';
            Editable = false;
        }
        field(76584; "Total Cost"; Decimal)
        {
            Caption = 'Total Cost';
            Editable = false;
        }
        field(76585; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            Editable = false;
        }
        field(76586; "Line Description"; Text[100])
        {
            Caption = 'Line Description';
            Editable = false;
        }
        field(88860; "Concernee DEB"; Boolean)
        {
            Caption = 'Concernée DEB';
            Description = 'KAN.FHA 16/02/2023';
        }
    }

    keys
    {
        key(Key1; "Posted Sales Invoice No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

