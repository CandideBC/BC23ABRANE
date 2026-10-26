table 50073 "Entete OCR vente"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'N°';
            Description = 'Identifiant du document';
        }
        field(5; "Date OCRisation"; Date)
        {
        }
        field(10; "Date document"; Date)
        {
            Caption = 'Date document';
        }
        field(11; "No. document client"; Code[35])
        {
            Caption = 'N° document client';
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

                //"No. contact societe" := Client.GetContactNo;
            end;
        }
        field(13; "Nom donneur d'ordre"; Text[100])
        {
            CalcFormula = Lookup (Customer.Name WHERE ("No." = FIELD ("No. donneur ordre")));
            Caption = 'Nom donneur d''ordre';
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; "No. contact societe"; Code[20])
        {
            Caption = 'N° contact société';
            TableRelation = Contact."No." WHERE (Type = CONST (Company));

            trigger OnValidate()
            begin
                UpdateSellToCust("No. contact societe");
            end;
        }
        field(20; "No. contact personne"; Code[20])
        {
            Caption = 'N° contact personne';
            Description = 'TESTS KANOPI';
            TableRelation = Contact."No." WHERE (Type = CONST (Person),
                                                 "Company No." = FIELD ("No. contact societe"));
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
        field(23; "Nom contact personne"; Text[100])
        {
            CalcFormula = Lookup (Contact.Name WHERE ("No." = FIELD ("No. contact personne")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50; "Montant HT NAV (hors port)"; Decimal)
        {
            CalcFormula = Sum ("Ligne OCR vente"."Montant ligne HT (OCR)" WHERE ("No. document OCR" = FIELD ("No.")));
            Caption = 'Montant HT NAV (hors port)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60; "Montant HT OCR"; Decimal)
        {
            Caption = 'Montant HT OCR';
        }
        field(70; "Montant port HT OCR"; Decimal)
        {
            Caption = 'Montant port HT OCR';
        }
        field(80; "Montant TVA OCR"; Decimal)
        {
            Caption = 'Montant TVA OCR';
        }
        field(90; "Total TTC OCR"; Decimal)
        {
            Caption = 'Total TTC OCR';
        }
        field(95; "URL document"; Text[250])
        {
        }
        field(109; "Type document NAV"; Option)
        {
            Caption = 'Type document NAV';
            OptionMembers = Devis,Commande;
        }
        field(110; "No. document NAV"; Code[20])
        {
            Caption = 'N° document NAV';
            TableRelation = IF ("Type document NAV" = CONST (Devis)) "Sales Header"."No." WHERE ("Document Type" = CONST (Quote))
            ELSE
            IF ("Type document NAV" = CONST (Commande)) "Sales Header"."No." WHERE ("Document Type" = CONST (Order));
        }
        field(115; "Email expediteur"; Text[80])
        {
            Caption = 'Email expéditeur';
            Description = 'Email de celui qui a envoyé le document.';
        }
        field(117; "No. TVA Societe OCR"; Text[20])
        {
            Caption = 'N° TVA Société OCR';
        }
        field(118; "No. SIRET Societe OCR"; Text[14])
        {
            Caption = 'N° SIRET Société OCR';
        }
        field(119; "GUID Societe"; Text[38])
        {
            Caption = 'GUID Société';
        }
        field(120; "Nom client OCR"; Text[50])
        {
            Caption = 'Nom client OCR';
        }
        field(122; "Nom client 2 OCR"; Text[50])
        {
            Caption = 'Nom client 2 OCR';
        }
        field(130; "Adresse client OCR"; Text[50])
        {
            Caption = 'Adresse client OCR';
        }
        field(132; "Adresse client 2 OCR"; Text[50])
        {
            Caption = 'Adresse client 2 OCR';
        }
        field(140; "Code postal client OCR"; Code[20])
        {
            Caption = 'Code postal client OCR';
        }
        field(150; "Ville client OCR"; Text[30])
        {
            Caption = 'Ville client OCR';
        }
        field(160; "Code pays client OCR"; Code[10])
        {
            Caption = 'Code pays client OCR';
            TableRelation = "Country/Region";
            ValidateTableRelation = false;
        }
        field(165; "GUID Personne"; Text[38])
        {
            Caption = 'GUID Personne';
        }
        field(170; "GUID destinataire"; Text[38])
        {
            Caption = 'GUID destinataire';
        }
        field(200; "Nom destinataire OCR"; Text[50])
        {
            Caption = 'Nom destinataire OCR';
        }
        field(210; "Nom destinataire 2 OCR"; Text[50])
        {
            Caption = 'Nom destinataire 2 OCR';
        }
        field(220; "Adresse destinataire OCR"; Text[50])
        {
            Caption = 'Adresse destinataire OCR';
        }
        field(230; "Adresse destinataire 2 OCR"; Text[50])
        {
            Caption = 'Adresse destinataire 2 OCR';
        }
        field(240; "Code postal destinataire OCR"; Code[20])
        {
            Caption = 'Code postal destinataire OCR';
        }
        field(250; "Ville destinataire OCR"; Text[30])
        {
            Caption = 'Ville destinataire OCR';
        }
        field(260; "Code pays destinataire OCR"; Code[10])
        {
            Caption = 'Code pays destinataire OCR';
            TableRelation = "Country/Region";
        }
        field(261; "Nom pour transporteur"; Text[32])
        {
            Caption = 'Nom pour transporteur';
        }
        field(262; "Adresse pour transporteur"; Text[32])
        {
            Caption = 'Adresse pour transporteur';
            Description = '1';
        }
        field(263; "Adresse 2 pour transporteur"; Text[32])
        {
            Caption = 'Adresse 2 pour transporteur';
        }
        field(264; "Code postal pour transporteur"; Code[35])
        {
            Caption = 'Code postal pour transporteur';
        }
        field(265; "Ville pour transporteur"; Text[27])
        {
            Caption = 'Ville pour transporteur';
        }
        field(267; "Nom contact pour transporteur"; Text[15])
        {
            DataClassification = ToBeClassified;
        }
        field(268; "Prenom contact pour transport."; Text[15])
        {
            Caption = 'Prénom contact pour transport.';
            DataClassification = ToBeClassified;
        }

        field(270; "No. telephone destinataire"; Text[30])
        {
            Caption = 'N° téléphone destinataire';
            ExtendedDatatype = PhoneNo;
        }
        field(280; "Instruction livraison 1"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(290; "Instruction livraison 2"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(300; "No. tel. prioritaire livraison"; Text[30])
        {
            Caption = 'N° téléphone prioritaire livraison';
            DataClassification = ToBeClassified;
        }
        field(310; "Autre No. telephone livraison"; Text[30])
        {
            Caption = 'Autre N° téléphone livraison';
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;
        }
        field(335; "EMail livraison"; Text[80])
        {
            Caption = 'EMail livraison';
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
        field(530; "Creer client No."; Code[20])
        {
            Caption = 'Créer client N°';
            Description = 'Lorsqu''on a affaire à une nouvelle société, l''utilisateur doit indiquer sous quel N° le contact doit être créé.';

            trigger OnValidate()
            begin
                TestField("No. donneur ordre", '');
                TestField("No. contact societe", '');

                if "Creer client No." <> '' then begin
                    "Nom nouveau client" := "Nom client OCR";
                    "Nom 2 nouveau client" := "Nom client 2 OCR";
                    "Adresse nouveau client" := "Adresse client OCR";
                    "Adresse 2 nouveau client" := "Adresse client 2 OCR";
                    "Code postal nouveau client" := "Code postal client OCR";
                    "Ville nouveau client" := "Ville client OCR";
                    "Code pays nouveau client" := "Code pays client OCR";
                    "Nom pour transporteur" := CopyStr("Nom nouveau client", 1, 32);
                    "Adresse pour transporteur" := CopyStr("Adresse nouveau client", 1, 32);
                    "Adresse 2 pour transporteur" := CopyStr("Adresse 2 nouveau client", 1, 32);
                    "Code postal pour transporteur" := "Code postal nouveau client";
                    "Ville pour transporteur" := CopyStr("Ville nouveau client", 1, 27);
                end else begin
                    "Nom nouveau client" := '';
                    "Nom 2 nouveau client" := '';
                    "Adresse nouveau client" := '';
                    "Adresse 2 nouveau client" := '';
                    "Code postal nouveau client" := '';
                    "Ville nouveau client" := '';
                    "Code pays nouveau client" := '';
                    "Nom pour transporteur" := '';
                    "Adresse pour transporteur" := '';
                    "Adresse 2 pour transporteur" := '';
                    "Code postal pour transporteur" := '';
                    "Ville pour transporteur" := '';
                end;
            end;
        }
        field(540; "Nom nouveau client"; Text[50])
        {
            Caption = 'Nom nouveau client';
        }
        field(550; "Nom 2 nouveau client"; Text[50])
        {
            Caption = 'Nom 2 nouveau client';
        }
        field(560; "Adresse nouveau client"; Text[50])
        {
            Caption = 'Adresse nouveau client';
        }
        field(570; "Adresse 2 nouveau client"; Text[50])
        {
            Caption = 'Adresse 2 nouveau client';
        }
        field(580; "Code postal nouveau client"; Code[20])
        {
            Caption = 'Code postal nouveau client';
        }
        field(590; "Ville nouveau client"; Text[30])
        {
            Caption = 'Ville nouveau client';
        }
        field(600; "Code pays nouveau client"; Code[10])
        {
            Caption = 'Code pays nouveau client';
            TableRelation = "Country/Region";
            ValidateTableRelation = false;
        }
        field(602; "Code etablissement nouv. clt"; Code[20])
        {
            Caption = 'Code établissement nouv. clt';
        }
        field(610; "Creer nouvelle adresse"; Boolean)
        {
            Caption = 'Créer nouvelle adresse';
            Description = 'Lorsqu''on a affaire à une nouvelle société, l''utilisateur doit indiquer sous quel N° le contact doit être créé.';

            trigger OnValidate()
            begin
                TestField("Code destinataire", '');

                if "Creer nouvelle adresse" then begin
                    "Nom nouveau destinataire" := "Nom destinataire OCR";
                    "Nom 2 nouveau destinataire" := "Nom destinataire 2 OCR";
                    "Adresse nouveau destinataire" := "Adresse destinataire OCR";
                    "Adresse 2 nouveau destinataire" := "Adresse destinataire 2 OCR";
                    "Code postal nouveau dest." := "Code postal destinataire OCR";
                    "Ville nouveau destinataire" := "Ville destinataire OCR";
                    "Code pays nouveau dest." := "Code pays destinataire OCR";
                    //KAN.FHA 04/12/2025 DEBUT
                    "E-mail nouveau destinataire" := "EMail livraison";
                    //KAN.FHA 04/12/2025 FIN
                    "Nom pour transporteur" := CopyStr("Nom nouveau destinataire", 1, 32);
                    "Adresse pour transporteur" := CopyStr("Adresse nouveau destinataire", 1, 32);
                    "Adresse 2 pour transporteur" := CopyStr("Adresse 2 nouveau destinataire", 1, 32);
                    "Code postal pour transporteur" := CopyStr("Code postal nouveau dest.", 1, 5);
                    "Ville pour transporteur" := CopyStr("Ville nouveau destinataire", 1, 27);
                end else begin
                    "Nom nouveau destinataire" := '';
                    "Nom 2 nouveau destinataire" := '';
                    "Adresse nouveau destinataire" := '';
                    "Adresse 2 nouveau destinataire" := '';
                    "Code postal nouveau dest." := '';
                    "Ville nouveau destinataire" := '';
                    "Code pays nouveau dest." := '';
                    "Nom pour transporteur" := CopyStr("Nom nouveau destinataire", 1, 32);
                    "Adresse pour transporteur" := CopyStr("Adresse nouveau destinataire", 1, 32);
                    "Adresse 2 pour transporteur" := CopyStr("Adresse 2 nouveau destinataire", 1, 32);
                    "Code postal pour transporteur" := CopyStr("Code postal nouveau dest.", 1, 5);
                    "Ville pour transporteur" := CopyStr("Ville nouveau destinataire", 1, 27);
                end;
            end;
        }
        field(620; "Nom nouveau destinataire"; Text[50])
        {
            Caption = 'Nom nouveau destinataire';

            trigger OnValidate()
            begin
                "Nom pour transporteur" := CopyStr("Nom nouveau destinataire", 1, 32);
            end;
        }
        field(630; "Nom 2 nouveau destinataire"; Text[50])
        {
            Caption = 'Nom 2 nouveau destinataire';
        }
        field(640; "Adresse nouveau destinataire"; Text[50])
        {
            Caption = 'Adresse nouveau destinataire';

            trigger OnValidate()
            begin
                "Adresse pour transporteur" := CopyStr("Adresse nouveau destinataire", 1, 32);
            end;
        }
        field(650; "Adresse 2 nouveau destinataire"; Text[50])
        {
            Caption = 'Adresse 2 nouveau destinataire';

            trigger OnValidate()
            begin
                "Adresse 2 pour transporteur" := CopyStr("Adresse 2 nouveau destinataire", 1, 32);
            end;
        }
        field(660; "Code postal nouveau dest."; Code[20])
        {
            Caption = 'Code postal nouveau dest.';

            trigger OnValidate()
            begin
                "Code postal pour transporteur" := CopyStr("Code postal nouveau dest.", 1, 5);
            end;
        }
        field(670; "Ville nouveau destinataire"; Text[30])
        {
            Caption = 'Ville nouveau destinataire';

            trigger OnValidate()
            begin
                "Ville pour transporteur" := CopyStr("Ville nouveau destinataire", 1, 27);
            end;
        }
        field(680; "Code pays nouveau dest."; Code[10])
        {
            Caption = 'Code pays nouveau dest.';
            TableRelation = "Country/Region";
            ValidateTableRelation = false;
        }
        field(690; "Instr.  livraison 1 nouv. dest"; Text[30])
        {
        }
        field(700; "Instr.  livraison 2 nouv. dest"; Text[30])
        {
        }
        field(710; "Tel. priorit. livr nouv. dest"; Text[30])
        {
            Caption = 'N° téléphone prioritaire livraison';
        }
        field(720; "E-mail nouveau destinataire"; Text[80])
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Document OCR traite")
        {
        }
        key(Key3; "Document OCR traite", "No. contact societe")
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
        LigneDocumentOCR.SetRange("No. document OCR", "No.");
        LigneDocumentOCR.DeleteAll();
    end;

    var
        //Client: Record Customer;

        Text037: Label 'Contact %1 %2 is not related to customer %3.';
        
        TransferExtendedText: Codeunit "Transfer Extended Text";
        //DemandeCompte: Record "Demande creation compte Web";
        CommandeExisteDejaQst: Label 'Le document %1 %2 fait mention du même N° de commande client, la commande a peut-être été envoyée deux fois par le client. Voulez-vous créer un devis malgré cela ?';
        InterrompuMsg: Label 'Opération abandonnée à la demande de l''utilisateur.';

   /*
    procedure MAJDonneesClientNAV()
    begin
        if "GUID Societe" <> '' then begin
            Contact.SetCurrentKey(GUID);
            Contact.SetRange(GUID, "GUID Societe");
            if Contact.FindFirst then
                if Contact.Type = Contact.Type::Company then
                    UpdateSellToCust(Contact."No.")
                else
                    UpdateSellToCust(Contact."Company No.")
        end;
    end;
    */

    /*
    procedure MAJDonneesDestinataireNAV()
    begin
        if "GUID destinataire" <> '' then begin
            AdrDest.SetCurrentKey("GUID Adresse");
            AdrDest.SetRange("GUID Adresse", "GUID destinataire");
            if AdrDest.FindFirst then
                Validate("Code destinataire", AdrDest.Code);
        end;
    end;
    */

    procedure UpdateSellToCust(ContactNo: Code[20])
    var
        ContBusinessRelation: Record "Contact Business Relation";
        Cont: Record Contact;
    begin
        if not Cont.Get(ContactNo) then
            exit;

        ContBusinessRelation.Reset();
        ContBusinessRelation.SetCurrentKey("Link to Table", "Contact No.");
        ContBusinessRelation.SetRange("Link to Table", ContBusinessRelation."Link to Table"::Customer);
        ContBusinessRelation.SetRange("Contact No.", Cont."Company No.");
        if ContBusinessRelation.FindFirst() then begin
            if ("No. donneur ordre" <> '') and
               ("No. donneur ordre" <> ContBusinessRelation."No.")
            then
                Error(Text037, Cont."No.", Cont.Name, "No. donneur ordre");
            if "No. donneur ordre" = '' then 
                Validate("No. donneur ordre", ContBusinessRelation."No.");
            
        end;
    end;

    procedure CreerClient()
    var
        Client: Record Customer;
        CreerClientQST: Label 'Voulez-vous créer le client %1 ?';
    begin
        if not Confirm(CreerClientQST, true, "Creer client No.") then
            Error(InterrompuMsg);

        TestField("No. donneur ordre", '');
        TestField("No. contact societe", '');
        TestField("Creer client No.");
        TestField("Code pays nouveau client");

        Client.Reset();
        Client.Init();
        Client."No." := "Creer client No.";
        Client.Insert(true);

        Client.Name := "Nom nouveau client";
        Client."Name 2" := "Nom 2 nouveau client";
        Client.Address := "Adresse nouveau client";
        Client."Address 2" := "Adresse 2 nouveau client";
        Client."Post Code" := "Code postal nouveau client";
        Client.City := "Ville nouveau client";
        Client.Validate("Country/Region Code", "Code pays nouveau client");  //Pour recuperer les groupes compta
        Client."Bill-to Customer No." := Client."No.";
        Client.Modify(true);
        //Client.UpdateShipToAddress1;
        Commit();
        Validate("No. donneur ordre", "Creer client No.");
        Validate("Code destinataire", '1');
    end;

    /*
    procedure CreerAdrDest()
    var
        AdrDest: Record "Ship-to Address";
        CodeDestinataire: Code[10];
        CodeAdr: Code[10];
    begin
        TestField("No. donneur ordre");
        TestField("Code destinataire", '');

        AdrDest.Reset;
        AdrDest.SetCurrentKey("Code adresse transporteurs");
        if AdrDest.FindLast then
            CodeAdr := IncStr(AdrDest."Code adresse transporteurs")
        else
            CodeAdr := 'A000001';

        AdrDest.Reset;
        AdrDest.Init;
        AdrDest."Customer No." := "No. donneur ordre";
        AdrDest.Code := CodeAdr;
        AdrDest."GUID Adresse" := CreateGuid;
        AdrDest."Code adresse transporteurs" := CodeAdr;
        if Client.Get("No. donneur ordre") then
            if ContactSociete.Get(Client.GetContactNo) then
                AdrDest."GUID Societe" := ContactSociete.GUID;
        AdrDest.Insert;

        AdrDest.Name := "Nom nouveau destinataire";
        AdrDest."Name 2" := "Nom 2 nouveau destinataire";
        AdrDest.Address := "Adresse nouveau destinataire";
        AdrDest."Address 2" := "Adresse 2 nouveau destinataire";
        AdrDest."Post Code" := "Code postal nouveau dest.";
        AdrDest.City := "Ville destinataire OCR";
        AdrDest."Country/Region Code" := "Code pays destinataire OCR";
        AdrDest."Phone No." := "No. telephone destinataire";
        //KAN.FHA 04/12/2025 DEBUT
        AdrDest."No. tel. prioritaire livraison" := "Tel. priorit. livr nouv. dest";
        AdrDest."Instruction livraison 1" := "Instr.  livraison 1 nouv. dest";
        AdrDest."Instruction livraison 2" := "Instr.  livraison 2 nouv. dest";
        AdrDest."E-Mail" := "E-mail nouveau destinataire";
        //KAN.FHA 04/12/2025 FIN
        //AdrDest."Autre No. telephone livraison" := "Autre No. telephone livraison";
        //AdrDest."E-Mail" := "EMail livraison";
        //AdrDest.Contact := COPYSTR("Nom personne livraison" + ' ' + "Prenom personne livraison",1,50);
        AdrDest."Nom pour transporteur" := "Nom pour transporteur";
        AdrDest."Adresse pour transporteur" := "Adresse pour transporteur";
        AdrDest."Adresse 2 pour transporteur" := "Adresse 2 pour transporteur";
        AdrDest."Code postal pour transporteur" := "Code postal pour transporteur";
        AdrDest."Ville pour transporteur" := "Ville pour transporteur";
        //AdrDest."Nom contact pour transporteur" := "Nom personne livraison";
        //AdrDest."Prenom contact pour transport." := "Prenom personne livraison";
        //AdrDest."Envoyer aux logiciels transpor" := true;
        AdrDest."Envoyer a CHRONOPOST" := true;
        AdrDest."Envoyer a FEDEX" := true;
        AdrDest."Envoyer a KUEHNE" := true;
        AdrDest."Envoyer a LAPOSTE" := true;
        AdrDest.Modify;
        Commit;
        Validate("Code destinataire", AdrDest.Code);

        Message(Text50000, "Code destinataire");
    end;
    */
    procedure CreerDocumentVente()
    var
        EnteteVente: Record "Sales Header";
        LigneVente: Record "Sales Line";
        LigneOCRVente: Record "Ligne OCR vente";
        GpeCptaMarche: Record "Gen. Business Posting Group";
        Client: Record Customer;
        AdrDest: Record "Ship-to Address";
        NouvelleAdrNonCreeeErr: Label 'Cette adresse n''est pas enregistrée dans les adresses du client. Veuillez vérifier l''adresse et la créer.';
        CommandeCreeMsg: Label 'Le document  N°%1 a été transformé en %2 %3.',Comment = '%1 = N° doc OCR ; %2 = Type document ; %3 = N° document';
    begin
        //Vérification que le document n'a pas été envoyé 2 fois
        EnteteVente.SetCurrentKey("Sell-to Customer No.", "External Document No.");
        EnteteVente.SetRange("Sell-to Customer No.", "No. donneur ordre");
        EnteteVente.SetRange("External Document No.", "No. document client");
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
        EnteteVente."Document Type" := EnteteVente."Document Type"::Quote;
        EnteteVente."No." := '';
        EnteteVente.Insert(true);
        //EnteteVente.VALIDATE("Sell-to Customer No.","No. donneur ordre");
        if ("No. contact personne" <> '') and ("No. contact personne" <> "No. contact societe") then
            EnteteVente.Validate("Sell-to Contact No.", "No. contact personne")
        else
            EnteteVente.Validate("Sell-to Contact No.", "No. contact societe");

        EnteteVente.Validate("Document Date", "Date document");
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
        EnteteVente."External Document No." := Format("No. document client");
        //EnteteVente."Origine OCR" := true;
        EnteteVente.Modify();
        "Type document NAV" := "Type document NAV"::Devis;
        "No. document NAV" := EnteteVente."No.";
        "Document OCR traite" := true;
        Modify();

        LigneOCRVente.Reset();
        LigneOCRVente.SetRange("No. document OCR", "No.");
        if LigneOCRVente.FindSet(false) then
            repeat
                LigneVente.Init();
                LigneVente."Document Type" := EnteteVente."Document Type";
                LigneVente."Document No." := EnteteVente."No.";
                LigneVente."Line No." := LigneOCRVente."No. ligne" * 300000;
                LigneVente.Validate(Type, LigneVente.Type::Item);
                LigneVente.Validate("No.", LigneOCRVente."No. article");
                LigneVente.Validate("Variant Code", LigneOCRVente."Code variante");
                LigneVente.Validate(Quantity, LigneOCRVente.Quantite);
                LigneVente.Validate("Unit of Measure Code", LigneOCRVente."Code unite");
                //LigneVente.VALIDATE("Line Discount %",LigneOCRVente."% remise ligne");
                LigneVente.Insert();
                LigneVente.Validate("Qty. to Assemble to Order");
                LigneVente.Modify();
                if TransferExtendedText.SalesCheckIfAnyExtText(LigneVente, true) then
                    TransferExtendedText.InsertSalesExtText(LigneVente);

            until LigneOCRVente.Next() = 0;


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

        Message(CommandeCreeMsg, "No.", Format(EnteteVente."Document Type"), EnteteVente."No.");
    end;
}

