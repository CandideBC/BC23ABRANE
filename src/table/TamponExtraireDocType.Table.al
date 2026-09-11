table 50057 TamponExtraireDocType
{
    Caption = 'Tampon extraire doc. type';

    fields
    {
        field(1; "Code utilisateur"; Code[50])
        {
            Caption = 'Code utilisateur';
            Editable = false;
        }
        field(2; "No. ligne"; Integer)
        {
            Caption = 'N° ligne';
            Editable = false;
        }
        field(3; Type; Enum "Sales Line Type")
        {
            Caption = 'Type';
            Editable = false;


        }
        field(4; "No."; Code[20])
        {
            Caption = 'N°';
            Editable = false;
            TableRelation = if (Type = const(" ")) "Standard Text"
            else
            if (Type = const("G/L Account")) "G/L Account"
            else
            if (Type = const(Item)) Item where(Blocked = const(false))
            else
            if (Type = const(Resource)) Resource
            else
            if (Type = const("Fixed Asset")) "Fixed Asset"
            else
            if (Type = const("Charge (Item)")) "Item Charge";
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            Editable = false;
        }
        field(6; Quantite; Decimal)
        {
            BlankZero = true;
            Editable = false;
            Caption = 'Quantité';
            DecimalPlaces = 0 : 5;
        }

        field(8; "Code unite"; Code[10])
        {
            Caption = 'Code unité';
            Editable = false;
            TableRelation = if (Type = const(Item)) "Item Unit of Measure".Code where("Item No." = field("No."))
            else
            "Unit of Measure";
        }

        field(11; "Code variante"; Code[10])
        {
            Caption = 'Code variante';
            Editable = false;
            TableRelation = if (Type = const(Item)) "Item Variant".Code where("Item No." = field("No."), Blocked = const(false));
        }
        field(100; "Prix unitaire"; Decimal)
        {
            Caption = 'Prix unitaire';
            Editable = false;
            DataClassification = ToBeClassified;
            DecimalPlaces = 2:5;
            BlankZero = true;
        }        
        field(50008; "Poids net"; Decimal)
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
        field(50025; "No. fournisseur"; Code[20])
        {
            Caption = 'N° fournisseur';
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
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
        
        field(50000; "Ajouter au document"; Boolean)
        {
            Caption = 'Ajouter au document';
            DataClassification = ToBeClassified;
        }
        field(51250; "Type ligne"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            OptionMembers = " ","Début total","Fin total";
        }
        field(51270; "Type Fiche BE"; Option)
        {
            OptionMembers = " ","Pas de fiche","BE fournisseur","BE Abrane";
            DataClassification = ToBeClassified;
        }

        
        field(51290; "Phase"; Integer)
        {
            Caption = 'Code phase';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code utilisateur", "No. ligne")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    procedure SelectionMultiple(pSelectionnerTout:Boolean)
    var
        TamponExtraireLigne : Record TamponExtraireDocType;
    begin
        //Si le paramètre pSelectionnerTout vaut Oui, on sélectionne tout, sinon on déselectionne tout
        TamponExtraireLigne.SetRange("Code utilisateur",UserId);
        TamponExtraireLigne.ModifyAll("Ajouter au document",pSelectionnerTout);
    end;

    procedure EmptyLine(): Boolean
    begin
        exit(("No." = '') and (Quantite = 0))
    end;

    procedure InsertLine(): Boolean
    begin
        exit((Type = Type::" ") or (not EmptyLine()));
    end;

}