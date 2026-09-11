table 50025 Enseigne
{
    // AXES :
    // 1 CLIENT
    // 2 AFFAIRE
    // 3 CHANTIER
    // 4 GROUPE
    // 5 ENSEIGNE

    LookupPageID = 50080;

    fields
    {
        field(10; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(20; Description; Text[50])
        {
        }
        field(25; "Code groupe"; Code[20])
        {
            TableRelation = "Groupe client";
        }
        field(30; "Filtre date"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(35; "Filtre annee commande"; Integer)
        {
            Caption = 'Filtre année commande';
            FieldClass = FlowFilter;
        }
        field(40; "Enseigne interne"; Boolean)
        {
        }
        field(60; "Code conditions paiement"; Code[10])
        {
            Description = 'Sert de valeur par défaut en cas de rattachement de nouveaux clients à l''enseigne.';
            TableRelation = "Payment Terms";
            trigger OnValidate()
            var
                Client: Record Customer;
            begin
                Client.SetCurrentKey("Code enseigne");
                Client.SetRange("Code enseigne",Rec.Code);
                if client.FindSet(true) then
                    repeat
                        if (Client."Payment Terms Code" = xRec."Code conditions paiement") or (Client."Payment Terms Code" = '') then begin
                            Client.Validate("Payment Terms Code",Rec."Code conditions paiement");
                            Client.Modify();
                        end;
                    until Client.Next() = 0;
            end;
        }
        field(70; "Code cond. paiement acomptes"; Code[10])
        {
            TableRelation = "Payment Terms";
        }
        field(72; "% acompte situation"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(74; "Code cond. paiement situation"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Terms";
        }
        field(80; "Concept obligatoire"; Boolean)
        {
        }
        field(90; "Chemin acces PDF Devis Stock"; Text[250])
        {
            Caption = 'Chemin accès PDF Devis Stock';

            trigger OnValidate()
            begin
                if "Chemin acces PDF Devis Stock" <> '' then
                    if CopyStr("Chemin acces PDF Devis Stock", StrLen("Chemin acces PDF Devis Stock"), 1) <> '\' then
                        "Chemin acces PDF Devis Stock" := COPYSTR("Chemin acces PDF Devis Stock" + '\',1,250);
            end;
        }
        field(92; "Chemin acces PDF Achats Stock"; Text[250])
        {
            Caption = 'Chemin accès PDF Achats Stock';

            trigger OnValidate()
            begin
                if "Chemin acces PDF Achats Stock" <> '' then
                    if CopyStr("Chemin acces PDF Achats Stock", StrLen("Chemin acces PDF Achats Stock"), 1) <> '\' then
                        "Chemin acces PDF Achats Stock" := COPYSTR("Chemin acces PDF Achats Stock" + '\',1,250);
            end;
        }
        field(500; "Montant factures ventes"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Sales Invoice Line"."Montant ligne HT (DS)" where ("Code enseigne" = field (Code),
                                                                                  "Exclure de la rentabilite" = const (false),
                                                                                  "Posting Date" = field ("Filtre date")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(501; "Montant avoirs ventes"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Sales Cr.Memo Line"."Montant ligne HT (DS)" where ("Code enseigne" = field (Code),
                                                                                  "Exclure de la rentabilite" = const (false),
                                                                                  "Posting Date" = field ("Filtre date")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(505; "OD Chiffre affaires"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("OD CA Enseigne"."CA transfere" where ("Code enseigne" = field (Code),
                                                                     Date = field ("Filtre date")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(510; "Montant factures achats"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Purch. Inv. Line"."Montant ligne HT (DS)" where ("Code enseigne" = field (Code),
                                                                                "Achat pour stock" = const (false),
                                                                                "Posting Date" = field ("Filtre date")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(511; "Montant avoirs achats"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Purch. Cr. Memo Line"."Montant ligne HT (DS)" where ("Code enseigne" = field (Code),
                                                                                    "Achat pour stock" = const (false),
                                                                                    "Posting Date" = field ("Filtre date")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(520; "Montant reste a livrer"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Sales Line"."Montant restant HT (DS)" where ("Document Type" = const (Order),
                                                                            "Code enseigne" = field (Code),
                                                                            "Exclure de la rentabilite" = const (false),
                                                                            SAV = const (false),
                                                                            "Annee commande" = field ("Filtre annee commande")));
            Caption = 'Montant reste à livrer';
            Editable = false;
            FieldClass = FlowField;
        }
        field(525; "Montant livre non facture"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Sales Line"."Livre non facture HT (DS)" where ("Document Type" = const (Order),
                                                                              "Code enseigne" = field (Code),
                                                                              "Annee commande" = field ("Filtre annee commande")));
            Caption = 'Montant livré non facturé';
            Editable = false;
            FieldClass = FlowField;
        }
        field(530; "Montant sur cdes achats"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Purchase Line"."Montant restant HT (DS)" where ("Document Type" = const (Order),
                                                                               "Code enseigne" = field (Code),
                                                                               "Achat pour stock" = const (false),
                                                                               "Annee commande" = field ("Filtre annee commande")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(535; "Montant recu non facture"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Purchase Line"."A. Rcd. Not Inv. Ex. VAT (LCY)" where ("Document Type" = const (Order),
                                                                                      "Code enseigne" = field (Code),
                                                                                      "Achat pour stock" = const (false),
                                                                                      "Annee commande" = field ("Filtre annee commande")));
            Caption = 'Montant reçu non facturé';
            Editable = false;
            FieldClass = FlowField;
        }
        field(540; "No. dern. chantier"; Code[20])
        {
            Editable = false;
            
        }
        field(550; "Prefixe chantier"; Code[5])
        {
            Caption = 'Préfixe chantier';

            trigger OnValidate()
            var
                CodeChantier: Code[20];
            begin
                if ("Prefixe chantier" <> '') and (xRec."Prefixe chantier" = '') then begin
                    Chantier.SetCurrentKey("Code enseigne", Cloture);
                    Chantier.SetRange("Code enseigne", Code);
                    Chantier.SetRange("Chantier Prototypes", true);
                    if not Chantier.FindSet(true) then begin
                        Chantier.Init();
                        Chantier.Code := "Prefixe chantier" + '-0000';
                        Chantier."Code enseigne" := Code;
                        Chantier."Prefixe chantier" := "Prefixe chantier";
                        Chantier."Chantier Prototypes" := true;
                        Chantier."Description chantier" := 'PROTOTYPES';
                        Chantier."Nom chantier" := 'PROTOTYPES';
                        Chantier.Insert();
                    end;

                    //KAN.FHA 10/01/2024 DEBUT
                    Chantier.Reset();
                    CodeChantier := "Prefixe chantier" + '-DESTR';
                    if not Chantier.Get(CodeChantier) then begin
                        Chantier.Init();
                        Chantier.Code := CodeChantier;
                        Chantier."Code enseigne" := Code;
                        Chantier."Prefixe chantier" := "Prefixe chantier";
                        Chantier."Chantier destruction" := true;
                        Chantier."Description chantier" := 'DESTRUCTION ' + Code;
                        Chantier."Nom chantier" := Chantier."Description chantier";
                        Chantier.Insert();
                    end;
                    //KAN.FHA 10/01/2024 FIN
                end;
            end;
        }
        field(580; "Devis STOCK"; Integer)
        {
            CalcFormula = count ("Sales Header" where ("Document Type" = const (Quote),
                                                      "Code enseigne" = field (Code),
                                                      "Devis Stock" = const (true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(590; "Commandes achat STOCK"; Integer)
        {
            CalcFormula = count ("Purchase Header" where ("Document Type" = const (Order),
                                                         "Code enseigne" = field (Code),
                                                         "Achat pour stock" = const (true),
                                                         "Annee commande" = field ("Filtre annee commande")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(600; "Montant factures achats STOCK"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Purch. Inv. Line"."Montant ligne HT (DS)" where ("Code enseigne" = field (Code),
                                                                                "Achat pour stock" = const (true),
                                                                                "Posting Date" = field ("Filtre date")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(610; "Montant avoirs achats STOCK"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Purch. Cr. Memo Line"."Montant ligne HT (DS)" where ("Code enseigne" = field (Code),
                                                                                    "Achat pour stock" = const (true),
                                                                                    "Posting Date" = field ("Filtre date")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(620; "Montant sur cdes achats STOCK"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Purchase Line"."Montant restant HT (DS)" where ("Document Type" = const (Order),
                                                                               "Code enseigne" = field (Code),
                                                                               "Achat pour stock" = const (true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(630; "Montant recu non facture STOCK"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Purchase Line"."A. Rcd. Not Inv. Ex. VAT (LCY)" where ("Document Type" = const (Order),
                                                                                      "Code enseigne" = field (Code),
                                                                                      "Achat pour stock" = const (true),
                                                                                      "Annee commande" = field ("Filtre annee commande")));
            Caption = 'Montant reçu non facturé STOCK';
            Editable = false;
            FieldClass = FlowField;
        }
        field(640; "Montant acomptes en cours"; Decimal)
        {
            BlankZero = true;
            CalcFormula = - sum ("G/L Entry".Amount where ("Code enseigne" = field (Code),
                                                         "G/L Account No." = filter ('419*'),
                                                         "Posting Date" = field ("Filtre date"),
                                                         Letter = filter ('')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(650; "Facture non paye"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum ("Detailed Cust. Ledg. Entry"."Amount (LCY)" where ("Code enseigne" = field (Code)));
            Caption = 'Balance (LCY)';
            Description = '(Solde DS)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1000; "Cout total Achats+Stock"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Ecriture rentabilite"."Montant total (DS)" where ("Code enseigne" = field (Code),
                                                                                 "Type ecriture" = const ("Coût"),
                                                                                 "Type de cout" = filter (Stock .. Achat)));
            Caption = 'Coût total Achats+Stock';
            Description = 'Correspond de toutes les natures de vente donc des champs 1001 à 1054';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1001; "Cout total hors catégorie"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Ecriture rentabilite"."Montant total (DS)" where ("Code enseigne" = field (Code),
                                                                                 "Type ecriture" = const ("Coût"),
                                                                                 "Nature vente" = const ("Indéfini"),
                                                                                 "Type de cout" = filter (Stock .. Achat)));
            Caption = 'Coût total hors catégorie';
            Description = 'Renta : Coût dont la nature de vente est "Indéfinie"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1002; "Cout total Mobilier"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Ecriture rentabilite"."Montant total (DS)" where ("Code enseigne" = field (Code),
                                                                                 "Type ecriture" = const ("Coût"),
                                                                                 "Nature vente" = const (Mobilier),
                                                                                 "Type de cout" = filter (Stock .. Achat)));
            Caption = 'Coût total Mobilier';
            Description = 'Renta';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1012; "Cout total Pose/Audit"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Ecriture rentabilite"."Montant total (DS)" where ("Code enseigne" = field (Code),
                                                                                 "Type ecriture" = const ("Coût"),
                                                                                 "Nature vente" = const ("Pose/Audit"),
                                                                                 "Type de cout" = filter (Stock .. Achat)));
            Caption = 'Coût total Pose/Audit';
            Description = 'Renta';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1022; "Cout total Transport"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Ecriture rentabilite"."Montant total (DS)" where ("Code enseigne" = field (Code),
                                                                                 "Type ecriture" = const ("Coût"),
                                                                                 "Nature vente" = const (Transport),
                                                                                 "Type de cout" = filter (Stock .. Achat)));
            Caption = 'Coût total Transport';
            Description = 'Renta';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1032; "Cout total Bennes/Fenwick"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Ecriture rentabilite"."Montant total (DS)" where ("Code enseigne" = field (Code),
                                                                                 "Type ecriture" = const ("Coût"),
                                                                                 "Nature vente" = const ("Bennes/Fenwick"),
                                                                                 "Type de cout" = filter (Stock .. Achat)));
            Caption = 'Coût total Bennes/Fenwick';
            Description = 'Renta';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1042; "Cout total SAV"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Ecriture rentabilite"."Montant total (DS)" where ("Code enseigne" = field (Code),
                                                                                 "Type ecriture" = const ("Coût"),
                                                                                 "Nature vente" = const (SAV),
                                                                                 "Type de cout" = filter (Stock .. Achat)));
            Caption = 'Coût total SAV';
            Description = 'Renta';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1052; "Frais d'approche"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Ecriture rentabilite"."Montant total (DS)" where ("Code enseigne" = field (Code),
                                                                                 "Type ecriture" = const ("Coût"),
                                                                                 "Type de cout" = const (Approche)));
            Caption = 'Frais d''approche';
            Description = 'Renta';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1054; "Frais d'emballage"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Ecriture rentabilite"."Montant total (DS)" where ("Code enseigne" = field (Code),
                                                                                 "Type ecriture" = const ("Coût"),
                                                                                 "Type de cout" = const (Emballage)));
            Caption = 'Frais d''emballage';
            Description = 'Renta';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2000; "CA Total"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Ecriture rentabilite"."Montant total (DS)" where ("Type ecriture" = const (CA),
                                                                                 "Code enseigne" = field (Code),
                                                                                 "Date comptabilisation" = field ("Filtre date")));
            Description = 'Renta';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2020; "CA Mobilie"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Ecriture rentabilite"."Montant total (DS)" where ("Code enseigne" = field (Code),
                                                                                 "Type ecriture" = const (CA),
                                                                                 "Nature vente" = const (Mobilier),
                                                                                 "Date comptabilisation" = field ("Filtre date")));
            Caption = 'CA Mobilier';
            Description = 'Renta';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2030; "CA Pose/Audit"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Ecriture rentabilite"."Montant total (DS)" where ("Type ecriture" = const (CA),
                                                                                 "Code enseigne" = field (Code),
                                                                                 "Nature vente" = const ("Pose/Audit"),
                                                                                 "Date comptabilisation" = field ("Filtre date")));
            Caption = 'CA Pose/Audit';
            Description = 'Renta';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2040; "CA Transport"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Ecriture rentabilite"."Montant total (DS)" where ("Type ecriture" = const (CA),
                                                                                 "Code enseigne" = field (Code),
                                                                                 "Nature vente" = const (Transport),
                                                                                 "Date comptabilisation" = field ("Filtre date")));
            Caption = 'CA Transport';
            Description = 'Renta';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2050; "CA Bennes/Fenwick"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Ecriture rentabilite"."Montant total (DS)" where ("Type ecriture" = const (CA),
                                                                                 "Code enseigne" = field (Code),
                                                                                 "Nature vente" = const ("Bennes/Fenwick"),
                                                                                 "Date comptabilisation" = field ("Filtre date")));
            Caption = 'CA Bennes/Fenwick';
            Description = 'Renta';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2060; "CA SAV"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Ecriture rentabilite"."Montant total (DS)" where ("Type ecriture" = const (CA),
                                                                                 "Code enseigne" = field (Code),
                                                                                 "Nature vente" = const (SAV),
                                                                                 "Date comptabilisation" = field ("Filtre date")));
            Caption = 'CA SAV';
            Description = 'Renta';
            Editable = false;
            FieldClass = FlowField;
        }
        field(3000;"Nombre interlocuteurs";Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Interlocuteurs Enseigne" where ("Code enseigne"= field(code)));
            Editable = false;
        }
        field(3010;"Dernier No. interlocuteur cree";Integer)
        {
            Caption = 'Dernier N° interlocuteur créé';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; "Enseigne interne")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Chantier.Reset();
        Chantier.SetCurrentKey("Code enseigne", "Chantier archive");
        Chantier.SetRange("Code enseigne", Code);
        if Chantier.FindFirst() then
            Error(ChantierRattacheErr);
    end;

    trigger OnInsert()
    begin
        if GetFilter("Code groupe") <> '' then
            if GetRangeMin("Code groupe") = GetRangeMax("Code groupe") then
                "Code groupe" := GetRangeMin("Code groupe");
    end;

    var
        Chantier: Record Chantier;
        ChantierRattacheErr: Label 'Vous ne pouvez pas supprimer une enseigne à laquelle des chantiers sont rattachés.';
        
        OperationInterrompueErr: Label 'Opération interrompue à la demande de l''utilisateur.';

    procedure CreerCdeAchatStock()
    var
        EnteteAchat: Record "Purchase Header";
        CreerDocumentStockQst: Label 'Voulez-vous créer une commande d''achat pour stock ?';
    begin
        TestField("Code groupe");

        if not Confirm(CreerDocumentStockQst) then
            exit;

        EnteteAchat.Init();
        EnteteAchat."Document Type" := EnteteAchat."Document Type"::Order;
        EnteteAchat."No." := '';
        EnteteAchat.Insert(true);

        EnteteAchat."Code groupe" := "Code groupe";
        EnteteAchat."Code enseigne" := Code;
        EnteteAchat."Achat pour stock" := true;
        EnteteAchat.Modify();

        PAGE.Run(50, EnteteAchat);
    end;

    procedure CreerDevisVenteStock()
    var
        EnteteVente: Record "Sales Header";
        CreerDocumentStockQst: Label 'Voulez-vous créer un devis pour stock ?';
    begin
        TestField("Code groupe");

        if not Confirm(CreerDocumentStockQst) then
            exit;

        EnteteVente.Init();
        EnteteVente."Document Type" := EnteteVente."Document Type"::Quote;
        EnteteVente."No." := '';
        EnteteVente.Insert(true);

        EnteteVente."Code groupe" := "Code groupe";
        EnteteVente."Code enseigne" := Code;
        EnteteVente."Devis Stock" := true;
        EnteteVente.Modify();

        PAGE.Run(41, EnteteVente);
    end;

    procedure CreerNouveauChantier(pNumChantierOrigine: Code[20]; pPrefixe: Code[5])
    var
        AncienChantier: Record Chantier;
        NouvNum: Code[20];
        ChantierInconnu: Boolean;
        OuvrirNouveauChantierQst: Label 'Nouveau chantier créé sous le numéro : %1. Voulez-vous l''afficher pour le compléter ?',Comment = '%1 = N° du nouveau chantier';
        PrefixeCompletErr: Label 'Plus possible de créer de chantiers sur cette enseigne avec ce préfixe.';
        CloturerChantierActifQst: Label 'Le chantier %1 n''est pas clôturé. Si vous voulez créer un nouveau chantier à partir de ce chantier, il sera automatiquement clôturé. Confirmez-vous ?',Comment='%1 = N° chantier';
    begin
        if pNumChantierOrigine <> '' then begin
            AncienChantier.Get(pNumChantierOrigine);
            if not AncienChantier.Cloture and not Chantier."Chantier archive" then begin
                if not Confirm(CloturerChantierActifQst, true, pNumChantierOrigine) then
                    Error(OperationInterrompueErr);
                AncienChantier.Cloturer();
            end;
        end;

        Chantier.SetRange("Prefixe chantier", pPrefixe);
        Chantier.SetRange("Chantier destruction", false);
        if Chantier.FindLast() then
            NouvNum := IncStr(Chantier.Code)
        else
            NouvNum := pPrefixe + '-' + '0001';

        if Chantier.Get(NouvNum) then
            repeat
                NouvNum := IncStr(NouvNum);
                ChantierInconnu := not (Chantier.Get(NouvNum));
            until (NouvNum = '9999') or (ChantierInconnu);

        if NouvNum = '9999' then
            Error(PrefixeCompletErr);

        Chantier.Reset();
        Chantier.Init();

        if OperationInterrompueErr <> '' then begin
            Chantier.TransferFields(AncienChantier);
            Chantier."Statut chantier" := Chantier."Statut chantier"::"Création";
            Chantier."Chantier archive" := false;
            Chantier.Cloture := false;
            Chantier."Chantier a verifier (>=2020)" := false;
            Chantier."Chantier verifie" := false;
        end;
        Chantier."Prefixe chantier" := pPrefixe;
        Chantier.Code := NouvNum;
        Chantier."Code enseigne" := Code;
        Chantier."Activer rentabilite" := true;
        Chantier.Insert();
        Chantier.MAJAdrDest();

        "No. dern. chantier" := NouvNum;

        if Confirm(OuvrirNouveauChantierQst, true, Chantier.Code) then
            PAGE.Run(PAGE::"Fiche chantier", Chantier)
    end;

    procedure ChantierAnnuel(pDateCompta: Date): Code[20]
    var
        Annee: Integer;
        txtAnnee: Code[4];
        CodeChantier: Code[20];
    begin
        if pDateCompta <> 0D then
            Annee := Date2DMY(pDateCompta, 3)
        else
            Annee := Date2DMY(Today, 3);

        txtAnnee := Format(Annee);

        CodeChantier := "Prefixe chantier" + '-' + txtAnnee;
        if not Chantier.Get(CodeChantier) then begin
            Chantier.Init();
            Chantier.Code := CodeChantier;
            Chantier."Code enseigne" := Code;
            Chantier.Insert();
        end;

        exit(CodeChantier);
    end;
}

