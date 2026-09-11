table 50016 "Detail colisage"
{
    Caption = 'Détail colisage';

    fields
    {
        field(1; "No. colisage"; Code[20])
        {
            Caption = 'N° colisage';
            TableRelation = "Entete colisage";
        }

        field(9; "No. UC"; Code[20])
        {
            Caption = 'N° UC';

            trigger OnValidate()
            begin
                CheckPackingStatus();
            end;
        }
        field(10; "Type UC"; Option)
        {
            Caption = 'Type UC';
            DataClassification = ToBeClassified;
            OptionMembers = " ",Palette,"Colis";
            OptionCaption = ' ,Palette,Colis';
        }

        field(12; "Poids net articles"; Decimal)
        {
            BlankZero = true;
            Caption = 'Poids net des articles (KG)';
            DecimalPlaces = 0 : 5;
            FieldClass=FlowField;
            Editable = false;
            CalcFormula=sum("Contenu colisage"."Poids net ligne" where ("No. colisage"=field("No. colisage"),"No. UC"=field("No. UC")));
        }

        field(21; "Poids brut UC"; Decimal)
        {
            Caption = 'Poids brut de l''UC';
            DecimalPlaces = 0:5;
        }

        field(30;Numerotation; Code[10])
        {
            Caption = 'Numérotation';
            DataClassification = ToBeClassified;
        }
        field(40;"Numero camion"; Code[20])
        {
            Caption = 'Numéro camion';
            DataClassification = ToBeClassified;
        }
        
    }

    keys
    {
        key(Key1; "No. colisage", "No. UC")
        {
            Clustered = true;
            SumIndexFields = "Poids brut UC";
        }
        key(MyKey2; "No. colisage","Type UC")
        {
            
        }
        key(MyKey3; "No. colisage")
        {
            SumIndexFields = "Poids brut UC";
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Type UC","No. UC",Numerotation,"Numero camion")
        {
        }
    }

    trigger OnDelete()
    begin
        CheckPackingStatus();
        //on supprime le colis dans toutes les lignes
        ContenuColisage.Reset();
        ContenuColisage.SetRange("No. colisage", "No. colisage");
        ContenuColisage.SetRange("No. UC", "No. UC");
        if ContenuColisage.FindSet() then
            repeat
                ContenuColisage."No. UC" := '';
                ContenuColisage."Poids brut ligne" := 0;
                ContenuColisage."Poids net ligne" := 0;
                ContenuColisage.Modify();
            until ContenuColisage.Next() = 0;
    end;

    trigger OnInsert()
    begin
        SalesSetup.Get();
        SalesSetup.TestField("No. UC");
        NoSeriesMgt.InitSeries(SalesSetup."No. UC", '', 0D, "No. UC", codFiller);

        CheckPackingStatus();
    end;

    trigger OnModify()
    begin
        //on remplace le colis dans toutes les lignes
        ContenuColisage.Reset();
        ContenuColisage.SetRange("No. colisage", "No. colisage");
        ContenuColisage.SetRange("No. UC", "No. UC");
        if ContenuColisage.FindSet(true) then
            repeat
                ContenuColisage."Poids brut ligne" := "Poids brut UC";
                ContenuColisage."Poids net ligne" := "Poids net articles";

                ContenuColisage.Modify();
            until ContenuColisage.Next() = 0;
    end;

    trigger OnRename()
    begin
        //on remplace le colis dans toutes les lignes
        ContenuColisage.Reset();
        ContenuColisage.SetRange("No. colisage", "No. colisage");
        ContenuColisage.SetRange("No. UC", xRec."No. UC");
        if ContenuColisage.FindSet(true) then
            repeat
                ContenuColisage."No. UC" := "No. UC";
                ContenuColisage."Poids brut ligne" := "Poids brut UC";
                ContenuColisage."Poids net ligne" := "Poids net articles";
                ContenuColisage.Modify();
            until ContenuColisage.Next() = 0;
    end;

    var
        ContenuColisage: Record "Contenu colisage";
        SalesSetup: Record "Sales & Receivables Setup";
        T50016: Record "Detail colisage";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        codFiller: Code[20];

    procedure CheckPackingStatus()
    var
        lEnteteColisage: Record "Entete colisage";
        Text001Lbl: Label 'Mise à jour non autorisée avec ce statut de colisage.';
    begin
        if lEnteteColisage.Get("No. colisage") and (lEnteteColisage."Packing Status" <> 0) then
            Error(Text001Lbl);
    end;

    /*
    procedure CalcWeight(PackNo: Code[20]; ColNo: Code[20])
    var
        ITNG: Decimal;
    begin
        T50016.SetRange("No. colisage", PackNo);
        if T50016.FindFirst() then
            repeat
                ITNG := 0;
                ContenuColisage.SetRange("No. colisage", T50016."No. colisage");
                ContenuColisage.SetRange("No. UC", T50016."No. UC");
                if ContenuColisage.FindFirst() then
                    repeat
                        ITNG += ContenuColisage."Poids net ligne";
                    until ContenuColisage.Next() = 0;
                T50016.Validate("Poids net articles", ITNG);
                T50016.Validate("Poids brut UC", ITNG + T50016."Poids brut UC");
                T50016.Modify();
            until T50016.Next() = 0;
    end;
    */
}

