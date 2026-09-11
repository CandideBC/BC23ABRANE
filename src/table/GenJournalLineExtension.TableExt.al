tableextension 50035 GenJournalLineExtension extends "Gen. Journal Line"
{
    fields
    {
        field(50000; "Facture acompte"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
        }
        field(50001; "Facture situation"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
        }
        field(50020; "Code groupe"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
        }
        field(50030; "Code enseigne"; Code[20])
        {
            Caption = 'Code enseigne';
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = Enseigne;
        }
        field(50040; "Code operation"; Code[20])
        {
            Caption = 'Code opération';
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = Operations.Code where ("Code enseigne" = field ("Code enseigne"));
        }
        field(50050; "Code chantier"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = Chantier.Code;
        }
    }

    procedure RecupNomCompte():Text[100]
    var
        Vendor: Record Vendor;
        Customer: Record Customer;
        GLAccount : Record "G/L Account";
        BankAccount : Record "Bank Account";
        NameAccountNo : Text[100];
    begin
        NameAccountNo := '';

        case "Account Type" of
            "Account Type"::Customer: 
                if Customer.GET("Account No.") then NameAccountNo := Customer.Name;
            "Account Type"::Vendor : 
                if Vendor.GET("Account No.") then NameAccountNo := Vendor.Name;
            "Account Type"::"Bank Account" : 
                if BankAccount.GET("Account No.") then NameAccountNo := BankAccount.Name;
            "Account Type"::"G/L Account" :
                 if GLAccount.GET("Account No.") then NameAccountNo := GLAccount.Name;
        end;
        exit(NameAccountNo);
    end;



}

