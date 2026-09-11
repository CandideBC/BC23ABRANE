table 50030 "Semainier chargement import"
{
    Caption = 'Semainier chargement import';
    LookupPageId = "Semainier chargement import";

    fields
    {
        field(1; "Date debut semaine"; Date) //Date de chargement
        {
            Caption = 'Date début semaine';
        }

        field(5; "No. semaine"; Integer) //Semaine de chargement
        {
            Caption = 'N° semaine';
            DataClassification = ToBeClassified;
        }

        field(6; "Date semaine reception prevue"; Date) //Date de chargement
        {
            Caption = 'Date semaine réception prévue';
        }

        field(7; "No. semaine reception prevue"; Integer) //Semaine de chargement
        {
            Caption = 'N° semaine réception prévue';
            DataClassification = ToBeClassified;
        }

        field(10; "No. fournisseur"; Code[20])
        {
            Caption = 'N° fournisseur';
            NotBlank = true;
            TableRelation = Vendor;
        }
        field(11; "Nom du fournisseur"; Text[100])
        {
            CalcFormula = lookup(Vendor.Name where("No." = field("No. fournisseur")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Code pays fournisseur"; Code[10])
        {
            Caption = 'Code pays fournisseur';
            DataClassification = ToBeClassified;
        }
        
        field(20; "Mnt restant a charger"; Decimal)
        {
            Caption = 'Montant restant à charger';
            DataClassification = ToBeClassified;
            BlankZero = true;
            DecimalPlaces = 2:2;
        }
        field(22; "Mnt restant a charger liv. dir"; Decimal)
        {
            Caption = 'Mnt restant à charger en liv. dir.';
            DataClassification = ToBeClassified;
            BlankZero = true;
            Editable = false;
            DecimalPlaces = 2:2;
        }
        field(30; "Nombre commandes"; Integer)
        {
            Caption = 'Nombre commandes';
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" where("No. fournisseur"=field("No. fournisseur"),"Suivi container" = const(true), "Suivi container OK" = const(false), "Date intention chargement" = field("Date debut semaine")));
            Editable = false;
            BlankZero = true;
        }
        field(40; "Budget approche"; Decimal)
        {
            Caption = 'Budget approche';
            DataClassification = ToBeClassified;
            BlankZero = true;
            Editable = false;
            DecimalPlaces = 2:2;
        }
        /*
        field(50; "Type transport pressenti"; Text[30])
        {
            Caption = 'Type transport pressenti';
            DataClassification = ToBeClassified;
        }
        */
        field(60; "Remplissages transport"; Text[50])
        {
            Caption = 'Remplissages transport';
            DataClassification = ToBeClassified;
            //Width = 30; 
        }
        
        field(100; "Montant VAN"; Decimal)
        {
            Caption = 'Montant VAN';
            DataClassification = ToBeClassified;
            BlankZero = true;
            DecimalPlaces = 0:2;
        }
        field(110; "Montant Porteur"; Decimal)
        {
            Caption = 'Montant Porteur';
            DataClassification = ToBeClassified;
            BlankZero = true;
            DecimalPlaces = 0:2;
        }
        field(120; "Montant Semi"; Decimal)
        {
            Caption = 'Montant Semi';
            DataClassification = ToBeClassified;
            BlankZero = true;
            DecimalPlaces = 0:2;
        }
        field(130; "Montant Container 20p"; Decimal)
        {
            Caption = 'Montant Container 20p';
            DataClassification = ToBeClassified;
            BlankZero = true;
            DecimalPlaces = 0:2;
        }
        field(140; "Montant Container 40p"; Decimal)
        {
            Caption = 'Montant Container 40p';
            DataClassification = ToBeClassified;
            BlankZero = true;
            DecimalPlaces = 0:2;
        }

    }

    keys
    {
        key(PK; "Date debut semaine", "No. fournisseur")
        {
            Clustered = true;
        }
        key(MyKey1; "No. fournisseur","Date debut semaine")
        {
        }
        key(MyKey2; "Date semaine reception prevue","No. fournisseur")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"Date debut semaine","No. semaine","Mnt restant a charger liv. dir","Mnt restant a charger","Remplissages transport","Nombre commandes")
        {
            
        }
    }


}

