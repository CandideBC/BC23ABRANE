table 50073 "Entete OCR vente"
{

    fields
    {
        field(1; "ID document OCR"; Code[20])
        {
            Caption = 'ID document OCR';
            Description = 'Identifiant unique du document. Si la commande PO1234 est envoyée 2 fois par LMF, elle aura 2 ID Document OCR. C''est un numéro attribué par l''OCRisation.';
        }
        field(5; "Date OCRisation"; Date)
        {
        }
        field(8; "Demandeur"; Text[250])
        {
            Caption = 'Demandeur';
        }
        field(10; "Date commande"; Date)
        {
            Caption = 'Date document';
        }
        field(11; "No. commande client"; Code[35])
        {
            Caption = 'N° commande client';
        }
        field(12; "No. donneur ordre"; Code[20])
        {
            Caption = 'N° donneur d''ordre';
            TableRelation = Customer;

            trigger OnValidate()
            var
                Client: Record Customer;
            begin
                if not Client.Get("No. donneur ordre") then
                    Client.Init();

                "Nom client NAV" := Client.Name;
                "Nom client 2 NAV" := Client."Name 2";
                "Adresse client NAV" := Client.Address;
                "Adresse client 2 NAV" := Client."Address 2";
                "Code postal client NAV" := Client."Post Code";
                "Ville client NAV" := Client.City;
                "Code pays client NAV" := Client."Country/Region Code";
            end;
        }
        field(13; "Nom donneur d'ordre"; Text[100])
        {
            CalcFormula = lookup (Customer.Name where ("No." = field ("No. donneur ordre")));
            Caption = 'Nom donneur d''ordre';
            Editable = false;
            FieldClass = FlowField;
        }

        field(15; "Code chantier"; Code[20])
        {
            Caption = 'Code chantier';
            TableRelation = Chantier;
            ValidateTableRelation = false;
            DataClassification = ToBeClassified;
        }

        field(21; "Code destinataire"; Code[10])
        {
            Caption = 'Code destinataire';
            TableRelation = "Ship-to Address".Code WHERE ("Customer No." = FIELD ("No. donneur ordre"));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                AdrDest: Record "Ship-to Address";
            begin
                if not AdrDest.Get("No. donneur ordre", "Code destinataire") then
                    AdrDest.Init();

                "Nom destinataire NAV" := AdrDest.Name;
                "Nom destinataire 2 NAV" := AdrDest."Name 2";
                "Adresse destinataire NAV" := AdrDest.Address;
                "Adresse destinataire 2 NAV" := AdrDest."Address 2";
                "Code postal destinataire NAV" := AdrDest."Post Code";
                "Ville destinataire NAV" := AdrDest.City;
                "Code pays destinataire NAV" := AdrDest."Country/Region Code";
                /*
                "Nom pour transporteur" := AdrDest."Nom pour transporteur";
                "Adresse pour transporteur" := AdrDest."Adresse pour transporteur";
                "Adresse 2 pour transporteur" := AdrDest."Adresse 2 pour transporteur";
                "Code postal pour transporteur" := AdrDest."Code postal pour transporteur";
                "Ville pour transporteur" := AdrDest."Ville pour transporteur";
                */
            end;
        }



        field(60; "Montant HT OCR"; Decimal)
        {
            Caption = 'Montant HT OCR';
        }

        field(109; "Type document NAV"; Option)
        {
            Caption = 'Type document NAV';
            OptionMembers = Devis,Commande;
        }
        field(110; "No. document NAV"; Code[20])
        {
            Caption = 'N° document NAV';
            TableRelation = IF ("Type document NAV" = const (Devis)) "Sales Header"."No." where ("Document Type" = const (Quote))
            else
            if ("Type document NAV" = const (Commande)) "Sales Header"."No." where ("Document Type" = const (Order));
        }

        field(120; "Nom facturation OCR"; Text[100])
        {
            Caption = 'Nom client OCR';
        }
        field(122; "Nom facturation 2 OCR"; Text[50])
        {
            Caption = 'Nom facturation 2 OCR';
        }
        field(130; "Adresse facturation OCR"; Text[100])
        {
            Caption = 'Adresse facturation OCR';
        }
        field(132; "Adresse facturation 2 OCR"; Text[50])
        {
            Caption = 'Adresse facturation 2 OCR';
        }
        field(140; "CP facturation OCR"; Code[20])
        {
            Caption = 'CP facturation client OCR';
        }
        field(150; "Ville facturation OCR"; Text[30])
        {
            Caption = 'Ville facturation OCR';
        }
        field(160; "Pays facturation OCR"; Text[30])
        {
            Caption = 'Pays facturation OCR';
        }
        field(165; "Email facturation"; Text[80])
        {
            Caption = 'Email facturation';
            ExtendedDatatype = EMail;
        }

        field(200; "Nom livraison OCR"; Text[100])
        {
            Caption = 'Nom livraison OCR';
        }
        field(210; "Nom livraison 2 OCR"; Text[50])
        {
            Caption = 'Nom livraison 2 OCR';
        }
        field(220; "Adresse livraison OCR"; Text[50])
        {
            Caption = 'Adresse livraison OCR';
        }
        field(230; "Adresse livraison 2 OCR"; Text[50])
        {
            Caption = 'Adresse livraison 2 OCR';
        }
        field(240; "CP livraison OCR"; Code[20])
        {
            Caption = 'Code postal livraison OCR';
        }
        field(250; "Ville livraison OCR"; Text[30])
        {
            Caption = 'Ville livraison OCR';
        }
        field(260; "Code pays livraison OCR"; Code[10])
        {
            Caption = 'Code pays livraison OCR';
            TableRelation = "Country/Region";
        }

        field(270; "No. telephone livraison"; Text[30])
        {
            Caption = 'N° téléphone livraison';
            ExtendedDatatype = PhoneNo;
        }
        field(275; Rayon; Text[30])
        {
            DataClassification = ToBeClassified;
        }

        field(340; "Commentaire valideur"; Text[250])
        {
            Caption = 'Commentaire valideur';
        }
        field(350; "Document OCR traite"; Boolean)
        {
            Caption = 'Document OCR traité';
        }
        field(400; "Nom client NAV"; Text[100])
        {
            Caption = 'Nom client NAV';
            Description = 'Champ que je complète sur l''entête du document OCR à partir des infos fournies sur la ligne écrite par le WebService pour pouvoir comparer entre valeurs OCRisés et valeurs connues dans NAV';
        }
        field(402; "Nom client 2 NAV"; Text[50])
        {
            Caption = 'Nom client 2 NAV';
            Description = 'Champ que je complète sur l''entête du document OCR à partir des infos fournies sur la ligne écrite par le WebService pour pouvoir comparer entre valeurs OCRisés et valeurs connues dans NAV';
        }
        field(410; "Adresse client NAV"; Text[100])
        {
            Caption = 'Adresse client NAV';
            Description = 'Champ que je complète sur l''entête du document OCR à partir des infos fournies sur la ligne écrite par le WebService pour pouvoir comparer entre valeurs OCRisés et valeurs connues dans NAV';
        }
        field(412; "Adresse client 2 NAV"; Text[50])
        {
            Caption = 'Adresse client 2 NAV';
            Description = 'Champ que je complète sur l''entête du document OCR à partir des infos fournies sur la ligne écrite par le WebService pour pouvoir comparer entre valeurs OCRisés et valeurs connues dans NAV';
        }
        field(420; "Code postal client NAV"; Code[20])
        {
            Caption = 'Code postal client NAV';
            Description = 'Champ que je complète sur l''entête du document OCR à partir des infos fournies sur la ligne écrite par le WebService pour pouvoir comparer entre valeurs OCRisés et valeurs connues dans NAV';
        }
        field(430; "Ville client NAV"; Text[30])
        {
            Caption = 'Ville client NAV';
            Description = 'Champ que je complète sur l''entête du document OCR à partir des infos fournies sur la ligne écrite par le WebService pour pouvoir comparer entre valeurs OCRisés et valeurs connues dans NAV';
        }
        field(440; "Code pays client NAV"; Code[10])
        {
            Caption = 'Code pays client NAV';
            Description = 'Champ que je complète sur l''entête du document OCR à partir des infos fournies sur la ligne écrite par le WebService pour pouvoir comparer entre valeurs OCRisés et valeurs connues dans NAV';
            TableRelation = "Country/Region";
            ValidateTableRelation = false;
        }
        field(460; "Nom destinataire NAV"; Text[100])
        {
            Caption = 'Nom destinataire NAV';
            Description = 'Champ que je complète sur l''entête du document OCR à partir des infos fournies sur la ligne écrite par le WebService pour pouvoir comparer entre valeurs OCRisés et valeurs connues dans NAV';
        }
        field(470; "Nom destinataire 2 NAV"; Text[50])
        {
            Caption = 'Nom destinataire 2 NAV';
            Description = 'Champ que je complète sur l''entête du document OCR à partir des infos fournies sur la ligne écrite par le WebService pour pouvoir comparer entre valeurs OCRisés et valeurs connues dans NAV';
        }
        field(480; "Adresse destinataire NAV"; Text[100])
        {
            Caption = 'Adresse destinataire NAV';
            Description = 'Champ que je complète sur l''entête du document OCR à partir des infos fournies sur la ligne écrite par le WebService pour pouvoir comparer entre valeurs OCRisés et valeurs connues dans NAV';
        }
        field(490; "Adresse destinataire 2 NAV"; Text[50])
        {
            Caption = 'Adresse destinataire 2 NAV';
            Description = 'Champ que je complète sur l''entête du document OCR à partir des infos fournies sur la ligne écrite par le WebService pour pouvoir comparer entre valeurs OCRisés et valeurs connues dans NAV';
        }
        field(500; "Code postal destinataire NAV"; Code[20])
        {
            Caption = 'Code postal destinataire NAV';
            Description = 'Champ que je complète sur l''entête du document OCR à partir des infos fournies sur la ligne écrite par le WebService pour pouvoir comparer entre valeurs OCRisés et valeurs connues dans NAV';
        }
        field(510; "Ville destinataire NAV"; Text[30])
        {
            Caption = 'Ville destinataire NAV';
            Description = 'Champ que je complète sur l''entête du document OCR à partir des infos fournies sur la ligne écrite par le WebService pour pouvoir comparer entre valeurs OCRisés et valeurs connues dans NAV';
        }
        field(520; "Code pays destinataire NAV"; Code[10])
        {
            Caption = 'Code pays destinataire NAV';
            Description = 'Champ que je complète sur l''entête du document OCR à partir des infos fournies sur la ligne écrite par le WebService pour pouvoir comparer entre valeurs OCRisés et valeurs connues dans NAV';
            TableRelation = "Country/Region";
        }


    }

    keys
    {
        key(Key1; "ID document OCR")
        {
            Clustered = true;
        }
        key(Key2; "Document OCR traite")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        LigneDocumentOCR: Record "Ligne OCR vente";
    begin
        LigneDocumentOCR.Reset();
        LigneDocumentOCR.SetRange("ID document OCR", "ID document OCR");
        LigneDocumentOCR.DeleteAll();
    end;

    var
        //Client: Record Customer;

        TransferExtendedText: Codeunit "Transfer Extended Text";
        
        
        //DemandeCompte: Record "Demande creation compte Web";
        CommandeExisteDejaQst: Label 'Le document %1 %2 fait mention du même N° de commande client, la commande a peut-être été envoyée deux fois par le client. Voulez-vous créer un devis malgré cela ?';
        InterrompuMsg: Label 'Opération abandonnée à la demande de l''utilisateur.';


    procedure CreerCommandeVente()
    var
        EnteteVente: Record "Sales Header";
        LigneVente: Record "Sales Line";
        LigneOCRVente: Record "Ligne OCR vente";
        GpeCptaMarche: Record "Gen. Business Posting Group";
        Client: Record Customer;
        AdrDest: Record "Ship-to Address";
        NumLigne: Integer;
        NouvelleAdrNonCreeeErr: Label 'Cette adresse n''est pas enregistrée dans les adresses du client. Veuillez vérifier l''adresse et la créer.';
        CommandeCreeMsg: Label 'Le document N°%1 a été transformé en %2 %3.',Comment = '%1 = N° doc OCR ; %2 = Type document ; %3 = N° document';
    begin
        //Vérification que le document n'a pas été envoyé 2 fois
        EnteteVente.SetCurrentKey("Sell-to Customer No.", "External Document No.");
        EnteteVente.SetRange("Sell-to Customer No.", "No. donneur ordre");
        EnteteVente.SetRange("External Document No.", "No. commande client");
        if EnteteVente.FindFirst() then
            if not Confirm(CommandeExisteDejaQst, false, EnteteVente."Document Type", EnteteVente."No.") then begin
                Message(InterrompuMsg);
                exit;
            end;

        TestField("Code destinataire");
        TestField("Document OCR traite", false);

        if not AdrDest.Get("No. donneur ordre", "Code destinataire") then
            Error(NouvelleAdrNonCreeeErr);

        Client.Get("No. donneur ordre");

        GpeCptaMarche.Get(Client."Gen. Bus. Posting Group");
        //GpeCptaMarche.TestField("Compte port ventes");

        EnteteVente.Reset();
        EnteteVente.Init();
        EnteteVente."Document Type" := EnteteVente."Document Type"::Order;
        EnteteVente."No." := '';
        EnteteVente.Insert(true);
        //EnteteVente.VALIDATE("Sell-to Customer No.","No. donneur ordre");

        EnteteVente.Validate("Document Date", "Date commande");
        EnteteVente.Validate("Ship-to Code", "Code destinataire");
        /*
        EnteteVente."Ship-to Name" := "Nom destinataire OCR";
        EnteteVente."Ship-to Name 2" := "Nom destinataire 2 OCR";
        EnteteVente."Ship-to Address" := "Adresse destinataire OCR";
        EnteteVente."Ship-to Address 2" := "Adresse destinataire 2 OCR";
        EnteteVente."Ship-to Post Code" := "Code postal destinataire OCR";
        EnteteVente."Ship-to City" := "Ville destinataire OCR";
        EnteteVente."Ship-to Country/Region Code" := "Code pays destinataire OCR";
        */
        EnteteVente."External Document No." := Format("No. commande client");
        //EnteteVente."Origine OCR" := true;
        EnteteVente.Modify();
        "Type document NAV" := "Type document NAV"::Devis;
        "No. document NAV" := EnteteVente."No.";
        "Document OCR traite" := true;
        Modify();

        LigneOCRVente.Reset();
        LigneOCRVente.SetRange("ID document OCR", "ID document OCR");
        if LigneOCRVente.FindSet(false) then begin
            NumLigne := 10000;
            repeat
                LigneVente.Init();
                LigneVente."Document Type" := EnteteVente."Document Type";
                LigneVente."Document No." := EnteteVente."No.";
                LigneVente."Line No." := NumLigne;
                LigneVente.Validate(Type, LigneVente.Type::Item);
                //A REVOIR LigneVente.Validate("No.", LigneOCRVente."No. article");
                //LigneVente.Validate("Variant Code", LigneOCRVente."Code variante");
                LigneVente.Validate(Quantity, LigneOCRVente.Quantite);
                //LigneVente.Validate("Unit of Measure Code", LigneOCRVente."Code unite");
                //LigneVente.VALIDATE("Line Discount %",LigneOCRVente."% remise ligne");
                LigneVente.Insert();
                NumLigne := NumLigne + 10000;
                LigneVente.Validate("Qty. to Assemble to Order");
                LigneVente.Modify();
                if TransferExtendedText.SalesCheckIfAnyExtText(LigneVente, true) then
                    TransferExtendedText.InsertSalesExtText(LigneVente);

            until LigneOCRVente.Next() = 0;
        end;


        /*
        if "Montant port HT OCR" <> 0 then begin
            LigneVente.Init();
            LigneVente."Document Type" := EnteteVente."Document Type";
            LigneVente."Document No." := EnteteVente."No.";
            LigneVente."Line No." := (LigneOCRVente."No. ligne" * 300000) + 300000;
            LigneVente.Validate(Type, LigneVente.Type::"G/L Account");
            LigneVente.Validate("No.", GpeCptaMarche."Compte port ventes");
            LigneVente.Validate(Quantity, 1);
            LigneVente.Validate("Unit Price", "Montant port HT OCR");
            LigneVente.Insert();
        end;
        */

        Message(CommandeCreeMsg, "No. commande client", Format(EnteteVente."Document Type"), EnteteVente."No.");
    end;
}

