tableextension 50040 SalesShipmentHeaderExtension extends "Sales Shipment Header"
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
        field(50060; Comments; Text[250])
        {
            Caption = 'Commentaires';
            DataClassification = ToBeClassified;
            Description = 'X01';
        }
        field(50072; "Prepayment deducted"; Decimal)
        {
            Caption = 'Acompte à déduire (HT)]';
            DataClassification = ToBeClassified;
        }
        field(50090; "Nombre de colis"; Decimal)
        {
            Caption = 'Nombre de colis';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            Description = 'X01';
        }
        field(50091; "Nombre de palettes"; Decimal)
        {
            Caption = 'Nombre de palettes';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            Description = 'X01';
        }
        field(50100; ASS; Boolean)
        {
            Caption = 'SAV';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 18/10/2022';
        }
        field(50130; "Total Net Weight"; Decimal)
        {
            Caption = 'Poids net total';
            DataClassification = ToBeClassified;
        }
        field(50140; "Poids brut total"; Decimal)
        {
            Caption = 'Poids brut total (pesé)';
            DataClassification = ToBeClassified;
        }
        field(50170; "Return Reason Code"; Code[10])
        {
            Caption = 'Code motif SAV';
            DataClassification = ToBeClassified;
            TableRelation = "Return Reason";
        }
        field(50190; "Code groupe"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Groupe client";
        }
        field(50200; "Code enseigne"; Code[20])
        {
            Caption = 'Code enseigne';
            DataClassification = ToBeClassified;
            TableRelation = Enseigne;
        }
        field(50210; "Code operation"; Code[20])
        {
            Caption = 'Code opération';
            DataClassification = ToBeClassified;
            TableRelation = Operations.Code where("Code enseigne" = field("Code enseigne"));
        }
        field(50220; "Code chantier"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Chantier;
        }
        field(51280; "Phase"; Integer)
        {
            Caption = 'Phase';
            DataClassification = ToBeClassified;
        }
        field(51281; "Libelle phase"; Text[50])
        {
            Caption = 'Libellé phase';
            DataClassification = ToBeClassified;
        }
        field(50305; "Facturation en compta (O/N)"; Boolean)
        {
            Caption = 'Facturation en compta (O/N)';
            DataClassification = ToBeClassified;
        }
        field(50310; "Commentaire factu."; Text[50])
        {
            Caption = 'Commentaire factu.';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 12/03/2024';
        }
        field(50550; "Factor Code"; Code[10])
        {
            Caption = 'Code banque';
            DataClassification = ToBeClassified;
            Description = 'Facto';
            TableRelation = Factor."Factor Code";
        }
        field(76888; "Code magasin remise en stock"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'DV0035';
            TableRelation = Location where("Use As In-Transit" = const(false),
                                            "Magasin bloque" = const(false));
        }
        field(76889; "Date remise en stock"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'DV0035';
        }
        field(76890; "Annee commande"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Année commande';
        }
        field(76897; "Nbre colisages"; Integer)
        {
            Caption = 'Nbre colisages';
            FieldClass = FlowField;
            CalcFormula = count("Entete colisage" where("No. expedition enregistree" = field("No.")));
            Editable = false;
        }

    }

    procedure RemettreEnStock()
    var
        ShiptLineEditCodeunit: Codeunit "Shipment Line - Edit";
    begin
        ShiptLineEditCodeunit.RemettreEnStock(Rec);
    end;

    procedure CreerColisage(pOuvrirFiche: Boolean)
    var
        EnteteColisage: Record "Entete colisage";
        DetailColisage: Record "Detail colisage";
        ContenuColisage: Record "Contenu colisage";
        LigneExpeditionEnregistree: Record "Sales Shipment Line";
        FicheColisage: page "Fiche colisage";
        NumColisage: Code[20];
        NbLignes: Integer;
        PrecisionArrondi: Decimal;
    begin
        EnteteColisage.SetCurrentKey("No. expedition enregistree");
        EnteteColisage.SetRange("No. expedition enregistree", Rec."No.");
        if not EnteteColisage.IsEmpty then
            exit;

        EnteteColisage.Reset();
        EnteteColisage.Init();
        EnteteColisage."No." := '';
        EnteteColisage.Insert(true);
        NumColisage := EnteteColisage."No.";
        EnteteColisage."Sell-to Customer No." := Rec."Sell-to Customer No.";
        EnteteColisage.Validate("No. expedition enregistree", Rec."No.");
        EnteteColisage.Phase := Phase;
        EnteteColisage."Poids brut non colise" := Rec."Poids brut total";
        EnteteColisage."Date comptabilisation" := Rec."Posting Date";
        EnteteColisage.Phase := rec.Phase;
        EnteteColisage.Modify();

        LigneExpeditionEnregistree.SetRange("Document No.", Rec."No.");
        LigneExpeditionEnregistree.SetRange(Type, LigneExpeditionEnregistree.Type::Item);
        if LigneExpeditionEnregistree.FindSet(false) then
            repeat
                if LigneExpeditionEnregistree.Quantity <> 0 then begin
                    ContenuColisage.Init();
                    ContenuColisage."No. colisage" := EnteteColisage."No.";
                    ContenuColisage."No. ligne" := LigneExpeditionEnregistree."Line No.";
                    ContenuColisage.Type := LigneExpeditionEnregistree.Type;
                    ContenuColisage."Item No." := LigneExpeditionEnregistree."No.";
                    ContenuColisage."Quantite UC" := LigneExpeditionEnregistree.Quantity;
                    ContenuColisage.Description := LigneExpeditionEnregistree.Description;
                    ContenuColisage."Shipment No." := LigneExpeditionEnregistree."Document No.";
                    ContenuColisage."Shipment Line No." := LigneExpeditionEnregistree."Line No.";
                    ContenuColisage."Order No." := Rec."Order No.";
                    ContenuColisage."Order Line No." := LigneExpeditionEnregistree."Order Line No.";
                    if LigneExpeditionEnregistree."Linked to line" <> 0 then begin
                        ContenuColisage."Type produit" := ContenuColisage."Type produit"::Composant;
                        ContenuColisage."No. ligne regroupement" := LigneExpeditionEnregistree."Linked to line";
                    end else begin
                        ContenuColisage."Type produit" := ContenuColisage."Type produit"::"Produit fini";
                        ContenuColisage."No. ligne regroupement" := ContenuColisage."No. ligne";
                    end;
                    ContenuColisage."Poids net unitaire" := LigneExpeditionEnregistree."Net Weight";
                    PrecisionArrondi := 0;
                    if ContenuColisage."Poids net unitaire" < 1 then
                        PrecisionArrondi := 0.001
                    else
                        PrecisionArrondi := 0.01;
                    ContenuColisage."Poids net ligne" := ROUND(ContenuColisage."Quantite UC" * ContenuColisage."Poids net unitaire",PrecisionArrondi);
                    ContenuColisage.Insert();
                end;
            until LigneExpeditionEnregistree.Next() = 0;

        if (Rec."Nombre de colis" >= 1) or (Rec."Nombre de palettes" >= 1) then begin
            NbLignes := 0;
            while NbLignes < Rec."Nombre de colis" do begin
                DetailColisage.Init();
                DetailColisage."No. colisage" := EnteteColisage."No.";
                DetailColisage."No. UC" := '';
                DetailColisage.Insert(true);
                DetailColisage."Type UC" := DetailColisage."Type UC"::Colis;
                DetailColisage.Modify();
                NbLignes := NbLignes + 1;
            end;

            NbLignes := 0;
            while NbLignes < Rec."Nombre de palettes" do begin
                DetailColisage.Init();
                DetailColisage."No. colisage" := EnteteColisage."No.";
                DetailColisage."No. UC" := '';
                DetailColisage.Insert(true);
                DetailColisage."Type UC" := DetailColisage."Type UC"::Palette;
                DetailColisage.Modify();
                NbLignes := NbLignes + 1;
            end;
        end;

        if pOuvrirFiche then begin
            Clear(FicheColisage);
            EnteteColisage.Setrange("No.", NumColisage);
            if EnteteColisage.FindFirst() then begin
                FicheColisage.SetTableView(EnteteColisage);
                FicheColisage.Run();
            end;
        end;
    end;
}

