table 50053 "Phases document"
{
    Caption = 'Phases document';
    DataClassification = ToBeClassified;
    LookupPageId = "Liste phases document";
    DrillDownPageId = "Phases document vente";

    fields
    {
        field(1; "Type document"; Enum "Sales Document Type")
        {
            Caption = 'Type document';
        }
        field(10; "No. document"; Code[20])
        {
            Caption = 'N° document';
            TableRelation = if ("Type document" = const(Quote)) "Sales Header"."No." where("document type" = const(Quote))
            else
            if ("Type document" = const(Order)) "Sales Header"."No." where("document type" = const(Order));

        }
        field(12; "Code enseigne"; Code[20])
        {
            Caption = 'Code enseigne';
            Editable = false;
            TableRelation = Enseigne;
        }
        field(13; "Code chantier"; Code[20])
        {
            Caption = 'Code chantier';
            Editable = false;
            TableRelation = Chantier.Code where("Code enseigne" = field("Code enseigne"));
        }
        field(14; "Commentaires"; Text[250])
        {
            Caption = 'Commentaires';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header".Commentaire where("Document Type" = field("Type document"), "No." = field("No. document")));
            Editable = false;
        }
        field(15; "No. doc externe"; Code[35])
        {
            Caption = 'N° doc. externe';
            trigger OnValidate()
            var
                EnteteVente: Record "Sales Header";
                PhasesDocument: Record "Phases document";
            begin
                if "No. document" <> '' then begin
                    EnteteVente.get(Rec."Type Document"::Quote, Rec."No. document");
                    EnteteVente.Validate("External Document No.", rec."No. doc externe");
                    EnteteVente.Modify();
                end;
                PhasesDocument.SetRange("Type document", "Type document");
                PhasesDocument.SetRange("No. document", "No. document");
                PhasesDocument.SetFilter(Phase, '<>%1', Phase);
                PhasesDocument.ModifyAll("No. doc externe", "No. doc externe");
            end;
        }

        field(16; "Proba transformation"; Option)
        {
            Caption = 'Proba transformation';

            OptionMembers = " ","1","50","100";
            OptionCaption = ' ,1,50,100';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                EnteteVente: Record "Sales Header";
                PhasesDocument: Record "Phases document";
            begin
                if EnteteVente.get(EnteteVente."Document Type"::Quote, Rec."No. document") then begin
                    EnteteVente.Validate("Proba transformation", Rec."Proba transformation");
                    EnteteVente.Modify();
                end;
                PhasesDocument.SetRange("Type document", "Type document");
                PhasesDocument.SetRange("No. document", "No. document");
                PhasesDocument.SetFilter(Phase, '<>%1', Phase);
                PhasesDocument.ModifyAll("Proba transformation", "Proba transformation");
            end;
        }
        field(18; "Code vendeur"; Code[20])
        {
            Caption = 'Code vendeur';
            TableRelation = "Salesperson/Purchaser";
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(20; Phase; Integer)
        {
            Caption = 'Phase';
        }
        field(25; Description; Text[50])
        {
            Caption = 'Description phase';
        }
        field(30; "Nb lignes dans phase"; Integer)
        {
            Caption = 'Nb lignes dans phase';
            FieldClass = FlowField;
            CalcFormula = count("Sales Line" where(TypeDocDuplique = field("Type document"), NumDocDuplique = field("No. document"), Phase = field(Phase)));
            Editable = false;
        }

        field(50; "Date chargement"; Date)
        {
            Caption = 'Date chargement';
        }
        field(51; "Date semaine chargement"; Date)
        {
            Caption = 'Date semaine chargement';
        }
        field(60; "Date livraison demandee"; Date)
        {
            Caption = 'Date livraison demandée';
            trigger OnValidate()
            var
                Pays: Record "Country/Region";
                EnteteDocumentVente: Record "Sales Header";
                DateChargement: Date;
                JourSemaine: Integer;
                DelaiTransit: Text;
                UnJourAvantTxt: Label '<-%1D>', Comment = '%1 = Nombre de jours';

            begin
                if rec."Type document" in ["Type document"::Quote, "Type document"::Order] then begin
                    EnteteDocumentVente.Get(Rec."Type document", Rec."No. document");

                    if not pays.get(EnteteDocumentVente."Ship-to Country/Region Code") then
                        Pays.Init();

                    Pays.TestField("Delai transit (jours)");
                    DelaiTransit := StrSubstNo(UnJourAvantTxt, Pays."Delai transit (jours)");
                    DateChargement := CalcDate(DelaiTransit, Rec."Date livraison demandee");
                    JourSemaine := Date2DWY(DateChargement, 1);
                    //On veut une date de chargement qui ne soit pas un samedi ou un dimanche
                    while JourSemaine > 5 do begin
                        DateChargement := CalcDate('<-1D>', DateChargement);
                        JourSemaine := Date2DWY(DateChargement, 1);
                    end;
                    "Date chargement" := DateChargement;
                    //KAN.FHA 28/04/2026 DEBUT
                    if "Date chargement" <> 0D then
                        "Date semaine chargement" := CalcDate('<-CW>', "Date chargement")
                    else
                        "Date semaine chargement" := 0D;
                    //KAN.FHA 28/04/2026 FIN
                end;
            end;
        }
        field(70; "Date comptabilisation"; Date)
        {
            Caption = 'Date comptabilisation';
        }
        field(75; "Commentaire factu."; Text[50])
        {
            Caption = 'Commentaire factu.';
            DataClassification = ToBeClassified;
        }

        field(80; Acheter; Boolean)
        {
            Caption = 'Acheter';
            Description = 'Sert dans le processus "Créer commande achat" depuis un document de vente';

            trigger OnValidate()
            var
                LigneVente: Record "Sales Line";
            begin
                LigneVente.SetRange("Document Type", Rec."Type document");
                LigneVente.SetRange("Document No.", Rec."No. document");
                LigneVente.SetRange(Phase, Rec.Phase);
                LigneVente.ModifyAll("A acheter", Rec.Acheter);
            end;
        }

    }

    keys
    {
        key(PK; "Type document", "No. document", Phase)
        {
            Clustered = true;
        }
        key(MyKey1; "No. document")
        {

        }
        key(MyKey2; "Type document", "No. document", "Date chargement")
        {

        }
        key(MyKey3; "Type document", "Date semaine chargement")
        {

        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Phase, Description)
        {

        }
    }
    trigger OnInsert()
    var
        EnteteVente: Record "Sales Header";
    begin
        VerifStatutDocument();
        if "No. document" <> '' then begin
            EnteteVente.Get(Rec."Type document", Rec."No. document");
            "Code vendeur" := Entetevente."Salesperson Code";
            "Code enseigne" := EnteteVente."Code enseigne";
            "Code chantier" := EnteteVente."Code chantier";
            "No. doc externe" := EnteteVente."External Document No.";
            "Proba transformation" := EnteteVente."Proba transformation";
        end;
    end;

    trigger OnDelete()
    begin
        VerifStatutDocument();
    end;

    procedure VerifStatutDocument()
    var
        EnteteVente: Record "Sales Header";
    begin
        if "No. document" <> '' then begin
            EnteteVente.Get(Rec."Type document", Rec."No. document");
            EnteteVente.TestStatusOpen();
        end;
    end;

    procedure CompterCdesAchatsLiees(): Integer
    var
        AffectationsAchats: Record "Affectations achat vente";
        LigneVente: Record "Sales Line";
        NbCde: Integer;
        NumCde: Code[20];
        ListeCommandesAchatsTxt: text[250];

    begin
        //Ce code n'est pas bon. Il faut compter le Nb de commandes d'achats affectées uniquement aux lignes de la phase
        NbCde := 0;
        NumCde := '';
        ListeCommandesAchatsTxt := '';

        LigneVente.SetRange("Document Type", Rec."Type document");
        LigneVente.SetRange("Document No.", Rec."No. document");
        LigneVente.SetRange(Phase, Rec.Phase);
        if LigneVente.FindSet(false) then begin
            AffectationsAchats.Reset();
            AffectationsAchats.SetCurrentKey("Type document vente", "No. document vente", "No. document achat");
            AffectationsAchats.SetRange("Type document vente", "Type document");
            AffectationsAchats.SetRange("No. document vente", "No. document");

            repeat
                AffectationsAchats.SetRange("No. ligne document vente", LigneVente."Line No.");

                if AffectationsAchats.FindSet(false) then
                    repeat
                        if (AffectationsAchats."No. document achat" <> '') and (AffectationsAchats."No. document achat" <> NumCde) then 
                            if StrPos(ListeCommandesAchatsTxt, AffectationsAchats."No. document achat") = 0 then begin
                                NbCde := NbCde + 1;
                                ListeCommandesAchatsTxt := copystr(ListeCommandesAchatsTxt + AffectationsAchats."No. document achat" + ' ', 1, 250);
                                NumCde := AffectationsAchats."No. document achat";
                            end;
                    until AffectationsAchats.Next() = 0;

            until LigneVente.Next() = 0;
        end;
        exit(NbCde);
    end;
}
