table 50066 "Unite colisage"
{
    Caption = 'Unité colisage';
    LookupPageId = "Liste unites colisage";

    fields
    {

        field(10; "No."; Code[20])
        {
            Caption = 'N°';

        }
        field(20; "Type UC"; Option)
        {
            Caption = 'Type UC';
            DataClassification = ToBeClassified;
            OptionMembers = " ",Palette,"Colis";
            OptionCaption = ' ,Palette,Colis';
        }

        field(25; "No. client"; Code[20])
        {
            Caption = 'N° client';
            DataClassification = ToBeClassified;
            TableRelation = Customer;
            trigger OnValidate()
            begin
                CalcFields("Nom client");
            end;
        }
        field(26; "Nom client"; Text[100])
        {
            Caption = 'Nom client';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where ("No."= field("No. client")));
        }

        field(28; "Statut UC"; Option)
        {
            Caption = 'Statut UC';
            OptionMembers = " ","Reçue","Expédiée";
            OptionCaption = ' ,Reçue,Expédiée';
            DataClassification = ToBeClassified;
        }

        field(30;Numerotation; Code[10])
        {
            Caption = 'Numérotation';
            DataClassification = ToBeClassified;
        }
        field(35;"No. container"; Code[20])
        {
            Caption = 'N° container';
            DataClassification = ToBeClassified;
            Editable = false; //Enregistré par le systeme quand on réceptionne le container.
        }
        field(40;"Numero camion expedition"; Code[20])
        {
            Caption = 'Numéro camion expé';
            DataClassification = ToBeClassified;
        }
        field(41;"Numero camion reception"; Code[20])
        {
            Caption = 'Numéro camion récep.';
            DataClassification = ToBeClassified;
        }
        field(42;Longueur; Integer)
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
        field(44;Largeur; Integer)
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
        field(46;Hauteur; Integer)
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

        field(50;Dimensions; Text[20])
        {
            Caption = 'Dimensions';
            DataClassification = ToBeClassified;
        }
        field(60; "Poids brut"; Decimal)
        {
            Caption = 'Poids brut';
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK ; "No.")
        {
            Clustered = true;
        }
        key(MyKey1; "No. client")
        {
            
        }
        key(MyKey2; "Statut UC")
        {
            
        }
        key(MyKey3; "Statut UC","No. client")
        {
            
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Type UC","No.",Numerotation,"Numero camion expedition")
        {
        }
    }

    trigger OnDelete()
    begin
    end;

    trigger OnInsert()
    begin
        SalesSetup.Get();
        SalesSetup.TestField("No. UC");
        NoSeriesMgt.InitSeries(SalesSetup."No. UC", '', 0D, "No.", codFiller);
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        codFiller: Code[20];

}

