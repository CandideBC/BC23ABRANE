table 50027 Chantier
{
    // CLIENT
    // AFFAIRE
    // CHANTIER
    // GROUPE
    // ENSEIGNE

    LookupPageID = 50083;

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Code enseigne"; Code[20])
        {
            TableRelation = Enseigne;
        }
        field(5; "Prefixe chantier"; Code[5])
        {
            Caption = 'Préfixe chantier';
        }
        field(6; "Code concept"; Code[20])
        {

        }
        field(7; "Chantier Prototypes"; Boolean)
        {
        }
        field(8; "Annee du chantier"; Integer)
        {
            Caption = 'Année du chantier';
        }
        field(9; "Chantier destruction"; Boolean)
        {
            Description = 'Permet de filtrer quand on crée un nouveau chantier depuis l''enseigne car sinon l''INCSTR qui cherche le dernier N° + 1 plante puisque sans ce filtre il tomberait sur le chantier DESTR qui est le dernier de la liste';
        }
        field(10; "No. client"; Code[20])
        {
            Caption = 'N° donneur d''ordre';
            TableRelation = Customer;

            trigger OnValidate()
            var
                Client: Record Customer;
            begin
                //KAN.FHA 26/08/2022 DEBUT
                if "No. client" <> xRec."No. client" then begin
                    //KAN.FHA 20/10/2025 DEBUT
                    if client.Get("No. client") then
                        "Code pays chantier" := Client."Country/Region Code"
                    else
                        "Code pays chantier" := '';
                    //KAN.FHA 20/10/2025 FIN

                    MAJAdrDest();
                end;
                //KAN.FHA 26/08/2022 FIN

            end;
        }
        field(11; "Nom client"; Text[100])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("No. client")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Nom 2 client"; Text[50])
        {
            CalcFormula = lookup(Customer."Name 2" where("No." = field("No. client")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; "Code postal client"; Code[20])
        {
            CalcFormula = lookup(Customer."Post Code" where("No." = field("No. client")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(19; "Ville client"; Text[30])
        {
            CalcFormula = lookup(Customer.City where("No." = field("No. client")));
            Caption = 'Ville client';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Description chantier"; Text[50])
        {
            Caption = 'Description chantier';

            trigger OnValidate()
            begin
                MAJAnalytiqueChantier();
            end;
        }
        field(30; "Filtre date"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(31; "Filtre annee commande"; Integer)
        {
            Caption = 'Filtre année commande';
            FieldClass = FlowFilter;
        }
        field(32; "Nom chantier"; Text[50])
        {
            Caption = 'Nom chantier';
        }
        field(34; "Nom chantier 2"; Text[50])
        {
            Caption = 'Nom chantier 2';
        }
        field(36; "Adresse chantier"; Text[50])
        {
            Caption = 'Adresse';
        }
        field(38; "Adresse chantier 2"; Text[50])
        {
            Caption = 'Adresse 2';
        }
        field(40; "Code postal chantier"; Code[20])
        {
            Caption = 'Code postal';
            TableRelation = if ("Code pays chantier" = const('')) "Post Code"
            else
            if ("Code pays chantier" = filter(<> '')) "Post Code" where("Country/Region Code" = field("Code pays chantier"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode("Ville chantier", "Code postal chantier", Region, "Code pays chantier", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(45; "Ville chantier"; Text[30])
        {
            Caption = 'Ville';
            TableRelation = if ("Code pays chantier" = const('')) "Post Code".City
            else
            if ("Code pays chantier" = filter(<> '')) "Post Code".City where("Country/Region Code" = field("Code pays chantier"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(47; Region; Text[30])
        {
            Caption = 'Région';
        }
        field(50; "Code pays chantier"; Code[10])
        {
            Caption = 'Code pays';
            TableRelation = "Country/Region";
            trigger OnValidate()
            var
                Client:Record Customer;
                AttentionPaysMsg: Label 'Attention, le pays du chantier (%1) ne correspond pas au pays du client (%2) , il faut vérifier avec la comptabilité ce qu''il convient de faire concernant la TVA.',Comment = '%1 = pays du chantier ; %2 = pays du client';
            begin
                if client.Get("No. client") then
                    if "Code pays chantier" <> Client."Country/Region Code" then
                        message(AttentionPaysMsg,Rec."Code pays chantier",Client."Country/Region Code");
            end;
        }
        field(55; "Contact chantier"; Text[50])
        {
            Caption = 'Contact';
        }
        field(60; "No. téléphone chantier"; Text[30])
        {
            Caption = 'N° téléphone';
            ExtendedDatatype = PhoneNo;
        }
        field(70; "Shipment Method Code"; Code[10])
        {
            Caption = 'Code condition livraison';
            TableRelation = "Shipment Method";
        }
        field(80; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Code transporteur';
            TableRelation = "Shipping Agent";
        }
        field(90; "E-Mail chantier"; Text[80])
        {
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(100; "Location Code"; Code[10])
        {
            Caption = 'Code magasin';
            TableRelation = Location where("Use As In-Transit" = const(false));
        }
        field(110; "Statut chantier"; Option)
        {
            Editable = false;
            OptionMembers = "Création",Devis,"En cours","Terminé";
        }
        field(112; Cloture; Boolean)
        {
            Caption = 'Clôturé';
        }
        field(118; "Chantier archive"; Boolean)
        {
            Description = 'Chantiers terminés avant 2020 et dont les chiffres sont vraisemblablement faux.';
        }
        field(119; "Chantier a verifier (>=2020)"; Boolean)
        {
            Caption = 'Chantier à vérifier (>=2020)';
        }
        field(120; "Chantier verifie"; Boolean)
        {
            Caption = 'Chantier vérifié';
            Description = 'Au démarrage du module affaires on va chercher à vérifier si toutes les factures ont bien été affectées chantier par chantier. Ce champ permet juste de suivre lesquels ont été vérifiés ou non.';
        }
        field(130; "Adr. facture=Adr. livraison"; Boolean)
        {
            Description = 'KAN.FHA 26/10/2020';
        }
        field(140; "Chemin acces PDF Devis"; Text[250])
        {
            Caption = 'Chemin accès PDF Vente';

            trigger OnValidate()
            begin
                if "Chemin acces PDF Devis" <> '' then
                    if CopyStr("Chemin acces PDF Devis", StrLen("Chemin acces PDF Devis"), 1) <> '\' then
                        "Chemin acces PDF Devis" := COPYSTR("Chemin acces PDF Devis" + '\', 1, 250);
            end;
        }
        field(150; "Chemin acces PDF Achats"; Text[250])
        {
            Caption = 'Chemin accès PDF Achats';

            trigger OnValidate()
            begin
                if "Chemin acces PDF Achats" <> '' then
                    if CopyStr("Chemin acces PDF Achats", StrLen("Chemin acces PDF Achats"), 1) <> '\' then
                        "Chemin acces PDF Achats" := CopyStr("Chemin acces PDF Achats" + '\', 1, 250);
            end;
        }
        field(160; "Chemin acces PDF BL"; Text[250])
        {
            Caption = 'Chemin accès PDF BL';

            trigger OnValidate()
            begin
                if "Chemin acces PDF BL" <> '' then
                    if CopyStr("Chemin acces PDF BL", StrLen("Chemin acces PDF BL"), 1) <> '\' then
                        "Chemin acces PDF BL" := CopyStr("Chemin acces PDF BL" + '\', 1, 250);
            end;
        }
        field(170; "Chemin acces PDF Factures"; Text[250])
        {
            Caption = 'Chemin accès PDF Factures';

            trigger OnValidate()
            begin
                if "Chemin acces PDF Factures" <> '' then
                    if CopyStr("Chemin acces PDF Factures", StrLen("Chemin acces PDF Factures"), 1) <> '\' then
                        "Chemin acces PDF Factures" := CopyStr("Chemin acces PDF Factures" + '\', 1, 250);
            end;
        }
        field(500; "Montant factures vente"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Sales Invoice Line"."Montant ligne HT (DS)" where("Code chantier" = field(Code),
                                                                                  "Exclure de la rentabilite" = const(false),
                                                                                  "Posting Date" = field("Filtre date")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(501; "Montant avoirs vente"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Sales Cr.Memo Line"."Montant ligne HT (DS)" where("Code chantier" = field(Code),
                                                                                  "Exclure de la rentabilite" = const(false),
                                                                                  "Posting Date" = field("Filtre date")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(510; "Montant factures achats"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Purch. Inv. Line"."Montant ligne HT (DS)" where("Code chantier" = field(Code),
                                                                                "Achat pour stock" = const(false),
                                                                                "Posting Date" = field("Filtre date")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(511; "Montant avoirs achats"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Purch. Cr. Memo Line"."Montant ligne HT (DS)" where("Code chantier" = field(Code),
                                                                                    "Achat pour stock" = const(false),
                                                                                    "Posting Date" = field("Filtre date")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(520; "Montant reste a livrer"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Sales Line"."Montant restant HT (DS)" where("Document Type" = const(Order),
                                                                            "Code chantier" = field(Code),
                                                                            "Exclure de la rentabilite" = const(false),
                                                                            SAV = const(false),
                                                                            "Annee commande" = field("Filtre annee commande")));
            Caption = 'Montant reste à livrer';
            Editable = false;
            FieldClass = FlowField;
        }
        field(525; "Montant livre non facture"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Sales Line"."Livre non facture HT (DS)" where("Document Type" = const(Order),
                                                                              "Code chantier" = field(Code),
                                                                              "Exclure de la rentabilite" = const(false),
                                                                              "Annee commande" = field("Filtre annee commande")));
            Caption = 'Montant livré non facturé';
            Editable = false;
            FieldClass = FlowField;
        }
        field(530; "Montant sur cdes achats"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Purchase Line"."Montant restant HT (DS)" where("Document Type" = const(Order),
                                                                               "Code chantier" = field(Code),
                                                                               "Annee commande" = field("Filtre annee commande")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(535; "Montant recu non facture"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Purchase Line"."A. Rcd. Not Inv. Ex. VAT (LCY)" where("Document Type" = const(Order),
                                                                                      "Code chantier" = field(Code),
                                                                                      "Annee commande" = field("Filtre annee commande")));
            Caption = 'Montant reçu non facturé';
            Editable = false;
            FieldClass = FlowField;
        }
        field(540; "Nombre devis"; Integer)
        {
            BlankZero = true;
            CalcFormula = count("Sales Header" where("Document Type" = const(Quote),
                                                      "Code chantier" = field(Code)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(800; "Date premiere facture vte"; Date)
        {
            CalcFormula = min("Sales Invoice Header"."Posting Date" where("Code chantier" = field(Code)));
            Caption = 'Date première facture vte';
            Editable = false;
            FieldClass = FlowField;
        }
        field(810; "Date derniere facture vte"; Date)
        {
            CalcFormula = max("Sales Invoice Header"."Posting Date" where("Code chantier" = field(Code)));
            Caption = 'Date dernière facture vte';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1000; "Cout total Achats+Stock"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Ecriture rentabilite"."Montant total (DS)" where("Code chantier" = field(Code),
                                                                                 "Type ecriture" = const("Coût"),
                                                                                 "Type de cout" = filter(Stock .. Achat)));
            Caption = 'Coût total Achats+Stock';
            Description = 'Correspond de toutes les natures de vente donc des champs 1001 à 1054';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1001; "Cout total hors catégorie"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Ecriture rentabilite"."Montant total (DS)" where("Code chantier" = field(Code),
                                                                                 "Type ecriture" = const("Coût"),
                                                                                 "Nature vente" = const("Indéfini"),
                                                                                 "Type de cout" = filter(Stock .. Achat)));
            Caption = 'Cout total hors catégorie';
            Description = 'Renta : Coût dont la nature de vente est "Indéfinie"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1002; "Cout total Mobilier"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Ecriture rentabilite"."Montant total (DS)" where("Code chantier" = field(Code),
                                                                                 "Type ecriture" = const("Coût"),
                                                                                 "Nature vente" = const(Mobilier),
                                                                                 "Type de cout" = filter(Stock .. Achat)));
            Caption = 'Coût total Mobilier';
            Description = 'Renta';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1012; "Cout total Pose/Audit"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Ecriture rentabilite"."Montant total (DS)" where("Code chantier" = field(Code),
                                                                                 "Type ecriture" = const("Coût"),
                                                                                 "Nature vente" = const("Pose/Audit"),
                                                                                 "Type de cout" = filter(Stock .. Achat)));
            Caption = 'Coût total Pose/Audit';
            Description = 'Renta';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1022; "Cout total Transport"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Ecriture rentabilite"."Montant total (DS)" where("Code chantier" = field(Code),
                                                                                 "Type ecriture" = const("Coût"),
                                                                                 "Nature vente" = const(Transport),
                                                                                 "Type de cout" = filter(Stock .. Achat)));
            Caption = 'Coût total Transport';
            Description = 'Renta';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1032; "Cout total Bennes/Fenwick"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Ecriture rentabilite"."Montant total (DS)" where("Code chantier" = field(Code),
                                                                                 "Type ecriture" = const("Coût"),
                                                                                 "Nature vente" = const("Bennes/Fenwick"),
                                                                                 "Type de cout" = filter(Stock .. Achat)));
            Caption = 'Coût total Bennes/Fenwick';
            Description = 'Renta';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1042; "Cout total SAV"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Ecriture rentabilite"."Montant total (DS)" where("Code chantier" = field(Code),
                                                                                 "Type ecriture" = const("Coût"),
                                                                                 "Nature vente" = const(SAV),
                                                                                 "Type de cout" = filter(Stock .. Achat)));
            Caption = 'Coût total SAV';
            Description = 'Renta';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1052; "Frais d'approche"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Ecriture rentabilite"."Montant total (DS)" where("Code chantier" = field(Code),
                                                                                 "Type ecriture" = const("Coût"),
                                                                                 "Type de cout" = const(Approche)));
            Caption = 'Frais d''approche';
            Description = 'Renta';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1054; "Frais d'emballage"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Ecriture rentabilite"."Montant total (DS)" where("Code chantier" = field(Code),
                                                                                 "Type ecriture" = const("Coût"),
                                                                                 "Type de cout" = const(Emballage)));
            Caption = 'Frais d''emballage';
            Description = 'Renta';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2000; "CA Total"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Ecriture rentabilite"."Montant total (DS)" where("Type ecriture" = const(CA),
                                                                                 "Code chantier" = field(Code),
                                                                                 "Date comptabilisation" = field("Filtre date")));
            Description = 'Renta';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2010; "Activer rentabilite"; Boolean)
        {
            Caption = 'Activer rentabilité';
            Description = 'Tout nouveau chantier sera coché mais on ne va pas créer des écritures rentabilité sur des chantiers entamés au moment où je mets en place la nouvelle logique de calcul de la renta des chantiers.';
        }
        field(2020; "CA Mobilier (Renta)"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Ecriture rentabilite"."Montant total (DS)" where("Code chantier" = field(Code),
                                                                                 "Type ecriture" = const(CA),
                                                                                 "Nature vente" = const(Mobilier),
                                                                                 "Date comptabilisation" = field("Filtre date")));
            Caption = 'CA Mobilier (Renta)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2030; "CA Pose/Audit (Renta)"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Ecriture rentabilite"."Montant total (DS)" where("Type ecriture" = const(CA),
                                                                                 "Code chantier" = field(Code),
                                                                                 "Nature vente" = const("Pose/Audit"),
                                                                                 "Date comptabilisation" = field("Filtre date")));
            Caption = 'CA Pose/Audit (Renta)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2040; "CA Transport (Renta)"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Ecriture rentabilite"."Montant total (DS)" where("Type ecriture" = const(CA),
                                                                                 "Code chantier" = field(Code),
                                                                                 "Nature vente" = const(Transport),
                                                                                 "Date comptabilisation" = field("Filtre date")));
            Caption = 'CA Transport (Renta)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2050; "CA Bennes/Fenwick (Renta)"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Ecriture rentabilite"."Montant total (DS)" where("Type ecriture" = const(CA),
                                                                                 "Code chantier" = field(Code),
                                                                                 "Nature vente" = const("Bennes/Fenwick"),
                                                                                 "Date comptabilisation" = field("Filtre date")));
            Caption = 'CA Bennes/Fenwick (Renta)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2060; "CA SAV (Renta)"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Ecriture rentabilite"."Montant total (DS)" where("Type ecriture" = const(CA),
                                                                                 "Code chantier" = field(Code),
                                                                                 "Nature vente" = const(SAV),
                                                                                 "Date comptabilisation" = field("Filtre date")));
            Caption = 'CA SAV (Renta)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(3000; "Nombre interlocuteurs"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Interlocuteurs Chantier" where("Code chantier" = field(code)));
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; "No. client")
        {
        }
        key(Key3; "Prefixe chantier")
        {
        }
        key(Key4; "Code enseigne", "Chantier archive", Cloture)
        {
        }
        key(Key5; "Chantier archive", "No. client")
        {
        }
        key(Key6; "Chantier archive")
        {
        }
        key(Key7; "Code enseigne", Cloture)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", "Description chantier", "Nom chantier")
        {
        }
    }

    trigger OnDelete()
    begin
        LigneVente.Reset();
        LigneVente.SetCurrentKey("Code chantier");
        LigneVente.SetRange("Code chantier", Code);
        if LigneVente.FindFirst() then
            Error(LignesVentesExistentErr, LigneVente."Document Type", LigneVente."Document No.");

        LigneAchat.Reset();
        LigneAchat.SetCurrentKey("Code chantier");
        LigneAchat.SetRange("Code chantier", Code);
        if LigneAchat.FindFirst() then
            Error(LignesAchatsExistentErr, LigneAchat."Document Type", LigneAchat."Document No.");
    end;

    trigger OnInsert()
    begin
        if GetFilter("Code enseigne") <> '' then
            if GetRangeMin("Code enseigne") = GetRangeMax("Code enseigne") then
                "Code enseigne" := GetRangeMin("Code enseigne");

        "Activer rentabilite" := true;

        MAJAnalytiqueChantier();
    end;

    trigger OnModify()
    begin
        if "No. client" <> '' then
            if ("Nom chantier" <> xRec."Nom chantier") or
               ("Nom chantier 2" <> xRec."Nom chantier 2") or
               ("Adresse chantier" <> xRec."Adresse chantier") or
               ("Adresse chantier 2" <> xRec."Adresse chantier 2") or
               ("Code postal chantier" <> xRec."Code postal chantier") or
               ("Ville chantier" <> xRec."Ville chantier") or
               ("Code pays chantier" <> xRec."Code pays chantier") or
               ("Contact chantier" <> xRec."Contact chantier") or
               ("No. téléphone chantier" <> xRec."No. téléphone chantier") or
               ("Shipment Method Code" <> xRec."Shipment Method Code") or
               ("Shipping Agent Code" <> xRec."Shipping Agent Code") or
               ("E-Mail chantier" <> xRec."E-Mail chantier") or
               ("Location Code" <> xRec."Location Code") or
               //KAN.FHA 26/10/2020 DEBUT
               ("Adr. facture=Adr. livraison" <> xRec."Adr. facture=Adr. livraison")
            //KAN.FHA 26/10/2020 FIN
            then
                MAJAdrDest();
    end;

    var
        PostCode: Record "Post Code";
        ShipToAddr: Record "Ship-to Address";
        LigneVente: Record "Sales Line";
        LigneAchat: Record "Purchase Line";
        StatutChantier: Option "Création",Devis,"En cours","Terminé";

        LignesVentesExistentErr: Label 'Vous ne pouvez pas supprimer ce chantier car des documents de vente lui sont rattachés (%1 %2).', Comment = '%1 = Type document ; %2 = N° document';

        LignesAchatsExistentErr: Label 'Vous ne pouvez pas supprimer ce chantier car des documents d''achats lui sont rattachés (%1 %2).', Comment = '%1 = Type document ; %2 = N° document';
        ChoixCreationVenteLbl: Label 'Standard,SAV';
        Selection: Integer;
        ChoixCreationAchatLbl: Label 'Standard,SAV fournisseur,SAV Abrane';

    procedure CreerCdeAchat()
    var
        EnteteAchat: Record "Purchase Header";
        Enseigne: Record Enseigne;

        ParamAchat: Record "Purchases & Payables Setup";
        RelationSouches: Record "No. Series Relationship";
        CodeSoucheCommandeSAV: Code[20];
        AucuneSoucheAchatSAVErr: Label 'Aucune souche n''a été définie pour les commandes d''achats de SAV.';
    begin
        TestField("Code enseigne");
        TestField(Cloture, false);

        //IF NOT CONFIRM(CreerCdeAchatQst) THEN
        //  EXIT;

        Selection := StrMenu(ChoixCreationAchatLbl, 1);
        if Selection = 0 then
            exit;

        EnteteAchat.Init();
        EnteteAchat."Document Type" := EnteteAchat."Document Type"::Order;
        EnteteAchat."No." := '';
        //KAN.FHA 05/05/2021 DEBUT
        //IF Selection = 2 THEN BEGIN
        if Selection in [2, 3] then begin
            //KAN.FHA 05/05/2021 FIN
            CodeSoucheCommandeSAV := '';
            ParamAchat.Get();
            ParamAchat.TestField("Order Nos.");
            RelationSouches.SetRange(RelationSouches.Code, ParamAchat."Order Nos.");
            if RelationSouches.FindSet() then
                repeat
                    if StrPos(RelationSouches."Series Code", 'SAV') <> 0 then
                        CodeSoucheCommandeSAV := RelationSouches."Series Code";
                until (RelationSouches.Next() = 0) or (CodeSoucheCommandeSAV <> '');
            if CodeSoucheCommandeSAV <> '' then
                EnteteAchat."No. Series" := CodeSoucheCommandeSAV
            else
                Error(AucuneSoucheAchatSAVErr);
        end;

        EnteteAchat.Insert(true);

        Enseigne.Get("Code enseigne");
        if Enseigne."Concept obligatoire" then
            TestField("Code concept");

        EnteteAchat."Code groupe" := Enseigne."Code groupe";
        EnteteAchat."Code enseigne" := "Code enseigne";
        EnteteAchat."Code chantier" := Code;

        //KAN.FHA 05/05/2021 DEBUT
        //EnteteAchat.SAV := (Selection = 2);
        EnteteAchat.SAV := (Selection = 2) or (Selection = 3);
        //KAN.FHA 05/05/2021 FIN

        if EnteteAchat.SAV then
            //KAN.FHA 05/05/2021 DEBUT
            //EnteteAchat."SAV Type" := EnteteAchat."SAV Type"::Vendor;
            //Remplacé par :
            if Selection = 2 then
                EnteteAchat."SAV Type" := EnteteAchat."SAV Type"::FOURNISSEUR
            else
                EnteteAchat."SAV Type" := EnteteAchat."SAV Type"::ABRANE;
        //KAN.FHA 05/05/2021 FIN
        EnteteAchat.Modify();

        PAGE.Run(50, EnteteAchat);
    end;

    procedure CreerDocumentVente(pTypeDoc: Option Devis,Commande)
    var
        EnteteVente: Record "Sales Header";
        Enseigne: Record Enseigne;
        ClientDonneurOrdre: Record Customer;
    begin
        TestField(Cloture, false);

        //KAN.FHA 18/04/2023 DEBUT
        TestField("Code pays chantier");
        //KAN.FHA 18/04/2023 FIN

        Selection := StrMenu(ChoixCreationVenteLbl, 1);
        if Selection = 0 then
            exit;

        TestField("Code enseigne");
        TestField("No. client");

        ClientDonneurOrdre.Get("No. client");
        Enseigne.Get("Code enseigne");
        Enseigne.TestField("Code groupe");

        if Enseigne."Concept obligatoire" then
            TestField("Code concept");

        EnteteVente.Init();
        if pTypeDoc = pTypeDoc::Commande then
            EnteteVente."Document Type" := EnteteVente."Document Type"::Order
        else
            EnteteVente."Document Type" := EnteteVente."Document Type"::Quote;
        EnteteVente."No." := '';

        EnteteVente.ASS := (Selection = 2);

        EnteteVente.Insert(true);

        EnteteVente."Document Date" := Today;
        EnteteVente."Code enseigne" := "Code enseigne";
        EnteteVente."Code groupe" := Enseigne."Code groupe";

        EnteteVente.Validate("Sell-to Customer No.", "No. client");

        if ClientDonneurOrdre."Payment Terms Code" <> '' then
            EnteteVente.Validate("Payment Terms Code", ClientDonneurOrdre."Payment Terms Code")
        else
            EnteteVente.Validate("Payment Terms Code", Enseigne."Code conditions paiement");

        EnteteVente.Validate("Code enseigne", "Code enseigne");
        EnteteVente.Validate("Code chantier", Code);

        if ShipToAddr.Get("No. client", Code) then
            EnteteVente.Validate("Ship-to Code", Code);

        EnteteVente."Devis Stock" := false;

        EnteteVente.Modify();

        case pTypeDoc of
            pTypeDoc::Devis:
                PAGE.Run(41, EnteteVente);
            pTypeDoc::Commande:
                PAGE.Run(42, EnteteVente);
        end;
    end;

    procedure MAJAnalytiqueChantier()
    var
        DimensionValue: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.Get();
        if GLSetup."Shortcut Dimension 3 Code" = '' then //Axe CHANTIER
            exit;

        if not DimensionValue.Get(GLSetup."Shortcut Dimension 3 Code", Code) then begin
            DimensionValue.Init();
            DimensionValue."Dimension Code" := GLSetup."Shortcut Dimension 3 Code";
            DimensionValue.Code := Code;
            DimensionValue.Insert();
        end;
        DimensionValue.Name := "Description chantier";
        DimensionValue.Modify();
    end;

    procedure FactureNonSoldee(): Boolean
    var
        EcrClient: Record "Cust. Ledger Entry";
    begin
        EcrClient.SetCurrentKey("Code chantier", "Document Type", Open, "Due Date");
        EcrClient.SetRange("Code chantier", Code);
        EcrClient.SetRange("Document Type", EcrClient."Document Type"::Invoice);
        EcrClient.SetRange(Open, true);
        exit(not EcrClient.IsEmpty());
    end;

    procedure FactureImpayee(): Boolean
    var
        EcrClient: Record "Cust. Ledger Entry";
    begin
        EcrClient.SetCurrentKey("Code chantier", "Document Type", Open, "Due Date");
        EcrClient.SetRange("Code chantier", Code);
        EcrClient.SetRange("Document Type", EcrClient."Document Type"::Invoice);
        EcrClient.SetRange(Open, true);
        EcrClient.SetRange("Due Date", 0D, CalcDate('<-1D>', Today));
        exit(not EcrClient.IsEmpty());
    end;

    procedure MAJStatutChantier()
    begin
        if "Chantier archive" then
            exit;

        CalcFields("Montant factures vente", "Nombre devis", "Montant reste a livrer", "Montant sur cdes achats", "Montant recu non facture", "Montant livre non facture", "Cout total Achats+Stock");

        if ("Montant reste a livrer" <> 0) or ("Montant sur cdes achats" <> 0) or ("Montant recu non facture" <> 0) or ("Montant livre non facture" <> 0) or FactureNonSoldee() then
            StatutChantier := StatutChantier::"En cours"
        else
            if ("Montant factures vente" <> 0) or ("Cout total Achats+Stock" <> 0) then
                StatutChantier := StatutChantier::"Terminé"
            else
                if "Nombre devis" <> 0 then
                    StatutChantier := StatutChantier::Devis
                else
                    StatutChantier := StatutChantier::"Création";

        if StatutChantier <> "Statut chantier" then begin
            "Statut chantier" := StatutChantier;
            Modify();
        end;
    end;

    procedure MAJAdrDest()
    begin
        if not ShipToAddr.Get("No. client", Code) then begin
            ShipToAddr.Init();
            ShipToAddr."Customer No." := "No. client";
            ShipToAddr.Code := COPYSTR(Code, 1, 10);
            ShipToAddr.Insert();
        end;
        ShipToAddr.Name := "Nom chantier";
        ShipToAddr."Name 2" := "Nom chantier 2";
        ShipToAddr.Address := "Adresse chantier";
        ShipToAddr."Address 2" := "Adresse chantier 2";
        ShipToAddr."Post Code" := "Code postal chantier";
        ShipToAddr.City := "Ville chantier";
        ShipToAddr."Country/Region Code" := "Code pays chantier";
        ShipToAddr.Contact := "Contact chantier";
        ShipToAddr."Phone No." := "No. téléphone chantier";
        ShipToAddr."Shipment Method Code" := "Shipment Method Code";
        ShipToAddr."Shipping Agent Code" := "Shipping Agent Code";
        ShipToAddr."E-Mail" := "E-Mail chantier";
        ShipToAddr."Location Code" := "Location Code";
        //KAN.FHA 26/10/2020 DEBUT
        ShipToAddr."Adresse de facturation" := "Adr. facture=Adr. livraison";
        //KAN.FHA 26/10/2020 FIN
        ShipToAddr.Modify();
    end;

    procedure RecreerChantier()
    var
        Enseigne: Record Enseigne;
        PageCreationChantier: Page 50003;
        PrefixeNouveauChantier: Code[5];

    begin
        Clear(PageCreationChantier);
        PageCreationChantier.DefChantierOrigine(Code);
        if PageCreationChantier.RUNMODAL() = ACTION::OK then begin
            PageCreationChantier.RecupPrefixe(PrefixeNouveauChantier);
            Enseigne.Get("Code enseigne");
            Enseigne.CreerNouveauChantier(Code, PrefixeNouveauChantier);
        end;
    end;

    procedure Cloturer()
    var
        CloturerQst: Label 'Voulez-vous clôturer ce chantier ?';
        CloturerMalgreEncoursQst: Label 'Ce chantier est lié à des éléments d''en cours :\- Factures non soldées ou\- commandes d''achats non réceptionnées/réceptionnées non facturées ou\- commandes de ventes non livrées/livrées non facturées.\Voulez-vous malgré tout clôturer ce chantier ? Cela empêchera toute saisie de nouveau document d''achat ou de vente mais pas la validation des documents en cours. Cela signifie par contre que vous clôturez un chantier dont la rentabilité va encore évoluer. Confirmez-vous ?';
        ChantierClotureMsg: Label 'Le chantier a été clôturé.';
    begin
        if not Confirm(CloturerQst) then
            exit;

        CalcFields("Montant reste a livrer", "Montant sur cdes achats", "Montant recu non facture", "Montant livre non facture");
        if ("Montant reste a livrer" <> 0) or ("Montant sur cdes achats" <> 0) or ("Montant recu non facture" <> 0) or ("Montant livre non facture" <> 0) or FactureNonSoldee() then
            if not Confirm(CloturerMalgreEncoursQst) then
                exit;

        Cloture := true;
        Modify();
        Message(ChantierClotureMsg);
    end;

    procedure Rouvrir()
    var
        RouvrirQst: Label 'Voulez-vous rouvrir ce chantier ?';
        ChantierRouvertMsg: Label 'Le chantier a été rouvert.';
    begin
        if not Confirm(RouvrirQst) then
            exit;

        Cloture := false;
        Modify();
        Message(ChantierRouvertMsg);
    end;

    procedure AfficherEtiquettePalette()
    var
        EtiquettePalette: Record "Etiquettes palettes";
    begin
        EtiquettePalette.Reset();
        EtiquettePalette.SetRange("Code utilisateur", UserId);
        EtiquettePalette.DeleteAll();

        EtiquettePalette.Init();
        EtiquettePalette."Code utilisateur" := COPYSTR(UserId, 1, 50);
        //EtiquettePalette."No. container" := '';
        EtiquettePalette."Code enseigne" := "Code enseigne";
        EtiquettePalette."Code chantier" := Code;
        //EtiquettePalette."No. packing list" := '';
        EtiquettePalette."Nom chantier" := "Nom chantier";
        EtiquettePalette."Nom chantier 2" := "Nom chantier 2";
        EtiquettePalette."Adresse chantier" := "Adresse chantier";
        EtiquettePalette."Adresse chantier 2" := "Adresse chantier 2";
        EtiquettePalette."Code postal chantier" := "Code postal chantier";
        EtiquettePalette."Ville chantier" := "Ville chantier";
        EtiquettePalette."Code pays chantier" := "Code pays chantier";
        EtiquettePalette."Contact/No. tel chantier" := CopyStr("Contact chantier" + '-' + "No. téléphone chantier", 1, 80);
        EtiquettePalette.Insert();
        EtiquettePalette.FilterGroup(2);
        EtiquettePalette.SetRange("Code utilisateur", UserId);
        EtiquettePalette.FilterGroup(0);
        PAGE.Run(PAGE::"Etiquettes palettes", EtiquettePalette);
    end;
}

