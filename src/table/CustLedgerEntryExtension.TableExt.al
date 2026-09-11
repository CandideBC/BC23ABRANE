tableextension 50005 CustLedgerEntryExtension extends "Cust. Ledger Entry"
{
    fields
    {
        field(50000; "Nom du client"; Text[100])
        {
            CalcFormula = lookup (Customer.Name where ("No." = field ("Customer No.")));
            Caption = 'Nom client';
            Editable = false;
            FieldClass = FlowField;
        }

        field(50020; "Code groupe"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
        }
        field(50030; "Nouveau Code enseigne"; Code[20])
        {
            Caption = 'Nouveau Code enseigne';
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = Enseigne;
        }
        field(50040; "Code operation"; Code[20])
        {
            Caption = 'Code opération';
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = Operations.Code where ("Code enseigne" = field ("Nouveau Code enseigne"));
        }
        field(50050; "Code chantier"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = Chantier.Code where ("No. client" = field ("Sell-to Customer No."));
        }
        field(50060; "Facture acompte"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
        }
        field(50070; "Facture situation"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
        }
        field(50500; "Applied Cust. Ledger Entry No."; Integer)
        {
            CalcFormula = max ("Detailed Cust. Ledg. Entry"."Applied Cust. Ledger Entry No." where ("Cust. Ledger Entry No." = field ("Entry No."),
                                                                                                   "Entry Type" = const (Application),
                                                                                                   Unapplied = const (false)));
            Caption = 'Applied Cust. Ledger Entry No.';
            Description = 'TRIX.027';
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(MyKey1; "Code chantier")
        {
        }
        key(MyKey2; "Document Type",Open,"Due Date")
        {
            
        }
    }
    
}

