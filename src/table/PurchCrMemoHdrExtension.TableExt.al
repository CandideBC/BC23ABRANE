tableextension 50018 PurchCrMemoHdrExtension extends "Purch. Cr. Memo Hdr."
{
    fields
    {
        field(50008; "No. container"; Code[20])
        {
            Caption = 'N° container';
            DataClassification = ToBeClassified;
            TableRelation = Container;
        }
        field(50016; "Commande transitaire container"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50060; Comments; Text[250])
        {
            Caption = 'Commentaires';
            DataClassification = ToBeClassified;
            Description = 'X01';
        }
        field(50070; "Annee commande"; Integer)
        {
            Caption = 'Année commande';
            DataClassification = ToBeClassified;
        }
        field(50190; "Code groupe"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = "Groupe client";

            trigger OnValidate()
            var
                AutresTriggersTableCodeunit: Codeunit AutresTriggersTable;
            begin
                AutresTriggersTableCodeunit.PurchCrMemoHeaderOnValidateCodeGroupe(Rec);
            end;
        }
        field(50200; "Code enseigne"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = Enseigne;

            trigger OnValidate()
            var
                AutresTriggersTableCodeunit: Codeunit AutresTriggersTable;
            begin

                AutresTriggersTableCodeunit.PurchCrMemoHeaderOnValidateCodeEnseigne(Rec);
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
                AutresTriggersTableCodeunit.PurchCrMemoHeaderOnValidateCodeOperation(Rec);
            end;
        }
        field(50220; "Code chantier"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = Chantier;

            trigger OnValidate()
            var
                AutresTriggersTableCodeunit: Codeunit AutresTriggersTable;
            begin
                AutresTriggersTableCodeunit.PurchCrMemoHeaderOnValidateCodeChantier(Rec);
            end;
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
        field(50520; ShortCutDim5; Code[20])
        {
            CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Set ID" = field("Dimension Set ID"),
                                                                                     "Dimension Code" = const('ENSEIGNE')));
            CaptionClass = '1,2,5';
            FieldClass = FlowField;
        }
        field(50620; "Achat pour stock"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';

            trigger OnValidate()
            var
                AutresTriggersTableCodeunit: Codeunit AutresTriggersTable;



            begin
                AutresTriggersTableCodeunit.PurchCrMemoHeaderOnValidateAchatPourStock(rec);
            end;
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
    }
    keys
    {
        key(MyKey1; "Code chantier")
        {

        }
        key(MyKey2; "Code groupe", "Code enseigne", "Code chantier", "Achat pour stock")
        {

        }
        key(MyKey3; "Commande transitaire container", "No. container")
        {

        }
        key(MyKey4; "Concerne DEB", "Periode validation DEB")
        {

        }
    }

    procedure EditerLignes()
    var
        EditerLigne: Record "Editer ligne doc. enregistre";
        LigneAvoir: record "Purch. Cr. Memo Line";
        PageEditerLigne: Page EditerLigneDocEnreg;

    begin
        EditerLigne.Reset();
        EditerLigne.Setrange(EditerLigne."Type document", EditerLigne."Type document"::"Avoir enreg. achat");
        EditerLigne.SetRange("No. document", Rec."No.");
        EditerLigne.DeleteAll();

        LigneAvoir.Reset();
        LigneAvoir.SetRange("Document No.", rec."No.");
        IF LigneAvoir.FindSet(false) then begin
            repeat
                EditerLigne.Init();
                EditerLigne."Type document" := EditerLigne."Type document"::"Avoir enreg. achat";
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
            EditerLigne.SetRange("Type document", EditerLigne."Type document"::"Avoir enreg. achat");
            EditerLigne.SetRange("No. document", Rec."No.");
            EditerLigne.FilterGroup(0);

            PageEditerLigne.SetTableView(EditerLigne);
            PageEditerLigne.Run();

        end;
    end;



}

