tableextension 50001 SalesInvoiceLineExtension extends "Sales Invoice Line"
{
    fields
    {
        field(50008; "Annee commande"; Integer)
        {
            Caption = 'Année commande';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 06/03/2023 Pour pouvoir filtrer le montant des cdes en cours par année sur les enseignes, groupes clients et chantiers';
        }
        field(50035; "Article divers"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'ART.DIV';
        }
        field(50090; "Nomenclature produits"; Code[20])
        {
            Caption = 'Nomenclature produits';
            DataClassification = ToBeClassified;
            TableRelation = "Tariff Number";
        }
        field(50100; "Eco Tax Furniture Code"; Code[10])
        {
            Caption = 'Code taxe éco mobilier';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Taxe eco-mobilier";
        }
        field(50110; "Eco Tax Furniture Amount"; Decimal)
        {
            Caption = 'Montant taxe éco mobilier';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 4;
            Editable = false;
        }
        field(50120; "Eco Tax Furniture Qty Per"; Decimal)
        {
            Caption = 'Eco mobilier Quantité Par';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50130; "Eco Tax Furniture Line"; Boolean)
        {
            Caption = 'Ligne éco mobilier';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50140; "Eco Tax Furniture Family"; Text[50])
        {
            CalcFormula = lookup ("Taxe eco-mobilier".Family where (Code = field ("Eco Tax Furniture Code")));
            Caption = 'Famille taxe éco mobilier';
            FieldClass = FlowField;
        }
        field(50150; "Eco Tax Furniture Sub Family"; Text[50])
        {
            CalcFormula = lookup ("Taxe eco-mobilier"."Sub Family" where (Code = field ("Eco Tax Furniture Code")));
            Caption = 'Sous famille taxe éco mobilier';
            Description = 'CPT02';
            FieldClass = FlowField;
        }
        field(50160; "Price included Eco Tax"; Boolean)
        {
            Caption = 'Prix écotaxe inclus';
            DataClassification = ToBeClassified;
        }
        field(50200; "Linked to line"; Integer)
        {
            Caption = 'Lié à la ligne N°';
            DataClassification = ToBeClassified;
            Description = 'BOM';
        }
        field(50210; "Explode Line"; Boolean)
        {
            Caption = 'Ligne éclatée';
            DataClassification = ToBeClassified;
            Description = 'BOM';
        }
        field(50230; "Ligne deduction acompte"; Boolean)
        {
            Caption = 'Ligne déduction acompte';
            DataClassification = ToBeClassified;
        }
        field(50240; "Salesperson Code"; Code[10])
        {
            Caption = 'Code vendeur';
            DataClassification = ToBeClassified;
            Description = 'DIA£LBO';
            TableRelation = "Salesperson/Purchaser";


        }
        field(50250; "Reason Code"; Code[10])
        {
            Caption = 'Code motif retour';
            DataClassification = ToBeClassified;
            Description = 'DIA£LBO modification caption';
            TableRelation = "Reason Code";
        }
        field(50270; "Nature vente"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 18/06/2020';
            OptionMembers = Mobilier,"Pose/Audit",Transport,"Bennes/Fenwick",SAV;
        }
        field(51010; "Country/Region of Origin Code"; Code[10])
        {
            Caption = 'Code pays originne';
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
        field(51180; "Exclure de la rentabilite"; Boolean)
        {
            Caption = 'Exclure de la rentabilité';
            DataClassification = ToBeClassified;
        }
        field(51190; "Code groupe"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = "Groupe client";

            trigger OnValidate()
            var 
                AutresTriggersTablesCodeunit: codeunit AutresTriggersTable;
            begin
                AutresTriggersTablesCodeunit.SalesInvoiceLineOnAfterValidateCodeGroupe(Rec);
            end;
        }
        field(51200; "Code enseigne"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = Enseigne;

            trigger OnValidate()
            var
                AutresTriggersTablesCodeunit: codeunit AutresTriggersTable;
            begin
                AutresTriggersTablesCodeunit.SalesInvoiceLineOnAfterValidateCodeEnseigne(Rec);
            end;
        }
        field(51210; "Code operation"; Code[20])
        {
            Caption = 'Code opération';
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = Operations.Code where ("Code enseigne" = field ("Code enseigne"));
        }
        field(51220; "Code chantier"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = Chantier;

            trigger OnValidate()
            var
                AutresTriggersTablesCodeunit: codeunit AutresTriggersTable;
            begin
                AutresTriggersTablesCodeunit.SalesInvoiceLineOnAfterValidateCodeChantier(Rec);
            end;
        }
        field(51250; "Type ligne"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            OptionMembers = " ","Début total","Fin total";
        }
        field(88888; "Montant ligne HT (DS)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
        }
        field(88889; "Cout ligne HT (DS)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
        }
        field(88890; "Cout unitaire force"; Boolean)
        {
            Caption = 'Coût unitaire forcé';
            DataClassification = ToBeClassified;
            Description = 'KAN. Dans le cas des articles divers on dispose d''un outil sur la facture pour forcer le coût unitaire. Ce champ indique si cela a été forcé.';
        }
        field(88891; "Cout unitaire force par"; Code[50])
        {
            Caption = 'Coût unitaire forcé par';
            DataClassification = ToBeClassified;
            Description = 'KAN. Dans le cas des articles divers on dispose d''un outil sur la facture pour forcer le coût unitaire. Ce champ indique qui a forcé.';
        }
        field(88894; "Code matiere article"; Code[20])
        {
            Caption = 'Code matière article';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Matiere;
        }
        field(88895; "Montant taxe Codifab"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(88900; "Code pays livraison"; Code[10])
        {
            CalcFormula = lookup ("Sales Invoice Header"."Ship-to Country/Region Code" where ("No." = field ("Document No.")));
            Description = 'KAN.FHA 26/10/2020 CODIFAB';
            Editable = false;
            FieldClass = FlowField;
        }
        field(88910; "Cout unitaire fiche article"; Decimal)
        {
            CalcFormula = lookup (Item."Unit Cost" where ("No." = field ("No.")));
            Description = 'TmpKAN pour contrôle';
            Editable = false;
            FieldClass = FlowField;
        }
        field(88920; "PMP recalcule FHA"; Decimal)
        {
            CalcFormula = lookup ("Valorisation stock à date"."PMP recalcule" where ("No. article" = field ("No."),
                                                                                    "Code magasin" = field ("Location Code")));
            Description = 'TmpKAN pour contrôle';
            Editable = false;
            FieldClass = FlowField;
        }
        field(88921; "PMP recalcule unitaire"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 08/01/2021';
        }
        field(88922; "Cout ligne au PMP recalc"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 08/01/2021';
        }
        field(88930; "Cout detaille"; Decimal)
        {
            CalcFormula = sum ("Ecriture rentabilite"."Montant total (DS)" where ("Type document" = const (OD),
                                                                                 "No. document" = field ("Document No."),
                                                                                 "No. ligne document" = field ("Line No.")));
            Caption = 'Coût détaillé';
            Description = 'KAN.FHA 19/02/2021 Montre la somme des coûts affectés à la ligne. Cela devrait correspondre au coût unitaire de la ligne. Fait pour controle';
            Editable = false;
            FieldClass = FlowField;
        }
        field(88931; "Renta verifiee"; Boolean)
        {
            Caption = 'Renta vérifiée';
            DataClassification = ToBeClassified;
        }
        field(88940; SubTotal; Boolean)
        {
            Caption = 'Sous-total';
            DataClassification = ToBeClassified;
            Description = 'Champ 8056601 renuméroté pendant la migration BC23';
        }
        field(88950; "SubTotal Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Montant sous-total HT';
            DataClassification = ToBeClassified;
            Description = 'Champ 8056602 renuméroté pendant la migration BC23';
            Editable = false;
        }
    }

    keys
    {
        key(MyKey1; "Code groupe","Code enseigne","Code chantier","Exclure de la rentabilite","Nature vente")
        {
            SumIndexFields = "Montant ligne HT (DS)";
        }
        key(MyKey2; "Code chantier","Exclure de la rentabilite","Nature vente")
        {
            SumIndexFields = "Montant ligne HT (DS)";
        }
        key(MyKey3; "Type","No.")
        {
            
        }
        key(MyKey4; "Code matiere article","Eco Tax Furniture Code")
        {
            
        }
        key(MyKey5; "Type","Posting Date")
        {
            
        }
        key(MyKey6; "Exclure de la rentabilite")
        {
            
        }
    }
    procedure "fctKAN-----"()
    begin
    end;

    procedure EditUnitCost()
    var
        EditAddressRecord: Record "Edit Sales Invoice";
        UserSetup: Record "User Setup";
    begin
        TestField("Article divers", true);

        if not UserSetup.Get(UserId) then
            UserSetup.Init();

        UserSetup.TestField("Forcer cout sur document vente", true);

        EditAddressRecord.DeleteAll();
        EditAddressRecord.Init();
        EditAddressRecord."Posted Sales Invoice No." := "Document No.";
        EditAddressRecord."Posted Sales Invoice Line No." := "Line No.";
        EditAddressRecord."Item No." := "No.";
        EditAddressRecord."Line Description" := Description;
        EditAddressRecord."Unit Cost (LCY)" := "Unit Cost (LCY)";
        EditAddressRecord.Quantity := Quantity;
        EditAddressRecord."Total Cost" := "Cout ligne HT (DS)";
        EditAddressRecord.Insert();
        PAGE.Run(PAGE::"Edit Sales Inv. Line Unit Cost", EditAddressRecord);
    end;

    procedure VerifChampsAffaire()
    var
        Chantier: Record Chantier;
        Groupe: Record "Groupe client";
        Enseigne: Record Enseigne;
        EnAnomalie: Boolean;
        TexteAnomalie: Text[100];

        
    begin
        if Quantity = 0 then
            exit;

        if Enseigne.Get("Code enseigne") then
            if Enseigne."Enseigne interne" then begin
                EnAnomalie := false;
                MAJAnomalie(false, '');
                exit;
            end;

        EnAnomalie := false;

        if "Code chantier" = '' then begin
            EnAnomalie := true;
            TexteAnomalie := 'Chantier vide';
        end
        else
            if "Code enseigne" = '' then begin
                EnAnomalie := true;
                TexteAnomalie := 'Enseigne vide';
            end
            else
                if "Code groupe" = '' then begin
                    EnAnomalie := true;
                    TexteAnomalie := 'Groupe vide';
                end;

        if not EnAnomalie then //On a les 3 champs qui sont renseignés
            if not Enseigne.Get("Code enseigne") then begin
                EnAnomalie := true;
                TexteAnomalie := 'Enseigne inconnue';
            end else
                if not Chantier.Get("Code chantier") then begin
                    EnAnomalie := true;
                    TexteAnomalie := 'Chantier inconnu';
                end
                else
                    if not Groupe.Get("Code groupe") then begin
                        EnAnomalie := true;
                        TexteAnomalie := 'Groupe inconnu';
                    end;
        

        if not EnAnomalie then //Les 3 champs sont renseignés et les valeurs existent
            if "Code groupe" <> Enseigne."Code groupe" then begin
                EnAnomalie := true;
                TexteAnomalie := 'Groupe facture <> Groupe enseigne';
            end else
                if Chantier."Code enseigne" <> "Code enseigne" then begin
                    EnAnomalie := true;
                    TexteAnomalie := 'Enseigne facture <> Enseigne chantier';
                end;
        

        MAJAnomalie(EnAnomalie, TexteAnomalie);
    end;

    procedure MAJAnomalie(pEnAnomalie: Boolean; pTexteAnomalie: Text[100])
    var
        Anomalie: Record "Anomalies affaires ventes";
    begin
        /*FHA
        IF pEnAnomalie THEN BEGIN
          IF NOT Anomalie.GET(Anomalie."Type document"::"1","Document No.","Line No.") THEN BEGIN
            Anomalie.INIT;
            Anomalie.TRANSFERFIELDS(Rec,TRUE);
            Anomalie."Type document" := Anomalie."Type document"::"1";
            Anomalie.INSERT;
          END;
          Anomalie."Description anomalie" := pTexteAnomalie;
          Anomalie.MODIFY;
        END ELSE
          IF Anomalie.GET(Anomalie."Type document"::"1","Document No.","Line No.") THEN
            Anomalie.DELETE;
        FHA*/

    end;
}

