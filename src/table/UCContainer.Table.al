table 50071 "UC container"
{
    //Cette table contient juste les informations "quelles palettes et quels colis sont dans ce container"
    //Une autre table (Contenu colisage container) montre quels articles sont dans le container et permet éventuellement de faire le lien entre les UC Containers et les article (contenu)
    Caption = 'UC container';

    fields
    {
        field(1; "No. container"; Code[20])
        {
            Caption = 'N° container';
            TableRelation = Container;
        }

        field(9; "No. UC"; Code[20])
        {
            Caption = 'N° UC';

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
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("Contenu colisage container"."Poids net ligne" where("No. container" = field("No. container"), "No. UC" = field("No. UC")));
        }

        field(21; "Poids brut UC"; Decimal)
        {
            Caption = 'Poids brut de l''UC';
            DecimalPlaces = 0 : 5;
        }

        field(30; Numerotation; Code[10])
        {
            Caption = 'Numérotation';
            DataClassification = ToBeClassified;
        }
        field(40; "Numero camion"; Code[20])
        {
            Caption = 'Numéro camion';
            DataClassification = ToBeClassified;
        }
        field(42; Longueur; Integer)
        {
            Caption = 'Longueur';
            DataClassification = ToBeClassified;
            MinValue = 0;
            BlankZero = true;
            trigger OnValidate()
            begin
                if (Longueur <> 0) and (Largeur <> 0) and (Hauteur <> 0) then
                    Dimensions := format(Longueur) + 'x' + Format(Largeur) + 'x' + Format(Hauteur)
                else
                    Dimensions := '';
            end;
        }
        field(44; Largeur; Integer)
        {
            Caption = 'Largeur';
            DataClassification = ToBeClassified;
            MinValue = 0;
            BlankZero = true;
            trigger OnValidate()
            begin
                if (Longueur <> 0) and (Largeur <> 0) and (Hauteur <> 0) then
                    Dimensions := format(Longueur) + 'x' + Format(Largeur) + 'x' + Format(Hauteur)
                else
                    Dimensions := '';
            end;
        }
        field(46; Hauteur; Integer)
        {
            Caption = 'Hauteur';
            DataClassification = ToBeClassified;
            MinValue = 0;
            BlankZero = true;
            trigger OnValidate()
            begin
                if (Longueur <> 0) and (Largeur <> 0) and (Hauteur <> 0) then
                    Dimensions := format(Longueur) + 'x' + Format(Largeur) + 'x' + Format(Hauteur)
                else
                    Dimensions := '';
            end;
        }

        field(50; Dimensions; Text[20])
        {
            Caption = 'Dimensions';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(55; "No. commande achat"; Code[20])
        {
            Caption = 'N° commande achat';
            DataClassification = ToBeClassified;
            TableRelation = "Statistique container"."No. commande achat" where ("No. container"=field("No. container"));
        }

        field(58; "Statut UC"; Option)
        {
            Caption = 'Statut UC';
            OptionMembers = " ","Reçue","Expédiée";
            OptionCaption = ' ,Reçue,Expédiée';
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "No. container", "No. UC")
        {
            Clustered = true;
            SumIndexFields = "Poids brut UC";
        }
        key(MyKey2; "No. container", "Type UC")
        {

        }
        key(MyKey3; "Statut UC")
        {
            
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Type UC", "No. UC", Numerotation, "Numero camion")
        {
        }
    }

    trigger OnDelete()
    begin
        //CheckPackingStatus();
        //on supprime le colis dans toutes les lignes
        ContenuColisageContainer.Reset();
        ContenuColisageContainer.SetRange("No. container", "No. container");
        ContenuColisageContainer.SetRange("No. UC", "No. UC");
        if ContenuColisageContainer.FindSet() then
            repeat
                ContenuColisageContainer."No. UC" := '';
                ContenuColisageContainer."Poids brut ligne" := 0;
                ContenuColisageContainer."Poids net ligne" := 0;
                ContenuColisageContainer.Modify();
            until ContenuColisageContainer.Next() = 0;
    end;

    trigger OnInsert()
    begin
        SalesSetup.Get();
        SalesSetup.TestField("No. UC");
        NoSeriesMgt.InitSeries(SalesSetup."No. UC", '', 0D, "No. UC", codFiller);

        //CheckPackingStatus();
    end;

    trigger OnModify()
    begin
        //on remplace le colis dans toutes les lignes
        ContenuColisageContainer.Reset();
        ContenuColisageContainer.SetRange("No. Container", "No. Container");
        ContenuColisageContainer.SetRange("No. UC", "No. UC");
        if ContenuColisageContainer.FindSet(true) then
            repeat
                ContenuColisageContainer."Poids brut ligne" := "Poids brut UC";
                ContenuColisageContainer."Poids net ligne" := "Poids net articles";

                ContenuColisageContainer.Modify();
            until ContenuColisageContainer.Next() = 0;
    end;

    trigger OnRename()
    begin
        //on remplace le colis dans toutes les lignes
        ContenuColisageContainer.Reset();
        ContenuColisageContainer.SetRange("No. Container", "No. Container");
        ContenuColisageContainer.SetRange("No. UC", xRec."No. UC");
        if ContenuColisageContainer.FindSet(true) then
            repeat
                ContenuColisageContainer."No. UC" := "No. UC";
                ContenuColisageContainer."Poids brut ligne" := "Poids brut UC";
                ContenuColisageContainer."Poids net ligne" := "Poids net articles";
                ContenuColisageContainer.Modify();
            until ContenuColisageContainer.Next() = 0;
    end;

    var
        ContenuColisageContainer: Record "Contenu colisage container";
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        codFiller: Code[20];


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

