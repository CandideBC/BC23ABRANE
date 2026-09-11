tableextension 50043 StandardSalesLineExtension extends "Standard Sales Line"
{
    fields
    {
        field(50000; "Poids net"; Decimal)
        {
            BlankZero = true;
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 10/04/2020';

            trigger OnValidate()
            var
                Article: Record Item;
                PoidsPrixSurDivUniqErr: Label 'Le prix et le poids ne peuvent être saisis que sur des articles divers.';
            begin
                //KAN.FHA 10/04/2020 DEBUT
                TestField(Type, Type::Item);
                TestField("No.");
                Article.Get("No.");
                if not Article."Miscellaneous Item" then
                    Error(PoidsPrixSurDivUniqErr);
                //KAN.FHA 10/04/2020 FIN
            end;
        }
        field(50009; "Prix achat prevu"; Decimal)
        {
            Caption = 'Prix achat prévu';
            DataClassification = ToBeClassified;
            BlankZero = true;
            DecimalPlaces = 2:5;
            trigger OnValidate()
            var
                Article: Record Item;
            begin
                TestField(Type, Type::Item);
                Article.Get("No.");
                Article.TestField("Miscellaneous Item", true);
            end;
        }
        field(50010; "Prix unitaire"; Decimal)
        {
            BlankZero = true;
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 10/04/2020';

            trigger OnValidate()
            var
                Article: Record Item;
                PoidsPrixSurDivUniqErr: Label 'Le prix et le poids ne peuvent être saisis que sur des articles divers.';
            begin
                //KAN.FHA 10/04/2020 DEBUT
                TestField(Type, Type::Item);
                TestField("No.");
                Article.Get("No.");
                if not Article."Miscellaneous Item" then
                    Error(PoidsPrixSurDivUniqErr);

                //KAN.FHA 10/04/2020 FIN
            end;
        }
        field(50020; "Nomenclature produits"; Code[20])
        {
            Caption = 'Nomenclature produits';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 17/10/2022';
            TableRelation = "Tariff Number";

            trigger OnValidate()
            var

                Article: Record Item;
            begin
                TestField(Type, Type::Item);
                Article.Get("No.");
                Article.TestField("Miscellaneous Item", true);
            end;
        }
        field(50030; "Country/Region of Origin Code"; Code[10])
        {
            Caption = 'Code pays origine';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 17/10/2022';
            TableRelation = "Country/Region";

            trigger OnValidate()
            var
                Article: Record Item;
            begin
                TestField(Type, Type::Item);
                Article.Get("No.");
                Article.TestField("Miscellaneous Item", true);
            end;
        }
        field(51250; "Type ligne"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            OptionMembers = " ","Début total","Fin total";

            trigger OnValidate()
            begin
                if "Type ligne" <> "Type ligne"::" " then begin
                    TestField("No.", '');
                    Validate(Type, 0);
                end;
            end;
        }
        field(51260; SubTotal; Boolean)
        {
            Caption = 'Sous-total';
            DataClassification = ToBeClassified;
            Description = 'Champ 8056601 renuméroté pendant migration BC23';
            trigger OnValidate()
            begin
                if SubTotal then
                    TestField(Type, 0);
            end;
        }
        field(51270; "Type Fiche BE"; Option)
        {
            OptionMembers = " ","Pas de fiche","BE fournisseur","BE Abrane";
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Article: Record Item;
                TypeFicheSurDivUniqErr: Label 'Ce champ ne peut être renseigné que pour les articles Divers.';
            begin
                Rec.TestField(Type,Rec.Type::Item);
                CalcFields("Description phase");
                Rec.TestField("No.");
                Article.Get("No.");
                if not Article."Miscellaneous Item" then
                    Error(TypeFicheSurDivUniqErr);
            end;
        }
        field(51280; "Code enseigne"; Code[20])
        {
            Caption = 'Code enseigne';
            DataClassification = ToBeClassified;
            TableRelation = Enseigne;
        }
        field(51290; "Phase"; Integer)
        {
            Caption = 'Code phase';
            DataClassification = ToBeClassified;
            TableRelation = "Phases enseigne".Phase where ("Code enseigne" = field("Code enseigne"));
            BlankZero = true;
            trigger OnValidate()
            begin
                Rec.TestField(Type,Rec.Type::Item);
                CalcFields("Description phase");
            end;
        }
        field(51291; "Description phase"; Text[50])
        {
            Caption = 'Description phase';
            FieldClass = FlowField;
            CalcFormula = lookup("Phases enseigne".Description where ("Code enseigne"=field("Code enseigne"),Phase=field("Phase")));
            Editable = false;
        }
        field(51300; "No. fournisseur"; Code[20])
        {
            Caption = 'N° fournisseur';
            TableRelation = Vendor;
            trigger OnValidate()
            var
                Article: Record Item;
                NumFnsDivUniqErr: Label 'Le N° fournisseur ne peut être renseigné que sur les articles divers.';
            begin
                Rec.TestField(Type,Rec.Type::Item);
                Rec.TestField("No.");
                Article.Get("No.");
                if not Article."Miscellaneous Item" then
                    Error(NumFnsDivUniqErr);
                CalcFields("Nom fournisseur");
            end;
        }
            field(51301; "Nom fournisseur"; Text[100])
        {
            Caption = 'Nom fournisseur';
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor.Name where ("No."=field("No. fournisseur")));
            Editable = false;
        }
    }



}

