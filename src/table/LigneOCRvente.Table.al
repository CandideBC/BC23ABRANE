table 50074 "Ligne OCR vente"
{

    fields
    {
        field(1; "No. document OCR"; Code[20])
        {
            Caption = 'N° document OCR';
            TableRelation = "Entete OCR vente";
            ValidateTableRelation = false;
        }
        field(2; "No. ligne"; Integer)
        {
            Caption = 'N° ligne';
        }
        field(11; "No. article"; Code[20])
        {
            Caption = 'No.';
            TableRelation = Item;
            ValidateTableRelation = false;
        }
        field(12; "Code variante"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE ("Item No." = FIELD ("No. article"));
            ValidateTableRelation = false;
        }
        field(13; "Designation article OCR"; Text[100])
        {
            Caption = 'Désignation article OCR';
        }
        field(15; Quantite; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            var
            begin
                Validate("% remise ligne");
            end;
        }
        field(17; "Code unite"; Code[10])
        {
            Caption = 'Code unité';
            TableRelation = "Item Unit of Measure".Code WHERE ("Item No." = FIELD ("No. article"));
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
        field(100; "Designation article NAV"; Text[100])
        {
            CalcFormula = Lookup (Item.Description WHERE ("No." = FIELD ("No. article")));
            Caption = 'Désignation article NAV';
            Editable = false;
            FieldClass = FlowField;
        }
        field(110; "Designation variante NAV"; Text[100])
        {
            CalcFormula = Lookup ("Item Variant".Description WHERE ("Item No." = FIELD ("No. article"),
                                                                   Code = FIELD ("Code variante")));
            Caption = 'Désignation variante NAV';
            Editable = false;
            FieldClass = FlowField;
        }
        field(130; "Alerte stock"; Boolean)
        {
            Caption = 'Alerte stock';
        }
        field(140; "Unite inconnue"; Boolean)
        {
            Caption = 'Unité inconnue';
        }
        field(150; "Article bloque"; Boolean)
        {
            BlankZero = true;
            CalcFormula = Lookup (Item.Blocked WHERE ("No." = FIELD ("No. article")));
            Caption = 'Article bloqué';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50000; "Date document OCR"; Date)
        {
            Caption = 'Date panier';
            Description = 'Champs d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50006; "No. document client"; Code[35])
        {
        }
        field(50010; "Email expediteur"; Text[80])
        {
            Caption = 'Email expediteur';
            Description = 'Email de celui qui a envoyé le document. Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50030; "GUID Destinataire"; Text[38])
        {
            Caption = 'Ship-to Code';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50040; "Montant HT OCR"; Decimal)
        {
            Caption = 'Montant HT OCR';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50041; "Montant port HT OCR"; Decimal)
        {
            Caption = 'Montant port HT OCR';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50044; "Montant TVA OCR"; Decimal)
        {
            Caption = 'Montant TVA OCR';
            Description = 'TVA (calculée sur les deux champs précédents). Champs d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50046; "Total TTC OCR"; Decimal)
        {
            Caption = 'Total TTC OCR';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50070; "Nom destinataire OCR"; Text[50])
        {
            Caption = 'Nom destinataire';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50080; "Nom destinataire 2 OCR"; Text[50])
        {
            Caption = 'Nom destinataire 2';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50090; "Adresse destinataire OCR"; Text[50])
        {
            Caption = 'Adresse destinataire';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50100; "Adresse destinataire 2 OCR"; Text[50])
        {
            Caption = 'Adresse destinataire 2';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50110; "Code postal destinataire OCR"; Code[20])
        {
            Caption = 'Code postal destinataire';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50120; "Ville destinataire OCR"; Text[30])
        {
            Caption = 'Ville destinataire';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50130; "Code pays destinataire OCR"; Code[10])
        {
            Caption = 'Code pays destinataire';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
            TableRelation = "Country/Region";
            ValidateTableRelation = false;
        }
        field(50140; "No. telephone destinataire OCR"; Text[30])
        {
            Caption = 'N° téléphone destinataire';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
            ExtendedDatatype = PhoneNo;
        }
        field(50210; "Commentaire valideur"; Text[250])
        {
            Caption = 'Commentaire valideur';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50220; "EMail livraison"; Text[80])
        {
            Caption = 'EMail livraison';
            Description = 'KAN.FHA 24/09/2025. Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50490; "GUID Societe"; Text[38])
        {
            Caption = 'GUID Société';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50491; "GUID Personne"; Text[38])
        {
            Caption = 'GUID Personne';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50492; "No. TVA Societe OCR"; Text[20])
        {
            Caption = 'N° TVA Société OCR';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50493; "No. SIRET Societe OCR"; Text[14])
        {
            Caption = 'N° SIRET Société OCR';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50500; "Nom client OCR"; Text[50])
        {
            Caption = 'Nom client OCR';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50510; "Nom client 2 OCR"; Text[50])
        {
            Caption = 'Nom client 2 OCR';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50520; "Adresse client OCR"; Text[50])
        {
            Caption = 'Adresse client OCR';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50530; "Adresse client 2 OCR"; Text[50])
        {
            Caption = 'Adresse client 2 OCR';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50540; "Code postal client OCR"; Code[20])
        {
            Caption = 'Code postal client OCR';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50550; "Ville client OCR"; Text[30])
        {
            Caption = 'Ville client OCR';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
        field(50560; "Code pays client OCR"; Code[10])
        {
            Caption = 'Code pays client OCR';
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
            TableRelation = "Country/Region";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50570; "URL document"; Text[250])
        {
            Description = 'Champ d''entete de panier présents ici car le WebService expose tous les champs d''entete et de lignes. A l''insertion dans cette table depuis le WS, NAV crée l''entête.';
        }
    }

    keys
    {
        key(Key1; "No. document OCR", "No. ligne")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //KAN.FHA 13/11/2025 DEBUT
        "Unite inconnue" := not (UniteArticle.Get("No. article", "Code unite"));
        //KAN.FHA 13/11/2025 FIN
        if not EnteteDocumentOCR.Get("No. document OCR") then begin
            //NumContactSociete := '';
            //NumContactPersonne := '';

            /*
            if "GUID Societe" <> '' then
                NumContactSociete := ChercherContact("GUID Societe");

            if "GUID Personne" <> '' then
                NumContactPersonne := ChercherContact("GUID Personne");
            */

            EnteteDocumentOCR.Init();
            EnteteDocumentOCR."No." := "No. document OCR";
            EnteteDocumentOCR."Date OCRisation" := Today;
            EnteteDocumentOCR."Date document" := "Date document OCR";
            EnteteDocumentOCR."No. document client" := "No. document client";
            EnteteDocumentOCR."URL document" := "URL document";

            /*
            if NumContactSociete <> '' then begin
                //EnteteDocumentOCR."No. contact societe" := NumContactSociete;
                Contact.Get(NumContactSociete);
                Contact.CalcFields("N° client");
                if Contact."N° client" <> '' then
                    EnteteDocumentOCR.Validate("No. donneur ordre", Contact."N° client");
            end;
            if NumContactPersonne <> '' then
                if Contact.Get(NumContactPersonne) then
                    EnteteDocumentOCR."No. contact personne" := NumContactPersonne;

            if EnteteDocumentOCR."No. contact personne" = '' then
                EnteteDocumentOCR."No. contact personne" := NumContactSociete;
            */

            EnteteDocumentOCR."Montant HT OCR" := "Montant HT OCR";
            EnteteDocumentOCR."Montant port HT OCR" := "Montant port HT OCR";
            EnteteDocumentOCR."Montant TVA OCR" := "Montant TVA OCR";
            EnteteDocumentOCR."Total TTC OCR" := "Total TTC OCR";
            EnteteDocumentOCR."Email expediteur" := "Email expediteur";
            //EnteteDocumentOCR."GUID Societe" := "GUID Societe";
            //EnteteDocumentOCR."GUID Personne" := "GUID Personne";
            EnteteDocumentOCR."No. TVA Societe OCR" := "No. TVA Societe OCR";
            EnteteDocumentOCR."No. SIRET Societe OCR" := "No. SIRET Societe OCR";
            EnteteDocumentOCR."Nom client OCR" := "Nom client OCR";
            EnteteDocumentOCR."Nom client 2 OCR" := "Nom client 2 OCR";
            EnteteDocumentOCR."Adresse client OCR" := "Adresse client OCR";
            EnteteDocumentOCR."Adresse client 2 OCR" := "Adresse client 2 OCR";
            EnteteDocumentOCR."Code postal client OCR" := "Code postal client OCR";
            EnteteDocumentOCR."Ville client OCR" := "Ville client OCR";
            EnteteDocumentOCR."Code pays client OCR" := "Code pays client OCR";
            EnteteDocumentOCR."GUID destinataire" := "GUID Destinataire";
            EnteteDocumentOCR."Nom destinataire OCR" := "Nom destinataire OCR";
            EnteteDocumentOCR."Nom destinataire 2 OCR" := "Nom destinataire 2 OCR";
            EnteteDocumentOCR."Adresse destinataire OCR" := "Adresse destinataire OCR";
            EnteteDocumentOCR."Adresse destinataire 2 OCR" := "Adresse destinataire 2 OCR";
            EnteteDocumentOCR."Code postal destinataire OCR" := "Code postal destinataire OCR";
            EnteteDocumentOCR."Ville destinataire OCR" := "Ville destinataire OCR";
            EnteteDocumentOCR."Code pays destinataire OCR" := "Code pays destinataire OCR";
            //IF "Attention nouvelle adresse" THEN BEGIN
            //  EnteteDocumentOCR."Nom pour transporteur" := COPYSTR("Nom destinataire",1,32);
            //  EnteteDocumentOCR."Adresse pour transporteur" := COPYSTR("Adresse destinataire",1,32);
            //  EnteteDocumentOCR."Adresse 2 pour transporteur" := COPYSTR("Adresse destinataire 2",1,32);
            //  EnteteDocumentOCR."Code postal pour transporteur" := "Code postal destinataire";
            //  EnteteDocumentOCR."Ville pour transporteur" := COPYSTR("Ville destinataire",1,27);
            //END ELSE
            /*
            if "GUID Destinataire" <> '' then begin
                AdrDest.SetCurrentKey("GUID Adresse");
                AdrDest.SetRange("GUID Adresse", "GUID Destinataire");
                if AdrDest.FindFirst then begin
                    EnteteDocumentOCR."Nom pour transporteur" := AdrDest."Nom pour transporteur";
                    EnteteDocumentOCR."Adresse pour transporteur" := AdrDest."Adresse pour transporteur";
                    EnteteDocumentOCR."Adresse 2 pour transporteur" := AdrDest."Adresse 2 pour transporteur";
                    EnteteDocumentOCR."Code postal pour transporteur" := AdrDest."Code postal pour transporteur";
                    EnteteDocumentOCR."Ville pour transporteur" := AdrDest."Ville pour transporteur";
                    //KAN.FHA 21/10/2026 DEBUT
                    EnteteDocumentOCR."Nom contact pour transporteur" := AdrDest."Nom contact pour transporteur";
                    EnteteDocumentOCR."Prenom contact pour transport." := AdrDest."Prenom contact pour transport.";
                    EnteteDocumentOCR."No. tel. prioritaire livraison" := AdrDest."No. tel. prioritaire livraison";
                    EnteteDocumentOCR."Autre No. telephone livraison" := AdrDest."Autre No. telephone livraison";
                    EnteteDocumentOCR."EMail livraison" := AdrDest."E-Mail";
                    EnteteDocumentOCR."Instruction livraison 1" := AdrDest."Instruction livraison 1";
                    EnteteDocumentOCR."Instruction livraison 2" := AdrDest."Instruction livraison 2";
                    //KAN.FHA 21/10/2026 FIN
                end;
            end;
            */
            EnteteDocumentOCR."No. telephone destinataire" := "No. telephone destinataire OCR";
            EnteteDocumentOCR."EMail livraison" := "EMail livraison";
            //EnteteDocumentOCR.MAJDonneesClientNAV;
            //EnteteDocumentOCR.MAJDonneesDestinataireNAV;
            EnteteDocumentOCR.Insert();
        end;
    end;

    var
        EnteteDocumentOCR: Record "Entete OCR vente";
        Item: Record Item;
        UniteArticle: Record "Item Unit of Measure";

    /*
    local procedure ChercherContact(pGUID: Text[38]): Code[20]
    begin
        Contact.SetCurrentKey(GUID);
        Contact.SetRange(GUID, pGUID);
        if Contact.FindFirst then
            exit(Contact."No.")
        else
            exit('');
    end;
    */
}

