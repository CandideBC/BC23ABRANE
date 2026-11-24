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
            column(Version; "No. of Archived Versions")
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

            column(LabelNoLocationName_SalesHeader; LabelNoLocationNameLbl)
            {
            }
            column(NoLocationName_SalesHeader; "No. And Location Name")
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
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = sorting(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = const(1));
                    column(CompanyInfoPicture; CompanyInfo.Picture)
                    {
                    }
                    column(SalesCopyText; SalesCopyTextTxt)
                    {
                    }
                    column(TitreDocumentFRALbl; TitreDocumentFRALbl)
                    {

                    }



  
                    column(CompanyInfoAddress; CompanyInfo.Address)
                    {
                    }
                    column(CompanyInfoPostCode; CompanyInfo."Post Code")
                    {
                    }


                    column(CompanyInfoTradeRegister; CompanyInfo."Trade Register")
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
                        DataItemTableView = sorting("Code utilisateur", "Type document", "No. document", "No. ligne");
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
                        column(Lig_NoCdeFournisseur; NoCdeFournisseur)
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

                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture);

                //FormatAddr.Company(CompanyAddr, CompanyInfo);

                if "Salesperson Code" = '' then begin
                    Clear(SalesPurchPerson);
                    SalesPersonText := '';
                end else begin
                    SalesPurchPerson.Get("Salesperson Code");
                    SalesPersonText := Text000Lbl;
                end;

                ReferenceText := copystr(FieldCaption("Your Reference"), 1, 80);

                VATNoText := copystr(FieldCaption("VAT Registration No."), 1, 80);

                //FormatAddr.SalesHeaderSellTo(CustAddr, "Sales Header");

                //FormatAddr.SalesHeaderBillTo(BillToAddr, "Sales Header");

                if not ShippingAgent.Get("Sales Header"."Shipping Agent Code") then
                    ShippingAgent.Init();

                if "Payment Terms Code" = '' then
                    PaymentTerms.Init()
                else begin
                    PaymentTerms.Get("Payment Terms Code");
                    PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
                end;

                if "Shipment Method Code" = '' then
                    ShipmentMethod.Init()
                else begin
                    ShipmentMethod.Get("Shipment Method Code");
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Language Code");
                end;

                FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, "Sales Header");

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
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        ShippingAgent: Record "Shipping Agent";
        FormatAddr: Codeunit "Format Address";
        //CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[100];
        CustAddr: array[8] of Text[100];
        SalesPersonText: Text[30];
        VATNoText: Text[80];
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
        LabelNoLocationNameLbl: Label 'Magasin :';
        CommentaireLbl: Label 'Commentaires : ';
        TotalWeightLbl: Label 'Poids net total';
        //MarchandiseLbl: Label 'Product Information';
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

