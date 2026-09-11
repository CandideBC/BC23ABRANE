table 50012 "Etiquettes palettes"
{
    // Cette table peut être remplie depuis plusieurs endroits :
    // - un container : le système va lister les chantiers présents sur les commandes d'achats liées au container et l'utilisateur indiquera combien il veut d'étiquettes pour chaque chantier

    Caption = 'Etiquettes palettes';

    fields
    {
        field(10; "Code utilisateur"; Code[50])
        {
            Caption = 'Code utilisateur';
        }
        field(20; "No. container"; Code[20])
        {
            Caption = 'N° container';
            TableRelation = Container;
        }
        field(21; "No. packing list"; Code[20])
        {
            Caption = 'N° packing list';
        }
        field(25; "No. palette"; Text[20])
        {
            Caption = 'N° palette';
        }
        field(28; Phase; Text[20])
        {
            Caption = 'Phase';
        }
        field(30; "Code enseigne"; Code[20])
        {
            Caption = 'Code enseigne';
            TableRelation = Enseigne;
        }
        field(40; "Code chantier"; Code[20])
        {
            Caption = 'Code chantier';
            TableRelation = if ("Code enseigne" = filter (<> '')) Chantier.Code where ("Code enseigne" = field ("Code enseigne"))
            else
            Chantier;

            trigger OnValidate()
            begin
                if Chantier.Get("Code chantier") then begin
                    "Nom chantier" := Chantier."Nom chantier";
                    "Nom chantier 2" := Chantier."Nom chantier 2";
                    "Adresse chantier" := Chantier."Adresse chantier";
                    "Adresse chantier 2" := Chantier."Adresse chantier 2";
                    "Code postal chantier" := Chantier."Code postal chantier";
                    "Ville chantier" := Chantier."Ville chantier";
                    "Code pays chantier" := Chantier."Code pays chantier";
                    "Contact/No. tel chantier" := CopyStr(Chantier."Contact chantier" + '-' + Chantier."No. téléphone chantier", 1, 80);
                end;
            end;
        }
        field(42; "No. commande achat"; Code[20])
        {
            Caption = 'N° commande achat';
            TableRelation = "Purchase Header"."No." where ("Document Type" = const (Order));
        }
        field(44; "Contact/No. tel chantier"; Text[80])
        {
            Caption = 'Contact/N° tél chantier';
        }
        field(50; "Nb etiquettes"; Integer)
        {
            Caption = 'Nb étiquettes';
        }
        field(100; "Nom chantier"; Text[50])
        {
            Caption = 'Nom chantier';
        }
        field(110; "Nom chantier 2"; Text[50])
        {
            Caption = 'Nom chantier 2';
        }
        field(120; "Adresse chantier"; Text[50])
        {
            Caption = 'Adresse chantier';
        }
        field(130; "Adresse chantier 2"; Text[50])
        {
            Caption = 'Adresse chantier 2';
        }
        field(140; "Code postal chantier"; Code[20])
        {
            Caption = 'Code postal chantier';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(150; "Ville chantier"; Text[30])
        {
            Caption = 'Ville chantier';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(160; "Code pays chantier"; Code[10])
        {
            Caption = 'Code pays chantier';
            TableRelation = "Country/Region";
        }
    }

    keys
    {
        key(Key1; "Code utilisateur", "No. container", "Code enseigne", "Code chantier", "No. commande achat")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Code utilisateur" := COPYSTR(UserId,1,50);
    end;

    var
        Chantier: Record Chantier;
}

