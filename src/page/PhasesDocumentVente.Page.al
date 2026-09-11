page 50105 "Phases document vente"
{
    ApplicationArea = All;
    Caption = 'Phases document vente';
    PageType = List;
    SourceTable = "Phases document";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            field(NumDoc; NumDoc)
            {
                ApplicationArea = All;
                Caption = 'N° document';
                ToolTip = 'N° document';
                Editable = false;
            }
            field(StatutDoc; StatutDoc)
            {
                ApplicationArea = All;
                Caption = 'Statut';
                ToolTip = 'Statut du document';
                Editable = false;
            }


            repeater(General)
            {
                field(Phase; Rec.Phase)
                {
                    ToolTip = 'Indique la phase, la phase 0 correspondant à la phase "Indéfinie"';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description de la phase, cela peut correspondre à un découpage du chantier par étage ou par étapes de réalisation par exemple.';
                    StyleExpr = MonStyle;
                }
                field("Date chargement"; Rec."Date chargement")
                {
                    ToolTip = 'Indique la date à laquelle les articles devraient être chargés pour satisfaire la date de livraison demandée.';
                }
                field("Date livraison demandee"; Rec."Date livraison demandee")
                {
                    ToolTip = 'Indique la date à laquelle les articles liés à cette phase doivent être livrés (date demandée par le client)';
                }

                field("Date comptabilisation"; Rec."Date comptabilisation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Permet d''indiquer la date du bon de livraison lorsque vous êtes sur le point de livrer cette phase.';
                }
            }
            part("SF Phases document vente"; "SF phases document vente")
            {
                SubPageLink = "TypedocDuplique" = field("Type document"), NumDocDuplique = field("No. document"), Phase = field(Phase);
                Editable = SFEditable;
            }
        }

    }
    actions
    {
        area(Processing)
        {
            action(PhaserReliquat)
            {
                ApplicationArea = All;
                Caption = 'Phaser le reliquat';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = MoveNegativeLines;
                ToolTip = 'Déplace les quantités non encore expédiées vers la phase 99 = phase dédiée à la livraison du reliquat';

                trigger OnAction()
                var
                    EnteteVente: Record "Sales Header";
                    ParamUtil: Record "User Setup";
                    ConfirmerQst: label 'Souhaitez-vous déplacer les quantités non livrées vers la phase 99 RELIQUAT';

                begin
                    if not ParamUtil.Get(UserId) then
                        ParamUtil.Init();

                    ParamUtil.TestField("Phaser reliquat", true);

                    if not Confirm(ConfirmerQst, true) then
                        exit;

                    EnteteVente.get(EnteteVente."Document Type"::Order, Rec."No. document");
                    EnteteVente.PhaserReliquat();
                end;
            }
            action(RouvrirDocument)
            {
                ApplicationArea = All;
                Caption = 'Rouvrir document';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ReOpen;
                ToolTip = 'Permet de rouvrir le document.';
                ShortcutKey = 'Ctrl+Q';

                trigger OnAction()
                var
                    EnteteVente: Record "Sales Header";
                    RelaseSalesDocCodeunit: Codeunit "Release Sales Document";
                    DocumentRouvertMsg: Label 'Le document a été rouvert.';
                    DocumentDejaOuvertMsg: Label 'Le document  déjà ouvert.';
                begin

                    EnteteVente.get(Rec."Type document", Rec."No. document");
                    if EnteteVente.Status <> EnteteVente.Status::Open then begin
                        RelaseSalesDocCodeunit.Reopen(EnteteVente);
                        Message(DocumentRouvertMsg);
                    end else
                        Message(DocumentDejaOuvertMsg);
                end;
            }

        }
    }

    procedure GererModificationsPhases()
    var
        Pays: Record "Country/Region";

        PhasesDocument: Record "Phases document";
        DossierBE: Record "Dossier BE";
        LigneFicheBE: Record "Ligne fiche BE";
        LigneVente: Record "Sales Line";
        JourSemaine: Integer;
        DateLimiteReponseBE: date;
        NotifDateChargementTxt: Text[250];
        DelaiTransitText: Text;
        DelaiTransitLbl: label '<-%1D>', Comment = '%1 = Nombre de jours';
    begin
        if Rec.getfilter("No. document") = '' then
            exit;

        if Rec.GetRangeMin("No. document") <> Rec.GetRangeMax("No. document") then
            exit;

        //La date de chargement du document doit correspondre à la plus grande date de chargement des phases du document
        PhasesDocument.Reset();
        PhasesDocument.SetCurrentKey("Type document", "No. document", "Date chargement");
        PhasesDocument.SetRange("Type document", Rec."Type document");
        PhasesDocument.SetRange("No. document", Rec."No. document");
        if PhasesDocument.FindLast() then begin
            EnteteDocumentVente.Get(Rec."Type document", Rec."No. document");
            EnteteDocumentVente.CalcFields("Date chargement min. phases", "Date chargement max. phases");
            if PhasesDocument."Date chargement" > DateChargementMaxAvant then begin
                DateChargementMaxApres := PhasesDocument."Date chargement";
                EnteteDocumentVente."Date chargement" := PhasesDocument."Date chargement";
                EnteteDocumentVente."Requested Delivery Date" := PhasesDocument."Date livraison demandee";
                EnteteDocumentVente.Modify();
            end;

            //Le BE doit donner une réponse avant une date limite qui dépend de la première date de chargement 
            //On vérifie si elle a changé
            PhasesDocument.FindFirst();
            DateChargementMinApres := PhasesDocument."Date Chargement";
            if EnteteDocumentVente."No. dossier BE" <> '' then
                if (DateChargementMinAvant <> DateChargementMinApres) or (DateChargementMaxAvant <> DateChargementMaxApres) then begin

                    NotifDateChargementTxt := 'Dates chargements modifiées :' +
                                              ' - Avant : ' + format(DateChargementMinAvant) + ' au ' + format(DateChargementMaxAvant) + ' ' +
                                              ' - Mtnt : ' + format(DateChargementMinApres) + ' au ' + format(DateChargementMaxApres);

                    DossierBE.GET(EnteteDocumentVente."No. dossier BE");
                    DossierBE."Alerte decalage date" := true;
                    DossierBE."Detail alerte" := NotifDateChargementTxt;
                    DossierBE.Modify();
                end;

            if PhasesDocument."Date chargement" < DateChargementMinAvant then begin
                //Parcourir les fiches BE et recalculer la date limite réponse BE 
                LigneFicheBE.Reset();
                LigneFicheBE.SetRange("No. dossier BE", EnteteDocumentVente."No. dossier BE");
                if LigneFicheBE.FindSet(true) then begin
                    LigneVente.Reset();
                    LigneVente.SetCurrentKey("Reference Fiche BE");
                    repeat
                        if LigneFicheBE."Statut ligne" in [LigneFicheBE."Statut ligne"::" ", LigneFicheBE."Statut ligne"::"En cours"] then begin
                            DateLimiteReponseBE := CalcDate('<-6W>', DateChargementMinApres);
                            LigneVente.SetRange("Reference Fiche BE", LigneFicheBE.Reference);
                            if LigneVente.Findfirst() then
                                if LigneVente."Country/Region of Origin Code" <> '' then begin
                                    Pays.get(LigneVente."Country/Region of Origin Code");
                                    Pays.TestField("Delai transit (jours)");
                                    DelaiTransitText := StrSubstNo(DelaiTransitLbl, Pays."Delai transit (jours)");
                                    DateLimiteReponseBE := CalcDate(DelaiTransitText, DateLimiteReponseBE);
                                    JourSemaine := Date2DWY(DateLimiteReponseBE, 1);
                                    while JourSemaine > 5 do begin
                                        DateLimiteReponseBE := CalcDate('<+1D>', DateLimiteReponseBE);
                                        JourSemaine := Date2DWY(DateLimiteReponseBE, 1);
                                    end;
                                end else
                                    DateLimiteReponseBE := CalcDate('<-2W>', Rec."Date chargement"); //On passe donc à 8 semaines si on ne connait pas le pays d'origine

                            LigneFicheBE."Date limite reponse BE" := DateLimiteReponseBE;
                            LigneFicheBE."Semaine limite reponse BE" := Date2DWY(LigneFicheBE."Date limite reponse BE", 2);
                            LigneFicheBE.Modify();
                        end;
                    until LigneFicheBE.Next() = 0;
                end;
            end;
        end;
    end;


    procedure DefinirConditionsAppel(pAppelPourLivrer: Boolean)
    begin
        SFEditable := pAppelPourLivrer;
    end;

    trigger OnOpenPage()
    begin
        EnteteDocumentVente.Get(Rec.GetRangeMin("Type document"), Rec.Getrangemin("No. document"));
        EnteteDocumentVente.CalcFields("Date chargement min. phases", "Date chargement max. phases");
        DateChargementMinAvant := EnteteDocumentVente."Date chargement min. phases";
        DateChargementMaxAvant := EnteteDocumentVente."Date chargement max. phases";
        DateChargementMinApres := DateChargementMinAvant;
        DateChargementMaxApres := DateChargementMaxAvant;
        NumDoc := EnteteDocumentVente."No.";
        StatutDoc := Format(EnteteDocumentVente.Status);
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        GererModificationsPhases();
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.calcfields("Nb lignes dans phase");
        DefinirStyle();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        Rec.calcfields("Nb lignes dans phase");
        DefinirStyle();
    end;

    procedure DefinirStyle()
    var

    begin
        if Rec."Nb lignes dans phase" = 0 then
            MonStyle := 'Subordinate'
        else
            MonStyle := 'Standard';
    end;

    var
        EnteteDocumentVente: Record "Sales Header";
        SFEditable: Boolean;
        DateChargementMinApres: Date;
        DateChargementMaxApres: Date;
        DateChargementMinAvant: Date;
        DateChargementMaxAvant: Date;
        MonStyle: Text;
        NumDoc: Code[20];
        StatutDoc: Text[30];

}
