table 50014 "Entete colisage"
{
    Caption = 'Entête colisage';
    DrillDownPageID = 50029;
    LookupPageID = 50029;
    Permissions = TableData "Sales Line" = rm,
                  TableData "Sales Shipment Line" = rm;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'N°';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get();
                    NoSeriesMgt.TestManual(GetNoSeriesCode());
                end;
            end;
        }
        field(3; "Sell-to Customer No."; Code[20])
        {
            Caption = 'N° donneur d''ordre';
            TableRelation = Customer;

            trigger OnValidate()
            var
                Text001Err: Label 'Pas possible de modifier le client quand il y a des lignes';
            begin
                CheckPackingStatus();
                CalcFields("Nb UC");
                if "Nb UC" <> 0 then
                    Error(Text001Err);

                if Customer.Get("Sell-to Customer No.") then begin
                    "Ship-To Name" := Customer.Name;
                    "Ship-To Name 2" := Customer."Name 2";
                    "Ship-To Address" := Customer.Address;
                    "Ship-To Address 2" := Customer."Address 2";
                    "Ship-To City" := Customer.City;
                    "Ship-To Post Code" := Customer."Post Code";
                    "Ship-To County Code" := Customer.County;
                    Validate("Ship-To Country Code", Customer."Country/Region Code");
                    "Ship-To Address Code" := '';
                    //if Customer."Bill-to Customer No." <> '' then
                    //    Validate("Bill-To Customer No.", Customer."Bill-to Customer No.")
                    //else
                    //    Validate("Bill-To Customer No.", Customer."No.");
                end;
            end;
        }
        field(4; "Ship-To Address Code"; Code[10])
        {
            Caption = 'Code destinataire';
            TableRelation = "Ship-to Address".Code where("Customer No." = field("Sell-to Customer No."));

            trigger OnValidate()
            var
                recEnteteVente: Record "Sales Header";
            begin
                if "Ship-To Address Code" <> '' then begin
                    ShipToAddr.Get("Sell-to Customer No.", "Ship-To Address Code");
                    "Ship-To Name" := ShipToAddr.Name;
                    "Ship-To Name 2" := ShipToAddr."Name 2";
                    "Ship-To Address" := ShipToAddr.Address;
                    "Ship-To Address 2" := ShipToAddr."Address 2";
                    "Ship-To City" := ShipToAddr.City;
                    "Ship-To Post Code" := ShipToAddr."Post Code";
                    "Ship-To County Code" := ShipToAddr.County;
                    Validate("Ship-To Country Code", ShipToAddr."Country/Region Code");
                end else
                    if recEnteteVente.Get(recEnteteVente."Document Type"::Order, Rec."No. commande") then begin
                        "Ship-To Name" := recEnteteVente."Ship-to Name";
                        "Ship-To Name 2" := recEnteteVente."Ship-to Name 2";
                        "Ship-To Address" := recEnteteVente."Ship-to Address";
                        "Ship-To Address 2" := recEnteteVente."Ship-to Address 2";
                        "Ship-To City" := "Ship-To City";
                        "Ship-To Post Code" := "Ship-To Post Code";
                        "Ship-To County Code" := "Ship-To County Code";
                        Validate("Ship-To Country Code", "Ship-To Country Code");
                    end else
                        if Customer.get("Sell-to Customer No.") then begin
                            "Ship-To Name" := Customer.Name;
                            "Ship-To Name 2" := Customer."Name 2";
                            "Ship-To Address" := Customer.Address;
                            "Ship-To Address 2" := Customer."Address 2";
                            "Ship-To City" := Customer.City;
                            "Ship-To Post Code" := Customer."Post Code";
                            "Ship-To County Code" := Customer.County;
                            Validate("Ship-To Country Code", Customer."Country/Region Code");
                        end else begin
                            "Ship-To Name" := '';
                            "Ship-To Name 2" := '';
                            "Ship-To Address" := '';
                            "Ship-To Address 2" := '';
                            "Ship-To City" := '';
                            "Ship-To Post Code" := '';
                            "Ship-To County Code" := '';
                            Validate("Ship-To Country Code", '');
                        end;
            end;
        }
        field(5; "Ship-To Name"; Text[100])
        {
            Caption = 'Nom destinataire';
        }
        field(6; "Ship-To Name 2"; Text[50])
        {
            Caption = 'Nom 2 destinataire';
        }
        field(7; "Ship-To Address"; Text[100])
        {
            Caption = 'Adresse destinataire';
        }
        field(8; "Ship-To Address 2"; Text[50])
        {
            Caption = 'Adresse 2 destinataire';
        }
        field(9; "Ship-To City"; Text[30])
        {
            Caption = 'Ville destinataire';
        }
        field(10; "Ship-To Post Code"; Code[20])
        {
            Caption = 'Code postal destinataire';
            TableRelation = "Post Code";
        }
        field(11; "Ship-To County Code"; Text[30])
        {
            Caption = 'Région destinataire';
        }
        field(12; "Ship-To Country Code"; Code[10])
        {
            Caption = 'Code pays destinataire';
            TableRelation = "Country/Region";
        }
        field(15; "Your Reference"; Text[35])
        {
            Caption = 'Votre référence';
        }
        field(16; "Packing Status"; Option)
        {
            Caption = 'Statut colisage';
            OptionCaption = ' ,En cours,Terminé';
            OptionMembers = " ","En cours","Terminé";
        }
        field(17; Destination; Text[80])
        {
            Caption = 'Destination';
        }

        field(100; "External Document No."; Code[35])
        {
            Caption = 'N° doc. externe';
        }
        field(140; "No. Series"; Code[20])
        {
            Caption = 'Souche de N°';
            TableRelation = "No. Series";
        }
        field(141; "Creation Date"; Date)
        {
            Caption = 'Date création';
            Editable = false;
        }
        field(210; "Nb UC"; Integer)
        {
            BlankZero = true;
            CalcFormula = count("Detail colisage" where("No. colisage" = field("No.")));
            Caption = 'Nombre UC';
            Editable = false;
            FieldClass = FlowField;
        }
        field(215; "Poids brut non colise"; Decimal)
        {
            Caption = 'Poids brut non colisé';
            DecimalPlaces = 0 : 5;
        }
        field(220; "Poids brut total colise"; Decimal)
        {
            CalcFormula = sum("Detail colisage"."Poids brut UC" where("No. colisage" = field("No.")));
            Caption = 'Total poids brut colisé';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }

        field(230; "Poids net total colise"; Decimal)
        {
            CalcFormula = sum("Contenu colisage"."Poids net ligne" where("No. colisage" = field("No.")));
            Caption = 'Poids net total colisé';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }

        field(232; "Poids net total articles"; Decimal)
        {
            CalcFormula = sum("Contenu colisage"."Poids net ligne" where("No. colisage" = field("No.")));
            Caption = 'Poids net total articles';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(233; "Poids brut total articles"; Decimal)
        {
            CalcFormula = sum("Contenu colisage"."Poids brut ligne" where("No. colisage" = field("No.")));
            Caption = 'Poids brut total articles';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(300; "Nombre de colis"; Integer)
        {
            Caption = 'Nombre de colis';
            FieldClass = FlowField;
            CalcFormula = count("Detail colisage" where("No. colisage" = field("No."), "Type UC" = const(Colis)));
            Editable = false;

        }
        field(310; "Nombre de palettes"; Integer)
        {
            Caption = 'Nombre de palettes';
            FieldClass = FlowField;
            CalcFormula = count("Detail colisage" where("No. colisage" = field("No."), "Type UC" = const(Palette)));
            Editable = false;
        }
        field(49900; "No. expedition enregistree"; Code[20])
        {
            Caption = 'N° expédition enregistrée';
            DataClassification = ToBeClassified;
            TableRelation = "Sales Shipment Header" where("Sell-to Customer No." = field("Sell-to Customer No."));
            trigger OnValidate()
            var
                EnteteExpedVente: Record "Sales Shipment Header";
            begin
                if "No. expedition enregistree" <> '' then begin
                    EnteteExpedVente.Get("No. expedition enregistree");
                    Rec.Validate("No. commande", EnteteExpedVente."Order No.");
                end;
            end;
        }
        field(50000; "No. commande"; Code[20])
        {
            Caption = 'N° commande';
            TableRelation = "Sales Header"."No." where("Document Type" = const(Order), "Sell-to Customer No." = field("Sell-to Customer No."));

            trigger OnValidate()
            var
                recEnteteVente: Record "Sales Header";
            begin
                if "No. commande" <> '' then begin
                    recEnteteVente.Get(recEnteteVente."Document Type"::Order, "No. commande");
                    "Range No." := recEnteteVente."Range No.";
                    "Your Reference" := recEnteteVente."Your Reference";
                    "External Document No." := recEnteteVente."External Document No.";
                    "Ship-To Address Code" := recEnteteVente."Ship-to Code";
                    "Ship-To Name" := recEnteteVente."Ship-to Name";
                    "Ship-To Name 2" := recEnteteVente."Ship-to Name 2";
                    "Ship-To Address" := recEnteteVente."Ship-to Address";
                    "Ship-To Address 2" := recEnteteVente."Ship-to Address 2";
                    "Ship-To Post Code" := recEnteteVente."Ship-to Post Code";
                    "Ship-To City" := recEnteteVente."Ship-to City";
                    "Ship-To Country Code" := recEnteteVente."Ship-to Country/Region Code";
                end;
            end;
        }
        field(50010; Phase; Integer)
        {
            Caption = 'Phase';
            DataClassification = ToBeClassified;
            TableRelation = "Phases document".Phase where("Type document" = const(Order), "No. document" = field("No. commande"));
        }
        field(50011; "Description phase"; Text[50])
        {
            Caption = 'Description phase';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(50050; "Range No."; Text[30])
        {
            Caption = 'N° de rayon';
        }
        field(50060; "Phone No."; Text[30])
        {
            Caption = 'N° téléphone';
            ExtendedDatatype = PhoneNo;
        }

        field(50070; Email; Text[80])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;
        }

        field(50080; "Code transporteur"; Code[10])
        {
            Caption = 'Code transporteur';
            TableRelation = "Shipping Agent";
        }

        field(50090; "No. suivi colis"; Text[30])
        {
            Caption = 'N° suivi colis';
        }

        field(50100; "Code magasin"; Code[10])
        {
            Caption = 'Code magasin';
            TableRelation = Location;
        }
        field(50110; "Date comptabilisation"; Date)
        {
            Caption = 'Date comptabilisation';
            //Editable = false;
        }
        field(50120; Expedie; Boolean)
        {
            Caption = 'Expédié';
            Editable = false;
        }
        field(50130; "Commentaire validation"; Text[50])
        {
            Caption = 'Commentaire validation';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Packing Status", "Creation Date")
        {
        }
        key(MyKey3; "No. expedition enregistree")
        {
        }

        key(Key4; "Packing Status", "Sell-to Customer No.")
        {
        }
        key(MyKey5; Expedie,"No. commande", "No. expedition enregistree")
        {

        }
        key(MyKey6; Expedie)
        {
            
        }
        key(MyKey7; "Sell-to Customer No.",Expedie,"No. commande")
        {
            
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        ContenuColisage: Record "Contenu colisage";
    begin
        ContenuColisage.SetRange("No. colisage", "No.");
        ContenuColisage.DeleteAll();

        DetailColisage.SetRange("No. colisage", "No.");
        DetailColisage.DeleteAll();
    end;

    trigger OnInsert()
    begin
        SalesSetup.Get();

        if "No." = '' then begin
            SalesSetup.TestField("No. colisage");
            NoSeriesMgt.InitSeries(SalesSetup."No. colisage", "No. Series", WorkDate(), "No.", SalesSetup."No. colisage");
        end;
        "Creation Date" := WorkDate();
    end;

    trigger OnRename()
    begin
        Error(Text001Lbl, TableCaption);
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        //ContenuColisage: Record "Contenu colisage";
        ContenuColisage2: Record "Contenu colisage";
        ShipToAddr: Record "Ship-to Address";
        Customer: Record Customer;
        ShptLine: Record "Sales Shipment Line";
        DetailColisage: Record "Detail colisage";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text001Lbl: Label 'Vous ne pouvez pas renommer l''enregistrement %1.', Comment = '%1 = Enregistrement';
        Text002Lbl: Label 'BL %1 Ligne %2 quantité %3 alors que la somme des qtés colisage est de %4', Comment = '%1 = N° BL ; %2 = N° ligne ; %3 = Quantité ; %4 = Somme des quantités';
        Text004Lbl: Label 'Manque le poids brut sur UC %1', Comment = '%1 = N° UC';
        Text005Lbl: Label 'Manque le poids net sur UC %1', Comment = '%1 = N° UC';
        Text009Lbl: Label 'Des lignes du colisage n''ont pas été livrées';

    local procedure GetNoSeriesCode(): Code[20]
    begin
        exit(SalesSetup."No. colisage");
    end;

    procedure Reopen()
    begin
        TestField("Packing Status", "Packing Status"::"Terminé");
        //Effacer le n° colisage dans les lignes BL

        ShptLine.SetRange("No. colisage", "No.");
        if ShptLine.FindSet() then
            repeat
                ShptLine."No. colisage" := '';
                ShptLine."Packing in Progress" := true;
                ShptLine.Modify();
            until ShptLine.Next() = 0;

        "Packing Status" := 0;
        "Date comptabilisation" := 0D;
        Modify();
    end;

    procedure CheckPacking()
    var
        ContenuColisage: Record "Contenu colisage";
    begin
        TestField("Packing Status", "Packing Status"::" ");

        //Contrôle des lignes
        //-------------------------
        ContenuColisage.SetCurrentKey("No. colisage", "Shipment No.", "Shipment Line No.");
        ContenuColisage.SetRange("No. colisage", "No.");

        //on ne peut pas terminer un colisage dont les lignes ne comporte pas de n° BL
        ContenuColisage.SetRange("Shipment No.", '');
        if ContenuColisage.FindFirst() then
            Error(Text009Lbl);

        ContenuColisage.SetRange("Shipment No.");
        if ContenuColisage.FindSet() then
            repeat
                ContenuColisage.CalcFields("Quantite colisee totale", "Qte expediee");
                ContenuColisage.TestField("No. UC");

                if ContenuColisage."Quantite colisee totale" <> ContenuColisage."Qte expediee" then
                    Error(Text002Lbl, ContenuColisage."Shipment No.", ContenuColisage."Shipment Line No.", ContenuColisage."Qte expediee",
                    ContenuColisage."Quantite colisee totale");

                if ContenuColisage."Poids brut ligne" = 0 then begin
                    ContenuColisage2.Reset();
                    ContenuColisage2.SetCurrentKey("No. colisage", "Shipment No.", "Shipment Line No.");
                    ContenuColisage2.SetRange("No. colisage", "No.");
                    ContenuColisage2.SetFilter(Type, '<>%1', 0);
                    ContenuColisage2.SetRange("No. UC", ContenuColisage."No. UC");
                    ContenuColisage2.SetFilter("Poids brut ligne", '<>%1', 0);
                    if not ContenuColisage2.FindFirst() then
                        Error(Text004Lbl, ContenuColisage."No. UC");    //poids brut obligatoire
                end;

                if ContenuColisage."Poids net ligne" = 0 then begin
                    ContenuColisage2.Reset();
                    ContenuColisage2.SetCurrentKey("No. colisage", "Shipment No.", "Shipment Line No.");
                    ContenuColisage2.SetRange("No. colisage", "No.");
                    ContenuColisage2.SetFilter(Type, '<>%1', 0);
                    ContenuColisage2.SetRange("No. UC", ContenuColisage."No. UC");
                    ContenuColisage2.SetFilter("Poids net ligne", '<>%1', 0);
                    if not ContenuColisage2.FindFirst() then
                        Error(Text005Lbl, ContenuColisage."No. UC");    //Poids net
                end;

            until ContenuColisage.Next() = 0;

        //Mettre le n° colisage dans les lignes BL
        //-----------------------
        ContenuColisage.Reset();
        ContenuColisage.SetRange("No. colisage", "No.");
        if ContenuColisage.FindSet() then
            repeat
                if ShptLine.Get(ContenuColisage."Shipment No.", ContenuColisage."Shipment Line No.") then begin
                    ShptLine."No. colisage" := "No.";
                    ShptLine."Packing in Progress" := false;
                    ShptLine.Modify();
                end;
            until ContenuColisage.Next() = 0;

        //Mettre à jour le statut entête
        "Date comptabilisation" := WorkDate();
        "Packing Status" := "Packing Status"::"Terminé";
        Modify();
    end;

    procedure CheckPackingStatus()
    var
        Text001Err: Label 'Modification non autorisée en raison du statut du colis';
    begin
        if "Packing Status" <> 0 then
            Error(Text001Err);
    end;

    procedure MAJPoidsSurContenuColisage()
    var
        ContenuColisage: Record "Contenu colisage";
        PoidsBrutDeReference: Decimal;
        PoidsBrutReparti: Decimal;
        PoidsNetTotalArticles: Decimal;
        PlusGrosPoidsNet: Decimal;
        NumLignePlusGrosPoids: Integer;
    begin
        //Soit on a indiqué des poids sur les palettes et colis, soit c'est le poids global saisi qui doit être saupoudré sur les lignes d'articles (contenu colisage).
        CalcFields("Poids brut total colise");
        if Rec."Poids brut total colise" <> 0 then
            PoidsBrutDeReference := Rec."Poids brut total colise"
        else
            PoidsBrutDeReference := Rec."Poids brut non colise";

        //Le seul poids net dont on dispose, c'est le poids net de chaque article, on va calculer le prorata de chaque article dans le poids net total des articles présents
        //dans le colisage et donner ensuite à chaque ligne d'article un poids brut correspondant à ce prorata.
        //Cela ne peut toutefois être fait que si le poids brut total pesé est supérieur au poids net des articles. Lorsque ce n'est pas le cas, on va recalculer un poids net
        //théorique. 
        //Pour ne pas perdre le poids net de l'article lorsqu'on le recalcule (si on saisit un poids brut total inférieur puis supérieur au poids net total et qu'on a 
        //recalculé le poids net, on perd ce poids net), on va sauvegarder le poids net dans un champ à côté, le [Poids net invariable] (celui provenant de la fiche article).
        CalcFields("Poids net total articles");
        PoidsNetTotalArticles := "Poids net total articles";

        ContenuColisage.Reset();
        ContenuColisage.SetRange("No. colisage", "No.");
        if ContenuColisage.FindSet(true) then begin
            PlusGrosPoidsNet := 0;
            NumLignePlusGrosPoids := 0;
            PoidsBrutReparti := 0;
            repeat
                //Si c'est la premiere fois qu'on boucle sur les lignes, on sauvegarde les poids nets des articles
                if ContenuColisage."Poids net unitaire invariable" = 0 then begin
                    ContenuColisage."Poids net unitaire invariable" := ContenuColisage."Poids net unitaire";
                    ContenuColisage.Modify();
                end;
                //La ligne la plus lourde recevra les écarts d'arrondis de poids
                if ContenuColisage."Poids net ligne" > PlusGrosPoidsNet then begin
                    PlusGrosPoidsNet := ContenuColisage."Poids net ligne";
                    NumLignePlusGrosPoids := ContenuColisage."No. ligne";
                end;
                if PoidsNetTotalArticles <> 0 then
                    ContenuColisage."Poids brut ligne" := ROUND(ContenuColisage."Poids net ligne" / PoidsNetTotalArticles * PoidsBrutDeReference, 0.1)
                else
                    ContenuColisage."Poids brut ligne" := 0;

                PoidsBrutReparti := PoidsBrutReparti + ContenuColisage."Poids brut ligne";

                ContenuColisage."Poids brut unitaire" := ROUND(ContenuColisage."Poids brut ligne" / ContenuColisage."Quantite UC", 0.01);
                ContenuColisage.Modify();
            until ContenuColisage.Next() = 0;
            if PoidsBrutDeReference <> PoidsBrutReparti then begin
                ContenuColisage.get(Rec."No.", NumLignePlusGrosPoids);
                ContenuColisage."Poids brut ligne" := ContenuColisage."Poids brut ligne" + ROUND(PoidsBrutDeReference - PoidsBrutReparti, 0.1);
                ContenuColisage."Poids brut unitaire" := ROUND(ContenuColisage."Poids brut ligne" / ContenuColisage."Quantite UC", 0.01);
                ContenuColisage.Modify();
            end;

        end;
    end;

    procedure Expedier()
    //Va générer le BL pour chaque commande présente dans le colisage (normalement une seule commande)
    var
        ContenuColisage: Record "Contenu colisage";
        EnteteVente: Record "Sales Header";
        LigneVente: Record "Sales Line";
        LigneVenteRattachee: Record "Sales Line";
        NumCde: Code[20];
        NbCdesValidees: Integer;
        NbCdes:Integer;
        GenererBLQst : Label 'Voulez-vous générer le(s) bon(s) de livraison pour ce colisage ?';
        NbCdesValideesLbl: Label '%1 commandes validées sur %2.',Comment = '%1 Nb commandes validées; %2 = Nb commandes dans le colisage';
        ColisageDejaExpedieErr : Label 'Colisage déjà expédié.';
    begin
        if Expedie then
            Error(ColisageDejaExpedieErr);
        
        if not Confirm(GenererBLQst) then
            exit;

        ContenuColisage.SetCurrentKey("No. colisage", "Order No.", "Order Line No.");
        ContenuColisage.SetRange("No. colisage",Rec."No.");
        if ContenuColisage.FindSet(false) then begin
            NumCde := '';
            repeat
                if ContenuColisage."Order No." <> NumCde then begin
                    EnteteVente.Get(EnteteVente."Document Type"::Order, ContenuColisage."Order No.");
                    EnteteVente.ViderQteAExpedierAutresPhases(-999);
                    Commit();
                end;
                LigneVente.Get(LigneVente."Document Type"::Order, ContenuColisage."Order No.", ContenuColisage."Order Line No.");
                LigneVente.Validate("Qty. to Ship", LigneVente."Qty. to Ship" + ContenuColisage."Quantite UC");
                LigneVente.Modify();
                LigneVenteRattachee.setrange("Document Type",LigneVente."Document Type");
                LigneVenteRattachee.setrange("Document No.",LigneVente."Document No.");
                LigneVenteRattachee.SetRange("Attached to Line No.",LigneVente."Line No.");
                if LigneVenteRattachee.findset(true) then 
                    repeat
                        LigneVenteRattachee.Validate("Qty. to Ship",LigneVente."Qty. to Ship");
                        LigneVenteRattachee.Modify();
                    until LigneVenteRattachee.Next() = 0;
                NumCde := ContenuColisage."Order No.";
            until ContenuColisage.Next() = 0;

            //On va reboucler sur les memes lignes pour lancer la validation en BL de chaque commande présente dans le colisage. 
            ContenuColisage.FindSet(true);
            NumCde := '';
            NbCdes := 0;
            NbCdesValidees := 0;
            repeat
                if ContenuColisage."Order No." <> NumCde then begin
                    NbCdes := NbCdes + 1;
                    EnteteVente.Get(EnteteVente."Document Type"::Order, ContenuColisage."Order No.");
                    EnteteVente.Ship := true;
                    EnteteVente.Invoice := false;
                    EnteteVente.Validate("Posting Date",Rec."Date comptabilisation");
                    EnteteVente.Modify();
                    Commit();
                    if not codeunit.Run(Codeunit::"Sales-Post",EnteteVente) then begin
                        ContenuColisage."Erreur validation BL" := CopyStr(GetLastErrorText(),1,250);
                        ContenuColisage.Modify();
                        ClearLastError();
                    end else 
                        NbCdesValidees := NbCdesValidees + 1;

                    Commit();
                end;

                NumCde := ContenuColisage."Order No.";
            until ContenuColisage.Next() = 0;
            if NbCdes <> 0 then 
                if (NbCdesValidees = NbCdes) then begin
                    Rec.Expedie := true;
                    rec."Commentaire validation" := '';
                end else
                    Rec."Commentaire validation" := StrSubstNo(NbCdesValideesLbl,NbCdesValidees,NbCdes) 
        end;
    end;

    procedure ExtraireColisage()
    //On a parfois besoin de rassembler plusieurs colisages en un seul.
    //Si on livre par exemple une commande en deux fois la même journée (sans faire partir la marchandise) et que dans les faits, cela ne corresponde qu'à un 
    //seul colisage, on a le système qui a créé automatiquement 2 colisages (1 pour chaque BL généré).
    //On peut alors demander à extraire un colisage pour l'ajouter à l'autre, ce qui a pour effet de supprimer le colisage extrait.
    //On se positionne sur le colisage cible et on extrait l'autre colisage qui va s'ajouter au colisage actif puis être supprimé.
    var
        ColisageSource: Record "Entete colisage";
        ContenuColisageSource: Record "Contenu colisage";
        ContenuColisage: Record "Contenu colisage";
        PageListeColisage: Page "Liste colisages";
        NumColisageSource: Code[20];
        NumLigne: Integer;
        //SavLineNo: Integer;

    begin
        //PagePhases.DefinirConditionsAppel(true);
        ColisageSource.SetCurrentKey("Sell-to Customer No.", Expedie, "No. commande");
        ColisageSource.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");
        ColisageSource.SetFilter("No.", '<>%1', Rec."No.");
        PageListeColisage.SetTableView(ColisageSource);
        PageListeColisage.LookupMode(true);
        if PageListeColisage.RunModal() = Action::LookupOK then begin
            //KAN.FHA 08/09/2025 FIN
            PageListeColisage.GetRecord(ColisageSource);
            NumColisageSource := ColisageSource."No.";

            NumLigne := 0;

            ContenuColisageSource.Reset();
            ContenuColisageSource.SetRange("No. colisage", NumColisageSource);

            if ContenuColisageSource.FindSet() then begin
                ContenuColisage.LockTable();
                ContenuColisage.SetRange("No. colisage", "No.");
                if ContenuColisage.FindLast() then
                    NumLigne := ContenuColisage."No. ligne";

                //Window.Open(Text002Msg + Text003Msg);

                repeat
                    //if SalesShptHeader."No." <> SalesShptLine2."Document No." then
                    //    SalesShptHeader.Get(SalesShptLine2."Document No.");

                    //if not Item.Get(SalesShptLine2."No.") then
                    //    Item.Init();

                    //Créer ligne colisage
                    NumLigne := NumLigne + 10000;

                    ContenuColisage.Init();
                    ContenuColisage."No. colisage" := "No.";
                    ContenuColisage."No. ligne" := NumLigne;
                    ContenuColisage."Shipment No." := ContenuColisageSource."Shipment No.";
                    ContenuColisage.Validate("Shipment Line No.", ContenuColisageSource."Shipment Line No.");
                    ContenuColisage.Insert(true);
                    //SavLineNo := NumLigne;

                /*
                //recherche des lignes commentaires attachées à la ligne de BL
                //------------------------------------------------------------
                ShptLineAtt.SetRange("Document No.", SalesShptLine2."Document No.");
                ShptLineAtt.SetRange(Type, ShptLineAtt.Type::" ");
                ShptLineAtt.SetRange("Attached to Line No.", SalesShptLine2."Line No.");
                if ShptLineAtt.FindSet() then
                    repeat
                        LastLineNo += 10000;
                        ContenuColisage."No. ligne" := LastLineNo;
                        ContenuColisage."Attached to Line No." := SavLineNo;
                        ContenuColisage."Item No." := ShptLineAtt."No.";
                        ContenuColisage.Description := ShptLineAtt.Description;
                        ContenuColisage."Description 2" := ShptLineAtt."Description 2";
                        ContenuColisage."Designation article" := '';
                        ContenuColisage."Cross-Reference No." := ShptLineAtt."Item Reference No.";
                        ContenuColisage."Quantite UC" := 0;
                        ContenuColisage."Shipment No." := ShptLineAtt."Document No.";
                        ContenuColisage."Shipment Line No." := ShptLineAtt."Line No.";
                        case ShptLineAtt.Type of
                            ShptLineAtt.Type::" ":
                                ContenuColisage.Type := ContenuColisage.Type::" ";
                            ShptLineAtt.Type::"Charge (Item)":
                                ContenuColisage.Type := ContenuColisage.Type::"Charge (Item)";
                            ShptLineAtt.Type::"Fixed Asset":
                                ContenuColisage.Type := ContenuColisage.Type::"Fixed Asset";
                            ShptLineAtt.Type::"G/L Account":
                                ContenuColisage.Type := ContenuColisage.Type::"G/L Account";
                            ShptLineAtt.Type::Item:
                                ContenuColisage.Type := ContenuColisage.Type::Item;
                        end;
                        //ContenuColisage.Type := ShptLineAtt.Type;
                        ContenuColisage."Order No." := ShptLineAtt."Order No.";
                        ContenuColisage."Order Line No." := ShptLineAtt."Order Line No.";
                        ContenuColisage.Insert(true);

                    until ShptLineAtt.Next() = 0;
                    */
                until ContenuColisageSource.Next() = 0;
                ColisageSource.Reset();
                ColisageSource.get(NumColisageSource);
                ColisageSource.Delete(true);
            end;
        end;
    end;


}

