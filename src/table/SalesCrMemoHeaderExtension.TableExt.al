tableextension 50008 SalesCrMemoHeaderExtension extends "Sales Cr.Memo Header"
{
    fields
    {
        field(50020; "Surface m2"; Decimal)
        {
            Caption = 'Surface (m2)';
            DataClassification = ToBeClassified;
            Description = 'C11.01';
        }
        field(50030; "Eco Tax Furniture Liable"; Boolean)
        {
            Caption = 'Soumis taxe éco mobilier';
            DataClassification = ToBeClassified;
            Description = 'CPT02';
            InitValue = true;
        }
        field(50035; "Price included Eco Tax"; Boolean)
        {
            Caption = 'Prix écotaxe compris';
            DataClassification = ToBeClassified;
            Description = 'CPT02';
        }
        field(50040; "No. And Location Name"; Text[50])
        {
            Caption = 'N° et nom magasin';
            DataClassification = ToBeClassified;
            Description = 'X01';
        }
        field(50050; "Range No."; Text[30])
        {
            Caption = 'N° de rayon';
            DataClassification = ToBeClassified;
            Description = 'X01';
        }
        field(50060; Commentaire; Text[250])
        {
            Caption = 'Commentaires';
            DataClassification = ToBeClassified;
            Description = 'X01';
        }
        field(50072; "Prepayment deducted"; Decimal)
        {
            Caption = 'Acompte à déduire (HT)';
            DataClassification = ToBeClassified;
        }
        field(50080; Factoring; Boolean)
        {
            Caption = 'Affacturage';
            DataClassification = ToBeClassified;
            Description = 'X01';
        }
        field(50090; "Number Of Packages"; Decimal)
        {
            Caption = 'Nombre de colis';
            DataClassification = ToBeClassified;
            Description = 'X01';
        }
        field(50091; "Pallet Number"; Decimal)
        {
            Caption = 'Nombre de palettes';
            DataClassification = ToBeClassified;
            Description = 'X01';
        }
        field(50100; ASS; Boolean)
        {
            Caption = 'SAV';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 13/10/2020';
        }
        field(50120; "Amount included Ecotax"; Decimal)
        {
            BlankZero = true;
            Caption = 'Montant écotaxe inclus';
            DataClassification = ToBeClassified;
            Description = 'CPTO2';
            Editable = false;
        }
        field(50130; "Total Net Weight"; Decimal)
        {
            Caption = 'Poids net total';
            DataClassification = ToBeClassified;
        }
        field(50140; "Total Gross Weight"; Decimal)
        {
            Caption = 'Poids brut total';
            DataClassification = ToBeClassified;
        }

        field(50170; "Return Reason Code"; Code[10])
        {
            Caption = 'Code motif SAV';
            DataClassification = ToBeClassified;
            TableRelation = "Return Reason";
        }
        field(50180; "Annee commande"; Integer)
        {
            Caption = 'Année commande';
            DataClassification = ToBeClassified;
        }
        field(50190; "Code groupe"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Groupe client";

            trigger OnValidate()
            var
                AutresTriggersTableCodeunit: Codeunit AutresTriggersTable;
            begin
                AutresTriggersTableCodeunit.SalesCrMemoHeaderOnAfterValidateCodeGroupe(Rec, xRec);
            end;
        }
        field(50200; "Code enseigne"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Enseigne.Code where("Code groupe" = field("Code groupe"));

            trigger OnValidate()
            var
                AutresTriggersTableCodeunit: Codeunit AutresTriggersTable;
            begin
                AutresTriggersTableCodeunit.SalesCrMemoHeaderOnAfterValidateCodeEnseigne(rec, xRec);
            end;
        }
        field(50210; "Code operation"; Code[20])
        {
            Caption = 'Code opération';
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = Operations.Code where("Code enseigne" = field("Code enseigne"));

            trigger OnValidate()
            var
                AutresTriggersTableCodeunit: Codeunit AutresTriggersTable;
            begin
                AutresTriggersTableCodeunit.SalesCrMemoHeaderOnAfterValidateCodeOperation(rec, xRec);

            end;
        }
        field(50220; "Code chantier"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = if ("Code enseigne" = const('')) Chantier.Code where("Chantier archive" = const(false))
            else
            if ("Code enseigne" = filter(<> '')) Chantier.Code where("Chantier archive" = const(false),
                                                                                        "Code enseigne" = field("Code enseigne"));

            trigger OnValidate()
            var
                AutresTriggersTableCodeunit: Codeunit AutresTriggersTable;
            begin
                AutresTriggersTableCodeunit.SalesCrMemoHeaderOnAfterValidateCodeChantier(Rec, xRec);
            end;
        }
        field(50305; "Facturation en compta"; Boolean)
        {
            Caption = 'Facturation en compta';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 12/03/2024';
        }
        field(50310; "Commentaire factu."; Text[50])
        {
            Caption = 'Commentaire factu.';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 12/03/2024';
        }
        field(50500; ShortCutDim3; Code[20])
        {
            CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Set ID" = field("Dimension Set ID"),
                                                                                     "Dimension Code" = const('CHANTIER')));
            CaptionClass = '1,2,3';
            FieldClass = FlowField;
        }
        field(50510; ShortCutDim4; Code[20])
        {
            CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Set ID" = field("Dimension Set ID"),
                                                                                     "Dimension Code" = const('GROUPE')));
            CaptionClass = '1,2,4';
            FieldClass = FlowField;
        }
        field(50550; "Factor Code"; Code[10])
        {
            Caption = 'Code banque';
            DataClassification = ToBeClassified;
            Description = 'Facto';
            TableRelation = Factor."Factor Code";
        }
        field(60000; ShortCutDim5; Code[20])
        {
            CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Set ID" = field("Dimension Set ID"),
                                                                                     "Dimension Code" = const('ENSEIGNE')));
            CaptionClass = '1,2,5';
            FieldClass = FlowField;
        }
        field(88860; "Concerne DEB"; Boolean)
        {
            Caption = 'Concerné DEB';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 16/02/2023';
        }
        field(88870; "Periode validation DEB"; Date)
        {
            Caption = 'Période validation DEB';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 16/02/2023 Permet de savoir à quelle période comptable la facture a été déclarée. Si vide, cela veut dire qu''il faudra l''extraire sur la prochaine déclaration.';
        }
        field(88888; "Code chantier archive"; Code[20])
        {
            Caption = 'Code chantier archivé';
            DataClassification = ToBeClassified;
            Description = 'KAN. Quand renseigné, le chantier n''est pas pris en compte dans le tableau d''affaires "Enseigne" car les chiffres sont faux (vieux chantiers d''avant 2020)';
            TableRelation = Chantier;
        }
        field(88889; "Code groupe archive"; Code[20])
        {
            Caption = 'Code groupe archivé';
            DataClassification = ToBeClassified;
            Description = 'KAN';
        }
        field(88890; "Code enseigne archive"; Code[20])
        {
            Caption = 'Code enseigne archivé';
            DataClassification = ToBeClassified;
            Description = 'KAN';
        }
        field(88891; "Code operation archive"; Code[20])
        {
            Caption = 'Code opération archivé';
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = Operations.Code where("Code enseigne" = field("Code enseigne"));
        }
        field(88900; "Controle affaire OK"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN. Indique que les champs "Affaire" (Groupe, Enseigne, Chantier) ont été vérifés et sont cohérents.';
        }
    }
    keys
    {
        key(MyKey1; "Code chantier")
        {

        }
        key(MyKey2; "Code enseigne")
        {

        }
        key(MyKey3; "Bill-to Country/Region Code")
        {

        }
        key(MyKey4; "Code enseigne", "Code chantier")
        {

        }

        key(MyKey6; "Concerne DEB", "Periode validation DEB")
        {

        }
    }

    procedure EditerLignes()
    var
        EditerLigne: Record "Editer ligne doc. enregistre";
        LigneAvoir: record "Sales Cr.Memo Line";
        PageEditerLigne: Page EditerLigneDocEnreg;
    begin
        EditerLigne.Reset();
        EditerLigne.Setrange(EditerLigne."Type document", EditerLigne."Type document"::"Avoir enreg. vente");
        EditerLigne.SetRange("No. document", Rec."No.");
        EditerLigne.DeleteAll();

        LigneAvoir.Reset();
        LigneAvoir.SetRange("Document No.", rec."No.");
        IF LigneAvoir.FindSet(false) then begin
            repeat
                EditerLigne.Init();
                EditerLigne."Type document" := EditerLigne."Type document"::"Avoir enreg. vente";
                EditerLigne."No. document" := LigneAvoir."Document No.";
                EditerLigne."No. ligne document" := LigneAvoir."Line No.";
                EditerLigne.Type := LigneAvoir.Type;
                EditerLigne."No." := LigneAvoir."No.";
                EditerLigne.Description := LigneAvoir.Description;
                EditerLigne."Annee commande" := LigneAvoir."Annee commande";
                EditerLigne.Insert();
            until LigneAvoir.Next() = 0;

            Clear(PageEditerLigne);
            EditerLigne.Reset();
            EditerLigne.FilterGroup(2);
            EditerLigne.SetRange("Type document", EditerLigne."Type document"::"Avoir enreg. vente");
            EditerLigne.SetRange("No. document", Rec."No.");
            EditerLigne.FilterGroup(0);

            PageEditerLigne.SetTableView(EditerLigne);
            PageEditerLigne.Run();

        end;


    end;

}

