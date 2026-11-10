table 50074 "Ligne OCR vente"
{

    fields
    {
        field(1; "ID document OCR"; Code[20])
        {
            Caption = 'ID document OCR';
        }
        field(2; "ID ligne document OCR"; Code[20])
        {
            Caption = 'ID ligne document OCR';
        }
        field(5; "No. commande client"; Code[20])
        {
            Caption = 'N° commande client';
        }

        field(6; "No. ligne commande client"; Code[10])
        {
            Caption = 'N° ligne commande client';
        }
        field(11; "Reference article client"; Code[20])
        {
            Caption = 'Reference article client';
        }

        field(13; "Designation article OCR"; Text[100])
        {
            Caption = 'Désignation article OCR';
        }
        field(14; "No. article BC"; Code[20])
        {
            Caption = 'N° article BC';
        }
        field(15; Quantite; Decimal)
        {
            Caption = 'Quantité';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            var
            begin
                Validate("% remise ligne");
            end;
        }
        field(17; "Unite"; Text[30])
        {
            Caption = 'Code unité';
            TableRelation = "Item Unit of Measure".Code where ("Item No." = field ("No. article BC"));
            ValidateTableRelation = false;
        }
        field(18; "Prix unitaire OCR"; Decimal)
        {
            Caption = 'Prix unitaire OCR';

            trigger OnValidate()
            begin
                Validate("% remise ligne");
            end;
        }
        field(20; "% remise ligne"; Decimal)
        {
            Caption = 'Line Discount %';
            DecimalPlaces = 0 : 5;
            Editable = true;
            MaxValue = 100;
            MinValue = 0;
        }
        field(50; "Montant ligne HT (OCR)"; Decimal)
        {
            Caption = 'Montant ligne HT';
        }
        field(100; "Designation article BC"; Text[100])
        {
            CalcFormula = lookup (Item.Description where ("No." = field ("No. article BC")));
            Caption = 'Désignation article NAV';
            Editable = false;
            FieldClass = FlowField;
        }

        field(130; "Alerte stock"; Boolean)
        {
            Caption = 'Alerte stock';
        }

        field(150; "Article bloque"; Boolean)
        {
            BlankZero = true;
            CalcFormula = lookup (Item.Blocked where ("No." = field ("No. article BC")));
            Caption = 'Article bloqué';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50000; "Date commande OCR"; Date)
        {
            Caption = 'Date commande OCR';
            Description = 'Champs d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50005; "Demandeur"; Text[250])
        {
            Caption = 'Demandeur';
            Description = 'Champs d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }

        field(50010; "Email facturation"; Text[80])
        {
            Caption = 'Email facturation';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }

        field(50040; "Montant HT OCR"; Decimal)
        {
            Caption = 'Montant HT OCR';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }

        field(50070; "Nom livraison OCR"; Text[100])
        {
            Caption = 'Nom livraison OCR';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50080; "Nom livraison 2 OCR"; Text[50])
        {
            Caption = 'Nom livraison 2';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50090; "Adresse livraison OCR"; Text[100])
        {
            Caption = 'Adresse livraison OCR';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50100; "Adresse livraison 2 OCR"; Text[50])
        {
            Caption = 'Adresse livraison 2 OCR';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50110; "CP livraison OCR"; Code[20])
        {
            Caption = 'Code postal livraison OCR';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50120; "Ville livraison OCR"; Text[30])
        {
            Caption = 'Ville livraison OCR';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50130; "Pays livraison OCR"; Code[10])
        {
            Caption = 'Pays livraison OCR';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50140; "No. telephone livraison OCR"; Text[30])
        {
            Caption = 'N° téléphone livraison OCR';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
            ExtendedDatatype = PhoneNo;
        }

        field(50150; Rayon; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50160; "Date livraison demandee"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50165; "Code chantier"; Code[20])
        {
            Caption = 'Code chantier';
            TableRelation = Chantier;
            ValidateTableRelation = false;
            DataClassification = ToBeClassified;
        }
        field(50500; "Nom facturation OCR"; Text[50])
        {
            Caption = 'Nom facturation OCR';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50510; "Nom facturation 2 OCR"; Text[50])
        {
            Caption = 'Nom facturation 2 OCR';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50520; "Adresse facturation OCR"; Text[50])
        {
            Caption = 'Adresse facturation OCR';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50530; "Adresse facturation 2 OCR"; Text[50])
        {
            Caption = 'Adresse facturation 2 OCR';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50540; "CP facturation OCR"; Code[20])
        {
            Caption = 'Code postal facturation OCR';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50550; "Ville facturation OCR"; Text[30])
        {
            Caption = 'Ville facturation OCR';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50560; "Pays facturation OCR"; Text[30])
        {
            Caption = 'Code pays client OCR';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
    }

    keys
    {
        key(Key1; "ID document OCR", "ID ligne document OCR")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        TestField("ID document OCR");
        TestField("ID ligne document OCR");
        if not EnteteDocumentOCR.Get("ID document OCR") then begin
            EnteteDocumentOCR.Init();
            EnteteDocumentOCR."ID document OCR" := "ID document OCR";
            EnteteDocumentOCR."Date OCRisation" := Today;
            EnteteDocumentOCR."Date commande" := "Date commande OCR";
            EnteteDocumentOCR.Demandeur := Demandeur;
            EnteteDocumentOCR."No. commande client" := "No. commande client";
            EnteteDocumentOCR."Montant HT OCR" := "Montant HT OCR";
            EnteteDocumentOCR."Email facturation" := "Email facturation";
            EnteteDocumentOCR."Nom facturation OCR" := "Nom facturation OCR";
            EnteteDocumentOCR."Nom facturation 2 OCR" := "Nom facturation 2 OCR";
            EnteteDocumentOCR."Adresse facturation OCR" := "Adresse facturation OCR";
            EnteteDocumentOCR."Adresse facturation 2 OCR" := "Adresse facturation 2 OCR";
            EnteteDocumentOCR."CP facturation OCR" := "CP facturation OCR";
            EnteteDocumentOCR."Ville facturation OCR" := "Ville facturation OCR";
            EnteteDocumentOCR."Pays facturation OCR" := "Pays facturation OCR";
            EnteteDocumentOCR."Nom livraison OCR" := "Nom livraison OCR";
            EnteteDocumentOCR."Nom livraison 2 OCR" := "Nom livraison 2 OCR";
            EnteteDocumentOCR."Adresse livraison OCR" := "Adresse livraison OCR";
            EnteteDocumentOCR."Adresse livraison 2 OCR" := "Adresse livraison 2 OCR";
            EnteteDocumentOCR."CP livraison OCR" := "CP livraison OCR";
            EnteteDocumentOCR."Ville livraison OCR" := "Ville livraison OCR";
            EnteteDocumentOCR."Code pays livraison OCR" := "Pays livraison OCR";
            EnteteDocumentOCR."No. telephone livraison" := "No. telephone livraison OCR";
            EnteteDocumentOCR."Code chantier" := "Code chantier";
            EnteteDocumentOCR.Rayon := Rayon;
            if not EnteteDocumentOCR.Insert() then //Pour éviter 2 POSTS où le 2e essaie de faire un insert qui plante car le premier n'a pas fini l'insert.
                EnteteDocumentOCR.Get("ID document OCR");
        end;
    end;

    var
        EnteteDocumentOCR: Record "Entete OCR vente";


}

