tableextension 50021 PurchaseHeaderExtension extends "Purchase Header"
{

    fields
    {
        field(50000; "Date limite reponse"; Date)
        {
            Caption = 'Date limite réponse fournisseur';
            DataClassification = ToBeClassified;
        }
        field(50001; "Choix container"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 23/03/20222 Quand on utilise lécran "Pousser vers container", on peut choisir de créer un nouveau container ou ajouter la commande d''achat à un contrainer existant';
            OptionMembers = " ","Ajouter à container existant","Créer nouveau container";

            trigger OnValidate()
            begin
                if "Choix container" = "Choix container"::"Créer nouveau container" then
                    "No. container existant" := '';
            end;
        }
        field(50002; "No. container existant"; Code[20])
        {
            Caption = 'N° container existant';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 23/03/20222 Quand on utilise lécran "Pousser vers container", on peut choisir de créer un nouveau container ou ajouter la commande d''achat à un contrainer existant';
            TableRelation = Container."No." where("Statut container" = const("En cours"));

            trigger OnValidate()
            begin
                if "No. container existant" <> '' then
                    "Choix container" := "Choix container"::"Ajouter à container existant";
            end;
        }
        field(50003; "Montant vers container"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Montant vers container" where("Document Type" = field("Document Type"),
                                                                              "Document No." = field("No.")));
            Description = 'KAN.FHA 23/03/2022 Avant d''ajouter une commande d''achat à un container, on peut indiquer la quantité de chaque ligne (quantité vers container) et ce champ totalise le montant correspondant pour faciliter le rapprochement avec la packilng list où le fournisseur dit ce qu''il a mis dans tel ou tel container.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "Montant vers container papier"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Montant facture (papier)" where("Document Type" = field("Document Type"),
                                                                                "Document No." = field("No.")));
            Caption = 'Montant vers container papier';
            Description = 'Calculé à partir du coût unitaire figurant sur la facture papier et non le coût unitaire figurant sur la commande.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; "Suivi container"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 19/04/2021 Indique si la commande est une commande "Import" et donc qu''elle doit être suivie par l''assistante import/export (Gestion de containers).';

            trigger OnValidate()
            var
                LigneAchat: Record "Purchase Line";
            begin
                LigneAchat.Reset();
                LigneAchat.SetRange("Document Type", "Document Type");
                LigneAchat.SetRange("Document No.", "No.");
                if LigneAchat.FindSet(true) then
                    repeat
                        LigneAchat."Suivi container" := "Suivi container";
                        LigneAchat.Modify();
                    until LigneAchat.Next() = 0;
            end;
        }
        field(50006; "Suivi container OK"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 19/04/2021 Indique que toutes les lignes de la commande sont en container. Champ mis à jour par un traitement disponible sur la gestion des containers. Pour éviter filtre sur un FlowField.';
        }
        field(50007; "Existe ligne container non OK"; Boolean)
        {
            CalcFormula = exist("Purchase Line" where("Document Type" = field("Document Type"),
                                                       "Document No." = field("No."),
                                                       "Suivi container" = const(true),
                                                       "Suivi container OK" = const(false)));
            Description = 'KAN.FHA 19/04/2021 FlowField qui sert à la mise à jour du champ précédent lors du traitement de vérification du suivi des containers.';
            FieldClass = FlowField;
        }
        field(50008; "No. container"; Code[20])
        {
            Caption = 'N° container';
            DataClassification = ToBeClassified;
            Description = 'Utilisé uniquement au moment de la réception pour récupérer sur le bon de réception le N° de container. Au final, une commande aura vu passer plusieurs valeurs dans ce champ si elle se trouvait dans plusieurs containers. Sert aussi aux commandes transport.';
            TableRelation = Container;

            trigger OnValidate()

            begin
                //KAN.FHA 20/06/2023 DEBUT
                //On peut le saisir sur les commandes transitaire
                TestField("Commande transitaire container", true);
                //KAN.FHA 20/06/2023 FIN
            end;
        }
        field(50010; "Commentaires pour AIE"; Text[80])
        {
            Caption = 'Commentaires pour AIE';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA Gestion des containers. AIE = Assistant(e) Import/Export';
        }
        field(50012; "Commentaires prev. transport"; Text[80])
        {
            Caption = 'Commentaires prévision transport';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 16/06/2023';
        }
        field(50013; "Commentaires suivi production"; Text[250])
        {
            Caption = 'Commentaires suivi production';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 15/05/2024';
        }

        field(50016; "Commande transitaire container"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 20/06/2023';
        }
        field(50020; "Frais transitaire eclates"; Boolean)
        {
            Caption = 'Frais transitaire éclatés';
            DataClassification = ToBeClassified;
            Description = 'Permet juste d''alerter sur une commande d''acht au transitaire que les frais annexes ont déjà été éclatés (pour le module Containers, on éclate les frais en autant de fois qu''on a de commandes d''achat dans les réceptions affectées aux frais annexes)';

            trigger OnValidate()
            var
                LigneAchat: Record "Purchase Line";
                SupprimerFraisAnnexesQst: Label 'Voulez-vous supprimer les frais annexes de la commande ?';

            begin
                if not "Frais transitaire eclates" then
                    if Confirm(SupprimerFraisAnnexesQst) then begin
                        LigneAchat.Reset();
                        LigneAchat.SetRange("Document Type", "Document Type");
                        LigneAchat.SetRange("Document No.", "No.");
                        LigneAchat.SetRange(Type, LigneAchat.Type, LigneAchat.Type::"Charge (Item)");
                        LigneAchat.DeleteAll(true);
                    end;
            end;
        }
        field(50030; "Montant restant HT (DS)"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Montant restant HT (DS)" where("Document Type" = field("Document Type"),
                                                                               "Document No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50040; "Montant recu non facture HT DS"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."A. Rcd. Not Inv. Ex. VAT (LCY)" where("Document Type" = field("Document Type"),
                                                                                      "Document No." = field("No.")));
            Caption = 'Montant reçu non facturé HT DS';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50050; SAV; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 11/09/2020 Plus utilisé ?';
        }
        field(50060; Commentaires; Text[250]) //Champ Comments renommé
        {
            Caption = 'Commentaires';
            DataClassification = ToBeClassified;
            Description = 'X01';

            trigger OnValidate()
            begin
                //KAN.FHA 14/12/2022 DEBUT
                //On utilise ce champ pour nommer un PDF et cela ne fonctionne si on a un slash ou un antislash dans la valeur
                Commentaires := ConvertStr(Commentaires, '/\', '  ');
            end;
        }
        field(50070; "Annee commande"; Integer)
        {
            Caption = 'Année commande';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                ParamUtil: Record "User Setup";
            begin
                if not ParamUtil.Get(UserId) then
                    ParamUtil.Init();

                ParamUtil.TestField("Modifier annee commande");

                PurchLine.Reset();
                PurchLine.SetRange("Document Type", "Document Type");
                PurchLine.SetRange("Document No.", "No.");
                if PurchLine.FindSet(true) then
                    PurchLine.ModifyAll("Annee commande", "Annee commande");
            end;
        }
        field(50080; "Semaine chargement"; Integer)
        {
            Caption = 'Semaine chargement';
            DataClassification = ToBeClassified;
        }
        field(50090; "Semaine reception prevue"; Integer)
        {
            Caption = 'Semaine reception prévue';
            DataClassification = ToBeClassified;
        }
        field(50190; "Code groupe"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = "Groupe client";

            trigger OnValidate()
            begin
                Rec.MAJLigneChampsAffaire();

            end;
        }
        field(50200; "Code enseigne"; Code[20])
        {
            Caption = 'Code enseigne';
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = Enseigne;

            trigger OnValidate()
            var
                Enseigne: Record Enseigne;
            begin
                if "Code enseigne" <> '' then begin
                    Enseigne.Get("Code enseigne");
                    "Code groupe" := Enseigne."Code groupe";
                    //KAN.FHA 12/03/2021 DEBUT
                    if Enseigne."Enseigne interne" then
                        "Code chantier" := Enseigne.ChantierAnnuel("Posting Date");
                    //KAN.FHA 12/03/2021 FIN
                end else
                    "Code groupe" := '';

                MAJLigneChampsAffaire();
            end;
        }
        field(50210; "Code operation"; Code[20])
        {
            Caption = 'Code opération';
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = Operations.Code where("Code enseigne" = field("Code enseigne"));

            trigger OnValidate()
            begin
                MAJLigneChampsAffaire();
            end;
        }
        field(50220; "Code chantier"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = Chantier where("Chantier archive" = const(false));

            trigger OnValidate()
            var
                Chantier: Record Chantier;
            begin
                if "Code chantier" <> '' then begin
                    TestField("Achat pour stock", false);
                    Chantier.Get("Code chantier");
                    Chantier.TestField(Cloture, false);
                    Validate("Code enseigne", Chantier."Code enseigne");
                end;

                if "Code chantier" <> xRec."Code chantier" then
                    "Code operation" := '';

                //KAN.FHA 10/08/2020 DEBUT
                MAJLigneChampsAffaire();
                //KAN.FHA 10/08/2020 FIN
            end;
        }
        //Lorsque l'achat n'est passé que pour une phase d'un document de vente, la phase est recopiée sur l'achat au moment du "Créer commande achat" depuis la vente
        field(50224; "Info phases"; Text[10])
        {
            Caption = 'Info phases';
            DataClassification = ToBeClassified;
        }
        //Lorsque l'achat n'est passé que pour un document de vente, les champs suivants sont renseignés par le système au moment du "Créer commande achat" depuis la vente
        field(50226; "Type doc. vente"; Enum "Sales Document Type")
        {
            Caption = 'Type doc. vente';
            DataClassification = ToBeClassified;
        }
        field(50227; "No. doc. vente"; Code[20])
        {
            Caption = 'N° doc. vente';
            DataClassification = ToBeClassified;
        }

        field(50228; "Date livraison chantier"; Date)
        {
            Caption = 'Date livraison chantier';
            DataClassification = ToBeClassified;
            //FieldClass = FlowField;
            //CalcFormula = lookup("Phases document"."Date livraison demandee" where("Type document" = field("Type doc. vente"), "No. document" = field("No. doc. vente"), Phase = field(Phase)));
            Editable = false;
        }


        field(50230; "Date validite"; Date) //Pour les commandes cadres
        {
            Caption = 'Date validité';
            DataClassification = ToBeClassified;
        }
        field(50590; "Date intention chargement"; Date) //Previsionnelle, saisie par le chargé d'affaires
        {
            Caption = 'Date intention chargement';
            DataClassification = ToBeClassified;
            TableRelation = "Semainier chargement import"."Date debut semaine" where("No. fournisseur" = field("Buy-from Vendor No."));
            trigger OnValidate()
            var
                SaisieErr: Label 'Vous ne pouvez plus modifier la valeur du champ %1 si le champ %2 a déjà été renseigné.', Comment = '%1 = Date de la semaine de chargement ; %2 = Date réelle de chargement';
            begin
                //KAN.FHA 11/05/2026 DEBUT
                if "Date chargement confirmee" <> 0D then
                    error(SaisieErr, Rec.FieldCaption("Date intention chargement"), Rec.FieldCaption("Date chargement confirmee"));
                //KAN.FHA 11/05/2026 FIN
                //KAN.FHA 22/05/2026 DEBUT
                "Date intention chargement" := CalcDate('<-CW>', "Date intention chargement");
                "Semaine chargement" := Date2DWY("Date intention chargement", 2);
                //KAN.FHA 22/05/2026 FIN
                MAJAnneeCommande();
            end;
        }
        field(50594; "Livraison directe"; Boolean) //Rien à voir avec le flux standard de livraison directe de BC
        {
            Caption = 'Livraison directe';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                LigneAchat: Record "Purchase Line";
            begin
                LigneAchat.Reset();
                LigneAchat.SetRange("Document Type", "Document Type");
                LigneAchat.SetRange("Document No.", "No.");
                LigneAchat.ModifyAll("Livraison directe", "Livraison directe");
            end;
        }

        field(50600; "Date chargement confirmee"; Date) //Date réelle de chargement saisie par l'agent d'import/export
        {
            Caption = 'Date chargement confirmée';
            DataClassification = ToBeClassified;
            Description = 'AB1807';

            trigger OnValidate()
            var
                PaymentTerms: Record "Payment Terms";
            begin
                //KAN.FHA 20/04/2023 DEBUT
                if "Date chargement confirmee" <> 0D then begin
                    "Semaine chargement" := Date2DWY("Date chargement confirmee", 2);
                    if "Payment Terms Code" <> '' then begin
                        PaymentTerms.get("Payment Terms Code");
                        "Due Date" := CalcDate(PaymentTerms."Due Date Calculation", "Date chargement confirmee");
                    end;
                    //KAN.FHA 03/05/2026 DEBUT
                    if "Suivi container" then
                        "Date intention chargement" := CalcDate('<-CW>', "Date chargement confirmee");
                    //KAN.FHA 03/05/2026 FIN
                end;
                //KAN.FHA 20/04/2023 FIN

                MAJAnneeCommande();

            end;
        }

        field(50610; "SAV Type"; Option)
        {
            Caption = 'Type SAV';
            DataClassification = ToBeClassified;
            Description = 'AB1807';
            OptionCaption = ' ,FOURNISSEUR,ABRANE';
            OptionMembers = " ",FOURNISSEUR,ABRANE;
        }
        field(50620; "Achat pour stock"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';

            trigger OnValidate()
            var
                ParamUtil: Record "User Setup";
                LigneAchat: Record "Purchase Line";
                CodeEnseigne: Code[20];

                MAJChampNonAutoriseeErr: Label 'Vous n''êtes pas autorisé à modifier ce champ.';
            begin
                if not ParamUtil.Get(UserId) then
                    ParamUtil.Init();

                if not ParamUtil."Gerer case a cocher Stock" then
                    Error(MAJChampNonAutoriseeErr);

                if "Achat pour stock" then begin
                    CodeEnseigne := "Code enseigne";
                    Validate("Code chantier", '');
                    Validate("Code enseigne", CodeEnseigne);
                end;

                LigneAchat.Reset();
                LigneAchat.SetRange("Document Type", "Document Type");
                LigneAchat.SetRange("Document No.", "No.");
                if LigneAchat.FindSet(true) then
                    repeat
                        if LigneAchat."No." <> '' then begin
                            LigneAchat."Achat pour stock" := "Achat pour stock";
                            LigneAchat.Modify();
                        end;
                    until LigneAchat.Next() = 0;
            end;
        }

        field(50629; "No. fournisseur"; Code[20]) //Champ qui reprend la valeur du Buy-from vendor N° car j'ai besoin d'avoir une clé de parcours mélangeant champs std et spec
        {
            Caption = 'N° fournisseur';
            DataClassification = ToBeClassified;
        }

        field(50630; "Affectations manquantes"; Integer)
        {
            CalcFormula = count("Purchase Line" where("Document Type" = field("Document Type"),
                                                       "Document No." = field("No."),
                                                       "Affectation manquante" = const(true)));
            Description = 'Pour les factures. Le champ [Affectation manquante] des lignes est calculé quand on extrait les réceptions puis qu''on essaie de valider en facture enregistrée.';
            Editable = false;
            FieldClass = FlowField;
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
        key(MyKey3; "Suivi container", "Suivi container OK")
        {

        }
        key(MyKey4; "Code enseigne", "Achat pour stock")
        {

        }
        key(MyKey5; "Suivi container", "Suivi container OK", "Semaine chargement")
        {

        }
        key(MyKey6; "Commande transitaire container", "No. container")
        {

        }
        key(MyKey7; "No. fournisseur", "Suivi container", "Suivi container OK", "Date intention chargement")
        {

        }
        key(MyKey8; "Suivi container", "Suivi container OK", "Semaine chargement", "No. fournisseur")
        {

        }
        key(MyKey9; "No. doc. vente")
        {

        }
    }

    procedure VerifierLigneArticleSansNum()
    var
        LigneAchat: Record "Purchase Line";
        LigneArticleSansNulErr: label 'La ligne %1 est de type Article mais aucun article n''a été saisi. Saisissez un N° article ou enlevez le type Article.', Comment = '%1 = N° ligne';
    begin
        LigneAchat.RESET();
        LigneAchat.SETRANGE("Document Type", Rec."Document Type");
        LigneAchat.SETRANGE("Document No.", Rec."No.");
        LigneAchat.SETFILTER(Type, '<> %1', LigneAchat.Type::" ");
        LigneAchat.SETFILTER("No.", '=%1', ' ');
        if LigneAchat.FindFirst() then
            ERROR(LigneArticleSansNulErr, LigneAchat."Line No.");
    end;

    procedure MAJAnneeCommande()
    var
        Fournisseur: Record Vendor;
        TypeFournisseur: Record "Type fournisseur";
        Pays: Record "Country/Region";
        JourSemaine: Integer;
        NouvelleDate: date;
        DateChargement: date;
        ExprCalcDate: Text;
    begin
        //KAN.FHA 07/05/2026 DEBUT
        if "Date chargement confirmee" <> 0D then
            DateChargement := "Date chargement confirmee"
        else
            DateChargement := "Date intention chargement";

        if DateChargement <> 0D then begin
            if not Fournisseur.GET("Buy-from Vendor No.") then
                Fournisseur.INIT();
            if not TypeFournisseur.GET(Fournisseur."Type fournisseur") then
                TypeFournisseur.INIT();
            if TypeFournisseur."Annee cde ach = annee chargt" then
                "Annee commande" := DATE2DMY(DateChargement, 3);
            if Pays.Get(Fournisseur."Country/Region Code") and (Pays."Delai transit (jours)" <> 0) then begin
                ExprCalcDate := '<' + Format(Pays."Delai transit (jours)") + 'D>';

                //KAN.FHA 22/05/2026 DEBUT
                NouvelleDate := CalcDate(ExprCalcDate, DateChargement);
                JourSemaine := Date2DWY(NouvelleDate, 1);
                while JourSemaine > 5 do begin
                    NouvelleDate := CalcDate('<+1D>', NouvelleDate);
                    JourSemaine := Date2DWY(NouvelleDate, 1);
                end;

                Validate("Expected Receipt Date", NouvelleDate);
                //KAN.FHA 22/05/2026 FIN
            end;
        end else
            "Annee commande" := DATE2DMY(TODAY, 3);
        //KAN.FHA 07/05/2026 FIN

        PurchLine.Reset();
        PurchLine.SetRange("Document Type", "Document Type");
        PurchLine.SetRange("Document No.", "No.");
        if PurchLine.FindSet(true) then
            PurchLine.ModifyAll("Annee commande", "Annee commande");
    end;

    procedure ProposerImpressions()
    var
        ChoixImpressions: Record "Choix impressions achat";
        EnteteAchat: Record "Purchase Header";
        SelectionEtatsAchats: Record "Report Selections";
        PageChoixImpressions: page "Choix impressions achat";
        CodeUtil: Code[50];

    begin
        CodeUtil := CopyStr(UserId, 1, 50);
        ChoixImpressions.SetRange("Code utilisateur", CodeUtil);
        ChoixImpressions.DeleteAll();
        SelectionEtatsAchats.SetRange(Usage, SelectionEtatsAchats.Usage::"P.Order");
        if SelectionEtatsAchats.FindFirst() then begin
            ChoixImpressions.Init();
            ChoixImpressions."Code utilisateur" := CodeUtil;
            ChoixImpressions."Type document" := ChoixImpressions."Type document"::"Commande achat";
            ChoixImpressions."No. document" := Rec."No.";
            ChoixImpressions.Document := 'Commande achat';

            ChoixImpressions."No. etat" := SelectionEtatsAchats."Report ID";
            ChoixImpressions.Imprimer := true;
            ChoixImpressions.Insert();
        end;
        CalcFields("No. of Archived Versions");
        if Rec."No. of Archived Versions" > 1 then begin
            ChoixImpressions.Init();
            ChoixImpressions."Code utilisateur" := CodeUtil;
            ChoixImpressions."Type document" := ChoixImpressions."Type document"::"Commande achat";
            ChoixImpressions."No. document" := Rec."No.";

            ChoixImpressions.Document := 'Evolutions commande achat';
            ChoixImpressions."No. etat" := 50000;
            ChoixImpressions.Imprimer := true;
            ChoixImpressions.Insert();
            EnteteAchat.get(EnteteAchat."Document Type"::order, Rec."No.");
            EnteteAchat.ComparerVersionsArchives(Rec."No. of Archived Versions" - 1, Rec."No. of Archived Versions");
        end;
        ChoixImpressions.Init();
        ChoixImpressions."Code utilisateur" := CodeUtil;
        ChoixImpressions."Type document" := ChoixImpressions."Type document"::"Commande achat";
        ChoixImpressions."No. document" := Rec."No.";

        ChoixImpressions.Document := 'Etiquette palette';
        ChoixImpressions."No. etat" := 50098;
        ChoixImpressions.Imprimer := true;
        ChoixImpressions.Insert();
        //exit;
        Clear(PageChoixImpressions);
        //ChoixImpressions.SetRange("Code utilisateur",CodeUtil);
        //PageChoixImpressions.SetTableView(ChoixImpressions);
        PageChoixImpressions.Run();
    end;

    procedure DiversNonAffecte(var pNumLigne: Integer): Boolean
    var
        LigRecepAchat: Record "Purch. Rcpt. Line";
        LigneCdeAchat: Record "Purchase Line";
        EnteteAchat: Record "Purchase Header";
        Article: Record Item;
        AffectationManquante: Boolean;

    begin
        if not ("Document Type" in ["Document Type"::Order, "Document Type"::Invoice]) then
            exit(false);

        AffectationManquante := false;

        PurchLine.SetRange("Document Type", "Document Type");
        PurchLine.SetRange("Document No.", "No.");
        PurchLine.SetRange(Type, PurchLine.Type::Item);

        case "Document Type" of
            "Document Type"::Order:

                //KAN.FHA 21/10/2020 DEBUT
                if "Achat pour stock" then
                    AffectationManquante := false
                else
                    //KAN.FHA 21/10/2020 FIN
                    if PurchLine.FindSet(false) then
                        repeat
                            if Article.Get(PurchLine."No.") then
                                if Article."Miscellaneous Item" then begin
                                    PurchLine.CalcFields("Nb lignes ventes liees");
                                    if (PurchLine."Nb lignes ventes liees" = 0) then begin
                                        AffectationManquante := true;
                                        pNumLigne := PurchLine."Line No.";
                                    end;
                                end;
                        until (PurchLine.Next() = 0) or (AffectationManquante);

            "Document Type"::Invoice:

                if PurchLine.FindSet(true) then
                    repeat
                        if PurchLine."Receipt No." <> '' then begin
                            PurchLine."Affectation manquante" := false;
                            LigRecepAchat.Get(PurchLine."Receipt No.", PurchLine."Receipt Line No.");
                            LigneCdeAchat.Get(LigneCdeAchat."Document Type"::Order, LigRecepAchat."Order No.", LigRecepAchat."Order Line No.");
                            if Article.Get(LigneCdeAchat."No.") then
                                if Article."Miscellaneous Item" then begin
                                    EnteteAchat.Get(LigneCdeAchat."Document Type", LigneCdeAchat."Document No.");
                                    if not EnteteAchat."Achat pour stock" then begin
                                        LigneCdeAchat.CalcFields("Nb lignes ventes liees");
                                        if (LigneCdeAchat."Nb lignes ventes liees" = 0) and (not EnteteAchat."Achat pour stock") then begin
                                            AffectationManquante := true;
                                            PurchLine."Affectation manquante" := true;
                                            pNumLigne := PurchLine."Line No.";
                                        end;
                                    end;
                                end;
                            PurchLine.Modify();
                        end else begin //On est sur une ligne d'article ajoutée manuellement dans la facture donc non affectée à ce stade
                            AffectationManquante := true;
                            PurchLine."Affectation manquante" := true;
                            PurchLine.Modify();
                        end;
                    until (PurchLine.Next() = 0);

        end;

        exit(AffectationManquante);
    end;

    procedure VerifChampsAffaire()
    var
        Enseigne: Record Enseigne;
        Chantier: Record Chantier;
        Groupe: Record "Groupe client";
        CodeGroupeErr: Label 'Le Groupe est incohérent avec le groupe de l''enseigne.';
        CodeEnseigneErr: Label 'L''enseigne n''est pas la même entre le document et le chantier.';

    begin
        //KAN.FHA 10/08/2020
        //Cette fonction est notamment appelée quand on cherche à facturer un achat (CU90).
        TestField("Code chantier");
        TestField("Code groupe");
        TestField("Code enseigne");
        Enseigne.Get("Code enseigne");
        Groupe.Get("Code groupe");
        Chantier.Get("Code chantier");

        if "Code groupe" <> Enseigne."Code groupe" then
            Error(CodeGroupeErr);

        if "Code enseigne" <> Chantier."Code enseigne" then
            Error(CodeEnseigneErr);
    end;

    procedure MAJLigneChampsAffaire()
    var
        LigneAchat: Record "Purchase Line";
    begin
        LigneAchat.LockTable();
        Modify();

        LigneAchat.Reset();
        LigneAchat.SetRange("Document Type", "Document Type");
        LigneAchat.SetRange("Document No.", "No.");
        if LigneAchat.FindSet(true) then
            repeat
                if LigneAchat."No." <> '' then begin
                    LigneAchat."Code groupe" := "Code groupe";
                    LigneAchat."Code enseigne" := "Code enseigne";
                    LigneAchat."Code operation" := "Code operation";
                    LigneAchat."Code chantier" := "Code chantier";
                    LigneAchat.Modify();
                end;
            until LigneAchat.Next() = 0;
    end;

    procedure LigneSansCout(var pNumLigne: Integer): Boolean
    var
        LigneSansCoutBoolean: Boolean;
    begin
        if "Document Type" <> "Document Type"::Order then
            exit(false);

        //KAN.FHA 24/08/2022 DEBUT
        if "SAV Type" = "SAV Type"::FOURNISSEUR then
            exit(false);
        //KAN.FHA 24/08/2022 FIN

        LigneSansCoutBoolean := false;

        PurchLine.SetRange("Document Type", "Document Type");
        PurchLine.SetRange("Document No.", "No.");
        PurchLine.SetRange(Type, PurchLine.Type::Item);
        if PurchLine.FindSet(false) then
            repeat
                if (PurchLine."Qty. to Receive" <> 0) and (PurchLine."Direct Unit Cost" = 0) then begin
                    LigneSansCoutBoolean := true;
                    pNumLigne := PurchLine."Line No.";
                end;
            until (PurchLine.Next() = 0) or (LigneSansCoutBoolean);

        exit(LigneSansCoutBoolean);
    end;

    procedure RemplirQuantiteVersContainer()

    begin
        PurchLine.Reset();
        PurchLine.SetRange("Document Type", "Document Type");
        PurchLine.SetRange("Document No.", "No.");
        if PurchLine.FindSet(true) then
            repeat
                PurchLine.CalcFields("Quantite en container");
                PurchLine.Validate("Quantite vers container", PurchLine.Quantity - PurchLine."Quantite en container");
                PurchLine.Modify();
            until PurchLine.Next() = 0;
    end;

    procedure ViderQuantiteVersContainer()
    begin
        PurchLine.Reset();
        PurchLine.SetRange("Document Type", "Document Type");
        PurchLine.SetRange("Document No.", "No.");
        if PurchLine.FindSet(true) then
            repeat
                PurchLine.Validate("Quantite vers container", 0);
                PurchLine.Modify();
            until PurchLine.Next() = 0;
    end;

    procedure EnvoyerLignesVersContainer()
    var
        Container: Record Container;
        PurchLine2: Record "Purchase Line";
        LigneContainer: Record "Ligne container";
        ChoixContainerErr: Label 'Vous devez indiquer au système s''il doit créer un nouveau container ou ajouter les lignes à un container existant.';
        NumLigne: Integer;
        OuvrirContainerCompleteMsg: Label 'Les lignes sélectionnées ont été ajoutées au container %1. ', Comment = '%1 = N° container';

    begin
        if "Choix container" = "Choix container"::" " then
            Error(ChoixContainerErr);

        if "Choix container" = "Choix container"::"Ajouter à container existant" then
            TestField("No. container existant");

        if "Choix container" = "Choix container"::"Créer nouveau container" then begin
            Container.Init();
            Container."No." := '';
            Container.Insert(true);
            NumLigne := 10000;
        end else begin
            Container.Get("No. container existant");
            LigneContainer.SetRange("No. container", "No. container existant");
            if LigneContainer.FindLast() then
                NumLigne := LigneContainer."No. ligne" + 10000
            else
                NumLigne := 10000;
        end;

        PurchLine.Reset();
        PurchLine.SetRange("Document Type", "Document Type");
        PurchLine.SetRange("Document No.", "No.");
        PurchLine.SetFilter("Quantite vers container", '<>%1', 0);
        if PurchLine.FindSet(true) then begin
            repeat
                LigneContainer.Init();
                LigneContainer."No. ligne" := NumLigne;
                LigneContainer."No. container" := Container."No.";
                LigneContainer."No. commande achat" := PurchLine."Document No.";
                LigneContainer."No. ligne commande achat" := PurchLine."Line No.";
                LigneContainer."No." := PurchLine."No.";
                LigneContainer.Description := PurchLine.Description;
                LigneContainer.Validate(Quantite, PurchLine."Quantite vers container");
                LigneContainer."Cout unitaire facture (papier)" := PurchLine."Cout unitaire facture (papier)";
                LigneContainer."Cout unitaire direct" := PurchLine."Direct Unit Cost";
                LigneContainer."Montant facture (papier)" := PurchLine."Montant facture (papier)";
                LigneContainer."Code devise" := PurchLine."Currency Code";
                //KAN.FHA 24/08/2022 DEBUT
                LigneContainer."No. facture fournisseur" := "Vendor Invoice No.";
                //KAN.FHA 24/08/2022 FIN
                //KAN.FHA 17/10/2022 DEBUT
                LigneContainer."Poids net unitaire" := PurchLine."Net Weight";
                LigneContainer."Nomenclature produits" := PurchLine."Nomenclature produits";
                //KAN.FHA 17/10/2022 FIN
                LigneContainer.Insert();
                PurchLine2.Get(PurchLine."Document Type", PurchLine."Document No.", PurchLine."Line No.");
                //KAN.FHA 12/12/2022 DEBUT
                if PurchLine2."Direct Unit Cost" = 0 then
                    PurchLine2.Validate("Direct Unit Cost", PurchLine."Cout unitaire facture (papier)");
                //KAN.FHA 12/12/2022 FIN

                PurchLine2."Quantite vers container" := 0;
                PurchLine2."Montant vers container" := 0;
                PurchLine2."Montant facture (papier)" := 0;
                PurchLine2.Modify();
                NumLigne := NumLigne + 10000;
            until PurchLine.Next() = 0;
            "Vendor Invoice No." := '';
        end;

        "Choix container" := "Choix container"::" ";
        "No. container existant" := '';
        Modify();

        Message(OuvrirContainerCompleteMsg, Container."No.");
    end;

    procedure GenererEtiquettePalette(pImpressionDirecte: Boolean)
    var
        EtiquettePalette: Record "Etiquettes palettes";
        Chantier: Record Chantier;
    begin
        EtiquettePalette.Reset();
        EtiquettePalette.SetRange("Code utilisateur", UserId);
        EtiquettePalette.DeleteAll();
        if "Code chantier" <> '' then
            if not EtiquettePalette.Get(UserId, "No.", PurchLine."Code enseigne", PurchLine."Code chantier", PurchLine."Document No.") then begin
                Chantier.Get("Code chantier");
                EtiquettePalette.Init();
                EtiquettePalette."Code utilisateur" := copystr(UserId, 1, 50);
                EtiquettePalette."No. container" := '';
                EtiquettePalette."Code enseigne" := "Code enseigne";
                EtiquettePalette."Code chantier" := "Code chantier";
                EtiquettePalette."No. commande achat" := "No.";
                EtiquettePalette."No. packing list" := '';
                EtiquettePalette."Nom chantier" := Chantier."Nom chantier";
                EtiquettePalette."Nom chantier 2" := Chantier."Nom chantier 2";
                EtiquettePalette."Adresse chantier" := Chantier."Adresse chantier";
                EtiquettePalette."Adresse chantier 2" := Chantier."Adresse chantier 2";
                EtiquettePalette."Code postal chantier" := Chantier."Code postal chantier";
                EtiquettePalette."Ville chantier" := Chantier."Ville chantier";
                EtiquettePalette."Code pays chantier" := Chantier."Code pays chantier";
                EtiquettePalette."Contact/No. tel chantier" := CopyStr(Chantier."Contact chantier" + '-' + Chantier."No. téléphone chantier", 1, 80);
                EtiquettePalette.Insert();
            end;

        Commit();

        if pImpressionDirecte then
            if EtiquettePalette.FindFirst() then
                REPORT.Run(REPORT::"Etiquette palette", true, false, EtiquettePalette);
    end;

    procedure RecupDateLivDemandeeVente(var pNumCdeSiUnique: Code[20]; var pCodesDossiersBE: Text[80]): Text[20]
    var
        EnteteVente: Record "Sales Header";
        LienAchatVente: Record "Affectations achat vente";
        PlusieursCommandesTxt: Label 'Plusieurs commandes';
        NumCdeVente: Code[20];
    begin
        pNumCdeSiUnique := '';

        if "Document Type" <> "Document Type"::Order then
            exit('');
        LienAchatVente.Reset();
        LienAchatVente.SetCurrentKey("No. document achat", "Type document vente", "No. document vente");
        LienAchatVente.SetRange("No. document achat", "No.");
        LienAchatVente.SetRange("Type document vente", LienAchatVente."Type document vente"::Commande);
        NumCdeVente := '';
        pCodesDossiersBE := '';
        if LienAchatVente.FindSet(false) then
            repeat
                if LienAchatVente."No. document vente" <> '' then begin
                    if NumCdeVente = '' then
                        NumCdeVente := LienAchatVente."No. document vente"
                    else
                        if LienAchatVente."No. document vente" <> NumCdeVente then
                            NumCdeVente := PlusieursCommandesTxt;

                    //KAN.FHA 13/10/2025 DEBUT
                    if EnteteVente.get(EnteteVente."Document Type"::Order, LienAchatVente."No. document vente") then
                        if strpos(pCodesDossiersBe, EnteteVente."No. dossier BE") <> 0 then
                            pCodesDossiersBE := copystr(pCodesDossiersBE + ' ' + EnteteVente."No. dossier BE", 1, 80);
                    //KAN.FHA 13/10/2025 FIN
                end;
            until LienAchatVente.Next() = 0;

        if (NumCdeVente <> '') and (NumCdeVente <> PlusieursCommandesTxt) then begin
            pNumCdeSiUnique := NumCdeVente;
            if not EnteteVente.Get(EnteteVente."Document Type"::Order, NumCdeVente) then
                EnteteVente.Init();
            if EnteteVente."Requested Delivery Date" <> 0D then
                exit(Format(EnteteVente."Requested Delivery Date"))
            else
                exit('');
        end else
            exit('');
    end;

    procedure MAJCompletementChargee()
    var
        EnteteAchat: Record "Purchase Header";
        CompltChargee: Boolean;

    begin
        EnteteAchat.RESET();
        EnteteAchat.SETCURRENTKEY("Document Type", "Suivi container", "Suivi container OK", "Semaine chargement", EnteteAchat."Buy-from Vendor No.");
        EnteteAchat.SETRANGE("Document Type", EnteteAchat."Document Type"::Order);
        EnteteAchat.SETRANGE("Suivi container", true);
        EnteteAchat.SETRANGE("Suivi container OK", false);
        if EnteteAchat.FINDSET(false) then
            repeat
                PurchLine.SETRANGE("Document Type", EnteteAchat."Document Type");
                PurchLine.SETRANGE("Document No.", EnteteAchat."No.");
                if PurchLine.FINDSET(true) then
                    repeat
                        PurchLine.CALCFIELDS("Quantite en container");
                        CompltChargee := PurchLine."Ligne acompte" or (PurchLine.Quantity - PurchLine."Quantite en container" = 0);
                        if PurchLine."Completement chargee" <> CompltChargee then begin
                            PurchLine."Completement chargee" := CompltChargee;
                            PurchLine.MODIFY();
                        end;
                    until PurchLine.NEXT() = 0;
            until EnteteAchat.NEXT() = 0;
    end;

    procedure CalcValeursResteACharger(var pMontantACharger: Decimal; var pPoidsNetACharger: Decimal; var pLignesSansCout: Integer; var pNbDIVSansHSCode: Integer; var pNbLignesSansPoids: Integer)
    var
        QteRestante: Decimal;
    begin
        PurchLine.SetRange("Document Type", "Document Type");
        PurchLine.SetRange("Document No.", "No.");
        PurchLine.SetRange("Ligne acompte", false);
        pMontantACharger := 0;
        pPoidsNetACharger := 0;
        pLignesSansCout := 0;
        pNbDIVSansHSCode := 0;
        pNbLignesSansPoids := 0;
        if PurchLine.FindSet(false) then
            repeat
                PurchLine.CalcFields("Quantite en container");
                QteRestante := PurchLine.Quantity - PurchLine."Quantite en container";
                if PurchLine.Quantity <> 0 then begin
                    pMontantACharger := pMontantACharger + Round(QteRestante / PurchLine.Quantity * PurchLine."Line Amount", 0.01);
                    pPoidsNetACharger := QteRestante * PurchLine."Net Weight";
                    if PurchLine."Direct Unit Cost" = 0 then
                        pLignesSansCout := pLignesSansCout + 1;
                    if PurchLine."Article divers" and (PurchLine."Nomenclature produits" = '') then
                        pNbDIVSansHSCode := pNbDIVSansHSCode + 1;
                    if (PurchLine.Type = PurchLine.Type::Item) and (PurchLine."Net Weight" = 0) then
                        pNbLignesSansPoids := pNbLignesSansPoids + 1;
                end;

            until PurchLine.Next() = 0;
    end;

    procedure CreerAvoirFnsSAV()
    var
        EnteteAvoirAchat: Record "Purchase Header";
        LigneCommandeAchat: Record "Purchase Line";
        LigneAvoirAchat: Record "Purchase Line";
        GeneralPostingSetup: Record "General Posting Setup";
        AffectationAchatVenteExistante: Record "Affectations achat vente";
        NouvelleAffectationAchatVente: Record "Affectations achat vente";
    begin
        //Dans le cas des SAV fournisseurs, certains fournisseurs facturent l'article à un certaine valeur (pour passer les douanes) puis annulent cela par un avoir.
        //Cette fonction permet de générer un avoir dans ce cas sachant qu'on utilise pour l'avoir le compte 607 lié à l'article d'origine.
        //Pour information, d'autres fournisseurs facturent à zéro et on va alors procéder autrtement : on va demander au syst-me de créer une ligne d'écart de prix :
        //  la ligne d'article est maintenue au prix facturé par le fournisseur (on ne veut pas facturer à éro pour ne pas faire chuter le PMP)
        //  une ligne est ajoutée sur un compte 607 avec un coût annulant le coût de l'article.

        TestField("SAV Type", "SAV Type"::FOURNISSEUR);

        EnteteAvoirAchat.Init();
        EnteteAvoirAchat."Document Type" := EnteteAvoirAchat."Document Type"::"Credit Memo";
        EnteteAvoirAchat."No." := '';
        EnteteAvoirAchat.Insert(true);
        EnteteAvoirAchat.Validate("Buy-from Vendor No.", "Buy-from Vendor No.");
        EnteteAvoirAchat.Validate("Code chantier", "Code chantier");
        EnteteAvoirAchat."SAV Type" := "SAV Type";
        EnteteAvoirAchat.Modify();

        LigneCommandeAchat.SetRange("Document Type", "Document Type");
        LigneCommandeAchat.SetRange("Document No.", "No.");
        LigneCommandeAchat.SetRange(Type, LigneCommandeAchat.Type::Item);
        if LigneCommandeAchat.FindSet(false) then
            repeat
                GeneralPostingSetup.Get(LigneCommandeAchat."Gen. Bus. Posting Group", LigneCommandeAchat."Gen. Prod. Posting Group");

                LigneAvoirAchat.Init();
                LigneAvoirAchat."Document Type" := EnteteAvoirAchat."Document Type";
                LigneAvoirAchat."Document No." := EnteteAvoirAchat."No.";
                LigneAvoirAchat."Line No." := LigneCommandeAchat."Line No.";
                LigneAvoirAchat.Insert();
                LigneAvoirAchat.Validate(Type, LigneAvoirAchat.Type::"G/L Account");
                LigneAvoirAchat.Validate("No.", GeneralPostingSetup."Purch. Account");
                LigneAvoirAchat.Validate(Quantity, LigneCommandeAchat.Quantity);
                LigneAvoirAchat.Validate("Direct Unit Cost", -LigneCommandeAchat."Direct Unit Cost");
                LigneAvoirAchat.Modify();

                //L'affectation Achat/Vente doit être la même que la ligne d'origine
                AffectationAchatVenteExistante.SetRange("No. document achat", LigneCommandeAchat."Document No.");
                AffectationAchatVenteExistante.SetRange("No. ligne document achat", LigneCommandeAchat."Line No.");
                if AffectationAchatVenteExistante.FindSet(false) then
                    repeat
                        NouvelleAffectationAchatVente.Init();
                        NouvelleAffectationAchatVente."No. document achat" := LigneAvoirAchat."Document No.";
                        NouvelleAffectationAchatVente."No. ligne document achat" := LigneAvoirAchat."Line No.";
                        NouvelleAffectationAchatVente."Type document vente" := AffectationAchatVenteExistante."Type document vente";
                        NouvelleAffectationAchatVente."No. document vente" := AffectationAchatVenteExistante."No. document vente";
                        NouvelleAffectationAchatVente."No. ligne document vente" := AffectationAchatVenteExistante."No. ligne document vente";
                        NouvelleAffectationAchatVente.Insert();
                        NouvelleAffectationAchatVente.Validate("Quantite affectee", LigneAvoirAchat.Quantity);
                        NouvelleAffectationAchatVente.Modify();
                    until AffectationAchatVenteExistante.Next() = 0;
            until LigneCommandeAchat.Next() = 0;

    end;

    procedure MAJDescriptionsEnFRA()
    var
        lLigneAchat: Record "Purchase Line";
        VarianteArticle: Record "Item Variant";
        Article: Record Item;
        TraduireEnFRAQst: label 'Voulez-vous que les désignations des articles soient en français ?\Les articles divers ne sont pas concernés.\Attention, si vous aviez personnalisé certaines désignations sur les lignes, ces personnalisations seront perdues.';
    begin

        if not CONFIRM(TraduireEnFRAQst, FALSE) THEN
            exit;
        lLigneAchat.SETRANGE("Document Type", "Document Type");
        lLigneAchat.SETRANGE("Document No.", "No.");
        lLigneAchat.SETRANGE(Type, lLigneAchat.Type::Item);
        if lLigneAchat.FINDSET(true) then
            repeat
                if not lLigneAchat."Article divers" then
                    if lLigneAchat."Variant Code" = '' then begin
                        if Article.GET(lLigneAchat."No.") THEN begin
                            lLigneAchat.Description := Article.Description;
                            lLigneAchat.MODIFY();
                        end
                    end else
                        if VarianteArticle.GET(lLigneAchat."No.", lLigneAchat."Variant Code") THEN
                            if VarianteArticle.Description <> '' then begin
                                lLigneAchat.Description := VarianteArticle.Description;
                                lLigneAchat.MODIFY();
                            end else
                                if Article.GET(lLigneAchat."No.") then begin
                                    lLigneAchat.Description := Article.Description;
                                    lLigneAchat.MODIFY();
                                end else
                                    if Article.GET(lLigneAchat."No.") then begin
                                        lLigneAchat.Description := Article.Description;
                                        lLigneAchat.MODIFY();
                                    end

            until lLigneAchat.NEXT() = 0;
    end;

    procedure MAJDescriptionsEnENU()
    var
        lLigneAchat: Record "Purchase Line";
        TraductionArticle: Record "Item Translation";
        TraduireEnENUQst: Label 'Voulez-vous que les désignations des articles soient en anglais ?\Les articles divers ne sont pas concernés.\Attention, si vous aviez personnalisé certaines désignations sur les lignes, ces personnalisations seront perdues.';
    begin

        if not CONFIRM(TraduireEnENUQst, FALSE) THEN
            exit;

        lLigneAchat.SETRANGE("Document Type", "Document Type");
        lLigneAchat.SETRANGE("Document No.", "No.");
        lLigneAchat.SETRANGE(Type, lLigneAchat.Type::Item);
        if lLigneAchat.FINDSET(TRUE) THEN
            repeat
                if not lLigneAchat."Article divers" THEN
                    if TraductionArticle.GET(lLigneAchat."No.", lLigneAchat."Variant Code", 'ENU') then begin
                        lLigneAchat.Description := TraductionArticle.Description;
                        lLigneAchat.MODIFY();
                    end
            until lLigneAchat.NEXT() = 0;
    end;

    procedure Archiver()
    var
        ArchiveManagement: Codeunit ArchiveManagement;
        MontantDernArchive: Decimal;
        NoVersionDernArchive: Integer;
        DateDernArchive: Date;
    begin
        CalcFields("No. of Archived Versions");
        if Rec."No. of Archived Versions" = 0 then begin
            ArchiveManagement.StorePurchDocument(Rec, false);
            commit();
        end else begin
            rec.CalcFields(Amount);
            RecupInfosDerniereArchive(MontantDernArchive, NoVersionDernArchive, DateDernArchive);
            if Amount <> MontantDernArchive then begin
                ArchiveManagement.StorePurchDocument(Rec, false);
                commit();
            end;
        end;
    end;

    procedure RecupInfosDerniereArchive(var pMontant: Decimal; var pNoVersion: Integer; var pDateVersion: Date)
    var
        EnteteArchiveAchat: Record "Purchase Header Archive";
    begin
        EnteteArchiveAchat.SetRange("Document Type", "Document Type");
        EnteteArchiveAchat.SetRange("No.", "No.");
        if EnteteArchiveAchat.FindLast() then begin
            pMontant := EnteteArchiveAchat."Montant archive";
            pNoVersion := EnteteArchiveAchat."Version No.";
            pDateVersion := EnteteArchiveAchat."Date Archived";
        end else begin
            pMontant := 0;
            pNoVersion := 0;
            pDateVersion := 0D;
        end;
    end;

    procedure ObtenirInfosDocumentVenteLie(var pNoDocVente: Text; var pDateChargementTxt: Text; var pDateLivraisonDemandeeTxt: Text)
    var
        Affectation: Record "Affectations achat vente";
        SalesHeader: Record "Sales Header";
        TempSalesHeader: Record "Sales Header" temporary;
        NbTrouve: Integer;
        MultipleTxt: Label 'Multiple';
    begin
        pNoDocVente := '';
        pDateChargementTxt := '';
        pDateLivraisonDemandeeTxt := '';

        if "No." = '' then
            exit;

        Affectation.Reset();
        Affectation.SetCurrentKey("No. document achat", "No. ligne document achat", "Type document vente", "No. document vente", "No. ligne document vente");
        Affectation.SetRange("No. document achat", "No.");
        Affectation.SetFilter("Type document vente", '%1|%2', Affectation."Type document vente"::Devis, Affectation."Type document vente"::Commande);
        Affectation.SetFilter("No. document vente", '<>%1', '');

        if not Affectation.FindSet() then
            exit;

        repeat
            if not TempSalesHeader.Get(ConvertirTypeDocVente(Affectation."Type document vente"), Affectation."No. document vente") then begin
                TempSalesHeader.Init();
                TempSalesHeader."Document Type" := ConvertirTypeDocVente(Affectation."Type document vente");
                TempSalesHeader."No." := Affectation."No. document vente";
                TempSalesHeader.Insert();
            end;
        until Affectation.Next() = 0;

        NbTrouve := TempSalesHeader.Count();

        if NbTrouve = 0 then
            exit;

        if NbTrouve > 1 then begin
            pNoDocVente := MultipleTxt;
            pDateChargementTxt := MultipleTxt;
            pDateLivraisonDemandeeTxt := MultipleTxt;
            exit;
        end;

        TempSalesHeader.FindFirst();
        if SalesHeader.Get(TempSalesHeader."Document Type", TempSalesHeader."No.") then begin
            pNoDocVente := SalesHeader."No.";
            pDateChargementTxt := Format(SalesHeader."Date chargement");
            pDateLivraisonDemandeeTxt := Format(SalesHeader."Requested Delivery Date");
        end;
    end;

    local procedure ConvertirTypeDocVente(pTypeDocVente: Option Devis,Commande,"Facture enregistrée","Avoir enregistré"): Enum "Sales Document Type"
    begin
        case pTypeDocVente of
            pTypeDocVente::Devis:
                exit("Sales Document Type"::Quote);
            pTypeDocVente::Commande:
                exit("Sales Document Type"::Order);
        end;
    end;

    procedure ComparerVersionsArchives(pVersion1: Integer; pVersion2: Integer)
    var
        Comparaison: Record ComparaisonVersionsDocument;
        LigneAchatArchive: Record "Purchase Line Archive";
        CodeUtil: code[50];
    begin
        CodeUtil := CopyStr(UserId, 1, 50);

        Comparaison.Reset();
        Comparaison.SetCurrentKey("Code utilisateur");
        Comparaison.SetRange("Code utilisateur", CodeUtil);
        Comparaison.DeleteAll();

        LigneAchatArchive.SetRange("Document Type", Rec."Document Type");
        LigneAchatArchive.SetRange("Document No.", Rec."No.");
        LigneAchatArchive.SetRange("Version No.", pVersion1);
        LigneAchatArchive.SetRange(Type, LigneAchatArchive.Type::Item);
        if LigneAchatArchive.FindSet(false) then
            repeat
                if not Comparaison.get(Rec."Document Type", Rec."No.", LigneAchatArchive."No.") then begin
                    Comparaison.Init();
                    Comparaison."Code utilisateur" := CodeUtil;
                    Comparaison."Type document" := Rec."Document Type";
                    Comparaison."No. document" := Rec."No.";
                    Comparaison."No. article" := LigneAchatArchive."No.";
                    Comparaison.Description := LigneAchatArchive.Description;
                    Comparaison."Ligne modifiee" := true;
                    Comparaison."No. version A" := pVersion1;
                    Comparaison."No. version B" := pVersion2;
                    Comparaison.Insert();
                end;
                Comparaison."Quantite version A" := Comparaison."Quantite version A" + LigneAchatArchive.Quantity;
                Comparaison.Modify();
            until LigneAchatArchive.Next() = 0;

        LigneAchatArchive.SetRange("Version No.", pVersion2);
        if LigneAchatArchive.FindSet(false) then
            repeat
                if not Comparaison.get(Rec."Document Type", Rec."No.", LigneAchatArchive."No.") then begin
                    Comparaison.Init();
                    Comparaison."Code utilisateur" := CodeUtil;
                    Comparaison."Type document" := Rec."Document Type";
                    Comparaison."No. document" := Rec."No.";
                    Comparaison."No. article" := LigneAchatArchive."No.";
                    Comparaison.Description := LigneAchatArchive.Description;
                    Comparaison."No. version A" := pVersion1;
                    Comparaison."No. version B" := pVersion2;

                    Comparaison.Insert();
                end;
                Comparaison."Quantite version B" := Comparaison."Quantite version B" + LigneAchatArchive.Quantity;
                Comparaison."Ligne modifiee" := (Comparaison."Quantite version A" <> Comparaison."Quantite version B");
                //KAN.FHA 20/04/2026 DEBUT
                Comparaison."Quantite ecart (B-A)" := Comparaison."Quantite version B" - Comparaison."Quantite version A";
                //KAN.FHA 20/04/2026 FIN
                Comparaison.Modify();
            until LigneAchatArchive.Next() = 0;
    end;

}

