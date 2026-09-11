table 50052 "Ligne fiche BE"
{
    Caption = 'Ligne fiche BE';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No. dossier BE"; Code[20])
        {
            Caption = 'N° dossier BE';
            TableRelation = "Dossier BE";
        }
        field(10; "No. ligne"; Integer)
        {
            Caption = 'N° ligne';
        }
        field(11; "Type document"; Option)
        {
            Caption = 'Type document';
            OptionMembers = " ",Devis,Commande;
            OptionCaption = ' ,Devis,Commande';
            FieldClass = FlowField;
            CalcFormula = lookup("Dossier BE"."Type document" where("No." = field("No. dossier BE")));
            Editable = false;
        }
        field(12; "No. document"; Code[20])
        {
            Caption = 'N° document';
            FieldClass = FlowField;
            CalcFormula = lookup("Dossier BE"."No. document" where("No." = field("No. dossier BE")));
            Editable = false;
        }

        field(17; "Nom chantier"; Text[250])
        {
            Caption = 'Nom du chantier';
            FieldClass = FlowField;
            CalcFormula = lookup("Dossier BE"."Nom chantier" where("No." = field("No. dossier BE")));
            Editable = false;
        }
        field(20; "Date demande"; Date)
        {
            Caption = 'Date demande';
            Editable = false;
        }

        field(25; "No. fournisseur"; Code[20])
        {
            Caption = 'N° fournisseur';
            TableRelation = Vendor;
        }
        field(26; "Nom fournisseur"; Text[100])
        {
            Caption = 'Nom fournisseur';
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor.Name where ("No."= field("No. fournisseur")));
            Editable = false;
        }
        field(30; "Reference"; Code[10])
        {
            Caption = 'Référence';
        }
        field(40; "Description de la demande"; Text[100])
        {
            Caption = 'Description de la demande';
        }

        field(80; "Statut ligne"; Option)
        {
            Caption = 'Statut ligne';
            OptionMembers = " ","En cours",Standby,Annnulé,Terminé,"BE fournisseur","Pas de fiche","En attente validation client";
            OptionCaption = ' ,En cours,Standby,Annulé,Terminé,BE Fournisseur,Pas de fiche,En attente validation client';
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
        field(82; "Date limite reponse BE"; Date)
        {
            Caption = 'Date limite réponse BE';
            trigger OnValidate()
            var
                DossierBE: Record "Dossier BE";
                SaisieNonAutoriseeErr: Label 'Vous ne pouvez pas modifier la date limite de réponse du BE lorsque le dossier est lié à un document de vente.';
            begin
                if CurrFieldNo = rec.FieldNo("Date limite reponse BE") then begin
                    DossierBE.Get(Rec."No. dossier BE");
                    if DossierBE."No. document" <> '' then
                        Error(SaisieNonAutoriseeErr);
                end;
                if "Date limite reponse BE" <> 0D then
                    "Semaine limite reponse BE" := Date2DWY("Date limite reponse BE", 2);
            end;
        }
        field(83; "Semaine limite reponse BE"; Integer)
        {
            Caption = 'Semaine limite réponse BE';
            Editable = false;
        }
        field(89; "Periode planification"; Text[30])
        {
            Caption = 'Période planification';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Temps: Record Date;
                ParamUtil: Record "User Setup";
                UtilNonAutoriseErr: Label 'Vous n''êtes pas autorisé à compléter ce champ.';
                DateFin: date;
            begin

                if not ParamUtil.Get(UserId) then
                    ParamUtil.init();
                if not ParamUtil."Completer fiches BE" then
                    error(UtilNonAutoriseErr);

                DateFin := Calcdate('<+1Y>', today);
                Temps.SetRange("Period Type", Temps."Period Type"::week);
                Temps.Setrange("Period Start", today, DateFin);
                Temps.SetFilter("Period No.", "Periode planification");
                if Temps.Findfirst() then begin
                    Rec."Semaine debut traitement BE" := Temps."Period No.";
                    Rec."Date debut traitement BE" := Temps."Period Start";
                end;
            end;
        }

        field(90; "Semaine debut traitement BE"; Integer)
        {
            Caption = 'Semaine début traitement BE';
            BlankZero = true;
            Editable = false;
        }
        field(91; "Date debut traitement BE"; Date)
        {
            Caption = 'Date début traitement BE';
            Editable = false;
        }
        field(93; "Charge pour le BE (h)"; Decimal)
        {
            Caption = 'Charge pour le BE (h)';
            BlankZero = true;
            DecimalPlaces = 0 : 2;
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
        field(95; "Nb dessinateurs"; Integer)
        {
            Caption = 'Nb dessinateurs';
            FieldClass = FlowField;
            CalcFormula = count("Dessinateurs fiche BE" where("No. dossier BE" = field("No. dossier BE"), "No. ligne" = field("No. ligne"), Affecte = const(true)));
            Editable = false;
        }

        field(100; "Dessinateurs"; Text[250])
        {
            Caption = 'Dessinateurs';
            Editable = false;
        }
        field(102; "Commentaire fiche BE"; Text[250])
        {
            Caption = 'Commentaire fiche BE';
            DataClassification = ToBeClassified;
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

        field(104; "No. article B.E."; Code[20])
        {
            Caption = 'N° article B.E.';
            DataClassification = ToBeClassified;
        }

        field(110; "Alerte decalage date"; Boolean)
        {
            Caption = 'Alerte décalage date';
            FieldClass = FlowField;
            CalcFormula = lookup("Dossier BE"."Alerte decalage date" where("No." = field("No. dossier BE")));
            Editable = false;
        }
        field(111; "Detail alerte"; Text[250])
        {
            Caption = 'Détail alerte';
            FieldClass = FlowField;
            CalcFormula = lookup("Dossier BE"."Detail alerte" where("No." = field("No. dossier BE")));
            Editable = false;
        }
        field(112; "Alerte vue par BE"; Boolean)
        {
            Caption = 'Alerte vue par BE';
            FieldClass = FlowField;
            CalcFormula = lookup("Dossier BE"."Alerte vue par BE" where("No." = field("No. dossier BE")));
            Editable = false;
        }

        field(200; "Nom du prospect/client"; Text[100])
        {
            Caption = 'Nom du prospect/client';
            FieldClass = FlowField;
            CalcFormula = lookup("Dossier BE"."Nom du prospect/client" where("No." = field("No. dossier BE")));
            Editable = false;
        }
        field(210; "Commentaires"; Text[250])
        {
            Caption = 'Commentaires';
            FieldClass = FlowField;
            CalcFormula = lookup("Dossier BE".Commentaires where("No." = field("No. dossier BE")));
            Editable = false;
        }
        field(220; "Code vendeur"; Code[20])
        {
            Caption = 'Code vendeur';
            TableRelation = "Salesperson/Purchaser";
            FieldClass = FlowField;
            CalcFormula = lookup("Dossier BE"."Code vendeur" where("No." = field("No. dossier BE")));
            Editable = false;
        }
        field(230; "Date chargement"; Date)
        {
            Caption = 'Date de chargement';
            FieldClass = FlowField;
            CalcFormula = lookup("Dossier BE"."Date chargement" where("No." = field("No. dossier BE")));
            Editable = false;
        }
        field(240; "Date livraison demandée"; Date)
        {
            Caption = 'Date de livraison demandée';
            FieldClass = FlowField;
            CalcFormula = lookup("Dossier BE"."Date livraison demandée" where("No." = field("No. dossier BE")));
            Editable = false;
        }

        field(270; "PJ sur serveur"; Boolean)
        {
            Caption = 'PJ sur serveur ';
            FieldClass = FlowField;
            CalcFormula = lookup("Dossier BE"."PJ sur serveur" where("No." = field("No. dossier BE")));
            Editable = false;
        }


    }
    keys
    {
        key(PK; "No. dossier BE", "No. ligne")
        {
            Clustered = true;
        }
        key(MyKey2; "Reference")
        {

        }
        key(MyKey3; "Statut ligne")
        {

        }
        key(MyKey4; "Date debut traitement BE", Dessinateurs)
        {

        }
        key(MyKey5; "No. dossier BE", "Semaine debut traitement BE")
        {
        }
        key(MyKey6; "Date limite reponse BE")
        {

        }


    }

    trigger OnInsert()
    var
        DossierBE: Record "Dossier BE";
        LigneFicheBE: Record "Ligne fiche BE";
        Dessinateur: Record "Salesperson/Purchaser";
        DessinateurFicheBE: Record "Dessinateurs fiche BE";
        Annee: Integer;
        txtAnnee: Text[4];
        AjoutManuelDeLigneInterditErr: Label 'L''ajout de lignes n''est pas autorisé sur un dossier BE lié à un document de vente.';
    begin
        DossierBE.Get(Rec."No. dossier BE");
        if DossierBE."No. document" <> '' then
            Error(AjoutManuelDeLigneInterditErr);
        Annee := Date2DMY(Today, 3);
        txtAnnee := Format(Annee);
        txtAnnee := CopyStr(txtAnnee, 3, 2); //25 si on est en 2025 donc

        LigneFicheBE.SetCurrentKey(Reference);
        LigneFicheBE.SetFilter(Reference, '%1', txtAnnee + '*');

        if LigneFicheBE.FindLast() then
            Reference := IncStr(LigneFicheBE.Reference)
        else
            Reference := txtAnnee + '-00001';

        "Date demande" := today;

        if Rec."No. ligne" = 0 then begin
            LigneFicheBE.Reset();
            LigneFicheBE.SetRange("No. dossier BE", Rec."No. dossier BE");
            if LigneFicheBE.FindLast() then
                Rec."No. ligne" := LigneFicheBE."No. ligne" + 1
            else
                Rec."No. ligne" := 1;
        end;

        Dessinateur.SetRange(Dessinateur, true);
        if Dessinateur.FindSet(false) then
            repeat
                if not DessinateurFicheBE.Get("No. dossier BE", "No. ligne", Dessinateur.Code) then begin
                    DessinateurFicheBE.Init();
                    DessinateurFicheBE."No. dossier BE" := "No. dossier BE";
                    DessinateurFicheBE."No. ligne" := "No. ligne";
                    DessinateurFicheBE."Code dessinateur" := Dessinateur.Code;
                    DessinateurFicheBE.Insert();
                end;
            until Dessinateur.Next() = 0;
    end;

    trigger OnDelete()
    var
        DossierBE: record "Dossier BE";
        DessinateurFicheBE: Record "Dessinateurs fiche BE";
        SuppressionInterditeErr: label 'Vous ne pouvez pas supprimer cette ligne car la fiche est liée à un document de vente (%1 %2)', Comment = '%1 = Type document ; %2 = N° document';
    begin
        DossierBE.Get(Rec."No. dossier BE");
        if DossierBE."No. document" <> '' then
            Error(SuppressionInterditeErr, DossierBE."Type document", DossierBE."No. document");

        DessinateurFicheBE.SetRange("No. dossier BE", Rec."No. dossier BE");
        DessinateurFicheBE.SetRange("No. ligne", Rec."No. ligne");
        DessinateurFicheBE.DeleteAll();
    end;

    procedure ListerDessinateurs(): Text[250]
    var
        DessinateursFicheBE: Record "Dessinateurs fiche BE";
        TexteDessinateurs: Text[250];
    begin
        TexteDessinateurs := '';
        DessinateursFicheBE.SetRange("No. dossier BE", Rec."No. dossier BE");
        DessinateursFicheBE.SetRange("No. ligne", Rec."No. ligne");
        if DessinateursFicheBE.FindSet(false) then
            repeat
                if DessinateursFicheBE.Affecte then
                    if TexteDessinateurs = '' then
                        TexteDessinateurs := DessinateursFicheBE."Code dessinateur"
                    else
                        TexteDessinateurs := copystr(TexteDessinateurs + '|' + DessinateursFicheBE."Code dessinateur", 1, 250);
            until DessinateursFicheBE.Next() = 0;
        exit(TexteDessinateurs);
    end;
}
