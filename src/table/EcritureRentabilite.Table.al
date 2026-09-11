table 50003 "Ecriture rentabilite"
{
    Caption = 'Ecriture rentabilité';
    DrillDownPageID = 50007;

    fields
    {
        field(1; "No. sequence"; Integer)
        {
            Caption = 'N° séquence';
        }
        field(3; "Type ecriture"; Option)
        {
            Caption = 'Type écriture';
            OptionMembers = CA,"Coût";
        }
        field(5; "Valide par"; Code[50])
        {
            Caption = 'Validé par';
        }
        field(10; "Code chantier"; Code[20])
        {
            Caption = 'Code chantier';
            TableRelation = Chantier;
        }
        field(12; "Code groupe"; Code[20])
        {
            TableRelation = "Groupe client";
        }
        field(14; "Code enseigne"; Code[20])
        {
            TableRelation = Enseigne;
        }
        field(16; "Code operation"; Code[20])
        {
            Caption = 'Code opération';
            TableRelation = Operations.Code where ("Code enseigne" = field ("Code enseigne"));
        }
        field(20; "Date comptabilisation"; Date)
        {
            Caption = 'Date comptabilisation';
        }
        field(30; "No. commande vente"; Code[20])
        {
            Caption = 'N° commande vente';
            TableRelation = "Sales Header"."No." where ("Document Type" = const (Order));
        }
        field(31; "No. ligne commande vente"; Integer)
        {
            Caption = 'N° ligne commande vente';
        }
        field(51; "Type document"; Option)
        {
            Caption = 'Type document';
            OptionCaption = 'Posted Invoice,Posted Cr. Memo,OD';
            OptionMembers = Facture,Avoir,OD;
        }
        field(52; "No. document"; Code[20])
        {
            Caption = 'N° document';
            TableRelation = if ("Type ecriture" = const ("Coût"),
                                "Type document" = const (Facture)) "Purch. Inv. Header"."No."
            else
            if ("Type ecriture" = const ("Coût"),
                                         "Type document" = const (Avoir)) "Purch. Cr. Memo Hdr."."No."
            else
            if ("Type ecriture" = const (CA),
                                                  "Type document" = const (Facture)) "Sales Invoice Header"."No."
            else
            if ("Type ecriture" = const (CA),
                                                           "Type document" = const (Avoir)) "Sales Cr.Memo Header"."No.";


        }
        field(53; "No. ligne document"; Integer)
        {
            Caption = 'N° ligne document';


        }
        field(55; "Nature vente"; Option)
        {
            OptionMembers = Mobilier,"Pose/Audit",Transport,"Bennes/Fenwick",SAV,"Indéfini";
        }
        field(56; "Type de cout"; Option)
        {
            Caption = 'Type de coût';
            OptionMembers = " ",Stock,Achat,Approche,Emballage;
        }
        field(57; "Date compta. vente"; Date)
        {
        }
        field(71; "No."; Code[20])
        {
            Caption = 'N°';
            Editable = false;
        }
        field(72; Description; Text[100])
        {
            Caption = 'Désignation';
            Editable = false;
        }
        field(110; Quantite; Decimal)
        {
            Caption = 'Quantité';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                "Montant total (DS)" := Round(Quantite * "Montant unitaire (DS)", 0.01);
            end;
        }
        field(180; "Montant unitaire (DS)"; Decimal)
        {
            Caption = 'Montant unitaire (DS)';

            trigger OnValidate()
            begin
                "Montant total (DS)" := Round(Quantite * "Montant unitaire (DS)", 0.01);
            end;
        }
        field(190; "Montant total (DS)"; Decimal)
        {
            Caption = 'Montant total (DS)';
            Editable = false;
        }
        field(290; "Nouveau cout unitaire (force)"; Decimal)
        {
            Caption = 'Nouveau coût unitaire (forcé)';
            Description = 'Champ qui peut être saisi sur la page 50056, seul champ forcable par l''utilisateur.';

            trigger OnValidate()
            begin
                TestField("Type de cout", "Type de cout"::Stock);
                if "Nouveau cout unitaire (force)" <> 0 then begin
                    Validate("Montant unitaire (DS)", "Nouveau cout unitaire (force)");
                    "Cout fige" := true;
                    "Cout fige par" := copystr(UserId,1,50);
                end else begin
                    "Cout fige" := false;
                    "Cout fige par" := '';
                    Rec.MettreAJourCoutPrisSurStock();
                end;
            end;
        }
        field(300; "Cout fige"; Boolean)
        {
            Caption = 'Coût figé';
            Description = 'L''utilisateur peut décider de figer un coût (Type de cout = Stock) pour éviter le recalcul par le systeme, notamment lorsque les écritures valeur sont foireuses sur certains articles.';
        }
        field(305; "Cout fige par"; Code[50])
        {
            Caption = 'Coût figé par';
        }
        field(310; "Cout total prevu (qte fact)"; Decimal)
        {
            CalcFormula = sum ("Value Entry"."Cost Amount (Expected)" where ("Document No." = field ("No. document"),
                                                                            "Document Line No." = field ("No. ligne document")));
            Caption = 'Coût total prévu (qté fact)';
            Description = 'Attention, c''est le cout pour la quantité facturée, pas pour la quantité prise sur stock';
            Editable = false;
            FieldClass = FlowField;
        }
        field(320; "Cout total reel (qte fact)"; Decimal)
        {
            CalcFormula = - sum ("Value Entry"."Cost Amount (Actual)" where ("Document No." = field ("No. document"),
                                                                           "Document Line No." = field ("No. ligne document")));
            Caption = 'Coût total réel (qté fact)';
            Description = 'Attention, c''est le cout pour la quantité facturée, pas pour la quantité prise sur stock';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No. sequence")
        {
            Clustered = true;
        }
        key(Key2; "Type ecriture", "Type document", "No. document", "No. ligne document")
        {
        }
        key(Key3; "Code chantier", "Type ecriture", "Date compta. vente")
        {
            SumIndexFields = "Montant total (DS)";
        }
        key(Key4; "Code enseigne", "Type ecriture", "Date compta. vente")
        {
            SumIndexFields = "Montant total (DS)";
        }
        key(Key5; "Code groupe", "Type ecriture", "Date compta. vente")
        {
            SumIndexFields = "Montant total (DS)";
        }
        key(Key6; "Code chantier", "Type ecriture", "Nature vente", "Type de cout", "Date compta. vente")
        {
            SumIndexFields = "Montant total (DS)";
        }
        key(Key7; "Code enseigne", "Type ecriture", "Nature vente", "Type de cout", "Date compta. vente")
        {
            SumIndexFields = "Montant total (DS)";
        }
        key(Key8; "Code groupe", "Type ecriture", "Nature vente", "Type de cout", "Date compta. vente")
        {
            SumIndexFields = "Montant total (DS)";
        }
        key(Key9; "Code groupe", "Code enseigne", "Code operation", "Code chantier", "Type ecriture", "Nature vente", "Date compta. vente")
        {
            SumIndexFields = "Montant total (DS)";
        }
        key(Key10; "Code chantier", "Type ecriture", "Type de cout")
        {
            SumIndexFields = "Montant total (DS)";
        }
        key(Key11; "Code enseigne", "Type ecriture", "Type de cout")
        {
            SumIndexFields = "Montant total (DS)";
        }
        key(Key12; "Code groupe", "Type ecriture", "Type de cout")
        {
            SumIndexFields = "Montant total (DS)";
        }
        key(Key13; "No. commande vente", "No. ligne commande vente", "Type ecriture", "Type de cout")
        {
        }
        key(Key14; "Type de cout", "Date comptabilisation")
        {
        }
        key(Key15; "Code chantier", "Type ecriture", "Nature vente", "Date comptabilisation")
        {
            SumIndexFields = "Montant total (DS)";
        }
        key(Key16; "Code chantier")
        {
        }
    }

    fieldgroups
    {
    }


    var

    procedure MettreAJourCoutPrisSurStock()
    var
        LigneFactureVente: Record "Sales Invoice Line";
        CoutLigneFacture: Decimal;
    begin
        //Cette fonction ne concerne que les écritures de rentabilité où on a pris sur stock.
        //Exemple : j'ai vendu 10 tables, 4 prises sur achats donc 6 prises sur stock.
        //Pendant 3 mois après que l'écriture de renta a été créée, on va mettre à jour le coût réel à partir des écritures valeurs de NAV qui sont régulierement ajustées.
        //Enfin, ABRANE peut décider de figer un coût lorsque la mécanique de NAV part en sucette sur certains articles.
        if "Type de cout" <> "Type de cout"::Stock then
            exit;

        if "Cout fige" then
            exit;

        if "Type document" <> "Type document"::Facture then //En attendant d'avoir reflechi au cas des avoirs
            exit;

        CalcFields("Cout total prevu (qte fact)", "Cout total reel (qte fact)");

        case "Type document" of
            "Type document"::Facture:
                begin
                    LigneFactureVente.Get("No. document", "No. ligne document");
                    if LigneFactureVente."Quantity (Base)" <> 0 then begin
                        if "Cout total reel (qte fact)" <> 0 then
                            CoutLigneFacture := Abs("Cout total reel (qte fact)")
                        else
                            CoutLigneFacture := Abs("Cout total prevu (qte fact)");

                        "Montant total (DS)" := Round(Quantite / LigneFactureVente."Quantity (Base)" * CoutLigneFacture, 0.01);
                        "Montant unitaire (DS)" := Round("Montant total (DS)" / Quantite, 0.00001);
                        Modify();
                    end;
                end;

        end;
    end;
}

