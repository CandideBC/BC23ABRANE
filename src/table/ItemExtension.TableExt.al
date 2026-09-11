tableextension 50000 ItemExtension extends Item
{
    fields
    {
        field(50000; "No. client final"; Code[20])
        {
            Caption = 'N° client final';
            DataClassification = ToBeClassified;
            TableRelation = Customer;

            trigger OnValidate()
            begin

                if "No. client final" <> '' then
                    CreateCustomerCrosReference("No. client final", "No.");

            end;
        }
        field(50020; "Qte stock tampon"; Decimal)
        {
            BlankZero = true;
            Caption = 'Qté stock tampon';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(50030; "Qte stock maxi"; Decimal)
        {
            BlankZero = true;
            Caption = 'Qté stock maxi';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(50040; Indic; BLOB)
        {
            Caption = 'Indic';
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(50050; "Composants planning (Qte)"; Decimal)
        {
            CalcFormula = sum("Planning Component"."Expected Quantity (Base)" where("Item No." = field("No."),
                                                                                     "Due Date" = field("Date Filter"),
                                                                                     "Location Code" = field("Location Filter"),
                                                                                     "Variant Code" = field("Variant Filter"),
                                                                                     "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                                     "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter")));
            Caption = 'Composants planning (Qté)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50060; "Prix/Cout relation"; Boolean)
        {
            Caption = 'Prix/Coût relation';
            DataClassification = ToBeClassified;
        }
        field(50070; "Code matiere"; Code[20])
        {
            Caption = 'Code matière';
            DataClassification = ToBeClassified;
            TableRelation = Matiere;

            trigger OnValidate()
            begin
                if not "Miscellaneous Item" then
                    Validate(Codifab, ParamCodifab.Get("Code matiere", "Eco Tax Furniture Code"));
                CalcFields("Designation matiere");

                //KAN.FHA 17/02/2025 DEBUT
                IF "Code matiere" <> xrec."Code matiere" then
                    Validate("Eco Tax Furniture Code", '');
                //KAN.FHA 17/02/2025 FIN
            end;
        }

        field(50071; "Designation matiere"; Text[50])
        {
            CalcFormula = lookup(Matiere.Description where("Code" = field("Code matiere")));
            Caption = 'Désignation matière';
            Editable = false;
            FieldClass = FlowField;
        }

        field(50090; "Prix bloque"; Boolean)
        {
            Caption = 'Prix bloqué';
            DataClassification = ToBeClassified;

        }
        field(50100; "Nom fournisseur"; Text[100])
        {
            CalcFormula = lookup(Vendor.Name where("No." = field("Vendor No.")));
            Caption = 'Nom fournisseur';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50105; Codifab; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Si oui, le système calculera le montant de la taxe codifab sur les lignes de factures et d''avoirs si le pays du client facturé est un pays Codifab';

            trigger OnValidate()
            begin
                if CurrFieldNo = FieldNo(Codifab) then
                    TestField("Miscellaneous Item", true);


                /*KAN.FHA 25/01/2021
                //On ne veut plus que le passé soit mis à jour si on coche/décoche un article
                IF Codifab <> xRec.Codifab THEN BEGIN
                  ParamVente.GET;
                  ParamVente.TESTFIELD("% taxe Codifab");
                  LigneFactureVente.SETCURRENTKEY(Type,"No.");
                  LigneFactureVente.SETRANGE(Type,LigneFactureVente.Type::Item);
                  LigneFactureVente.SETRANGE("No.","No.");
                  IF LigneFactureVente.FINDSET(TRUE,FALSE) THEN
                    REPEAT
                      EnteteFactureVente.GET(LigneFactureVente."Document No.");
                      IF NOT Pays.GET(EnteteFactureVente."Bill-to Country/Region Code") THEN
                        Pays.INIT;
                      IF Pays."Pays Codifab" AND Codifab AND NOT (EnteteFactureVente.ASS) AND (STRPOS(EnteteFactureVente."No.",'SAV') = 0) THEN
                        LigneFactureVente."Montant taxe Codifab" := ROUND(ParamVente."% taxe Codifab" / 100 * LigneFactureVente."Montant ligne HT (DS)",0.01)
                      ELSE
                        LigneFactureVente."Montant taxe Codifab" := 0;
                      LigneFactureVente.MODIFY;
                    UNTIL LigneFactureVente.NEXT = 0;
                  LigneAvoirVente.SETCURRENTKEY(Type,"No.");
                  LigneAvoirVente.SETRANGE(Type,LigneAvoirVente.Type::Item);
                  LigneAvoirVente.SETRANGE("No.","No.");
                  IF LigneAvoirVente.FINDSET(TRUE,FALSE) THEN
                    REPEAT
                      EnteteAvoirVente.GET(LigneAvoirVente."Document No.");
                      IF NOT Pays.GET(EnteteAvoirVente."Bill-to Country/Region Code") THEN
                        Pays.INIT;
                      IF Pays."Pays Codifab" AND Codifab AND NOT (EnteteFactureVente.ASS) AND (STRPOS(EnteteAvoirVente."No.",'SAV') =0) THEN
                        LigneAvoirVente."Montant taxe Codifab" := ROUND(ParamVente."% taxe Codifab" / 100 * LigneAvoirVente."Montant ligne HT (DS)",0.01)
                      ELSE
                        LigneAvoirVente."Montant taxe Codifab" := 0;
                      LigneAvoirVente.MODIFY;
                    UNTIL LigneAvoirVente.NEXT = 0;
                
                END;
                KAN.FHA 25/01/2021*/

            end;
        }
        field(50110; "Eco Tax Furniture Code"; Code[10])
        {
            Caption = 'Code taxe éco mobilier';
            DataClassification = ToBeClassified;
            TableRelation = "Taxe eco-mobilier".Code where("Code matiere associe" = field("Code matiere"));

            trigger OnValidate()
            begin
                if not "Miscellaneous Item" then
                    Validate(Codifab, ParamCodifab.Get("Code matiere", "Eco Tax Furniture Code"));
            end;
        }
        field(50120; "Eco Tax Furniture Family"; Text[50])
        {
            CalcFormula = lookup("Taxe eco-mobilier".Family where(Code = field("Eco Tax Furniture Code")));
            Caption = 'Famille taxe éco mobilier';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50130; "Eco Tax Furniture Sub Family"; Text[50])
        {
            CalcFormula = lookup("Taxe eco-mobilier"."Sub Family" where(Code = field("Eco Tax Furniture Code")));
            Caption = 'Sous Famille taxe éco mobilier';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50140; Dimension; Text[50])
        {
            Caption = 'Dimension';
            DataClassification = ToBeClassified;
        }
        field(50150; "Unit Of Measure"; Option)
        {
            Caption = 'Unité de mesure';
            DataClassification = ToBeClassified;
            OptionCaption = 'mm,cm,ml';
            OptionMembers = mm,cm,ml;
        }
        field(50160; "Creation date"; Date)
        {
            Caption = 'Date de création';
            DataClassification = ToBeClassified;
        }
        field(50170; "Qty. on Asm. Component Quote"; Decimal)
        {
            CalcFormula = sum("Assembly Line"."Remaining Quantity (Base)" where("Document Type" = const(Quote),
                                                                                Type = const(Item),
                                                                               "No." = field("No."),
                                                                                //FHA Migration "Test Quote" = CONST (false),
                                                                                //"Released Status" = CONST (true),
                                                                                "Location Code" = field("Location Filter"),
                                                                                "Variant Code" = field("Variant Filter"),
                                                                                "Due Date" = field("Date Filter")));
            Caption = 'Qty. on Asm. Component Quote';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50180; "Qty. on Sales Quote"; Decimal)
        {
            CalcFormula = sum("Sales Line"."Outstanding Qty. (Base)" where("Document Type" = const(Quote),
                                                                           Type = const(Item),
                                                                           "No." = field("No."),
                                                                           //"Test Quote" = const (false),
                                                                           "Released Status" = const(true),
                                                                           "Location Code" = field("Location Filter"),
                                                                           "Variant Code" = field("Variant Filter"),
                                                                           "Shipment Date" = field("Date Filter")));
            Caption = 'Qty. on Sales Order';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50190; "Complement ref. client"; Text[30])
        {
            Caption = 'Complément réf. client';
            DataClassification = ToBeClassified;
        }
        field(50200; "Référence externe"; Code[50])
        {
            CalcFormula = lookup("Item Reference"."Reference No." where("Item No." = field("No."),
                                                                                     "Reference Type" = filter(Customer)));
            FieldClass = FlowField;
        }

        field(50225; "Quantite en transit"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Ligne container"."Quantite restante" where(Type = const(Article),
                                                                           "No." = field("No.")));
            Caption = 'Quantité en transit';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50230; "Inventory trash"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No."),
                                                                  "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                  "Location Code" = field("Location trash Filter"),
                                                                  "Drop Shipment" = field("Drop Shipment Filter"),
                                                                  "Variant Code" = field("Variant Filter"),
                                                                  "Lot No." = field("Lot No. Filter"),
                                                                  "Serial No." = field("Serial No. Filter")));
            Caption = 'Stocks rebut';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50240; "Location trash Filter"; Code[10])
        {
            Caption = 'Filtre magasin rebut';
            FieldClass = FlowFilter;
            TableRelation = Location;
        }


        field(50246; "Filtre magasin stock"; Code[10])
        {
            Caption = 'Filtre magasin stock';
            FieldClass = FlowFilter;
            TableRelation = Location;
        }
        field(50248; Stock; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No."),
                                                                  "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                  "Location Code" = field("Filtre magasin stock"),
                                                                  "Drop Shipment" = field("Drop Shipment Filter"),
                                                                  "Variant Code" = field("Variant Filter"),
                                                                  "Lot No." = field("Lot No. Filter"),
                                                                  "Serial No." = field("Serial No. Filter")));
            Caption = 'Stock';
            DecimalPlaces = 0 : 5;
            Description = 'KAN';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50250; "Miscellaneous Item"; Boolean)
        {
            Caption = 'Article Divers';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if not "Miscellaneous Item" then
                    "Article divers jamais acheté" := false;

                if not "Miscellaneous Item" then
                    Validate(Codifab, ParamCodifab.Get("Code matiere", "Eco Tax Furniture Code"))
                else
                    Validate(Codifab, false);
            end;
        }
        field(50252; "Poids obligatoire"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 16/10/2020. Pour certains divers, on impose la saisie d''un poids sur les documents de vente, notamment pour calcul de l''EcoTaxe.';
        }
        field(50255; "Date derniere vente"; Date)
        {
            CalcFormula = max("Item Ledger Entry"."Posting Date" where("Item No." = field("No."),
                                                                        "Entry Type" = const(Sale)));
            Caption = 'Date dernière vente';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50256; "Date dernier achat"; Date)
        {
            CalcFormula = max("Item Ledger Entry"."Posting Date" where("Item No." = field("No."),
                                                                        "Entry Type" = const(Purchase)));
            Caption = 'Date dernier achat';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50260; "Ne pas regrouper sur BP"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50264; "Article divers jamais acheté"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 27/05/2020. Pour éviter que les lignes de commandes ventes se mettent et restent en rouge sur des articles vendus mais jamais achetés (Forfait emballage par exemple).';

            trigger OnValidate()
            begin
                if "Article divers jamais acheté" then
                    TestField("Miscellaneous Item", true);
            end;
        }
        field(50270; "Nature vente"; Option)
        {
            DataClassification = ToBeClassified;

            OptionMembers = Mobilier,"Pose/Audit",Transport,"Bennes/Fenwick",SAV;

            trigger OnValidate()
            var
                NatureSAVInterditErr: Label 'Vous ne pouvez pas affecter cette nature de vente à un article.';
            begin
                if "Nature vente" = "Nature vente"::SAV then
                    Error(NatureSAVInterditErr);
            end;
        }
        field(55000; "Qty. on Assembly Order Cust"; Decimal)
        {
            CalcFormula = sum("Assembly Header"."Remaining Quantity (Base)" where("Document Type" = const(Order),
                                                                                   "Item No." = field("No."),
                                                                                   "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                                   "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                                   "Location Code" = field("Location Filter"),
                                                                                   "Variant Code" = field("Variant Filter")));
            //Migration FHA
            //"Specific Order" = FILTER (true)));
            Caption = 'Qté sur ordre d''assemblage client';
            DecimalPlaces = 0 : 5;
            Description = 'STCV3';
            Editable = false;
            FieldClass = FlowField;
        }

        field(55100; "Achat bloqué"; Boolean)
        {
            Caption = 'Achat bloqué';
            DataClassification = ToBeClassified;
        }
        field(55200; "Nb Ref Externe"; Integer)
        {
            CalcFormula = count("Item Reference" where("Item No." = field("No.")));
            FieldClass = FlowField;
        }
        field(55300; "Indice plan conditionnement"; Text[10])
        {
            Caption = 'Indice du plan de conditionnement';
            DataClassification = ToBeClassified;
        }
        field(55310; "Nb pieces par emballage"; Decimal)
        {
            BlankZero = true;
            Caption = 'Nb de pieces / emballage';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
        }
        field(55315; Commentaires; Text[200])
        {
            Caption = 'Commentaires conditionnement';
            DataClassification = ToBeClassified;
        }
        field(55320; "Film retractable"; Boolean)
        {
            Caption = 'Film retractable';
            DataClassification = ToBeClassified;
        }
        field(55330; "Film bulle"; Boolean)
        {
            Caption = 'Film bulle';
            DataClassification = ToBeClassified;
        }
        field(55340; Rien; Boolean)
        {
            Caption = 'Rien';
            DataClassification = ToBeClassified;
        }
        field(55341; "Sachet plastique"; Boolean)
        {
            Caption = 'Sachet plastique';
            DataClassification = ToBeClassified;
        }
        field(55350; "Emballage par carton"; Boolean)
        {
            Caption = 'Emballage par carton';
            DataClassification = ToBeClassified;
        }
        field(55351; "1(Long)"; Decimal)
        {
            BlankZero = true;
            Caption = 'Longueur carton';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
        }
        field(55352; "1(larg)"; Decimal)
        {
            BlankZero = true;
            Caption = 'Largeur carton';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
        }
        field(55353; "1(h)"; Decimal)
        {
            BlankZero = true;
            Caption = 'Hauteur carton';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
        }
        field(55354; "Nb de carton / palette"; Decimal)
        {
            BlankZero = true;
            Caption = 'Nb de carton maxi / palette';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
        }
        field(55355; "2(Long)"; Decimal)
        {
            BlankZero = true;
            Caption = 'Longueur palette';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
        }
        field(55356; "2(larg)"; Decimal)
        {
            BlankZero = true;
            Caption = 'Largeur palette';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
        }
        field(55357; "2(h)"; Decimal)
        {
            BlankZero = true;
            Caption = 'Hauteur palette';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
        }
        field(55360; "Emballage caisse bois"; Boolean)
        {
            Caption = 'Emballage dans caisse en bois';
            DataClassification = ToBeClassified;
        }
        field(55361; "3(Long)"; Decimal)
        {
            BlankZero = true;
            Caption = 'Longueur caisse';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
        }
        field(55362; "3(larg)"; Decimal)
        {
            BlankZero = true;
            Caption = 'Largeur caisse';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
        }
        field(55363; "3(h)"; Decimal)
        {
            BlankZero = true;
            Caption = 'Hauteur caisse';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
        }
        field(55370; "Piece seule sur palette"; Boolean)
        {
            Caption = 'Piece seule filmée et cerclée sur palette';
            DataClassification = ToBeClassified;
        }
        field(55371; "4(Long)"; Decimal)
        {
            BlankZero = true;
            Caption = 'Longueur palette pièce seule';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
        }
        field(55372; "4(llarg)"; Decimal)
        {
            BlankZero = true;
            Caption = 'Largeur palette pièce seule';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
        }
        field(55373; "4(h)"; Decimal)
        {
            BlankZero = true;
            Caption = 'Hauteur palette pièce seule';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
        }
        field(55380; "Nb de pièces dans carton"; Decimal)
        {
            BlankZero = true;
            Caption = 'Nb de pièce dans carton';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
        }
        field(56000; "Code client"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'DIA£LBO';
        }
        field(56050; "Nb de pièces sur palette"; Decimal)
        {
            BlankZero = true;
            Caption = 'Nb de pièces sur palette';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
        }
        field(56060; "Nb de pièces dans caisse"; Decimal)
        {
            BlankZero = true;
            Caption = 'Nb de pièces dans caisse';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
        }
        field(56070; "Ref. client"; Code[20])
        {

            Caption = 'Réf. client';
            Description = 'Remplace le champ N° 2 utilisé dans NAV2013';
            DataClassification = ToBeClassified;
            TableRelation = "Reference client";
            trigger OnValidate()
            var
                ReferenceClient: Record "Reference client";
            begin
                if not ReferenceClient.Get(Rec."Ref. client") then
                    ReferenceClient.Init();
                Rec."Code enseigne" := ReferenceClient."Code enseigne";
            end;
        }
        field(56080; "Code enseigne"; Code[20])
        {
            Caption = 'Code enseigne';
            DataClassification = ToBeClassified;
            TableRelation = Enseigne;
            Editable = false;
            Description = 'Hérité de la réf. client';
        }
        field(56100; PMP; Decimal)
        {

            Caption = 'PMP';
            BlankZero = true;
            DecimalPlaces = 2 : 2;
            Description = 'Il reste à developper le fait de le calculer chaque nuit';
            DataClassification = ToBeClassified;

        }
        field(56110; Phase; Integer)
        {

            Caption = 'Phase';
            BlankZero = true;
            MinValue = 0;
            DataClassification = ToBeClassified;
            TableRelation = "Phases enseigne".Phase where("Code enseigne" = field("Code enseigne"));
        }
    }

    keys
    {
        key(MyKey1; "No. client final")
        {

        }
        key(MyKey2; "Ref. client")
        {

        }
        key(MyKey3; "Code matiere", "Eco Tax Furniture Code")
        {

        }
    }


    procedure CreateCustomerCrosReference(CustomerNo: Code[20]; ItemNo: Code[20]): Boolean
    var
        //ItemCrossReference: Record "Item Cross Reference";
        ItemReferenceRecord: Record "Item Reference";
        Item: Record Item;
    begin
        Item.Get(ItemNo);

        ItemReferenceRecord.Init();
        ItemReferenceRecord.Validate("Item No.", Item."No.");
        ItemReferenceRecord.Validate("Unit of Measure", Item."Base Unit of Measure");
        ItemReferenceRecord.Validate("Reference Type", ItemReferenceRecord."Reference Type"::Customer);
        ItemReferenceRecord.Validate("Reference Type No.", CustomerNo);
        ItemReferenceRecord.Validate("Reference No.", Item."No.");
        ItemReferenceRecord.Validate(Description, Item.Description);

        if not ItemReferenceRecord.Insert() then
            exit(false);

        exit(true);
    end;

    procedure CalcPMP_A_Date(pDate: Date)
    var
        EcritureArticle: Record "Item Ledger Entry";
        LigneFactAchat: Record "Purch. Inv. Line";
        EcritureValeur: Record "Value Entry";
        HistoPMP: Record "Historique PMP article";
        QteEnStock: Decimal;
        QteTrouvee: Decimal;
        MontantAchatsAvecFrais: Decimal;
        QteRestantAValoriser: Decimal;
        CoutTotal: Decimal;
        PasAssezDeFactures: Text[30];
        CoutMoyenAvecFrais: Decimal;

    begin
        EcritureArticle.SetCurrentKey("Item No.", Positive, "Posting Date");
        EcritureArticle.Ascending(false);
        EcritureArticle.SetRange(Positive, true);
        EcritureArticle.SetRange("Entry Type", EcritureArticle."Entry Type"::Purchase);
        EcritureArticle.SetRange("Posting Date", 0D, pDate);

        LigneFactAchat.Reset();
        LigneFactAchat.SetCurrentKey(Type, "No.", "Posting Date");
        LigneFactAchat.Ascending(false);
        LigneFactAchat.SetRange(Type, LigneFactAchat.Type::Item);
        LigneFactAchat.SetRange("Posting Date", 0D, pDate);

        EcritureValeur.SetCurrentKey("Item Ledger Entry No.", "Entry Type");

        /*FHA XX
        IF Item."Last Direct Cost" <> 0 THEN
          DPA := "Last Direct Cost"
        ELSE BEGIN
          LigneFactAchat.SETRANGE("No.","No.");
          LigneFactAchat.SETFILTER(Quantity,'<>%1',0);
          IF LigneFactAchat.FINDLAST THEN
            DPA := LigneFactAchat."Unit Cost (LCY)";
        END;
        FHA XX*/

        SetFilter("Location Filter", '<>*C*');
        CalcFields("Net Change");
        QteEnStock := "Net Change";

        if QteEnStock <> 0 then
            if not HistoPMP.Get("No.", pDate) then begin
                HistoPMP.Init();
                HistoPMP."No. article" := "No.";
                HistoPMP.Date := pDate;
                HistoPMP."Quantite en stock" := QteEnStock;
                HistoPMP.Insert();
            end;

        QteTrouvee := 0;
        MontantAchatsAvecFrais := 0;
        //DateDernMouvement := 0D;
        /*FHA XX
        EcrArt2.RESET;
        EcrArt2.SETCURRENTKEY("Item No.","Posting Date");
        EcrArt2.SETRANGE("Item No.","No.");
        EcrArt2.SETRANGE("Posting Date",0D,DateValeurStock);
        IF EcrArt2.FINDLAST THEN
          DateDernMouvement := EcrArt2."Posting Date";
        FHA XX*/

        //DateDernEntreeAchat := 0D;
        /*FHA XX
        EcrArt2.RESET;
        EcrArt2.SETCURRENTKEY("Item No.","Entry Type","Posting Date");
        EcrArt2.SETRANGE("Item No.",Item."No.");
        EcrArt2.SETRANGE("Entry Type",EcrArt2."Entry Type"::Purchase);
        IF EcrArt2.FINDLAST THEN
          DateDernEntreeAchat := EcrArt2."Posting Date";
        FHA XX*/

        /*FHA XX
        PctDepreciationRetenu := 0;
        IF DateDernEntreeAchat < DateMaxPourDepreciation3 THEN
          PctDepreciationRetenu := PctDepreciation3
        ELSE
          IF DateDernEntreeAchat < DateMaxPourDepreciation2 THEN
            PctDepreciationRetenu := PctDepreciation2
          ELSE
            IF DateDernEntreeAchat < DateMaxPourDepreciation1 THEN
              PctDepreciationRetenu := PctDepreciation1;
        FHA XX*/

        EcritureArticle.SetRange("Item No.", "No.");
        if EcritureArticle.FindSet() then
            //FHA XX DateDernMouvement := EcritureArticle."Posting Date";   // ???? A verifier avec bloc de code ci-dessus
            repeat
                if EcritureArticle.Quantity > 0 then begin
                    QteTrouvee := QteTrouvee + EcritureArticle.Quantity;
                    if QteTrouvee <= QteEnStock then
                        QteRestantAValoriser := EcritureArticle.Quantity //Sert juste à savoir si on doit tout prendre plus bas au niveau des écritures valeur.
                    else
                        QteRestantAValoriser := EcritureArticle.Quantity - (QteTrouvee - QteEnStock); //Là le champ QteRestantAValoriser a un sens, on tombe par ex sur une ligne de 1000 mais il faut en prendre que 22.

                    EcritureArticle.CalcFields("Cost Amount (Expected)", "Cost Amount (Actual)");

                    if QteTrouvee <= QteEnStock then
                        CoutTotal := (EcritureArticle."Cost Amount (Expected)" + EcritureArticle."Cost Amount (Actual)")
                    else
                        CoutTotal := Round((EcritureArticle."Cost Amount (Expected)" + EcritureArticle."Cost Amount (Actual)") / EcritureArticle.Quantity * QteRestantAValoriser, 0.01);

                    MontantAchatsAvecFrais := MontantAchatsAvecFrais + CoutTotal;
                end;
            until (EcritureArticle.Next() = 0) or (QteTrouvee >= QteEnStock);


        PasAssezDeFactures := '';

        if QteTrouvee < QteEnStock then begin
            //Si on n'a pas trouvé assez d'achats après la date limite pour couvrir la quantité restant en stock, on valorise
            //la quantité en écart au coût qui était connu juste à la date limite
            //Je mets donc en commentaire les deux lignes suivantes :
            PasAssezDeFactures := 'Manque des factures pour ' + Format(QteEnStock - QteTrouvee);

            //La quantité pour laquelle on ne trouve pas de factures d'achat va être valorisée au coût unitaire de NAV (qui est peut-être faux mais c'est la seule valeur dont on dispose et elle inclut les frais annexes).
            /*FHA XX
            DetailValeurStock.INIT;
            DetailValeurStock."No. article" := Item."No.";
            DetailValeurStock."No. ecriture article" := 0;
            DetailValeurStock."Type document" := DetailValeurStock."Type document"::"Factures manquantes";
            DetailValeurStock."No. document" := '';
            DetailValeurStock."No. ligne document" := 0;
            DetailValeurStock.Quantite := (QteEnStock - QteTrouvee);
            DetailValeurStock."Cout unitaire" := Item."Unit Cost";
            DetailValeurStock."Cout total" := (QteEnStock - QteTrouvee) * Item."Unit Cost";
            DetailValeurStock."Date comptabilisation" := TODAY;
            DetailValeurStock.INSERT;
            FHA XX*/
            MontantAchatsAvecFrais := MontantAchatsAvecFrais + (QteEnStock - QteTrouvee) * "Unit Cost";
        end;

        if QteEnStock <> 0 then
            CoutMoyenAvecFrais := Round(MontantAchatsAvecFrais / QteEnStock, 0.00001)
        else
            CoutMoyenAvecFrais := 0;

        HistoPMP."PMP recalcule" := CoutMoyenAvecFrais;
        HistoPMP.Modify();

    end;

    procedure CalculerDispo(Afficher: Boolean; var QteDispo: Decimal);
    var
        StockDispo: Record "Stock dispo pour creer cde";
        TamponDetailDispoStock: Record TamponDetailDispoStock;
        LigneVente: Record "Sales Line";
        EnteteVente: Record "Sales Header";
        AffectationsAchat: Record "Affectations achat vente";
        InfoSoc: Record "Company Information";
        decQtePriseSurStockCetteLigne: Decimal;
        CodeUtilisateur: Text[50];
        NumLigne: Integer;

    begin
        //On va creer une ligne dans la table Dispo stock et cette ligne contient des champs calculés qui somment les lignes dans la table TamponDetailDispoStock
        //qu'on va remplir par la suite.
        CodeUtilisateur := CopyStr(UserId, 1, 50);

        InfoSoc.Get();
        InfoSoc.TestField("Location Code");

        StockDispo.SetRange("Code utilisateur", CodeUtilisateur);
        StockDispo.SetRange("Type ligne", StockDispo."Type ligne"::"Stock dispo");
        StockDispo.DeleteAll();

        TamponDetailDispoStock.Reset();
        TamponDetailDispoStock.SetRange("Code utilisateur", CodeUtilisateur);
        TamponDetailDispoStock.DeleteAll();

        rec.SetRange("Location Filter", InfoSoc."Location Code");
        CalcFields(Inventory, "Quantite en transit");

        StockDispo.Init();
        StockDispo."Code utilisateur" := CodeUtilisateur;
        StockDispo."Type ligne" := StockDispo."Type ligne"::"Stock dispo";
        StockDispo."No. article" := Rec."No.";
        StockDispo.Stock := Rec.Inventory;
        StockDispo."Code magasin" := InfoSoc."Location Code";
        StockDispo."Qte en transit" := Rec."Quantite en transit";
        StockDispo.Insert();

        LigneVente.Reset();
        LigneVente.SetCurrentKey("Document Type", Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Shipment Date");
        LigneVente.SetRange("Document Type", LigneVente."Document Type"::Quote, LigneVente."Document Type"::Order);
        LigneVente.SetRange(Type, LigneVente.Type::Item);
        LigneVente.SetRange("No.", Rec."No.");

        if LigneVente.FindSet(false) then begin
            NumLigne := 1;
            AffectationsAchat.SetCurrentKey("Type document vente", "No. document vente", "No. ligne document vente");
            AffectationsAchat.SetRange("Type document vente", AffectationsAchat."Type document vente"::Devis, AffectationsAchat."Type document vente"::Commande);
            repeat
                if LigneVente."Pris sur stock" then begin
                    TamponDetailDispoStock.Init();
                    TamponDetailDispoStock."Code utilisateur" := CodeUtilisateur;
                    TamponDetailDispoStock."No. article" := Rec."No.";
                    TamponDetailDispoStock."No. document" := LigneVente."Document No.";
                    TamponDetailDispoStock."No. ligne" := NumLigne;
                    NumLigne := NumLigne + 1;
                    TamponDetailDispoStock."Quantite reservee" := LigneVente."Outstanding Quantity";
                    EnteteVente.get(LigneVente."Document Type", LigneVente."Document No.");
                    TamponDetailDispoStock."Date chargement" := EnteteVente."Date chargement";
                    TamponDetailDispoStock."Date livraison demandee" := EnteteVente."Requested Delivery Date";
                    TamponDetailDispoStock."Code vendeur" := EnteteVente."Salesperson Code";
                    TamponDetailDispoStock."Proba transformation" := EnteteVente."Proba transformation";
                    TamponDetailDispoStock.Insert();
                end else begin
                    //Si on a des achats affectés à la ligne de commande, c'est qu'on ne prend pas tout en stock, il faut déduire les quantités achetées
                    AffectationsAchat.SetRange("No. document vente", LigneVente."Document No.");
                    AffectationsAchat.SetRange("No. ligne document vente", LigneVente."Line No.");
                    if AffectationsAchat.FindSet(false) then begin
                        decQtePriseSurStockCetteLigne := LigneVente."Outstanding Qty. (Base)";
                        repeat
                            AffectationsAchat.CalcFields("Qte achetee", "Qte recue");
                            decQtePriseSurStockCetteLigne := decQtePriseSurStockCetteLigne - (AffectationsAchat."Qte achetee" - AffectationsAchat."Qte recue");
                        until AffectationsAchat.Next() = 0;
                        if decQtePriseSurStockCetteLigne > 0 then begin
                            TamponDetailDispoStock.Init();
                            TamponDetailDispoStock."Code utilisateur" := CodeUtilisateur;
                            TamponDetailDispoStock."No. article" := Rec."No.";
                            TamponDetailDispoStock."No. document" := LigneVente."Document No.";
                            TamponDetailDispoStock."No. ligne" := NumLigne;
                            NumLigne := NumLigne + 1;
                            TamponDetailDispoStock."Quantite reservee" := decQtePriseSurStockCetteLigne;
                            EnteteVente.get(LigneVente."Document Type", LigneVente."Document No.");
                            TamponDetailDispoStock."Date chargement" := EnteteVente."Date chargement";
                            TamponDetailDispoStock."Date livraison demandee" := EnteteVente."Requested Delivery Date";
                            TamponDetailDispoStock."Code vendeur" := EnteteVente."Salesperson Code";
                            TamponDetailDispoStock."Proba transformation" := EnteteVente."Proba transformation";
                            TamponDetailDispoStock.Insert();
                        end;
                    end else
                        if (LigneVente."Document Type" = LigneVente."Document Type"::Quote) and (LigneVente.Quantity <> 0) then begin
                            //Si on arrive ici,
                            //On sait qu'on ne prend pas tout sur stock et qu'on n'a pas affecté d'achats,
                            //il faut alors décompter la ligne en [Quantité sur devis]
                            TamponDetailDispoStock.Init();
                            TamponDetailDispoStock."Code utilisateur" := CodeUtilisateur;
                            TamponDetailDispoStock."No. article" := Rec."No.";
                            TamponDetailDispoStock."No. document" := LigneVente."Document No.";
                            TamponDetailDispoStock."No. ligne" := NumLigne;
                            NumLigne := NumLigne + 1;
                            TamponDetailDispoStock."Quantite sur devis" := LigneVente."Quantity (Base)";
                            EnteteVente.get(LigneVente."Document Type", LigneVente."Document No.");
                            TamponDetailDispoStock."Date chargement" := EnteteVente."Date chargement";
                            TamponDetailDispoStock."Date livraison demandee" := EnteteVente."Requested Delivery Date";
                            TamponDetailDispoStock."Code vendeur" := EnteteVente."Salesperson Code";
                            TamponDetailDispoStock."Proba transformation" := EnteteVente."Proba transformation";
                            TamponDetailDispoStock.Insert();
                        end;

                end;
            until LigneVente.Next() = 0;
        end;
        Commit();
        StockDispo.CalcFields("Quantite reservee");
        QteDispo := StockDispo.Stock - StockDispo."Quantite reservee";
        if QteDispo < 0 then
            QteDispo := 0;
        StockDispo."Stock dispo" := QteDispo;
        StockDispo.Modify();

        if Afficher then
            page.Run(Page::StockDispoArticle, StockDispo);

    end;
    /*FHA
    procedure ListerQtePriseSurStock(pNumLigneParent: Integer)
    //Fonction qui va calculer combien de pieces de l'article vont etre prises sur stock et en stocker le détail dans une table "Tampon".
    //Cette fonction est appelée lorsque sur un devis ou une commande on demande à voir le stock dispo de chaque article du document.
    //Pour cela, on va déduire de la qté sur commande vente les quantités achetées et affectées aux ventes.
    //Exemple : pour l'article A1, j'ai deux commandes ventes, une de 10 et une de 20
    //Pour la première commande, j'ai une affectation (achats affectés à cette commande) de 6 pièces. Cela veut donc dire qu'à ce stade, je prévois d'en prendre (10-6)=4 pieces 
    //en stock.
    //Pour la 2e commande, je n'ai pas d'affectation du tout (pas d'achats affectés à cette commande). Cela veut donc dire que je prévois de tout prendre sur stock.
    //Au final, pour cet article, la quantité prise sur stock pour cet article est 20 + 4 = 24 pièces.
    var
        LigneVente: Record "Sales Line";
        AffectationsAchat: Record "Affectations achat vente";
        TamponDetailDispoStock: Record TamponDetailDispoStock;
        decQtePriseSurStockCetteLigne: Decimal;
        NumLigne: Integer;
        CodeUtil: Text[50];
    begin
        if pNumLigneParent = 0 then
            NumLigneParent := 10000
        else
            NumLigneParent := pNumLigneParent + 10000;

        NumLigne := 1;
        CodeUtil := CopyStr(UserId, 1, 50);
        LigneVente.SetCurrentKey("Document Type", Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Shipment Date");
        LigneVente.SetRange("Document Type", LigneVente."Document Type"::Quote, LigneVente."Document Type"::Order);
        LigneVente.SetRange(Type, LigneVente.Type::Item);
        LigneVente.SetRange("No.", Rec."No.");

        if LigneVente.FindSet(false) then begin
            AffectationsAchat.SetCurrentKey("Type document vente", "No. document vente", "No. ligne document vente");
            AffectationsAchat.SetRange("Type document vente", AffectationsAchat."Type document vente"::Devis, AffectationsAchat."Type document vente"::Commande);
            repeat
                if LigneVente."Pris sur stock" then begin
                    TamponDetailDispoStock.Init();
                    TamponDetailDispoStock."Code utilisateur" := CodeUtil;
                    TamponDetailDispoStock."No. article" := Rec."No.";
                    TamponDetailDispoStock."No. document" := LigneVente."Document No.";
                    TamponDetailDispoStock."No. ligne" := LigneVente."Line No.";
                    //TamponDetailDispoStock."No. ligne parent" := NumLigneParent;
                    TamponDetailDispoStock."No. ligne" := NumLigne;
                    NumLigne := NumLigne + 1;
                    TamponDetailDispoStock."Quantite reservee" := LigneVente."Outstanding Quantity";
                    TamponDetailDispoStock.Insert();
                end else begin
                    //Si on a des achats affectés à la ligne de commande, c'est qu'on ne prend pas tout en stock, il faut déduire les quantités achetées
                    AffectationsAchat.SetRange("No. document vente", LigneVente."Document No.");
                    AffectationsAchat.SetRange("No. ligne document vente", LigneVente."Line No.");
                    if AffectationsAchat.FindSet(false) then begin
                        decQtePriseSurStockCetteLigne := LigneVente."Outstanding Qty. (Base)";
                        repeat
                            AffectationsAchat.CalcFields("Qte achetee", "Qte recue");
                            decQtePriseSurStockCetteLigne := decQtePriseSurStockCetteLigne - (AffectationsAchat."Qte achetee" - AffectationsAchat."Qte recue");
                        until AffectationsAchat.Next() = 0;
                        if decQtePriseSurStockCetteLigne > 0 then begin
                            TamponDetailDispoStock.Init();
                            TamponDetailDispoStock."Code utilisateur" := CodeUtil;
                            TamponDetailDispoStock."No. article" := Rec."No.";
                            TamponDetailDispoStock."No. document" := LigneVente."Document No.";
                            //TamponDetailDispoStock."No. ligne parent" := NumLigneParent;
                            TamponDetailDispoStock."No. ligne" := NumLigne;
                            NumLigne := NumLigne + 1;
                            TamponDetailDispoStock."Quantite reservee" := decQtePriseSurStockCetteLigne;
                            TamponDetailDispoStock.Insert();
                        end;
                    end else
                        if (LigneVente."Document Type" = LigneVente."Document Type"::Quote) and (LigneVente.Quantity <> 0) then begin 
                            //Si on arrive ici,
                            //On sait qu'on ne prend pas tout sur stock et qu'on n'a pas affecté d'achats,
                            //il faut alors décompter la ligne en [Quantité sur devis]
                            TamponDetailDispoStock.Init();
                            TamponDetailDispoStock."Code utilisateur" := CodeUtil;
                            TamponDetailDispoStock."No. article" := Rec."No.";
                            TamponDetailDispoStock."No. document" := LigneVente."Document No.";
                            //TamponDetailDispoStock."No. ligne parent" := NumLigneParent;
                            TamponDetailDispoStock."No. ligne" := NumLigne;
                            NumLigne := NumLigne + 1;
                            TamponDetailDispoStock."Quantite sur devis" := LigneVente."Quantity (Base)";
                            TamponDetailDispoStock.Insert();
                        end;
                    ;
                end;
            until LigneVente.Next() = 0;
        end;
    end;
    */
    procedure PrixAchatActuel(pNumFns: Code[20]): Decimal
    var
        PrixAchat: Record "Purchase Price";
    begin
        if pNumFns = '' then
            exit(0);

        PrixAchat.SetRange("Item No.", Rec."No.");
        PrixAchat.SetRange("Vendor No.", pNumFns);
        PrixAchat.SetFilter("Starting Date", '%1|<=%2', 0D, TODAY);
        PrixAchat.SetFilter("Ending Date", '%1|>=%2', 0D, TODAY);
        if PrixAchat.FindFirst() then
            exit(PrixAchat."Direct Unit Cost")
        else
            exit(0);
    end;

    procedure PrixVenteActuel(pNumClt: Code[20]): Decimal
    var
        PrixVente: Record "Sales Price";
        Client: Record Customer;
    begin
        if pNumClt = '' then
            exit(0);

        PrixVente.SetRange("Item No.", Rec."No.");
        PrixVente.SetFilter("Starting Date", '%1|<=%2', 0D, TODAY);
        PrixVente.SetFilter("Ending Date", '%1|>=%2', 0D, TODAY);
        PrixVente.SetRange("Sales Type", PrixVente."Sales Type"::Customer);
        PrixVente.SetRange("Sales Code", pNumClt);
        if PrixVente.FindFirst() then
            exit(PrixVente."Unit Price")
        else begin
            Client.Get(pNumClt);
            if Client."Customer Price Group" <> '' then begin
                PrixVente.SetRange("Sales Type", PrixVente."Sales Type"::"Customer Price Group");
                PrixVente.SetRange("Sales Code", Client."Customer Price Group");
                if PrixVente.FindFirst() then
                    exit(PrixVente."Unit Price")
                else
                    exit(0);
            end else
                exit(0);
        end;
        exit(0);
    end;

    var
        ParamCodifab: Record "Parametrage articles Codifab";
}

