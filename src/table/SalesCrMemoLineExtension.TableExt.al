tableextension 50007 SalesCrMemoLineExtension extends "Sales Cr.Memo Line"
{
    fields
    {
        field(50100; "Eco Tax Furniture Code"; Code[10])
        {
            Caption = 'Code taxe éco mobilier';
            DataClassification = ToBeClassified;
            Description = 'CPT02';
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
        field(50230; "Prepayment Deducted Line"; Boolean)
        {
            Caption = 'Ligne acompte déductible';
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
            TableRelation = "Reason Code";
        }
        field(50270; "Nature vente"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 18/06/2020';
            OptionMembers = Mobilier,"Pose/Audit",Transport,"Bennes/Fenwick",SAV;
        }
        field(51180; "Exclure de la rentabilite"; Boolean)
        {
            Caption = 'Exclure de la rentabilité';
            DataClassification = ToBeClassified;
        }
        field(51190; "Code groupe"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Groupe client";
        }
        field(51200; "Code enseigne"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Enseigne;
        }
        field(51210; "Code operation"; Code[20])
        {
            Caption = 'Code opération';
            DataClassification = ToBeClassified;
            TableRelation = Operations.Code where ("Code enseigne" = field ("Code enseigne"));
        }
        field(51220; "Code chantier"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Chantier;
        }
        field(51250; "Type ligne"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Début total","Fin total";
        }
        field(88888; "Montant ligne HT (DS)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(88889; "Cout ligne HT (DS)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(88894; "Code matiere article"; Code[20])
        {
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
            CalcFormula = lookup ("Sales Cr.Memo Header"."Ship-to Country/Region Code" where ("No." = field ("Document No.")));
            Description = 'KAN.FHA 26/10/2020 CODIFAB';
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
            CalcFormula = sum ("Ecriture rentabilite"."Montant total (DS)" where ("Type document" = const(1),
                                                                                 "No. document" = field ("Document No."),
                                                                                 "No. ligne document" = field ("Line No.")));
            Caption = 'Coût détaillé';
            Editable = false;
            FieldClass = FlowField;
        }
        field(88940; "Annee commande"; Integer)
        {
            Caption = 'Année commande';
            DataClassification = ToBeClassified;
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
        key(MyKey3; "Code chantier","Exclure de la rentabilite")
        {
            SumIndexFields = "Montant ligne HT (DS)";
        }
        key(MyKey4 ; Type,"No.")
        {
            
        }
        key(MyKey5; "Code matiere article","Eco Tax Furniture Code")
        {
            SumIndexFields = "Montant taxe Codifab";
        }
    }


    procedure "fctKAN-----"()
    begin
    end;

    procedure VerifChampsAffaire()
    var
        Enseigne: Record Enseigne;
        Chantier: Record Chantier;
        Groupe: Record "Groupe client";

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
            end
            else
                if not Chantier.Get("Code chantier") then begin
                    EnAnomalie := true;
                    TexteAnomalie := 'Chantier inconnu';
                end
                else
                    if not Groupe.Get("Code groupe") then begin
                        EnAnomalie := true;
                        TexteAnomalie := 'Groupe inconnu';
                    end;
        

        if not EnAnomalie then  //Les 3 champs sont renseignés et les valeurs existent
            if "Code groupe" <> Enseigne."Code groupe" then begin
                EnAnomalie := true;
                TexteAnomalie := 'Groupe avoir <> Groupe enseigne';
            end else
                if Chantier."Code enseigne" <> "Code enseigne" then begin
                    EnAnomalie := true;
                    TexteAnomalie := 'Enseigne avoir <> Enseigne chantier';
                end;
        

        MAJAnomalie(EnAnomalie, TexteAnomalie);
    end;

    procedure MAJAnomalie(pEnAnomalie: Boolean; pTexteAnomalie: Text[100])
     
    begin
        /*FHA
        IF pEnAnomalie THEN BEGIN
          IF NOT Anomalie.GET(Anomalie."Type document"::"0","Document No.","Line No.") THEN BEGIN
            Anomalie.INIT;
            Anomalie.TRANSFERFIELDS(Rec,TRUE);
            Anomalie."Type document" := Anomalie."Type document"::"0";
            Anomalie.INSERT;
          END;
          Anomalie."Description anomalie" := pTexteAnomalie;
          Anomalie.MODIFY;
        END ELSE
          IF Anomalie.GET(Anomalie."Type document"::"0","Document No.","Line No.") THEN
            Anomalie.DELETE;
        FHA*/

    end;


}

