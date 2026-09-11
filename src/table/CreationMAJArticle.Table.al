table 50028 "Creation/MAJ article"
{
    Caption = 'Creation/MAJ article';
    DataCaptionFields = "No.", Description;
    Permissions =;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'N°';

            trigger OnValidate()
            begin
                if Article.Get("No.") then
                    Error(ArticleExistantErr);
            end;
        }

        field(3; Description; Text[100])
        {
            Caption = 'Désignation';
        }
        field(5; "Description 2"; Text[50])
        {
            Caption = 'Désignation 2';
        }
        field(8; "Base Unit of Measure"; Code[10])
        {
            Caption = 'Unité de base';
            TableRelation = "Unit of Measure";
            ValidateTableRelation = false;
        }
        field(31; "Vendor No."; Code[20])
        {
            Caption = 'N° fournisseur';
            TableRelation = Vendor;
            ValidateTableRelation = true;

            trigger OnValidate()
            begin
                if "Vendor No." <> xRec."Vendor No." then
                    "Prix achat" := 0;
            end;
        }
        field(33; "Lead Time Calculation"; DateFormula)
        {
            Caption = 'Délai de réappro.';
        }
        field(42; "Net Weight"; Decimal)
        {
            Caption = 'Poids net';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(47; "Tariff No."; Code[20])
        {
            Caption = 'Nomenclature produits';
            TableRelation = "Tariff Number";
        }
        field(49; "Country/Region Purchased Code"; Code[10])
        {
            Caption = 'Code pays/région achat';
            TableRelation = "Country/Region";
        }
        field(54; Blocked; Boolean)
        {
            Caption = 'Bloqué';
            Description = 'V2';
        }
        field(92; Picture; BLOB)
        {
            Caption = 'Image';
            SubType = Bitmap;
        }
        field(95; "Country/Region of Origin Code"; Code[10])
        {
            Caption = 'Code pays/région origine';
            TableRelation = "Country/Region";
        }

        field(8003; "Sales Blocked"; Boolean)
        {
            Caption = 'Ventes bloquées';
            DataClassification = CustomerContent;
        }
        field(50070; "Code matiere"; Code[20])
        {
            Caption = 'Code matière';
            TableRelation = Matiere;
            trigger OnValidate()
            begin
                //KAN.FHA 17/02/2025 DEBUT
                if "Code matiere" <> xrec."Code matiere" then
                    "Eco Tax Furniture Code" := '';
                //KAN.FHA 17/02/2025 DEBUT
            end;
        }
        field(50110; "Eco Tax Furniture Code"; Code[10])
        {
            Caption = 'Code taxe éco mobilier';
            TableRelation = "Taxe eco-mobilier".Code where("Code matiere associe" = field("Code matiere"));
        }
        field(50140; Dimension; Text[50])
        {
            Caption = 'Dimension';
        }
        field(50150; "Unit Of Measure"; Option)
        {
            Caption = 'Unité de mesure';
            OptionCaption = 'mm,cm,ml';
            OptionMembers = mm,cm,ml;
        }
        field(50190; "Complement ref. client"; Text[30])
        {
            Caption = 'Complément réf. client';
        }
        field(56070; "Ref. client"; Code[20])
        {

            Caption = 'Réf. client';
            Description = 'Remplace le champ N° 2 utilisé dans NAV2013';
            DataClassification = ToBeClassified;
            TableRelation = "Reference client";
        }
        field(50270; "Nature vente"; Option)
        {
            DataClassification = ToBeClassified;

            OptionMembers = Mobilier,"Pose/Audit",Transport,"Bennes/Fenwick",SAV;
        }
        field(55100; "Achat bloqué"; Boolean)
        {
            Caption = 'Achat bloqué';
            DataClassification = ToBeClassified;
        }
        field(56110; Phase; Integer)
        {
            Caption = 'Phase';
            BlankZero = true;
            MinValue = 0;  
            DataClassification = ToBeClassified;
        }
        field(99129; "Prix achat"; Decimal)
        {
            Caption = 'Prix achat';
            DecimalPlaces = 2 : 2;
            trigger OnValidate()
            begin
                TestField("Vendor No.");
            end;
        }
        field(99131; "Sales Type"; Option)
        {
            Caption = 'Type vente';
            OptionCaption = 'Client,Groupe prix client';
            OptionMembers = Client,"Groupe prix client";

            trigger OnValidate()
            begin
                if "Sales Type" <> xRec."Sales Type" then
                    "Sales Code" := '';
            end;
        }
        field(99133; "Sales Code"; Code[20])
        {
            Caption = 'Code vente';
            TableRelation = if ("Sales Type" = const("Groupe prix client")) "Customer Price Group"
            else
            if ("Sales Type" = const(Client)) Customer;
        }
        field(99134; "Reference externe client"; Code[50])
        {
            Caption = 'Référence externe client';
        }
        field(99135; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Prix unitaire';
            DecimalPlaces = 2 : 2;
            MinValue = 0;
        }
        field(99140; "Description anglaise"; Text[100])
        {
            Caption = 'Description anglaise';
        }
        field(99150; "Description anglaise 2"; Text[50])
        {
            Caption = 'Description anglaise 2';
        }
        field(99160; "Composants saisis"; Boolean)
        {
            Caption = 'Composants saisis';
            CalcFormula = exist("Nomenclature saisie article" where("Code utilisateur" = field("Code utilisateur"),
                                                                     "No. article parent" = field("No.")));
            FieldClass = FlowField;
        }
        field(99993; "Code utilisateur"; Code[50])
        {
            Caption = 'Code utilisateur';
        }
        field(99995; "Type article"; Option)
        {
            Caption = 'Type article';
            OptionCaption = 'Normal (102),Nomenclature';
            OptionMembers = "Normal (102)",Nomenclature;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Code utilisateur", "Type article")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Description, "Ref. client", "Base Unit of Measure")
        {
        }
    }

    trigger OnDelete()

    begin
        NomenclatureSaisieArt.SetRange("No. article parent", "No.");
        NomenclatureSaisieArt.DeleteAll();
    end;

    trigger OnInsert()
    begin
        "Code utilisateur" := copystr(UserId, 1, 50);
    end;

    var
        SaisieArticle: Record "Creation/MAJ article";
        Article: Record Item;
        UniteArticle: Record "Item Unit of Measure";
        PrixVente: Record "Sales Price";

        PrixAchat: Record "Purchase Price";
        ReferenceExterne: Record "Item Reference";
        TraductionArticle: Record "Item Translation";
        Client: Record Customer;
        NomenclatureSaisieArt: Record "Nomenclature saisie article";
        BOMComponent: Record "BOM Component";
        Composant: Record Item;
        ConfirmCreationArticleQst: Label 'Voulez-vous créer/mettre à jour les articles ?';

        ArticlesCreesMsg: Label 'articles ont été créés.';
        NbArt: Integer;
        NbArtMAJ: Integer;
        ArticlesModifiesMsg: Label 'articles ont été mis à jour.';

        TotalWeight: Decimal;

        ArticleExistantErr: Label 'Vous ne pouvez pas créer cet article car il existe déjà.\Si vous souhaitez mettre à jour cet article, utilisez le traitement d''extraction des articles disponible sur cette page.';
        NomencSansComposantsLbl: Label 'Vous n''avez saisi aucun composant pour l''article %1. La validation n''est pas possible.', Comment = '%1 = N° article';

    procedure CreerArticles()
    var
        ParamCodifab: Record "Parametrage articles Codifab";
        InventorySetup: Record "Inventory Setup";
        Matiere: Record Matiere;
        CreerPrix: Boolean;


    begin
        if not Confirm(ConfirmCreationArticleQst) then
            exit;

        InventorySetup.get();
        InventorySetup.TestField("Groupe compta produit defaut");
        InventorySetup.TestField("Gpe compta produit TVA defaut");
        InventorySetup.TestField("Groupe compta stock defaut");

        SaisieArticle.Reset();
        SaisieArticle.SetCurrentKey("Code utilisateur", "Type article");
        SaisieArticle.SetRange("Code utilisateur", UserId);
        SaisieArticle.SetRange("Type article", "Type article");
        if SaisieArticle.FindSet() then begin
            NbArt := 0;
            repeat
                //KAN.FHA 17/02/2025 DEBUT
                SaisieArticle.TestField("Code matiere");
                Matiere.Get(SaisieArticle."Code matiere");
                if Matiere."Code eco-taxe obligatoire" then
                    SaisieArticle.TestField("Eco Tax Furniture Code");

                SaisieArticle.TestField("Net Weight");
                SaisieArticle.TestField("Tariff No.");
                SaisieArticle.TestField("Country/Region of Origin Code");
                //KAN.FHA 17/02/2025 FIN
                if not Article.Get(SaisieArticle."No.") then begin
                    //SaisieArticle.TestField("Item Category Code");
                    //KAN.FHA 26/10/2022 DEBUT
                    if "Type article" = "Type article"::"Normal (102)" then
                        SaisieArticle.TestField("Net Weight");
                    SaisieArticle.TestField("Tariff No.");
                    SaisieArticle.TestField("Country/Region of Origin Code");
                    SaisieArticle.TestField("Code matiere");
                    //KAN.FHA 26/10/2022 FIN
                    Article.Init();
                    Article."No." := SaisieArticle."No.";
                    Article."Base Unit of Measure" := SaisieArticle."Base Unit of Measure";
                    Article.Insert();
                    if not UniteArticle.Get(SaisieArticle."No.", SaisieArticle."Base Unit of Measure") then begin
                        UniteArticle.Init();
                        UniteArticle."Item No." := SaisieArticle."No.";
                        UniteArticle.Code := SaisieArticle."Base Unit of Measure";
                        UniteArticle."Qty. per Unit of Measure" := 1;
                        UniteArticle.Insert();
                    end;
                    //Article.Validate("Item Category Code", SaisieArticle."Item Category Code");
                    Article.Validate("Gen. Prod. Posting Group", InventorySetup."Groupe compta produit defaut");
                    Article.Validate("VAT Prod. Posting Group", InventorySetup."Gpe compta produit TVA defaut");
                    Article.Validate("Inventory Posting Group", InventorySetup."Groupe compta stock defaut");

                    Article."Costing Method" := Article."Costing Method"::Average;
                    Article.Modify();
                    NbArt := NbArt + 1;
                end;
                if "Type article" = "Type article"::Nomenclature then begin
                    CalcFields("Composants saisis");
                    if not "Composants saisis" then
                        Error(NomencSansComposantsLbl, "No.");
                end;
                Article."Ref. client" := SaisieArticle."Ref. client";
                Article.Description := SaisieArticle.Description;
                Article."Description 2" := SaisieArticle."Description 2";
                Article."Vendor No." := SaisieArticle."Vendor No.";
                Article."Lead Time Calculation" := SaisieArticle."Lead Time Calculation";
                Article."Net Weight" := SaisieArticle."Net Weight";
                Article."Tariff No." := SaisieArticle."Tariff No.";
                Article."Country/Region Purchased Code" := SaisieArticle."Country/Region Purchased Code";
                Article."Country/Region of Origin Code" := SaisieArticle."Country/Region of Origin Code";
                Article."Code matiere" := SaisieArticle."Code matiere";

                Article."Eco Tax Furniture Code" := SaisieArticle."Eco Tax Furniture Code";
                //KAN.FHA 14/10/2020 DEBUT
                Article.Codifab := ParamCodifab.Get(Article."Code matiere", Article."Eco Tax Furniture Code");
                //KAN.FHA 14/10/2020 FIN
                Article.Dimension := SaisieArticle.Dimension;
                Article."Unit Of Measure" := SaisieArticle."Unit Of Measure";
                Article."Complement ref. client" := SaisieArticle."Complement ref. client";
                SaisieArticle.CalcFields(Picture);
                Article.Blocked := SaisieArticle.Blocked;
                Article.Validate("Purch. Unit of Measure", SaisieArticle."Base Unit of Measure");
                Article.Validate("Sales Unit of Measure", SaisieArticle."Base Unit of Measure");
                //KAN.FHA 19/08/2025 DEBUT
                Article.Phase := SaisieArticle.Phase;
                //KAN.FHA 19/08/2025 FIN
                Article.Modify();

                if (SaisieArticle."Description anglaise" <> '') or (SaisieArticle."Description anglaise 2" <> '') then begin
                    if not TraductionArticle.Get(Article."No.", '', 'ENU') then begin
                        TraductionArticle.Init();
                        TraductionArticle."Item No." := Article."No.";
                        TraductionArticle."Variant Code" := '';
                        TraductionArticle."Language Code" := 'ENU';
                        TraductionArticle.Insert();
                    end;
                    TraductionArticle.Description := SaisieArticle."Description anglaise";
                    TraductionArticle."Description 2" := SaisieArticle."Description anglaise 2";
                    TraductionArticle.Modify();
                end;

                NbArtMAJ := NbArtMAJ + 1;

                if SaisieArticle."Unit Price" <> 0 then begin
                    SaisieArticle.TestField("Sales Code");
                    CreerPrix := true;

                    PrixVente.SetRange("Item No.", SaisieArticle."No.");
                    PrixVente.SetFilter("Sales Type", '%1|%2', PrixVente."Sales Type"::Customer, PrixVente."Sales Type"::"Customer Price Group");
                    PrixVente.SetRange("Sales Code", SaisieArticle."Sales Code");
                    PrixVente.SetFilter("Starting Date", '<=%1|%2', Today, 0D);
                    PrixVente.SetFilter("Ending Date", '>=%1|%2', Today, 0D);

                    IF PrixVente.FindSet(true) then begin
                        PrixVente.Validate("Unit Price", SaisieArticle."Unit Price");
                        PrixVente.Modify();
                    end else begin
                        PrixVente.Init();
                        PrixVente.Validate("Item No.", SaisieArticle."No.");
                        PrixVente.Validate("Sales Type", SaisieArticle."Sales Type");
                        PrixVente.Validate("Sales Code", SaisieArticle."Sales Code");
                        PrixVente.Validate("Unit Price", SaisieArticle."Unit Price");
                        PrixVente."Starting Date" := Today;
                        PrixVente.Insert();
                    end;
                end;

                //KAN.FHA 14/09/2020 DEBUT
                CreerPrix := false;
                //KAN.FHA 14/09/2020 FIN

                if SaisieArticle."Prix achat" <> 0 then begin
                    SaisieArticle.TestField("Vendor No.");
                    //KAN.FHA 14/09/2020 DEBUT
                    CreerPrix := true;
                    //KAN.FHA 14/09/2020 FIN
                end;
                PrixAchat.SetRange("Item No.", SaisieArticle."No.");
                PrixAchat.SetRange("Vendor No.", SaisieArticle."Vendor No.");
                if PrixAchat.FindLast() then
                    if SaisieArticle."Prix achat" <> PrixAchat."Direct Unit Cost" then begin
                        if PrixAchat."Starting Date" <> Today then begin
                            PrixAchat."Ending Date" := CalcDate('<-1D>', Today);
                            PrixAchat.Modify();
                            CreerPrix := (SaisieArticle."Prix achat" <> 0);
                        end else begin
                            PrixAchat.Validate("Direct Unit Cost", SaisieArticle."Prix achat");
                            PrixAchat.Modify();
                            CreerPrix := false;
                        end;
                    end
                    else
                        CreerPrix := false;

                if CreerPrix then begin
                    PrixAchat.Init();
                    PrixAchat.Validate("Item No.", SaisieArticle."No.");
                    PrixAchat.Validate("Vendor No.", SaisieArticle."Vendor No.");
                    PrixAchat.Validate("Direct Unit Cost", SaisieArticle."Prix achat");
                    PrixAchat."Starting Date" := Today;
                    PrixAchat.Insert();
                end;

                if SaisieArticle."Sales Type" = SaisieArticle."Sales Type"::Client then begin
                    ReferenceExterne.SetRange("Item No.", SaisieArticle."No.");
                    ReferenceExterne.SetRange("Reference Type", ReferenceExterne."Reference Type"::Customer);
                    ReferenceExterne.SetRange("Reference Type No.", SaisieArticle."Sales Code");
                    //ReferenceExterne.SetRange("Cross-Reference Type", ReferenceExterne."Cross-Reference Type"::Customer);
                    //ReferenceExterne.SetRange("Cross-Reference Type No.", SaisieArticle."Sales Code");
                    ReferenceExterne.DeleteAll();
                    if (SaisieArticle."Reference externe client" <> '') then begin
                        ReferenceExterne.Init();
                        ReferenceExterne.Validate("Item No.", SaisieArticle."No.");
                        ReferenceExterne.Validate("Reference Type", ReferenceExterne."Reference Type"::Customer);
                        ReferenceExterne.Validate("Reference Type No.", SaisieArticle."Sales Code");
                        if SaisieArticle."Type article" = SaisieArticle."Type article"::"Normal (102)" then
                            ReferenceExterne."Reference No." := SaisieArticle."Reference externe client"
                        else
                            ReferenceExterne."Reference No." := SaisieArticle."No.";
                        ReferenceExterne.Insert();
                    end;
                end else begin //Sales Type = Groupe Tarif clients = on met la réf externe sur tous les clients de ce groupe prix client
                    Client.Reset();
                    Client.SetCurrentKey("Customer Price Group");
                    Client.SetRange("Customer Price Group", SaisieArticle."Sales Code");
                    if Client.FindSet(false) then
                        repeat
                            ReferenceExterne.SetRange("Item No.", SaisieArticle."No.");
                            ReferenceExterne.SetRange("Reference Type", ReferenceExterne."Reference Type"::Customer);
                            ReferenceExterne.SetRange("Reference Type No.", Client."No.");
                            ReferenceExterne.DeleteAll();

                            if SaisieArticle."Reference externe client" <> '' then begin
                                ReferenceExterne.Init();
                                ReferenceExterne.Validate("Item No.", SaisieArticle."No.");
                                ReferenceExterne.Validate("Reference Type", ReferenceExterne."Reference Type"::Customer);
                                ReferenceExterne.Validate("Reference Type No.", Client."No.");
                                if SaisieArticle."Type article" = SaisieArticle."Type article"::"Normal (102)" then
                                    ReferenceExterne."Reference No." := SaisieArticle."Reference externe client"
                                else
                                    ReferenceExterne."Reference No." := SaisieArticle."No.";
                                ReferenceExterne.Insert();
                            end;
                        until Client.Next() = 0;
                end;

                NomenclatureSaisieArt.SetRange("No. article parent", SaisieArticle."No.");
                if NomenclatureSaisieArt.FindSet(false) then begin
                    BOMComponent.SetRange("Parent Item No.", SaisieArticle."No.");
                    BOMComponent.DeleteAll(true);
                    TotalWeight := 0;
                    repeat
                        BOMComponent.Init();
                        BOMComponent."Parent Item No." := SaisieArticle."No.";
                        BOMComponent."Line No." := NomenclatureSaisieArt."Line No.";
                        BOMComponent.Validate(Type, BOMComponent.Type::Item);
                        BOMComponent.Validate("No.", NomenclatureSaisieArt."N° article");
                        BOMComponent.Validate("Quantity per", NomenclatureSaisieArt.Quantite);
                        BOMComponent.Insert();
                        Composant.Get(BOMComponent."No.");
                        TotalWeight := TotalWeight + (Composant."Net Weight" * BOMComponent."Quantity per");
                    until NomenclatureSaisieArt.Next() = 0;
                    Article."Net Weight" := TotalWeight;
                    Article."Gross Weight" := TotalWeight;
                    Article.Modify();
                end;
            until SaisieArticle.Next() = 0;
            SaisieArticle.DeleteAll(true);
            Message(Format(NbArt) + ' ' + ArticlesCreesMsg + '\' + Format(NbArtMAJ - NbArt) + ' ' + ArticlesModifiesMsg);
        end;
    end;
}

