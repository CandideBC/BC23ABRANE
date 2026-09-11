tableextension 50020 PurchaseLineExtension extends "Purchase Line"
{

    fields
    {
        field(50000; Indice; Code[10])
        {
            Caption = 'Indice';
            DataClassification = ToBeClassified;
            Description = 'C12.01';
        }
        field(50001; TypeDoc; Enum "Purchase Document Type")
        {
            Caption = 'TypeDoc';
            DataClassification = ToBeClassified;
            Description = 'Pour avoir une clé qui melangent champs standards et spec';
        }
        field(50002; NumDoc; Code[20])
        {
            Caption = 'NumDoc';
            DataClassification = ToBeClassified;
            Description = 'Pour avoir une clé qui melangent champs standards et spec';
        }
        field(50003; GrpComptaMarche; Code[20])
        {
            Caption = 'GrpComptaMarche';
            DataClassification = ToBeClassified;
            Description = 'Pour avoir une clé qui melangent champs standards et spec';
        }

        field(50005; "Suivi container"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 19/04/2021 Indique si la ligne est une ligne "Import" et donc qu''elle doit être suivie par l''assistante import/export (Gestion de containers).';
        }
        field(50006; "Suivi container OK"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 19/04/2021 Indique que la ligne est complètement traitée (toute la quantité achetée a été mise en container = l''utilisateur a affecté la quantité entièrement dans un ou plusieurs containers).';
        }
        field(50008; "Quantite vers container"; Decimal)
        {
            BlankZero = true;
            Caption = 'Quantité vers container';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'KAN.FHA 23/03/2022 Avant d''avoir poussé la ligne de commande vers un container, on peut choisir la quantité de chaque ligne et cela valorise la ligne pour controle avec la packing list du fournisseur qui dit ce qu''il a mis dans chaque container';

            trigger OnValidate()
            var
                QteErr1Err: Label 'La quantité à mettre en container doit être positive et inférieure à la quantité restante.';
                QteErr2Err: Label 'La quantité à mettre en container doit être négative et supérieure à la quantité restante.';
            begin
                CalcFields("Quantite en container");
                if "Quantite vers container" <> 0 then
                    if Quantity > 0 then begin
                        if ("Quantite vers container" > (Quantity - "Quantite en container")) or ("Quantite vers container" < 0) then
                            Error(QteErr1Err)
                    end else
                        if Quantity < 0 then
                            if ("Quantite vers container" < (Quantity - "Quantite en container")) or ("Quantite vers container" > 0) then
                                Error(QteErr2Err);


                if Quantity <> 0 then begin
                    "Montant vers container" := Round("Quantite vers container" / Quantity * "Line Amount", 0.01);
                    if "Quantite vers container" = 0 then
                        "Cout unitaire facture (papier)" := 0
                    else
                        if ("Cout unitaire facture (papier)" = 0) then
                            "Cout unitaire facture (papier)" := "Direct Unit Cost";

                    "Montant facture (papier)" := Round("Quantite vers container" * "Cout unitaire facture (papier)", 0.01);
                end else begin
                    "Montant vers container" := 0;
                    "Montant facture (papier)" := 0;
                end;
            end;
        }
        field(50009; "Montant vers container"; Decimal)
        {
            BlankZero = true;
            Caption = 'Montant vers container';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 23/03/2022 Avant d''avoir poussé la ligne de commande vers un container, on peut choisir la quantité de chaque ligne et cela valorise la ligne pour controle avec la packing list du fournisseur qui dit ce qu''il a mis dans chaque container';
        }
        field(50010; "Quantite en container"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Ligne container".Quantite where("No. commande achat" = field("Document No."),
                                                                "No. ligne commande achat" = field("Line No.")));
            Caption = 'Quantité en container';
            DecimalPlaces = 0 : 5;
            Description = 'KAN.FHA 19/04/2021 Gestion des containers';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50011; "Quantite restante en container"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Ligne container"."Quantite restante" where("No. commande achat" = field("Document No."),
                                                                           "No. ligne commande achat" = field("Line No.")));
            Caption = 'Quantité restante en container';
            DecimalPlaces = 0 : 5;
            Description = 'KAN.FHA 19/04/2021 Gestion des containers';
            Editable = false;
            FieldClass = FlowField;
        }
        /*
        field(50013; "Selectionnee pour chargement"; Boolean)
        {
            Caption = 'Selectionnée pour chargement';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 16/06/2023. Champ coché sur l''entête et reporté sur les lignes.';
        }
        */
        field(50014; "Livraison directe"; Boolean)
        {
            Caption = 'Livraison directe';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 04/05/2026. Champ coché sur l''entête et reporté sur les lignes.';
        }
        field(50020; "No. container"; Code[20])
        {
            Caption = 'N° container';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 26/08/2022 Pour les retours fournisseurs uniquement. Une ligne commande d''achat peut être liée à plusieurs lignes de containers en revanche et ce champ n''est donc pas renseigné sur les lignes de commandes.';
            TableRelation = Container;
        }
        field(50021; "No. ligne container"; Integer)
        {
            Caption = 'N° ligne container';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 26/08/2022 Pour les retours fournisseurs uniquement. Une ligne commande d''achat peut être liée à plusieurs lignes de containers en revanche et ce champ n''est donc pas renseigné sur les lignes de commandes.';
            TableRelation = "Ligne container"."No. ligne" where("No. container" = field("No. container"));
        }
        field(50090; "Nomenclature produits"; Code[20])
        {
            Caption = 'Nomenclature produits';
            DataClassification = ToBeClassified;
            TableRelation = "Tariff Number";

            trigger OnValidate()
            var
                LigneVente: Record "Sales Line";
                LigneContainer: Record "Ligne container";
                ParamUtil: Record "User Setup";
                LienAchatVente: Record "Affectations achat vente";
                CodeDouanierNonAutoriseErr: Label 'Vous n''êtes pas autorisé à saisir/modifier le champ %1.', Comment = '%1 = Le champ';

            begin
                //KAN.FHA 07/06/2021 DEBUT
                if not ParamUtil.Get(UserId) then
                    ParamUtil.Init();

                if not ParamUtil."Saisir code douanier achat/vte" then
                    Error(CodeDouanierNonAutoriseErr, FieldCaption("Nomenclature produits"));
                //KAN.FHA 07/06/2021 FIN

                //KAN.FHA 08/10/2021 DEBUT
                TestField("Article divers", true);
                //KAN.FHA 08/10/2021 FIN

                //KAN.FHA 06/09/2022 DEBUT
                if "Document Type" = "Document Type"::Order then begin
                    LienAchatVente.Reset();
                    LienAchatVente.SetRange("No. document achat", "Document No.");
                    LienAchatVente.SetRange("No. ligne document achat", "Line No.");
                    if LienAchatVente.FindSet(true) then
                        repeat
                            if LigneVente.Get(LienAchatVente."Type document vente", LienAchatVente."No. document vente", LienAchatVente."No. ligne document vente") then begin
                                LigneVente."Nomenclature produits" := "Nomenclature produits";
                                LigneVente.Modify();
                            end;
                        until LienAchatVente.Next() = 0;
                end;
                //KAN.FHA 06/09/2022 FIN

                //KAN.FHA 17/10/2022 DEBUT
                if ("Document Type" = "Document Type"::Order) then begin
                    LigneContainer.Reset();
                    LigneContainer.SetCurrentKey("No. commande achat", "No. ligne commande achat");
                    LigneContainer.SetRange("No. commande achat", "Document No.");
                    LigneContainer.SetRange("No. ligne commande achat", "Line No.");
                    if LigneContainer.FindSet(true) then
                        repeat
                            LigneContainer."Nomenclature produits" := "Nomenclature produits";
                            LigneContainer.Modify();
                        until LigneContainer.Next() = 0;
                end;
                //KAN.FHA 17/10/2022 FIN
            end;
        }
        field(50100; "Code douanier OK"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 07/06/2021 Pour le suivi des codes douaniers sur les DIV.';
        }
        field(50120; "Annee commande"; Integer)
        {
            Caption = 'Année commande';
            DataClassification = ToBeClassified;
        }
        field(50240; "Purchaser Code"; Code[20])
        {
            Caption = 'Code acheteur';
            DataClassification = ToBeClassified;
            Description = 'DIA£LBO';
            TableRelation = "Salesperson/Purchaser";
        }

        field(50270; "Nature vente"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Mobilier,"Pose/Audit",Transport,"Bennes/Fenwick",SAV,"Indéfinie";

            trigger OnValidate()
            begin
                //KAN.FHA 08/01/2024 DEBUT
                //Ce champ ne doit pouvoir être forcé que pour les lignes de compte je pense
                TestField(Type, Type::"G/L Account");
                //KAN.FHA 08/01/2024 FIN
            end;
        }
        field(50620; "Achat pour stock"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            Editable = false;
        }

        field(50630; "Ligne acompte"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51010; "Country/Region of Origin Code"; Code[10])
        {
            Caption = 'Code pays/région origine';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 25/08/2022. Pour la DEB. Pour les articles DIVERS, il faut que la donnée soit saisie sur la ligne de commande.';
            TableRelation = "Country/Region";
        }
        field(51110; "Montant restant HT (DS)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
        }
        field(51190; "Code groupe"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = "Groupe client";
        }
        field(51200; "Code enseigne"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = Enseigne;
            trigger OnValidate()
            var
                Enseigne: Record Enseigne;
                ParamUtil: Record "User Setup";
                MAJChampNonAutoriseeErr: Label 'Vous n''êtes pas autorisé à modifier ce champ.';

            begin
                if not ParamUtil.Get(UserId) then
                    ParamUtil.Init();

                if not ParamUtil."Changer chantier a la ligne" then
                    Error(MAJChampNonAutoriseeErr);

                if "Code enseigne" <> xRec."Code enseigne" then begin
                    "Code chantier" := '';
                    "Code operation" := '';
                    if not Enseigne.Get("Code enseigne") then
                        Enseigne.Init();

                    "Code groupe" := Enseigne."Code groupe";
                end;
            end;
        }
        field(51210; "Code operation"; Code[20])
        {
            Caption = 'Code opération';
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = Operations.Code where("Code enseigne" = field("Code enseigne"));
        }
        field(51220; "Code chantier"; Code[20])
        {
            Caption = 'Code chantier';
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = if ("Code enseigne" = filter(<> '')) Chantier.Code where("Code enseigne" = field("Code enseigne"))
            else
            Chantier;
            trigger OnValidate()
            var

                ParamUtil: Record "User Setup";
                Chantier: Record Chantier;
                Enseigne: Record Enseigne;
                MAJChampNonAutoriseeErr: Label 'Vous n''êtes pas autorisé à modifier ce champ.';
            begin
                if not ParamUtil.Get(UserId) then
                    ParamUtil.Init();

                if not ParamUtil."Changer chantier a la ligne" then
                    Error(MAJChampNonAutoriseeErr);

                if "Code chantier" <> xRec."Code chantier" then begin
                    if not Chantier.Get("Code chantier") then
                        Chantier.Init();

                    if Chantier."Code enseigne" <> "Code enseigne" then
                        "Code operation" := '';

                    "Code enseigne" := Chantier."Code enseigne";

                    if not Enseigne.Get("Code enseigne") then
                        Enseigne.Init();

                    "Code groupe" := Enseigne."Code groupe";
                end;
            end;
        }
        
        field(51230; "Nb lignes ventes liees"; Integer)
        {
            BlankZero = true;
            CalcFormula = count("Affectations achat vente" where("No. document achat" = field("Document No."),
                                                                  "No. ligne document achat" = field("Line No."),
                                                                  "No. document vente" = filter(<> ''),
                                                                  "Quantite affectee" = filter(<> 0)));
            Caption = 'Nb lignes ventes liées';
            Description = 'KAN';
            Editable = false;
            FieldClass = FlowField;
        }
        field(51240; "Quantite affectee aux ventes"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Affectations achat vente"."Quantite affectee" where("No. document achat" = field("Document No."),
                                                                                    "No. ligne document achat" = field("Line No.")));
            Caption = 'Quantité affectée aux ventes';
            DecimalPlaces = 0 : 5;
            Description = 'KAN Pour les commandes d''achat';
            Editable = false;
            FieldClass = FlowField;
        }
        field(51245; "Affectation manquante"; Boolean)
        {
            Caption = 'Affectation manquante';
            DataClassification = ToBeClassified;
            Description = 'KAN Pour les factures d''achat (on cherche les commandes liées aux réceptions extraites sur la facture)';
        }
        field(51250; "Article divers"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
        }
        field(51255; "Reference 102 B.E."; Code[20])
        {
            Caption = 'Référence 102 B.E.';
            DataClassification = ToBeClassified; //Champ à remplir , DEV PAS FAIT
        }
        field(51260; "Cout unitaire facture (papier)"; Decimal)
        {
            BlankZero = true;
            Caption = 'Coût unitaire facture (papier)';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 12/12/2022 Lorsqu''on recoit la facture fns pour un container, on souhaite saisir le coût figurant sur le papier potentiellement différent du cout figurant sur la commande. Ce champ est affiché sur le sous-form de la page "Pousser vers container".';

            trigger OnValidate()
            begin
                "Montant facture (papier)" := Round("Quantite vers container" * "Cout unitaire facture (papier)", 0.01);
            end;
        }
        field(51270; "Montant facture (papier)"; Decimal)
        {
            BlankZero = true;
            Caption = 'Montant facture (papier)';
            DataClassification = ToBeClassified;
            Description = 'Idem';
        }
        field(51280; "Creer ligne ecart prix"; Boolean)
        {
            Caption = 'Créer ligne écart prix';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 23/06/2023';

            trigger OnValidate()
            begin
                TestField(Type, Type::Item);
                TestField("Article divers", false);
            end;
        }
        field(51290; "Completement chargee"; Boolean)
        {
            Caption = 'Complètement chargée';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 31/05/2024. Pour les commandes suivies en Container uniquement.';
        }

        field(51292; "Date intention chargement"; Date)
        {
            Caption = 'Date intention chargement';
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Header"."Date intention chargement" where ("Document Type"=field("Document Type"),"No."=field("Document No.")));
            Editable = false;
        }        
        field(51293; "Date chargement confirmee"; Date)
        {
            Caption = 'Date chargement confirmée';
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Header"."Date chargement confirmee" where ("Document Type"=field("Document Type"),"No."=field("Document No.")));
            Editable = false;
        }
        field(51300; "Qte sur commande"; Decimal)
        {
            Caption = 'Qté sur commande'; //Pour les commandes cadres, totalise la quantité sur commande achat (qté restante)
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Line"."Outstanding Qty. (Base)" where ("Document Type"=const(Order),"Blanket Order No."=field("Document No."),"Blanket Order Line No."=field("Line No.")));
            Editable = false;
            BlankZero = true;
            DecimalPlaces = 0:5;
        }
    }
    keys
    {
        key(MyKey1; "Suivi container")
        {

        }
        key(MyKey2; "Article divers")
        {

        }

        key(MyKey3; "Code enseigne", "Code chantier")
        {

        }
        key(MyKey4; "Code chantier", "Achat pour stock", "Annee commande")
        {

        }
        key(MyKey5; "Code enseigne", "Achat pour stock", "Annee commande")
        {

        }
        key(MyKey6; "Suivi container", "Suivi container OK")
        {

        }
        key(MyKey7; "Document Type", "Completely Received")
        {

        }
        key(MyKey8; "Affectation manquante")
        {

        }
        key(MyKey9; "No. container", "No. ligne container")
        {

        }
        key(MyKey10; "Code groupe", "Annee commande")
        {

        }
        key(MyKey11; TypeDoc, "Article divers", "Code douanier OK", GrpComptaMarche)
        {
            
        }
        key(MyKey12; "Document Type","Blanket Order No.","Blanket Order Line No.")
        {
            SumIndexFields = "Outstanding Qty. (Base)";
        }

    }


    procedure fctRAZQuantitearecevoir();
    var
        PurchLine2: Record "Purchase Line";
    begin
        PurchLine2.RESET();
        PurchLine2.SETCURRENTKEY("Document Type", "Document No.");//
        PurchLine2.SETRANGE("Document Type", "Document Type");
        PurchLine2.SETRANGE("Document No.", "Document No.");
        PurchLine2.SETFILTER(Type, '<>0');
        PurchLine2.SETFILTER("Qty. to Receive", '>0');
        if PurchLine2.FINDSET(true) then
            repeat
                PurchLine2.VALIDATE("Qty. to Receive", 0);
                PurchLine2.MODIFY();
            until PurchLine2.NEXT() = 0;
    end;

    procedure fctRemplirQuantitearecevoir();
    var
        PurchLine2: Record "Purchase Line";
        QteRestante: Decimal;
    begin
        if not (Rec."Document Type" in [Rec."Document Type"::"Blanket Order",Rec."Document Type"::Order]) then
            exit;
        PurchLine2.RESET();
        PurchLine2.SETCURRENTKEY("Document Type", "Document No.");//
        PurchLine2.SETRANGE("Document Type", "Document Type");
        PurchLine2.SETRANGE("Document No.", "Document No.");
        //PurchLine2.SETRANGE("Qty. to Receive", 0);
        if PurchLine2.FINDSET(true) then 
            repeat
                if Rec."Document Type" = Rec."Document Type"::Order then
                        PurchLine2.VALIDATE("Qty. to Receive", PurchLine2."Outstanding Quantity")
                else begin
                    PurchLine2.CalcFields("Qte sur commande");
                    QteRestante := PurchLine2.Quantity - (PurchLine2."Qte sur commande" + PurchLine2."Quantity Received");
                    if QteRestante < 0 then
                        QteRestante := 0;
                    PurchLine2.VALIDATE("Qty. to Receive",QteRestante);
                end;
                PurchLine2.MODIFY();
            until PurchLine2.NEXT() = 0;
    end;

    procedure MAJLiensAchatVentes()
    var
        LigRecepAchat: Record "Purch. Rcpt. Line";
        LigneCdeAchat: Record "Purchase Line";
        LienAchatVente: Record "Affectations achat vente";
        NumCdeAchat: Code[20];
        NumLigCdeAchat: Integer;

    begin
        case "Document Type" of
            "Document Type"::Order:
                begin
                    NumCdeAchat := "Document No.";
                    NumLigCdeAchat := "Line No.";
                end;
            "Document Type"::Invoice:
                if "Receipt No." <> '' then begin
                    LigRecepAchat.Get("Receipt No.", "Receipt Line No.");
                    NumCdeAchat := LigRecepAchat."Order No.";
                    NumLigCdeAchat := LigRecepAchat."Order Line No.";
                end else
                    exit
            else
                exit;
        end;

        if not LigneCdeAchat.Get(LigneCdeAchat."Document Type"::Order, NumCdeAchat, NumLigCdeAchat) then //Eviter erreur en cas de creation de ligne
            exit;

        LigneCdeAchat.CalcFields("Nb lignes ventes liees");
        if LigneCdeAchat."Nb lignes ventes liees" = 0 then
            exit;

        LienAchatVente.Reset();
        LienAchatVente.SetRange("No. document achat", NumCdeAchat);
        LienAchatVente.SetRange("No. ligne document achat", NumLigCdeAchat);
        if LienAchatVente.FindSet(true) then
            repeat
                LienAchatVente.Validate("Cout unitaire (DS)", "Unit Cost (LCY)");
                LienAchatVente."Description article achete" := Description;
                LienAchatVente.Modify();
            until LienAchatVente.Next() = 0;
    end;

    procedure MAJStatutCdeSurAffectation()
    var
        EnteteAchat: Record "Purchase Header";
        LienAchatVente: Record "Affectations achat vente";
    begin
        if "Document Type" = "Document Type"::Order then begin
            LienAchatVente.Reset();
            LienAchatVente.SetRange("No. document achat", "Document No.");
            LienAchatVente.SetRange("No. ligne document achat", "Line No.");
            if LienAchatVente.FindSet(true) then
                repeat
                    if (Quantity <> 0) and ("Outstanding Quantity" = 0) then
                        LienAchatVente."Statut commande achat" := LienAchatVente."Statut commande achat"::"Totalement reçue"
                    else begin
                        EnteteAchat.Get("Document Type", "Document No.");
                        if EnteteAchat.Status = EnteteAchat.Status::Open then
                            LienAchatVente."Statut commande achat" := LienAchatVente."Statut commande achat"::Ouverte
                        else
                            LienAchatVente."Statut commande achat" := LienAchatVente."Statut commande achat"::"Lancée";
                    end;
                    LienAchatVente.Modify();
                until LienAchatVente.Next() = 0;

        end;
    end;

    procedure InsererLigneContainerDepuisLigneAchat(var LigneContainer: Record "Ligne container")
    var
        TempLigneContainer: Record "Ligne container" temporary;
        NextLineNo: Integer;
    begin
        SetRange("Document No.", "Document No.");

        TempLigneContainer := LigneContainer;
        if LigneContainer.Find('+') then
            NextLineNo := LigneContainer."No. ligne" + 10000
        else
            NextLineNo := 10000;

        CalcFields("Quantite en container");
        LigneContainer.Init();
        LigneContainer."No. ligne" := NextLineNo;
        LigneContainer."No. container" := TempLigneContainer."No. container";
        LigneContainer."No. commande achat" := "Document No.";
        LigneContainer."No. ligne commande achat" := "Line No.";
        LigneContainer."No." := "No.";
        LigneContainer.Description := Description;
        LigneContainer.Validate(Quantite, Quantity - "Quantite en container");
        LigneContainer."Cout unitaire direct" := "Direct Unit Cost";
        LigneContainer."Code devise" := "Currency Code";
        //KAN.FHA 01/03/2023 DEBUT
        LigneContainer.Validate("Cout unitaire facture (papier)", "Cout unitaire facture (papier)");
        LigneContainer."Montant facture (papier)" := "Montant facture (papier)";
        //KAN.FHA 01/03/2023 FIN
        LigneContainer.Insert();

        NextLineNo := NextLineNo + 10000;
    end;

    procedure DejMiseAjourCoutDepuisContainer(pMiseAjourCoutDepuisContainer: Boolean)
    begin
        MiseAjourCoutDepuisContainer := pMiseAjourCoutDepuisContainer;
    end;

    procedure AnnulerEclatementLignesTransitaire()
    var
        LigneAchatActuelle: Record "Purchase Line";
        LigneAchat: Record "Purchase Line";
        LiensCdeTransitaire: Record "Lien cde transitaire-reception";
        Container: Record Container;
        NumLignePremierFraisAnnexe: Integer;

    begin
        //Fonction pour "renrouler" les lignes qui ont été éclatées

        //On commence par supprimer toutes les lignes de commentaires qui suivent le premier frais annexe
        LigneAchatActuelle.Reset();
        LigneAchatActuelle.SetRange("Document Type", "Document Type");
        LigneAchatActuelle.SetRange("Document No.", "Document No.");
        LigneAchatActuelle.SetRange(Type, LigneAchatActuelle.Type::"Charge (Item)");

        if LigneAchatActuelle.FindSet(true) then begin
            NumLignePremierFraisAnnexe := LigneAchatActuelle."Line No.";
            LigneAchatActuelle.TestField("Quantity Received", 0);
            LigneAchat.SetRange("Document Type", LigneAchatActuelle."Document Type"::Order);
            LigneAchat.SetRange("Document No.", "Document No.");
            LigneAchat.SetRange(Type, LigneAchatActuelle.Type::" ");
            LigneAchat.SetFilter("Line No.", '>%1', NumLignePremierFraisAnnexe);
            LigneAchat.DeleteAll();

            //Pour chaque frais annexe (on peut trouver plusieurs lignes de commandes qui se suivent avec même frais annexe), on va cumuler les montants pour les remettre sur la première ligne et on supprimera les autres lignes
            LigneAchat.Reset();
            LigneAchat.SetCurrentKey("Document Type", "Document No.", Type, "No.");
            repeat
                LigneAchat.SetRange("Document Type", LigneAchatActuelle."Document Type");
                LigneAchat.SetRange("Document No.", LigneAchatActuelle."Document No.");
                LigneAchat.SetRange(Type, LigneAchatActuelle.Type::"Charge (Item)");
                LigneAchat.SetRange("No.", LigneAchatActuelle."No.");
                LigneAchat.FindSet(true);
                LigneAchatActuelle."Direct Unit Cost" := 0;
                repeat
                    LigneAchatActuelle.Validate("Direct Unit Cost", LigneAchatActuelle."Direct Unit Cost" + LigneAchat."Direct Unit Cost");
                    LigneAchatActuelle.Modify();
                until LigneAchat.Next() = 0;
                LigneAchat.SetFilter("Line No.", '>%1', LigneAchatActuelle."Line No.");
                LigneAchat.DeleteAll();
            until LigneAchatActuelle.Next() = 0;
            //KAN.FHA 01/03/2023 DEBUT Une case à cocher sur le container indique que les frans de transport ont été ventilés, il faut la décocher si on annule l'éclatement
            LiensCdeTransitaire.Reset();
            LiensCdeTransitaire.SetRange("No. commande transitaire", "Document No.");
            if LiensCdeTransitaire.FindSet(false) then
                repeat
                    if LiensCdeTransitaire."No. container" <> '' then begin
                        Container.Get(LiensCdeTransitaire."No. container");
                        if Container."Frais transport ventiles" then begin
                            Container."Frais transport ventiles" := false;
                            Container.Modify();
                        end;
                    end;
                until LiensCdeTransitaire.Next() = 0;
            //KAN.FHA 01/03/2023 FIN
        end;
    end;

    procedure AjouterLignesEcartDePrixSelection()
    var
        LigneAchat: Record "Purchase Line";
    begin
        LigneAchat.SetRange("Document Type", "Document Type");
        LigneAchat.SetRange("Document No.", "Document No.");
        LigneAchat.SetRange(Type, LigneAchat.Type::Item);
        LigneAchat.SetRange("Creer ligne ecart prix", true);
        if LigneAchat.FindSet(true) then begin
            repeat
                LigneAchat.AjouterLigneEcartDePrix(LigneAchat);
            until LigneAchat.Next() = 0;
            LigneAchat.SetRange("Creer ligne ecart prix");
            LigneAchat.ModifyAll("Creer ligne ecart prix", false);
        end;
    end;

    procedure AjouterLigneEcartDePrix(pLigneAchat: Record "Purchase Line")
    var
        LigneAchatCourante: Record "Purchase Line";
        LigneEcartCout: Record "Purchase Line";
        GeneralPostingSetup: Record "General Posting Setup";
        EnteteAchat: Record "Purchase Header";
        AffectationAchatVenteExistante: Record "Affectations achat vente";
        NouvelleAffectationAchatVente: Record "Affectations achat vente";
        LineSpacing: Integer;

    begin
        LigneAchatCourante.SetRange("Document No.", pLigneAchat."Document No.");
        LigneAchatCourante."Document Type" := pLigneAchat."Document Type";
        LigneAchatCourante."Document No." := pLigneAchat."Document No.";
        LigneAchatCourante."Line No." := pLigneAchat."Line No.";
        LigneAchatCourante.Find('=');

        //Migration if LigneAchatCourante.Find('>') then
        if LigneAchatCourante.NEXT() <> 0 then
            LineSpacing := (LigneAchatCourante."Line No." - pLigneAchat."Line No.") div 2
        else
            LineSpacing := 10000;

        GeneralPostingSetup.Get(pLigneAchat."Gen. Bus. Posting Group", pLigneAchat."Gen. Prod. Posting Group");

        LigneEcartCout.Init();
        LigneEcartCout."Document Type" := pLigneAchat."Document Type";
        LigneEcartCout."Document No." := pLigneAchat."Document No.";
        LigneEcartCout."Line No." := pLigneAchat."Line No." + LineSpacing;
        LigneEcartCout.Insert();
        LigneEcartCout.Validate(Type, LigneEcartCout.Type::"G/L Account");
        LigneEcartCout.Validate("No.", GeneralPostingSetup."Purch. Account");
        LigneEcartCout.Validate(Quantity, pLigneAchat.Quantity);
        EnteteAchat.Get(pLigneAchat."Document Type", pLigneAchat."Document No.");
        if EnteteAchat."SAV Type" = EnteteAchat."SAV Type"::FOURNISSEUR then
            LigneEcartCout.Validate("Direct Unit Cost", -pLigneAchat."Direct Unit Cost");
        LigneEcartCout.Modify();

        //L'affectation Achat/Vente doit être la même que la ligne d'origine
        AffectationAchatVenteExistante.SetRange("No. document achat", pLigneAchat."Document No.");
        AffectationAchatVenteExistante.SetRange("No. ligne document achat", pLigneAchat."Line No.");
        if AffectationAchatVenteExistante.FindSet(false) then
            repeat
                NouvelleAffectationAchatVente.Init();
                NouvelleAffectationAchatVente."No. document achat" := LigneEcartCout."Document No.";
                NouvelleAffectationAchatVente."No. ligne document achat" := LigneEcartCout."Line No.";
                NouvelleAffectationAchatVente."Type document vente" := AffectationAchatVenteExistante."Type document vente";
                NouvelleAffectationAchatVente."No. document vente" := AffectationAchatVenteExistante."No. document vente";
                NouvelleAffectationAchatVente."No. ligne document vente" := AffectationAchatVenteExistante."No. ligne document vente";
                NouvelleAffectationAchatVente.Insert();
                NouvelleAffectationAchatVente.Validate("Quantite affectee", LigneEcartCout.Quantity);
                NouvelleAffectationAchatVente.Modify();
            until AffectationAchatVenteExistante.Next() = 0;
    end;

    procedure CalcQteDispoCdeCadre(): Decimal
    begin
        if rec."Document Type" <> rec."Document Type"::"Blanket Order" then
            exit(0);

        CalcFields("Qte sur commande");
        exit(Rec.Quantity - Rec."Qte sur commande" - Rec."Quantity Received");
    end;
    var
        MiseAjourCoutDepuisContainer: Boolean;

}

