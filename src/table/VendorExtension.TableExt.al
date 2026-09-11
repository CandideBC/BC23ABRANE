tableextension 50031 VendorExtension extends Vendor
{
    fields
    {
        field(50000; "Fournisseur divers"; Boolean)
        {
            Caption = 'Fournisseur divers';
            DataClassification = ToBeClassified;
            Description = 'Imposera notamment la saisie du pays d''origine lors de la création de commandes d''achats depuis une vente.';
        }
        
        field(50010; "Contact Phone No."; Text[30])
        {
            CalcFormula = lookup (Contact."Phone No." where ("No." = field ("Primary Contact No.")));
            Caption = 'N° téléphone contact';
            Editable = false;
            ExtendedDatatype = PhoneNo;
            FieldClass = FlowField;
        }
        field(50020; "Contact E-Mail"; Text[80])
        {
            CalcFormula = lookup (Contact."E-Mail" where ("No." = field ("Primary Contact No.")));
            Caption = 'E-mail contact';
            Editable = false;
            ExtendedDatatype = EMail;
            FieldClass = FlowField;
        }

        field(50520; "Type fournisseur"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Type fournisseur";
        }
        field(50530; Transitaire; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50540; "Suivi container"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 02/06/2021 Les commandes d''achat saisies sur un fournisseur coché ''Suivi container" apparaitront automatiquement dans les commandes à traiter';
        }
        field(50550; "Code cond. paiement acomptes"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'Peut paraitre idiot, on mettra "COMPTANT" sur toutes les enseignes mais cela évite de coder en dur "COMPTANT"';
            TableRelation = "Payment Terms";
        }
        field(50560; "% acompte demande"; Decimal)
        {
            Caption = '% acompte demandé';

        }

    }
    keys
    {
        key(MyKey1; "Type fournisseur")
        {
            
        }
        key(MyKey2; "Registration Number")
        {
            
        }
        key(MyKey3; "VAT Registration No.")
        {
            
        }
    }
}

