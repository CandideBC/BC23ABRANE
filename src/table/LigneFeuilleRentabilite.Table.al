table 50004 "Ligne feuille rentabilite"
{
    Caption = 'Ligne feuille rentabilité';
    DrillDownPageID = "Ecriture rentabilite";

    fields
    {
        field(1; "No. ligne"; Integer)
        {
            Caption = 'N° ligne';
        }
        field(2; "Code utilisateur"; Code[50])
        {
        }
        field(10; "Code chantier"; Code[20])
        {
            Caption = 'Code chantier';
            TableRelation = Chantier;
        }
        field(20; "Date comptabilisation"; Date)
        {
            Caption = 'Date comptabilisation';
        }
        field(25; "Type ecriture"; Option)
        {
            Caption = 'Type écriture';
            OptionMembers = CA,"Coût";

            trigger OnValidate()
            begin
                if "Type ecriture" = "Type ecriture"::CA then
                    "Type de cout" := "Type de cout"::" ";

                if "Type ecriture" = "Type ecriture"::CA then
                    "Type de cout" := "Type de cout"::Achat;          //Valeur par défaut
            end;
        }
        field(55; "Nature vente"; Option)
        {
            OptionMembers = " ",Mobilier,"Pose/Audit",Transport,"Bennes/Fenwick",SAV,"Indéfinie";
        }
        field(56; "Type de cout"; Option)
        {
            Caption = 'Type de coût';
            OptionMembers = " ",Stock,Achat,Approche,Emballage;

            trigger OnValidate()
            begin
                TestField("Type ecriture", "Type ecriture"::"Coût");
            end;
        }
        field(110; Quantite; Decimal)
        {
            Caption = 'Quantité';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                "Cout total (DS)" := Round(Quantite * "Cout unitaire (DS)", 0.01);
            end;
        }
        field(180; "Cout unitaire (DS)"; Decimal)
        {
            Caption = 'Coût unitaire (DS)';

            trigger OnValidate()
            begin
                "Cout total (DS)" := Round(Quantite * "Cout unitaire (DS)", 0.01);
            end;
        }
        field(190; "Cout total (DS)"; Decimal)
        {
            Caption = 'Coût total (DS)';
            Editable = false;
        }
        field(500; Description; Text[80])
        {
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



    trigger OnInsert()
    begin
        "Code utilisateur" := copystr(UserId,1,50);
    end;

    var
        Chantier: Record Chantier;
        Enseigne: Record Enseigne;
        TypeCoutObligatoireErr: Label 'Vous devez spécifier un type de coût sur la ligne %1.',Comment ='%1 = N° ligne';
        FeuilleValideeMsg: Label 'La feuille rentabilité a été validée.';
        RienAValiderMsg: Label 'Il n''y a rien à valider.';

    procedure ViderFeuille(pUserID: Code[50])
    var
        LigneFeuilleRenta: Record "Ligne feuille rentabilite";
    begin
        LigneFeuilleRenta.SetRange("Code utilisateur", pUserID);
        LigneFeuilleRenta.DeleteAll();
    end;

    procedure Valider(pUserID: Code[50])
    var
        EcritureRenta: Record "Ecriture rentabilite";
        LigneFeuilleRenta: Record "Ligne feuille rentabilite";
        NumEcr: Integer;
    begin
        LigneFeuilleRenta.SetRange("Code utilisateur", pUserID);
        LigneFeuilleRenta.CopyFilters(Rec);
        if LigneFeuilleRenta.FindSet(true) then begin
            EcritureRenta.LockTable();
            if EcritureRenta.FindLast() then
                NumEcr := EcritureRenta."No. sequence" + 1
            else
                NumEcr := 1;

            repeat
                Chantier.Get(LigneFeuilleRenta."Code chantier");
                Enseigne.Get(Chantier."Code enseigne");

                LigneFeuilleRenta.TestField("Nature vente");

                case LigneFeuilleRenta."Type ecriture" of
                    LigneFeuilleRenta."Type ecriture"::"Coût":
                        
                            if LigneFeuilleRenta."Type de cout" = LigneFeuilleRenta."Type de cout"::" " then
                                Error(TypeCoutObligatoireErr, LigneFeuilleRenta."No. ligne");

                        


                end;

                EcritureRenta.Init();
                EcritureRenta."No. sequence" := NumEcr;
                NumEcr := NumEcr + 1;
                EcritureRenta."Type document" := EcritureRenta."Type document"::OD;
                EcritureRenta."Type ecriture" := LigneFeuilleRenta."Type ecriture";
                EcritureRenta."Nature vente" := LigneFeuilleRenta."Nature vente" - 1;
                EcritureRenta."Type de cout" := LigneFeuilleRenta."Type de cout";
                EcritureRenta.Description := LigneFeuilleRenta.Description;
                EcritureRenta.Quantite := LigneFeuilleRenta.Quantite;
                EcritureRenta."Montant unitaire (DS)" := LigneFeuilleRenta."Cout unitaire (DS)";
                EcritureRenta."Montant total (DS)" := LigneFeuilleRenta."Cout total (DS)";
                EcritureRenta."Code chantier" := LigneFeuilleRenta."Code chantier";
                EcritureRenta."Code enseigne" := Chantier."Code enseigne";
                EcritureRenta."Code groupe" := Enseigne."Code groupe";
                EcritureRenta.Insert();
            until LigneFeuilleRenta.Next() = 0;
            LigneFeuilleRenta.DeleteAll();
            Message(FeuilleValideeMsg);
        end else
            Message(RienAValiderMsg);
    end;
}

