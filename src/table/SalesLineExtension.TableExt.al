tableextension 50011 SalesLineExtension extends "Sales Line"
{
    fields
    {
        field(50000; "Prix bloque"; Boolean)
        {
            Caption = 'Prix bloqué';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50001; "Prix debloque par"; Code[50])
        {
            Caption = 'Prix débloqué par';
            DataClassification = ToBeClassified;
            Editable = false;
            NotBlank = true;
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }
        field(50002; "Prix avant deblocage"; Decimal)
        {
            Caption = 'Prix avant déblocage';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50005; SAV; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 17/11/2022';
        }
        field(50006; TypeDocDuplique; Enum "Sales Document Type")
        {
            Caption = 'TypeDocDuplique';
            DataClassification = ToBeClassified;
        }
        field(50007; NumDocDuplique; Code[20])
        {
            Caption = 'NumDocDuplique';
            DataClassification = ToBeClassified;
        }

        field(50008; "Annee commande"; Integer)
        {
            Caption = 'Année commande';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 17/11/2022 Pour pouvoir filtrer le montant des cdes en cours par année sur les enseignes, groupes clients et chantiers';
        }
        field(50010; "Released Status"; Boolean)
        {
            Caption = 'Statut Lancé';
            DataClassification = ToBeClassified;
            Description = 'E10';
            Editable = false;
        }

        field(50030; "Vendor No."; Code[20])
        {
            Caption = 'N° fournisseur';
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No." where(Blocked = const(" "));

            trigger OnValidate()
            var
                SelectionFns: Record "Selection fns pour creer cde";
                SelectionFns2: Record "Selection fns pour creer cde";
                Fournisseur: Record Vendor;
                LigneFicheBE: Record "Ligne fiche BE";
                Item: Record Item;
                CodeUtil: code[50];
                NumLigne: Integer;
                AssemblagesPasAchetablesErr: Label 'Il n''est pas possible d''acheter un article assemblé.';
            begin
                TestField(Type, Type::Item);
                TestField("No.");
                Item.Get("No.");
                Item.CalcFields("Assembly BOM");
                if Item."Assembly BOM" then
                    Error(AssemblagesPasAchetablesErr);

                if not Item."Miscellaneous Item" then
                    if "Vendor No." = '' then
                        Validate("Prix achat prevu", 0)
                    else
                        Validate("Prix achat prevu", Item.PrixAchatActuel("Vendor No."));

                //Si ce champ est saisi depuis l'écran "Créer commande achat", cela veut dire qu'on a listé les fournisseurs présents sur les lignes de la commande dans la table 50035 pour proposer
                //à l'utilisateur de cocher pour quels fournisseurs il veut créer les commandes d'achat. Si l'utilisateur choisit un fournisseur qui n'avait pas encore été listé au moment où on a ouvert
                //cet écran, il faut l'ajouter à la liste
                if "Vendor No." <> '' then begin
                    CodeUtil := copystr(UserId, 1, 50);
                    SelectionFns.Setrange("Code utilisateur", CodeUtil);
                    SelectionFns.SetRange("No. fournisseur", "Vendor No.");
                    if not SelectionFns.FindSet(true) then begin
                        SelectionFns2.SetRange("Code utilisateur", CodeUtil);
                        if SelectionFns2.FindLast() then
                            NumLigne := SelectionFns2."No. ligne" + 10000
                        else
                            NumLigne := 10000;
                        //if not SelectionFns.Get(UserId, "Vendor No.") then begin
                        SelectionFns.Init();
                        SelectionFns."Code utilisateur" := CodeUtil;
                        SelectionFns."No. ligne" := NumLigne;
                        SelectionFns."No. fournisseur" := "Vendor No.";
                        case "Document Type" of
                            "Document Type"::"Blanket Order":
                                SelectionFns."Document Type" := SelectionFns."Document Type"::"Blanket Order";
                            "Document Type"::"Credit Memo":
                                SelectionFns."Document Type" := SelectionFns."Document Type"::"Credit Memo";
                            "Document Type"::Invoice:
                                SelectionFns."Document Type" := SelectionFns."Document Type"::Invoice;
                            "Document Type"::Order:
                                SelectionFns."Document Type" := SelectionFns."Document Type"::Order;
                            "Document Type"::Quote:
                                SelectionFns."Document Type" := SelectionFns."Document Type"::Quote;
                            "Document Type"::"Return Order":
                                SelectionFns."Document Type" := SelectionFns."Document Type"::"Return Order";
                        end;
                        SelectionFns."Document No." := "Document No.";
                        SelectionFns.Insert();
                    end;
                end;

                //KAN.FHA 06/09/2022 DEBUT
                if Fournisseur.Get("Vendor No.") then
                    "Country/Region of Origin Code" := Fournisseur."Country/Region Code"
                else
                    "Country/Region of Origin Code" := '';
                //KAN.FHA 06/09/2022 FIN

                if Rec."Reference Fiche BE" <> '' then begin
                    LigneFicheBE.Reset();
                    LigneFicheBE.SetCurrentKey(Reference);
                    LigneFicheBE.SetRange(Reference, Rec."Reference Fiche BE");
                    if LigneFicheBE.FindFirst() then begin
                        LigneFicheBE."No. fournisseur" := "Vendor No.";
                        LigneFicheBE.Modify();
                    end;
                end;
            end;
        }
        field(50035; "Article divers"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'ART.DIV';
        }
        field(50036; "Type Fiche BE"; Option)
        {
            OptionMembers = " ","Pas de fiche","BE fournisseur","BE Abrane";
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                LigneFicheBE: Record "Ligne fiche BE";
            begin
                Rec.TestField(Type, Rec.Type::Item);
                Rec.TestField("Article divers", true);
                if Rec."Reference Fiche BE" <> '' then begin
                    LigneFicheBE.Reset();
                    LigneFicheBE.SetCurrentKey(Reference);
                    LigneFicheBE.SetRange(Reference, Rec."Reference Fiche BE");
                    if LigneFicheBE.FindFirst() then
                        case "Type Fiche BE" of
                            Rec."Type Fiche BE"::" ", Rec."Type Fiche BE"::"BE Abrane":
                                begin
                                    LigneFicheBE."Statut ligne" := LigneFicheBE."Statut ligne"::" ";
                                    LigneFicheBE.Modify();
                                end;
                            Rec."Type Fiche BE"::"BE fournisseur":
                                begin
                                    LigneFicheBE."Statut ligne" := LigneFicheBE."Statut ligne"::"BE fournisseur";
                                    LigneFicheBE.Modify();
                                end;
                            Rec."Type Fiche BE"::"Pas de fiche":
                                begin
                                    LigneFicheBE."Statut ligne" := LigneFicheBE."Statut ligne"::"Pas de fiche";
                                    LigneFicheBE.Modify();
                                end;
                        end;
                end;
            end;
        }

        field(50037; "Reference Fiche BE"; Code[10])
        {
            DataClassification = ToBeClassified;
        }

        field(50038; "Poids obligatoire"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 21/10/2020';
        }
        field(50039; "Prix achat prevu"; Decimal)
        {
            Caption = 'Prix achat prévu';
            DataClassification = ToBeClassified;
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            trigger OnValidate()
            var
                EnteteVente: Record "Sales Header";
                Fournisseur: Record Vendor;
                FacteurDevise: Record "Currency Exchange Rate";
                MontantAchatsPrevusDS: Decimal;
            begin
                if CurrFieldNo = Rec.FieldNo("Prix achat prevu") then
                    Rec.TestField("Article divers", true);
                if not Fournisseur.get("Vendor No.") then
                    Fournisseur.init();

                EnteteVente.Get(Rec."Document Type", Rec."Document No.");
                MontantAchatsPrevusDS := "Prix achat prevu" * Quantity;
                if Fournisseur."Currency Code" = '' then
                    "Montant achats prevus (DS)" := round(MontantAchatsPrevusDS, 0.01)
                else
                    //FacteurDevise.ExchangeRate()
                    "Montant achats prevus (DS)" := round(
                    FacteurDevise.ExchangeAmtFCYToLCY(EnteteVente."Document Date", Fournisseur."Currency Code", MontantAchatsPrevusDS,
                            FacteurDevise.GetCurrentCurrencyFactor(Fournisseur."Currency Code")), 0.01);

            end;
        }

        field(50040; "Creer cde achat"; Boolean)
        {
            Caption = 'Créer cde achat';
            DataClassification = ToBeClassified;
            Description = 'ART.DIV';

            trigger OnValidate()
            var
                Item: Record Item;
                PasPossibleAcheterAssembErr: Label 'Vous ne pouvez pas acheter un article assemblé.';
                QteAAcheterObligErr: Label 'Vous devez une quantité à acheter.';

            begin
                if "Creer cde achat" then begin
                    if "Quantite a acheter" = 0 then
                        Error(QteAAcheterObligErr);
                    Item.Get("No.");
                    Item.CalcFields("Assembly BOM");
                    if Item."Assembly BOM" then
                        Error(PasPossibleAcheterAssembErr);
                end;
            end;
        }
        field(50042; "Ajouter à cde achat No."; Code[20])
        {
            Caption = 'Ajouter à cde achat N°';
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No." where("Document Type" = const(Order));
        }

        field(50090; "Nomenclature produits"; Code[20])
        {
            Caption = 'Nomenclature produits';
            DataClassification = ToBeClassified;
            TableRelation = "Tariff Number";

            trigger OnValidate()
            begin
                //KAN.FHA 08/10/2021 DEBUT
                TestField("Article divers", true)
                //KAN.FHA 08/10/2021 FIN
            end;
        }
        field(50100; "Eco Tax Furniture Code"; Code[10])
        {
            Caption = 'Code taxe éco mobilier';
            DataClassification = ToBeClassified;
            Description = 'CPT02';
            Editable = false;
            TableRelation = "Taxe eco-mobilier";
        }
        field(50110; "Eco Tax Furniture Amount"; Decimal)
        {
            Caption = 'Montant taxe éco mobilier';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 4;
            Description = 'CPT02';
            Editable = false;
        }
        field(50120; "Eco Tax Furniture Qty Per"; Decimal)
        {
            Caption = 'Eco mobilier Quantité Par';
            DataClassification = ToBeClassified;
            Description = 'CPT02';
            Editable = false;
        }
        field(50130; "Eco Tax Furniture Line"; Boolean)
        {
            Caption = 'Ligne éco mobilier';
            DataClassification = ToBeClassified;
            Description = 'CPT02';
            Editable = false;
        }
        field(50140; "Eco Tax Furniture Family"; Text[50])
        {
            CalcFormula = lookup("Taxe eco-mobilier".Family where(Code = field("Eco Tax Furniture Code")));
            Caption = 'Famille taxe éco mobilier';
            Description = 'CPT02';
            FieldClass = FlowField;
        }
        field(50150; "Eco Tax Furniture Sub Family"; Text[50])
        {
            CalcFormula = lookup("Taxe eco-mobilier"."Sub Family" where(Code = field("Eco Tax Furniture Code")));
            Caption = 'Sous famille taxe éco mobilier';
            Description = 'CPT02';
            FieldClass = FlowField;
        }
        field(50160; "Price included Eco Tax"; Boolean)
        {
            Caption = 'Prix écotaxe inclus';
            DataClassification = ToBeClassified;
            Description = 'CPT02';
        }
        field(50200; "Linked to line"; Integer)
        {
            Caption = 'Lié à la ligne N°';
            DataClassification = ToBeClassified;
        }
        field(50205; "Quantite pour 1"; Decimal)
        {
            Caption = 'Quantité pour 1';
            DataClassification = ToBeClassified;
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Description = 'Pour les composants, indique la quantité pour 1 article parent. Uniquement pour les composants ajoutés manuellement, pas presents dans la nomenclature de l''article';
        }

        field(50207; "Article nomenclature"; Boolean)
        {
            Caption = 'Article nomenclaturé';
            DataClassification = ToBeClassified;
            Description = 'KAN 21/08/2025';
        }

        field(50210; "Ligne eclatee"; Boolean)
        {
            Caption = 'Ligne éclatée';
            DataClassification = ToBeClassified;
        }
        field(50220; "Visible Line No."; Integer)
        {
            CalcFormula = lookup("Sales Line"."Line No." where("Document Type" = field("Document Type"),
                                                                "Document No." = field("Document No."),
                                                                "Line No." = field("Line No.")));
            Caption = 'N° ligne visible';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50230; "Ligne deduction acompte"; Boolean)
        {
            Caption = 'Ligne déduction acompte';
            DataClassification = ToBeClassified;
        }
        field(50231; "Ligne deduction situation"; Boolean)
        {
            Caption = 'Ligne déduction situation';
            DataClassification = ToBeClassified;
        }
        field(50240; "Salesperson Code"; Code[20])
        {
            Caption = 'Code vendeur';
            DataClassification = ToBeClassified;
            Description = 'DIA£LBO';
            TableRelation = "Salesperson/Purchaser";
        }
        field(50250; "Reason Code"; Code[10])
        {
            Caption = 'Code motif retour';
            DataClassification = ToBeClassified;
            Description = 'DIA£LBO modifiication caption';
            TableRelation = "Reason Code";
        }
        field(50260; "Nom du client"; Text[100])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("Sell-to Customer No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50270; "Nature vente"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 18/06/2020';
            OptionMembers = Mobilier,"Pose/Audit",Transport,"Bennes/Fenwick",SAV,"Indéfini";
        }
        field(51000; "Do not print"; Boolean)
        {
            Caption = 'Ne pas imprimer';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                SalesLine2: Record "Sales Line";
                ABRATXT0001Err: Label 'Vous ne pouvez pas sélectionner des lignes d''éco taxe ou des composants, le traitement va les sélectionner automatiquement.';
            begin
                //DIA.SCH - 23/03/2016  - DNP
                case "Document Type" of
                    "Document Type"::Order:
                        begin
                            if ("Linked to line" <> 0) or ("Eco Tax Furniture Line" = true) then
                                Error(ABRATXT0001Err);
                            if "Do not print" = true then
                                Validate("Qty. to Ship", 0)
                            else
                                Validate("Qty. to Ship", "Outstanding Quantity");
                            SalesLine2.SetRange("Document Type", "Document Type");
                            SalesLine2.SetRange("Document No.", "Document No.");
                            SalesLine2.SetFilter("Linked to line", '<>0&%1', "Line No.");
                            if SalesLine2.Find('-') then
                                repeat
                                    SalesLine2."Do not print" := "Do not print";
                                    if "Do not print" = true then
                                        SalesLine2.Validate("Qty. to Ship", 0)
                                    else
                                        SalesLine2.Validate("Qty. to Ship", SalesLine2."Outstanding Quantity");
                                    SalesLine2.Modify();
                                until SalesLine2.Next() = 0;
                        end;
                    "Document Type"::Quote:
                        begin
                            if ("Linked to line" <> 0) or ("Eco Tax Furniture Line" = true) then
                                Error(ABRATXT0001Err);
                            SalesLine2.SetRange("Document Type", "Document Type");
                            SalesLine2.SetRange("Document No.", "Document No.");
                            SalesLine2.SetFilter("Linked to line", '<>0&%1', "Line No.");
                            if SalesLine2.Find('-') then
                                repeat
                                    SalesLine2."Do not print" := "Do not print";
                                    SalesLine2.Modify();
                                until SalesLine2.Next() = 0;
                        end;

                end;
            end;
        }
        field(51010; "Country/Region of Origin Code"; Code[10])
        {
            Caption = 'Code pays/région origine';
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
        field(51100; "Duplicate Line"; Boolean)
        {
            Caption = 'Dupliquer ligne';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if ("Document Type" = "Document Type"::Order) or ("Document Type" = "Document Type"::Quote) then;
            end;
        }
        field(51110; "Montant restant HT (DS)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
        }
        field(51115; "Livre non facture HT (DS)"; Decimal)
        {
            Caption = 'Livré non facturé HT (DS)';
            DataClassification = ToBeClassified;
            Description = 'KAN';
            Editable = false;
        }
        field(51120; "Montant achats prevus (DS)"; Decimal)
        {
            Caption = 'Montant achats prevus (DS)';
            DataClassification = ToBeClassified;
            Editable = false;
            Description = 'Coût des achats prévus dans la devise de la pièce';
            DecimalPlaces = 2 : 5;
        }

        field(51180; "Exclure de la rentabilite"; Boolean)
        {
            Caption = 'Exclure de la rentabilité';
            DataClassification = ToBeClassified;
        }

        field(51182; "Date livraison demandee"; Date)
        {
            Caption = 'Date livraison demandée';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."Requested Delivery Date" where("Document Type" = field("Document Type"), "No." = field("Document No.")));
            Editable = false;
        }

        field(51183; "Date chargement"; Date)
        {
            Caption = 'Date chargement';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."Date chargement" where("Document Type" = field("Document Type"), "No." = field("Document No.")));
            Editable = false;
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
                Chantier: Record Chantier;
                Enseigne: Record Enseigne;
                ParamUtil: Record "User Setup";
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

        field(51222; "Stock dispo instant t"; Decimal)
        {
            BlankZero = true;
            Caption = 'Stock dispo instant t';
            DecimalPlaces = 0 : 5;
            Description = 'KAN Ce champ montre le stock dispo au moment où l''utilisateur demande à créer les commandes d''achat, pour les magasins qu''il aura sélectionnés sur le "Créer commande achat".';
            Editable = false;

        }
        field(51223; "Pris sur stock"; Boolean)
        {
            Caption = 'Pris sur stock';
            trigger OnValidate()
            begin
                if Rec."Pris sur stock" then begin
                    "Quantite a acheter" := 0;
                    "Creer cde achat" := false;
                end;
            end;
        }
        field(51224; "A acheter"; Boolean)
        {
            Caption = 'A acheter';
        }
        field(51225; "Quantite a acheter"; Decimal)
        {
            BlankZero = true;
            Caption = 'Quantité à acheter';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'KAN';
            MinValue = 0;

            trigger OnValidate()
            var
                ListeFournisseur: Record "Selection fns pour creer cde";
                CodeUtil: Text[50];
            begin
                testfield("Pris sur stock", false);
                if "Quantite a acheter" = 0 then begin
                    "Creer cde achat" := false;
                    //KAN.FHA 22/04/2026 DEBUT
                    "Ajouter à cde achat No." := '';
                    //KAN.FHA 22/04/2026 FIN
                end else begin
                    //KAN.FHA 22/04/2026 DEBUT
                    CodeUtil := CopyStr(UserId, 1, 50);
                    ListeFournisseur.Reset();
                    ListeFournisseur.SetRange("Code utilisateur", CodeUtil);
                    ListeFournisseur.SetRange("No. fournisseur", "Vendor No.");
                    if ListeFournisseur.FindFirst() then begin
                        "Creer cde achat" := ListeFournisseur."Creer nouvelle commande";
                        "Ajouter à cde achat No." := ListeFournisseur."Ajouter a la cde No.";
                    end;
                    //KAN.FHA 22/04/2026 FIN
                end;
            end;
        }
        field(51228; "Quantite affectee"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Affectations achat vente"."Quantite affectee" where("Type document vente" = field("Document Type"),
                                                                                    "No. document vente" = field("Document No."),
                                                                                    "No. ligne document vente" = field("Line No.")));
            Caption = 'Quantité affectée';
            Description = 'KAN.FHA 12/05/2021 Somme des quantités affectées. Pour les 102, cela a du sens. Pour les DIV non.';
            Editable = false;
            FieldClass = FlowField;
            DecimalPlaces = 0 : 5;
        }
        field(51230; "Cout achats affectes"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Affectations achat vente"."Cout total (DS)" where("Type document vente" = field("Document Type"),
                                                                                  "No. document vente" = field("Document No."),
                                                                                  "No. ligne document vente" = field("Line No.")));
            Caption = 'Coût des achats affectés';
            Description = 'KAN';
            Editable = false;
            FieldClass = FlowField;
        }
        field(51232; "Cout unitaire force"; Boolean)
        {
            Caption = 'Coût unitaire forcé';
            DataClassification = ToBeClassified;
            Description = 'KAN';
            Editable = false;
        }
        field(51234; "Cout unitaire force par"; Code[50])
        {
            Caption = 'Coût unitaire forcé par';
            DataClassification = ToBeClassified;
            Description = 'KAN';
            Editable = false;
        }
        field(51240; "Nb affectations achats"; Integer)
        {
            BlankZero = true;
            CalcFormula = count("Affectations achat vente" where("Type document vente" = field("Document Type"),
                                                                  "No. document vente" = field("Document No."),
                                                                  "No. ligne document vente" = field("Line No."),
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
                AffectationsAchats.SetRange("No. document vente", "Document No.");
                AffectationsAchats.SetRange("No. ligne document vente", "Line No.");
                AffectationsAchats.FindFirst();

                if "Nb affectations achats" = 1 then begin
                    EnteteAchat.Get(EnteteAchat."Document Type"::Order, AffectationsAchats."No. document achat");
                    PAGE.Run(PAGE::"Purchase Order", EnteteAchat);
                end else
                    PAGE.Run(PAGE::"Affectations achat vente", AffectationsAchats);

            end;
        }
        field(51245; "Statut commande achat"; Option)
        {
            CalcFormula = min("Affectations achat vente"."Statut commande achat" where("Type document vente" = field("Document Type"),
                                                                                        "No. document vente" = field("Document No."),
                                                                                        "No. ligne document vente" = field("Line No.")));
            Description = 'KAN';
            Editable = false;
            FieldClass = FlowField;
            OptionMembers = Ouverte,"Lancée","Totalement reçue";
        }
        field(51250; "Type ligne"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            OptionMembers = " ","Début total","Fin total";

            trigger OnValidate()
            var
                txtSousTotalTxt: Label 'Sous-total';
            begin
                if "Type ligne" <> "Type ligne"::" " then begin
                    TestField("No.", '');
                    Validate(Type, 0);
                end;

                if "Type ligne" <> "Type ligne"::"Fin total" then
                    "SubTotal Amount" := 0;

                //KAN.FHA 06/04/2020 FIN
                if "Type ligne" = "Type ligne"::"Fin total" then
                    Description := txtSousTotalTxt;
                //KAN.FHA 06/04/2020 FIN
            end;
        }
        field(51260; "Packing in Progress"; Boolean)
        {
            Caption = 'Colisage en cours';
            DataClassification = ToBeClassified;
            Description = 'ABRA.COL Champ renumeroté (8056421 en NAV2013)';
            Editable = false;
        }
        field(51262; "No. UC"; Code[20])
        {
            Caption = 'N° UC';
            DataClassification = ToBeClassified;
            //TableRelation = "Unite colisage"."No." where("No. client" = field("Sell-to Customer No."));
            //ValidateTableRelation = false;
            TableRelation = "UC Commande"."No. UC" where("No. commande" = field("Document No."));
            trigger OnValidate()
            var
                UC: Record "Unite colisage";
            begin
                AjouterUC("No. UC");
                CalcFields("Nombre UC");
                if "Nombre UC" > 1 then
                    "No. UC" := 'Multiple';
            end;
        }
        field(51263; "Nombre UC"; Integer)
        {
            Caption = 'Nombre UC';
            Editable = false;
            BlankZero = true;
            FieldClass = FlowField;
            CalcFormula = Count("Prepa colisage" where("No. commande" = field("Document No."), "No. ligne commande" = field("Line No.")));
        }
        field(51264; "Quantite prepa colisage"; Decimal)
        {
            Caption = 'Quantité colisée';
            Editable = false;
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
            CalcFormula = sum("Prepa colisage"."Quantite dans UC" where("No. commande" = field("Document No."), "No. ligne commande" = field("Line No.")));
        }

        /*
        field(51265; "Quantite colisee"; Decimal)
        {
            Caption = 'Quantité colisée';
            Editable = false;
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
            CalcFormula = sum("Contenu colisage"."Quantite UC" where("Order No." = field("Document No."), "Order Line No." = field("Line No.")));
        }
        */
        field(51270; "SubTotal Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Montant sous-total HT';
            DataClassification = ToBeClassified;
            Description = 'ABRA.COL Champ renumeroté (8056602 en NAV2013)';
            Editable = false;
        }
        field(51280; Phase; Integer)
        {
            Caption = 'Phase';
            DataClassification = ToBeClassified;
            TableRelation = "Phases document".Phase where("No. document" = field("Document No."));
            BlankZero = true;
            MinValue = 0;
            trigger OnValidate()
            var
                LigneVenteComposant: Record "Sales Line";
                WEEEMgt: Codeunit "Gestion Ecopart";
                intChoix: Integer;
                ChoixMAJComposantsQst: Label 'Mettre à jour tous les composants,Que les composants qui avaient la même phase';
            begin
                TestField(Type, Type::Item);
                TestField("No.");

                //Mise à jour de la phase sur l'éco-contribution
                WEEEMgt.SalesUpdateWEEE(Rec, FieldNo(Phase));

                if not ("Document Type" in ["Document Type"::Quote, "Document Type"::Order]) then
                    exit;

                //On va regarder si l'article est composé et dans ce cas si les composants étaient sur la même phase que le composé dont on vient de changer la phase.
                //- S'ils étaient de la même phase, on ne demande rien, on les met sur la même phase.
                //- S'il y en avait au moins sur une phase différente, on demande à l'utilisateur s'il veut mettre à jour tous les composants
                //ou juste ceux qui avaient la même phase
                if Rec."Article nomenclature" and (CurrFieldNo = FieldNo(Phase)) then begin
                    //On commence par regarder parmi les composants s'il y en avait sur une autre phase
                    //PhaseUniformeSurComposants := true;
                    LigneVenteComposant.SetRange("Document Type", "Document Type");
                    LigneVenteComposant.SetRange("Document No.", "Document No.");
                    LigneVenteComposant.Setrange("Linked to line", Rec."Line No.");
                    LigneVenteComposant.SetFilter(Phase, '<>%1', xRec.Phase);
                    if LigneVenteComposant.FindFirst() then begin
                        LigneVenteComposant.SetRange(Phase);
                        intChoix := StrMenu(ChoixMAJComposantsQst, 1);
                        case intChoix of
                            1: //Mettre à jour la phase sur tous les composants
                                begin
                                    LigneVenteComposant.Findset(true);
                                    repeat
                                        LigneVenteComposant.Phase := Phase;
                                        LigneVenteComposant.Modify();
                                    until LigneVenteComposant.Next() = 0;
                                end;
                            2:  //Mettre à jour la phase que sur les composants qui avaient la même phase
                                begin
                                    LigneVenteComposant.Findset(true);
                                    repeat
                                        if LigneVenteComposant.Phase = xRec.Phase then begin
                                            LigneVenteComposant.Phase := Phase;
                                            LigneVenteComposant.Modify();
                                        end;
                                    until LigneVenteComposant.Next() = 0;
                                end;
                        end;

                    end else begin
                        LigneVenteComposant.SetRange(Phase);
                        if LigneVenteComposant.Findset(true) then
                            repeat
                                LigneVenteComposant.Phase := Phase;
                                LigneVenteComposant.Modify();
                            until LigneVenteComposant.Next() = 0;
                    end;
                end;
            end;
        }

        field(51310; "Phase a expedier"; Integer)
        {
            Caption = 'Phase à expédier';
            DataClassification = ToBeClassified;
            Description = 'Champ rempli par le système au moment où on livre une commande et qui permet au systeme de mettre à jour qté expédiée sur le phasage de la ligne.';
        }
        field(51315; "Prix unitaire composant"; Decimal)
        {
            Caption = 'Prix unitaire composant';
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            DataClassification = ToBeClassified;
        }
        field(51320; "Valeur douane unitaire"; Decimal)
        {
            Caption = 'Valeur douane unitaire';
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            DataClassification = ToBeClassified;
        }
    }

    keys
    {

        key(MyKey1; "Document Type", "Document No.", Type)//Pas possible d'ajouter Vendor No donc probleme !!!
        {

        }
        key(MyKey2; "Vendor No.")
        {

        }
        key(MyKey3; "Document Type", "Document No.", "No.")
        {

        }
        key(MyKey4; "Code enseigne", "Code chantier", "Exclure de la rentabilite")
        {

        }
        key(MyKey5; "Code chantier", "Exclure de la rentabilite", SAV, "Annee commande")
        {

        }
        key(MyKey6; "Document Type", "Completely Shipped")
        {

        }
        key(MyKey8; "Code chantier", "Exclure de la rentabilite")
        {

        }
        key(MyKey9; "Document Type", "Document No.", Type, "No.", "Variant Code")
        {
            SumIndexFields = "Outstanding Qty. (Base)";
        }
        key(MyKey10; TypeDocDuplique, NumDocDuplique, "Ligne deduction acompte", "Ligne deduction situation")
        {
            SumIndexFields = "Montant restant HT (DS)";
        }
        key(MyKey11; TypeDocDuplique, NumDocDuplique, "Ligne deduction situation")
        {
            SumIndexFields = "Montant restant HT (DS)";
        }
        key(MyKey12; TypeDocDuplique, NumDocDuplique, Phase)
        {
            SumIndexFields = "Montant achats prevus (DS)";
        }
        key(MyKey13; "Reference Fiche BE")
        {

        }
        key(MyKey14; "Eco Tax Furniture Line", TypeDocDuplique, NumDocDuplique, "Linked to line")
        {

        }
        key(MyKey15; TypeDocDuplique, NumDocDuplique, "Vendor No.", Phase)
        {

        }
    }

    procedure AjouterUC(pNumUC: Code[20])
    var
        UC: Record "Unite colisage";
        PrepaColisage: Record "Prepa colisage";
        QteNonPreparee: Decimal;
        QuantiteEntierementPrepareeErr: Label 'La quantité a déjà été entièrement préparée.';
    begin
        if pNumUC = '' then
            exit;

        CalcFields("Quantite prepa colisage");
        QteNonPreparee := Rec."Outstanding Qty. (Base)" - "Quantite prepa colisage";

        if QteNonPreparee <= 0 then
            error(QuantiteEntierementPrepareeErr);

        if not UC.Get(pNumUC) then begin
            "No. UC" := '';
            exit;
        end;

        if UC."No." <> '' then begin
            PrepaColisage.Init();
            PrepaColisage."No. commande" := "Document No.";
            PrepaColisage."No. ligne commande" := "Line No.";
            PrepaColisage."No. UC" := UC."No.";
            PrepaColisage."Type UC" := UC."Type UC";
            PrepaColisage.Numerotation := UC.Numerotation;
            PrepaColisage."Numero camion" := UC."Numero camion expedition";
            PrepaColisage.Phase := Phase;
            PrepaColisage."No. article" := "No.";
            PrepaColisage.Designation := Description;
            PrepaColisage."Quantite dans UC" := QteNonPreparee;
            PrepaColisage.Insert();
        end;

    end;

    procedure MAJPhaseSurPrepaColisage()
    var
        PrepaColisage: Record "Prepa colisage";
    begin
        if "Document Type" <> "Document Type"::Order then
            exit;

        PrepaColisage.SetRange("No. commande", Rec."Document No.");
        PrepaColisage.SetRange("No. ligne commande", Rec."Line No.");
        if PrepaColisage.FindSet(true) then
            repeat
                PrepaColisage.Phase := Rec.Phase;
                PrepaColisage.Modify();
            until PrepaColisage.Next() = 0;
    end;

    procedure CalcValeursDouane()
    var
        LigneVenteCompose: Record "Sales Line";
        LigneVenteComposant: Record "Sales Line";
        ValeurCompose: Decimal;
        PlusGrosMontantLigne: Decimal;
        TotalValeurSaupoudre: Decimal;
        MontantComposant: Decimal;
        NumLignePlusGrosMontant: Integer;
    begin
        //Cette fonction part d'un article composé (qui a un prix unitaire facturé au client) et va calculer un prix unitaire déclaré au douane
        //pour chaque article composant l'article composé.
        //Pour faire cela, chaque article a un prix unitaire fictif et on va se baser sur ce prix unitaire fictif pour calculer la valeur de douane par rapport
        //au prix unitaire du composé.
        LigneVenteCompose.SETRANGE("Document Type", "Document Type");
        LigneVenteCompose.SETRANGE("Document No.", "Document No.");
        LigneVenteCompose.setrange(Type, LigneVenteCompose.type::Item);
        if LigneVenteCompose.findset(false) then begin
            LigneVenteComposant.RESET();
            LigneVenteComposant.SETCURRENTKEY("Document Type", "Document No.", "Linked to line");
            PlusGrosMontantLigne := 0;
            NumLignePlusGrosMontant := 0;
            TotalValeurSaupoudre := 0;
            repeat
                ValeurCompose := round(LigneVenteCompose."Unit Price" * LigneVenteCompose.Quantity, 0.01);
                LigneVenteComposant.SETRANGE("Document Type", LigneVenteCompose."Document Type");
                LigneVenteComposant.SETRANGE("Document No.", LigneVenteCompose."Document No.");
                LigneVenteComposant.SETRANGE("Linked to line", LigneVenteCompose."Line No.");
                if LigneVenteComposant.FINDSET(true) then
                    repeat
                        MontantComposant := LigneVenteComposant."Prix unitaire composant" * LigneVenteComposant.Quantity;
                        if MontantComposant >= PlusGrosMontantLigne then begin //>= et non > car si on n'a qu"une ligne de marchandise remisée à zéro, on aurait aucune ligne sur laquelle saupoudrer
                            PlusGrosMontantLigne := MontantComposant;
                            NumLignePlusGrosMontant := LigneVenteComposant."Line No.";
                        end;
                    until LigneVenteComposant.Next() = 0;

            until LigneVenteCompose.Next() = 0;
        end;

    end;

    procedure SetPrixBloque(SetValue: Boolean)
    begin

        Rec."Prix bloque" := SetValue;

        if not SetValue then begin
            "Prix debloque par" := COPYSTR(USERID, 1, 50);
            "Prix avant deblocage" := "Unit Price";
        end;

        MODIFY();
    end;

    procedure RecupQuantiteEnTransit(): Decimal
    var
        Article: Record Item;
    begin
        if rec.Type <> rec.Type::Item then
            exit(0);

        if Article.get("No.") then begin
            Article.CalcFields("Quantite en transit");
            exit(Article."Quantite en transit");
        end else
            exit(0);
    end;

    procedure fctMajQuantiteComposant(var LigneVenteOrigine: Record "Sales Line");
    var
        l_FromBOMComp: Record "BOM Component";
        l_recArticle: Record Item;
        SalesLine2: Record "Sales Line";
        l_UOMMgt: Codeunit "Unit of Measure Management";
    begin
        //DIA.ABRA.BOM NBE 03/12/2014 DEBUT
        if not LigneVenteOrigine."Ligne eclatee" then //Si la ligne n'a pas encore ete eclatee pas besoin d'aller mettre à jour les lignes de composants
            exit;

        SalesLine2.RESET();
        SalesLine2.SETCURRENTKEY("Document Type", "Document No.", "Linked to line");
        SalesLine2.SETRANGE("Document Type", LigneVenteOrigine."Document Type");
        SalesLine2.SETRANGE("Document No.", LigneVenteOrigine."Document No.");
        SalesLine2.SETRANGE("Linked to line", LigneVenteOrigine."Line No.");
        if SalesLine2.FINDSET(true) then
            repeat
                l_FromBOMComp.RESET();
                l_FromBOMComp.SETRANGE("Parent Item No.", LigneVenteOrigine."No.");
                l_FromBOMComp.SETRANGE(Type, l_FromBOMComp.Type::Item);
                l_FromBOMComp.SETRANGE(l_FromBOMComp."No.", SalesLine2."No.");
                if l_FromBOMComp.FindFirst() then begin
                    l_recArticle.GET(l_FromBOMComp."No.");
                    SalesLine2.VALIDATE(Quantity,
                        ROUND(
                          LigneVenteOrigine."Quantity (Base)" * l_FromBOMComp."Quantity per" *
                          l_UOMMgt.GetQtyPerUnitOfMeasure(l_recArticle, SalesLine2."Unit of Measure Code") /
                          SalesLine2."Qty. per Unit of Measure",
                          0.00001));
                    //DIA.SCH - 13/04/2015
                    SalesLine2.VALIDATE("Unit Price", 0);
                    SalesLine2.MODIFY();
                end else begin //On est sur un composant ajoute manuellement à l'article parent (non présent au départ dans la nomenclature du parent)
                    SalesLine2.VALIDATE(Quantity,
                        ROUND(LigneVenteOrigine."Quantity (Base)" * SalesLine2."Quantite pour 1", 0.00001));
                    SalesLine2.VALIDATE("Unit Price", 0);
                    SalesLine2.MODIFY();
                end;
                ;
            until SalesLine2.NEXT() = 0;

    end;

    procedure fctMajQuantiteAExpedierComposant();
    var
        l_FromBOMComp: Record "BOM Component";
        l_recArticle: Record Item;
        SalesLine2: Record "Sales Line";
        l_UOMMgt: Codeunit "Unit of Measure Management";

    begin
        //DIA.ABRA.BOM NBE 03/12/2014 DEBUT
        if not "Ligne eclatee" then
            exit;

        SalesLine2.RESET();
        SalesLine2.SETCURRENTKEY("Document Type", "Document No.", "Linked to line");
        SalesLine2.SETRANGE("Document Type", "Document Type");
        SalesLine2.SETRANGE("Document No.", "Document No.");
        SalesLine2.SETRANGE("Linked to line", "Line No.");
        if SalesLine2.FINDSET(false) then
            repeat
                l_FromBOMComp.RESET();
                l_FromBOMComp.SETRANGE("Parent Item No.", "No.");
                l_FromBOMComp.SETRANGE(Type, l_FromBOMComp.Type::Item);
                l_FromBOMComp.SETRANGE(l_FromBOMComp."No.", SalesLine2."No.");
                if l_FromBOMComp.FINDFIRST() then begin
                    l_recArticle.GET(l_FromBOMComp."No.");
                    SalesLine2.VALIDATE("Qty. to Ship",
                        ROUND(
                          "Qty. to Ship (Base)" * l_FromBOMComp."Quantity per" *
                          l_UOMMgt.GetQtyPerUnitOfMeasure(l_recArticle, SalesLine2."Unit of Measure Code") /
                          SalesLine2."Qty. per Unit of Measure",
                          0.00001));
                    SalesLine2.MODIFY();
                end;
            until SalesLine2.NEXT() = 0;

    end;

    procedure fctRAZQuantiteAExpedier();
    var
        SalesLine2: Record "Sales Line";
        sup0Txt: Label '>0';
    begin
        SalesLine2.RESET();
        SalesLine2.SETCURRENTKEY("Document Type", "Document No.");//
        SalesLine2.SETRANGE("Document Type", "Document Type");
        SalesLine2.SETRANGE("Document No.", "Document No.");
        SalesLine2.SETFILTER(Type, '<>0');
        SalesLine2.SETFILTER("Qty. to Ship", sup0Txt);
        if SalesLine2.FINDSET(true) then
            repeat
                SalesLine2.VALIDATE("Qty. to Ship", 0);
                SalesLine2.MODIFY();
            until SalesLine2.NEXT() = 0;
    end;

    /*08/09/2025
    procedure fctRemplirQuantiteAExpedier();
    var
        SalesLine2: Record "Sales Line";
    begin
        SalesLine2.RESET();
        SalesLine2.SETCURRENTKEY("Document Type", "Document No.");
        SalesLine2.SETRANGE("Document Type", "Document Type");
        SalesLine2.SETRANGE("Document No.", "Document No.");
        SalesLine2.SETFILTER(Type, '<>0');
        SalesLine2.SETRANGE("Qty. to Ship", 0);
        if SalesLine2.FINDSET(true) then
            repeat
                SalesLine2.VALIDATE("Qty. to Ship", SalesLine2."Outstanding Quantity");
                SalesLine2.MODIFY();
            until SalesLine2.NEXT() = 0;
    end;
    08/09/2025*/
    procedure CreatePurchaseOrder(): Boolean;
    var
        lSalesHeader: Record "Sales Header";
        lrecSalesLine: Record "Sales Line";
        lrecSalesLine2: Record "Sales Line";
        lrecPurchaseHdr: Record "Purchase Header";
        lrecPurchaseLine: Record "Purchase Line";
        TempPurchLine: Record "Purchase Line" temporary;
        lrecSalesCommLine: Record "Sales Comment Line";
        lrecPurchCommLine: Record "Purch. Comment Line";
        lBeforeBuyFromNo: Code[20];
        lLineNo: Integer;

    begin
        if ("Document Type" <> "Document Type"::Order) then
            exit(false);

        TESTFIELD("Vendor No.");

        TempPurchLine.RESET();
        TempPurchLine.DELETEALL();

        lSalesHeader.GET("Document Type", "Document No.");

        lrecSalesLine.RESET();
        lrecSalesLine.SETCURRENTKEY("Document Type", "Document No.", Type, "Special Order");
        lrecSalesLine.SETRANGE("Document Type", "Document Type");
        lrecSalesLine.SETRANGE("Document No.", lSalesHeader."No.");
        lrecSalesLine.SETRANGE(Type, lrecSalesLine.Type::Item);
        lrecSalesLine.SETRANGE("Vendor No.", "Vendor No.");
        lrecSalesLine.SETRANGE("Special Order", true);
        lrecSalesLine.SETRANGE("Special Order Purchase No.", '');
        if lrecSalesLine.FINDSET() then
            repeat
                //Ligne article
                TempPurchLine.RESET();
                TempPurchLine.INIT();
                TempPurchLine."Document Type" := TempPurchLine."Document Type"::Order;
                TempPurchLine."Document No." := lSalesHeader."No.";
                TempPurchLine."Line No." := lrecSalesLine."Line No.";
                TempPurchLine.Type := lrecSalesLine.Type;
                TempPurchLine."No." := lrecSalesLine."No.";
                TempPurchLine."Variant Code" := lrecSalesLine."Variant Code";
                TempPurchLine."Location Code" := lrecSalesLine."Location Code";
                TempPurchLine."Unit of Measure" := lrecSalesLine."Unit of Measure";
                TempPurchLine.Quantity := lrecSalesLine.Quantity;
                TempPurchLine.Description := lrecSalesLine.Description;
                TempPurchLine."Description 2" := lrecSalesLine."Description 2";
                TempPurchLine."Special Order Sales No." := lrecSalesLine."Document No.";
                TempPurchLine."Special Order Sales Line No." := lrecSalesLine."Line No.";
                TempPurchLine."Buy-from Vendor No." := lrecSalesLine."Vendor No.";
                //DIA.KBO-AHO START
                TempPurchLine."Location Code" := lrecSalesLine."Location Code";
                //DIA.KBO-AHO STOP
                TempPurchLine.INSERT();
                //Lignes texte tendus
                lrecSalesLine2.RESET();
                lrecSalesLine2.SETCURRENTKEY("Document Type", "Document No.", "Linked to line");
                lrecSalesLine2.SETRANGE("Document Type", "Document Type");
                lrecSalesLine2.SETRANGE("Document No.", lSalesHeader."No.");
                lrecSalesLine2.SETRANGE("Linked to line", lrecSalesLine."Line No.");
                lrecSalesLine2.SETRANGE(Type, lrecSalesLine2.Type::" ");
                if lrecSalesLine2.FINDSET() then
                    repeat
                        TempPurchLine.RESET();
                        TempPurchLine.INIT();
                        TempPurchLine."Document Type" := TempPurchLine."Document Type"::Order;
                        TempPurchLine."Document No." := lSalesHeader."No.";
                        TempPurchLine."Line No." := lrecSalesLine2."Line No.";
                        TempPurchLine.Type := lrecSalesLine2.Type;
                        TempPurchLine."No." := lrecSalesLine2."No.";
                        TempPurchLine.Description := lrecSalesLine2.Description;
                        TempPurchLine."Description 2" := lrecSalesLine2."Description 2";
                        TempPurchLine."Buy-from Vendor No." := lrecSalesLine2."Vendor No.";
                        TempPurchLine.INSERT();
                    until lrecSalesLine2.NEXT() = 0;

            until lrecSalesLine.NEXT() = 0;


        TempPurchLine.RESET();
        TempPurchLine.SETCURRENTKEY("Document Type", "Buy-from Vendor No.");
        if TempPurchLine.FINDSET() then begin
            lBeforeBuyFromNo := '';
            repeat
                //Création de l'entte
                if (lBeforeBuyFromNo <> TempPurchLine."Buy-from Vendor No.") then begin
                    lrecPurchaseHdr.INIT();
                    lrecPurchaseHdr."No." := '';
                    lrecPurchaseHdr.VALIDATE("Document Type", lrecPurchaseHdr."Document Type"::Order);
                    lrecPurchaseHdr.INSERT(true);
                    lrecPurchaseHdr.VALIDATE("Buy-from Vendor No.", TempPurchLine."Buy-from Vendor No.");
                    lrecPurchaseHdr.VALIDATE("Purchaser Code", lSalesHeader."Salesperson Code");
                    lrecPurchaseHdr.VALIDATE("Shortcut Dimension 1 Code", lSalesHeader."Shortcut Dimension 1 Code");
                    lrecPurchaseHdr.VALIDATE("Shortcut Dimension 2 Code", lSalesHeader."Shortcut Dimension 2 Code");
                    lrecPurchaseHdr.VALIDATE("Dimension Set ID", lSalesHeader."Dimension Set ID");
                    lrecPurchaseHdr.VALIDATE(Commentaires, lSalesHeader.Commentaire);
                    //DIA.KBO-AHO START
                    lrecPurchaseHdr.VALIDATE("Location Code", lSalesHeader."Location Code");
                    //DIA.KBO-AHO STOP
                    lrecPurchaseHdr.MODIFY(true);
                    lLineNo := 10000;
                end;
                //Creation des lignes
                lrecPurchaseLine.INIT();
                lrecPurchaseLine.VALIDATE("Document Type", lrecPurchaseHdr."Document Type");
                lrecPurchaseLine.VALIDATE("Document No.", lrecPurchaseHdr."No.");
                lrecPurchaseLine."Line No." := lLineNo;
                lrecPurchaseLine.VALIDATE(Type, TempPurchLine.Type);
                lrecPurchaseLine.VALIDATE("No.", TempPurchLine."No.");
                lrecPurchaseLine.VALIDATE("Variant Code", TempPurchLine."Variant Code");
                lrecPurchaseLine.VALIDATE("Location Code", TempPurchLine."Location Code");
                lrecPurchaseLine.VALIDATE("Unit of Measure", TempPurchLine."Unit of Measure");
                lrecPurchaseLine.VALIDATE(Quantity, TempPurchLine.Quantity);
                lrecPurchaseLine.VALIDATE(Description, TempPurchLine.Description);
                lrecPurchaseLine.VALIDATE("Description 2", TempPurchLine."Description 2");
                lrecPurchaseLine.VALIDATE("Special Order", true);
                lrecPurchaseLine.VALIDATE("Special Order Sales No.", TempPurchLine."Special Order Sales No.");
                lrecPurchaseLine.VALIDATE("Special Order Sales Line No.", TempPurchLine."Special Order Sales Line No.");
                lrecPurchaseLine.INSERT(true);
                //Mise à jour des lignes de vente
                lrecSalesLine.GET(lrecSalesLine."Document Type"::Order, TempPurchLine."Special Order Sales No.",
                                  TempPurchLine."Special Order Sales Line No.");
                lrecSalesLine.VALIDATE("Special Order Purchase No.", lrecPurchaseLine."Document No.");
                lrecSalesLine.VALIDATE("Special Order Purch. Line No.", lrecPurchaseLine."Line No.");
                lrecSalesLine.MODIFY(true);
                //Lignes commentaires
                lrecSalesCommLine.RESET();
                lrecSalesCommLine.SETRANGE("Document Type", lrecSalesCommLine."Document Type"::Order);
                lrecSalesCommLine.SETRANGE("No.", TempPurchLine."Special Order Sales No.");
                lrecSalesCommLine.SETRANGE("Document Line No.", TempPurchLine."Special Order Sales Line No.");
                if lrecSalesCommLine.FINDSET() then
                    repeat
                        lrecPurchCommLine.INIT();
                        lrecPurchCommLine.TRANSFERFIELDS(lrecSalesCommLine);
                        lrecPurchCommLine.INSERT(true);
                    until lrecSalesCommLine.NEXT() = 0;

                lLineNo += 10000;
                lBeforeBuyFromNo := TempPurchLine."Buy-from Vendor No.";
            until TempPurchLine.NEXT() = 0;
            exit(true);
        end else
            exit(false);
        //+DIA.AJD.C01 26/09/18 Commande spéciale
    end;


    procedure SelectOrDeselectDoNotPrint();
    var
        lSalesLine: Record "Sales Line";
        IsSelect: Boolean;
    begin
        lSalesLine.RESET();
        lSalesLine.SETRANGE("Document Type", "Document Type");
        lSalesLine.SETRANGE("Document No.", "Document No.");
        if lSalesLine.FINDFIRST() then
            IsSelect := lSalesLine."Do not print";

        lSalesLine.RESET();
        lSalesLine.SETRANGE("Document Type", "Document Type");
        lSalesLine.SETRANGE("Document No.", "Document No.");
        if lSalesLine.FINDSET(true) then
            repeat
                if (lSalesLine."Linked to line" = 0) and (lSalesLine."Eco Tax Furniture Line" = false) then begin
                    lSalesLine."Do not print" := not IsSelect;
                    if lSalesLine."Document Type" = lSalesLine."Document Type"::Order then
                        if not IsSelect then
                            lSalesLine.VALIDATE("Qty. to Ship", 0)
                        else
                            lSalesLine.VALIDATE("Qty. to Ship", "Outstanding Quantity");

                    lSalesLine.MODIFY();
                end;
            until lSalesLine.NEXT() = 0;
    end;

    procedure Traduire()
    begin
        if Type <> Type::Item then
            exit;

        if rec."No." = '' then
            exit;

        rec.GetItemTranslation();
        message('fait');
        rec.Modify();
    end;
}


