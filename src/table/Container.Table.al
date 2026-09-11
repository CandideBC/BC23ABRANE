table 50040 Container
{
    Caption = 'Container';
    DrillDownPageID = 50090;
    LookupPageID = 50090;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'N°';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    PurchSetup.Get();
                    NoSeriesMgt.TestManual(PurchSetup."No. container");
                    "No. Series" := '';
                end;
            end;
        }
        field(10; "No. Immat / Container"; Text[20])
        {
            Caption = 'N° Immat / Container';
            Description = 'KAN.FHA 10/02/2022';
        }
        field(18; "Mode de transport"; Code[10])
        {
            Caption = 'Mode de transport';
            TableRelation = "Transport Method";
        }
        field(19; "Description mode transport"; Text[100])
        {
            CalcFormula = lookup("Transport Method".Description where(Code = field("Mode de transport")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Date chargement fournisseur"; Date)
        {
            Caption = 'Date chargement fournisseur';

            trigger OnValidate()
            var
                LigneContainer: Record "Ligne container";
                EnteteAchat: Record "Purchase Header";
                NumCde: Code[20];
                DateReceptionPrevue: date;
            begin
                if "Statut container" > "Statut container"::"En cours" then
                    Error(MAJInterditeErr, Format("Statut container"));

                //KAN.FHA 10/02/2022 DEBUT
                if "Date chargement fournisseur" <> 0D then
                    "Semaine chargement fournisseur" := Date2DWY("Date chargement fournisseur", 2)
                else
                    "Semaine chargement fournisseur" := 0;
                //KAN.FHA 10/02/2022 FIN
                //KAN.FHA 11/05/2026 DEBUT
                if "Date chargement fournisseur" <> xRec."Date chargement fournisseur" then begin
                    LigneContainer.SetCurrentKey("No. container", "No. commande achat");
                    LigneContainer.SetRange("No. container", Rec."No.");
                    if LigneContainer.FindSet(false) then begin
                        NumCde := '';
                        repeat
                            if (LigneContainer."No. commande achat" <> '') and (LigneContainer."No. commande achat" <> NumCde) then
                                if EnteteAchat.get(EnteteAchat."Document Type"::Order, LigneContainer."No. commande achat") then begin
                                    EnteteAchat.Validate("Date chargement confirmee", Rec."Date chargement fournisseur");
                                    EnteteAchat.Modify();
                                    //KAN.FHA 19/05/2026 DEBUT
                                    DateReceptionPrevue := EnteteAchat."Expected Receipt Date";
                                    //KAN.FHA 19/05/2026 FIN
                                end;
                            NumCde := LigneContainer."No. commande achat";
                        until LigneContainer.Next() = 0;
                        //KAN.FHA 19/05/2026 DEBUT
                        Rec.Validate("Date reception prevue", DateReceptionPrevue);
                        //KAN.FHA 19/05/2026 FIN
                    end;
                end;
                //KAN.FHA 11/05/2026 FIN
            end;
        }
        field(21; "Semaine chargement fournisseur"; Integer)
        {
        }
        field(25; "No. fournisseur"; Code[20])
        {
            Caption = 'N° fournisseur';
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                CalcFields("Nom fournisseur");
            end;
        }
        field(26; "Nom fournisseur"; Text[100])
        {
            CalcFormula = lookup(Vendor.Name where("No." = field("No. fournisseur")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Date depart port"; Date)
        {
            Caption = 'Date départ port';
        }
        field(50; "Date reception prevue"; Date)
        {
            Caption = 'Date réception prévue';

            trigger OnValidate()
            begin
                if "Date reception prevue" <> 0D then begin
                    "Semaine reception prevue" := Date2DWY("Date reception prevue", 2);
                    //KAN.FHA 28/04/2026 DEBUT
                    "Date semaine reception prevue" := CalcDate('<-CW>', "Date reception prevue");
                    //KAN.FHA 28/04/2026 FIN
                end else begin
                    "Semaine reception prevue" := 0;
                    //KAN.FHA 28/04/2026 DEBUT
                    "Date semaine reception prevue" := 0D;
                    //KAN.FHA 28/04/2026 FIN

                end;
            end;
        }
        field(51; "Semaine reception prevue"; Integer)
        {
            Caption = 'Semaine réception prévue';
            BlankZero = true;
            Editable = false;
        }
        field(52; "Date semaine reception prevue"; Date)
        {
            Caption = 'Date semaine réception prévue';
            Editable = false;
            Description = 'Le lundi de la semaine de réception prévue';
        }
        field(90; "Code transporteur"; Code[20])
        {
            Caption = 'Code transporteur';
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                if Fns.Get("Code transporteur") then
                    "Nom transporteur" := Fns.Name
                else
                    "Nom transporteur" := '';
            end;
        }
        field(91; "Nom transporteur"; Text[100])
        {
            Editable = false;
        }
        field(100; "Frais transport ventiles"; Boolean)
        {
            Caption = 'Frais transport ventilés';
            Description = 'Passe à Oui quand on éclate les lignes de frais annexe sur une commande d''achat au transitaire';
        }
        field(160; "Lieu Incoterm"; Text[30])
        {
            Caption = 'Lieu Incoterm';
        }
        field(192; "Date comptabilisation"; Date)
        {
        }
        field(195; "No. packing list / BL"; Code[20])
        {
            Caption = 'N° packing list / BL';
        }

        field(197; "Nombre de colis"; Decimal)
        {
            Caption = 'Nombre de colis';
            Description = 'Champ saisi par l''utilisateur';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            MinValue = 0;
            trigger OnValidate()
            var
                UCContainer: Record "UC container";
                ContenuColisage: Record "Contenu colisage container";
                LigneContainer: Record "Ligne container";
                NbUC: Integer;
                NbLignes: Integer;
                NoCdeAchtUnique: Code[20];
                MiseAJourManuelleNecessaireMsg: Label 'Vous avez réduit le nombre de colis, le système ne va pas décider tout seul quelles lignes de colis il doit supprimer.';
            begin
                //Si l'utilisateur joue avec la valeur de ce champ, on l'autorise à augmenter la valeur, pas à la baisser 
                //(s'il avait saisi 4 colis, le système a rattaché 4 UC de type colis, s'il réduit à 2, je ne veux pas décider quels colis doivent être supprimés,
                //l'utilisateur a peut-être déjà renseigné des informations sur telle ou telle ligne de colis.)
                CalcFields("Nb UC Colis");
                ContenuColisage.SetRange("No. container", Rec."No.");
                if ContenuColisage.IsEmpty then
                    ExtraireContenuColisage();
                NbUC := "Nb UC Colis";

                if "Nombre de colis" > NbUC then begin
                    NbLignes := NbUC;

                    //KAN.FHA 11/09/2026 DEBUT
                    CalculerStatsContainer(); //Pour avoir la liste à jour des commandes d'achats présentes dans le container
                    CalcFields("Nb commandes");
                    if "Nb commandes" = 1 then begin
                        NoCdeAchtUnique := '';
                        LigneContainer.SetRange("No. container", Rec."No.");
                        LigneContainer.SetFilter("No. commande achat", '<>%1', '');
                        if LigneContainer.FindFirst() then
                            NoCdeAchtUnique := LigneContainer."No. commande achat";
                    end;
                    //KAN.FHA 11/09/2026 FIN
                    while NbLignes < Rec."Nombre de colis" do begin
                        UCContainer.Init();
                        UCContainer."No. container" := "No.";
                        UCContainer."No. UC" := '';
                        UCContainer.Insert(true);
                        UCContainer."Type UC" := UCContainer."Type UC"::Colis;
                        //KAN.FHA 11/09/2026 DEBUT
                        UCContainer."No. commande achat" := NoCdeAchtUnique;
                        //KAN.FHA 11/09/2026 FIN
                        UCContainer.Modify();
                        NbLignes := NbLignes + 1;
                    end;
                end else
                    if "Nombre de colis" < NbUC then
                        Message(MiseAJourManuelleNecessaireMsg);
                ;
            end;
        }
        field(198; "Nombre de palettes"; Decimal)
        {
            Caption = 'Nombre de palettes';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            MinValue = 0;
            trigger OnValidate()
            var
                UCContainer: Record "UC container";
                ContenuColisage: record "Contenu colisage container";
                LigneContainer: Record "Ligne container";
                NoCdeAchtUnique: Code[50];
                NbUC: Integer;
                NbLignes: Integer;
                MiseAJourManuelleNecessaireMsg: Label 'Vous avez réduit le nombre de palettes, le système ne va pas décider tout seul quelles lignes de palettes il doit supprimer.';
            begin
                //Si l'utilisateur joue avec la valeur de ce champ, on l'autorise à augmenter la valeur, pas à la baisser 
                //(s'il avait saisi 4 colis, le système a rattaché 4 UC de type colis, s'il réduit à 2, je ne veux pas décider quels colis doivent être supprimés,
                //l'utilisateur a peut-être déjà renseigné des informations sur telle ou telle ligne de colis.)
                CalcFields("Nb UC Palette", "Nb UC Colis");

                ContenuColisage.SetRange("No. container", Rec."No.");
                if ContenuColisage.IsEmpty then
                    ExtraireContenuColisage();

                NbUC := "Nb UC Palette";

                if "Nombre de palettes" > NbUC then begin
                    NbLignes := NbUC;

                    //KAN.FHA 11/09/2026 DEBUT
                    CalculerStatsContainer(); //Pour avoir la liste à jour des commandes d'achats présentes dans le container
                    CalcFields("Nb commandes");
                    if "Nb commandes" = 1 then begin
                        NoCdeAchtUnique := '';
                        LigneContainer.SetRange("No. container", Rec."No.");
                        LigneContainer.SetFilter("No. commande achat", '<>%1', '');
                        if LigneContainer.FindFirst() then
                            NoCdeAchtUnique := LigneContainer."No. commande achat";
                    end;
                    //KAN.FHA 11/09/2026 FIN

                    while NbLignes < Rec."Nombre de palettes" do begin
                        UCContainer.Init();
                        UCContainer."No. container" := "No.";
                        UCContainer."No. UC" := '';
                        UCContainer.Insert(true);
                        UCContainer."Type UC" := UCContainer."Type UC"::Palette;
                        UCContainer."No. commande achat" := NoCdeAchtUnique;
                        UCContainer.Modify();
                        NbLignes := NbLignes + 1;
                    end;
                end else
                    if "Nombre de palettes" < NbUC then
                        Message(MiseAJourManuelleNecessaireMsg);
                ;
            end;
        }
        field(200; "No. commande transitaire"; Code[20])
        {
            CalcFormula = lookup("Purchase Header"."No." where("Document Type" = const(Order),
                                                                "Commande transitaire container" = const(true),
                                                                "No. container" = field("No.")));
            Editable = false;
            TableRelation = "Purchase Header"."No." where("Document Type" = const(Order));
            FieldClass = FlowField;
        }
        field(201; "No. cde transitaire (facturee)"; Code[20])
        {
            CalcFormula = lookup("Purch. Inv. Header"."Order No." where("Commande transitaire container" = const(true),
                                                                         "No. container" = field("No.")));
            Caption = 'N° cde transitaire (facturée)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(210; "Nb UC Colis"; Integer)
        {
            BlankZero = true;
            CalcFormula = count("UC container" where("No. container" = field("No."), "Type UC" = const(Colis)));
            Caption = 'Nombre UC Colis';
            Editable = false;
            FieldClass = FlowField;
        }
        field(211; "Nb UC Palette"; Integer)
        {
            BlankZero = true;
            CalcFormula = count("UC container" where("No. container" = field("No."), "Type UC" = const(Palette)));
            Caption = 'Nombre UC Palette';
            Editable = false;
            FieldClass = FlowField;
        }

        field(230; "No. Series"; Code[20])
        {
            Caption = 'N° souche';
            TableRelation = "No. Series";
        }
        field(260; "Statut container"; Option)
        {
            Caption = 'Statut container';
            OptionMembers = "En cours","Réceptionné","Archivé";
        }
        field(261; "Code magasin destination"; Code[10])
        {
            Caption = 'Code magasin destination';
            TableRelation = Location;
        }
        field(262; "Emplacement reception"; Code[20])
        {
            Caption = 'Emplacement réception';
            TableRelation = Bin.Code where("Location Code" = field("Code magasin destination"));
        }
        field(500; "Volume charge"; Text[50])
        {
            Caption = 'Volume chargé';
        }
        field(510; Commentaire; Text[50])
        {
        }
        field(520; "Nb commandes"; Decimal)
        {
            CalcFormula = sum("Statistique container"."Nb commande" where("No. container" = field("No.")));
            DecimalPlaces = 0 : 0;
            Description = 'Attention, ce champ ne se calcule que lorsqu''on demande à afficher les statistiques d''un container';
            Editable = false;
            FieldClass = FlowField;
        }
        field(530; "Montant charge (DS)"; Decimal)
        {
            CalcFormula = sum("Statistique container"."Montant charge (DS)" where("No. container" = field("No.")));
            Caption = 'Montant chargé (DS)';
            Description = 'Attention, ce champ ne se calcule que lorsqu''on demande à afficher les statistiques d''un container';
            Editable = false;
            FieldClass = FlowField;
        }
        field(540; "Montant facture (papier)"; Decimal)
        {
            CalcFormula = sum("Ligne container"."Montant facture (papier)" where("No. container" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(550; "Quantite totale"; Decimal)
        {
            CalcFormula = sum("Ligne container".Quantite where("No. container" = field("No.")));
            Caption = 'Quantité totale';
            DecimalPlaces = 0 : 2;
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Statut container")
        {
        }
        key(Key3; "Statut container", "Date reception prevue")
        {
        }
        key(Key4; "Date semaine reception prevue", "Statut container")
        {

        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Nom transporteur", "Date chargement fournisseur")
        {
        }
    }

    trigger OnDelete()
    var
        LigneContainer: Record "Ligne container";
    begin
        TestField("Statut container", "Statut container"::"En cours");
        LigneContainer.Reset();
        LigneContainer.SetRange("No. container", "No.");
        if LigneContainer.FindSet() then
            if Confirm(Text001Lbl) then
                repeat
                    if PurchLine.Get(PurchLine."Document Type"::Order, LigneContainer."No. commande achat", LigneContainer."No. ligne commande achat") then begin
                        ;
                        PurchLine."Suivi container OK" := false;
                        PurchLine.Modify();
                    end;
                until LigneContainer.Next() = 0
            else
                Error(Text002Lbl);

        LigneContainer.DeleteAll();

        StatsContainer.SetRange("No. container", "No.");
        StatsContainer.DeleteAll();
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            PurchSetup.Get();
            PurchSetup.TestField("No. container");
            NoSeriesMgt.InitSeries(PurchSetup."No. container", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        CompanyInfo.Get();
        "Code magasin destination" := CompanyInfo."Location Code";
    end;

    var
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        PurchSetup: Record "Purchases & Payables Setup";
        CompanyInfo: Record "Company Information";
        StatsContainer: Record "Statistique container";
        Fns: Record Vendor;
        NoSeriesMgt: Codeunit NoSeriesManagement;



        Text001Lbl: Label 'There are purchase order lines that are linked to this container. If you delete the container, the system will empty the Container No. field on these lines. Do you confirm ?';
        Text002Lbl: Label 'Operation cancelled by the user, deletion aborted.';

        //Text003Lbl: Label 'Vous ne pouvez pas solder un container lié à une ligne de commande d''achat qui n''a pas été entièrement réceptionnée.';
        MAJInterditeErr: Label 'Vous ne pouvez plus modifier ce champ sur un container dont le statut est %1.', Comment = '%1 = Statut';

        ReceptionnerQst: Label 'Le système va enregistrer la réception des commandes d''achats présentes dans ce container. Confirmez-vous ?';
        ReceptionFaiteOuvrirBRQst: Label 'Les commandes liées au container %1 ont été réceptionnées. Voulez-vous imprimer les bons de réception correspondants ?', Comment = '%1 = N° container';


    procedure ExtraireContenuColisage()
    var
        LigneContainer: Record "Ligne container";
        ContenuColisage: Record "Contenu colisage container";
        PrecisionArrondi: Decimal;
    begin
        //LigneContainer.SetCurrentKey(TypeDocDuplique, NumDocDuplique, Phase);
        LigneContainer.SetRange("No. container", Rec."No.");
        LigneContainer.SetRange(Type, LigneContainer.Type::Article);
        if LigneContainer.FindSet(false) then
            repeat
                if LigneContainer.Quantite <> 0 then begin
                    ContenuColisage.Init();
                    ContenuColisage."No. container" := "No.";
                    ContenuColisage."No. ligne" := LigneContainer."No. ligne";
                    ContenuColisage.Type := ContenuColisage.Type::Item;
                    ContenuColisage."Item No." := LigneContainer."No.";
                    ContenuColisage."Quantite UC" := LigneContainer.Quantite;
                    ContenuColisage.Description := LigneContainer.Description;
                    //ContenuColisage."Order No." := Rec."No.";
                    //ContenuColisage."Order Line No." := LigneContainer."Line No.";
                    ContenuColisage."Poids net unitaire" := LigneContainer."Poids net unitaire";
                    PrecisionArrondi := 0;
                    if ContenuColisage."Poids net unitaire" < 1 then
                        PrecisionArrondi := 0.001
                    else
                        PrecisionArrondi := 0.01;
                    ContenuColisage."Poids net ligne" := ROUND(ContenuColisage."Quantite UC" * ContenuColisage."Poids net unitaire", PrecisionArrondi);
                    ContenuColisage.Insert();
                end;
            until LigneContainer.Next() = 0;

    end;

    procedure CalculerMontantChargeDS(): Decimal
    var
        EnteteAchat: Record "Purchase Header";
        LigneAchat: Record "Purchase Line";
        CurrExchRate: Record "Currency Exchange Rate";
        LigneContainer: Record "Ligne container";
        MontantLigne: Decimal;
        MontantChargeDS: Decimal;

        lValeur: Decimal;
    begin
        LigneContainer.SetRange("No. container", "No.");
        LigneContainer.SetCurrentKey("No. container", "No. commande achat");
        lValeur := 0;
        MontantChargeDS := 0;

        if LigneContainer.FindSet(false) then
            repeat
                if LigneAchat.Get(LigneAchat."Document Type"::Order, LigneContainer."No. commande achat", LigneContainer."No. ligne commande achat") then begin
                    EnteteAchat.Get(EnteteAchat."Document Type"::Order, LigneContainer."No. commande achat");
                    if LigneAchat.Quantity <> 0 then
                        MontantLigne := Round(LigneContainer.Quantite / LigneAchat.Quantity * LigneAchat.Amount, 0.01)
                    else
                        MontantLigne := 0;

                    if EnteteAchat."Currency Code" = '' then
                        lValeur := MontantLigne
                    else
                        lValeur := CurrExchRate.ExchangeAmtFCYToLCY(Today, EnteteAchat."Currency Code", MontantLigne, EnteteAchat."Currency Factor");

                    MontantChargeDS := MontantChargeDS + lValeur;

                end;
            until LigneContainer.Next() = 0;


        exit(MontantChargeDS);
    end;

    procedure AfficherStatsContainer()

    begin
        CalculerStatsContainer();
        PAGE.Run(PAGE::"Statistiques container", Rec);
    end;

    procedure CalculerStatsContainer()
    var
        EnteteAchat: Record "Purchase Header";
        LigneAchat: Record "Purchase Line";
        CurrExchRate: Record "Currency Exchange Rate";
        LigneContainer: Record "Ligne container";
        LigneStatContainer: Record "Statistique container";

        MontantLigne: Decimal;
        NumCde: Code[20];

        lNbCde: Integer;
        lValeur: Decimal;

    begin
        LigneContainer.SetCurrentKey("No. container", "No. commande achat");
        LigneContainer.SetRange("No. container", "No.");

        lValeur := 0;
        lNbCde := 0;

        NumCde := '';

        if LigneContainer.FindSet(false) then begin
            //KAN.FHA 10/02/2022 DEBUT
            LigneStatContainer.Reset();
            LigneStatContainer.SetRange("No. container", "No.");
            LigneStatContainer.DeleteAll();
            //KAN.FHA 10/02/2022 FIN
            repeat
                if LigneContainer."No. commande achat" <> NumCde then begin
                    lNbCde := lNbCde + 1;
                    LigneStatContainer.Init();
                    LigneStatContainer."No. container" := "No.";
                    LigneStatContainer."No. commande achat" := LigneContainer."No. commande achat";
                    LigneStatContainer."Nb commande" := 1;
                    LigneStatContainer.Insert();
                    //KAN.FHA 10/02/2022 FIN
                end;

                if LigneAchat.Get(LigneAchat."Document Type"::Order, LigneContainer."No. commande achat", LigneContainer."No. ligne commande achat") then begin
                    EnteteAchat.Get(EnteteAchat."Document Type"::Order, LigneContainer."No. commande achat");
                    if LigneAchat.Quantity <> 0 then
                        MontantLigne := Round(LigneContainer.Quantite / LigneAchat.Quantity * (LigneAchat."Line Amount" - LigneAchat."Inv. Discount Amount"), 0.01)
                    else
                        MontantLigne := 0;

                    LigneStatContainer."Montant charge" := LigneStatContainer."Montant charge" + MontantLigne;
                    LigneStatContainer."Code devise" := EnteteAchat."Currency Code";

                    if EnteteAchat."Currency Code" = '' then
                        lValeur := MontantLigne
                    else
                        lValeur := CurrExchRate.ExchangeAmtFCYToLCY(Today, EnteteAchat."Currency Code", MontantLigne, EnteteAchat."Currency Factor");

                    LigneStatContainer."Montant charge (DS)" := LigneStatContainer."Montant charge (DS)" + lValeur;
                    //KAN.FHA 23/11/2023 DEBUT
                    LigneStatContainer."Quantite totale" := LigneStatContainer."Quantite totale" + LigneAchat.Quantity;
                    //KAN.FHA 23/11/2023 FIN
                    LigneStatContainer.Modify();
                end;
                NumCde := LigneContainer."No. commande achat";
            until LigneContainer.Next() = 0;
        end;
    end;

    procedure ImprimerBonReception(pNumContainer: Code[20])
    var
        EnteteReception: Record "Purch. Rcpt. Header";
        ReportSelection: Record "Report Selections";
    begin
        EnteteReception.Reset();
        EnteteReception.SetCurrentKey("No. container");
        EnteteReception.SetRange("No. container", "No.");
        if EnteteReception.FindSet(false) then begin
            ReportSelection.Reset();
            ReportSelection.SetRange(Usage, ReportSelection.Usage::"P.Receipt");
            ReportSelection.FindSet();
            repeat
                ReportSelection.TestField("Report ID");
                REPORT.Run(ReportSelection."Report ID", false, false, EnteteReception);
            until ReportSelection.Next() = 0;
        end;
    end;

    procedure Receptionner()
    var
        LigneContainer: Record "Ligne container";
        UCContainer: Record "UC container";
        EnteteAchat: Record "Purchase Header";
        NumCdeAchat: Code[20];
        NoDocVente: Text;
        DateChargementTxt: Text;
        DateLivDemandeeTxt: Text;
        RienAValiderMsg: Label 'Il n''y a rien à réceptionner (veuillez saisir la quantité à recevoir pour chaque ligne).';
        QuantiteTropGrandeErr: Label 'Sur la ligne %1 de ce container, la quantité à recevoir est supérieure à la quantité restante (commande %2, ligne %3).', Comment = '%1 = N° ligne container %2 = N° commande %3 = N° ligne commande';
        NumFactFns: Code[35];
    begin
        if not Confirm(ReceptionnerQst, false) then
            exit;

        TestField("Statut container", "Statut container"::"En cours");
        TestField("Date comptabilisation");
        TestField("No. packing list / BL");

        LigneContainer.Reset();
        LigneContainer.SetCurrentKey("No. container", "No. commande achat");
        LigneContainer.SetRange("No. container", "No.");
        LigneContainer.SetFilter("Qte a recevoir", '<>0');

        if LigneContainer.FindSet(false) then begin
            //1. Avant de valider la réception d'une commande achat, il faut vider la 'Quantite à recevoir" sur chaque ligne de la cde et inscrire Date compta et N° packing list dans l'entete de chaque commande
            NumCdeAchat := '';
            NumFactFns := '';
            repeat
                if LigneContainer."No. commande achat" <> NumCdeAchat then begin
                    NumFactFns := LigneContainer."No. facture fournisseur";
                    PurchHeader.Get(PurchHeader."Document Type"::Order, LigneContainer."No. commande achat");
                    PurchHeader.Validate("Posting Date", "Date comptabilisation");
                    PurchHeader."Vendor Shipment No." := "No. packing list / BL";
                    PurchHeader."Vendor Invoice No." := NumFactFns;
                    PurchHeader.Modify();
                    PurchLine.Reset();
                    PurchLine.SetRange("Document Type", PurchLine."Document Type"::Order);
                    PurchLine.SetRange("Document No.", LigneContainer."No. commande achat");
                    PurchLine.SetFilter(Type, '%1|%2', PurchLine.Type::Item, PurchLine.Type::"Charge (Item)");
                    if PurchLine.FindSet(true) then
                        repeat
                            if PurchLine."Qty. to Receive" <> 0 then begin
                                PurchLine.Validate("Qty. to Receive", 0);
                                PurchLine.Modify();
                            end;
                        until PurchLine.Next() = 0;
                end;
                NumCdeAchat := LigneContainer."No. commande achat";
            until LigneContainer.Next() = 0;

            //2, On remplit sur les lignes de commandes d'achat les quantités à recevoir
            LigneContainer.FindSet(false);
            repeat
                if (LigneContainer."Qte a recevoir" <> 0) then begin
                    PurchLine.Get(PurchLine."Document Type"::Order, LigneContainer."No. commande achat", LigneContainer."No. ligne commande achat");
                    //KAN.FHA 24/03/2022 DEBUT
                    //Si on cherche à réceptionner plus que la quantité restante, le message d'erreur de Microsoft ne précise pas sur quelle ligne de quelle commande d'achat
                    //et c'est donc difficile de savoir sur quelle ligne du container on a un souci.
                    //Je rajoute donc mon propre controle et mon propre message.
                    if LigneContainer."Qte a recevoir" > PurchLine."Outstanding Quantity" then
                        Error(QuantiteTropGrandeErr, LigneContainer."No. ligne", LigneContainer."No. commande achat", LigneContainer."No. ligne commande achat");
                    //KAN.FHA 24/03/2022 FIN
                    PurchLine.Validate("Qty. to Receive", LigneContainer."Qte a recevoir");
                    PurchLine.Modify();
                end;
            until LigneContainer.Next() = 0;

            //3. On valide la réception de chaque commande
            LigneContainer.FindSet(true);
            NumCdeAchat := '';
            repeat
                if LigneContainer."No. commande achat" <> NumCdeAchat then begin
                    PurchHeader.Get(PurchHeader."Document Type"::Order, LigneContainer."No. commande achat");
                    PurchHeader.Receive := true;
                    PurchHeader.Invoice := false;
                    PurchHeader."No. container" := "No.";
                    PurchHeader.Modify();
                    CODEUNIT.Run(CODEUNIT::"Purch.-Post", PurchHeader);
                end;

                NumCdeAchat := LigneContainer."No. commande achat";
            until LigneContainer.Next() = 0;
            LigneContainer.FindSet(true);

            //On met à jour les quantités reçues sur les lignes du container
            repeat
                LigneContainer."Quantite recue" := LigneContainer."Quantite recue" + LigneContainer."Qte a recevoir";
                LigneContainer."Quantite restante" := LigneContainer.Quantite - LigneContainer."Quantite recue";
                LigneContainer."Qte a recevoir" := 0;
                LigneContainer.Modify();
            until LigneContainer.Next() = 0;
            "Statut container" := "Statut container"::"Réceptionné";
            Modify();

            //KAN.FHA 11/09/2026 DEBUT
            //Recopier les UC (Palettte/colis) du container vers la commande 
            UCContainer.Reset();
            UCContainer.SetCurrentKey("No. container", "No. commande achat");
            UCContainer.Setrange("No. container", Rec."No.");
            UCContainer.SetFilter("No. commande achat", '<>%1', '');
            if UCContainer.FindSet(false) then begin
                NumCdeAchat := '';
                repeat
                    if UCContainer."No. commande achat" <> NumCdeAchat then
                        if EnteteAchat.Get(EnteteAchat."Document Type"::Order, UCContainer."No. commande achat") then begin
                            EnteteAchat.ObtenirInfosDocumentVenteLie(NoDocVente, DateChargementTxt, DateLivDemandeeTxt);
                            if Copystr(NoDocVente,1,2) = 'CC' then begin //Pas génial mais permet d'exclure les devis et la valeur "Multiple"
                                //On sait ici que la commande d'achat n'est affectée qu'à une seule commande de vente, on peut transférer l'UC vers cette commande vente
                            end;
                        end;
                    NumCdeAchat := UCContainer."No. commande achat";
                until UCContainer.Next() = 0;
            end;
            //KAN.FHA 11/09/2026 FIN

            if Confirm(ReceptionFaiteOuvrirBRQst, true, "No.") then
                ImprimerBonReception("No.");
        end else
            Message(RienAValiderMsg);
    end;

    procedure ListerChantiersPourEtiquettesPalettes()
    var
        LigneContainer: Record "Ligne container";
        EtiquettePalette: Record "Etiquettes palettes";
        Chantier: Record Chantier;
    begin
        LigneContainer.Reset();
        LigneContainer.SetRange("No. container", "No.");
        if LigneContainer.FindSet(false) then begin
            EtiquettePalette.Reset();
            EtiquettePalette.SetRange("Code utilisateur", UserId);
            EtiquettePalette.DeleteAll();
            repeat
                if PurchLine.Get(PurchLine."Document Type"::Order, LigneContainer."No. commande achat", LigneContainer."No. ligne commande achat") then
                    if PurchLine."Code chantier" <> '' then
                        if not EtiquettePalette.Get(UserId, "No.", PurchLine."Code enseigne", PurchLine."Code chantier", PurchLine."Document No.") then begin
                            Chantier.Get(PurchLine."Code chantier");
                            EtiquettePalette.Init();
                            EtiquettePalette."Code utilisateur" := COPYSTR(UserId, 1, 50);
                            EtiquettePalette."No. container" := "No.";
                            EtiquettePalette."Code enseigne" := PurchLine."Code enseigne";
                            EtiquettePalette."Code chantier" := PurchLine."Code chantier";
                            EtiquettePalette."No. commande achat" := PurchLine."Document No.";
                            EtiquettePalette."No. packing list" := "No. packing list / BL";
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
            until LigneContainer.Next() = 0;
        end;
        EtiquettePalette.FilterGroup(2);
        EtiquettePalette.SetRange("Code utilisateur", UserId);
        EtiquettePalette.FilterGroup(0);
        PAGE.Run(PAGE::"Etiquettes palettes", EtiquettePalette);
    end;

    procedure CreerCommandeTransitaire()
    var
        CreerCommandeTransitaireQst: Label 'Voulez-vous créer une commande d''achat au transitaire %1 ?', Comment = '%1 = N° du transitaire';
        OuvrirCommandeTransitaireQst: Label 'La commande d''achat %1 a été créée, voulez-vous l''afficher ?', Comment = '%1 = N° de la commande d''achat';
    begin
        TestField("Code transporteur");

        if not Confirm(CreerCommandeTransitaireQst, true, "Nom transporteur") then
            exit;

        PurchHeader.Init();
        PurchHeader."Document Type" := PurchHeader."Document Type"::Order;
        PurchHeader."No." := '';
        PurchHeader.Insert(true);
        PurchHeader.Validate("Buy-from Vendor No.", "Code transporteur");
        //KAN.FHA 20/06/2023 DEBUT
        PurchHeader."Commande transitaire container" := true;
        PurchHeader."No. container" := "No.";
        //KAN.FHA 20/06/2023 fin
        PurchHeader.Modify();

        if Confirm(OuvrirCommandeTransitaireQst, true, PurchHeader."No.") then
            PAGE.Run(PAGE::"Purchase Order", PurchHeader);
    end;

    procedure AfficherCommandeTransitaire()
    var
        EnteteAchat: Record "Purchase Header";
    begin
        if EnteteAchat.Get(EnteteAchat."Document Type"::Order, Rec."No. commande transitaire") then
            Page.Run(Page::"Purchase Order", EnteteAchat);
    end;

    procedure AfficherFactureTransitaire()
    var
        EnteteFactAchat: Record "Purchase Header";
    begin
        EnteteFactAchat.SetCurrentKey("Commande transitaire container", "No. container");
        EnteteFactAchat.SetRange("Commande transitaire container", true);
        EnteteFactAchat.SetRange("No. container", Rec."No.");
        if EnteteFactAchat.FindFirst() then
            Page.Run(Page::"Posted Purchase Invoice", EnteteFactAchat);
    end;

    procedure RemplirOuViderQteARecevoir(pOption: Option Remplir,Vider)
    var
        LigneContainer: Record "Ligne container";
        QteARecevoir: Decimal;
    begin
        LigneContainer.Reset();
        LigneContainer.SetRange("No. container", "No.");
        if LigneContainer.FindSet(true) then
            repeat
                if pOption = pOption::Vider then
                    QteARecevoir := 0
                else
                    QteARecevoir := LigneContainer.Quantite - LigneContainer."Quantite recue";
                LigneContainer.Validate("Qte a recevoir", QteARecevoir);
                LigneContainer.Modify();
            until LigneContainer.Next() = 0
    end;

    procedure CreerRetourFournisseur(var pNoRetour: Code[20]): Boolean
    var
        LigneContainer: Record "Ligne container";
        LigneContainer2: Record "Ligne container";
        EnteteRetour: Record "Purchase Header";
        LigneRetour: Record "Purchase Line";
        EnteteCommande: Record "Purchase Header";
        LigneCommande: Record "Purchase Line";
        NbRetours: Integer;
        NoCdeAchat: Code[20];
        lLineNo: Integer;
        TexteRetour: Text[100];
        TexteLigneRetourLbl: Label 'Container %1 - Commande %2', Comment = '%1 = N° container %2 = N° Commande';
        TexteContainerLbl: Label 'Container %1', Comment = '%1 = N° container';
        TexteCommandeLbl: Label 'Commande %1', Comment = '%1 = N° commande';

    begin
        //On doit créer autant de retours que de commandes d'achats différentes présentant une [Qté à retourner] sur la ligne de container liée
        LigneContainer.SetCurrentKey("No. container", "No. commande achat");
        LigneContainer.SetRange("No. container", "No.");
        LigneContainer.SetFilter("Qte a retourner", '<>%1', 0);

        if LigneContainer.FindSet(true) then begin
            NoCdeAchat := '';
            NbRetours := 0;

            repeat
                //Création de l'entête
                if (NoCdeAchat <> LigneContainer."No. commande achat") then begin
                    EnteteCommande.Get(EnteteCommande."Document Type"::Order, LigneContainer."No. commande achat");
                    LigneCommande.Get(LigneCommande."Document Type"::Order, LigneContainer."No. commande achat", LigneContainer."No. ligne commande achat");
                    EnteteRetour.Init();
                    EnteteRetour."No." := '';
                    EnteteRetour.Validate("Document Type", EnteteRetour."Document Type"::"Return Order");
                    EnteteRetour.Insert(true);
                    NbRetours := NbRetours + 1;
                    EnteteRetour.Validate("Buy-from Vendor No.", EnteteCommande."Buy-from Vendor No.");
                    EnteteRetour.Validate("Purchaser Code", EnteteCommande."Purchaser Code");
                    EnteteRetour.Validate("Shortcut Dimension 1 Code", EnteteCommande."Shortcut Dimension 1 Code");
                    EnteteRetour.Validate("Shortcut Dimension 2 Code", EnteteCommande."Shortcut Dimension 2 Code");
                    EnteteRetour.Validate("Dimension Set ID", EnteteCommande."Dimension Set ID");
                    EnteteRetour.Validate(Commentaires, EnteteCommande.Commentaires);
                    EnteteRetour.Validate("Location Code", EnteteCommande."Location Code");
                    EnteteRetour."Code groupe" := EnteteCommande."Code groupe";
                    EnteteRetour."Code enseigne" := EnteteCommande."Code enseigne";
                    EnteteRetour."Code operation" := EnteteCommande."Code operation";
                    EnteteRetour."Code chantier" := EnteteCommande."Code chantier";
                    EnteteRetour."No. container" := "No.";
                    EnteteRetour.Modify(true);
                    lLineNo := 10000;

                    //Ajout d'une ligne indiquant les références de la commande et du container
                    TexteRetour := StrSubstNo(TexteLigneRetourLbl, "No. Immat / Container", EnteteCommande."No.");
                    if StrLen(TexteRetour) > 50 then begin
                        TexteRetour := StrSubstNo(TexteContainerLbl, "No. Immat / Container");
                        LigneRetour.Init();
                        LigneRetour.Validate("Document Type", EnteteRetour."Document Type");
                        LigneRetour.Validate("Document No.", EnteteRetour."No.");
                        LigneRetour."Line No." := lLineNo;
                        LigneRetour.Description := TexteRetour;
                        LigneRetour."No. container" := "No.";
                        LigneRetour."No. ligne container" := LigneContainer."No. ligne";
                        LigneRetour.Insert(true);
                        lLineNo += 10000;

                        TexteRetour := StrSubstNo(TexteCommandeLbl, EnteteCommande."No.");
                        LigneRetour.Init();
                        LigneRetour.Validate("Document Type", EnteteRetour."Document Type");
                        LigneRetour.Validate("Document No.", EnteteRetour."No.");
                        LigneRetour."Line No." := lLineNo;
                        LigneRetour.Description := TexteRetour;
                        LigneRetour."No. container" := "No.";
                        LigneRetour."No. ligne container" := LigneContainer."No. ligne";
                        LigneRetour.Insert(true);
                        lLineNo += 10000;

                    end else begin
                        LigneRetour.Init();
                        LigneRetour.Validate("Document Type", EnteteRetour."Document Type");
                        LigneRetour.Validate("Document No.", EnteteRetour."No.");
                        LigneRetour."Line No." := lLineNo;
                        LigneRetour.Description := TexteRetour;
                        LigneRetour."No. container" := "No.";
                        LigneRetour."No. ligne container" := LigneContainer."No. ligne";
                        LigneRetour.Insert(true);
                        lLineNo += 10000;
                    end;
                end;
                //IF LigneContainer.Type = LigneContainer.Type::Art THEN
                //  IF NOT Article.GET(LigneContainer."No.") THEN
                //    Article.INIT;
                LigneContainer.CalcFields("Qte sur retour");
                //Création des lignes
                LigneRetour.Init();
                LigneRetour.Validate("Document Type", EnteteRetour."Document Type");
                LigneRetour.Validate("Document No.", EnteteRetour."No.");
                LigneRetour."Line No." := lLineNo;
                case LigneContainer.Type of
                    LigneContainer.Type::Article:
                        LigneRetour.Validate(Type, LigneRetour.Type::Item);
                    LigneContainer.Type::"Frais annexes":
                        LigneRetour.Validate(Type, LigneRetour.Type::"Charge (Item)");
                    LigneContainer.Type::"Compte général":
                        LigneRetour.Validate(Type, LigneRetour.Type::"G/L Account");
                end;
                LigneRetour.Validate("No.", LigneContainer."No.");
                LigneRetour.Validate("Variant Code", LigneCommande."Variant Code");
                LigneRetour.Validate("Location Code", LigneCommande."Location Code");
                LigneRetour.Validate("Unit of Measure", LigneCommande."Unit of Measure");
                LigneRetour.Validate(Quantity, LigneContainer."Qte a retourner" - LigneContainer."Qte sur retour");
                LigneRetour.Validate(Description, LigneCommande.Description);
                LigneRetour.Validate("Description 2", LigneCommande."Description 2");
                LigneRetour.Validate(LigneRetour."Direct Unit Cost", LigneCommande."Direct Unit Cost");
                LigneRetour."Nomenclature produits" := LigneCommande."Nomenclature produits";
                LigneRetour."Country/Region of Origin Code" := LigneCommande."Country/Region of Origin Code";
                LigneRetour."No. container" := "No.";
                LigneRetour."No. ligne container" := LigneContainer."No. ligne";
                LigneRetour.Insert(true);

                lLineNo += 10000;
                NoCdeAchat := LigneContainer."No. commande achat";

                LigneContainer2.Get(LigneContainer."No. container", LigneContainer."No. ligne");
                LigneContainer2."Qte a retourner" := 0;
                LigneContainer2.Modify();
            until LigneContainer.Next() = 0;
            if NbRetours = 1 then
                pNoRetour := EnteteRetour."No."
            else
                pNoRetour := '';
            exit(true);
        end else
            exit(false);
    end;

    procedure RecupMontantEncoursCdeTransitaire(): Decimal
    var
        EnteteAchat: Record "Purchase Header";
        MontantTotal: Decimal;
    begin
        MontantTotal := 0;
        EnteteAchat.SetCurrentKey("Document Type", "Commande transitaire container", "No. container");
        EnteteAchat.SetRange("Document Type", EnteteAchat."Document Type"::Order);
        EnteteAchat.SetRange("Commande transitaire container", true);
        EnteteAchat.SetRange("No. container", "No.");
        if EnteteAchat.FindSet(false) then
            repeat
                EnteteAchat.CalcFields("Montant restant HT (DS)", "Montant recu non facture HT DS");
                MontantTotal := MontantTotal + EnteteAchat."Montant restant HT (DS)" + EnteteAchat."Montant recu non facture HT DS";
            until EnteteAchat.Next() = 0;

        exit(MontantTotal);
    end;

    procedure RecupMontantFactureTransitaire(): Decimal
    var
        EnteteFactAchat: Record "Purch. Inv. Header";
        EnteteAvoirAchat: Record "Purch. Cr. Memo Hdr.";
        MontantTotal: Decimal;
    begin
        MontantTotal := 0;
        EnteteFactAchat.SetCurrentKey("Commande transitaire container", "No. container");
        EnteteFactAchat.SetRange("Commande transitaire container", true);
        EnteteFactAchat.SetRange("No. container", "No.");
        if EnteteFactAchat.FindSet(false) then
            repeat
                EnteteFactAchat.CalcFields(Amount);
                MontantTotal := MontantTotal + EnteteFactAchat.Amount;
            until EnteteFactAchat.Next() = 0;

        EnteteAvoirAchat.SetCurrentKey("Commande transitaire container", "No. container");
        EnteteAvoirAchat.SetRange("Commande transitaire container", true);
        EnteteAvoirAchat.SetRange("No. container", "No.");
        if EnteteAvoirAchat.FindSet(false) then
            repeat
                EnteteAvoirAchat.CalcFields(Amount);
                MontantTotal := MontantTotal - EnteteAvoirAchat.Amount;
            until EnteteAvoirAchat.Next() = 0;

        exit(MontantTotal);
    end;

}















