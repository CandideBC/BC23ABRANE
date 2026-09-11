table 50023 "Affectations achat vente"
{
    Caption = 'Affectations achat vente';
    DrillDownPageID = "Affectations achat vente";
    Permissions = TableData "Sales Invoice Line" = rm;

    fields
    {
        field(10; "No. document achat"; Code[20])
        {
            Caption = 'N° commande achat';
            TableRelation = "Purchase Header"."No." where ("Document Type" = const (Order));

            trigger OnLookup()
            begin
                EnteteAchat.Reset();

                EnteteAchat.SetRange("Document Type", EnteteAchat."Document Type"::Order);

                if PAGE.RunModal(PAGE::"Purchase Order List", EnteteAchat) = ACTION::LookupOK then begin
                    "No. document achat" := EnteteAchat."No.";
                    if "No. document achat" <> xRec."No. document achat" then
                        Validate("No. ligne document achat", 0);
                end;
            end;
        }
        field(20; "No. ligne document achat"; Integer)
        {
            Caption = 'N° ligne document achat';
            TableRelation = "Purchase Line"."Line No." where ("Document Type" = const (Order),
                                                              "Document No." = field ("No. document achat"));
        }
        field(21; "No. article achete"; Code[20])
        {
            CalcFormula = lookup ("Purchase Line"."No." where ("Document Type" = const (Order),
                                                              "Document No." = field ("No. document achat"),
                                                              "Line No." = field ("No. ligne document achat")));
            Caption = 'N° article acheté';
            Editable = false;
            FieldClass = FlowField;
        }
        field(22; "Description article achete"; Text[100])
        {
            Caption = 'Description article acheté';
            Editable = false;
        }
        field(23; "Qte achetee"; Decimal)
        {
            CalcFormula = lookup ("Purchase Line".Quantity where ("Document Type" = const (Order),
                                                                 "Document No." = field ("No. document achat"),
                                                                 "Line No." = field ("No. ligne document achat")));
            Caption = 'Qté achetée';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(24; "Qte recue"; Decimal)
        {
            CalcFormula = lookup ("Purchase Line"."Qty. Received (Base)" where ("Document Type" = const (Order),
                                                                               "Document No." = field ("No. document achat"),
                                                                               "Line No." = field ("No. ligne document achat")));
            Caption = 'Qté reçue';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(25; "Date reception prevue"; Date)
        {
            CalcFormula = lookup ("Purchase Line"."Expected Receipt Date" where ("Document Type" = const (Order),
                                                                                "Document No." = field ("No. document achat"),
                                                                                "Line No." = field ("No. ligne document achat")));
            Caption = 'Date réception prévue';
            Editable = false;
            FieldClass = FlowField;
        }
        field(28; "No. donneur ordre"; Code[20])
        {
            Caption = 'N° donneur ordre';
            TableRelation = Customer;

            trigger OnValidate()
            begin
                CalcFields("Nom donneur ordre");
            end;
        }
        field(29; "Nom donneur ordre"; Text[100])
        {
            CalcFormula = lookup (Customer.Name where ("No." = field ("No. donneur ordre")));
            Caption = 'Nom donneur d''ordre';
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Type document vente"; Option)
        {
            Caption = 'Type document vente';
            OptionCaption = 'Devis,Commande,Facture enregistrée,Avoir enregistré';
            OptionMembers = Devis,"Commande","Facture enregistrée","Avoir enregistré";

            trigger OnValidate()
            begin
                if "Type document vente" <> xRec."Type document vente" then begin
                    "No. document vente" := '';
                    Validate("No. ligne document vente", 0);
                    "Quantite affectee" := 0;
                end;
            end;
        }
        field(40; "No. document vente"; Code[20])
        {
            Caption = 'N° document vente';
            TableRelation = if ("Type document vente" = const (Commande)) "Sales Header"."No." where ("Document Type" = const (Order))
            else
            if ("Type document vente" = const (Devis)) "Sales Header"."No." where ("Document Type" = const (Quote))
            else
            if ("Type document vente" = const ("Facture enregistrée")) "Sales Invoice Header"."No."
            else
            if ("Type document vente" = const ("Avoir enregistré")) "Sales Cr.Memo Header"."No.";

            trigger OnLookup()
            begin
                if "Type document vente" in ["Type document vente"::Devis, "Type document vente"::Commande] then begin
                    EnteteVente.Reset();
                    if "No. donneur ordre" <> '' then begin
                        EnteteVente.SetCurrentKey("Document Type", "Sell-to Customer No.");
                        EnteteVente.SetRange("Sell-to Customer No.", "No. donneur ordre");
                    end;

                    EnteteVente.SetRange("Document Type", "Type document vente");

                    if PAGE.RunModal(PAGE::"Sales List", EnteteVente) = ACTION::LookupOK then begin
                        "No. document vente" := EnteteVente."No.";
                        if "No. document vente" <> xRec."No. document vente" then
                            Validate("No. ligne document vente", 0);
                    end;
                end else
                    if "Type document vente" = "Type document vente"::"Facture enregistrée" then begin
                        EnteteFactVente.Reset();
                        if "No. donneur ordre" <> '' then begin
                            EnteteFactVente.SetCurrentKey("Sell-to Customer No.");
                            EnteteFactVente.SetRange("Sell-to Customer No.", "No. donneur ordre");
                        end;

                        if PAGE.RunModal(PAGE::"Posted Sales Invoices", EnteteFactVente) = ACTION::LookupOK then begin
                            "No. document vente" := EnteteFactVente."No.";
                            if "No. document vente" <> xRec."No. document vente" then
                                Validate("No. ligne document vente", 0);
                        end;
                    end;
            end;

            trigger OnValidate()
            var
                LigneExiste: Boolean;
            begin
                //KAN.FHA 18/11/2020 DEBUT
                if "No. document vente" <> xRec."No. document vente" then begin
                    "No. ligne document vente" := 0;
                    "Quantite affectee" := 0;
                    case "Type document vente" of
                        "Type document vente"::Devis, "Type document vente"::Commande:
                            LigneExiste := (LigneVente.Get("Type document vente", xRec."No. document vente", xRec."No. ligne document vente"));
                        "Type document vente"::"Facture enregistrée":
                            LigneExiste := (LigneFactureVente.Get(xRec."No. document vente", xRec."No. ligne document vente"));
                    end;

                    if LigneExiste then
                        MAJCoutLigneVente("Type document vente", xRec."No. document vente", xRec."No. ligne document vente");
                end;
                //KAN.FHA 18/11/2020 FIN
            end;
        }
        field(50; "No. ligne document vente"; Integer)
        {
            Caption = 'N° ligne document vente';
            TableRelation = if ("Type document vente" = const (Commande)) "Sales Line"."Line No." where ("Document Type" = const (Order),
                                                                                                   "Document No." = field ("No. document vente"),
                                                                                                   Type = const (Item));

            trigger OnLookup()
            var
                ArticleAchete: Record Item;
                AffecterADiversUniquement: Boolean;

            begin
                if "No. document vente" = '' then
                    exit;

                case "Type document vente" of
                    "Type document vente"::Devis, "Type document vente"::Commande:
                        begin
                            LigneVente.Reset();
                            LigneVente.SetRange("Document Type", "Type document vente");
                            LigneVente.SetRange("Document No.", "No. document vente");
                            LigneVente.SetRange(Type, LigneVente.Type::Item);
                            //KAN.FHA 22/06/2023 DEBUT
                            //LigneVente.SETRANGE("Article divers",TRUE);
                            //Remplacé par :
                            if LigneAchat.Get(LigneAchat."Document Type"::Order, "No. document achat", "No. ligne document achat") then
                                if LigneAchat.Type = LigneAchat.Type::"G/L Account" then
                                    AffecterADiversUniquement := false
                                else
                                    if ArticleAchete.Get(LigneAchat."No.") then
                                        AffecterADiversUniquement := ArticleAchete."Miscellaneous Item";
                            
                            //KAN.FHA 22/06/2023 FIN
                            if PAGE.RunModal(PAGE::"Sales Lines", LigneVente) = ACTION::LookupOK then begin
                                TestField("No. document vente", LigneVente."Document No.");
                                Validate("No. ligne document vente", LigneVente."Line No.");
                            end;
                        end;
                    "Type document vente"::"Facture enregistrée":
                        begin
                            LigneFactureVente.Reset();
                            LigneFactureVente.SetRange("Document No.", "No. document vente");
                            LigneFactureVente.SetRange(Type, LigneFactureVente.Type::Item);
                            LigneFactureVente.SetRange("Article divers", true);
                            if PAGE.RunModal(PAGE::"Posted Sales Invoice Lines", LigneFactureVente) = ACTION::LookupOK then begin
                                TestField("No. document vente", LigneFactureVente."Document No.");
                                Validate("No. ligne document vente", LigneFactureVente."Line No.");
                            end;

                        end;
                    "Type document vente"::"Avoir enregistré":
                        begin
                        end;
                end;
            end;

            trigger OnValidate()
            var
                LigneExiste: Boolean;
            begin
                case "Type document vente" of
                    "Type document vente"::Devis, "Type document vente"::Commande:
                        LigneExiste := (LigneVente.Get("Type document vente", "No. document vente", xRec."No. ligne document vente"));
                    "Type document vente"::"Facture enregistrée":
                        LigneExiste := (LigneFactureVente.Get("No. document vente", xRec."No. ligne document vente"));
                end;

                if ("No. ligne document vente" <> xRec."No. ligne document vente") and LigneExiste then
                    MAJCoutLigneVente("Type document vente", "No. document vente", xRec."No. ligne document vente");
            end;
        }
        field(60; "Quantite affectee"; Decimal)
        {
            Caption = 'Quantité affectée';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                //KAN.FHA 18/11/2020
                TestField("No. document vente");
                TestField("No. ligne document vente");
                CalcFields("Qte achetee", "Quantite affectee totale");
                if ("Quantite affectee totale" - xRec."Quantite affectee" + "Quantite affectee") > "Qte achetee" then
                    Error(QteAffecteeTropGrandeErr);
                //KAN.FHA 18/11/2020
                LigneAchat.Get(LigneAchat."Document Type"::Order, "No. document achat", "No. ligne document achat");
                Validate("Cout unitaire (DS)", LigneAchat."Unit Cost (LCY)");
            end;
        }
        field(65; "Quantite affectee totale"; Decimal)
        {
            CalcFormula = sum ("Affectations achat vente"."Quantite affectee" where ("No. document achat" = field ("No. document achat"),
                                                                                    "No. ligne document achat" = field ("No. ligne document achat")));
            Caption = 'Quantité affectée totale';
            DecimalPlaces = 0 : 5;
            Description = 'Somme des quantités affectées pour cette ligne de commande d''achat';
            Editable = false;
            FieldClass = FlowField;

            /*
            trigger OnValidate()
            begin
                //KAN.FHA 18/11/2020
                TestField("No. document vente");
                TestField("No. ligne document vente");
                CalcFields("Qte achetee");
                if "Quantite affectee" > "Qte achetee" then
                    Error(QteAffecteeTropGrandeErr);
                //KAN.FHA 18/11/2020
                LigneAchat.Get(LigneAchat."Document Type"::Order, "No. document achat", "No. ligne document achat");
                Validate("Cout unitaire (DS)", LigneAchat."Unit Cost (LCY)");
            end;
            */
        }
        field(70; "Nombre receptions"; Integer)
        {
            BlankZero = true;
            CalcFormula = count ("Purch. Rcpt. Header" where ("Order No." = field ("No. document achat")));
            Caption = 'Nombre réceptions';
            Editable = false;
            FieldClass = FlowField;
        }
        field(120; "Code chantier"; Code[20])
        {
            Caption = 'Code chantier';
        }
        field(130; "Cout unitaire (DS)"; Decimal)
        {
            Caption = 'Coût unitaire';
            Editable = false;

            trigger OnValidate()
            begin
                "Cout total (DS)" := Round("Quantite affectee" * "Cout unitaire (DS)", 0.01);

                MAJCoutLigneVente("Type document vente", "No. document vente", "No. ligne document vente");
            end;
        }
        field(140; "Cout total (DS)"; Decimal)
        {
            Caption = 'Coût total (DS)';
            Editable = false;
        }
        field(150; "Montant frais annexes"; Decimal)
        {
            CalcFormula = sum ("Item Charge Assignment (Purch)"."Amount to Assign" where ("Document Type" = const (Order),
                                                                                         "Applies-to Doc. No." = field ("No. document achat"),
                                                                                         "Applies-to Doc. Line No." = field ("No. ligne document achat")));
            Caption = 'Montant frais annexes';
            Editable = false;
            FieldClass = FlowField;
        }
        field(160; "Statut commande achat"; Option)
        {
            OptionCaption = 'Ouverte,Lancée,Totalement reçue';
            OptionMembers = Ouverte,"Lancée","Totalement reçue";
        }
        field(170; "Date chargement cde achat"; Date)
        {
            CalcFormula = lookup ("Purchase Header"."Date chargement confirmee" where ("No." = field ("No. document achat")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(180; "Date liv. demandee cde achat"; Date)
        {
            CalcFormula = lookup ("Purchase Header"."Requested Receipt Date" where ("No." = field ("No. document achat")));
            Caption = 'Date liv. demandée cde achat';
            Editable = false;
            FieldClass = FlowField;
        }
        field(190; "Nom fournisseur"; Text[100])
        {
            CalcFormula = lookup ("Purchase Header"."Buy-from Vendor Name" where ("No." = field ("No. document achat")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No. document achat", "No. ligne document achat", "Type document vente", "No. document vente", "No. ligne document vente")
        {
            Clustered = true;
            SumIndexFields = "Quantite affectee";
        }
        key(Key2; "Type document vente", "No. document vente", "No. ligne document vente")
        {
            SumIndexFields = "Cout total (DS)", "Quantite affectee";
        }
        key(Key3; "No. document achat", "Type document vente", "No. document vente")
        {
        }
        key(Key4; "Type document vente","No. document vente","No. document achat")
        {
            
        }
        key(Key5; "No. document achat","No. document vente")
        {
            
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        lTypeDocVente: Option Devis,Commande,"Facture enregistrée","Avoir enregistré";
    begin
        if "Statut commande achat" = "Statut commande achat"::"Totalement reçue" then
            Error(SupprImpossibleErr);

        if "No. ligne document achat" <> 0 then
            if not LigneAchat.Get(LigneAchat."Document Type"::Order, "No. document achat", "No. ligne document achat") then
                Error(SupprImpossibleErr); //La commande a été entièrement facturée

        if LigneAchat."Quantity Received" <> 0 then
            Error(SupprImpossibleErr);

        if "No. ligne document vente" <> 0 then begin
            lTypeDocVente := "Type document vente";
            //lNumDocVente := "No. document vente";
            //lNumLigneDoc := "No. ligne document vente";
            "Cout total (DS)" := 0;
            MAJCoutLigneVente("Type document vente", "No. document vente", "No. ligne document vente");
        end;
    end;

    trigger OnInsert()
    begin
        MAJStatutCdeAchat();

        if GetFilter("No. document vente") <> '' then
            if GetRangeMin("No. document vente") = GetRangeMax("No. document vente") then
                "No. document vente" := GetRangeMin("No. document vente");

        if GetFilter("No. ligne document vente") <> '' then
            if GetRangeMin("No. ligne document vente") = GetRangeMax("No. ligne document vente") then
                "No. ligne document vente" := GetRangeMin("No. ligne document vente");
    end;

    trigger OnModify()
    begin
        MAJStatutCdeAchat();
    end;

    var
        LigneAchat: Record "Purchase Line";
        LigneVente: Record "Sales Line";
        EnteteVente: Record "Sales Header";
        LienAchatVente: Record "Affectations achat vente";
        EnteteAchat: Record "Purchase Header";
        EnteteFactVente: Record "Sales Invoice Header";
        LigneFactureVente: Record "Sales Invoice Line";
        TotalAchatsPourLigneVente: Decimal;
        SupprImpossibleErr: Label 'Il n''est pas possible de supprimer l''affectation d''une commande d''achat qui a été réceptionnée.';


        QteAffecteeTropGrandeErr: Label 'Vous ne pouvez pas affecter plus que ce qui a été acheté.';

    procedure MAJCoutLigneVente(pTypeDocument: Integer; pNumDocument: Code[20]; pNumLigneDoc: Integer)
    var
        CurrExchRate: Record "Currency Exchange Rate";
        LigneVenteSansQteErr: Label 'Vous ne pouvez pas affecter un achat à une ligne de vente sans quantité.';
    begin
        if pTypeDocument < 2 then begin //Devis ou commande
            if LigneVente.Get(pTypeDocument, pNumDocument, pNumLigneDoc) then begin
                if not LigneVente."Article divers" then
                    exit;

                if LigneVente.Quantity <> 0 then begin
                    //On ne peut pas utiliser le FlowField car il n'est pas encore à jour à ce stade.
                    //Pour éviter un COMMIT, je préfère totaliser "à la main"
                    //LigneVente.CALCFIELDS("Cout achats affectes");

                    LienAchatVente.Reset();
                    LienAchatVente.SetCurrentKey("Type document vente", "No. document vente", "No. ligne document vente");
                    LienAchatVente.SetRange("Type document vente", pTypeDocument);
                    LienAchatVente.SetRange("No. document vente", pNumDocument);
                    LienAchatVente.SetRange("No. ligne document vente", pNumLigneDoc);
                    if LienAchatVente.FindSet() then begin
                        TotalAchatsPourLigneVente := 0;
                        repeat
                            //On exclut la ligne courante qui n'est pas encore sauvegardée
                            if (LienAchatVente."No. document achat" <> "No. document achat") or (LienAchatVente."No. ligne document achat" <> "No. ligne document achat") then
                                TotalAchatsPourLigneVente := TotalAchatsPourLigneVente + LienAchatVente."Cout total (DS)";
                        until LienAchatVente.Next() = 0;
                    end;
                    //On ajoute la ligne courante
                    TotalAchatsPourLigneVente := TotalAchatsPourLigneVente + "Cout total (DS)";

                    LigneVente.Validate("Unit Cost (LCY)", Round(TotalAchatsPourLigneVente / LigneVente.Quantity, 0.01));
                    LigneVente."Cout unitaire force" := false;
                    LigneVente."Cout unitaire force par" := '';
                    LigneVente.Modify();
                end;
            end;
        end else
            if pTypeDocument = 2 then begin   //Facture enregistrée
                if LigneFactureVente.Get(pNumDocument, pNumLigneDoc) then begin
                    if not LigneFactureVente."Article divers" then
                        exit;

                    if LigneFactureVente.Quantity <> 0 then begin
                        LienAchatVente.Reset();
                        LienAchatVente.SetCurrentKey("Type document vente", "No. document vente", "No. ligne document vente");
                        LienAchatVente.SetRange("Type document vente", pTypeDocument);
                        LienAchatVente.SetRange("No. document vente", pNumDocument);
                        LienAchatVente.SetRange("No. ligne document vente", pNumLigneDoc);
                        if LienAchatVente.FindSet() then begin
                            TotalAchatsPourLigneVente := 0;
                            repeat
                                //On exclut la ligne courante qui n'est pas encore sauvegardée
                                if (LienAchatVente."No. document achat" <> "No. document achat") or (LienAchatVente."No. ligne document achat" <> "No. ligne document achat") then
                                    TotalAchatsPourLigneVente := TotalAchatsPourLigneVente + LienAchatVente."Cout total (DS)";
                            until LienAchatVente.Next() = 0;
                        end;
                        //On ajoute la ligne courante
                        TotalAchatsPourLigneVente := TotalAchatsPourLigneVente + "Cout total (DS)";

                        LigneFactureVente."Unit Cost (LCY)" := Round(TotalAchatsPourLigneVente / LigneFactureVente.Quantity, 0.01);
                        LigneFactureVente."Cout ligne HT (DS)" := TotalAchatsPourLigneVente;

                        EnteteFactVente.Get(LigneFactureVente."Document No.");
                        if EnteteFactVente."Currency Code" <> '' then 
                            LigneFactureVente."Unit Cost" :=
                              Round(
                                CurrExchRate.ExchangeAmtLCYToFCY(
                                  EnteteFactVente."Posting Date", EnteteFactVente."Currency Code",
                                  LigneFactureVente."Unit Cost (LCY)", EnteteFactVente."Currency Factor"),
                                0.01)
                        else
                            LigneFactureVente."Unit Cost" := LigneFactureVente."Unit Cost (LCY)";

                        LigneFactureVente."Cout unitaire force" := false;
                        LigneFactureVente."Cout unitaire force par" := '';

                        LigneFactureVente.Modify();
                    end else
                        Error(LigneVenteSansQteErr);
                end;
            end else
                if pTypeDocument = 3 then begin //Avoir enregistré
                                                //Cas non prévu pour le moment
                end;
    end;

    procedure AfficherDocumentVente()
    begin
        if "No. document vente" = '' then
            exit;

        case "Type document vente" of
            "Type document vente"::Devis, "Type document vente"::Commande:
                begin
                    EnteteVente.SetRange("Document Type", "Type document vente");
                    EnteteVente.SetRange("No.", "No. document vente");

                    case "Type document vente" of
                        "Type document vente"::Devis:
                            PAGE.Run(PAGE::"Sales Quote", EnteteVente);
                        "Type document vente"::Commande:
                            PAGE.Run(PAGE::"Sales Order", EnteteVente);
                    end;
                end;
            "Type document vente"::"Facture enregistrée":
                begin
                    EnteteFactVente.Get("No. document vente");
                    PAGE.Run(PAGE::"Posted Sales Invoice", EnteteFactVente);
                end;
        end;
    end;

    procedure MAJStatutCdeAchat()
    begin
        if ("No. document achat" = '') or ("No. ligne document achat" = 0) then begin
            "Statut commande achat" := "Statut commande achat"::Ouverte;
            exit;
        end;

        EnteteAchat.Get(EnteteAchat."Document Type"::Order, "No. document achat");
        LigneAchat.Get(LigneAchat."Document Type"::Order, "No. document achat", "No. ligne document achat");
        "Description article achete" := LigneAchat.Description;
        if (LigneAchat.Quantity <> 0) and (LigneAchat."Outstanding Quantity" = 0) then
            "Statut commande achat" := "Statut commande achat"::"Totalement reçue"
        else
            if EnteteAchat.Status = EnteteAchat.Status::Released then
                "Statut commande achat" := "Statut commande achat"::"Lancée"
            else
                "Statut commande achat" := "Statut commande achat"::Ouverte;
    end;
}

