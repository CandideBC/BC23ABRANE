tableextension 50013 SalesHeaderExtension extends "Sales Header"
{
    fields
    {
        field(50000; "Code concept"; Code[20])
        {
            Caption = 'Code concept';
            DataClassification = ToBeClassified;
            Description = 'Inutilisé';
        }
        field(50010; "No. client concept"; Code[20])
        {
            Caption = 'N° client concept';
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
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
        field(50035; "Price included Eco Tax"; Boolean)
        {
            Caption = 'Prix écotaxe compris';
            DataClassification = ToBeClassified;
            Description = 'CPT02';
        }
        field(50040; "No. And Location Name"; Text[50])
        {
            Caption = 'N° et nom magasin';
            DataClassification = ToBeClassified;
            Description = 'X01';
        }
        field(50050; "Range No."; Text[30])
        {
            Caption = 'N° rayon';
            DataClassification = ToBeClassified;
            Description = 'X01';
        }
        field(50060; Commentaire; Text[250])
        {
            Caption = 'Commentaires';
            DataClassification = ToBeClassified;
            Description = 'X01';

            trigger OnValidate()
            begin
                //KAN.FHA 14/12/2022 DEBUT
                //On utilise ce champ pour nommer un PDF et cela ne fonctionne si on a un slash ou un antislash dans la valeur
                Commentaire := CONVERTSTR(Commentaire, '/\', '  ');
            end;
        }
        field(50065; "Commentaires dossier BE"; Blob)
        {
            Caption = 'Commentaires dossier BE';
            DataClassification = ToBeClassified;

        }
        field(50066; "Commentaires prepa"; Blob)
        {
            Caption = 'Commentaires prépa';
            DataClassification = ToBeClassified;

        }
        field(50070; "Acompte verse (Montant)"; Decimal)
        {
            Caption = 'Acompte versé (Montant)';
            DataClassification = ToBeClassified;
            Description = 'X01';

            trigger OnValidate()
            begin
                //DIA£NBE 13/04/2015 DEBUT
                if "Acompte verse (Montant)" <> 0 then
                    TESTFIELD("Acompte a deduire (HT)", 0);
                //DIA£NBE 13/04/2015 FIN
            end;
        }
        field(50072; "Acompte a deduire (HT)"; Decimal)
        {
            Caption = 'Acompte à déduire (HT)';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //DIA£NBE 13/04/2015 DEBUT
                TESTFIELD(Status, Status::Open);
                if "Acompte a deduire (HT)" <> 0 then
                    TESTFIELD("Acompte verse (Montant)", 0);
                //DIA£NBE 13/04/2015 FIN
            end;
        }
        field(50080; Factoring; Boolean)
        {
            Caption = 'Affacturage';
            DataClassification = ToBeClassified;
            Description = 'X01';
        }
        field(50090; "Nombre de colis"; Decimal)
        {
            Caption = 'Nombre de colis';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
        }
        field(50091; "Nombre de palettes"; Decimal)
        {
            Caption = 'Nombre de palettes';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
        }
        field(50100; ASS; Boolean)
        {
            Caption = 'SAV';
            DataClassification = ToBeClassified;
        }

        field(50120; "Amount included Ecotax"; Decimal)
        {
            BlankZero = true;

            FieldClass = FlowField;
            CalcFormula = sum("Sales Line".Amount where("Document No." = field("No."), "Document Type" = field("Document Type"), "Price included Eco Tax" = const(true), "Eco Tax Furniture Line" = const(true)));
            Caption = 'Montant écotaxe inclus';
            Description = 'CPTO2';
            Editable = false;

        }
        field(50122; "Montant eco-taxe"; Decimal)
        {
            BlankZero = true;

            FieldClass = FlowField;
            CalcFormula = sum("Sales Line".Amount where("Document No." = field("No."), "Document Type" = field("Document Type"), "Eco Tax Furniture Line" = const(true)));
            Caption = 'Montant écotaxe';
            Description = 'FHA 28/04/2025';
            Editable = false;

        }
        field(50124; "Facture situation"; Boolean)
        {
            Caption = 'Facture situation';
            DataClassification = ToBeClassified;
            Description = 'KAN';
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
        field(50160; "At least One Ship"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Sales Line" where("Document Type" = field("Document Type"), "Document No." = field("No."), Type = filter(<> ' '), "No." = filter(<> ''), "Quantity Shipped" = filter(<> 0)));
            Caption = 'Au moins une expédition';
            Description = 'P21';
            Editable = false;
        }
        field(50165; "Necessite Fiche BE"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Sales Line" where("Document Type" = field("Document Type"), "Document No." = field("No."), "Type fiche BE" = filter(> 1), Quantity = filter(> 0)));
            Editable = false;
        }
        field(50166; "No. dossier BE"; Code[20])
        {
            Caption = 'N° dossier BE';
            TableRelation = "Dossier BE";
            Editable = false;
        }
        field(50170; "Return Reason Code"; Code[10])
        {
            Caption = 'Code motif SAV';
            DataClassification = ToBeClassified;
            TableRelation = "Return Reason";

            trigger OnValidate()
            var
                Text50001Qst: Label 'Voulez-vous mettre à jour ce code sur les lignes ?';
            begin
                //DIA£LBO 20/02/2017
                SalesLine.RESET();
                SalesLine.SETRANGE("Document Type", "Document Type");
                SalesLine.SETRANGE("Document No.", "No.");
                if SalesLine.FINDset(true) then
                    if CONFIRM(Text50001Qst) then
                        SalesLine.MODIFYALL("Return Reason Code", "Return Reason Code", false);

                //DIA£LBO 20/02/2017//
            end;
        }
        field(50180; "Annee commande"; Integer)
        {
            Caption = 'Année commande';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 17/11/2022 Pour pouvoir filtrer le montant des cdes en cours par année sur les enseignes, groupes clients et chantiers';

            trigger OnValidate()
            var
                ParamUtil: Record "User Setup";
            begin
                if not ParamUtil.GET(USERID) then
                    ParamUtil.INIT();

                ParamUtil.TESTFIELD("Modifier annee commande");

                SalesLine.RESET();
                SalesLine.SETRANGE("Document Type", "Document Type");
                SalesLine.SETRANGE("Document No.", "No.");
                if SalesLine.FINDSET(true) then
                    SalesLine.MODIFYALL("Annee commande", "Annee commande");

            end;
        }

        field(50184; "Phase"; Code[20])
        {
            Caption = 'Phase';
            DataClassification = ToBeClassified;
        }

        field(50190; "Code groupe"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            Editable = false;
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
            Editable = false;
            TableRelation = Enseigne;
            trigger OnValidate()
            var
                Enseigne: Record Enseigne;
                Chantier: Record Chantier;
                PhasesEnseigne: Record "Phases enseigne";
                PhasesDocument: Record "Phases document";
                intTypeDoc: Integer;

            begin
                //KAN.FHA 06/07/2020
                if "Code enseigne" = xRec."Code enseigne" then
                    exit;

                if Enseigne.GET("Code enseigne") then begin
                    "Code groupe" := Enseigne."Code groupe";
                    //KAN.FHA 12/03/2021 DEBUT
                    if Enseigne."Enseigne interne" then
                        "Code chantier" := Enseigne.ChantierAnnuel("Posting Date");
                    //KAN.FHA 12/03/2021 FIN
                    //KAN.FHA 28/08/2025 DEBUT
                    if Rec."Document Type" in [Rec."Document Type"::Quote, Rec."Document Type"::Order] then begin
                        PhasesEnseigne.SetRange("Code enseigne", Rec."Code enseigne");

                        if PhasesEnseigne.FindSet(false) then begin
                            if Rec."Document Type" = Rec."Document Type"::Quote then
                                intTypeDoc := 0
                            else
                                intTypeDoc := 1;

                            repeat
                                if not PhasesDocument.get(intTypeDoc, Rec."No.", PhasesEnseigne.Phase) then begin
                                    PhasesDocument.Init();
                                    PhasesDocument."Type document" := intTypeDoc;
                                    PhasesDocument."No. document" := Rec."No.";
                                    PhasesDocument.Phase := PhasesEnseigne.Phase;
                                    PhasesDocument.Insert();
                                end;
                                PhasesDocument.Description := PhasesEnseigne.Description;
                                PhasesDocument.Modify();
                            until PhasesEnseigne.Next() = 0;
                        end;

                    end;
                    //KAN.FHA 28/08/2025 FIN
                    if "Code chantier" <> '' then begin
                        Chantier.GET("Code chantier");
                        if Chantier."Code enseigne" <> "Code enseigne" then
                            VALIDATE("Code chantier", '');

                    end else
                        VALIDATE("Code chantier", '');

                    //KAN.FHA 27/10/2025 DEBUT
                    if Rec."Document Type" in ["Document Type"::Quote, "Document Type"::Order] then begin
                        PhasesDocument.SetRange("Type document", PhasesDocument."Type document");
                        PhasesDocument.SetRange("No. document", "No.");
                        if PhasesDocument.FindSet(true) then
                            repeat
                                PhasesDocument."Code enseigne" := "Code enseigne";
                                PhasesDocument.Modify();
                            until PhasesDocument.Next() = 0;
                    end;
                    //KAN.FHA 27/10/2025 FIN
                end;
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
                if "Code operation" = xRec."Code operation" then
                    exit;
                Rec.MAJLigneChampsAffaire();
            end;
        }
        field(50220; "Code chantier"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';

            TableRelation = Chantier.Code where("Chantier archive" = const(false));
            trigger OnValidate()
            var
                Chantier: record Chantier;
                PhasesDocument: Record "Phases document";
            begin
                if CurrFieldNo = Rec.Fieldno("Code chantier") then
                    if "Code chantier" <> '' then
                        TESTFIELD("Devis Stock", false)
                    else
                        TESTFIELD("Devis Stock", true);

                if "Code chantier" = xRec."Code chantier" then
                    exit;

                if Chantier.GET("Code chantier") then begin
                    Chantier.TESTFIELD(Cloture, false);
                    VALIDATE("Code enseigne", Chantier."Code enseigne");
                    if ("Document Type" = "Document Type"::Quote) and (Chantier."Statut chantier" in [Chantier."Statut chantier"::Création, Chantier."Statut chantier"::Terminé]) then begin
                        Chantier."Statut chantier" := Chantier."Statut chantier"::Devis;
                        Chantier.MODIFY();
                    end;
                    //KAN.FHA 27/10/2025 DEBUT
                    if Rec."Document Type" in ["Document Type"::Quote, "Document Type"::Order] then begin
                        PhasesDocument.SetRange("Type document", rec."Document Type");
                        PhasesDocument.SetRange("No. document", "No.");
                        if PhasesDocument.FindSet(true) then
                            repeat
                                PhasesDocument."Code chantier" := "Code chantier";
                                PhasesDocument.Modify();
                            until PhasesDocument.Next() = 0;
                    end;
                    //KAN.FHA 27/10/2025 FIN
                end else begin
                    "Code groupe" := '';
                    "Code enseigne" := '';
                    "Code operation" := '';
                end;

                MAJLigneChampsAffaire();
            end;
        }
        field(50222; "Devis Stock"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            trigger OnValidate()
            var
                ParamUtil: record "User Setup";
                CodeEnseigne: Code[20];
                MAJChampNonAutoriseeErr: Label 'Vous n''êtes pas autorisé à modifier ce champ.';
            begin
                if not ParamUtil.GET(USERID) then
                    ParamUtil.INIT();

                if not ParamUtil."Gerer case a cocher Stock" then
                    ERROR(MAJChampNonAutoriseeErr);

                if "Devis Stock" then begin
                    CodeEnseigne := "Code enseigne";
                    VALIDATE("Code chantier", '');
                    VALIDATE("Code enseigne", CodeEnseigne);
                end;
            end;
        }
        field(50225; "Acompte a creer"; Boolean)
        {
            Caption = 'Acompte à créer';
            DataClassification = ToBeClassified;
            Description = 'KAN';
        }
        field(50227; "Code cond. paiement acomptes"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = "Payment Terms";
            trigger OnValidate()
            var
                ParamUtil: Record "User Setup";
                PasAutoriseErr: Label 'Vous n''êtes pas autorisé(e) à modifier ce champ.';
            begin
                if not (rec."Document Type" in [Rec."Document Type"::Quote, Rec."Document Type"::Order]) then
                    exit;

                if CurrFieldNo = Rec.FieldNo("Code cond. paiement acomptes") then begin
                    if not ParamUtil.get(UserId) then
                        ParamUtil.Init();
                    if not ParamUtil."MAJ Cond. pmnt/Devis+Cde" then
                        error(PasAutoriseErr);
                end;
            end;
        }
        field(50230; "% acompte demande"; Decimal)
        {
            Caption = '% acompte demandé';
            DataClassification = ToBeClassified;
            Description = 'KAN';
            MinValue = 0;
            MaxValue = 100;
            DecimalPlaces = 0 : 2;
        }
        field(50240; "Facture acompte"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
        }
        field(50250; "Acompte pour type doc."; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            OptionMembers = Devis,Commande;
        }
        field(50260; "Acompte pour No. document"; Code[20])
        {
            Caption = 'Acompte pour N° document';
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = if ("Acompte pour type doc." = const(Devis)) "Sales Header"."No." where("Document Type" = const(Quote), "Bill-to Customer No." = field("Bill-to Customer No.")) else
            if ("Acompte pour type doc." = const(Commande)) "Sales Header"."No." where("Document Type" = const(Order), "Bill-to Customer No." = field("Bill-to Customer No."));
        }
        field(50261; "Situation a creer"; Boolean)
        {
            Caption = 'Situation à créer';
            DataClassification = ToBeClassified;
            Description = 'KAN';
        }
        field(50262; "Fact. situation : type doc."; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            OptionMembers = Devis,Commande;
        }
        field(50263; "Fact. situation : No. document"; Code[20])
        {
            Caption = 'Acompte pour N° document';
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = if ("Acompte pour type doc." = const(Devis)) "Sales Header"."No." where("Document Type" = const(Quote), "Bill-to Customer No." = field("Bill-to Customer No.")) else
            if ("Acompte pour type doc." = const(Commande)) "Sales Header"."No." where("Document Type" = const(Order), "Bill-to Customer No." = field("Bill-to Customer No."));
        }
        field(50265; "Fact. situation creee"; Boolean)
        {
            Caption = 'Fact. situation créée';
            DataClassification = ToBeClassified;
        }
        field(50266; "Demander situ. a la compta"; Boolean)
        {
            Caption = 'Demander situ. à la compta';
            DataClassification = ToBeClassified;
            Description = 'Champ qui permet d''avoir un compteur des situations à créer coté compta';
            Editable = false; //Le champ se met à jour automatiquement (il passe à Oui qd la date du jour atteint la valeur de [Creer facture situation le])
        }

        field(50270; "No. facture acompte"; Code[20])
        {
            Caption = 'N° facture acompte';
            DataClassification = ToBeClassified;
            Description = 'KAN';

            Editable = false;
            TableRelation = "Sales Header"."No." where("Document Type" = const(Invoice), "Bill-to Customer No." = field("Bill-to Customer No."));
            trigger OnLookup()
            var
                EnteteAcompte: Record "Sales Header";
            begin
                if "No. facture acompte" <> '' then begin
                    EnteteAcompte.GET(EnteteAcompte."Document Type"::Invoice, "No. facture acompte");
                    Page.Run(page::"Sales Invoice", EnteteAcompte);
                end;
            end;
        }
        field(50271; "No. facture acompte enregistre"; Code[20])
        {
            Caption = 'N° facture acompte enregistré';
            DataClassification = ToBeClassified;
            Description = 'KAN';
            Editable = false;
            TableRelation = "Sales Invoice Header" where("Bill-to Customer No." = field("Bill-to Customer No."));
        }
        field(50274; "Creer facture situation le"; Date)
        {
            Caption = 'Créer facture situation le';
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            var
                FactSituationDejaCreeErr: Label 'Une facture de situation a déjà été créée, vous ne pouvez plus changer la valeur de ce champ.';

            begin
                if (rec."No. facture situation" <> '') or (rec."No. facture situat. enregistre" <> '') then
                    error(FactSituationDejaCreeErr);
            end;
        }
        field(50275; "% acompte situation demande"; Decimal)
        {
            Caption = '% acompte (situation) demandé';
            DataClassification = ToBeClassified;
            Description = 'KAN';
            MinValue = 0;
            MaxValue = 100;
            DecimalPlaces = 0 : 2;

            trigger OnValidate()
            var
                ParamVente: Record "Sales & Receivables Setup";
            begin
                if "% acompte situation demande" = 0 then begin
                    "Creer facture situation le" := 0D;
                    "Situation a creer" := false;
                    "Demander situ. a la compta" := false;
                    exit;
                end;

                if "Date chargement" = 0D then
                    exit;

                ParamVente.Get();
                ParamVente.TestField("Delai creation fact. situ");
                "Creer facture situation le" := CalcDate(ParamVente."Delai creation fact. situ", "Date chargement");
                "Situation a creer" := true;
            end;
        }
        field(50276; "Code cond. paiement situation"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = "Payment Terms";
            trigger OnValidate()
            var
                ParamUtil: Record "User Setup";
                PasAutoriseErr: Label 'Vous n''êtes pas autorisé(e) à modifier ce champ.';
            begin
                if not (rec."Document Type" in [Rec."Document Type"::Quote, Rec."Document Type"::Order]) then
                    exit;

                if CurrFieldNo = Rec.FieldNo("Code cond. paiement situation") then begin
                    if not ParamUtil.get(UserId) then
                        ParamUtil.Init();
                    if not ParamUtil."MAJ Cond. pmnt/Devis+Cde" then
                        error(PasAutoriseErr);
                end;
            end;
        }
        field(50280; "No. facture situation"; Code[20])
        {
            Caption = 'N° facture situation';
            DataClassification = ToBeClassified;
            Description = 'KAN';
            Editable = false;
            TableRelation = "Sales Header"."No." where("Document Type" = const(Invoice), "Bill-to Customer No." = field("Bill-to Customer No."));
            trigger OnLookup()
            var
                EnteteAcompte: Record "Sales Header";
            begin
                if "No. facture acompte" <> '' then begin
                    EnteteAcompte.GET(EnteteAcompte."Document Type"::Invoice, "No. facture acompte");
                    PAGE.RUN(PAGE::"Sales Invoice", EnteteAcompte);
                end;
            end;
        }
        field(50290; "No. facture situat. enregistre"; Code[20])
        {
            Caption = 'N° facture situat. enregistrée';
            DataClassification = ToBeClassified;
            Description = 'KAN';
            Editable = false;
            TableRelation = "Sales Invoice Header" where("Bill-to Customer No." = field("Bill-to Customer No."));
        }
        field(50300; "Montant deja verse TTC"; Decimal)
        {
            Caption = 'Montant déjà versé TTC';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 02/06/2021';
            BlankZero = true;
        }
        field(50303; "Prepa finie"; Boolean)
        {
            Caption = 'Prépa finie';
            DataClassification = ToBeClassified;
        }

        field(50305; "Facturation en compta (O/N)"; Boolean)
        {
            Caption = 'Facturation en compta (O/N)';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                LigneVente: Record "Sales Line";
                LignesNonLivreesMsg: Label 'ATTENTION, une ou plusieurs lignes n''ont pas été livrées, veuillez vérifier.';
            begin
                if "Document Type" <> "Document Type"::Order then
                    exit;

                if "Facturation en compta (O/N)" then begin
                    LigneVente.SetRange("Document Type", Rec."Document Type");
                    LigneVente.SetRange("Document No.", Rec."No.");
                    LigneVente.Setfilter("Outstanding Quantity", '>0');
                    if not LigneVente.IsEmpty() then
                        Message(LignesNonLivreesMsg);
                end;
            end;
        }
        field(50310; "Commentaire factu."; Text[50])
        {
            Caption = 'Commentaire factu.';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 12/03/2024';

            trigger OnValidate()
            var
                PhasesDocument: Record "Phases document";
            begin
                if CurrFieldNo = FieldNo("Commentaire factu.") then begin
                    PhasesDocument.SetRange("Type document", PhasesDocument."Type document"::Quote);
                    PhasesDocument.SetRange("No. document", "No.");
                    PhasesDocument.ModifyAll("Commentaire factu.", "Commentaire factu.");
                end;
            end;
        }
        field(50550; "Factor Code"; Code[10])
        {
            Caption = 'Code banque';
            DataClassification = ToBeClassified;
            TableRelation = Factor;
        }
        field(50600; "Invoice-to Code"; Code[10])
        {
            Caption = 'Code adresse facturation';
            DataClassification = ToBeClassified;
            TableRelation = "Ship-to Address".Code where("Customer No." = field("Sell-to Customer No."), "Adresse de facturation" = filter(true));
            trigger OnValidate()
            var
                ShipToAddr: Record "Ship-to Address";

            begin
                if "Invoice-to Code" <> '' then
                    if ("Document Type" = "Document Type"::"Return Order") or ("Document Type" = "Document Type"::"Credit Memo") then begin

                        ShipToAddr.GET("Sell-to Customer No.", "Invoice-to Code");

                        if ShipToAddr."Adresse de facturation" then begin
                            "Bill-to Name" := ShipToAddr.Name;
                            "Bill-to Name 2" := ShipToAddr."Name 2";
                            "Bill-to Address" := ShipToAddr.Address;
                            "Bill-to Address 2" := ShipToAddr."Address 2";
                            "Bill-to City" := ShipToAddr.City;
                            "Bill-to Post Code" := ShipToAddr."Post Code";
                            "Bill-to County" := ShipToAddr.County;
                            VALIDATE("Bill-to Country/Region Code", ShipToAddr."Country/Region Code");
                            "Bill-to Contact" := ShipToAddr.Contact;
                        end;
                    end;
            end;
        }
        field(50610; "Proba transformation"; Option)
        {
            Caption = 'Proba transformation';

            OptionMembers = " ","1","50","100";
            OptionCaption = ' ,1,50,100';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                DossierBE: Record "Dossier BE";
                PhasesDocument: Record "Phases document";
            begin
                //Si on passe en proba 100, il faut créer/mettre à jour le dossier BE
                //Si on était en proba 100 et qu'on passe en autre chose, le dossier BE doit passer en statut annulé.
                //Si le document est lancé, le dossier ne se mettra pas à jour automatiquement
                //Si le document n'est pas lancé, le dossier BE se mettra à jour  
                if (Rec.Status = rec.Status::Released) and ("Proba transformation" = "Proba transformation"::"100") then
                    Rec.MAJDossierBE()
                else begin
                    DossierBE.Reset();
                    DossierBE.SetCurrentKey("Type document", "No. document");
                    DossierBE.SetRange("Type document", DossierBE."Type document"::Devis); //On est forcément sur un devis, le champ Proba transformation n'a pas de sens ailleurs
                    DossierBE.SetRange("No. document", Rec."No.");
                    if DossierBE.FindSet(true) then begin
                        DossierBE.Annule := true;
                        DossierBE.Archive := true;
                        DossierBE.Modify();
                    end;
                end;

                if CurrFieldNo = FieldNo("Proba transformation") then begin
                    PhasesDocument.SetRange("Type document", PhasesDocument."Type document"::Quote);
                    PhasesDocument.SetRange("No. document", "No.");
                    PhasesDocument.ModifyAll("Proba transformation", "Proba transformation");
                end;
            end;
        }
        field(50620; "Date chargement"; Date)
        {
            Caption = 'Date chargement';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                ParamVente: Record "Sales & Receivables Setup";
                LigneVente: Record "Sales Line";
                CondPaiement: Record "Payment Terms";
                DossierBE: Record "Dossier BE";
                PhasesDocument: Record "Phases document";
                TypeDocPhase: Integer;
                NotifDateChargementTxt: Text[80];
                PhaseIndefinieLbl: Label 'Indéfinie';
            begin
                //Création de la phase "Indéfinie"
                case Rec."Document Type" of
                    Rec."Document Type"::Quote:
                        TypeDocPhase := 0;
                    Rec."Document Type"::Order:
                        TypeDocPhase := 1;
                    else
                        exit;
                end;
                if not PhasesDocument.Get(TypeDocPhase, Rec."No.", 0) then begin
                    PhasesDocument.Init();
                    PhasesDocument."Type document" := TypeDocPhase;
                    PhasesDocument."No. document" := Rec."No.";
                    PhasesDocument.Phase := 0;
                    PhasesDocument.Description := PhaseIndefinieLbl;
                    PhasesDocument."Code vendeur" := Rec."Salesperson Code";
                    PhasesDocument."Code enseigne" := Rec."Code enseigne";
                    PhasesDocument."Code chantier" := Rec."Code chantier";
                    PhasesDocument.Insert();
                end;
                PhasesDocument."Date livraison demandee" := Rec."Requested Delivery Date";
                PhasesDocument."Date chargement" := Rec."Date chargement";
                if PhasesDocument."Date chargement" <> 0D then
                    PhasesDocument."Date semaine chargement" := CalcDate('<-CW>', "Date chargement")
                else
                    PhasesDocument."Date semaine chargement" := 0D;
                //KAN.FHA 28/04/2026 FIN
                //KAN.FHA 09/09/2026 DEBUT
                PhasesDocument."Commentaire factu." := "Commentaire factu.";
                //KAN.FHA 09/09/2026 FIN
                PhasesDocument.Modify();

                //Mise à jour des fiches BE
                if Rec."No. dossier BE" <> '' then begin
                    DossierBE.Get(Rec."No. dossier BE");
                    DossierBE."Alerte decalage date" := true;
                    NotifDateChargementTxt := 'Date chargement modifiée du ' + format(xRec."Date chargement") + ' au ' + format("Date chargement");
                    DossierBE."Detail alerte" := NotifDateChargementTxt;
                    DossierBE.Modify();

                    //Gestion des factures de situation
                    if ("No. facture situation" <> '') or ("No. facture situat. enregistre" <> '') then
                        exit;

                    if "Date chargement" = 0D then begin
                        "Creer facture situation le" := 0D;
                        "Situation a creer" := false;
                        "Demander situ. a la compta" := false;
                        exit;
                    end;

                    if "Date chargement" <> 0D then
                        Validate("Shipment Date", "Date chargement");

                    if "% acompte situation demande" = 0 then
                        exit;

                    ParamVente.Get();
                    ParamVente.TestField("Delai creation fact. situ");
                    "Creer facture situation le" := CalcDate(ParamVente."Delai creation fact. situ", "Date chargement");
                    "Situation a creer" := true;

                    if "Date chargement" <> 0D then begin
                        if CondPaiement.Get(Rec."Payment Terms Code") then
                            Rec."Due Date" := Calcdate(CondPaiement."Due Date Calculation", "Date chargement");

                        PhasesDocument.SetCurrentKey("Type document", "No. document", "Date chargement");
                        PhasesDocument.SetRange("Type document", "Document Type");
                        PhasesDocument.SetRange("No. document", "No.");
                        if PhasesDocument.FindLast() then begin
                            PhasesDocument."Date chargement" := Rec."Date chargement";
                            PhasesDocument."Date livraison demandee" := Rec."Requested Delivery Date";
                            PhasesDocument.Modify();
                        end;
                    end;
                end;
                //KAN.FHA 15/01/2026 DEBUT
                if rec."Date chargement" <> 0D then begin
                    Rec."Annee commande" := DATE2DMY(Rec."Date chargement", 3);
                    LigneVente.Reset();
                    LigneVente.SetRange("Document Type", Rec."Document Type");
                    LigneVente.SetRange("Document No.", Rec."No.");
                    if LigneVente.FindSet(true) then
                        LigneVente.ModifyAll("Annee commande", Rec."Annee commande");
                end;
                //KAN.FHA 15/01/2026 FIN

            end;
        }

        field(51240; "Nb affectations achats"; Integer)
        {
            BlankZero = true;
            CalcFormula = count("Affectations achat vente" where("Type document vente" = field("Document Type"),
                                                                  "No. document vente" = field("No."),
                                                                  "Quantite affectee" = filter(<> 0)));
            Caption = 'Nb affectations achats';
            Description = 'KAN';
            Editable = false;
            FieldClass = FlowField;

            trigger OnLookup()
            var
                AffectationsAchats: Record "Affectations achat vente";
                EnteteAchat: Record "Purchase Header";
            begin
                CalcFields("Nb affectations achats");
                if "Nb affectations achats" = 0 then
                    exit;

                AffectationsAchats.Reset();
                AffectationsAchats.SetCurrentKey("Type document vente", "No. document vente", "No. ligne document vente");
                AffectationsAchats.SetRange("Type document vente", "Document Type");
                AffectationsAchats.SetRange("No. document vente", "No.");
                AffectationsAchats.FindFirst();

                if "Nb affectations achats" = 1 then begin
                    EnteteAchat.Get(EnteteAchat."Document Type"::Order, AffectationsAchats."No. document achat");
                    PAGE.Run(PAGE::"Purchase Order", EnteteAchat);
                end else
                    PAGE.Run(PAGE::"Affectations achat vente", AffectationsAchats);

            end;
        }
        field(51250; "Montant CA"; Decimal)
        {
            Caption = 'Montant CA';
            FieldClass = FlowField;
            CalcFormula = sum("Sales Line"."Montant restant HT (DS)" where(TypeDocDuplique = field("Document Type"), NumDocDuplique = field("No."), "Ligne deduction acompte" = const(false), "Ligne deduction situation" = const(false)));
            Editable = false;
            BlankZero = true;
        }
        field(51260; "Montant fact. acompte"; Decimal)
        {
            Caption = 'Montant acompte';
            FieldClass = FlowField;
            CalcFormula = - sum("Sales Line"."Montant restant HT (DS)" where(TypeDocDuplique = field("Document Type"), NumDocDuplique = field("No."), "Ligne deduction acompte" = const(true)));
            Editable = false;
            BlankZero = true;
        }
        field(51270; "Montant fact. situation"; Decimal)
        {
            Caption = 'Montant situation';
            FieldClass = FlowField;
            CalcFormula = - sum("Sales Line"."Montant restant HT (DS)" where(TypeDocDuplique = field("Document Type"), NumDocDuplique = field("No."), "Ligne deduction situation" = const(true)));
            Editable = false;
            BlankZero = true;
        }
        field(51275; "Nombre phases"; Integer)
        {
            Caption = 'Nombre phases';
            FieldClass = FlowField;
            CalcFormula = count("Phases document" where("Type document" = field("Document Type"), "No. document" = field("No.")));
            Editable = false;
        }
        field(51277; "Date chargement min. phases"; Date)
        {
            Caption = 'Date chargement min. phases';
            FieldClass = FlowField;
            CalcFormula = min("Phases document"."Date chargement" where("Type document" = Field("Document Type"), "No. document" = field("No.")));
            Editable = false;
        }
        field(51278; "Date chargement max. phases"; Date)
        {
            Caption = 'Date chargement max. phases';
            FieldClass = FlowField;
            CalcFormula = max("Phases document"."Date chargement" where("Type document" = field("Document Type"), "No. document" = field("No.")));
            Editable = false;
        }
        field(51280; "Phase a expedier"; Integer)
        {
            Caption = 'Phase à expédier';
            DataClassification = ToBeClassified;
        }
        field(51281; "Libelle phase a expedier"; Text[50])
        {
            Caption = 'Libellé phase à expédier';
            DataClassification = ToBeClassified;
        }
        field(51290; "Colisages non valides"; Integer)
        {
            Caption = 'Colisages non validés';
            FieldClass = FlowField;
            CalcFormula = count("Entete colisage" where("No. commande" = field("No."), "No. expedition enregistree" = const('')));
            Editable = false;
        }
        field(51300; "Nb UC en prepa"; Integer)
        {
            Caption = 'Nb UC en prépa';
            FieldClass = FlowField;
            CalcFormula = count("UC Commande" where("No. commande" = field("No.")));
            Editable = false;
        }
        field(51310; "Commande export"; Boolean)
        {
            Caption = 'Commande export';
            Editable = false;
            Description = 'Livraison vers pays ni vide ni FR.';
        }
    }
    keys
    {
        key(MyKey1; "Code chantier")
        {

        }
        key(MyKey2; "Acompte a creer")
        {

        }
        key(MyKey3; "Code enseigne", "Code chantier")
        {

        }
        key(MyKey4; "Code enseigne", "Devis Stock")
        {

        }
        key(MyKey5; "Situation a creer", "Fact. situation creee", "Creer facture situation le")
        {

        }
        key(MyKey6; "Demander situ. a la compta")
        {

        }
        key(MyKey7; "Commande export")
        {

        }
    }

    procedure ColisageEnAttente(pPhase: Integer): Boolean
    var
        EnteteColisage: Record "Entete colisage";
    begin
        EnteteColisage.SetRange("No. commande", Rec."No.");
        EnteteColisage.Setrange(Phase, pPhase);
        EnteteColisage.SetRange("No. expedition enregistree", '');
        exit(not (EnteteColisage.IsEmpty));
    end;

    procedure SetCommentairesDossierBE(NewCommentairesDossierBE: Text)
    var
        DossierBE: Record "Dossier BE";
        OutStream: OutStream;
    begin
        Clear("Commentaires dossier BE");
        "Commentaires dossier BE".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewCommentairesDossierBE);
        Modify();
        if Rec."No. dossier BE" <> '' then
            if DossierBE.Get(Rec."No. dossier BE") then begin
                Clear(DossierBE."Commentaires dossier BE");
                DossierBE."Commentaires dossier BE".CreateOutStream(OutStream, TEXTENCODING::UTF8);
                OutStream.WriteText(NewCommentairesDossierBE);
                DossierBE.Modify();
            end;
    end;

    procedure GetCommentairesDossierBE() CommentairesDossierBE: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("Commentaires dossier BE");
        "Commentaires dossier BE".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Commentaires dossier BE")));
    end;


    procedure SetCommentairesPrepa(NewCommentairesPrepa: Text)
    var
        //DossierBE: Record "Dossier BE";
        OutStream: OutStream;
    begin
        Clear("Commentaires Prepa");
        "Commentaires prepa".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewCommentairesPrepa);
        Modify();
        /*
        if Rec."No. dossier BE" <> '' then
            if DossierBE.Get(Rec."No. dossier BE") then begin
                Clear(DossierBE."Commentaires dossier BE");
                DossierBE."Commentaires dossier BE".CreateOutStream(OutStream, TEXTENCODING::UTF8);
                OutStream.WriteText(NewCommentairesDossierBE);
                DossierBE.Modify();
            end;
        */
    end;

    procedure GetCommentairesPrepa() CommentairesPrepa: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("Commentaires Prepa");
        "Commentaires prepa".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Commentaires prepa")));
    end;

    procedure EtablirSuiviAchats()
    var
        AffectationsAchats: Record "Affectations achat vente";
        AffectationsAchats2: Record "Affectations achat vente";
        TamponCdesAchats: Record TamponCdesAchatsParDocVente;
        TamponAffectationsDocVente: Record TamponAffectationsDocVente;
        EnteteAchat: Record "Purchase Header";
        LigneAchat: Record "Purchase Line";
        CodeUtil: Text[50];
    begin
        CodeUtil := CopyStr(UserId, 1, 50);
        TamponCdesAchats.SetRange("Code utilisateur", CodeUtil);
        TamponCdesAchats.DeleteAll();

        TamponAffectationsDocVente.SetRange("Code utilisateur", CodeUtil);
        TamponAffectationsDocVente.DeleteAll();

        //On va chercher toutes les commandes d'achats pour lesquelles on a une affectation sur le document de vente
        //On va ensuite lister tout ce qui est acheté sur chaque commande, même les articles qui ne seraient pas achetés pour le document de vente
        //(on considère qu'on l'achète quand même pour ce chantier)
        //Exemple :
        //La commande de vente porte sur l'article A1
        //On a créé la commande d'achat CF23 qui porte cet article A1 avec donc une affectation pour cet article entre la commande d'achat et la commande de vente.
        //On a ajouté directement sur la commande d'achat des articles A2 et A3 qui ne sont pas vendus (pas d'affectation)
        //Le suivi doit montrer la commande CF23 avec les 3 articles dont une ligne qui fait mention d'une quantité affectée à la commande de vente.

        AffectationsAchats.Reset();
        AffectationsAchats.SetCurrentKey("Type document vente", "No. document vente", "No. ligne document vente");
        AffectationsAchats.SetRange("Type document vente", "Document Type");
        AffectationsAchats.SetRange("No. document vente", "No.");
        if AffectationsAchats.FindSet(false) then begin
            LigneAchat.Reset();
            LigneAchat.SetCurrentKey("Document Type", "Document No.", Type, "No.", "System-Created Entry");
            LigneAchat.Setrange("Document Type", LigneAchat."Document Type"::Order);
            LigneAchat.Setrange(Type, LigneAchat.Type::Item);
            repeat
                if AffectationsAchats."No. document achat" <> '' then
                    if not TamponCdesAchats.Get(UserId, Rec."Document Type", Rec."No.", AffectationsAchats."No. document achat") then begin
                        TamponCdesAchats.Init();
                        TamponCdesAchats."Code utilisateur" := CodeUtil;
                        TamponCdesAchats."Type document vente" := Rec."Document Type";
                        TamponCdesAchats."No. document vente" := Rec."No.";
                        TamponCdesAchats."No. commande achat" := AffectationsAchats."No. document achat";
                        TamponCdesAchats.Insert();
                        if EnteteAchat.Get(EnteteAchat."Document Type"::Order, TamponCdesAchats."No. commande achat") then begin
                            TamponCdesAchats."No. fournisseur" := EnteteAchat."Buy-from Vendor No.";
                            TamponCdesAchats."Nom fournisseur" := EnteteAchat."Buy-from Vendor Name";

                            TamponCdesAchats."Date semaine chargement" := EnteteAchat."Date intention chargement";
                            if TamponCdesAchats."Date semaine chargement" <> 0D then
                                TamponCdesAchats."Semaine chargement" := Date2DWY(TamponCdesAchats."Date semaine chargement", 2);
                            TamponCdesAchats."Date reception prevue" := EnteteAchat."Expected Receipt Date";
                            TamponCdesAchats.Commentaires := EnteteAchat.Commentaires;
                            TamponCdesAchats.Modify();
                        end;

                        //Une fois par commande d'achat trouvée, on liste tous les articles achetés sur cette commande
                        LigneAchat.Setrange("Document No.", AffectationsAchats."No. document achat");
                        if LigneAchat.FindSet(false) then
                            repeat
                                if not TamponAffectationsDocVente.get(CodeUtil, AffectationsAchats."No. document achat", LigneAchat."No.") then begin
                                    TamponAffectationsDocVente.Init();
                                    TamponAffectationsDocVente."Code utilisateur" := CodeUtil;
                                    TamponAffectationsDocVente."No. commande achat" := AffectationsAchats."No. document achat";
                                    TamponAffectationsDocVente."No. article achete" := LigneAchat."No.";
                                    TamponAffectationsDocVente."Description article achete" := LigneAchat.Description;
                                    //KAN.FHA 09/09/2026 DEBUT
                                    TamponAffectationsDocVente."Type document vente" := "Document Type";
                                    TamponAffectationsDocVente."No. doc. vente" := "No.";
                                    //KAN.FHA 09/09/2026 FIN
                                    TamponAffectationsDocVente.Insert();
                                end;
                                TamponAffectationsDocVente."Qte achetee" := TamponAffectationsDocVente."Qte achetee" + LigneAchat.Quantity;
                                TamponAffectationsDocVente."Qte recue" := TamponAffectationsDocVente."Qte recue" + LigneAchat."Quantity Received";
                                AffectationsAchats2.SetRange("No. document achat", LigneAchat."Document No.");
                                AffectationsAchats2.SetRange("No. ligne document achat", LigneAchat."Line No.");
                                AffectationsAchats2.SetRange("No. document vente", Rec."No.");
                                if AffectationsAchats2.FindSet(false) then
                                    repeat
                                        TamponAffectationsDocVente."Quantite affectee" := TamponAffectationsDocVente."Quantite affectee" + AffectationsAchats2."Quantite affectee";
                                        TamponAffectationsDocVente.Modify();
                                    until AffectationsAchats2.Next() = 0;
                            until LigneAchat.Next() = 0;
                    end;
            until AffectationsAchats.Next() = 0;
        end;
    end;

    procedure AfficherVueSimplifiee()
    var
        LigneVente: Record "Sales Line";
        LigneVenteSimplifiee: Record "Ligne vente simplifiee";
        intTypeDoc: Integer;
    begin
        case rec."Document Type" of
            rec."Document Type"::Quote:
                begin
                    intTypeDoc := 0;
                    LigneVenteSimplifiee.SetRange("Type Document", LigneVenteSimplifiee."Type document"::Quote);
                end;
            rec."Document Type"::Order:
                begin
                    intTypeDoc := 1;
                    LigneVenteSimplifiee.SetRange("Type Document", LigneVenteSimplifiee."Type document"::Order);
                end;
            else
                exit;
        end;
        LigneVenteSimplifiee.SetRange("No. Document", rec."No.");
        LigneVenteSimplifiee.deleteall();

        LigneVente.SetRange("Document Type", rec."Document Type");
        LigneVente.SetRange("Document No.", rec."No.");
        LigneVente.Setrange("Ligne deduction acompte", false);
        LigneVente.setrange("Ligne deduction situation", false);
        if LigneVente.FindSet(false) then
            repeat
                LigneVenteSimplifiee.Init();
                if intTypeDoc = 0 then
                    LigneVenteSimplifiee."Type document" := LigneVenteSimplifiee."Type document"::Quote
                else
                    LigneVenteSimplifiee."Type document" := LigneVenteSimplifiee."Type document"::Order;
                LigneVenteSimplifiee."No. document" := "No.";
                LigneVenteSimplifiee."No. ligne" := LigneVente."Line No.";
                LigneVenteSimplifiee.Type := LigneVente.Type;
                LigneVenteSimplifiee."No." := LigneVente."No.";
                LigneVenteSimplifiee."Article divers" := LigneVente."Article divers";
                //KAN.FHA 13/05/2026 DEBUT
                LigneVenteSimplifiee."Code variante" := LigneVente."Variant Code";
                LigneVenteSimplifiee.Phase := LigneVente.Phase;
                LigneVenteSimplifiee."Type Fiche BE" := LigneVente."Type Fiche BE";
                LigneVenteSimplifiee."Prix achat prevu" := LigneVente."Prix achat prevu";
                //KAN.FHA 13/05/2026 FIN
                LigneVenteSimplifiee.Description := LigneVente.Description;
                LigneVenteSimplifiee."Ligne eclatee" := LigneVente."Ligne eclatee";
                LigneVenteSimplifiee."Quantite pour 1" := LigneVente."Quantite pour 1";
                LigneVenteSimplifiee.Quantite := LigneVente.Quantity;
                LigneVenteSimplifiee."Quantite livree" := LigneVente."Quantity Shipped";
                LigneVenteSimplifiee."Quantite facturee" := LigneVente."Quantity Invoiced";
                LigneVenteSimplifiee."Prix unitaire" := LigneVente."Unit Price";
                LigneVenteSimplifiee."Cout unitaire (DS)" := LigneVente."Unit Cost (LCY)";
                //KAN.FHA 20/05/2026 DEBUT
                LigneVenteSimplifiee."% remise ligne" := LigneVente."Line Discount %";
                //KAN.FHA 20/05/2026 FIN
                LigneVenteSimplifiee.Montant := LigneVente.Amount;
                if (LigneVente."Attached to Line No." = 0) and (LigneVente."Linked to line" = 0) then
                    LigneVenteSimplifiee."Type ligne simplifiee" := LigneVenteSimplifiee."Type ligne simplifiee"::Mere
                else begin
                    LigneVenteSimplifiee."Type ligne simplifiee" := LigneVenteSimplifiee."Type ligne simplifiee"::Fille;
                    if LigneVente."Linked to line" <> 0 then
                        LigneVenteSimplifiee."No. ligne mere" := LigneVente."Linked to line"
                    else
                        LigneVenteSimplifiee."No. ligne mere" := LigneVente."Attached to Line No.";
                end;
                LigneVenteSimplifiee."Attached to Line No." := LigneVente."Attached to Line No.";
                LigneVenteSimplifiee."Linked to line No." := LigneVente."Linked to line";
                LigneVenteSimplifiee."Code magasin" := LigneVente."Location Code";
                LigneVenteSimplifiee."Nomenclature produits" := LigneVente."Nomenclature produits";
                LigneVenteSimplifiee."Eco Tax Furniture Amount" := LigneVente."Eco Tax Furniture Amount";
                LigneVenteSimplifiee."Eco Tax Furniture Code" := LigneVente."Eco Tax Furniture Code";
                LigneVenteSimplifiee."Eco Tax Furniture Line" := LigneVente."Eco Tax Furniture Line";
                LigneVenteSimplifiee."Eco Tax Furniture Qty Per" := LigneVente."Eco Tax Furniture Qty Per";
                LigneVenteSimplifiee."Type ligne" := LigneVente."Type ligne";
                LigneVenteSimplifiee."No. fournisseur" := LigneVente."Vendor No.";
                LigneVenteSimplifiee."Code pays origine" := LigneVente."Country/Region of Origin Code";
                LigneVenteSimplifiee."Poids unitaire" := LigneVente."Net Weight";
                LigneVenteSimplifiee.Insert();
            until lignevente.Next() = 0;

        LigneVenteSimplifiee.FilterGroup(2);
        LigneVenteSimplifiee.SetRange("Type document", intTypeDoc);
        LigneVenteSimplifiee.SetRange("No. document", "No.");
        LigneVenteSimplifiee.FilterGroup(0);
        page.run(page::"Vue simplifiee document vente", LigneVenteSimplifiee);
    end;

    procedure CalcSubTotal(pHeader: Record "Sales Header")
    var
        lSalesLine: Record "Sales Line";
        lTotal: Decimal;

    begin
        //-NEG.NV06 DIAGONAL YCH 22/06/2010 SOUS TOTAL
        CLEAR(lTotal);
        lSalesLine.RESET();
        lSalesLine.SETRANGE("Document Type", pHeader."Document Type");
        lSalesLine.SETRANGE("Document No.", pHeader."No.");
        lSalesLine.SETRANGE("Eco Tax Furniture Line", false);
        lSalesLine.MODIFYALL("SubTotal Amount", 0);
        if lSalesLine.FINDSET(true) then
            repeat
                if lSalesLine."Type ligne" = lSalesLine."Type ligne"::"Début total" then
                    lTotal := 0;
                if lSalesLine."Type ligne" = lSalesLine."Type ligne"::"Fin total" then begin
                    lSalesLine."SubTotal Amount" := lTotal;
                    lSalesLine.MODIFY();
                    CLEAR(lTotal);
                end;
                lTotal += lSalesLine."Line Amount";
            until lSalesLine.NEXT() = 0;
        //+NEG.NV06 DIAGONAL YCH 22/06/2010 SOUS TOTAL
    end;

    /*
    local procedure RecupSoucheSAV(): Code[20]
    var
        ParamVente: Record "Sales & Receivables Setup";
    begin
        ParamVente.GET();
        case "Document Type" of
            "Document Type"::Quote:
                exit(ParamVente."Quote Nos.");
            "Document Type"::Order:
                exit(ParamVente."ASS Order Nos.");
            "Document Type"::Invoice:
                exit(ParamVente."ASS Invoice Nos.");
            "Document Type"::"Return Order":
                exit(ParamVente."Return Order Nos.");
            "Document Type"::"Credit Memo":
                exit(ParamVente."ASS Credit Memo Nos.");
            "Document Type"::"Blanket Order":
                exit(ParamVente."Blanket Order Nos.");
        end;
    end;
    */

    procedure CalcPctExpedie(): Decimal
    begin
        //RESTE A CALCULER + CHAMP A AJOUTER (ONAFTERGETRECORD DE LA PAGE 50124 LISTE SAISIE EXPEDITIONS)
    end;

    procedure CalcPctPrepaSurStock(): Decimal
    begin
        //RESTE A CALCULER + CHAMP A AJOUTER (ONAFTERGETRECORD DE LA PAGE 50124 LISTE SAISIE EXPEDITIONS)
    end;

    procedure CalcNbArticlesAPreparer(): Decimal
    begin
        //RESTE A CALCULER + CHAMP A AJOUTER (ONAFTERGETRECORD DE LA PAGE 50124 LISTE SAISIE EXPEDITIONS)
    end;

    /*
    local procedure TestSoucheSAV(): Code[20]
    var
        ParamVente: Record "Sales & Receivables Setup";

    begin
        ParamVente.GET();
        case "Document Type" of
            "Document Type"::Quote:
                ParamVente.TESTFIELD("Quote Nos.");
            "Document Type"::Order:
                ParamVente.TESTFIELD("ASS Order Nos.");
            "Document Type"::Invoice:
                begin
                    ParamVente.TESTFIELD("ASS Invoice Nos.");
                    ParamVente.TESTFIELD("ASS Posted Invoice Nos.");
                end;
            "Document Type"::"Return Order":
                ParamVente.TESTFIELD("Return Order Nos.");
            "Document Type"::"Credit Memo":
                begin
                    ParamVente.TESTFIELD("ASS Credit Memo Nos.");
                    ParamVente.TESTFIELD("ASS Posted Credit Memo Nos.");
                end;
            "Document Type"::"Blanket Order":
                ParamVente.TESTFIELD("Blanket Order Nos.");
        end;
    end;
    */

    procedure UpdateFieldReleaseStatus_T()
    var
        SalesLine_l: Record "Sales Line";
    begin
        //- DIA/BPE 17/11/14
        if "Document Type" <> "Document Type"::Quote then
            exit;
        SalesLine_l.SETRANGE("Document Type", "Document Type");
        SalesLine_l.SETRANGE("Document No.", "No.");
        if SalesLine_l.FINDSET(true) then
            repeat
                SalesLine_l."Released Status" := (Status = Status::Released);
                SalesLine_l.MODIFY();
            until SalesLine_l.NEXT() = 0;
        //+ DIA/BPE 17/11/14

    end;

    procedure MAJLigneChampsAffaire()
    begin
        SalesLine.LOCKTABLE();
        MODIFY();

        SalesLine.RESET();
        SalesLine.SETRANGE("Document Type", "Document Type");
        SalesLine.SETRANGE("Document No.", "No.");
        if SalesLine.FINDSET(true) then
            repeat
                if SalesLine."No." <> '' then begin
                    SalesLine."Code groupe" := "Code groupe";
                    SalesLine."Code enseigne" := "Code enseigne";
                    SalesLine."Code operation" := "Code operation";
                    SalesLine."Code chantier" := "Code chantier";
                    SalesLine.MODIFY(true);
                end;
            until SalesLine.NEXT() = 0;
    end;

    procedure CreerCommandesAchats(var pPurchOrderNo: Code[20]; pCodeFournisseurIndefini: Code[20]; var pNbCdesCreees: Integer; var pNbCdesCompletees: Integer; var pNbLignesAjoutees: Integer; pAcheterQueCertainesPhases: Boolean): Boolean
    var
        lrecSalesLine: Record "Sales Line";
        lrecSalesLine2: Record "Sales Line";
        lrecPurchaseHdr: Record "Purchase Header";
        LigneCommandeCadre: Record "Purchase Line";
        lrecPurchaseLine: Record "Purchase Line";
        TamponDispoSurCdeCadre: Record "Tampon dispo cde cadre achat";
        LigneAchatPriseSurCadre: Record "Purchase Line";
        ListeFournisseur: Record "Selection fns pour creer cde";
        ListeMagasin: Record "Stock dispo pour creer cde";
        Magasin: Record Location;
        Article: Record Item;
        Fournisseur: Record Vendor;
        ParamAchat: Record "Purchases & Payables Setup";
        RelationSouches: Record "No. Series Relationship";
        TableTampon: Record TamponTriLignesDocument;
        PageListeFns: page "Selection fns/creer cde";
        CodeUtil: Code[50];
        lBeforeBuyFromNo: Code[20];
        CodeSoucheCommandeSAV: Code[20];
        ItemNo: Code[20];
        AjouterACdeNo: Code[20];
        CreerDocumentSAV: Boolean;
        AchatMultiPhases: Boolean;
        Selection: Integer;
        RemainingQtyToCover: Decimal;
        QtyToTake: Decimal;
        QteDispo: Decimal;
        QteAAcheter: Decimal;
        lLineNo: Integer;
        PhaseAchat: Integer;
        NbCdeAchatCreees: Integer;
        NbCdeAchatCompletees: Integer;
        NbLignesAjoutees: Integer;
        ListeFournisseurAConfirmerMsg: Text;
        PhaseText: Text[10];
        PhaseInt: Integer;
        ConfirmerListeFnsQst: Label 'Confirmez-vous vouloir créer une commande pour chacun des fournisseurs suivants : %1.', Comment = '%1 = Liste fournisseurs';
        AbandonMsg: Label 'Opération interrompue à la demande de l''utilisateur.';

        CreerAchatDevisStockLbl: Label 'Ce devis est un devis pour stock. Si vous créez la/les commande(s) d''achat, elles ne seront pas affectées à une vente. Confirmez-vous ?';
        ChoixCreationLbl: Label 'Commande Standard,Commande SAV fournisseur';
        AucuneSoucheAchatSAVErr: Label 'Aucune souche n''a été définie pour les commandes d''achats de SAV.';
    begin
        TestField("Salesperson Code");

        if not ("Document Type" in ["Document Type"::Quote, "Document Type"::Order]) then
            exit(false);

        if "Devis Stock" and ("Document Type" = "Document Type"::Quote) then
            if not CONFIRM(CreerAchatDevisStockLbl) then
                exit(false);

        CreerDocumentSAV := false;

        if ASS then begin
            Selection := STRMENU(ChoixCreationLbl, 2);
            if Selection = 0 then
                exit(false);
            CreerDocumentSAV := (Selection = 2);
        end;

        if CreerDocumentSAV then begin
            CodeSoucheCommandeSAV := '';
            ParamAchat.GET();
            ParamAchat.TESTFIELD("Order Nos.");
            RelationSouches.SETRANGE(RelationSouches.Code, ParamAchat."Order Nos.");
            if RelationSouches.FINDSET() then
                repeat
                    if STRPOS(RelationSouches."Series Code", 'SAV') <> 0 then
                        CodeSoucheCommandeSAV := RelationSouches."Series Code";
                until (RelationSouches.NEXT() = 0) or (CodeSoucheCommandeSAV <> '');
            if CodeSoucheCommandeSAV = '' then
                ERROR(AucuneSoucheAchatSAVErr);
        end;

        CodeUtil := copystr(USERID, 1, 50);

        ListeFournisseur.SETRANGE("Code utilisateur", CodeUtil);
        ListeFournisseur.DELETEALL();

        ListeMagasin.RESET();
        ListeMagasin.SETRANGE("Code utilisateur", CodeUtil);
        ListeMagasin.DELETEALL();

        TableTampon.SetRange("Code utilisateur", CodeUtil);
        TableTampon.DELETEALL();

        TamponDispoSurCdeCadre.SetRange("Code utilisateur", CodeUtil);
        TamponDispoSurCdeCadre.DeleteAll();

        lLineNo := 1;

        //On commence par lister tous les fournisseurs présents sur le document
        lrecSalesLine.RESET();
        lrecSalesLine.SETCURRENTKEY("Document Type", "Document No.", Type, "Vendor No.");
        lrecSalesLine.SETRANGE("Document Type", "Document Type");
        lrecSalesLine.SETRANGE("Document No.", "No.");
        lrecSalesLine.SETRANGE(Type, lrecSalesLine.Type::Item);
        //KAN.FHA 28/01/2026 DEBUT
        if pAcheterQueCertainesPhases then
            lrecSalesLine.SetRange("A acheter", true);

        //KAN.FHA 28/01/2026 FIN
        if lrecSalesLine.FINDSET(true) then
            repeat
                lrecSalesLine."Creer cde achat" := false;
                lrecSalesLine."Ajouter à cde achat No." := '';
                if lrecSalesLine."Vendor No." <> '' then begin
                    ListeFournisseur.SetRange("No. fournisseur", lrecSalesLine."Vendor No.");
                    if not ListeFournisseur.FindFirst() then begin
                        ListeFournisseur.INIT();
                        ListeFournisseur."Code utilisateur" := CodeUtil;
                        ListeFournisseur."No. fournisseur" := lrecSalesLine."Vendor No.";
                        ListeFournisseur."No. ligne" := lLineNo;
                        lLineNo := lLineNo + 10;
                        if Fournisseur.GET(lrecSalesLine."Vendor No.") then begin
                            ListeFournisseur."Nom fournisseur" := Fournisseur.Name;
                            ListeFournisseur."Fournisseur divers" := Fournisseur."Fournisseur divers";
                        end;
                        case "Document Type" of
                            "Document Type"::"Blanket Order":
                                ListeFournisseur."Document Type" := ListeFournisseur."Document Type"::"Blanket Order";
                            "Document Type"::"Credit Memo":
                                ListeFournisseur."Document Type" := ListeFournisseur."Document Type"::"Credit Memo";
                            "Document Type"::Invoice:
                                ListeFournisseur."Document Type" := ListeFournisseur."Document Type"::"Invoice";
                            "Document Type"::Order:
                                ListeFournisseur."Document Type" := ListeFournisseur."Document Type"::Order;
                            "Document Type"::Quote:
                                ListeFournisseur."Document Type" := ListeFournisseur."Document Type"::Quote;
                            "Document Type"::"Return Order":
                                ListeFournisseur."Document Type" := ListeFournisseur."Document Type"::"Return Order";
                        end;
                        ListeFournisseur."Document No." := "No.";
                        ListeFournisseur."Creer nouvelle commande" := true;
                        ListeFournisseur.INSERT();
                    end;
                    //KAN.FHA 22/04/2026 DEBUT
                    //lrecSalesLine.CALCFIELDS("Nb affectations achats");
                    //ListeFournisseur."Creer nouvelle commande" := (ListeFournisseur."Creer nouvelle commande") and (lrecSalesLine."Nb affectations achats" = 0) and (Fournisseur.GET(lrecSalesLine."Vendor No."));
                    //Lignes remplacees par :
                    lrecSalesLine.CalcFields("Quantite affectee");
                    ListeFournisseur."Creer nouvelle commande" := (ListeFournisseur."Creer nouvelle commande") and (lrecSalesLine."Quantite affectee" = 0) and (Fournisseur.GET(lrecSalesLine."Vendor No."));
                    ListeFournisseur.MODIFY();
                    lrecSalesLine."Creer cde achat" := ListeFournisseur."Creer nouvelle commande";
                    if lrecSalesLine."Creer cde achat" then
                        lrecSalesLine."Ajouter à cde achat No." := '';
                    //KAN.FHA 22/04/2026 DEBUT
                    //if lrecSalesLine."Creer cde achat" and (lrecSalesLine."Nb affectations achats" = 0) then
                    //    lrecSalesLine."Quantite a acheter" := lrecSalesLine."Outstanding Quantity"
                    //else
                    //    lrecSalesLine."Quantite a acheter" := 0;
                    //Lignes remplacees par :
                    if lrecSalesLine."Creer cde achat" then begin
                        QteAAcheter := lrecSalesLine."Outstanding Quantity" - lrecSalesLine."Quantite affectee";
                        if QteAAcheter < 0 then
                            QteAACheter := 0;
                        lrecSalesLine."Quantite a acheter" := QteAAcheter;
                    end else
                        lrecSalesLine."Quantite a acheter" := 0;

                    lrecSalesLine.MODIFY();
                end else begin //On liste les lignes sans fournisseur qu'on pourra aussi affecter à un fournisseur via cet écran
                    Article.GET(lrecSalesLine."No.");
                    Article.CALCFIELDS("Assembly BOM");
                    if not Article."Assembly BOM" then begin
                        ListeFournisseur.SetRange("Code utilisateur", CodeUtil);
                        ListeFournisseur.SetRange("No. fournisseur", pCodeFournisseurIndefini);
                        if not ListeFournisseur.FindFirst() then begin
                            ListeFournisseur.INIT();
                            ListeFournisseur."Code utilisateur" := CodeUtil;
                            ListeFournisseur."No. fournisseur" := pCodeFournisseurIndefini;
                            ListeFournisseur."No. ligne" := lLineNo;
                            lLineNo := lLineNo + 10;
                            case "Document Type" of
                                "Document Type"::"Blanket Order":
                                    ListeFournisseur."Document Type" := ListeFournisseur."Document Type"::"Blanket Order";
                                "Document Type"::"Credit Memo":
                                    ListeFournisseur."Document Type" := ListeFournisseur."Document Type"::"Credit Memo";
                                "Document Type"::Invoice:
                                    ListeFournisseur."Document Type" := ListeFournisseur."Document Type"::"Invoice";
                                "Document Type"::Order:
                                    ListeFournisseur."Document Type" := ListeFournisseur."Document Type"::Order;
                                "Document Type"::Quote:
                                    ListeFournisseur."Document Type" := ListeFournisseur."Document Type"::Quote;
                                "Document Type"::"Return Order":
                                    ListeFournisseur."Document Type" := ListeFournisseur."Document Type"::"Return Order";
                            end;

                            ListeFournisseur."Document No." := "No.";
                            ListeFournisseur."Creer nouvelle commande" := false;
                            ListeFournisseur.INSERT();
                        end else begin
                            ListeFournisseur."Creer nouvelle commande" := false;
                            ListeFournisseur.MODIFY();
                        end;
                        //Pour ne pas avoir de probleme de parcours (la clé contient le champ N° fournisseur qu'on doit modifier ici), je passe sur une autre variable
                        lrecSalesLine2.GET(lrecSalesLine."Document Type", lrecSalesLine."Document No.", lrecSalesLine."Line No.");
                        lrecSalesLine2."Vendor No." := pCodeFournisseurIndefini;
                        lrecSalesLine2.MODIFY();
                    end;
                end;
            until lrecSalesLine.NEXT() = 0;

        //On liste ensuite tous les magasins au cas où l'utilisateur voudrait prendre sur stock
        Magasin.RESET();
        Magasin.SETRANGE("Montrer stock sur creer cde", true);
        if Magasin.FINDSET(false) then
            repeat
                ListeMagasin.INIT();
                ListeMagasin."Code utilisateur" := CodeUtil;
                ListeMagasin."Type ligne" := ListeMagasin."Type ligne"::Magasin;
                ListeMagasin."Code magasin" := Magasin.Code;
                ListeMagasin."Document Type" := "Document Type";
                ListeMagasin."Document No." := "No.";
                ListeMagasin."Type ligne" := ListeMagasin."Type ligne"::Magasin;
                if ListeMagasin."Code magasin" = "Location Code" then
                    ListeMagasin."Tenir compte du stock" := true;
                ListeMagasin.INSERT();
            until Magasin.NEXT() = 0;

        if ListeFournisseur.FINDSET(false) then begin
            //Les magasins susceptibles de contenir du stock disponible pour traiter cette commande ont été listés, on va maintenant calculer le stock dispo pour
            //chacun des articles de la commande dans chacun des magasins (à ce stade, on ne devrait avoir qu'un magasin coché "Tenir compte du stock", le magasin de l'entete du document
            ListeMagasin.RESET();
            ListeMagasin.SETRANGE("Code utilisateur", CodeUtil);
            ListeMagasin.SetRange("Type ligne", ListeMagasin."Type ligne"::Magasin);
            ListeMagasin.SETRANGE("Tenir compte du stock", true);
            if ListeMagasin.FINDSET() then
                repeat
                    ListeMagasin.ChercherStockDispo();
                until ListeMagasin.NEXT() = 0;

            COMMIT(); //Aucun risque, on n'a fait que travailler sur des tables de travail jusque là.

            CLEAR(PageListeFns);
            PageListeFns.EDITABLE(true);
            PageListeFns.LOOKUPMODE(true);
            if PageListeFns.RUNMODAL() <> ACTION::LookupOK then
                exit(false);
            CLEAR(PageListeFns);

        end else
            exit(false);

        //Si l'utilisateur a fait "OK" sur la liste des fournisseurs et qu'il a au moins coché un fournisseur, on va avoir des lignes qui sont en [Créer cde achat] à Oui
        //On commence d'abord par lui afficher un message indiquant tous les fournisseurs pour lesquels il s'apprête à créer une commande pour confirmation
        ListeFournisseur.SETRANGE("Code utilisateur", CodeUtil);
        ListeFournisseur.SETRANGE("Creer nouvelle commande", true);
        if ListeFournisseur.FINDSET(false) then begin
            ListeFournisseurAConfirmerMsg := '';
            repeat
                if ListeFournisseur."Fournisseur divers" then
                    ListeFournisseur.TestField("Code pays origine");

                if ListeFournisseurAConfirmerMsg = '' then
                    ListeFournisseurAConfirmerMsg := ListeFournisseur."Nom fournisseur"
                else
                    ListeFournisseurAConfirmerMsg := ListeFournisseurAConfirmerMsg + '\' + ListeFournisseur."Nom fournisseur";
            until ListeFournisseur.NEXT() = 0;
            if not CONFIRM(ConfirmerListeFnsQst, true, ListeFournisseurAConfirmerMsg) then
                ERROR(AbandonMsg);
        end;

        //=================================================================================================
        //On liste les articles à commander pour les fournisseurs où on a coché 'Créer nouvelle commande"
        //=================================================================================================
        lrecSalesLine.SETRANGE("Document Type", "Document Type");
        lrecSalesLine.SETRANGE("Document No.", "No.");
        lrecSalesLine.SETRANGE(Type, lrecSalesLine.Type::Item);
        if pAcheterQueCertainesPhases then
            lrecSalesLine.SetRange("A acheter", true);
        if lrecSalesLine.FINDSET(true) then begin
            PhaseAchat := -99;
            repeat
                if (lrecSalesLine."Creer cde achat") and (lrecSalesLine."Quantite a acheter" <> 0) then begin
                    //KAN.FHA 19/05/2026 DEBUT
                    if lrecSalesLine.Phase <> PhaseAchat then
                        if PhaseAchat = -99 then
                            PhaseAchat := lrecSalesLine.Phase
                        else
                            PhaseAchat := 0;
                    //KAN.FHA 19/05/2026 FIN
                    lrecSalesLine.TESTFIELD("Vendor No.");
                    ListeFournisseur.SetRange("Code utilisateur", CodeUtil);
                    ListeFournisseur.SetRange("No. fournisseur", lrecSalesLine."Vendor No.");
                    ListeFournisseur.FindFirst();
                    if ListeFournisseur."Creer nouvelle commande" then begin
                        TableTampon.Reset();
                        TableTampon.Init();
                        TableTampon."Code utilisateur" := CodeUtil;
                        TableTampon."Creer nouvelle commande" := true;
                        TableTampon."Type document" := format(lrecSalesLine."Document Type");
                        TableTampon."No. document" := "No.";
                        TableTampon."No. ligne document" := lrecSalesLine."Line No.";
                        TableTampon.Type := lrecSalesLine.Type;
                        TableTampon."No." := lrecSalesLine."No.";
                        TableTampon."Code variante" := lrecSalesLine."Variant Code";
                        TableTampon."Code magasin" := lrecSalesLine."Location Code";
                        TableTampon."Code chantier" := lrecSalesLine."Code chantier";
                        TableTampon.Quantite := lrecSalesLine."Quantite a acheter";
                        TableTampon.Description := lrecSalesLine.Description;
                        TableTampon."No. document vente" := lrecSalesLine."Document No.";
                        TableTampon."No. ligne doc. vente" := lrecSalesLine."Line No.";
                        TableTampon."No. fournisseur" := lrecSalesLine."Vendor No.";
                        TableTampon."Fournisseur divers" := ListeFournisseur."Fournisseur divers";
                        TableTampon."Code pays origine" := ListeFournisseur."Code pays origine";
                        TableTampon."Nomenclature produits" := lrecSalesLine."Nomenclature produits";
                        TableTampon."Poids net" := lrecSalesLine."Net Weight";
                        if lrecSalesLine."Article divers" then
                            TableTampon."Prix achat prevu" := lrecSalesLine."Prix achat prevu";
                        TableTampon."Achete pour phase (si unique)" := PhaseAchat;
                        TableTampon.INSERT();

                        //Lignes texte étendus
                        lrecSalesLine2.RESET();
                        lrecSalesLine2.SETCURRENTKEY("Document Type", "Document No.", "Linked to line");
                        lrecSalesLine2.SETRANGE("Document Type", "Document Type");
                        lrecSalesLine2.SETRANGE("Document No.", "No.");
                        lrecSalesLine2.SETRANGE("Linked to line", lrecSalesLine."Line No.");
                        lrecSalesLine2.SETRANGE(Type, lrecSalesLine2.Type::" ");
                        if lrecSalesLine2.FINDSET() then
                            repeat
                                TableTampon.RESET();
                                TableTampon.INIT();
                                TableTampon."Code utilisateur" := CodeUtil;
                                TableTampon."Type Document" := format(Rec."Document Type");
                                TableTampon."No. Document" := "No.";
                                TableTampon."No. ligne document" := lrecSalesLine2."Line No.";
                                TableTampon.Type := lrecSalesLine2.Type;
                                TableTampon."No." := lrecSalesLine2."No.";
                                TableTampon.Description := lrecSalesLine2.Description;
                                TableTampon."No. fournisseur" := lrecSalesLine2."Vendor No.";
                                TableTampon."Creer nouvelle commande" := true;
                                TableTampon.INSERT();
                            until lrecSalesLine2.NEXT() = 0;

                        lrecSalesLine."Creer cde achat" := false;
                        lrecSalesLine.MODIFY();
                    end;
                end;
            until lrecSalesLine.NEXT() = 0;
        end;

        //KAN.FHA 08/03/2026 DEBUT
        LigneCommandeCadre.SetCurrentKey("Document Type", "Buy-from Vendor No.");
        LigneCommandeCadre.SetRange("Document Type", LigneCommandeCadre."Document Type"::"Blanket Order");
        LigneCommandeCadre.SetRange(Type, LigneCommandeCadre.Type::Item);
        //KAN.FHA 08/03/2026 FIN
        //KAN.FHA 16/03/2026 DEBUT
        //On va stocker dans une table tampon les quantités de commandes cadres encore disponibles
        ListeFournisseur.Reset();
        ListeFournisseur.SetRange("Code utilisateur", CodeUtil);
        if ListeFournisseur.FindSet() then
            repeat
                if ListeFournisseur."Creer nouvelle commande" or (ListeFournisseur."Ajouter a la cde No." <> '') then begin
                    LigneCommandeCadre.SetRange("Buy-from Vendor No.", ListeFournisseur."No. fournisseur");
                    if LigneCommandeCadre.FindSet(false) then
                        repeat
                            LigneCommandeCadre.CalcFields("Qte sur commande");
                            QteDispo := LigneCommandeCadre.Quantity - LigneCommandeCadre."Qte sur commande" - LigneCommandeCadre."Quantity Received";
                            if QteDispo > 0 then begin
                                TamponDispoSurCdeCadre.Init();
                                TamponDispoSurCdeCadre."Code utilisateur" := CodeUtil;
                                TamponDispoSurCdeCadre."No. commande cadre" := LigneCommandeCadre."Document No.";
                                TamponDispoSurCdeCadre."No. ligne commande cadre" := LigneCommandeCadre."Line No.";
                                TamponDispoSurCdeCadre."No. fournisseur" := LigneCommandeCadre."Buy-from Vendor No.";
                                TamponDispoSurCdeCadre."No. article" := LigneCommandeCadre."No.";
                                TamponDispoSurCdeCadre."Qte commande cadre" := LigneCommandeCadre.Quantity;
                                TamponDispoSurCdeCadre."Qte sur commande achat" := LigneCommandeCadre."Qte sur commande";
                                TamponDispoSurCdeCadre."Quantite recue" := LigneCommandeCadre."Quantity Received";
                                TamponDispoSurCdeCadre."Quantite dispo" := QteDispo;
                                TamponDispoSurCdeCadre.Insert();
                            end;
                        until LigneCommandeCadre.Next() = 0;
                end;
            until ListeFournisseur.Next() = 0;
        //KAN.FHA 16/03/2026 FIN

        //==================================================================================
        //1. CREATION DE NOUVELLES COMMANDES ACHAT AVEC RATTACHEMENT EVENTUEL A COMMANDE CADRE
        //==================================================================================
        TamponDispoSurCdeCadre.Reset();
        TamponDispoSurCdeCadre.SetRange("Code utilisateur", CodeUtil);

        TableTampon.Reset();
        TableTampon.SetCurrentKey("Code utilisateur", "Creer nouvelle commande", "Type document", "No. fournisseur", Type, "No.", "Code variante");
        TableTampon.SetRange("Code utilisateur", CodeUtil);
        TableTampon.SetRange("Creer nouvelle commande", true);
        if TableTampon.FindSet(true) then begin
            lBeforeBuyFromNo := '';
            NbCdeAchatCreees := 0;
            ItemNo := '';
            repeat
                //Création de l'entête
                if (lBeforeBuyFromNo <> TableTampon."No. fournisseur") then begin
                    lrecPurchaseHdr.INIT();
                    lrecPurchaseHdr."No." := '';
                    lrecPurchaseHdr.VALIDATE("Document Type", lrecPurchaseHdr."Document Type"::Order);
                    if CreerDocumentSAV then
                        lrecPurchaseHdr."No. Series" := CodeSoucheCommandeSAV;
                    if ("Document Type" = "Document Type"::Quote) and "Devis Stock" then
                        lrecPurchaseHdr."Achat pour stock" := true;
                    lrecPurchaseHdr.INSERT(true);
                    NbCdeAchatCreees := NbCdeAchatCreees + 1;
                    lrecPurchaseHdr.VALIDATE("Buy-from Vendor No.", TableTampon."No. fournisseur");
                    if TableTampon."Fournisseur divers" then
                        lrecPurchaseHdr.Validate("Buy-from Country/Region Code", TableTampon."Code pays origine");
                    lrecPurchaseHdr.VALIDATE("Purchaser Code", "Salesperson Code");
                    lrecPurchaseHdr.VALIDATE(Commentaires, Commentaire);
                    lrecPurchaseHdr.VALIDATE("Location Code", TableTampon."Code magasin");
                    lrecPurchaseHdr."Code groupe" := "Code groupe";
                    lrecPurchaseHdr."Code enseigne" := "Code enseigne";
                    lrecPurchaseHdr."Code operation" := "Code operation";
                    lrecPurchaseHdr."Code chantier" := "Code chantier";
                    if CreerDocumentSAV then
                        lrecPurchaseHdr."SAV Type" := lrecPurchaseHdr."SAV Type"::FOURNISSEUR;
                    lrecPurchaseHdr."Annee commande" := "Annee commande";
                    //KAN.FHA 19/05/2026 DEBUT
                    if lrecPurchaseHdr."No. doc. vente" = '' then begin
                        case TableTampon."Type document" of
                            'Devis':
                                lrecPurchaseHdr."Type doc. vente" := lrecPurchaseHdr."Type doc. vente"::Quote;
                            'Commande':
                                lrecPurchaseHdr."Type doc. vente" := lrecPurchaseHdr."Type doc. vente"::Order;

                        end;
                        lrecPurchaseHdr."No. doc. vente" := TableTampon."No. document";
                    end else
                        if lrecPurchaseHdr."No. doc. vente" <> TableTampon."No. document" then
                            lrecPurchaseHdr."No. doc. vente" := '';

                    //KAN.FHA 19/05/2026 FIN
                    lrecPurchaseHdr.MODIFY(true);
                    lLineNo := 10000;
                end;

                if (TableTampon.Type = TableTampon.Type::Item) then begin
                    if not Article.GET(TableTampon."No.") then
                        Article.INIT();

                    RemainingQtyToCover := TableTampon.Quantite;

                    //PHASE 1.1 : on crée des lignes de commandes d'achat pour les articles où on trouve une commande cadre encore disponible.
                    //On va d'abord ajouter à la commande achat que les articles pris sur une commande cadre car on veut sur la commande d'achat pouvoir dire
                    //au fournisseur "cela, je t'en avais déjà parlé via ma commande cadre" et dans un 2e temps on fera apparaitre les articles/quantités qui ne 
                    //figuraient pas sur une commande cadre en disant au fournisseur "cela, c'est nouveau, je t'en avais pas parlé."
                    //On cherche si on a une ou plusieurs commandes cadre sur lesquelles commander
                    TamponDispoSurCdeCadre.SetRange("No. fournisseur", TableTampon."No. fournisseur");
                    TamponDispoSurCdeCadre.SetRange("No. article", TableTampon."No.");
                    TamponDispoSurCdeCadre.SetFilter("Quantite dispo", '>0');

                    if TamponDispoSurCdeCadre.FindSet(true) then
                        repeat
                            QtyToTake := 0;
                            if RemainingQtyToCover > TamponDispoSurCdeCadre."Quantite dispo" then
                                QtyToTake := TamponDispoSurCdeCadre."Quantite dispo"
                            else
                                QtyToTake := RemainingQtyToCover;

                            if ItemNo <> TableTampon."No." then begin
                                // On crée la ligne et on RÉCUPÈRE l'enregistrement créé dans lrecPurchaseLine
                                CreerLigneCommandeAchat(lrecPurchaseHdr, TableTampon, lLineNo, QtyToTake, TamponDispoSurCdeCadre);
                                LigneAchatPriseSurCadre.Get(lrecPurchaseHdr."Document Type", lrecPurchaseHdr."No.", lLineNo);
                            end else begin //On met juste à jour la ligne déjà créée
                                LigneAchatPriseSurCadre.Validate(Quantity, LigneAchatPriseSurCadre.Quantity + QtyToTake);
                                LigneAchatPriseSurCadre.Modify();
                            end;

                            // On crée/MAJ l'affectation immédiatement pour cette ligne de cadre
                            MAJLienAchatVente(LigneAchatPriseSurCadre, TableTampon, QtyToTake);

                            // Maj Tampon
                            TamponDispoSurCdeCadre."Quantite dispo" := TamponDispoSurCdeCadre."Quantite dispo" - QtyToTake;
                            TamponDispoSurCdeCadre.Modify();
                            RemainingQtyToCover := RemainingQtyToCover - QtyToTake;
                            lLineNo += 10000;
                        until (RemainingQtyToCover = 0) or (TamponDispoSurCdeCadre.Next() = 0);

                    // On note qu'on devra créer une ligne de commande d'achat hors cadre (sur laquelle on cumulera les quantités vendues d'un meme article)
                    if RemainingQtyToCover > 0 then begin
                        TableTampon."Qte a prendre hors cadre" := RemainingQtyToCover;
                        TableTampon.Modify();
                    end;

                    TableTampon."No. commande achat creee" := lrecPurchaseHdr."No.";
                    TableTampon.Modify();
                end;

                lBeforeBuyFromNo := TableTampon."No. fournisseur";
                ItemNo := TableTampon."No.";
            //VariantCode := TableTampon."Code variante";
            until TableTampon.Next() = 0;

            lrecPurchaseLine.Reset();
            lrecPurchaseLine.SetRange("Document Type", lrecPurchaseLine."Document Type"::Order);

            TamponDispoSurCdeCadre.Reset();
            TamponDispoSurCdeCadre.Init(); //Juste pour envoyer un Record vide pour la fonction CreerLigneCommandeAchat ci-dessous
            TamponDispoSurCdeCadre."No. commande cadre" := '';
            TamponDispoSurCdeCadre."No. ligne commande cadre" := 0;

        end;

        //Phase 1.2
        //On va maintenant reparcourir les lignes de tampon pour créer de nouvelles lignes de commandes hors cadre en cumulant sur l'achat les quantités vendues
        TableTampon.SetFilter("Qte a prendre hors cadre", '<>%1', 0);
        if TableTampon.FindSet(true) then begin
            lBeforeBuyFromNo := '';
            ItemNo := '';
            repeat
                if (TableTampon.Type = TableTampon.Type::Item) and (TableTampon."Qte a prendre hors cadre" <> 0) then begin
                    if TableTampon."No." <> ItemNo then begin
                        //Recherche du dernier N° ligne dans la commande
                        lrecPurchaseLine.SetRange("Document No.", TableTampon."No. commande achat creee");
                        if lrecPurchaseLine.FindLast() then
                            lLineNo := lrecPurchaseLine."Line No." + 10000
                        else
                            lLineNo := 10000;

                        lrecPurchaseHdr.Get(lrecPurchaseHdr."Document Type"::Order, TableTampon."No. commande achat creee");

                        CreerLigneCommandeAchat(lrecPurchaseHdr, TableTampon, lLineNo, TableTampon."Qte a prendre hors cadre", TamponDispoSurCdeCadre);
                        lrecPurchaseLine.Get(lrecPurchaseHdr."Document Type", lrecPurchaseHdr."No.", lLineNo);
                        lLineNo := lLineNo + 10000;
                    end else begin
                        lrecPurchaseLine.Validate(Quantity, lrecPurchaseLine.Quantity + TableTampon."Qte a prendre hors cadre");
                        lrecPurchaseLine.Modify();
                    end;
                    MAJLienAchatVente(lrecPurchaseLine, TableTampon, TableTampon."Qte a prendre hors cadre");
                end;
                ItemNo := TableTampon."No.";
            until TableTampon.Next() = 0;
        end;

        //===================================================================================================
        //PHASE 2 : AJOUT DES LIGNES A COMMANDE EXISTANTE pour les fournisseurs où on a fait ce choix
        //===================================================================================================
        lrecSalesLine.SETRANGE("Document Type", "Document Type");
        lrecSalesLine.SETRANGE("Document No.", "No.");
        lrecSalesLine.SETRANGE(Type, lrecSalesLine.Type::Item);
        if lrecSalesLine.FINDSET(true) then begin
            //KAN.FHA 19/05/2026 DEBUT
            PhaseAchat := -99;
            //KAN.FHA 19/05/2026 FIN
            repeat
                if (lrecSalesLine."Ajouter à cde achat No." <> '') and (lrecSalesLine."Quantite a acheter" <> 0) then begin
                    //KAN.FHA 19/05/2026 DEBUT
                    if lrecSalesLine.Phase <> PhaseAchat then
                        if PhaseAchat = -99 then
                            PhaseAchat := lrecSalesLine.Phase
                        else
                            PhaseAchat := 0;
                    //KAN.FHA 19/05/2026 FIN
                    lrecSalesLine.TESTFIELD("Vendor No.");
                    ListeFournisseur.Reset();
                    ListeFournisseur.SetRange("Code utilisateur", CodeUtil);
                    ListeFournisseur.SetRange("No. fournisseur", lrecSalesLine."Vendor No.");
                    if ListeFournisseur.FindFirst() then
                        if ListeFournisseur."Ajouter a la cde No." <> '' then begin
                            TableTampon.Reset();
                            TableTampon.Init();
                            TableTampon."Code utilisateur" := CodeUtil;
                            TableTampon."Ajouter a la cde No." := ListeFournisseur."Ajouter a la cde No.";
                            TableTampon."Type document" := Format(lrecSalesLine."Document Type");
                            TableTampon."No. document" := lrecSalesLine."Document No.";
                            TableTampon."No. ligne document" := lrecSalesLine."Line No.";
                            TableTampon.Type := lrecSalesLine.Type;
                            TableTampon."No." := lrecSalesLine."No.";
                            TableTampon."Code variante" := lrecSalesLine."Variant Code";
                            TableTampon."Code magasin" := lrecSalesLine."Location Code";
                            TableTampon."Code chantier" := lrecSalesLine."Code chantier";
                            TableTampon.Quantite := lrecSalesLine."Quantite a acheter";
                            TableTampon.Description := lrecSalesLine.Description;
                            TableTampon."No. document vente" := lrecSalesLine."Document No.";
                            TableTampon."No. ligne doc. vente" := lrecSalesLine."Line No.";
                            TableTampon."No. fournisseur" := lrecSalesLine."Vendor No.";
                            TableTampon."Nomenclature produits" := lrecSalesLine."Nomenclature produits";
                            TableTampon."Poids net" := lrecSalesLine."Net Weight";
                            //KAN.FHA 19/05/2026 DEBUT
                            TableTampon."Achete pour phase (si unique)" := PhaseAchat;
                            //KAN.FHA 19/05/2026 FIN
                            TableTampon.Insert();

                            //Lignes texte étendus
                            lrecSalesLine2.Reset();
                            lrecSalesLine2.SetCurrentKey("Document Type", "Document No.", "Linked to line");
                            lrecSalesLine2.SetRange("Document Type", "Document Type");
                            lrecSalesLine2.SetRange("Document No.", "No.");
                            lrecSalesLine2.SetRange("Linked to line", lrecSalesLine."Line No.");
                            lrecSalesLine2.SetRange(Type, lrecSalesLine2.Type::" ");
                            if lrecSalesLine2.FindSet() then
                                repeat
                                    TableTampon.Reset();
                                    TableTampon.Init();
                                    TableTampon."Code utilisateur" := CodeUtil;
                                    TableTampon."Type Document" := format(Rec."Document Type");
                                    TableTampon."No. Document" := "No.";
                                    TableTampon."No. ligne document" := lrecSalesLine2."Line No.";
                                    TableTampon.Type := lrecSalesLine2.Type;
                                    TableTampon."No." := lrecSalesLine2."No.";
                                    TableTampon.Description := lrecSalesLine2.Description;
                                    TableTampon."No. fournisseur" := lrecSalesLine2."Vendor No.";
                                    TableTampon."Ajouter a la cde No." := ListeFournisseur."Ajouter a la cde No.";
                                    TableTampon."Prix achat prevu" := lrecSalesLine2."Prix achat prevu";
                                    TableTampon.Insert();
                                until lrecSalesLine2.Next() = 0;

                            lrecSalesLine."Ajouter à cde achat No." := '';
                            lrecSalesLine.Modify();
                        end;
                end;
            until lrecSalesLine.NEXT() = 0;
        end;

        NbLignesAjoutees := 0;
        NbCdeAchatCompletees := 0;
        TableTampon.Reset();
        TableTampon.SetCurrentKey("Code utilisateur", "Creer nouvelle commande", "Ajouter a la cde No.", Type, "No.", "Code variante");
        TableTampon.SetRange("Code utilisateur", CodeUtil);
        TableTampon.SetRange("Creer nouvelle commande", false);
        if TableTampon.FindSet(false) then begin
            AjouterACdeNo := '';
            ItemNo := '';
            repeat
                //Recuperation de l'entête et du dernier N° ligne
                if TableTampon."Ajouter a la cde No." <> AjouterACdeNo then begin
                    lrecPurchaseHdr.get(lrecPurchaseHdr."Document Type"::Order, TableTampon."Ajouter a la cde No.");
                    lrecPurchaseLine.Reset();
                    lrecPurchaseLine.Setrange("Document Type", lrecPurchaseLine."Document Type"::Order);
                    lrecPurchaseLine.SetRange("Document No.", TableTampon."Ajouter a la cde No.");
                    if lrecPurchaseLine.Findlast() then
                        lLineNo := lrecPurchaseLine."Line No." + 10000
                    else
                        lLineNo := 10000;
                    NbCdeAchatCompletees := NbCdeAchatCompletees + 1;
                end;

                if TableTampon.Type = TableTampon.Type::Item then
                    if not Article.GET(TableTampon."No.") then
                        Article.INIT();

                RemainingQtyToCover := TableTampon.Quantite;

                //PHASE 2.1 : on crée des lignes de commandes d'achat pour les articles où on trouve une commande cadre encore disponible.
                //On va d'abord ajouter à la commande achat que les articles pris sur une commande cadre car on veut sur la commande d'achat pouvoir dire
                //au fournisseur "cela, je t'en avais déjà parlé via ma commande cadre" et dans un 2e temps on fera apparaitre les articles/quantités qui ne 
                //figuraient pas sur une commande cadre en disant au fournisseur "cela, c'est nouveau, je t'en avais pas parlé."
                //On cherche si on a une ou plusieurs commandes cadre sur lesquelles commander
                TamponDispoSurCdeCadre.SetRange("No. fournisseur", TableTampon."No. fournisseur");
                TamponDispoSurCdeCadre.SetRange("No. article", TableTampon."No.");
                TamponDispoSurCdeCadre.SetFilter("Quantite dispo", '>0');

                if TamponDispoSurCdeCadre.FindSet(true) then
                    repeat
                        QtyToTake := 0;
                        if RemainingQtyToCover > TamponDispoSurCdeCadre."Quantite dispo" then
                            QtyToTake := TamponDispoSurCdeCadre."Quantite dispo"
                        else
                            QtyToTake := RemainingQtyToCover;

                        // On crée la ligne et on RÉCUPÈRE l'enregistrement créé dans lrecPurchaseLine
                        if ItemNo <> TableTampon."No." then begin
                            CreerLigneCommandeAchat(lrecPurchaseHdr, TableTampon, lLineNo, QtyToTake, TamponDispoSurCdeCadre);
                            lrecPurchaseLine.Get(lrecPurchaseHdr."Document Type", lrecPurchaseHdr."No.", lLineNo);
                        end else begin
                            lrecPurchaseLine.Validate(Quantity, lrecPurchaseLine.Quantity + QtyToTake);
                            lrecPurchaseLine.Modify();
                        end;

                        // On crée/MAJ l'affectation immédiatement pour cette ligne de cadre
                        MAJLienAchatVente(lrecPurchaseLine, TableTampon, QtyToTake);

                        // Maj Tampon
                        TamponDispoSurCdeCadre."Quantite dispo" := TamponDispoSurCdeCadre."Quantite dispo" - QtyToTake;
                        TamponDispoSurCdeCadre.Modify();
                        RemainingQtyToCover := RemainingQtyToCover - QtyToTake;
                        lLineNo += 10000;
                    until (RemainingQtyToCover = 0) or (TamponDispoSurCdeCadre.Next() = 0);

                // On note qu'on devra créer une ligne de commande d'achat hors cadre (sur laquelle on cumulera les quantités vendues d'un meme article)
                if RemainingQtyToCover > 0 then begin
                    TableTampon."Qte a prendre hors cadre" := RemainingQtyToCover;
                    TableTampon.Modify();
                end;

                TableTampon."No. commande achat creee" := lrecPurchaseHdr."No.";
                TableTampon.Modify();

                lLineNo += 10000;
                AjouterACdeNo := TableTampon."Ajouter a la cde No.";
                ItemNo := TableTampon."No.";
            until TableTampon.Next() = 0;

            lrecPurchaseLine.Reset();
            lrecPurchaseLine.SetRange("Document Type", lrecPurchaseLine."Document Type"::Order);

            TamponDispoSurCdeCadre.Reset();
            TamponDispoSurCdeCadre.Init(); //Juste pour envoyer un Record vide pour la fonction CreerLigneCommandeAchat ci-dessous
            TamponDispoSurCdeCadre."No. commande cadre" := '';
            TamponDispoSurCdeCadre."No. ligne commande cadre" := 0;

            //Phase 2.2
            //On va maintenant reparcourir les lignes de tampon pour créer de nouvelles lignes de commandes hors cadre en cumulant sur l'achat les quantités vendues
            if TableTampon.FindSet(true) then begin
                lBeforeBuyFromNo := '';
                ItemNo := '';
                repeat
                    if (TableTampon.Type = TableTampon.Type::Item) and (TableTampon."Qte a prendre hors cadre" <> 0) then begin
                        if TableTampon."No." <> ItemNo then begin
                            //Recherche du dernier N° ligne dans la commande
                            lrecPurchaseLine.SetRange("Document No.", TableTampon."No. commande achat creee");
                            if lrecPurchaseLine.FindLast() then
                                lLineNo := lrecPurchaseLine."Line No." + 10000
                            else
                                lLineNo := 10000;

                            lrecPurchaseHdr.Get(lrecPurchaseHdr."Document Type"::Order, TableTampon."No. commande achat creee");
                            //KAN.FHA 19/05/2026 DEBUT
                            if lrecPurchaseHdr."Info phases" <> format(TableTampon."Achete pour phase (si unique)") then begin
                                lrecPurchaseHdr."Info phases" := format(TableTampon."Achete pour phase (si unique)");
                                lrecPurchaseHdr.Modify();
                            end;
                            //KAN.FHA 19/05/2026 FIN
                            CreerLigneCommandeAchat(lrecPurchaseHdr, TableTampon, lLineNo, TableTampon."Qte a prendre hors cadre", TamponDispoSurCdeCadre);
                            lrecPurchaseLine.Get(lrecPurchaseHdr."Document Type", lrecPurchaseHdr."No.", lLineNo);
                            lLineNo := lLineNo + 10000;
                            NbLignesAjoutees := NbLignesAjoutees + 1;
                        end else begin
                            lrecPurchaseLine.Validate(Quantity, lrecPurchaseLine.Quantity + TableTampon."Qte a prendre hors cadre");
                            lrecPurchaseLine.Modify();
                        end;
                        MAJLienAchatVente(lrecPurchaseLine, TableTampon, TableTampon."Qte a prendre hors cadre");
                    end;
                    ItemNo := TableTampon."No.";
                until TableTampon.Next() = 0;
            end;
        end;

        if (NbCdeAchatCreees + NbCdeAchatCompletees) = 1 then
            pPurchOrderNo := lrecPurchaseHdr."No."
        else
            pPurchOrderNo := '';

        if (NbCdeAchatCreees > 0) or (NbLignesAjoutees > 0) or (NbCdeAchatCompletees > 0) then begin
            pNbCdesCreees := NbCdeAchatCreees;
            pNbCdesCompletees := NbCdeAchatCompletees;
            pNbLignesAjoutees := NbLignesAjoutees;
            exit(true)
        end else
            exit(false);
    end;

    procedure CreerLigneCommandeAchat(Var EnteteAchat: Record "Purchase Header"; TableTamponVente: Record TamponTriLignesDocument; LineNo: Integer; QtyToOrder: Decimal; var TamponCadre: record "Tampon dispo cde cadre achat")
    var
        lrecPurchaseLine: Record "Purchase Line";
        Article: Record Item;
    begin
        if QtyToOrder = 0 then
            exit;

        lrecPurchaseLine.INIT();
        lrecPurchaseLine.VALIDATE("Document Type", EnteteAchat."Document Type");
        lrecPurchaseLine.VALIDATE("Document No.", EnteteAchat."No.");
        lrecPurchaseLine."Line No." := LineNo;
        lrecPurchaseLine.INSERT(true); // On insère tôt pour que les VALIDATE suivants fonctionnent bien

        lrecPurchaseLine.VALIDATE(Type, lrecPurchaseLine.Type::Item);
        lrecPurchaseLine.VALIDATE("No.", TableTamponVente."No.");
        lrecPurchaseLine.VALIDATE("Variant Code", TableTamponVente."Code variante");
        lrecPurchaseLine.VALIDATE("Location Code", TableTamponVente."Code magasin");

        // SI on a un cadre, on lie la ligne AVANT de valider la quantité
        if TamponCadre."No. commande cadre" <> '' then begin
            lrecPurchaseLine.VALIDATE("Blanket Order No.", TamponCadre."No. commande cadre");
            lrecPurchaseLine.VALIDATE("Blanket Order Line No.", TamponCadre."No. ligne commande cadre");
            // Le VALIDATE de BC va normalement récupérer le prix de la commande cadre tout seul
        end;

        lrecPurchaseLine.VALIDATE(Quantity, QtyToOrder);

        // Reprise des champs spécifiques de ton algo
        lrecPurchaseLine.Description := TableTamponVente.Description;
        lrecPurchaseLine."Nomenclature produits" := TableTamponVente."Nomenclature produits";
        Article.Get(TableTamponVente."No.");

        if Article."Miscellaneous Item" then begin
            lrecPurchaseLine."Net Weight" := TableTamponVente."Poids net";
            if TableTamponVente."Prix achat prevu" <> 0 then
                lrecPurchaseLine.Validate("Direct Unit Cost", TableTamponVente."Prix achat prevu");
        end;
        //lrecPurchaseLine."Annee commande" := "Annee commande";
        if TableTamponVente."Fournisseur divers" then
            lrecPurchaseLine."Country/Region of Origin Code" := TableTamponVente."Code pays origine";

        lrecPurchaseLine."Annee commande" := EnteteAchat."Annee commande";

        if TableTamponVente."Fournisseur divers" then
            lrecPurchaseLine."Country/Region of Origin Code" := TableTamponVente."Code pays origine";

        lrecPurchaseLine.MODIFY(true);

    end;

    procedure MAJLienAchatVente(pLigneAchat: record "Purchase Line"; pTableTampon: record TamponTriLignesDocument; pQuantiteAffectee: Decimal)
    var
        LienAchatVente: Record "Affectations achat vente";
        TypeDoc: Integer;
    begin
        if "Devis Stock" then
            exit;

        case "Document Type" of
            "Document Type"::Order:
                TypeDoc := 1;
            "Document Type"::Quote:
                TypeDoc := 0;
        end;

        if not LienAchatVente.Get(pLigneAchat."Document No.", pLigneAchat."Line No.", TypeDoc, Rec."No.", pTableTampon."No. ligne doc. vente") then begin
            LienAchatVente.INIT();
            LienAchatVente."No. document achat" := pLigneAchat."Document No.";
            LienAchatVente."No. ligne document achat" := pLigneAchat."Line No.";
            LienAchatVente."Type document vente" := TypeDoc;
            LienAchatVente."No. document vente" := Rec."No.";
            LienAchatVente."No. ligne document vente" := pTableTampon."No. ligne doc. vente";
            LienAchatVente.Insert();
        end;

        //LienAchatVente."Quantite affectee" := LienAchatVente."Quantite affectee" + pQuantiteAffectee;
        LienAchatVente."No. donneur ordre" := "Sell-to Customer No.";
        LienAchatVente."Quantite affectee" := pQuantiteAffectee;
        LienAchatVente.Modify();
    end;

    procedure EstimerFraisApproche()
    var
        LigneVente: Record "Sales Line";
        TamponFraisApproche: Record TamponBudgetApprocheDocument;
        Fournisseur: Record Vendor;
        Pays: Record "Country/Region";
        CodePays: Code[10];
    begin
        TamponFraisApproche.SetRange("Code utilisateur", UserId);
        TamponFraisApproche.DeleteAll();

        LigneVente.Reset();
        LigneVente.SetCurrentKey("Document Type", "Document No.", Type, "Vendor No.");
        LigneVente.SetRange("Document Type", "Document Type");
        LigneVente.SetRange("Document No.", "No.");
        LigneVente.SetRange(Type, LigneVente.Type::Item);
        if LigneVente.FindSet(true) then
            repeat
                //if LigneVente."Vendor No." <> '' then begin
                CodePays := LigneVente."Country/Region of Origin Code";
                if CodePays = '' then
                    if Fournisseur.get(LigneVente."Vendor No.") then
                        CodePays := Fournisseur."Country/Region Code";

                if not TamponFraisApproche.get(UserId, LigneVente."Document Type", LigneVente."Document No.", CodePays) then begin
                    TamponFraisApproche.Init();
                    TamponFraisApproche."Code utilisateur" := copystr(UserId, 1, 50);
                    TamponFraisApproche."Type document" := LigneVente."Document Type";
                    TamponFraisApproche."No. document" := LigneVente."Document No.";
                    TamponFraisApproche."Code pays origine" := CodePays;
                    if not Pays.Get(CodePays) then
                        Pays.Init();
                    TamponFraisApproche."% frais approche" := Pays."% frais approche";
                    TamponFraisApproche."Type ligne" := TamponFraisApproche."Type ligne"::"Budget approche";

                    TamponFraisApproche.Insert();
                end;
                TamponFraisApproche."Montant achats prevus" := TamponFraisApproche."Montant achats prevus" + LigneVente."Montant achats prevus (DS)";
                TamponFraisApproche."Budget frais approche (DS)" := Round(TamponFraisApproche."% frais approche" / 100 * TamponFraisApproche."Montant achats prevus", 1);
                TamponFraisApproche."Poids net" := TamponFraisApproche."Poids net" + (LigneVente.Quantity * LigneVente."Net Weight");
                TamponFraisApproche."Poids brut" := TamponFraisApproche."Poids brut" + (LigneVente.Quantity * LigneVente."Gross Weight");
                TamponFraisApproche.Quantite := TamponFraisApproche.Quantite + LigneVente.Quantity;
                TamponFraisApproche.Modify();
            //end;
            until LigneVente.Next() = 0;
    end;

    /*
    procedure RepousserAcompte()
    var
        LigneVente: Record "Sales Line";
        LigneVente2: Record "Sales Line";
        NouvNumLigne: Integer;
        LigneAcompteInexistanteMsg: Label 'Il n''y a pas de ligne déduisant l''acompte.';
    begin
        //Cette fonction sert uniquement à éloigner la ligne qui déduit l'acompte vers la fin du document car elle embête les chargés d'affaire
        //On cherche la ligne d'acompte
        LigneVente.RESET();
        LigneVente.SETRANGE("Document Type", "Document Type");
        LigneVente.SETRANGE("Document No.", "No.");
        LigneVente.SETRANGE("Ligne deduction acompte", true);
        if LigneVente.FINDFIRST() then begin
            //On vérifie qu'elle n'a pas déjà été livrée
            LigneVente.TESTFIELD("Quantity Shipped", 0);
            //On cherche le dernier N° ligne utilisé
            LigneVente2.SETRANGE("Document Type", "Document Type");
            LigneVente2.SETRANGE("Document No.", "No.");
            LigneVente2.FINDLAST();
            NouvNumLigne := LigneVente2."Line No." + 100000;
            //On crée une nouvelle ligne à la fin du document en recopiant la ligne d'acompte
            LigneVente2.RESET();
            LigneVente2.INIT();
            LigneVente2.TRANSFERFIELDS(LigneVente, false);
            LigneVente2."Document Type" := "Document Type";
            LigneVente2."Document No." := "No.";
            LigneVente2."Line No." := NouvNumLigne;
            LigneVente2.INSERT();

            //On supprime la ligne d'acompte d'origine
            LigneVente.SetHideValidationDialog(true);
            LigneVente.DELETE(true);
        end else
            MESSAGE(LigneAcompteInexistanteMsg);
    end;
    */
    procedure CreerFactureAcompte()
    var
        EnteteFactureVente: Record "Sales Header";
        LigneFactureVente: Record "Sales Line";
        GroupeComptaMarche: Record "Gen. Business Posting Group";
        ParamCompta: Record "General Ledger Setup";
        //ClientDonneurOrdre: Record Customer;
        Enseigne: Record Enseigne;
        Chantier: Record Chantier;
        AbandonCreationAcompteErr: Label 'L''acompte n''a pas été créé.';
        CreerAcompteQst: Label 'Souhaitez-vous créer une facture d''acompte ?';
        MontantAcompte: Decimal;
        AcompteDejaCreeErr: Label 'Un acompte a déjà été créé. L''opération n''est pas possible.';
        TexteLigneAcompteLbl: Label 'Acompte de %1% sur %2 %3', Comment = '%1 = Montant ; %2 = Type document ; %3 = N° document';
        TexteLigneMarcheLbl: Label 'Montant du marché : %1 %2 H.T.', Comment = '%1 = Montant ; %2 = Devise';
        txtDevise: Code[10];

        LibelleEcritureLbl: Label 'Acpt %1% %2 %3 %4', Comment = '%1= % acompte demande" %2 = NumDoc %3 = Description chantier %4 = Nom du client';
        NumDoc: Code[20];
        txtLibelleEcriture: Text[250];

    begin
        //KAN.FHA 09/06/2020
        if not ("Document Type" in ["Document Type"::Quote, "Document Type"::Order]) then
            exit;

        if not Confirm(CreerAcompteQst) then
            Error(AbandonCreationAcompteErr);

        if ("No. facture acompte" <> '') or ("No. facture acompte enregistre" <> '') then
            Error(AcompteDejaCreeErr);

        TestField("% acompte demande");
        GroupeComptaMarche.Get("Gen. Bus. Posting Group");
        GroupeComptaMarche.TestField("Compte acompte");

        Chantier.Get("Code chantier");
        Enseigne.Get("Code enseigne");
        Enseigne.TestField("Code cond. paiement acomptes");

        CalcFields(Amount);

        MontantAcompte := Round(Amount * "% acompte demande" / 100, 0.01);

        if "Currency Code" <> '' then
            txtDevise := "Currency Code"
        else begin
            ParamCompta.Get();
            txtDevise := ParamCompta."LCY Code";
        end;

        if "Quote No." <> '' then
            NumDoc := "Quote No."
        else
            NumDoc := "No.";

        EnteteFactureVente.INIT();
        EnteteFactureVente."Document Type" := EnteteFactureVente."Document Type"::Invoice;
        EnteteFactureVente.INSERT(true);
        EnteteFactureVente.VALIDATE("Sell-to Customer No.", "Sell-to Customer No.");
        EnteteFactureVente.VALIDATE("Bill-to Customer No.", "Bill-to Customer No.");
        "Posting Date" := 0D;
        EnteteFactureVente.VALIDATE("Document Date", TODAY);
        EnteteFactureVente.MODIFY();
        EnteteFactureVente."Code groupe" := Enseigne."Code groupe";
        EnteteFactureVente."Code enseigne" := "Code enseigne";
        EnteteFactureVente."Code chantier" := "Code chantier";

        EnteteFactureVente."Ship-to Name" := "Ship-to Name";
        EnteteFactureVente."Ship-to Name 2" := "Ship-to Name 2";
        EnteteFactureVente."Ship-to Address" := "Ship-to Address";
        EnteteFactureVente."Ship-to Address 2" := "Ship-to Address 2";
        EnteteFactureVente."Ship-to Post Code" := "Ship-to Post Code";
        EnteteFactureVente."Ship-to City" := "Ship-to City";
        EnteteFactureVente."Ship-to Country/Region Code" := "Ship-to Country/Region Code";
        EnteteFactureVente."Ship-to Contact" := "Ship-to Contact";

        EnteteFactureVente.Commentaire := Commentaire;
        EnteteFactureVente."Salesperson Code" := "Salesperson Code";
        case "Document Type" of
            "Document Type"::Quote:
                EnteteFactureVente."Acompte pour type doc." := EnteteFactureVente."Acompte pour type doc."::Devis;
            "Document Type"::Order:
                EnteteFactureVente."Acompte pour type doc." := EnteteFactureVente."Acompte pour type doc."::Commande;
        end;
        EnteteFactureVente."Acompte pour No. document" := "No.";
        EnteteFactureVente."Facture acompte" := true;
        //KAN.FHA 08/02/2021 DEBUT
        //KAN.FHA 15/04/2025 ClientDonneurOrdre.GET("Sell-to Customer No.");
        //KAN.FHA 15/04/2025if ClientDonneurOrdre."Code cond. paiement acomptes" <> '' then
        EnteteFactureVente.VALIDATE("Payment Terms Code", "Code cond. paiement acomptes");
        //KAN.FHA 15/04/2025else
        //KAN.FHA 08/02/2021 FIN
        //KAN.FHA 15/04/2025    EnteteFactureVente.VALIDATE("Payment Terms Code", Enseigne."Code cond. paiement acomptes");
        txtLibelleEcriture := STRSUBSTNO(LibelleEcritureLbl, FORMAT("% acompte demande"), NumDoc, Chantier."Description chantier", "Sell-to Customer Name");
        EnteteFactureVente."Posting Description" := COPYSTR(txtLibelleEcriture, 1, 50);
        EnteteFactureVente."External Document No." := "External Document No.";
        if "Document Type" = "Document Type"::Quote then
            EnteteFactureVente."Quote No." := "No."
        else
            EnteteFactureVente."Quote No." := "Quote No.";

        EnteteFactureVente.MODIFY();

        "No. facture acompte" := EnteteFactureVente."No.";
        MODIFY();

        //Ajouter une ligne sur le bon compte (fonction du groupe compta marché)
        LigneFactureVente.INIT();
        LigneFactureVente."Document Type" := EnteteFactureVente."Document Type";
        LigneFactureVente."Document No." := EnteteFactureVente."No.";
        LigneFactureVente."Line No." := 10000;
        LigneFactureVente.VALIDATE(Type, LigneFactureVente.Type::"G/L Account");
        LigneFactureVente.VALIDATE("No.", GroupeComptaMarche."Compte acompte");
        LigneFactureVente.VALIDATE(Quantity, 1);
        LigneFactureVente.VALIDATE("Unit Price", MontantAcompte);
        if "Quote No." <> '' then
            LigneFactureVente.Description := STRSUBSTNO(TexteLigneAcompteLbl, FORMAT("% acompte demande"), FORMAT("Document Type"::Quote), "Quote No.")
        else
            LigneFactureVente.Description := STRSUBSTNO(TexteLigneAcompteLbl, FORMAT("% acompte demande"), FORMAT("Document Type"), "No.");
        LigneFactureVente.INSERT();

        LigneFactureVente.INIT();
        LigneFactureVente."Document Type" := EnteteFactureVente."Document Type";
        LigneFactureVente."Document No." := EnteteFactureVente."No.";
        LigneFactureVente."Line No." := 20000;
        LigneFactureVente.VALIDATE(Type, LigneFactureVente.Type::" ");
        LigneFactureVente.Description := STRSUBSTNO(TexteLigneMarcheLbl, FORMAT(Amount), txtDevise);
        LigneFactureVente.INSERT();

        //Ouvrir le document à l'écran
        PAGE.RUN(PAGE::"Sales Invoice", EnteteFactureVente);

    end;

    procedure DefinirPctAcompte(): Decimal
    var
        ConditionsAcompte: Record "Conditions acompte";
        InfoSoc: Record "Company Information";
    begin
        InfoSoc.GET();

        CALCFIELDS(Amount);
        ConditionsAcompte.SETRANGE(Type, ConditionsAcompte.Type::Client);
        ConditionsAcompte.SETRANGE(Code, "Sell-to Customer No.");
        //KAN.FHA 17/06/2021 DEBUT
        ConditionsAcompte.SETFILTER("% acompte demande", '<>%1', 0);
        //KAN.FHA 17/06/2021 FIN
        if ConditionsAcompte.FINDSET() then begin
            ConditionsAcompte.SETRANGE("Montant minimum", 0, Amount);
            if ConditionsAcompte.FINDLAST() then
                exit(ConditionsAcompte."% acompte demande")
            else
                exit(0);
        end else begin
            if "Sell-to Country/Region Code" <> InfoSoc."Country/Region Code" then
                exit(100);

            ConditionsAcompte.SETRANGE(Type, ConditionsAcompte.Type::Enseigne);
            ConditionsAcompte.SETRANGE(Code, "Code enseigne");
            ConditionsAcompte.SETRANGE("Montant minimum", 0, Amount);
            ConditionsAcompte.SETFILTER("% acompte demande", '<>%1', 0);

            if ConditionsAcompte.FINDLAST() then
                exit(ConditionsAcompte."% acompte demande")
            else
                exit(0);
        end;
    end;

    procedure CreerFactureSituation()
    var
        EnteteFactureVente: Record "Sales Header";
        LigneFactureVente: Record "Sales Line";
        GroupeComptaMarche: Record "Gen. Business Posting Group";
        ParamCompta: Record "General Ledger Setup";
        Enseigne: Record Enseigne;
        Chantier: Record Chantier;

        AbandonCreationAcompteErr: Label 'La facture de situation n''a pas été créée.';
        CreerAcompteQst: Label 'Souhaitez-vous créer une facture de situation ?';

        MontantAcompte: Decimal;
        FactureSituationDejaCreeeErr: Label 'Une facture de situation a déjà été créée. L''opération n''est pas possible.';
        TexteLigneAcompteLbl: Label 'Second acompte de %1% sur %2 %3', Comment = '%1 = % acompte situation demande" %2 = Type document %3 = N° document';
        TexteLigneMarcheLbl: Label 'Montant du marché : %1 %2 H.T.', Comment = '%1 = Montant %2 = Devise';
        ValiderFactAcompteAvantErr: Label 'Une facture d''acompte attend d''être validée. Vous ne pouvez pas créer de facture de situation avant que l''acompte n''a été validé.';
        CreerAcompteAvantErr: Label 'Etablissez plutôt une facture d''acompte. Une situation ne peut être faite qu''à la suite d''un acompte préalable.';
        txtDevise: Code[10];

    begin
        //KAN.FHA 06/07/2020
        if not ("Document Type" in ["Document Type"::Quote, "Document Type"::Order]) then
            exit;

        if ("No. facture situation" <> '') or ("No. facture situat. enregistre" <> '') then
            ERROR(FactureSituationDejaCreeeErr);

        if (rec."No. facture acompte" = '') and (Rec."No. facture acompte enregistre" = '') then
            Error(CreerAcompteAvantErr);

        if rec."No. facture acompte" <> '' then
            error(ValiderFactAcompteAvantErr);

        TESTFIELD("% acompte situation demande");
        GroupeComptaMarche.GET("Gen. Bus. Posting Group");
        GroupeComptaMarche.TESTFIELD("Compte acompte");

        Chantier.GET("Code chantier");
        Enseigne.GET("Code enseigne");

        CALCFIELDS(Amount);

        MontantAcompte := ROUND(Amount * "% acompte situation demande" / 100, 0.01);

        if "Currency Code" <> '' then
            txtDevise := "Currency Code"
        else begin
            ParamCompta.GET();
            txtDevise := ParamCompta."LCY Code";
        end;

        if not CONFIRM(CreerAcompteQst) then
            ERROR(AbandonCreationAcompteErr);

        EnteteFactureVente.INIT();
        EnteteFactureVente."Document Type" := EnteteFactureVente."Document Type"::Invoice;
        EnteteFactureVente.INSERT(true);
        EnteteFactureVente.VALIDATE("Sell-to Customer No.", "Sell-to Customer No.");
        EnteteFactureVente.VALIDATE("Bill-to Customer No.", "Bill-to Customer No.");
        EnteteFactureVente."Posting Date" := 0D;
        EnteteFactureVente.VALIDATE("Document Date", TODAY);
        EnteteFactureVente.MODIFY();
        EnteteFactureVente."Code groupe" := Enseigne."Code groupe";
        EnteteFactureVente."Code enseigne" := "Code enseigne";
        EnteteFactureVente."Code chantier" := "Code chantier";
        EnteteFactureVente."Ship-to Name" := Chantier."Nom chantier";
        EnteteFactureVente."Ship-to Name 2" := Chantier."Nom chantier 2";
        EnteteFactureVente."Ship-to Address" := Chantier."Adresse chantier";
        EnteteFactureVente."Ship-to Address 2" := Chantier."Adresse chantier 2";
        EnteteFactureVente."Ship-to Post Code" := Chantier."Code postal chantier";
        EnteteFactureVente."Ship-to City" := Chantier."Ville chantier";
        EnteteFactureVente."Ship-to Country/Region Code" := Chantier."Code pays chantier";
        EnteteFactureVente."Ship-to Contact" := Chantier."Contact chantier";

        EnteteFactureVente.Commentaire := Commentaire;
        EnteteFactureVente."Salesperson Code" := "Salesperson Code";
        case "Document Type" of
            "Document Type"::Quote:
                EnteteFactureVente."Fact. situation : type doc." := EnteteFactureVente."Fact. situation : type doc."::Devis;
            "Document Type"::Order:
                EnteteFactureVente."Fact. situation : type doc." := EnteteFactureVente."Fact. situation : type doc."::Commande;
        end;
        EnteteFactureVente."Fact. situation : No. document" := "No.";
        EnteteFactureVente."Facture situation" := true;
        //EnteteFactureVente.VALIDATE("Payment Terms Code",Enseigne."Code cond. paiement acomptes");
        EnteteFactureVente.MODIFY();

        "No. facture situation" := EnteteFactureVente."No.";
        MODIFY();

        LigneFactureVente.INIT();
        LigneFactureVente."Document Type" := EnteteFactureVente."Document Type";
        LigneFactureVente."Document No." := EnteteFactureVente."No.";
        LigneFactureVente."Line No." := 10000;
        LigneFactureVente.VALIDATE(Type, LigneFactureVente.Type::"G/L Account");
        LigneFactureVente.VALIDATE("No.", GroupeComptaMarche."Compte acompte");
        LigneFactureVente.VALIDATE(Quantity, 1);
        LigneFactureVente.VALIDATE("Unit Price", MontantAcompte);
        if "Quote No." <> '' then
            LigneFactureVente.Description := STRSUBSTNO(TexteLigneAcompteLbl, FORMAT("% acompte situation demande"), FORMAT("Document Type"::Quote), "Quote No.")
        else
            LigneFactureVente.Description := STRSUBSTNO(TexteLigneAcompteLbl, FORMAT("% acompte situation demande"), FORMAT("Document Type"), "No.");
        LigneFactureVente.INSERT();

        LigneFactureVente.INIT();
        LigneFactureVente."Document Type" := EnteteFactureVente."Document Type";
        LigneFactureVente."Document No." := EnteteFactureVente."No.";
        LigneFactureVente."Line No." := 20000;
        LigneFactureVente.VALIDATE(Type, LigneFactureVente.Type::" ");
        LigneFactureVente.Description := STRSUBSTNO(TexteLigneMarcheLbl, FORMAT(Amount), txtDevise);
        LigneFactureVente.INSERT();

        //Ouvrir le document à l'écran
        page.RUN(page::"Sales Invoice", EnteteFactureVente);
    end;

    procedure VerifChampsAffaire()
    var
        Groupe: Record "Groupe client";
        Enseigne: Record Enseigne;
        Chantier: Record Chantier;
        CodeGroupeErr: Label 'Le Groupe est incohérent avec le groupe de l''enseigne.';
        CodeEnseigneErr: Label 'L''enseigne n''est pas la même entre le document et le chantier.';
    begin
        //KAN.FHA 10/08/2020
        //Cette fonction est notamment appelée quand on cherche à facturer une vente (CU80).
        TESTFIELD("Code chantier");
        TESTFIELD("Code groupe");
        TESTFIELD("Code enseigne");
        Enseigne.GET("Code enseigne");
        Groupe.GET("Code groupe");
        Chantier.GET("Code chantier");

        if "Code groupe" <> Enseigne."Code groupe" then
            ERROR(CodeGroupeErr);

        if "Code enseigne" <> Chantier."Code enseigne" then
            ERROR(CodeEnseigneErr);
    end;

    procedure DefinirConditionsPaiement()
    var
        ClientDonneurOrdre: Record Customer;
        Enseigne: Record Enseigne;
    begin
        if not ("Document Type" in ["Document Type"::Quote, "Document Type"::Order]) then
            exit;

        if not ClientDonneurOrdre.GET("Sell-to Customer No.") then
            ClientDonneurOrdre.INIT();

        if not Enseigne.GET("Code enseigne") then
            Enseigne.INIT();

        if ClientDonneurOrdre."Code cond. paiement acomptes" <> '' then
            "Code cond. paiement acomptes" := ClientDonneurOrdre."Code cond. paiement acomptes"
        else
            "Code cond. paiement acomptes" := Enseigne."Code cond. paiement acomptes";

        if ClientDonneurOrdre."Payment Terms Code" <> '' then
            VALIDATE("Payment Terms Code", ClientDonneurOrdre."Payment Terms Code")
        else
            VALIDATE("Payment Terms Code", Enseigne."Code conditions paiement");

        if ClientDonneurOrdre."% acompte situation" <> 0 then
            Validate("% acompte situation demande", ClientDonneurOrdre."% acompte situation")
        else
            Validate("% acompte situation demande", Enseigne."% acompte situation");

        if ClientDonneurOrdre."Code cond. paiement situation" <> '' then
            "Code cond. paiement situation" := ClientDonneurOrdre."Code cond. paiement situation"
        else
            "Code cond. paiement situation" := Enseigne."Code cond. paiement situation";
    end;

    procedure CalculerPoidsTotal()
    var
        l_SalesLine: Record "Sales Line";
        l_TotalNetWeight: Decimal;
        l_TotalGrossWeight: Decimal;
    begin
        l_TotalNetWeight := 0;
        l_SalesLine.SETRANGE("Document Type", "Document Type");
        l_SalesLine.SETRANGE("Document No.", "No.");
        l_SalesLine.SETRANGE(Type, l_SalesLine.Type::Item);
        l_SalesLine.SETRANGE("Ligne eclatee", false);
        if l_SalesLine.FINDSET(false) then
            repeat
                l_TotalNetWeight := l_TotalNetWeight + (l_SalesLine."Net Weight" * l_SalesLine.Quantity);
                l_TotalGrossWeight := l_TotalGrossWeight + (l_SalesLine."Gross Weight" * l_SalesLine.Quantity);
            until l_SalesLine.NEXT() = 0;

        "Total Net Weight" := l_TotalNetWeight;
        "Poids brut total" := l_TotalGrossWeight;
        MODIFY();
    end;

    //procedure RemplirQteExpedierPhase()
    //var
    //PhasesChantier: Record "Phases chantier";
    //l_SalesLine: Record "Sales Line";
    //begin
    /*
    PhasesChantier.SETRANGE("Code chantier", "Code chantier");

    if page.RUNMODAL(page::"Phases chantier", PhasesChantier) = action::LookupOK then begin
        l_SalesLine.SETRANGE("Document Type", "Document Type");
        l_SalesLine.SETRANGE("Document No.", "No.");
        if l_SalesLine.FINDSET(true) then
            repeat
                if not ((l_SalesLine."Attached to Line No." <> 0) or (l_SalesLine."Eco Tax Furniture Line")) then begin
                    if l_SalesLine."Code phase" = PhasesChantier.Code then
                        l_SalesLine.VALIDATE("Qty. to Ship", l_SalesLine."Outstanding Quantity")
                    else
                        l_SalesLine.VALIDATE("Qty. to Ship", 0);
                    l_SalesLine.MODIFY();
                end;
            until l_SalesLine.NEXT() = 0;
    end;
    */
    //end;

    procedure DefMasquerVerifCredit(pCacher: Boolean)
    begin
        HideCreditCheckDialogue := pCacher;
    end;

    procedure MAJDescriptionsEnFRA()
    var
        lLigneVente: Record "Sales Line";
        Article: Record Item;
        VarianteArticle: Record "Item Variant";
        TraduireEnFRAQst: Label 'Voulez-vous que les désignations des articles soient en français ?\Les articles divers ne sont pas concernés.\Attention, si vous aviez personnalisé certaines désignations sur les lignes, ces personnalisations seront perdues.';
    begin

        if not CONFIRM(TraduireEnFRAQst, false) THEN
            exit;
        lLigneVente.SETRANGE("Document Type", "Document Type");
        lLigneVente.SETRANGE("Document No.", "No.");
        lLigneVente.SETRANGE(Type, lLigneVente.Type::Item);
        if lLigneVente.FINDSET(true) then
            repeat
                if not lLigneVente."Article divers" then
                    if lLigneVente."Variant Code" = '' then
                        if Article.GET(lLigneVente."No.") then begin
                            lLigneVente.Description := Article.Description;
                            lLigneVente.MODIFY();
                        end
                        else
                            if VarianteArticle.GET(lLigneVente."No.", lLigneVente."Variant Code") THEN
                                if VarianteArticle.Description <> '' then begin
                                    lLigneVente.Description := VarianteArticle.Description;
                                    lLigneVente.MODIFY();
                                end else
                                    if Article.GET(lLigneVente."No.") then begin
                                        lLigneVente.Description := Article.Description;
                                        lLigneVente.MODIFY();
                                    end

                                    else
                                        IF Article.GET(lLigneVente."No.") THEN begin
                                            lLigneVente.Description := Article.Description;
                                            lLigneVente.MODIFY();
                                        end
            UNTIL lLigneVente.NEXT() = 0;
    end;

    procedure MAJDescriptionsEnENU()
    var
        lLigneVente: Record "Sales Line";
        TraductionArticle: Record "Item Translation";
        TraduireEnENUQst: Label 'Voulez-vous que les désignations des articles soient en anglais ?\Les articles divers ne sont pas concernés.\Attention, si vous aviez personnalisé certaines désignations sur les lignes, ces personnalisations seront perdues.';
    begin

        if not Confirm(TraduireEnENUQst, FALSE) THEN
            exit;

        lLigneVente.SETRANGE("Document Type", "Document Type");
        lLigneVente.SETRANGE("Document No.", "No.");
        lLigneVente.SETRANGE(Type, lLigneVente.Type::Item);
        if lLigneVente.FINDSET(true) THEN
            repeat
                if not lLigneVente."Article divers" then
                    if TraductionArticle.GET(lLigneVente."No.", lLigneVente."Variant Code", 'ENU') then begin
                        lLigneVente.Description := TraductionArticle.Description;
                        lLigneVente.MODIFY();
                    end
            until lLigneVente.NEXT() = 0;
    end;

    procedure AfficherStockDispo()
    var
        LigneVente: Record "Sales Line";
        EnteteVente: Record "Sales Header";
        Article: Record Item;
        StockDispo: Record "Stock dispo pour creer cde";
        TamponDetailDispoStock: Record TamponDetailDispoStock;
        AffectationsAchat: Record "Affectations achat vente";
        decQtePriseSurStockCetteLigne: Decimal;
        QteDispo: Decimal;
        CodeUtilisateur: code[50];
        NumLigne: Integer;
    begin
        CodeUtilisateur := copystr(UserId, 1, 50);
        StockDispo.SetRange("Code utilisateur", CodeUtilisateur);
        StockDispo.DeleteAll();

        TamponDetailDispoStock.Reset();
        TamponDetailDispoStock.SetRange("Code utilisateur", CodeUtilisateur);
        TamponDetailDispoStock.DeleteAll();

        LigneVente.SetCurrentKey("Document Type", "Document No.", Type, "Vendor No.");
        LigneVente.SetRange("Document Type", "Document Type");
        LigneVente.SetRange("Document No.", "No.");
        LigneVente.SetRange(Type, LigneVente.Type::Item);
        NumLigne := 10000;

        if LigneVente.FindSet(false) then
            repeat
                LigneVente.calcfields("Quantite affectee");
                if Article.Get(LigneVente."No.") then begin
                    Article.CalcFields("Assembly BOM");
                    if not (Article."Miscellaneous Item") and not (Article."Assembly BOM") then begin
                        Article.SetFilter("Location Filter", LigneVente."Location Code");
                        if LigneVente."Variant Code" <> '' then
                            Article.SetRange("Variant Filter", LigneVente."Variant Code")
                        else
                            Article.SetRange("Variant Filter");

                        Article.CalcFields(Inventory, "Qty. on Sales Order", "Qty. on Purch. Order");
                        QteDispo := Article.Inventory - Article."Qty. on Sales Order";
                        if QteDispo < 0 then
                            QteDispo := 0;

                        //On va lister tous les articles présents dans le document et n'afficher qu'une seule fois un article si présent sur plusieurs lignes
                        if not StockDispo.Get(CodeUtilisateur, "Document Type", "No.", StockDispo."Type ligne"::"Stock dispo", LigneVente."Location Code", LigneVente."No.", LigneVente."Variant Code") then begin
                            StockDispo.Init();
                            StockDispo."Code utilisateur" := CodeUtilisateur;
                            StockDispo."Document Type" := LigneVente."Document Type";
                            StockDispo."Document No." := LigneVente."Document No.";
                            StockDispo."Type ligne" := StockDispo."Type ligne"::"Stock dispo";
                            StockDispo."Code magasin" := LigneVente."Location Code";
                            StockDispo."No. article" := LigneVente."No.";
                            StockDispo."Code variante" := LigneVente."Variant Code";
                            StockDispo.Stock := Article.Inventory;
                            StockDispo.Insert();
                        end;

                        TamponDetailDispoStock.Init();
                        TamponDetailDispoStock."Code utilisateur" := CodeUtilisateur;
                        TamponDetailDispoStock."No. article" := LigneVente."No.";
                        TamponDetailDispoStock."No. ligne" := NumLigne;
                        TamponDetailDispoStock."Quantite vendue" := LigneVente."Outstanding Qty. (Base)";
                        if LigneVente."Pris sur stock" then
                            TamponDetailDispoStock."Quantite prise sur stock" := LigneVente."Outstanding Qty. (Base)"
                        else
                            if LigneVente."Quantite affectee" <> 0 then begin
                                //REPLACER CECI PAR LA QTE REELLEMENT ACHETEE (aller lire les affectation du coup !!)
                                TamponDetailDispoStock."Quantite achetee" := LigneVente."Quantite affectee";

                                if TamponDetailDispoStock."Quantite achetee" <= LigneVente."Outstanding Qty. (Base)" then
                                    TamponDetailDispoStock."Quantite prise sur stock" := LigneVente."Outstanding Qty. (Base)" - TamponDetailDispoStock."Quantite achetee"
                                else
                                    ;
                            end else
                                TamponDetailDispoStock."Quantite non sourcee" := LigneVente."Outstanding Qty. (Base)";

                        TamponDetailDispoStock.Insert();

                        NumLigne := NumLigne + 10000;
                    end;
                end;
            until LigneVente.Next() = 0;

        Commit();
        //Maintenant qu'on a listé les articles présents dans le document (une seule ligne si article présent plusieurs fois), on va parcourir cette liste
        //et chercher d'une part les quantités prises sur stock et d'autre part les quantités sur devis où on sait pas encore si cela sera pris sur stock ou acheté

        StockDispo.Reset();
        StockDispo.SetRange("Code utilisateur", CodeUtilisateur);
        if StockDispo.FindSet(false) then
            repeat
                LigneVente.Reset();
                LigneVente.SetCurrentKey("Document Type", Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Shipment Date");
                LigneVente.SetRange("Document Type", LigneVente."Document Type"::Quote, LigneVente."Document Type"::Order);
                LigneVente.SetRange(Type, LigneVente.Type::Item);
                LigneVente.SetRange("No.", StockDispo."No. article");

                if LigneVente.FindSet(false) then begin
                    AffectationsAchat.SetCurrentKey("Type document vente", "No. document vente", "No. ligne document vente");
                    AffectationsAchat.SetRange("Type document vente", AffectationsAchat."Type document vente"::Devis, AffectationsAchat."Type document vente"::Commande);
                    repeat
                        if LigneVente."Pris sur stock" then begin
                            TamponDetailDispoStock.Init();
                            TamponDetailDispoStock."Code utilisateur" := CodeUtilisateur;
                            TamponDetailDispoStock."No. article" := StockDispo."No. article";
                            TamponDetailDispoStock."No. document" := LigneVente."Document No.";
                            TamponDetailDispoStock."No. ligne" := NumLigne;
                            NumLigne := NumLigne + 1;
                            TamponDetailDispoStock."Quantite reservee" := LigneVente."Outstanding Quantity";
                            EnteteVente.get(LigneVente."Document Type", LigneVente."Document No.");
                            TamponDetailDispoStock."Date chargement" := EnteteVente."Date chargement";
                            TamponDetailDispoStock."Date livraison demandee" := EnteteVente."Requested Delivery Date";
                            TamponDetailDispoStock."Code vendeur" := EnteteVente."Salesperson Code";
                            TamponDetailDispoStock."Proba transformation" := EnteteVente."Proba transformation";
                            TamponDetailDispoStock.Commentaires := EnteteVente.Commentaire;
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
                                    TamponDetailDispoStock."No. article" := StockDispo."No. article";
                                    TamponDetailDispoStock."No. document" := LigneVente."Document No.";
                                    TamponDetailDispoStock."No. ligne" := NumLigne;
                                    NumLigne := NumLigne + 1;
                                    TamponDetailDispoStock."Quantite reservee" := decQtePriseSurStockCetteLigne;
                                    EnteteVente.get(LigneVente."Document Type", LigneVente."Document No.");
                                    TamponDetailDispoStock."Date chargement" := EnteteVente."Date chargement";
                                    TamponDetailDispoStock."Date livraison demandee" := EnteteVente."Requested Delivery Date";
                                    TamponDetailDispoStock."Code vendeur" := EnteteVente."Salesperson Code";
                                    TamponDetailDispoStock."Proba transformation" := EnteteVente."Proba transformation";
                                    TamponDetailDispoStock.Commentaires := EnteteVente.Commentaire;
                                    TamponDetailDispoStock.Insert();
                                end;
                            end else
                                if (LigneVente."Document Type" = LigneVente."Document Type"::Quote) and (LigneVente.Quantity <> 0) then begin
                                    //Si on arrive ici,
                                    //On sait qu'on ne prend pas tout sur stock et qu'on n'a pas affecté d'achats,
                                    //il faut alors décompter la ligne en [Quantité sur devis]
                                    TamponDetailDispoStock.Init();
                                    TamponDetailDispoStock."Code utilisateur" := CodeUtilisateur;
                                    TamponDetailDispoStock."No. article" := StockDispo."No. article";
                                    TamponDetailDispoStock."No. document" := LigneVente."Document No.";
                                    TamponDetailDispoStock."No. ligne" := NumLigne;
                                    NumLigne := NumLigne + 1;
                                    TamponDetailDispoStock."Quantite sur devis" := LigneVente."Quantity (Base)";
                                    EnteteVente.get(LigneVente."Document Type", LigneVente."Document No.");
                                    TamponDetailDispoStock."Date chargement" := EnteteVente."Date chargement";
                                    TamponDetailDispoStock."Date livraison demandee" := EnteteVente."Requested Delivery Date";
                                    TamponDetailDispoStock."Code vendeur" := EnteteVente."Salesperson Code";
                                    TamponDetailDispoStock."Proba transformation" := EnteteVente."Proba transformation";
                                    TamponDetailDispoStock.Commentaires := EnteteVente.Commentaire;
                                    TamponDetailDispoStock.Insert();
                                end;
                        end;
                    until LigneVente.Next() = 0;
                end;
            until StockDispo.Next() = 0;

        Commit();
        if StockDispo.FindSet(true) then
            repeat
                StockDispo.CalcFields("Quantite reservee");
                StockDispo."Stock dispo" := StockDispo.Stock - StockDispo."Quantite reservee";
                if StockDispo."Stock dispo" < 0 then
                    StockDispo."Stock dispo" := 0;
                StockDispo.Modify();
            until StockDispo.Next() = 0;

        Commit();


        //On va maintenant aller mettre à jour le champ [Stock dispo instant t] sur les lignes vente
        //On parcourt les lignes de vente et on va chercher dans la table de travail la disponibilité de chaque article
        //(si un article est plusieurs fois dans le devis/la commande, il n'est qu'une fois dans la table de travail)
        //(Attention, les lignes de la table de travail n'indiquent pas de N° document car on a utilisé la fonction qui calcule la dispo d'un article et qui n'est pas
        //basée sur un certain document).
        LigneVente.Reset();
        LigneVente.SetCurrentKey("Document Type", "Document No.", Type, "No.", "System-Created Entry");
        LigneVente.SetRange("Document Type", Rec."Document Type");
        LigneVente.SetRange("Document No.", Rec."No.");
        LigneVente.SetRange(Type, LigneVente.Type::Item);
        if LigneVente.FindSet(true) then begin
            StockDispo.SetRange("Type ligne", StockDispo."Type ligne"::"Stock dispo");
            repeat
                StockDispo.SetRange("No. article", LigneVente."No.");
                if StockDispo.FindFirst() then begin
                    LigneVente."Stock dispo instant t" := StockDispo."Stock dispo";
                    LigneVente.Modify();
                end;
            until LigneVente.Next() = 0;
        end;

        commit();

        StockDispo.Reset();
        StockDispo.FilterGroup(2);
        StockDispo.SetRange("Code utilisateur", UserId);
        StockDispo.SetRange("Document Type", "Document Type");
        StockDispo.SetRange("Document No.", "No.");
        StockDispo.FilterGroup(0);
        page.run(page::StockDispoDocumentVente, StockDispo);
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
            ArchiveManagement.StoreSalesDocument(Rec, false);
            commit();
        end else begin
            rec.CalcFields(Amount);
            RecupInfosDerniereArchive(MontantDernArchive, NoVersionDernArchive, DateDernArchive);
            if Amount <> MontantDernArchive then begin
                ArchiveManagement.StoreSalesDocument(Rec, false);
                commit();
            end;
        end;
    end;

    procedure RecupInfosDerniereArchive(var pMontant: Decimal; var pNoVersion: Integer; var pDateVersion: Date)
    var
        EnteteArchiveVente: Record "Sales Header Archive";
    begin
        EnteteArchiveVente.SetRange("Document Type", "Document Type");
        EnteteArchiveVente.SetRange("No.", "No.");
        if EnteteArchiveVente.FindLast() then begin
            pMontant := EnteteArchiveVente."Montant archive";
            pNoVersion := EnteteArchiveVente."Version No.";
            pDateVersion := EnteteArchiveVente."Date Archived";
        end else begin
            pMontant := 0;
            pNoVersion := 0;
            pDateVersion := 0D;

        end;
    end;

    procedure AjouterDocumentType()
    var
        StdCustSalesCode: Record "Standard Customer Sales Code";
        StdSalesLine: Record "Standard Sales Line";
        StdSalesCode: Record "Standard Sales Code";
        TamponExtraireDocument: Record TamponExtraireDocType;
        LigneVente: Record "Sales Line";
        Article: Record Item;
        dNegDEEE: Codeunit "Gestion Ecopart";
        StdCustSalesCodes: Page "Standard Customer Sales Codes";
        PageExtraireDevisTypePartiel: Page ExtraireDocTypePartiel;
        NumLigne: Integer;

    begin
        TestField("No.");
        TestField("Sell-to Customer No.");

        TamponExtraireDocument.SetRange("Code utilisateur", Copystr(UserId, 1, 50));
        TamponExtraireDocument.DeleteAll();
        commit();

        StdCustSalesCode.FilterGroup := 2;
        StdCustSalesCode.SetRange("Customer No.", "Sell-to Customer No.");
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
                    StdCustSalesCode.TestField("Customer No.", "Sell-to Customer No.");
                    StdSalesCode.Get(StdCustSalesCode.Code);
                    StdSalesCode.TestField("Currency Code", "Currency Code");
                    StdSalesLine.SetRange("Standard Sales Code", StdCustSalesCode.Code);

                    NumLigne := 10000;

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
                                    //KAN.FHA 15/01/2026 DEBUT
                                    TamponExtraireDocument.Phase := StdSalesLine.Phase;
                                    //KAN.FHA 15/01/2026 FIN
                                    //KAN.FHA 15/04/2026 DEBUT
                                    TamponExtraireDocument."No. fournisseur" := StdSalesLine."No. fournisseur";
                                    //KAN.FHA 15/04/2026 FIN
                                    TamponExtraireDocument."Poids net" := StdSalesLine."Poids net";
                                    TamponExtraireDocument."Country/Region of Origin Code" := StdSalesLine."Country/Region of Origin Code";
                                    TamponExtraireDocument."Nomenclature produits" := StdSalesLine."Nomenclature produits";
                                    TamponExtraireDocument."Prix achat prevu" := StdSalesLine."Prix achat prevu";
                                    if StdSalesLine."Prix unitaire" <> 0 then
                                        TamponExtraireDocument."Prix unitaire" := StdSalesLine."Prix unitaire";
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
                        LigneVente.Init();
                        LigneVente.SetSalesHeader(SalesHeader);
                        LigneVente."Document Type" := "Document Type";
                        LigneVente."Document No." := "No.";
                        LigneVente."Line No." := 0;
                        LigneVente.Validate(Type, TamponExtraireDocument.Type);
                        if TamponExtraireDocument.Type = TamponExtraireDocument.Type::" " then begin
                            LigneVente.Validate("No.", TamponExtraireDocument."No.");
                            LigneVente.Description := TamponExtraireDocument.Description;
                            LigneVente."Sell-to Customer No." := "Sell-to Customer No.";
                        end else
                            //if not StdSalesLine.EmptyLine() then begin
                                TamponExtraireDocument.TestField("No.");
                        LigneVente.Validate("No.", TamponExtraireDocument."No.");
                        if TamponExtraireDocument."Code variante" <> '' then
                            LigneVente.Validate("Variant Code", TamponExtraireDocument."Code variante");
                        LigneVente.Validate(Quantity, TamponExtraireDocument.Quantite);
                        if TamponExtraireDocument."Code unite" <> '' then
                            LigneVente.Validate("Unit of Measure Code", TamponExtraireDocument."Code unite");
                        if TamponExtraireDocument.Description <> '' then
                            LigneVente.Validate(Description, TamponExtraireDocument.Description);

                        //LigneVente."Shortcut Dimension 1 Code" := TamponExtraireDocument."Shortcut Dimension 1 Code";
                        //LigneVente."Shortcut Dimension 2 Code" := TamponExtraireDocument."Shortcut Dimension 2 Code";

                        //DimensionSetIDArr[1] := SalesLine."Dimension Set ID";
                        //DimensionSetIDArr[2] := StdSalesLine."Dimension Set ID";

                        //LigneVente."Dimension Set ID" :=
                        //  DimensionManagement.GetCombinedDimensionSetID(
                        //    DimensionSetIDArr, SalesLine."Shortcut Dimension 1 Code", SalesLine."Shortcut Dimension 2 Code");

                        LigneVente."Type ligne" := TamponExtraireDocument."Type ligne";
                        LigneVente."Line No." := GetNextLineNo(LigneVente);
                        LigneVente.Insert(true);
                        LigneVente.AutoAsmToOrder();
                        InsertExtendedText(LigneVente, Rec);
                        if TamponExtraireDocument.Type = TamponExtraireDocument.Type::Item then
                            if Article.GET(TamponExtraireDocument."No.") then begin
                                //KAN.FHA 15/04/2026 DEBUT
                                LigneVente.Phase := TamponExtraireDocument.Phase;
                                //KAN.FHA 15/04/2026 FIN
                                Article.CALCFIELDS("Assembly BOM");
                                if "Eco Tax Furniture Liable" then
                                    if (LigneVente."Eco Tax Furniture Code" <> '') and (not Article."Assembly BOM") then
                                        dNegDEEE.InsertWEEELine(LigneVente);

                                if Article."Miscellaneous Item" then begin
                                    LigneVente.VALIDATE("Net Weight", TamponExtraireDocument."Poids net");
                                    LigneVente.VALIDATE(Quantity);
                                    LigneVente.VALIDATE("Unit Price", TamponExtraireDocument."Prix unitaire");
                                    LigneVente.validate("Prix achat prevu", TamponExtraireDocument."Prix achat prevu");
                                    LigneVente."Nomenclature produits" := TamponExtraireDocument."Nomenclature produits";
                                    LigneVente."Country/Region of Origin Code" := TamponExtraireDocument."Country/Region of Origin Code";
                                    //KAN.FHA 15/04/2026 DEBUT
                                    LigneVente."Vendor No." := TamponExtraireDocument."No. fournisseur";
                                    //KAN.FHA 15/04/2026 FIN
                                end;
                                //KAN.FHA 15/04/2026 LigneVente.Phase := TamponExtraireDocument.Phase;
                                LigneVente.Modify();

                                if Article."Assembly BOM" then
                                    CODEUNIT.RUN(CODEUNIT::"Eclater nomenclature ABRANE", LigneVente)
                                else
                                    ;
                            end;
                    until TamponExtraireDocument.Next() = 0;
            end;
        end;
    end;

    procedure GetNextLineNo(pLigneVente: Record "Sales Line"): Integer
    begin
        pLigneVente.SetRange("Document Type", pLigneVente."Document Type");
        pLigneVente.SetRange("Document No.", pLigneVente."Document No.");
        if pLigneVente.FindLast() then
            exit(pLigneVente."Line No." + 10000);

        exit(10000);
    end;

    procedure InsertExtendedText(pLigneVente: Record "Sales Line"; pSalesHeader: Record "Sales Header")
    var
        TransferExtendedText: Codeunit "Transfer Extended Text";
    begin
        if TransferExtendedText.SalesCheckIfAnyExtText(pLigneVente, false, pSalesHeader) then
            TransferExtendedText.InsertSalesExtText(pLigneVente);
    end;

    procedure RecupDateChargementPremPhase(): date
    var
        PhasesDocument: Record "Phases document";
        DateMin: date;
    begin
        DateMin := 0D;
        if Rec."Document Type" in ["Document Type"::Quote, "Document Type"::Order] then begin
            PhasesDocument.SetRange("Type document", "Document Type");
            PhasesDocument.SetRange("No. document", "No.");
            if PhasesDocument.FindSet(true) then begin
                if DateMin = 0D then
                    DateMin := PhasesDocument."Date chargement";
                repeat
                    if (PhasesDocument."Date chargement" <> 0D) and (PhasesDocument."Date chargement" < DateMin) then
                        DateMin := PhasesDocument."Date chargement";
                until PhasesDocument.Next() = 0;
                exit(DateMin);
            end else
                exit(0D);
        end else
            exit(0D);
    end;

    procedure MAJDossierBE()
    var
        DossierBE: Record "Dossier BE";
        LigneFicheBE: Record "Ligne fiche BE";
        LigneVente: Record "Sales Line";
        Chantier: Record Chantier;
        Pays: Record "Country/Region";
        Dessinateur: Record "Salesperson/Purchaser";
        DessinateurFicheBE: Record "Dessinateurs fiche BE";
        ParamStock: Record "Inventory Setup";
        ReferenceFicheBE: code[10];
        DateLimiteReponseBE: Date;
        NouvelleDate: Date;
        DossierBEExisteDeja: Boolean;
        intTypeDoc: Integer;
        NumLigne: Integer;
        Annee: Integer;
        JourSemaine: Integer;
        txtAnnee: text[4];
        DelaiTransitText: Text;
        DelaiTransitLbl: label '<-%1D>', Comment = '%1 = Nombre de jours';

    begin
        DossierBE.SetCurrentKey("Type document", "No. document");
        case "Document Type" of
            "Document Type"::Quote:
                intTypeDoc := 1;
            "Document Type"::Order:
                intTypeDoc := 2;
            else
                exit;
        end;

        DossierBE.SetRange("Type document", intTypeDoc);
        Rec.CalcFields("Necessite Fiche BE");
        DossierBE.SetRange("No. document", Rec."No.");
        DossierBEExisteDeja := not DossierBE.IsEmpty();

        if not "Necessite Fiche BE" and not DossierBEExisteDeja then //Pas besoin de fiche et il n'y a pas de fiche
            exit;

        Annee := Date2DMY(Today, 3);
        txtAnnee := Format(Annee);
        txtAnnee := CopyStr(txtAnnee, 3, 2); //25 si on est en 2025 donc

        //Si on arrive ici, on peut avoir plusieurs cas :
        //  1. on a une fiche BE mais on en n'a plus besoin (plus de DIV concerné au sein du document)
        //  2. on n'a pas de dossier BE, il faut la créer et ajouter les articles DIV concernés
        //  3. on a un dossier BE mais des articles DIV concernés ont pu disparaitre du document ou etre ajoutés

        LigneFicheBE.LockTable();

        //Cas 1 
        if not "Necessite Fiche BE" and DossierBEExisteDeja then begin
            DossierBE.FindSet(true);
            DossierBE.Annule := true;
            DossierBE.Archive := true;
            DossierBE.Modify();
            exit;
        end;

        //KAN.FHA 22/09/2025 DEBUT
        if DossierBEExisteDeja then begin
            DossierBE.Get(Rec."No. dossier BE");
            DossierBE.Annule := false;
            DossierBE.Archive := false;
            DossierBE.Modify();
        end;
        //KAN.FHA 22/09/2025 FIN

        //Cas 2 
        if not DossierBEExisteDeja then begin
            DossierBE.Init();
            DossierBE."No." := '';
            DossierBE.Insert(true);
            DossierBE."Type document" := intTypeDoc;
            DossierBE."No. document" := Rec."No.";
            DossierBE."Nom du prospect/client" := "Sell-to Customer Name";
            DossierBE."Code vendeur" := Rec."Salesperson Code";
            DossierBE.Commentaires := Rec.Commentaire;
            DossierBE."Date chargement" := Rec."Date chargement";
            DossierBE."Date livraison demandée" := Rec."Requested Delivery Date";
            DossierBE."Code chantier" := Rec."Code chantier";
            if Chantier.Get(DossierBE."Code chantier") then
                DossierBE."Nom chantier" := Chantier."Nom chantier";
            DossierBE.Modify();

            Rec."No. dossier BE" := DossierBE."No.";
            Modify();

            LigneVente.Reset();
            LigneVente.SetRange("Document Type", Rec."Document Type");
            LigneVente.SetRange("Document No.", Rec."No.");
            LigneVente.Setrange(Type, LigneVente.Type::Item);

            if LigneVente.FindSet(true) then begin
                //KAN.FHA 20/04/2026 DEBUT
                ParamStock.Get();
                ParamStock.TestField("No. article divers BE");
                //KAN.FHA 20/04/2026 FIN
                NumLigne := 10000;
                LigneFicheBE.Reset();
                LigneFicheBE.SetCurrentKey(Reference);
                LigneFicheBE.SetFilter(Reference, '%1', txtAnnee + '*');

                if LigneFicheBE.FindLast() then
                    ReferenceFicheBE := IncStr(LigneFicheBE.Reference)
                else
                    ReferenceFicheBE := txtAnnee + '-00001';
                repeat
                    if LigneVente."Type fiche BE" in [LigneVente."Type Fiche BE"::"BE fournisseur", LigneVente."Type Fiche BE"::"BE Abrane"] then begin
                        LigneFicheBE.Init();
                        LigneFicheBE."No. dossier BE" := DossierBE."No.";
                        LigneFicheBE."No. ligne" := NumLigne;
                        LigneFicheBE."Date demande" := today;
                        LigneFicheBE."No. fournisseur" := LigneVente."Vendor No.";
                        LigneFicheBE.Reference := ReferenceFicheBE;
                        ReferenceFicheBE := IncStr(ReferenceFicheBE);
                        LigneFicheBE."Description de la demande" := LigneVente.Description;
                        if LigneVente."Type Fiche BE" = LigneVente."Type Fiche BE"::"BE fournisseur" then
                            LigneFicheBE."Statut ligne" := LigneFicheBE."Statut ligne"::"BE fournisseur";
                        if LigneFicheBE."Statut ligne" < LigneFicheBE."Statut ligne"::"BE fournisseur" then begin
                            if Rec."Date chargement" <> 0D then begin
                                DateLimiteReponseBE := CalcDate('<-6W>', Rec."Date chargement");
                                if LigneVente."Country/Region of Origin Code" <> '' then begin
                                    Pays.get(LigneVente."Country/Region of Origin Code");
                                    Pays.TestField("Delai transit (jours)");
                                    DelaiTransitText := StrSubstNo(DelaiTransitLbl, Pays."Delai transit (jours)");
                                    DateLimiteReponseBE := CalcDate(DelaiTransitText, DateLimiteReponseBE);
                                    //KAN.FHA 22/05/2026 DEBUT
                                    JourSemaine := Date2DWY(DateLimiteReponseBE, 1);
                                    while JourSemaine > 5 do begin
                                        DateLimiteReponseBE := CalcDate('<+1D>', DateLimiteReponseBE);
                                        JourSemaine := Date2DWY(DateLimiteReponseBE, 1);
                                    end;
                                    //KAN.FHA 22/05/2026 FIN
                                end else
                                    DateLimiteReponseBE := CalcDate('<-2W>', Rec."Date chargement"); //On passe donc à 8 semaines si on ne connait pas le pays d'origine

                                LigneFicheBE."Date limite reponse BE" := DateLimiteReponseBE;
                                LigneFicheBE."Semaine limite reponse BE" := Date2DWY(LigneFicheBE."Date limite reponse BE", 2);
                            end;
                            //KAN.FHA 20/04/2026 DEBUT
                            LigneFicheBE."No. article B.E." := NoSeriesMgt.GetNextNo(ParamStock."No. article divers BE", WorkDate(), true);
                            //KAN.FHA 20/04/2026 FIN
                        end;
                        LigneFicheBE.Insert();

                        Dessinateur.SetRange(Dessinateur, true);
                        if Dessinateur.FindSet(false) then
                            repeat
                                if not DessinateurFicheBE.Get("No. dossier BE", LigneFicheBE."No. ligne", Dessinateur.Code) then begin
                                    DessinateurFicheBE.Init();
                                    DessinateurFicheBE."No. dossier BE" := "No. dossier BE";
                                    DessinateurFicheBE."No. ligne" := LigneFicheBE."No. ligne";
                                    DessinateurFicheBE."Code dessinateur" := Dessinateur.Code;
                                    DessinateurFicheBE.Insert();
                                end;
                            until Dessinateur.Next() = 0;

                        LigneVente."Reference Fiche BE" := LigneFicheBE.Reference;
                        LigneVente.Modify();
                        NumLigne := NumLigne + 10000;
                    end;
                until LigneVente.Next() = 0;
            end;
        end;

        //Cas 3 
        if DossierBEExisteDeja then begin
            //On va d''abord vérifier si on retrouve toujours la ligne de document vente pour chaque ligne de la fiche BE existante
            //Si ce n''est pas le cas, on passe la ligne de Fiche BE au statut Annulé
            DossierBE.SetRange("Type document", intTypeDoc);
            DossierBE.SetRange("No. document", Rec."No.");
            if DossierBE.FindFirst() then begin
                LigneFicheBE.reset();
                LigneFicheBE.SetRange("No. dossier BE", DossierBE."No.");
                if LigneFicheBE.FindLast() then
                    NumLigne := LigneFicheBE."No. ligne" + 10000
                else
                    NumLigne := 10000;

                LigneVente.SetCurrentKey("Reference Fiche BE");
                LigneFicheBE.SetRange("No. dossier BE", DossierBE."No.");
                if LigneFicheBE.FindSet(true) then
                    repeat
                        LigneVente.SetRange("Reference Fiche BE", LigneFicheBE.Reference);
                        if LigneVente.IsEmpty then begin
                            LigneFicheBE."Statut ligne" := LigneFicheBE."Statut ligne"::"Annnulé";
                            LigneFicheBE.Modify();
                        end;
                    until LigneFicheBE.Next() = 0;

                //On va maintenant faire l'inverse, vérifier pour chaque ligne du document de vente si on a besoin de rajouter une nouvelle ligne à la fiche BE existante
                LigneVente.Reset();
                LigneVente.SetRange("Document Type", Rec."Document Type");
                LigneVente.SetRange("Document No.", Rec."No.");
                LigneVente.Setrange(Type, LigneVente.Type::Item);

                if LigneVente.FindSet(true) then begin
                    LigneFicheBE.reset();
                    LigneFicheBE.SetCurrentKey(Reference);
                    LigneFicheBE.SetFilter(Reference, '%1', txtAnnee + '*');

                    if LigneFicheBE.FindLast() then
                        ReferenceFicheBE := IncStr(LigneFicheBE.Reference)
                    else
                        ReferenceFicheBE := txtAnnee + '-00001';
                    repeat
                        if LigneVente."Type fiche BE" in [LigneVente."Type Fiche BE"::"BE fournisseur", LigneVente."Type Fiche BE"::"BE Abrane"] then
                            if LigneVente."Reference Fiche BE" = '' then begin
                                LigneFicheBE.Init();
                                LigneFicheBE."No. dossier BE" := DossierBE."No.";
                                LigneFicheBE."No. ligne" := NumLigne;
                                LigneFicheBE."Date demande" := today;
                                LigneFicheBE."Description de la demande" := LigneVente.Description;
                                LigneFicheBE.Reference := ReferenceFicheBE;
                                ReferenceFicheBE := IncStr(ReferenceFicheBE);
                                if LigneVente."Type Fiche BE" = LigneVente."Type Fiche BE"::"BE fournisseur" then
                                    LigneFicheBE."Statut ligne" := LigneFicheBE."Statut ligne"::"BE fournisseur";

                                if LigneFicheBE."Statut ligne" < LigneFicheBE."Statut ligne"::"BE fournisseur" then
                                    if Rec."Date chargement" <> 0D then begin
                                        DateLimiteReponseBE := CalcDate('<-6W>', Rec."Date chargement");
                                        if LigneVente."Country/Region of Origin Code" <> '' then begin
                                            Pays.get(LigneVente."Country/Region of Origin Code");
                                            Pays.TestField("Delai transit (jours)");
                                            DelaiTransitText := StrSubstNo(DelaiTransitLbl, Pays."Delai transit (jours)");
                                            DateLimiteReponseBE := CalcDate(DelaiTransitText, DateLimiteReponseBE);
                                        end else
                                            DateLimiteReponseBE := CalcDate('<-2W>', Rec."Date chargement"); //On passe donc à 8 semaines si on ne connait pas le pays d'origine

                                        LigneFicheBE."Date limite reponse BE" := DateLimiteReponseBE;
                                        LigneFicheBE."Semaine limite reponse BE" := Date2DWY(LigneFicheBE."Date limite reponse BE", 2);
                                    end;
                                LigneFicheBE.Insert();

                                //Si on a ajouté une fiche BE à un dossier qui avait été archivé, on repasse le dossier en [Archivé = Non]
                                if LigneFicheBE."Statut ligne" = LigneFicheBE."Statut ligne"::" " then
                                    if DossierBE.Archive then begin
                                        DossierBE.Annule := false;
                                        DossierBE.Archive := false;
                                        DossierBE.Modify();
                                    end;

                                LigneVente."Reference Fiche BE" := LigneFicheBE.Reference;
                                LigneVente.Modify();

                                NumLigne := NumLigne + 10000;
                            end;
                    until LigneVente.Next() = 0;

                end;
            end;
        end;
    end;

    procedure ListerPhases()
    var
        LigneVente: record "Sales Line";
        PhaseDocument: Record "Phases document";

    begin
        LigneVente.Reset();
        LigneVente.SetRange("Document Type", Rec."Document Type");
        LigneVente.SetRange("Document No.", Rec."No.");
        LigneVente.Setrange(Type, LigneVente.Type::Item);
        if LigneVente.FindSet(false) then
            repeat
                if not PhaseDocument.Get(Rec."Document Type", rec."No.", LigneVente.Phase) then begin
                    PhaseDocument.Init();
                    PhaseDocument."Type document" := Rec."Document Type";
                    PhaseDocument."No. document" := Rec."No.";
                    PhaseDocument.Phase := LigneVente.Phase;
                    if PhaseDocument.Phase = 0 then
                        PhaseDocument.Description := 'Phase non définie';
                    PhaseDocument.Insert();
                end;
            until LigneVente.Next() = 0;
    end;

    procedure ViderQteAExpedierAutresPhases(pPhase: Integer)
    var
        LigneVente: Record "Sales Line";
    begin
        LigneVente.SetCurrentKey(TypeDocDuplique, NumDocDuplique, Phase);
        LigneVente.SetRange(TypeDocDuplique, Rec."Document Type");
        LigneVente.SetRange(NumDocDuplique, Rec."No.");
        //LigneVente.Setrange(Type, LigneVente.Type::Item);
        if pPhase >= 0 then //J'appelle cette fonction avec -999 comme Phase pour vider toutes les lignes
            LigneVente.SetFilter(Phase, '<>%1', pPhase);
        if LigneVente.FindSet(true) then
            repeat
                if LigneVente.Quantity <> 0 then begin
                    LigneVente.Validate("Qty. to Ship", 0);
                    LigneVente.Modify();
                end;
            until LigneVente.Next() = 0;
    end;

    procedure RemplirQteAExpedierPhase(pPhase: Integer)
    var
        LigneVente: Record "Sales Line";
    begin
        //On commence par vider la qté à expédier de toutes les lignes
        LigneVente.SetCurrentKey(TypeDocDuplique, NumDocDuplique, Phase);
        LigneVente.SetRange(TypeDocDuplique, Rec."Document Type");
        LigneVente.SetRange(NumDocDuplique, Rec."No.");
        LigneVente.Setrange(Type, LigneVente.Type::Item);
        if LigneVente.FindSet(true) then
            repeat
                LigneVente.Validate("Qty. to Ship", 0);
                LigneVente.Modify();
            until LigneVente.Next() = 0;

        //On lit maintenant les lignes qui ont du phasage pour la phase à livrer et on remplit la qté à expédier de la ligne vente associee
        LigneVente.SetRange(Phase, pPhase);
        if LigneVente.FindSet(true) then
            repeat
                LigneVente.Validate("Qty. to Ship", LigneVente."Outstanding Quantity");
                //LigneVente."Phase a expedier" := pPhase;
                LigneVente.Modify();
            until LigneVente.Next() = 0;
    end;


    procedure CompterPhasesActives(): Integer;
    var
        PhasesDocument: Record "Phases document";
        NbPhasesActives: Integer;
    begin
        //On compte combien de phases ont des articles rattachés.
        NbPhasesActives := 0;
        PhasesDocument.SetRange("Type document", Rec."Document Type");
        PhasesDocument.SetRange("No. document", Rec."No.");
        if PhasesDocument.FindSet(false) then
            repeat
                PhasesDocument.CalcFields("Nb lignes dans phase");
                if PhasesDocument."Nb lignes dans phase" > 0 then
                    NbPhasesActives := NbPhasesActives + 1;

            until PhasesDocument.Next() = 0;

        exit(NbPhasesActives);

    end;

    procedure RecupQteAExpedier(): Decimal
    //Sur l'écran de Saisie expédition, on a un champ qui affiche la somme des Quantités à expédier pour controle
    var
        LigneVente: Record "Sales Line";
        decQte: Decimal;
    begin
        decQte := 0;
        LigneVente.SetRange("Document Type", Rec."Document Type");
        LigneVente.SetRange("Document No.", Rec."No.");
        LigneVente.Setrange(Type, LigneVente.Type::Item);
        if LigneVente.FindSet(false) then
            repeat
                decQte := decQte + LigneVente."Qty. to Ship";
            until LigneVente.Next() = 0;
        exit(decQte);
    end;

    procedure PhaserReliquat()
    //Fonction encore utile ?????
    var
        PhasesDocument: Record "Phases document";
    begin
        if not PhasesDocument.Get(1, Rec."No.", 99) then begin
            PhasesDocument.Init();
            PhasesDocument."Type document" := PhasesDocument."Type document"::Order;
            PhasesDocument."No. document" := Rec."No.";
            PhasesDocument.Phase := 99;
            PhasesDocument.Description := 'Reliquat';
            PhasesDocument.Insert();
        end;
    end;

    procedure CreerColisage(pOuvrirFiche: Boolean)
    var
        EnteteColisage: Record "Entete colisage";
        ContenuColisage: Record "Contenu colisage";
        LigneCommande: Record "Sales Line";
        PhasesDocVente: Record "Phases document";
        FicheColisage: page "Fiche colisage";
        PagePhases: Page "Liste phases document";
        NbPhasesActives: Integer;
        PhaseAColiser: Integer;
        NumColisage: Code[20];
        PrecisionArrondi: Decimal;
        OuvrirColisageDejaEnCoursQst: Label 'Un colisage est déjà en cours pour cette commande.\Voulez-vous l''ouvrir ?';
        OperationInterrompueErr: Label 'Opération interrompue à la demande de l''utilisateur.';
    begin
        PhaseAColiser := 0;
        NbPhasesActives := rec.CompterPhasesActives();
        PhasesDocVente.SetRange("Type document", Rec."Document Type");
        PhasesDocVente.SetRange("No. document", Rec."No.");

        if NbPhasesActives = 1 then begin
            PhasesDocVente.FindFirst();
            PhaseAColiser := PhasesDocVente.Phase;
        end else
            if NbPhasesActives > 1 then begin
                commit();
                PagePhases.SetTableView(PhasesDocVente);
                PagePhases.DefinirTypeAppel('Coliser');
                PagePhases.LookupMode(true);
                if PagePhases.RunModal() = Action::LookupOK then begin
                    PagePhases.GetRecord(PhasesDocVente);
                    PhaseAColiser := PhasesDocVente.Phase;
                end;
            end;

        EnteteColisage.SetCurrentKey(Expedie, "No. commande", "No. expedition enregistree");
        EnteteColisage.SetRange(Expedie, false);
        EnteteColisage.SetRange("No. commande", Rec."No.");
        EnteteColisage.SetRange(Phase, PhaseAColiser);
        EnteteColisage.SetRange("No. expedition enregistree", '');
        if not EnteteColisage.IsEmpty then
            if Confirm(OuvrirColisageDejaEnCoursQst, true) then begin
                Clear(FicheColisage);
                if EnteteColisage.FindFirst() then begin
                    FicheColisage.SetTableView(EnteteColisage);
                    FicheColisage.Run();
                    exit;
                end else
                    error(OperationInterrompueErr);
            end else
                exit;

        EnteteColisage.Reset();
        EnteteColisage.Init();
        EnteteColisage."No." := '';
        EnteteColisage.Insert(true);
        NumColisage := EnteteColisage."No.";
        EnteteColisage."Sell-to Customer No." := Rec."Sell-to Customer No.";
        EnteteColisage.Validate("No. commande", Rec."No.");
        EnteteColisage."Poids brut non colise" := Rec."Poids brut total";
        EnteteColisage.Phase := PhaseAColiser;
        if PhasesDocVente.get(Rec."Document Type", Rec."No.", PhaseAColiser) then
            EnteteColisage."Description phase" := PhasesDocVente.Description;
        EnteteColisage.Modify();

        LigneCommande.SetCurrentKey(TypeDocDuplique, NumDocDuplique, Phase);
        LigneCommande.SetRange(TypeDocDuplique, Rec."Document Type");
        LigneCommande.SetRange(NumDocDuplique, Rec."No.");
        LigneCommande.SetRange(Phase, PhaseAColiser);
        LigneCommande.SetRange(Type, LigneCommande.Type::Item);
        if LigneCommande.FindSet(false) then
            repeat
                if LigneCommande."Outstanding Quantity" <> 0 then begin
                    ContenuColisage.Init();
                    ContenuColisage."No. colisage" := EnteteColisage."No.";
                    ContenuColisage."No. ligne" := LigneCommande."Line No.";
                    ContenuColisage.Type := ContenuColisage.Type::Item;
                    ContenuColisage."Item No." := LigneCommande."No.";
                    ContenuColisage."Quantite UC" := LigneCommande."Outstanding Quantity";
                    ContenuColisage.Description := LigneCommande.Description;
                    ContenuColisage."Order No." := Rec."No.";
                    ContenuColisage."Order Line No." := LigneCommande."Line No.";
                    if LigneCommande."Linked to line" <> 0 then begin
                        ContenuColisage."Type produit" := ContenuColisage."Type produit"::Composant;
                        ContenuColisage."No. ligne regroupement" := LigneCommande."Linked to line";
                    end else begin
                        ContenuColisage."Type produit" := ContenuColisage."Type produit"::"Produit fini";
                        ContenuColisage."No. ligne regroupement" := ContenuColisage."No. ligne";
                    end;
                    ContenuColisage."Poids net unitaire" := LigneCommande."Net Weight";
                    PrecisionArrondi := 0;
                    if ContenuColisage."Poids net unitaire" < 1 then
                        PrecisionArrondi := 0.001
                    else
                        PrecisionArrondi := 0.01;
                    ContenuColisage."Poids net ligne" := ROUND(ContenuColisage."Quantite UC" * ContenuColisage."Poids net unitaire", PrecisionArrondi);
                    ContenuColisage.Insert();
                end;
            until LigneCommande.Next() = 0;

        if pOuvrirFiche then begin
            Clear(FicheColisage);
            EnteteColisage.Setrange("No.", NumColisage);
            if EnteteColisage.FindFirst() then begin
                FicheColisage.SetTableView(EnteteColisage);
                FicheColisage.Run();
            end;
        end;
    end;

    procedure ComparerVersionsArchives(pVersion1: Integer; pVersion2: Integer)
    var
        Comparaison: Record ComparaisonVersionsDocument;
        LigneVenteArchive: Record "Sales Line Archive";
        CodeUtil: code[50];
    begin
        CodeUtil := CopyStr(UserId, 1, 50);

        Comparaison.Reset();
        Comparaison.SetCurrentKey("Code utilisateur");
        Comparaison.SetRange("Code utilisateur", CodeUtil);
        Comparaison.DeleteAll();

        LigneVenteArchive.SetRange("Document Type", Rec."Document Type");
        LigneVenteArchive.SetRange("Document No.", Rec."No.");
        LigneVenteArchive.SetRange("Version No.", pVersion1);
        LigneVenteArchive.SetRange(Type, LigneVenteArchive.Type::Item);
        if LigneVenteArchive.FindSet(false) then
            repeat
                if not Comparaison.get(Rec."Document Type", Rec."No.", LigneVenteArchive."No.") then begin
                    Comparaison.Init();
                    Comparaison."Code utilisateur" := CodeUtil;
                    Comparaison."Type document" := Rec."Document Type";
                    Comparaison."No. document" := Rec."No.";
                    Comparaison."No. article" := LigneVenteArchive."No.";
                    Comparaison.Description := LigneVenteArchive.Description;
                    Comparaison."Ligne modifiee" := true;
                    Comparaison."No. version A" := pVersion1;
                    Comparaison."No. version B" := pVersion2;
                    Comparaison.Insert();
                end;
                Comparaison."Quantite version A" := Comparaison."Quantite version A" + LigneVenteArchive.Quantity;
                Comparaison.Modify();
            until LigneVenteArchive.Next() = 0;

        LigneVenteArchive.SetRange("Version No.", pVersion2);
        if LigneVenteArchive.FindSet(false) then
            repeat
                if not Comparaison.get(Rec."Document Type", Rec."No.", LigneVenteArchive."No.") then begin
                    Comparaison.Init();
                    Comparaison."Code utilisateur" := CodeUtil;
                    Comparaison."Type document" := Rec."Document Type";
                    Comparaison."No. document" := Rec."No.";
                    Comparaison."No. article" := LigneVenteArchive."No.";
                    Comparaison.Description := LigneVenteArchive.Description;
                    Comparaison."No. version A" := pVersion1;
                    Comparaison."No. version B" := pVersion2;

                    Comparaison.Insert();
                end;
                Comparaison."Quantite version B" := Comparaison."Quantite version B" + LigneVenteArchive.Quantity;
                Comparaison."Ligne modifiee" := (Comparaison."Quantite version A" <> Comparaison."Quantite version B");
                //KAN.FHA 20/04/2026 DEBUT
                Comparaison."Quantite ecart (B-A)" := Comparaison."Quantite version B" - Comparaison."Quantite version A";
                //KAN.FHA 20/04/2026 FIN

                Comparaison.Modify();
            until LigneVenteArchive.Next() = 0;
    end;

}

