table 50051 "Dossier BE"
{
    Caption = 'Dossier BE';
    DataClassification = ToBeClassified;
    Description = 'Un dossier regroupe plusieurs fiches BE. Quand une commande de vente contient 3 articles DIV à dessiner, on a un dossier regroupant 3 fiches BE.';
    LookupPageId = "Liste dossiers BE";

    fields
    {
        field(10; "No."; Code[20])
        {
            Caption = 'N°';
            trigger OnValidate()
            var
                ParamVente: Record "Sales & Receivables Setup";
                NoSeriesMgt: Codeunit NoSeriesManagement;
            begin
                if "No." <> xRec."No." then begin
                    ParamVente.Get();
                    NoSeriesMgt.TestManual(ParamVente."No. fiche BE");
                    "No. Series" := '';
                end;
            end;
        }
        field(11; "Type document"; Option)
        {
            Caption = 'Type document';
            OptionMembers = " ",Devis,Commande;
            OptionCaption = ' ,Devis,Commande';
        }
        field(20; "No. document"; Code[20])
        {
            Caption = 'N° document';
        }
        field(22; "Commentaires"; Text[250])
        {
            Caption = 'Commentaires';
            DataClassification = ToBeClassified;
        }
        field(24; "Code chantier"; Code[20])
        {
            Caption = 'Code chantier';
            DataClassification = ToBeClassified;
        }
        field(25; "Nom chantier"; Text[250])
        {
            Caption = 'Nom chantier';
            DataClassification = ToBeClassified;
        }

        field(30; "Nom du prospect/client"; Text[100])
        {
            Caption = 'Nom du prospect/client';
        }
        field(40; "Code vendeur"; Code[20])
        {
            Caption = 'Code vendeur';
            TableRelation = "Salesperson/Purchaser";
        }
        field(50; "No. Series"; Code[20])
        {
            Caption = 'N° souche';
            TableRelation = "No. Series";
        }

        field(52; "Date demande"; Date)
        {
            Caption = 'Date demande';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(60; "Annule"; Boolean)
        {
            Caption = 'Annulée';
            DataClassification = ToBeClassified;
            Description = 'Le dossier avait été créé pour un devis/une commande mais plus aucun article de ce document ne nécessite de fiche BE.';
        }
        field(64; "Archive"; Boolean)
        {
            Caption = 'Archivé';
            DataClassification = ToBeClassified;
            Description = 'Lorsqu''un dossier ne contient que des fiches dont le statut est Terminé, Annulé ou BE fournisseur, il est archivé.';
        }
        field(70; "Date chargement"; Date)
        {
            Caption = 'Date de chargement';
            DataClassification = ToBeClassified;
        }
        field(80; "Date livraison demandée"; Date)
        {
            Caption = 'Date de livraison demandée';
            DataClassification = ToBeClassified;
        }

        field(90; "PJ sur serveur"; Boolean)
        {
            Caption = 'PJ sur serveur ';
        }
        
        
        field(105; "Alerte decalage date"; Boolean)
        {
            Caption = 'Alerte décalage date';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(106; "Detail alerte"; Text[250])
        {
            Caption = 'Détail alerte';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(107; "Alerte vue par BE"; Boolean)
        {
            Caption = 'Alerte vue par BE';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                ParamUtil: Record "User Setup";
                UtilNonAutoriseErr: Label 'Vous n''êtes pas autorisé à compléter ce champ.';
                SolderAlerteQst: label 'Ceci va supprimer l''alerte, confirmez-vous ?';
            begin
                if not ParamUtil.Get(UserId) then
                    ParamUtil.init();
                if not ParamUtil."Completer fiches BE" then
                    error(UtilNonAutoriseErr);

                if Rec."Alerte vue par BE" then begin
                    if not Confirm(SolderAlerteQst) then begin
                        "Alerte vue par BE" := false;
                        exit;
                    end;
                    Rec."Alerte decalage date" := false;
                    Rec."Detail alerte" := '';
                    Rec."Alerte vue par BE" := false;
                end

            end;
        }
        
        field(110; "Commentaires dossier BE"; Blob)
        {
            Caption = 'Commentaires dossier BE';
            trigger OnValidate()
            var
                ParamUtil: Record "User Setup";
                UtilNonAutoriseErr: Label 'Vous n''êtes pas autorisé à compléter ce champ.';
            begin
                if not ParamUtil.Get(UserId) then
                    ParamUtil.init();
                if not ParamUtil."Completer fiches BE" then
                    error(UtilNonAutoriseErr);

            end;
        }
        field(114; "Sem. debut traitement BE"; Integer)
        {
            Caption = 'Sem. début traitement BE';
            FieldClass = FlowField;
            CalcFormula = min("Ligne fiche BE"."Semaine debut traitement BE" where("No. dossier BE" = field("No."), "Semaine debut traitement BE" = filter(<> 0)));
        }
        field(116; "Sem. fin traitement BE"; Integer)
        {
            Caption = 'Sem. fin traitement BE';
            FieldClass = FlowField;
            CalcFormula = max("Ligne fiche BE"."Semaine debut traitement BE" where("No. dossier BE" = field("No."), "Semaine debut traitement BE" = filter(<> 0)));
        }

        field(120; "Nb fiches BE"; Integer)
        {
            Caption = 'Nb fiches BE';
            fieldclass = FlowField;
            CalcFormula = count("Ligne fiche BE" where("No. dossier BE" = field("No.")));
            Editable = false;
        }
        field(122; "Nb fiches BE actives"; Integer)
        {
            Caption = 'Nb fiches BE actives';
            fieldclass = FlowField;
            CalcFormula = count("Ligne fiche BE" where("No. dossier BE" = field("No."), "Statut ligne" = filter(" " | "En cours" | "En attente validation client")));
            Editable = false;
        }
        field(130; "Charge pour le BE (h)"; Decimal)
        {
            Caption = 'Charge pour le BE (h)';
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            fieldclass = FlowField;
            CalcFormula = sum("Ligne fiche BE"."Charge pour le BE (h)" where("No. dossier BE" = field("No.")));
            Editable = false;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(MyKey1; "Type document", "No. document")
        {

        }
        
        key(MyKey2; "Alerte decalage date")
        {

        }
        
        key(MyKey3; Archive)
        {

        }

        key(MyKey4; Archive, "Date chargement")
        {

        }

    }
    trigger OnInsert()
    var
        ParamVente: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        if "No." = '' then begin
            ParamVente.Get();
            ParamVente.TestField("No. fiche BE");
            NoSeriesMgt.InitSeries(ParamVente."No. fiche BE", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Date demande" := Today;
    end;

    trigger OnDelete()
    var
        LigneFicheBE: Record "Ligne fiche BE";
        SuppressionInterditeErr: Label 'Vous ne pouvez pas supprimer une fiche BE liée à un document de vente.';
    begin
        if "No. document" <> '' then
            error(SuppressionInterditeErr);

        ligneFicheBE.SetRange("No. dossier BE", Rec."No.");
        LigneFicheBE.Deleteall();

    end;

    procedure CalcAvancement(): Decimal
    begin
        Rec.CalcFields("Nb fiches BE", "Nb fiches BE actives");
        if Rec."Nb fiches BE" = 0 then
            exit(100)
        else
            exit(100 - round((Rec."Nb fiches BE actives") / Rec."Nb fiches BE" * 100, 1));
    end;

    procedure AfficherDocument()
    var
        EnteteVente: Record "Sales Header";
    begin
        if "No. document" = '' then
            exit;

        //EnteteVente.SetRange("No.", "No. document");

        case "Type document" of
            Rec."Type document"::Devis:
                begin
                    //EnteteVente.SetRange("Document Type", EnteteVente."Document Type"::Quote);
                    //if EnteteVente.Find('-') then
                    if EnteteVente.Get(EnteteVente."Document Type"::Quote, "No. document") then
                        Page.Run(Page::"Sales Quote", EnteteVente);
                end;
            Rec."Type document"::Commande:
                begin
                    //EnteteVente.SetRange(EnteteVente."Document Type", EnteteVente."Document Type"::Order);
                    //if EnteteVente.Find('-') then
                    if EnteteVente.Get(EnteteVente."Document Type"::Order, "No. document") then
                        Page.Run(Page::"Sales Order", EnteteVente);
                end;
            else
                exit;
        end;
    end;

    procedure LigneEnRetard() : Text
    var
        LigneFicheBE: Record "Ligne fiche BE";
    begin
        LigneFicheBE.SetRange("No. dossier BE",Rec."No.");
        LigneFicheBE.SetFilter("Statut ligne",'%1|%2|%3',LigneFicheBE."Statut ligne"::" ", LigneFicheBE."Statut ligne"::"En cours", LigneFicheBE."Statut ligne"::"En attente validation client");
        LigneFicheBE.SetFilter("Date limite reponse BE",'<%1',Today);
        if LigneFicheBE.IsEmpty then
            exit('')
        else
            exit('RETARD BE');
    end;
    procedure Desarchiver()
    var
        ConfirmQst: Label 'Souhaitez-vous désarchiver ce dossier ? Il réapparaitra dans la liste des dossiers BE (non archivés).';
    begin
        if not Rec.Archive then
            exit;

        if not confirm(ConfirmQst, true) then
            exit;

        Archive := false;
        Modify();
    end;

    procedure SetCommentairesDossierBE(NewCommentairesDossierBE: Text)
    var
        EnteteVente: Record "Sales Header";
        OutStream: OutStream;
    begin
        Clear("Commentaires dossier BE");
        "Commentaires dossier BE".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewCommentairesDossierBE);
        Modify();

        if Rec."No. document" <> '' then begin
            case "Type document" of
                Rec."Type document"::Devis:
                    EnteteVente.Get(EnteteVente."Document Type"::Quote, Rec."No. document");
                Rec."Type document"::Commande:
                    EnteteVente.Get(EnteteVente."Document Type"::Order, Rec."No. document");
                else
                    exit;
            end;
            clear(EnteteVente."Commentaires dossier BE");
            EnteteVente."Commentaires dossier BE".CreateOutStream(OutStream, TEXTENCODING::UTF8);
            OutStream.WriteText(NewCommentairesDossierBE);
            EnteteVente.Modify();
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

    procedure CreerPlanningBE(ModeAffichage: Integer); // 0 = Ecran ; 1 = Excel
    var
        DossierBE: Record "Dossier BE";
        LigneFicheBE: Record "Ligne fiche BE";
        Planning: Record TamponPlanningBE;
        PlanningLigneVide: Record TamponPlanningBE;
        Vendeur: Record "Salesperson/Purchaser";
        Semaines: Record date;

        DateFin: date;
        CodeDessinateur1: Code[20];
        CodeDessinateur2: Code[20];
        CodeDessinateur3: Code[20];
        CodeDessinateur4: Code[20];
        CodeDessinateur5: Code[20];

        SuffixeNomFichier: Text[15];
        NumSem: Code[5];
        NumSemLigneVide: Code[5];
        NumLigne: Integer;
        MonText: Text[10];
        AucunDessinateurErr: Label 'Aucun utilisateur n''a été paramétré comme Dessinateur';

    begin
        if ModeAffichage = 1 then begin
            SuffixeNomFichier := format(Date2DMY(today, 3));
            MonText := format(Date2DMY(today, 2));
            if StrLen(MonText) < 2 then
                MonText := '0' + MonText;
            SuffixeNomFichier := SuffixeNomFichier + MonText;
            MonText := format(Date2DMY(today, 1));
            if StrLen(MonText) < 2 then
                MonText := '0' + MonText;
            SuffixeNomFichier := SuffixeNomFichier + MonText;

            MonText := delchr(Format(time), '=', ':');
            SuffixeNomFichier := SuffixeNomFichier + '_' + MonText;
        end;

        Vendeur.SetRange(Dessinateur, true);
        if Vendeur.IsEmpty then
            Error(AucunDessinateurErr);

        CodeDessinateur1 := '';
        CodeDessinateur2 := '';
        CodeDessinateur3 := '';
        CodeDessinateur4 := '';
        CodeDessinateur5 := '';

        Vendeur.FindSet();
        repeat
            if CodeDessinateur1 = '' then
                CodeDessinateur1 := Vendeur.Code
            else
                if CodeDessinateur2 = '' then
                    CodeDessinateur2 := Vendeur.Code
                else
                    if CodeDessinateur3 = '' then
                        CodeDessinateur3 := Vendeur.Code
                    else
                        if CodeDessinateur4 = '' then
                            CodeDessinateur4 := Vendeur.Code
                        else
                            if CodeDessinateur5 = '' then
                                CodeDessinateur5 := Vendeur.Code
        until (Vendeur.Next() = 0) or (CodeDessinateur5 <> '');


        LigneFicheBE.Reset();
        LigneFicheBE.SetCurrentKey("Date debut traitement BE", Dessinateurs);
        LigneFicheBE.SetFilter("Date debut traitement BE", '<>%1', 0D);
        LigneFicheBE.SetFilter(Dessinateurs, '<>%1', '');
        LigneFicheBE.SetRange("Statut ligne", LigneFicheBE."Statut ligne"::" ", LigneFicheBE."Statut ligne"::"En cours");
        Planning.DeleteAll();
        NumSem := '';

        if LigneFicheBE.FindSet(false) then begin
            //Creation de la ligne de titres    Rémi            Giovanni            Georges par exemple
            Planning.Init();
            Planning."No. semaine" := '';
            Planning."No. ligne" := 1;
            Planning."No. document D1" := CodeDessinateur1; //Ruse pour ne pas avoir de colonne "Dessinateur", on l'inscrit sur la 1ere ligne
            Planning."No. document D2" := CodeDessinateur2;
            Planning."No. document D3" := CodeDessinateur3;
            Planning."No. document D4" := CodeDessinateur4;
            Planning."No. document D5" := CodeDessinateur5;
            NumLigne := 2;
            Planning.Insert();

            DateFin := CalcDate('<+1Y>', Today);
            Semaines.SetRange("Period Type", Semaines."Period Type"::Week);
            Semaines.Setrange("Period Start", today, DateFin);

            //Remplissage de la table tampon
            repeat
                LigneFicheBE.CalcFields("Nom chantier");
                DossierBE.Get(LigneFicheBE."No. dossier BE");

                //Boucle au cas où on aurait indiqué une plage de semaines sur la fiche BE (exemple : 50..51|2 veut dire semaines 50 et 51 de cette année et semaine 2 de l'annee prochaine)
                Semaines.SetFilter("Period No.", LigneFicheBE."Periode planification");
                if Semaines.FindSet() then
                    repeat
                        //On cherche si on a deja une ligne de planning pour cette semaine avec le code dessinateur correspondant vide
                        //NumSem := FormaterNumeroSemaine(LigneFicheBE."Semaine traitement BE");
                        NumSem := FormaterNumeroSemaine(Semaines."Period No.");
                        NumSemLigneVide := NumSem + '.';

                        Vendeur.SetFilter(Code, LigneFicheBE.Dessinateurs);
                        if Vendeur.FindSet(false) then
                            repeat
                                Planning.Reset();
                                Planning.SetRange("No. semaine", NumSem);
                                case Vendeur.Code of
                                    CodeDessinateur1:
                                        Planning.SetRange("Code dessinateur 1", '');
                                    CodeDessinateur2:
                                        Planning.SetRange("Code dessinateur 2", '');
                                    CodeDessinateur3:
                                        Planning.SetRange("Code dessinateur 3", '');
                                    CodeDessinateur4:
                                        Planning.SetRange("Code dessinateur 4", '');
                                    CodeDessinateur5:
                                        Planning.SetRange("Code dessinateur 5", '');
                                end;

                                if not Planning.FindSet(true) then begin
                                    Planning.Init();
                                    Planning."No. ligne" := NumLigne;
                                    Planning."No. semaine" := NumSem;
                                    NumLigne := NumLigne + 1;
                                    Planning.Insert();

                                    //NumSem := NumSem + '.';
                                    PlanningLigneVide.Setrange("No. semaine", NumSemLigneVide);
                                    if not PlanningLigneVide.FindFirst() then begin
                                        PlanningLigneVide.init();
                                        PlanningLigneVide."No. ligne" := NumLigne;
                                        PlanningLigneVide."No. semaine" := NumSemLigneVide;
                                        NumLigne := NumLigne + 1;

                                        PlanningLigneVide."Description de la demande D1" := PadStr(PlanningLigneVide."Description de la demande D1", MaxStrLen(PlanningLigneVide."Description de la demande D1"), '_');
                                        PlanningLigneVide."Description de la demande D2" := PadStr(PlanningLigneVide."Description de la demande D2", MaxStrLen(PlanningLigneVide."Description de la demande D2"), '_');
                                        PlanningLigneVide."Description de la demande D3" := PadStr(PlanningLigneVide."Description de la demande D3", MaxStrLen(PlanningLigneVide."Description de la demande D3"), '_');

                                        if Planning."Code dessinateur 4" <> '' then
                                            PlanningLigneVide."Description de la demande D4" := PadStr(PlanningLigneVide."Description de la demande D4", MaxStrLen(PlanningLigneVide."Description de la demande D4"), '_');

                                        if Planning."Code dessinateur 5" <> '' then
                                            PlanningLigneVide."Description de la demande D5" := PadStr(PlanningLigneVide."Description de la demande D5", MaxStrLen(PlanningLigneVide."Description de la demande D5"), '_');

                                        PlanningLigneVide.Insert();
                                    end;
                                end;

                                //On complete les champs correspondant au dessinateur de la fiche BE
                                case Vendeur.Code of
                                    CodeDessinateur1:
                                        begin
                                            Planning."Code dessinateur 1" := Vendeur.Code;
                                            Planning."No. document D1" := DossierBE."No. document";
                                            if LigneFicheBE."Nom chantier" <> '' then
                                                Planning."Nom chantier D1" := LigneFicheBE."Nom chantier"
                                            else
                                                Planning."Nom chantier D1" := DossierBE.Commentaires;

                                            Planning."Description de la demande D1" := LigneFicheBE."Description de la demande";
                                            if DossierBE."PJ sur serveur" then
                                                Planning."PJ D1 ?" := 'Oui';
                                            if LigneFicheBE."Date limite reponse BE" <> 0D then
                                                Planning."DLC D1" := format(LigneFicheBE."Date limite reponse BE");
                                            Planning."Statut ligne D1" := Format(LigneFicheBE."Statut ligne");
                                            Planning.Modify();
                                        end;
                                    CodeDessinateur2:
                                        begin
                                            Planning."Code dessinateur 2" := Vendeur.code;
                                            Planning."No. document D2" := DossierBE."No. document";
                                            if LigneFicheBE."Nom chantier" <> '' then
                                                Planning."Nom chantier D2" := LigneFicheBE."Nom chantier"
                                            else
                                                Planning."Nom chantier D2" := DossierBE.Commentaires;
                                            Planning."Description de la demande D2" := LigneFicheBE."Description de la demande";
                                            if DossierBE."PJ sur serveur" then
                                                Planning."PJ D2 ?" := 'Oui';
                                            if LigneFicheBE."Date limite reponse BE" <> 0D then
                                                Planning."DLC D2" := format(LigneFicheBE."Date limite reponse BE");
                                            Planning."Statut ligne D2" := Format(LigneFicheBE."Statut ligne");
                                            Planning.Modify();
                                        end;
                                    CodeDessinateur3:
                                        begin
                                            Planning."Code dessinateur 3" := Vendeur.Code;
                                            Planning."No. document D3" := DossierBE."No. document";
                                            if LigneFicheBE."Nom chantier" <> '' then
                                                Planning."Nom chantier D3" := LigneFicheBE."Nom chantier"
                                            else
                                                Planning."Nom chantier D3" := DossierBE.Commentaires;

                                            Planning."Description de la demande D3" := LigneFicheBE."Description de la demande";
                                            if DossierBE."PJ sur serveur" then
                                                Planning."PJ D3 ?" := 'Oui';
                                            if LigneFicheBE."Date limite reponse BE" <> 0D then
                                                Planning."DLC D3" := format(LigneFicheBE."Date limite reponse BE");
                                            Planning."Statut ligne D3" := Format(LigneFicheBE."Statut ligne");
                                            Planning.Modify();
                                        end;
                                    CodeDessinateur4:
                                        begin
                                            Planning."Code dessinateur 4" := Vendeur.Code;
                                            Planning."No. document D4" := DossierBE."No. document";
                                            if LigneFicheBE."Nom chantier" <> '' then
                                                Planning."Nom chantier D4" := LigneFicheBE."Nom chantier"
                                            else
                                                Planning."Nom chantier D4" := DossierBE.Commentaires;

                                            Planning."Description de la demande D4" := LigneFicheBE."Description de la demande";
                                            if DossierBE."PJ sur serveur" then
                                                Planning."PJ D4 ?" := 'Oui';
                                            if LigneFicheBE."Date limite reponse BE" <> 0D then
                                                Planning."DLC D4" := format(LigneFicheBE."Date limite reponse BE");
                                            Planning."Statut ligne D4" := Format(LigneFicheBE."Statut ligne");
                                            Planning.Modify();
                                        end;
                                    CodeDessinateur5:
                                        begin
                                            Planning."Code dessinateur 5" := Vendeur.Code;
                                            Planning."No. document D5" := DossierBE."No. document";
                                            if LigneFicheBE."Nom chantier" <> '' then
                                                Planning."Nom chantier D5" := LigneFicheBE."Nom chantier"
                                            else
                                                Planning."Nom chantier D5" := DossierBE.Commentaires;

                                            Planning."Description de la demande D5" := LigneFicheBE."Description de la demande";
                                            if DossierBE."PJ sur serveur" then
                                                Planning."PJ D5 ?" := 'Oui';
                                            if LigneFicheBE."Date limite reponse BE" <> 0D then
                                                Planning."DLC D5" := format(LigneFicheBE."Date limite reponse BE");
                                            Planning."Statut ligne D5" := Format(LigneFicheBE."Statut ligne");
                                            Planning.Modify();
                                        end;
                                end;
                            until Vendeur.Next() = 0;
                    until Semaines.Next() = 0;
            until LigneFicheBE.Next() = 0;
            Commit();

            if ModeAffichage = 0 then
                Page.Run(Page::"Planning BE")
            else
                Report.Run(Report::"Planning BE"); //Layout = Excel

        end;

    end;

    procedure FormaterNumeroSemaine(pNumSem: Integer): Code[3]
    var
        txt: Text[2];
    begin
        txt := Format(pNumSem);
        If StrLen(txt) = 1 then
            txt := '0' + txt;
        exit('S' + txt);
    end;

    procedure AjouterLigneExcel(var pTempExcelBuffer: record "Excel Buffer"; pPlanning: Record TamponPlanningBE)
    begin
        pTempExcelBuffer.NewRow();
        pTempExcelBuffer.AddColumn(pPlanning."No. semaine", false, '', false, false, false, '', pTempExcelBuffer."Cell Type"::Text);
        pTempExcelBuffer.AddColumn(pPlanning."No. document D1", false, '', false, false, false, '', pTempExcelBuffer."Cell Type"::Text);
        pTempExcelBuffer.AddColumn(pPlanning."Nom chantier D1", false, '', false, false, false, '', pTempExcelBuffer."Cell Type"::Text);
        pTempExcelBuffer.AddColumn(pPlanning."Description de la demande D1", false, '', false, false, false, '', pTempExcelBuffer."Cell Type"::Text);
        pTempExcelBuffer.AddColumn(pPlanning."PJ D1 ?", false, '', false, false, false, '', pTempExcelBuffer."Cell Type"::Text);
        pTempExcelBuffer.AddColumn(pPlanning."DLC D1", false, '', false, false, false, '', pTempExcelBuffer."Cell Type"::Text);
        pTempExcelBuffer.AddColumn(pPlanning."No. document D2", false, '', false, false, false, '', pTempExcelBuffer."Cell Type"::Text);
        pTempExcelBuffer.AddColumn(pPlanning."Nom chantier D2", false, '', false, false, false, '', pTempExcelBuffer."Cell Type"::Text);
        pTempExcelBuffer.AddColumn(pPlanning."Description de la demande D2", false, '', false, false, false, '', pTempExcelBuffer."Cell Type"::Text);
        pTempExcelBuffer.AddColumn(pPlanning."PJ D2 ?", false, '', false, false, false, '', pTempExcelBuffer."Cell Type"::Text);
        pTempExcelBuffer.AddColumn(pPlanning."DLC D2", false, '', false, false, false, '', pTempExcelBuffer."Cell Type"::Text);
        pTempExcelBuffer.AddColumn(pPlanning."No. document D3", false, '', false, false, false, '', pTempExcelBuffer."Cell Type"::Text);
        pTempExcelBuffer.AddColumn(pPlanning."Nom chantier D3", false, '', false, false, false, '', pTempExcelBuffer."Cell Type"::Text);
        pTempExcelBuffer.AddColumn(pPlanning."Description de la demande D3", false, '', false, false, false, '', pTempExcelBuffer."Cell Type"::Text);
        pTempExcelBuffer.AddColumn(pPlanning."PJ D3 ?", false, '', false, false, false, '', pTempExcelBuffer."Cell Type"::Text);
        pTempExcelBuffer.AddColumn(pPlanning."DLC D3", false, '', false, false, false, '', pTempExcelBuffer."Cell Type"::Text);
        pTempExcelBuffer.AddColumn(pPlanning."No. document D4", false, '', false, false, false, '', pTempExcelBuffer."Cell Type"::Text);
        pTempExcelBuffer.AddColumn(pPlanning."Nom chantier D4", false, '', false, false, false, '', pTempExcelBuffer."Cell Type"::Text);
        pTempExcelBuffer.AddColumn(pPlanning."Description de la demande D4", false, '', false, false, false, '', pTempExcelBuffer."Cell Type"::Text);
        pTempExcelBuffer.AddColumn(pPlanning."PJ D4 ?", false, '', false, false, false, '', pTempExcelBuffer."Cell Type"::Text);
        pTempExcelBuffer.AddColumn(pPlanning."DLC D4", false, '', false, false, false, '', pTempExcelBuffer."Cell Type"::Text);
        pTempExcelBuffer.AddColumn(pPlanning."No. document D5", false, '', false, false, false, '', pTempExcelBuffer."Cell Type"::Text);
        pTempExcelBuffer.AddColumn(pPlanning."Nom chantier D5", false, '', false, false, false, '', pTempExcelBuffer."Cell Type"::Text);
        pTempExcelBuffer.AddColumn(pPlanning."Description de la demande D5", false, '', false, false, false, '', pTempExcelBuffer."Cell Type"::Text);
        pTempExcelBuffer.AddColumn(pPlanning."PJ D5 ?", false, '', false, false, false, '', pTempExcelBuffer."Cell Type"::Text);
        pTempExcelBuffer.AddColumn(pPlanning."DLC D5", false, '', false, false, false, '', pTempExcelBuffer."Cell Type"::Text);

    end;
}
