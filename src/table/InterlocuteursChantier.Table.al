table 50046 "Interlocuteurs Chantier"
{
    Caption = 'Interlocuteurs Chantier';
    DrillDownPageId = InterlocuteursChantier;

    fields
    {
        field(1; "Code chantier"; Code[20])
        {
            Caption = 'Code chantier';
            TableRelation = Chantier;

            trigger OnValidate()
            var
                Chantier: Record Chantier;
            begin
                if Chantier.Get("Code chantier") then
                    "Code enseigne" := Chantier."Code enseigne";
            end;
        }
        field(5; "Code enseigne"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Enseigne;
        }
        field(6; "Type interlocuteur"; Option)
        {
            Caption = 'Type interlocuteur';
            OptionMembers = Enseigne,Autre;
            OptionCaption = 'Enseigne,Autre';
            DataClassification = ToBeClassified;
        }

        field(10; "No. interlocuteur"; Integer)
        {
            Caption = 'N° interlocuteur';
            TableRelation = if ("Type interlocuteur" = const(Enseigne)) "Interlocuteurs Enseigne"."No." where("Code enseigne" = field("Code enseigne"));
            trigger OnValidate()
            var
                InterlocuteurEnseigne: Record "Interlocuteurs Enseigne";
            begin
                IF InterlocuteurEnseigne.GET(Rec."Code enseigne", rec."No. interlocuteur") then begin
                    "Code appellation" := InterlocuteurEnseigne."Code appellation";
                    "Nom complet" := InterlocuteurEnseigne."Nom complet";
                    "No. telephone" := InterlocuteurEnseigne."No. telephone";
                    "No. telephone mobile" := InterlocuteurEnseigne."No. telephone mobile";
                    Fonction := InterlocuteurEnseigne.Fonction;
                    "E-Mail" := InterlocuteurEnseigne."E-Mail";
                    "Envoi devis/ARC" := InterlocuteurEnseigne."Envoi devis/ARC";
                    "Envoi facture" := InterlocuteurEnseigne."Envoi facture";
                    "Relances paiements" := InterlocuteurEnseigne."Relances paiements";
                end;
            end;
        }
        field(20; "Nom complet"; Text[100])
        {
            Caption = 'Nom complet';
        }
        field(90; "No. telephone"; Text[30])
        {
            Caption = 'N° téléphone';
            ExtendedDatatype = PhoneNo;
        }
        field(102; "E-Mail"; Text[80])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;
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
        }
        field(5061; "No. telephone mobile"; Text[30])
        {
            Caption = 'N° téléphone mobile';
            ExtendedDatatype = PhoneNo;
        }
        field(5101; "Code appellation"; Code[10])
        {
            Caption = 'Code appellation';
            TableRelation = Salutation;
        }
        field(5104; "Date dern. modification"; Date)
        {
            Caption = 'Date dern. modification';
            Editable = false;
        }

    }

    keys
    {
        key(PK; "Code chantier", "Type interlocuteur", "No. interlocuteur")
        {
            Clustered = true;
        }
        key(MyKey2; "Code enseigne", "Type interlocuteur", "No. interlocuteur")
        {

        }
    }

    fieldgroups
    {

    }

    
    trigger OnInsert()
    var
        InterlocuteurChantier: Record "Interlocuteurs Chantier";
    begin
        if "Type interlocuteur" = "Type interlocuteur"::Autre then begin
            InterlocuteurChantier.setrange("Code chantier", Rec."Code chantier");
            InterlocuteurChantier.Setrange("Type interlocuteur", InterlocuteurChantier."Type interlocuteur"::Autre);
            if InterlocuteurChantier.findlast() then
                Rec."No. interlocuteur" := InterlocuteurChantier."No. interlocuteur" + 1
            else
                Rec."No. interlocuteur" := 1;
        end;
    end;

    trigger OnModify()
    begin
        "Date dern. modification" := Today();
    end;


}

