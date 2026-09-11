table 50032 "OD CA Enseigne"
{
    Caption = 'OD CA Enseigne';
    DrillDownPageID = 50088;

    fields
    {
        field(1; "Type OD"; Option)
        {
            OptionMembers = Saisie,Contrepartie;
        }
        field(10; "Code enseigne"; Code[20])
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                if not Enseigne.Get("Code enseigne") then
                    Enseigne.Init();

                "Code groupe" := Enseigne."Code groupe";

                if "Code enseigne" <> xRec."Code enseigne" then
                    if ODEnseigne.Get(ODEnseigne."Type OD"::Contrepartie, xRec."Code enseigne", "No. sequence") then
                        ODEnseigne.Delete();
            end;
        }
        field(20; "Code groupe"; Code[20])
        {
            NotBlank = true;
        }
        field(25; "No. sequence"; Integer)
        {
        }
        field(27; Date; Date)
        {

            trigger OnValidate()
            begin
                MAJODContrepartie();
            end;
        }
        field(28; "Date contrepartie"; Date)
        {

            trigger OnValidate()
            begin
                TestField("Type OD", "Type OD"::Saisie);
                MAJODContrepartie();
            end;
        }
        field(30; "CA transfere"; Decimal)
        {
            Caption = 'CA transféré';

            trigger OnValidate()
            begin
                MAJODContrepartie();
            end;
        }
        field(40; Commentaire; Text[80])
        {
        }
    }

    keys
    {
        key(Key1; "Type OD", "Code enseigne", "No. sequence")
        {
            Clustered = true;
        }
        key(Key2; "Code enseigne")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //KAN.FHA 16/10/2020 DEBUT
        VerifDroit();
        //KAN.FHA 16/10/2020 FIN

        if ODEnseigne.Get(ODEnseigne."Type OD"::Contrepartie, xRec."Code enseigne", "No. sequence") then
            ODEnseigne.Delete();
    end;

    trigger OnInsert()
    begin
        //KAN.FHA 16/10/2020 DEBUT
        VerifDroit();
        //KAN.FHA 16/10/2020 FIN

        ODEnseigne.SetRange("Code enseigne", "Code enseigne");
        if ODEnseigne.FindLast() then
            "No. sequence" := ODEnseigne."No. sequence" + 1
        else
            "No. sequence" := 1;
    end;

    trigger OnModify()
    begin
        //KAN.FHA 16/10/2020 DEBUT
        TestField("Type OD", "Type OD"::Saisie);
        VerifDroit();
        //KAN.FHA 16/10/2020 FIN
    end;

    var
        ODEnseigne: Record "OD CA Enseigne";
        Enseigne: Record Enseigne;

    procedure MAJODContrepartie()
    begin
        if "No. sequence" = 0 then
            exit;

        if "Type OD" <> "Type OD"::Saisie then
            exit;

        if not ODEnseigne.Get(ODEnseigne."Type OD"::Contrepartie, "Code enseigne", "No. sequence") then begin
            ODEnseigne.Init();
            ODEnseigne."Type OD" := ODEnseigne."Type OD"::Contrepartie;
            ODEnseigne."Code enseigne" := "Code enseigne";
            ODEnseigne."No. sequence" := "No. sequence";
            ODEnseigne.Insert();
        end;
        ODEnseigne.Date := "Date contrepartie";
        ODEnseigne."Code groupe" := "Code groupe";
        ODEnseigne."CA transfere" := -"CA transfere";
        ODEnseigne.Modify();
    end;

    procedure VerifDroit()
    var
        ParamUtil: Record "User Setup";
        SaisieODInterditeErr: Label 'Vous n''êtes pas autorisé(e) à saisir ou modifier des OD de chiffre d''affaire.';
    begin
        if not ParamUtil.Get(UserId) then
            ParamUtil.Init();

        if not ParamUtil."Saisir OD CA sur enseignes" then
            Error(SaisieODInterditeErr);
    end;
}

