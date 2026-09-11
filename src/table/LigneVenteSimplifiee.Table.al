table 50005 "Ligne vente simplifiee"
{
    Caption = 'Ligne vente simplifiée';
    DataClassification = ToBeClassified;

    fields
    {
        field(5; "Type document"; enum "Sales Document Type")
        {
            Caption = 'Type document';
        }
        field(10; "No. document"; Code[20])
        {
            Caption = 'N° document';
        }
        field(15; "No. ligne"; Integer)
        {
            Caption = 'N° ligne';
        }
        field(18; "Type ligne simplifiee"; Option)
        {
            Caption = 'Type ligne simplifiée';
            OptionMembers = Mere,Fille;
            OptionCaption = 'Mère,Fille';
        }
        field(19; "No. ligne mere"; Integer)
        {
            Caption = 'N° ligne mère';
        }
        field(20; "Type"; Enum "Sales Line Type")
        {
            Caption = 'Type';
        }
        field(30; "No."; Code[20])
        {
            Caption = 'N°';
            TableRelation = if (Type = const(" ")) "Standard Text"
            else

            if (Type = const("G/L Account")) "G/L Account"
            else
            if (Type = const(Resource)) Resource
            else
            if (Type = const("Fixed Asset")) "Fixed Asset"
            else
            if (Type = const("Charge (Item)")) "Item Charge"
            else
            if (Type = const("Allocation Account")) "Allocation Account"
            else
            if (Type = const(Item)) Item where(Blocked = const(false), "Sales Blocked" = const(false));
            //ValidateTableRelation = false;

            trigger OnValidate()
            var
                Article: Record Item;
                CompteGene: Record "G/L Account";
                TempLigneVente: Record "Sales Line" temporary;

            begin
                TempLigneVente.init();
                TempLigneVente."Document Type" := "Type document";
                TempLigneVente."Document No." := "No. document";
                TempLigneVente."Line No." := -1;
                TempLigneVente.Validate(Type, Type);
                TempLigneVente.Validate("No.", "No.");
                TempLigneVente.insert();

                Description := TempLigneVente.Description;
                "Prix unitaire" := TempLigneVente."Unit Price";

                case Type of
                    Type::Item:
                        begin
                            if not Article.get("No.") then
                                Article.Init();

                            Description := Article.Description;
                            "Article divers" := Article."Miscellaneous Item";
                            "Nomenclature produits" := Article."Tariff No.";
                            Validate("Poids unitaire", Article."Net Weight");
                            if not "Article divers" then begin
                                "No. fournisseur" := Article."Vendor No.";
                                "Code pays origine" := Article."Country/Region of Origin Code";
                            end;

                        end;
                    Type::"G/L Account":
                        begin
                            if not CompteGene.GET("No.") then
                                CompteGene.Init();

                            Description := CompteGene.Name;
                        end;
                end;
            end;
        }
        field(40; Description; Text[100])
        {
            Caption = 'Description';
            trigger OnValidate()
            var
                LigneVente: Record "Sales Line";
            begin
                If not LigneVente.GET(rec."Type document", Rec."No. document", Rec."No. ligne") then
                    exit;

                LigneVente.Validate(Description, rec.Description);
                LigneVente.Modify();
            end;
        }

        field(50045; "Ligne eclatee"; Boolean)
        {
            Caption = 'Ligne éclatée';
            DataClassification = ToBeClassified;
        }
        field(49; "Quantite pour 1"; Decimal)
        {
            Caption = 'Quantité pour 1';
            DecimalPlaces = 0 : 5;
            BlankZero = true;
            Description = 'Nombre de composants pour 1 article composé';
            trigger OnValidate()
            var
                LigneVente: Record "Sales Line";
            begin
                TestField(Type, Type::Item);

                if not LigneVente.GET(rec."Type document", Rec."No. document", Rec."No. ligne mere") then
                    exit;

                Validate(Quantite, LigneVente.Quantity * "Quantite pour 1");

            end;
        }

        field(50; Quantite; Decimal)
        {
            Caption = 'Quantité';
            DecimalPlaces = 0 : 5;
            BlankZero = true;

            trigger OnValidate()
            var
                LigneVente: Record "Sales Line";
                TempLigneVente: Record "Sales Line" temporary;
                LigneVenteFille: Record "Sales Line";
                LigneVenteSimplifiee: record "Ligne vente simplifiee";
                QteNonAutoriseeErr: Label 'Vous ne pouvez pas saisir de quantité sur une ligne sans Type.';
            begin
                if not LigneVente.GET(rec."Type document", Rec."No. document", Rec."No. ligne") then begin
                    TempLigneVente.init();
                    TempLigneVente."Document Type" := "Type document";
                    TempLigneVente."Document No." := "No. document";
                    TempLigneVente."Line No." := -1;
                    TempLigneVente.Validate(Type, Type);
                    TempLigneVente.Validate("No.", "No.");
                    TempLigneVente.insert();
                    
                    //Description := TempLigneVente.Description;
                    TempLigneVente.Validate(Quantity,Quantite);
                    Rec."prix unitaire" := TempLigneVente."Unit Price";
                    Rec."% remise ligne" := TempLigneVente."Line Discount %";
                    
                    Rec.Montant := TempLigneVente.Amount;
                    /*
                    if Type = Type::Item then begin
                        begin
                            //if not Article.get("No.") then
                            //    Article.Init();

                            //Description := Article.Description;
                            //"Article divers" := Article."Miscellaneous Item";
                            //"Nomenclature produits" := Article."Tariff No.";
                            //Validate("Poids unitaire", Article."Net Weight");
                            //if not "Article divers" then begin
                            //    "No. fournisseur" := Article."Vendor No.";
                            //    "Code pays origine" := Article."Country/Region of Origin Code";
                            //end;

                        end;
                        */
                        
                    //end;
                    exit;
                end;

                if Type = Type::" " then
                    error(QteNonAutoriseeErr);

                LigneVente."Quantite pour 1" := "Quantite pour 1";
                LigneVente.Validate(Quantity, rec.Quantite);
                LigneVente.Modify();

                Montant := LigneVente.Amount;

                LigneVenteSimplifiee.SetCurrentKey("Type document", "No. document", "Type ligne simplifiee", "No. ligne mere");
                LigneVenteSimplifiee.SetRange("Type document", "Type document");
                LigneVenteSimplifiee.SetRange("No. document", "No. document");
                LigneVenteSimplifiee.SetRange("Type ligne simplifiee", LigneVenteSimplifiee."Type ligne simplifiee"::Fille);
                LigneVenteSimplifiee.SetRange("No. ligne mere", "No. ligne");
                if LigneVenteSimplifiee.FindSet(true) then
                    repeat
                        LigneVenteFille.get(LigneVenteSimplifiee."Type document", LigneVenteSimplifiee."No. document", LigneVenteSimplifiee."No. ligne");
                        LigneVenteSimplifiee.Quantite := LigneVenteFille.Quantity;
                        LigneVenteSimplifiee.Montant := LigneVenteFille.Amount;
                        LigneVenteSimplifiee.Modify();
                    until LigneVenteSimplifiee.Next() = 0;

            end;
        }
        field(55; "Poids unitaire"; Decimal)
        {
            Caption = 'Poids unitaire';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                LigneVente: Record "Sales Line";
            begin
                if CurrFieldNo = FieldNo("Poids unitaire") then
                    TestField("Article divers", true);
                if not LigneVente.GET(rec."Type document", Rec."No. document", Rec."No. ligne") then
                    exit;

                LigneVente.Validate("Net Weight", "Poids unitaire");
                LigneVente.Modify();
            end;
        }
        field(60; "Quantite livree"; Decimal)
        {
            Caption = 'Quantite livrée';
            Editable = false;
            DecimalPlaces = 0 : 5;
            BlankZero = true;
        }
        field(70; "Quantite facturee"; Decimal)
        {
            Caption = 'Quantite facturée';
            Editable = false;
            DecimalPlaces = 0 : 5;
            BlankZero = true;
        }
        field(75; "Cout unitaire (DS)"; Decimal)
        {
            Caption = 'Coût unitaire (DS)';
        }
        field(80; "Prix unitaire"; Decimal)
        {
            Caption = 'Prix unitaire';
            BlankZero = true;
            trigger OnValidate()
            var
                LigneVente: Record "Sales Line";
                PasDePrixVenteSurComposantErr: Label 'Un composant ne peut pas avoir de prix de vente.';
            begin

                if not LigneVente.GET(rec."Type document", Rec."No. document", Rec."No. ligne") then begin
                    Montant := round((Quantite * "Prix unitaire") * (1 - "% remise ligne" / 100), 0.01);
                    exit;
                end;

                if "Type ligne simplifiee" = "Type ligne simplifiee"::Fille then
                    error(PasDePrixVenteSurComposantErr);

                LigneVente.Validate("Unit Price", rec."Prix unitaire");
                LigneVente.Modify();

                Montant := LigneVente.Amount;
                "% remise ligne" := LigneVente."Line Discount %";

            end;
        }
        field(82; "% remise ligne"; Decimal)
        {
            Caption = '% remise ligne';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            BlankZero = true;

            trigger OnValidate()
            var
                LigneVente: Record "Sales Line";
            begin
                if LigneVente.GET(rec."Type document", Rec."No. document", Rec."No. ligne") then begin
                    LigneVente.Validate("Line Discount %", "% remise ligne");
                    //KAN.FHA 22/05/2026 DEBUT
                    LigneVente.Modify();
                    //KAN.FHA 22/05/2026 FIN
                    Montant := LigneVente.Amount;
                end else
                    Montant := Round(Quantite * "Prix unitaire" * (1 - "% remise ligne" / 100), 0.01);
            end;
        }

        field(90; Montant; Decimal)
        {
            Caption = 'Montant';
            BlankZero = true;
            Trigger OnValidate()
            var
                LigneVente: Record "Sales Line";
            begin
                if LigneVente.GET(rec."Type document", Rec."No. document", Rec."No. ligne") then begin
                    LigneVente.Validate(Amount, Montant);
                    "% remise ligne" := LigneVente."Line Discount %";
                end else
                    if Quantite <> 0 then
                        "% remise ligne" := 1 - Round((Montant / Quantite * "Prix unitaire"), 0.01);

            end;
        }
        field(100; "Nouveau No. ligne"; Integer)
        {
            //Sert uniquement lorsqu'on reassigne un N° ligne aux lignes
            Caption = 'Nouveau No. ligne';
            DataClassification = ToBeClassified;
        }
        field(5402; "Code variante"; Code[10])
        {
            Caption = 'Code variante';
            TableRelation = if (Type = const(Item)) "Item Variant".Code where("Item No." = field("No."), Blocked = const(false), "Sales Blocked" = const(false))
            else
            if (Type = const(Item)) "Item Variant".Code where("Item No." = field("No."), Blocked = const(false));
            ValidateTableRelation = false;


            trigger OnValidate()
            var
                LigneVente: Record "Sales Line";
            begin
                if not LigneVente.GET(rec."Type document", Rec."No. document", Rec."No. ligne") then
                    exit;

                LigneVente.Validate("Variant Code", Rec."Code variante");
                LigneVente.Modify();
            end;

        }
        field(50036; "Type Fiche BE"; Option)
        {
            OptionMembers = " ","Pas de fiche","BE fournisseur","BE Abrane";
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                LigneVente: Record "Sales Line";
            begin
                if not LigneVente.GET(rec."Type document", Rec."No. document", Rec."No. ligne") then
                    exit;

                LigneVente.Validate("Type Fiche BE", Rec."Type Fiche BE");
                LigneVente.Modify();
            end;
        }
        field(50039; "Prix achat prevu"; Decimal)
        {
            Caption = 'Prix achat prévu';
            DataClassification = ToBeClassified;
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            trigger OnValidate()
            var
                LigneVente: Record "Sales Line";

            begin
                if CurrFieldNo = Rec.FieldNo("Prix achat prevu") then
                    Rec.TestField("Article divers", true);

                if not LigneVente.GET(Rec."Type document", Rec."No. document", Rec."No. ligne") then
                    exit;

                LigneVente.Validate("Prix achat prevu", Rec."Prix achat prevu");
                LigneVente.Modify();
            end;
        }

        field(50200; "Linked to line No."; Integer)
        {
            Caption = 'Lié à la ligne N°';
            DataClassification = ToBeClassified;
            Description = 'Pour les composants';
        }
        field(50201; "Attached to Line No."; Integer)
        {
            Caption = 'Attaché à la ligne N°';
            Editable = false;
        }
        field(50300; "No. fournisseur"; Code[20])
        {
            Caption = 'N° fournisseur';
            DataClassification = ToBeClassified;
            TableRelation = Vendor;

            trigger OnValidate()
            var
                LigneVente: Record "Sales Line";
                Fournisseur: Record Vendor;
                Article: Record Item;

            begin
                if Fournisseur.get("No. fournisseur") then
                    "Code pays origine" := Fournisseur."Country/Region Code"
                else
                    "Code pays origine" := '';

                if not LigneVente.GET(rec."Type document", Rec."No. document", Rec."No. ligne") then
                    exit;

                //KAN.FHA 26/05/2026 DEBUT
                if Rec.Type = Rec.Type::Item then begin
                    if not Article.get(Rec."No.") then
                        Article.Init();
                    //Pas de validate car le validate du vendor no sur la LigneVente fera la mise à jour mais on a besoin de l'info sur la ligne vente simplifiée :
                    "Prix achat prevu" := Article.PrixAchatActuel("No. fournisseur");
                end;
                //KAN.FHA 26/05/2026 FIN
                LigneVente.Validate("Vendor No.", Rec."No. fournisseur");
                LigneVente."Country/Region of Origin Code" := "Code pays origine";
                LigneVente.Modify();
            end;
        }
        field(50310; "Code magasin"; Code[10])
        {
            Caption = 'Code magasin';
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(50320; "Code pays origine"; Code[10])
        {
            Caption = 'Code pays origine';
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
            trigger OnValidate()
            var
                LigneVente: Record "Sales Line";
            begin
                TestField("Article divers", true);
                if not LigneVente.GET(rec."Type document", Rec."No. document", Rec."No. ligne") then
                    exit;

                LigneVente."Country/Region of Origin Code" := Rec."Code pays origine";
                LigneVente.Modify();
            end;
        }
        field(50330; "Type ligne"; Option)
        {
            Caption = 'Type ligne';
            DataClassification = ToBeClassified;
            OptionMembers = " ","Début total","Fin total";

            trigger OnValidate()
            var
                txtSousTotalTxt: Label 'Sous-total';
            begin
                if "Type ligne" <> "Type ligne"::" " then begin
                    TestField("No.", '');
                    Validate(Type, 0);
                end;

                if "Type ligne" = "Type ligne"::"Fin total" then
                    Description := txtSousTotalTxt;
            end;
        }
        field(50335; "Article divers"; Boolean)
        {
            Caption = 'Article divers';
            DataClassification = ToBeClassified;
        }

        field(50340; "Nomenclature produits"; Code[20])
        {
            Caption = 'Nomenclature produits';
            DataClassification = ToBeClassified;
            TableRelation = "Tariff Number";

            trigger OnValidate()
            var
                LigneVente: Record "Sales Line";
            begin
                TestField("Article divers", true);
                if not LigneVente.GET(rec."Type document", Rec."No. document", Rec."No. ligne") then
                    exit;

                LigneVente.Validate("Nomenclature produits", rec."Nomenclature produits");
                LigneVente.Modify();
            end;
        }
        field(50350; "Eco Tax Furniture Code"; Code[10])
        {
            Caption = 'Code taxe éco mobilier';
            DataClassification = ToBeClassified;
            Description = 'CPT02';
            Editable = false;
            TableRelation = "Taxe eco-mobilier";
        }
        field(50360; "Eco Tax Furniture Amount"; Decimal)
        {
            Caption = 'Montant taxe éco mobilier';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 4;
            Description = 'CPT02';
            Editable = false;
        }
        field(50370; "Eco Tax Furniture Qty Per"; Decimal)
        {
            Caption = 'Eco mobilier Quantité Par';
            DataClassification = ToBeClassified;
            Description = 'CPT02';
            Editable = false;
        }
        field(50380; "Eco Tax Furniture Line"; Boolean)
        {
            Caption = 'Ligne éco mobilier';
            DataClassification = ToBeClassified;
            Description = 'CPT02';
            Editable = false;
        }
        field(50998; "Ligne devis existe"; Boolean)
        {
            Caption = 'Ligne devis existe';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("Sales Line" where("Document Type" = field("Type document"), "Document No." = field("No. document"), "Line No." = field("No. ligne")));
        }
        field(51280; Phase; Integer)
        {
            Caption = 'Phase';
            DataClassification = ToBeClassified;
            TableRelation = "Phases document".Phase where("No. document" = field("No. document"));
            BlankZero = true;
            MinValue = 0;

            trigger OnValidate()
            var
                LigneVente: Record "Sales Line";
                LigneVenteSimplifiee: Record "Ligne vente simplifiee";

                intChoix: Integer;
                ChoixMAJComposantsQst: Label 'Mettre à jour tous les composants,Que les composants qui avaient la même phase';
            begin
                TestField(Type, Type::Item);
                TestField("No.");

                if not LigneVente.GET(rec."Type document", Rec."No. document", Rec."No. ligne") then
                    exit;

                //On met à jour la phase sur la ligne vente directement liée (et cela mettra aussi à jour la phase sur la ligne ecocontribution si presente)
                LigneVente.Validate(Phase, Rec.Phase);
                LigneVente.Modify();

                //On va regarder si l'article est composé et dans ce cas si les composants étaient sur la même phase que le composé dont on vient de changer la phase.
                //- S'ils étaient de la même phase, on ne demande rien, on les met sur la même phase.
                //- S'il y en avait au moins un sur une phase différente, on demande à l'utilisateur s'il veut mettre à jour tous les composants
                //ou juste ceux qui avaient la même phase
                LigneVenteSimplifiee.SetCurrentKey("Type document", "No. document", "Type ligne simplifiee", "No. ligne mere");
                LigneVenteSimplifiee.SetRange("Type document", "Type document");
                LigneVenteSimplifiee.SetRange("No. document", "No. document");
                LigneVenteSimplifiee.SetRange("Type ligne simplifiee", LigneVenteSimplifiee."Type ligne simplifiee"::Fille);
                LigneVenteSimplifiee.SetRange("No. ligne mere", "No. ligne");
                //KAN.FHA 26/05/2026 DEBUT
                LigneVenteSimplifiee.SetRange(Type, LigneVenteSimplifiee.Type::Item);
                //KAN.FHA 26/05/2026 FIN
                if not LigneVenteSimplifiee.IsEmpty then begin
                    //On commence par regarder parmi les composants s'il y en avait sur une autre phase
                    LigneVenteSimplifiee.SetFilter(Phase, '<>%1', xRec.Phase);
                    repeat
                        LigneVenteSimplifiee.SetRange(Phase);
                        //KAN.FHA 26/05/2026 DEBUT
                        //J'enlève le filtre sur le type pour eventuellement mettre à jour la phase sur des lignes d'écopart
                        LigneVenteSimplifiee.SetRange(Type);
                        //KAN.FHA 26/05/2026 FIN
                        intChoix := StrMenu(ChoixMAJComposantsQst, 1);
                        case intChoix of
                            1: //Mettre à jour la phase sur tous les composants
                                begin
                                    LigneVenteSimplifiee.Findset(true);
                                    repeat
                                        LigneVenteSimplifiee.Phase := Phase;
                                        LigneVenteSimplifiee.Modify();
                                        if LigneVente.GET(LigneVenteSimplifiee."Type document", LigneVenteSimplifiee."No. document", LigneVenteSimplifiee."No. ligne") then begin
                                            LigneVente.Phase := Phase;
                                            LigneVente.Modify();
                                        end;
                                    until LigneVenteSimplifiee.Next() = 0;
                                end;
                            2:  //Mettre à jour la phase que sur les composants qui avaient la même phase
                                begin
                                    LigneVenteSimplifiee.Findset(true);
                                    repeat
                                        if LigneVenteSimplifiee.Phase = xRec.Phase then begin
                                            LigneVenteSimplifiee.Phase := Phase;
                                            LigneVenteSimplifiee.Modify();
                                            if LigneVente.GET(LigneVenteSimplifiee."Type document", LigneVenteSimplifiee."No. document", LigneVenteSimplifiee."No. ligne") then begin
                                                LigneVente.Phase := Phase;
                                                LigneVente.Modify();
                                            end;
                                        end;
                                    until LigneVenteSimplifiee.Next() = 0;
                                end;
                        end;

                    until LigneVenteSimplifiee.Next() = 0;
                end;
            end;

        }
    }
    keys
    {
        key(PK; "Type document", "No. document", "No. ligne")
        {
            Clustered = true;
        }
        key(MyKey1; "Type document", "No. document", "Type ligne simplifiee", "No. ligne mere")
        {

        }
    }
    trigger OnInsert()
    var
        EnteteVente: Record "Sales Header";

    begin
        EnteteVente.Get("Type document", "No. document");
        "Code magasin" := EnteteVente."Location Code";
    end;

    trigger OnDelete()
    var
        LigneVente: Record "Sales Line";
        SuppressionEcoTaxeErr: Label 'Vous ne pouvez pas supprimer la ligne d''éco-contribution.';
    begin
        if "Eco Tax Furniture Line" then
            error(SuppressionEcoTaxeErr);

        if LigneVente.GET(rec."Type document", Rec."No. document", Rec."No. ligne") then
            LigneVente.Delete(true);
    end;

    procedure MAJDevisNecessaire(): Boolean;
    var
        LigneVenteSimplifiee: Record "Ligne vente simplifiee";
        MAJNecessaire: Boolean;

    begin
        MAJNecessaire := false;
        LigneVenteSimplifiee.SetRange("Type document", "Type document");
        LigneVenteSimplifiee.SetRange("No. document", "No. document");
        if LigneVenteSimplifiee.FindSet(false) then
            repeat
                LigneVenteSimplifiee.CalcFields("Ligne devis existe");
                MAJNecessaire := not LigneVenteSimplifiee."Ligne devis existe";
            until MAJNecessaire or (LigneVenteSimplifiee.Next() = 0);

        exit(MAJNecessaire);
    end;

    procedure CreerLignesVentes()
    var
        LigneMere: Record "Ligne vente simplifiee";
        LigneFille: Record "Ligne vente simplifiee";
        LigneVente: Record "Sales Line";
        Article: Record item;
        EclaterBOM: codeunit "Eclater nomenclature ABRANE";
        dNegDEEE: Codeunit "Gestion Ecopart";
    begin
        LigneMere.SetRange("Type document", "Type document");
        LigneMere.SetRange("No. document", "No. document");
        LigneMere.SetRange("Type ligne simplifiee", LigneMere."Type ligne simplifiee"::Mere); //On ne devrait pas avoir d'autres lignes à ce stade normalement
        if LigneMere.FindSet(false) then begin
            LigneFille.SetRange("Type document", "Type document");
            LigneFille.SetRange("No. document", "No. document");
            LigneFille.SetRange("Type ligne simplifiee", LigneMere."Type ligne simplifiee"::Fille);

            //Première boucle pour créer les lignes d'articles (composés et articles indépendants)
            repeat
                if not LigneVente.get(LigneMere."Type document", LigneMere."No. document", LigneMere."No. ligne") then begin
                    LigneVente.init();
                    LigneVente."Document Type" := LigneMere."Type document";
                    LigneVente."Document No." := LigneMere."No. document";
                    LigneVente."Line No." := LigneMere."No. ligne";
                    LigneVente.Validate(Type, LigneMere.Type);
                    LigneVente.Validate("No.", LigneMere."No.");
                    //KAN.FHA 13/05/2026 DEBUT
                    LigneVente.Validate("Variant Code", LigneMere."Code variante");
                    //KAN.FHA 13/05/2026 FIN
                    LigneVente.Description := LigneMere.Description;
                    LigneVente.Validate(Quantity, LigneMere.Quantite);
                    LigneVente.Validate("Unit Price", LigneMere."Prix unitaire");
                    LigneVente.Validate("Line Discount %", LigneMere."% remise ligne");
                    if LigneVente."Article divers" then begin
                        LigneVente."Vendor No." := LigneMere."No. fournisseur";
                        LigneVente."Nomenclature produits" := LigneMere."Nomenclature produits";
                        LigneVente."Country/Region of Origin Code" := LigneMere."Code pays origine";
                        LigneVente."Net Weight" := LigneMere."Poids unitaire";
                        //KAN.FHA 22/05/2026 DEBUT
                        LigneVente.Phase := LigneMere.Phase;
                        //KAN.FHA 22/05/2026 FIN

                    end;
                    LigneVente."Type ligne" := LigneMere."Type ligne";
                    //KAN.FHA 20/05/2026 DEBUT
                    if (LigneVente.Type = LigneVente.Type::Item) and (LigneVente."Article divers") then begin
                        LigneVente.Validate("Type Fiche BE", LigneMere."Type Fiche BE");
                        if LigneMere."Prix achat prevu" <> 0 then
                            LigneVente.Validate("Prix achat prevu", LigneMere."Prix achat prevu");
                    end;
                    //KAN.FHA 20/05/2026 FIN
                    LigneVente.insert();
                end;
            until LigneMere.Next() = 0;

            //2e boucle pour éclater les éventuels articles composés
            LigneMere.findset(false);
            repeat
                if LigneMere.Type = LigneMere.Type::Item then begin
                    LigneVente.get(LigneMere."Type document", LigneMere."No. document", LigneMere."No. ligne");
                    if not Article.get(LigneVente."No.") then
                        Article.init();
                    Article.CalcFields("Assembly BOM");

                    //KAN.FHA 17/04/2025 DEBUT
                    if (LigneVente."Eco Tax Furniture Code" <> '') and (not Article."Assembly BOM") then
                        if dNegDEEE.SalesCheckIfAnyWEEE(LigneVente) then
                            dNegDEEE.InsertWEEELine(LigneVente);

                    //KAN.FHA 17/04/2025 FIN    
                    if article."Assembly BOM" and (not LigneVente."Ligne eclatee") then
                        EclaterBOM.RUN(LigneVente);
                end;
            until LigneMere.Next() = 0;
        end;

    end;

    procedure ReassignerNumerosLigne()
    var
        LigneVenteSimplifiee: Record "Ligne vente simplifiee";
        LigneMere: Record "Ligne vente simplifiee";
        LigneVente: Record "Sales Line";
        NumLigneMere: Integer;
        NumLigneFille: Integer;
    begin
        //Le but de cette fonction est de pouvoir reassigner un N° ligne aux lignes du devis/de la commande.
        //En effet, il arrive souvent qu'on ait au debut des lignes 10000 et 20000 mais s'ajoutent ensuite les composants de l'article 10000
        //qui prennent alors des numéros entre 10000 et 20000 mais ensuite on ajoute un autre meuble qui va aussi s'éclater en composants...
        //Le fait d'avoir une saisie simplifiée des devis/commandes devient compliqué dans ce contexte.
        //Avec cette fonction, on va chercher à avoir les lignes "Principales" numérotées de 10000 en 10000 et les composants de 200 en 200

        //La fonction va d'abord vider les lignes du devis puis les recréer à partir du contenu de cette table Ligne vente simplifiée
        //Dans un 2e temps, une fois les lignes de devis/commandes recréées, on va vide la table Ligne vente simplifiée (les lignes
        //où on se trouve ne correspondraient plus aux N° lignes réassignés aux lignes du devis/commande)

        //On vide le devis/la commande (le standard va empecher cela si une ligne a été livrée et c'est tant mieux)
        LigneVente.setrange("Document Type", "Type document");
        LigneVente.SetRange("Document No.", "No. document");
        LigneVente.SetFilter("Line No.", '>%1', 2); //Pour ne pas supprimer la ligne de déduction de l'acompte / de situation (Lignes 1 et 2)
        LigneVente.DeleteAll(true);

        LigneVenteSimplifiee.SetRange("Type document", "Type document");
        LigneVenteSimplifiee.SetRange("No. document", "No. document");

        if LigneVenteSimplifiee.FindSet(true) then begin
            NumLigneMere := 0;
            repeat
                if LigneVenteSimplifiee."Type ligne simplifiee" = LigneVenteSimplifiee."Type ligne simplifiee"::Mere then begin
                    NumLigneMere := NumLigneMere + 10000;
                    NumLigneFille := NumLigneMere;
                end;
                LigneVente.init();
                LigneVente."Document Type" := LigneVenteSimplifiee."Type document";
                LigneVente."Document No." := LigneVenteSimplifiee."No. document";
                if LigneVenteSimplifiee."Type ligne simplifiee" = LigneVenteSimplifiee."Type ligne simplifiee"::Fille then begin
                    NumLigneFille := NumLigneFille + 200;
                    LigneVente."Line No." := NumLigneFille;
                end else
                    LigneVente."Line No." := NumLigneMere;

                LigneVenteSimplifiee."Nouveau No. ligne" := LigneVente."Line No.";
                LigneVenteSimplifiee.Modify();

                LigneVente.Validate(Type, LigneVenteSimplifiee.Type);
                LigneVente.Validate("No.", LigneVenteSimplifiee."No.");
                LigneVente.Validate(Quantity, LigneVenteSimplifiee.Quantite);
                //KAN.FHA 20/05/2026 DEBUT
                LigneVente.Validate("Line Discount %", LigneVenteSimplifiee."% remise ligne");
                //KAN.FHA 20/05/2026 FIN
                if LigneVenteSimplifiee."No. ligne mere" <> 0 then begin
                    LigneMere.GET(LigneVenteSimplifiee."Type document", LigneVenteSimplifiee."No. document", LigneVenteSimplifiee."No. ligne mere");
                    IF LigneVenteSimplifiee."Attached to Line No." <> 0 then
                        LigneVente."Attached to Line No." := LigneMere."Nouveau No. ligne"
                    else //Alors c'est le 2e champ de lien, [Attached to line N°]
                        LigneVente."Linked to line" := LigneMere."Nouveau No. ligne";
                end;
                LigneVente.Description := LigneVenteSimplifiee.Description;
                if LigneVente."Location Code" <> LigneVenteSimplifiee."Code magasin" then
                    LigneVente.Validate("Location Code", LigneVenteSimplifiee."Code magasin");
                Lignevente."Country/Region of Origin Code" := LigneVenteSimplifiee."Code pays origine";
                LigneVente."Nomenclature produits" := LigneVenteSimplifiee."Nomenclature produits";
                LigneVente."Eco Tax Furniture Amount" := LigneVenteSimplifiee."Eco Tax Furniture Amount";
                LigneVente."Eco Tax Furniture Code" := LigneVenteSimplifiee."Eco Tax Furniture Code";
                LigneVente."Eco Tax Furniture Qty Per" := LigneVenteSimplifiee."Eco Tax Furniture Qty Per";
                LigneVente."Eco Tax Furniture Line" := LigneVenteSimplifiee."Eco Tax Furniture Line";
                LigneVente."Type ligne" := LigneVenteSimplifiee."Type ligne";
                LigneVente."Vendor No." := LigneVenteSimplifiee."No. fournisseur";
                LigneVente."Ligne eclatee" := LigneVenteSimplifiee."Ligne eclatee";
                LigneVente.insert();
            until LigneVenteSimplifiee.Next() = 0;
            LigneVenteSimplifiee.DeleteAll(); //Pour éviter de remettre à jour les lignes qui sont à l'écran puisque leur numero de ligne ne correspond plus aux lignes ventes recrees
        end;
    end;

    procedure ExtraireDocumentType(var SalesHeader: Record "Sales Header")
    var
        StdCustSalesCode: Record "Standard Customer Sales Code";
        StdCustSalesCodes: Page "Standard Customer Sales Codes";
    begin
        SalesHeader.TestField("No.");
        SalesHeader.TestField("Sell-to Customer No.");

        StdCustSalesCode.FilterGroup := 2;
        StdCustSalesCode.SetRange("Customer No.", SalesHeader."Sell-to Customer No.");
        StdCustSalesCode.FilterGroup := 0;

        StdCustSalesCodes.SetTableView(StdCustSalesCode);
        StdCustSalesCodes.LookupMode(true);
        if StdCustSalesCodes.RunModal() = ACTION::LookupOK then begin
            StdCustSalesCodes.GetSelected(StdCustSalesCode);
            if StdCustSalesCode.FindSet() then
                repeat
                    ExtraireLigneRecurrente(SalesHeader, StdCustSalesCode);
                until StdCustSalesCode.Next() = 0;
        end;
    end;

    procedure ExtraireLigneRecurrente(var SalesHeader: Record "Sales Header"; StdCustSalesCode: Record "Standard Customer Sales Code")
    var
        Currency: Record Currency;
        StdSalesLine: Record "Standard Sales Line";
        StdSalesCode: Record "Standard Sales Code";
        LigneVenteSimplifiee: Record "Ligne vente simplifiee";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if not IsHandled then begin
            Currency.Initialize(SalesHeader."Currency Code");

            if StdCustSalesCode.Blocked then
                exit;

            StdCustSalesCode.TestField(Code);
            StdCustSalesCode.TestField("Customer No.", SalesHeader."Sell-to Customer No.");
            StdSalesCode.Get(StdCustSalesCode.Code);
            StdSalesCode.TestField("Currency Code", SalesHeader."Currency Code");
            StdSalesLine.SetRange("Standard Sales Code", StdCustSalesCode.Code);
            LigneVenteSimplifiee."Type Document" := SalesHeader."Document Type";
            LigneVenteSimplifiee."No. document" := SalesHeader."No.";
            LigneVenteSimplifiee.SetRange("Type Document", SalesHeader."Document Type");
            LigneVenteSimplifiee.SetRange("No. document", SalesHeader."No.");

            LigneVenteSimplifiee.LockTable();
            StdSalesLine.LockTable();
            if StdSalesLine.Find('-') then
                repeat
                    LigneVenteSimplifiee.Init();
                    LigneVenteSimplifiee."No. ligne" := 0;
                    LigneVenteSimplifiee.Validate(Type, StdSalesLine.Type);
                    if StdSalesLine.Type = StdSalesLine.Type::" " then begin
                        LigneVenteSimplifiee.Validate("No.", StdSalesLine."No.");
                        LigneVenteSimplifiee.Description := StdSalesLine.Description;
                    end else
                        if not StdSalesLine.EmptyLine() then begin
                            StdSalesLine.TestField("No.");
                            LigneVenteSimplifiee.Validate("No.", StdSalesLine."No.");
                            LigneVenteSimplifiee.Validate(Quantite, StdSalesLine.Quantity);
                            if StdSalesLine.Description <> '' then
                                LigneVenteSimplifiee.Validate(Description, StdSalesLine.Description);
                            if LigneVenteSimplifiee."Article divers" then begin
                                LigneVenteSimplifiee."No. fournisseur" := StdSalesLine."No. fournisseur";
                                LigneVenteSimplifiee."Nomenclature produits" := StdSalesLine."Nomenclature produits";
                                LigneVenteSimplifiee."Poids unitaire" := StdSalesLine."Poids net";
                                LigneVenteSimplifiee."Code pays origine" := StdSalesLine."Country/Region of Origin Code";
                                LigneVenteSimplifiee.Validate("Prix unitaire", StdSalesLine."Prix unitaire");
                            end;
                        end;

                    if StdSalesLine.InsertLine() then begin
                        LigneVenteSimplifiee."No. ligne" := GetNextLineNo(LigneVenteSimplifiee);
                        LigneVenteSimplifiee.Insert(true);
                    end;
                until StdSalesLine.Next() = 0;
        end;
    end;

    procedure AjouterDocumentTypePartiel()
    var
        StdCustSalesCode: Record "Standard Customer Sales Code";
        EnteteDocument: Record "Sales Header";
        StdSalesLine: Record "Standard Sales Line";
        StdSalesCode: Record "Standard Sales Code";
        LigneVenteSimplifiee: Record "Ligne vente simplifiee";
        TamponExtraireDocument: Record TamponExtraireDocType;
        Article: Record Item;
        dNegDEEE: Codeunit "Gestion Ecopart";
        StdCustSalesCodes: Page "Standard Customer Sales Codes";
        PageExtraireDevisTypePartiel: Page ExtraireDocTypePartiel;
        NumLigne: Integer;

    begin
        //TestField("No.");
        EnteteDocument.get("Type document", "No. document");
        //TestField("Sell-to Customer No.");

        TamponExtraireDocument.SetRange("Code utilisateur", Copystr(UserId, 1, 50));
        TamponExtraireDocument.DeleteAll();
        commit();

        StdCustSalesCode.FilterGroup := 2;
        StdCustSalesCode.SetRange("Customer No.", EnteteDocument."Sell-to Customer No.");
        StdCustSalesCode.FilterGroup := 0;

        StdCustSalesCodes.SetTableView(StdCustSalesCode);
        StdCustSalesCodes.LookupMode(true);
        if StdCustSalesCodes.RunModal() = ACTION::LookupOK then begin
            StdCustSalesCodes.GetSelected(StdCustSalesCode);
            if StdCustSalesCode.FindSet() then
                repeat
                    if StdCustSalesCode.Blocked then
                        exit;

                    StdCustSalesCode.TestField(Code);
                    StdCustSalesCode.TestField("Customer No.", EnteteDocument."Sell-to Customer No.");
                    StdSalesCode.Get(StdCustSalesCode.Code);
                    StdSalesCode.TestField("Currency Code", EnteteDocument."Currency Code");
                    StdSalesLine.SetRange("Standard Sales Code", StdCustSalesCode.Code);

                    NumLigne := 10000;

                    LigneVenteSimplifiee."Type Document" := EnteteDocument."Document Type";
                    LigneVenteSimplifiee."No. document" := EnteteDocument."No.";
                    LigneVenteSimplifiee.SetRange("Type Document", EnteteDocument."Document Type");
                    LigneVenteSimplifiee.SetRange("No. document", EnteteDocument."No.");

                    StdSalesLine.LockTable();
                    if StdSalesLine.Find('-') then
                        repeat
                            TamponExtraireDocument.Init();
                            TamponExtraireDocument."Code utilisateur" := copystr(UserId, 1, 50);
                            TamponExtraireDocument.Type := StdSalesLine.Type;
                            if StdSalesLine.Type = StdSalesLine.Type::" " then begin
                                TamponExtraireDocument."No." := StdSalesLine."No.";
                                TamponExtraireDocument.Description := StdSalesLine.Description;
                            end else
                                if not StdSalesLine.EmptyLine() then begin
                                    StdSalesLine.TestField("No.");
                                    TamponExtraireDocument."No." := StdSalesLine."No.";
                                    TamponExtraireDocument."Code Variante" := StdSalesLine."Variant Code";
                                    TamponExtraireDocument.Quantite := StdSalesLine.Quantity;
                                    TamponExtraireDocument."Code unite" := StdSalesLine."Unit of Measure Code";
                                    TamponExtraireDocument.Description := StdSalesLine.Description;
                                    TamponExtraireDocument."Type ligne" := StdSalesLine."Type ligne";
                                    TamponExtraireDocument."Type fiche BE" := StdSalesLine."Type Fiche BE";
                                    //KAN.FHA 15/01/2026 FIN
                                    TamponExtraireDocument.Phase := StdSalesLine.Phase;
                                    //KAN.FHA 15/01/2026 FIN
                                    TamponExtraireDocument."Poids net" := StdSalesLine."Poids net";
                                    TamponExtraireDocument."Country/Region of Origin Code" := StdSalesLine."Country/Region of Origin Code";
                                    TamponExtraireDocument."Nomenclature produits" := StdSalesLine."Nomenclature produits";
                                    TamponExtraireDocument."Prix achat prevu" := StdSalesLine."Prix achat prevu";
                                    if StdSalesLine."Prix unitaire" <> 0 then
                                        TamponExtraireDocument."Prix unitaire" := StdSalesLine."Prix unitaire";
                                    TamponExtraireDocument."No. fournisseur" := StdSalesLine."No. fournisseur";

                                end;

                            TamponExtraireDocument."No. ligne" := NumLigne;
                            TamponExtraireDocument."Ajouter au document" := true;
                            NumLigne := NumLigne + 10000;
                            TamponExtraireDocument.Insert();
                        until StdSalesLine.Next() = 0;
                until StdCustSalesCode.Next() = 0;

            commit();
            PageExtraireDevisTypePartiel.SetTableView(TamponExtraireDocument);
            PageExtraireDevisTypePartiel.LookupMode(true);
            if PageExtraireDevisTypePartiel.RunModal() = ACTION::LookupOK then begin
                TamponExtraireDocument.SetRange("Ajouter au document", true);
                if TamponExtraireDocument.FindSet() then
                    repeat
                        LigneVenteSimplifiee.Init();
                        LigneVenteSimplifiee."No. ligne" := 0;
                        LigneVenteSimplifiee.Validate(Type, TamponExtraireDocument.Type);
                        if TamponExtraireDocument.Type = TamponExtraireDocument.Type::" " then begin
                            LigneVenteSimplifiee.Validate("No.", TamponExtraireDocument."No.");
                            LigneVenteSimplifiee.Description := TamponExtraireDocument.Description;
                        end else
                            if not TamponExtraireDocument.EmptyLine() then begin
                                TamponExtraireDocument.TestField("No.");
                                LigneVenteSimplifiee.Validate("No.", TamponExtraireDocument."No.");
                                LigneVenteSimplifiee.Validate(Quantite, TamponExtraireDocument.Quantite);
                                //KAN.FHA 13/05/2026 DEBUT
                                LigneVenteSimplifiee.Validate(Phase, TamponExtraireDocument.Phase);
                                LigneVenteSimplifiee.Validate("Prix achat prevu", TamponExtraireDocument."Prix achat prevu");
                                LigneVenteSimplifiee.Validate("Code variante", TamponExtraireDocument."Code variante");
                                //KAN.FHA 13/05/2026 FIN
                                if TamponExtraireDocument.Description <> '' then
                                    LigneVenteSimplifiee.Validate(Description, TamponExtraireDocument.Description);
                                if TamponExtraireDocument."Prix unitaire" <> 0 then
                                    LigneVenteSimplifiee.Validate("Prix unitaire", TamponExtraireDocument."Prix unitaire");
                                if TamponExtraireDocument."Poids net" <> 0 then
                                    LigneVenteSimplifiee."Poids unitaire" := TamponExtraireDocument."Poids net";
                                if TamponExtraireDocument."Nomenclature produits" <> '' then
                                    LigneVenteSimplifiee."Nomenclature produits" := TamponExtraireDocument."Nomenclature produits";
                                if TamponExtraireDocument."Country/Region of Origin Code" <> '' then
                                    LigneVenteSimplifiee."Code pays origine" := TamponExtraireDocument."Country/Region of Origin Code";
                                if TamponExtraireDocument."No. fournisseur" <> '' then
                                    LigneVenteSimplifiee."No. fournisseur" := TamponExtraireDocument."No. fournisseur";
                            end;
                        if TamponExtraireDocument.InsertLine() then begin
                            LigneVenteSimplifiee."No. ligne" := GetNextLineNo(LigneVenteSimplifiee);
                            LigneVenteSimplifiee.Insert(true);
                        end;
                    until TamponExtraireDocument.Next() = 0;
            end;
        end;
    end;

    procedure GetNextLineNo(LigneVenteSimplifiee: Record "Ligne vente simplifiee"): Integer
    begin
        LigneVenteSimplifiee.SetRange("Type Document", LigneVenteSimplifiee."Type Document");
        LigneVenteSimplifiee.SetRange("No. Document", LigneVenteSimplifiee."nO. Document");
        if LigneVenteSimplifiee.FindLast() then
            exit(LigneVenteSimplifiee."No. ligne" + 10000);

        exit(10000);
    end;

}
