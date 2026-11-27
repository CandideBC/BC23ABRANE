report 50012 "ABRANE : bon de preparation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/ReportLayout/ABRANEBonDePreparation.rdlc';

    Caption = 'Bon de préparation';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = filter(Quote | Order));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Bon de préparation / Devis ou commande vente';
            column(DocType_SalesHeader; "Document Type")
            {
            }
            column(No_SalesHeader; "No.")
            {
            }
            column(Version; NoVersionDernArchive)
            {
            }
            column(DateVersion; DateDernArchive)
            {
                
            }
            column(DocDate_SalesHeader; "Order Date")
            {
            }
            column(ShipToContact_SalesHeader; "Ship-to Contact")
            {
            }
            column(Comments_SalesHeader; Commentaire)
            {
            }
            column(CommentairesPrepaTxt; CommentairesPrepaTxt)
            {
            }
            column(LabelNoLocationName_SalesHeader; NomChantierLbl)
            {
            }
            column(NoLocationName_SalesHeader; NomChantier)
            {
            }
            column(LabelCommentaire; CommentaireLbl)
            {
            }
            column(LabellTotalWeight; TotalWeightLbl)
            {
            }
            column(LabelPrepNoArticle; NoArticleLbl)
            {
            }
            column(LabelPrepDesignation; DesignationLbl)
            {
            }
            column(LabelPrepQuantite; QuantiteLigneLbl)
            {
            }
            column(LabelPrepPhase; PhaseLbl)
            {
            }
            column(LabelPrepNoCdeFourn; NoCdeFournLbl)
            {
            }
            column(LabelPrepNoPalette; NoPaletteLbl)
            {
            }
            column(LabelPrepManquants; ManquantsLbl)
            {
            }
            column(ColonneCommentaireLbl; ColonneCommentaireLbl)
            {
            }
            column(Phase1Txt; Phase1Txt)
            {
                
            }
            column(Phase2Txt; Phase2Txt)
            {
                
            }
            column(Phase3Txt; Phase3Txt)
            {
                
            }
            column(DateChargementPhase1; DateChargementPhase1)
            {

            }
            column(DateChargementPhase2; DateChargementPhase2)
            {

            }
            column(DateChargementPhase3; DateChargementPhase3)
            {

            }
            column(DateLivraisonPhase1; DateLivraisonPhase1)
            {

            }
            column(DateLivraisonPhase2; DateLivraisonPhase2)
            {

            }
            column(DateLivraisonPhase3; DateLivraisonPhase3)
            {

            }
            column(AutresPhasesTxt; AutresPhasesTxt)
            {

            }

            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = sorting(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = const(1));

                    column(SalesCopyText; SalesCopyTextTxt)
                    {
                    }
                    column(TitreDocumentFRALbl; TitreDocumentFRALbl)
                    {

                    }


                    column(SalesPersonText; SalesPersonText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }

                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(SalesHeaderNoCaption; SalesHeaderNoCaptionLbl)
                    {
                    }


                    column(ShiptoAddrCaption; ShiptoAddrCaptionLbl)
                    {
                    }
                    column(ShipToAddr1; ShipToAddr[1])
                    {
                    }
                    column(ShipToAddr2; ShipToAddr[2])
                    {
                    }
                    column(ShipToAddr3; ShipToAddr[3])
                    {
                    }
                    column(ShipToAddr4; ShipToAddr[4])
                    {
                    }
                    column(ShipToAddr5; ShipToAddr[5])
                    {
                    }
                    column(ShipToAddr6; ShipToAddr[6])
                    {
                    }
                    column(ShipToAddr7; ShipToAddr[7])
                    {
                    }
                    column(ShipToAddr8; ShipToAddr[8])
                    {
                    }


                    dataitem(Lignes; TamponTriLignesDocument)
                    {
                        DataItemTableView = sorting("Code utilisateur", "Type document", "No. document","Prepa sur stock", "No. ligne");
                        column(Lig_NoLigne; "No. ligne")
                        {
                        }
                        column(Lig_NoArticle; "No.")
                        {
                        }
                        column(Lig_Designation; Description)
                        {
                        }
                        column(Lig_Quantite; Quantite)
                        {
                            AutoFormatType = 11;
                            AutoFormatExpression = '<Precision,0:0><Standard Format,0>';
                        }
                        column(Lig_Phase; Phase)
                        {
                        }
                        column(InfosPrepa; InfosPrepa)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            // Lignes de la table de travail de l'utilisateur pour le document en cours, dans l'ordre du N° ligne
                            // (le N° ligne est le rang d'impression défini au remplissage de la table).
                            SetRange("Code utilisateur", CopyStr(UserId, 1, MaxStrLen("Code utilisateur")));
                            SetRange("Type document", Format("Sales Header"."Document Type"));
                            SetRange("No. document", "Sales Header"."No.");

                        end;

                        trigger OnAfterGetRecord()
                        begin
                            // N° commande fournisseur : laissé vide pour l'instant, à renseigner ici ultérieurement.
                            NoCdeFournisseur := '';
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    if Number > 1 then
                        OutputNo += 1;
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := Abs(NoOfCopies) + 1;
                    CopyText := '';
                    SetRange(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if "Document Type" = "Document Type"::Order then
                    SalesCopyTextTxt := 'Commande'
                else
                    SalesCopyTextTxt := 'Devis';


                CommentairesPrepaTxt := GetCommentairesPrepa();
                RecupInfosDerniereArchive(MontantDernArchive, NoVersionDernArchive, DateDernArchive);

                //KAN.FHA 26/11/2026 DEBUT
                NomChantier := '';
                if "No. And Location Name" <> '' then
                    NomChantier := "No. And Location Name"
                else 
                    if "Code chantier" <> '' then
                        if Chantier.get("Code chantier") then
                            NomChantier := Chantier."Nom chantier"; 
                //KAN.FHA 26/11/2026 FIN

                if "Salesperson Code" = '' then begin
                    Clear(SalesPurchPerson);
                    SalesPersonText := '';
                end else begin
                    SalesPurchPerson.Get("Salesperson Code");
                    SalesPersonText := Text000Lbl;
                end;

                ReferenceText := copystr(FieldCaption("Your Reference"), 1, 80);

                FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, "Sales Header");

                NbPhases := 1;
                AutresPhasesTxt := '';
                PhasesDocument.SetRange("Type document", "Sales Header"."Document Type");
                PhasesDocument.SetRange("No. document", "Sales Header"."No.");
                if PhasesDocument.FindSet(false) then begin
                    repeat
                        TableauPhases[NbPhases] := 'Phase ' + format(PhasesDocument.Phase);
                        TableauDatesChargement[NbPhases] := PhasesDocument."Date chargement";
                        TableauDatesLivraison[NbPhases] := PhasesDocument."Date livraison demandee";
                        NbPhases := NbPhases + 1;
                    until (PhasesDocument.Next() = 0) or (NbPhases = 4);
                    Phase1Txt := TableauPhases[1];
                    Phase2Txt := TableauPhases[2];
                    Phase3Txt := TableauPhases[3];
                    DateChargementPhase1 := TableauDatesChargement[1];
                    DateChargementPhase2 := TableauDatesChargement[2];
                    DateChargementPhase3 := TableauDatesChargement[3];
                    DateLivraisonPhase1 := TableauDatesLivraison[1];
                    DateLivraisonPhase2 := TableauDatesLivraison[2];
                    DateLivraisonPhase3 := TableauDatesLivraison[3];
                    if PhasesDocument.Count > 3 then
                        AutresPhasesTxt := AutresPhasesLbl;
                end;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoOfCopiesField; NoOfCopies)
                    {
                        Caption = 'Nb de copies';
                        ToolTip = 'Nb de copies';
                    }
                }
            }
        }

        actions
        {
        }



    }

    trigger OnInitReport()
    begin
        SalesSetup.Get();
    end;

    trigger OnPostReport()
    begin
        // Hors aperçu : l'appelant imprimera aussi les feuilles complémentaires (Infos palette vente, Récap achats vente).
        ImprimerSuite := not CurrReport.Preview;
    end;

    var
        SalesPurchPerson: Record "Salesperson/Purchaser";
        SalesSetup: Record "Sales & Receivables Setup";
        PhasesDocument: Record "Phases document";
        Chantier: Record chantier;
        FormatAddr: Codeunit "Format Address";
        ShipToAddr: array[8] of Text[100];
        CustAddr: array[8] of Text[100];
        SalesPersonText: Text[30];
        ReferenceText: Text[80];
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        OutputNo: Integer;
        ImprimerSuite: Boolean;
        Text000Lbl: Label 'Suivi par';
        TitreDocumentFRALbl: Label 'Bon de préparation';
        PageCaptionLbl: Label 'Page';
        SalesHeaderNoCaptionLbl: Label 'No.';
        ShiptoAddrCaptionLbl: Label 'Adresse de livraison';
        NomChantierLbl: Label 'Magasin :';
        CommentaireLbl: Label 'Commentaires : ';
        TotalWeightLbl: Label 'Poids net total';
        SalesCopyTextTxt: Text[100];
        NoCdeFournisseur: Text[100];
        NoArticleLbl: Label 'N° article';
        DesignationLbl: Label 'Désignation';
        QuantiteLigneLbl: Label 'Quantité';
        PhaseLbl: Label 'Phase';
        NoCdeFournLbl: Label 'Infos pour prépa';
        NoPaletteLbl: Label 'Palettisation';
        ManquantsLbl: Label 'Reliquats';
        ColonneCommentaireLbl: Label 'Commentaires';
        Phase1Txt: Text[10];
        Phase2Txt: Text[10];
        Phase3Txt: Text[10];
        DateChargementPhase1: date;
        DateChargementPhase2: date;
        DateChargementPhase3: date;
        DateLivraisonPhase1: date;
        DateLivraisonPhase2: date;
        DateLivraisonPhase3: date;
        TableauPhases: array[3] of Text[10];
        TableauDatesChargement: array[3] of Date;
        TableauDatesLivraison: array[3] of Date;
        NbPhases: Integer;
        AutresPhasesLbl: Label 'Autres phases : voir récap infos achat';
        AutresPhasesTxt: Text[80];
        NomChantier: Text[50];
        InfosPrepa: Text[80];
        CommentairesPrepaTxt: Text;
        MontantDernArchive: Decimal;
        NoVersionDernArchive : integer; 
        DateDernArchive: Date;


    procedure GetImprimerSuite(): Boolean
    begin
        exit(ImprimerSuite);
    end;

    procedure SalesPurchPerson_PhoneNoEmail() PhoneNoEmail: Text[1024]
    begin
        Clear(PhoneNoEmail);
        PhoneNoEmail := SalesPurchPerson."Phone No.";
        if SalesPurchPerson."E-Mail" <> '' then begin
            if PhoneNoEmail <> '' then
                PhoneNoEmail := copystr(PhoneNoEmail + ' / ', 1, 1024);
            PhoneNoEmail := copystr(PhoneNoEmail + SalesPurchPerson."E-Mail", 1, 1024)
        end;
    end;
}

