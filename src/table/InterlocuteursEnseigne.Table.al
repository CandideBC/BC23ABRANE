table 50043 "Interlocuteurs Enseigne"
{
    Caption = 'Interlocuteurs Enseigne';
    DataCaptionFields = "Code enseigne";
    DrillDownPageId = InterlocuteursEnseigne;

    fields
    {
        field(1; "Code enseigne"; Code[20])
        {
            Caption = 'Code enseigne';
            TableRelation = Enseigne;
            NotBlank = true;
        }
        field(2; "No."; Integer)
        {
            Caption = 'N°';
            Editable = false;
        }
        field(10; "No. contact NAV"; Code[20])
        {
            Caption = 'N° contact NAV';
        }
        field(20; "Nom complet"; Text[100])
        {
            Caption = 'Nom complet';
            trigger OnValidate()
            begin
                MAJInterlocuteursChantier(FieldNo("Nom complet"));
            end;
        }
        field(90; "No. telephone"; Text[30])
        {
            Caption = 'N° téléphone';
            ExtendedDatatype = PhoneNo;
            trigger OnValidate()
            begin
                MAJInterlocuteursChantier(FieldNo("No. telephone"));
            end;
        }
        field(102; "E-Mail"; Text[80])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;
            trigger OnValidate()
            begin
                MAJInterlocuteursChantier(FieldNo("E-Mail"));
            end;
        }
        field(200; "Envoi devis/ARC"; Boolean)
        {
            Caption = 'Envoi devis/ARC';
            DataClassification = ToBeClassified;
        }
        field(202; "Envoi facture"; Boolean)
        {
            Caption = 'Envoi factures';
            DataClassification = ToBeClassified;
        }
        field(204; "Relances paiements"; Boolean)
        {
            Caption = 'Relances paiements';
            DataClassification = ToBeClassified;
        }
        
        field(5058; Fonction; Code[20])
        {
            Caption = 'Fonction';
            TableRelation = "Table multiple".Code where (Type = const(Fonction));
            trigger OnValidate()
            begin
                MAJInterlocuteursChantier(FieldNo(Fonction));
            end;
        }
        field(5061; "No. telephone mobile"; Text[30])
        {
            Caption = 'N° téléphone mobile';
            ExtendedDatatype = PhoneNo;

            trigger OnValidate()
            begin
                MAJInterlocuteursChantier(FieldNo("No. telephone mobile"));
            end;
        }
        field(5101; "Code appellation"; Code[10])
        {
            Caption = 'Code appellation';
            TableRelation = Salutation;

            trigger OnValidate()
            begin
                MAJInterlocuteursChantier(FieldNo("Code appellation"));
            end;
        }
        field(5104; "Date dern. modification"; Date)
        {
            Caption = 'Date dern. modification';
            Editable = false;
        }
        field(5200; "Nombre chantiers interlocuteur"; Integer)
        {
            Caption = 'Nombre chantiers interlocuteur';
            FieldClass = FlowField;
            CalcFormula = count("Interlocuteurs Chantier" where("Code enseigne" = field("Code enseigne"), "No. interlocuteur" = field("No.")));
            Editable = false;
        }

    }

    keys
    {
        key(Key1; "Code enseigne", "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Nom complet", Fonction)
        {

        }
    }

    trigger OnInsert()
    var
        Enseigne: Record Enseigne;

    begin
        Enseigne.LockTable();
        Enseigne.GET("Code enseigne");
        "No." := Enseigne."Dernier No. interlocuteur cree" + 1;
        Enseigne."Dernier No. interlocuteur cree" := "No.";
        Enseigne.Modify();
    end;

    trigger OnModify()
    begin
        "Date dern. modification" := Today();
    end;

    procedure MAJInterlocuteursChantier(pFieldNo: Integer)
    var
        InterlocuteursChantier: Record "Interlocuteurs Chantier";
    begin
        InterlocuteursChantier.SetCurrentKey("Code enseigne", "Type interlocuteur","No. interlocuteur");
        InterlocuteursChantier.SetRange("Code enseigne", Rec."Code enseigne");
        InterlocuteursChantier.SetRange("Type interlocuteur",InterlocuteursChantier."Type interlocuteur"::Enseigne);
        InterlocuteursChantier.SetRange("No. interlocuteur", "No.");
        if InterlocuteursChantier.FindSet(true) then
            repeat
                case pFieldNo of
                    rec.FieldNo("Code appellation") : InterlocuteursChantier."Code appellation" := "Code appellation";
                    rec.FieldNo("Nom complet") : InterlocuteursChantier."Nom complet" := "Nom complet";
                    rec.FieldNo("No. telephone") : InterlocuteursChantier."No. telephone" := "No. telephone";
                    rec.FieldNo("No. telephone mobile") : InterlocuteursChantier."No. telephone mobile" := "No. telephone mobile";
                    rec.FieldNo(Fonction) : InterlocuteursChantier.Fonction := Fonction;
                    rec.FieldNo("E-Mail") : InterlocuteursChantier."E-Mail" := "E-Mail";
                end;
                InterlocuteursChantier.Modify();
            until InterlocuteursChantier.Next() = 0;
    end;


}

