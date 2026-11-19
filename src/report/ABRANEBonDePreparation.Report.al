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

            column(SelltoCustNo_SalesHeader; "Sell-to Customer No.")
            {
            }
            column(BilltoCustNo_SalesHeader; "Bill-to Customer No.")
            {
            }
            column(DocDate_SalesHeader; "Order Date")
            {
            }
            column(ExternalDocumentNo_SalesHeader; "External Document No.")
            {
            }
            column(SellToContact_SalesHeader; "Sell-to Contact")
            {
            }
            column(ExitPoint_SalesHeader; "Exit Point")
            {
            }
            column(QuoteNo_SalesHeader; "Quote No.")
            {
            }
            column(VATRegNo_SalesHeader; "VAT Registration No.")
            {
            }
            column(ShipmentMethodDescriptionCaption; ShipmentMethodCaptionLbl)
            {
            }
            column(OrderDate_SalesHeader; "Order Date")
            {
            }

            column(JobName_SalesHeader; JobName)
            {
            }

            column(ShipmentDate; "Date chargement")
            {
            }
            column(Comments_SalesHeader; Commentaire)
            {
            }
            column(Range_SalesHeader; "Range No.")
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
            column(LabelShipmentDate; DateChargementLbl)
            {
            }
            column(LabellTotalWeight; TotalWeightLbl)
            {
            }
            column(LabelTotalGrossWeight; TotalGrossWeightLbl)
            {
            }


            column(LabelPalette; PaletteLbl)
            {
            }

            column(PackageNumber; "Nombre de colis")
            {
            }
            column(PalletNumber; "Nombre de palettes")
            {
            }
            column(TotalNetWeight; "Total Net Weight")
            {
            }
            column(TotalGrossWeight; "Poids brut total")
            {
            }
            column(LabelPackage; PackageLbl)
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
                    column(CustAddr1; CustAddr[1])
                    {
                    }
                    column(CustAddr2; CustAddr[2])
                    {
                    }
                    column(CustAddr3; CustAddr[3])
                    {
                    }
                    column(CustAddr4; CustAddr[4])
                    {
                    }
                    column(CustAddr5; CustAddr[5])
                    {
                    }
                    column(CustAddr6; CustAddr[6])
                    {
                    }
                    column(CustAddr7; CustAddr[7])
                    {
                    }
                    column(CustAddr8; CustAddr[8])
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(CompanyInfoName; CompanyInfo.Name)
                    {
                    }
                    column(CompanyInfoAddress; CompanyInfo.Address)
                    {
                    }
                    column(CompanyInfoPostCode; CompanyInfo."Post Code")
                    {
                    }
                    column(CompanyInfoCity; CompanyInfo.City)
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(CompanyInfoFaxNo; CompanyInfo."Fax No.")
                    {
                    }
                    column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoRegNo; CompanyInfo."Registration No.")
                    {
                    }
                    column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfoBankName; CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoHomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfoEmail; CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfoBankAccountNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(CompanyInfoTradeRegister; CompanyInfo."Trade Register")
                    {
                    }
                    column(CompanyInfoLegalForm; CompanyInfo."Legal Form")
                    {
                    }
                    column(CompanyInfoStockCapital; CompanyInfo."Stock Capital")
                    {
                    }
                    column(CompanyInfoAPECode; CompanyInfo."APE Code")
                    {
                    }
                    column(CompanyInfoIBAN; CompanyInfo.IBAN)
                    {
                    }
                    column(CompanyInfoSWIFTCode; CompanyInfo."SWIFT Code")
                    {
                    }
                    column(CompanyInfoCountryCode; CompanyInfo."Country/Region Code")
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(SalesPersonText; SalesPersonText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(SalesPurchPersonEMail; SalesPurchPerson_PhoneNoEmail())
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
                    column(PaymentTermsDescription; PaymentTerms.Description)
                    {
                    }

                    column(ShipmentMethodDescription; ShipmentMethod.Description)
                    {
                    }
                    column(ShippingAgentName; ShippingAgent.Name)
                    {
                    }

                    column(DateChargement; "Sales Header"."Date chargement")
                    {
                    }

                    column(CompanyInfoVATRegNoCaption; VATRegNoCaptionLbl)
                    {
                    }
                    column(SalesHeaderNoCaption; SalesHeaderNoCaptionLbl)
                    {
                    }


                    column(CompanyInfoEmailCaption; EmailCaptionLbl)
                    {
                    }


                    column(BilltoCustNo_SalesHeaderCaption; "Sales Header".FieldCaption("Bill-to Customer No."))
                    {
                    }
                    column(PricesInclVAT_SalesHeaderCaption; "Sales Header".FieldCaption("Prices Including VAT"))
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
                    column(BilltoAddrCaption; BilltoAddrCaptionLbl)
                    {
                    }
                    column(BillToAddr1; BillToAddr[1])
                    {
                    }
                    column(BillToAddr2; BillToAddr[2])
                    {
                    }
                    column(BillToAddr3; BillToAddr[3])
                    {
                    }
                    column(BillToAddr4; BillToAddr[4])
                    {
                    }
                    column(BillToAddr5; BillToAddr[5])
                    {
                    }
                    column(BillToAddr6; BillToAddr[6])
                    {
                    }
                    column(BillToAddr7; BillToAddr[7])
                    {
                    }
                    column(BillToAddr8; BillToAddr[8])
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

                FormatAddr.Company(CompanyAddr, CompanyInfo);

                if "Salesperson Code" = '' then begin
                    Clear(SalesPurchPerson);
                    SalesPersonText := '';
                end else begin
                    SalesPurchPerson.Get("Salesperson Code");
                    SalesPersonText := Text000Lbl;
                end;

                ReferenceText := copystr(FieldCaption("Your Reference"), 1, 80);

                VATNoText := copystr(FieldCaption("VAT Registration No."), 1, 80);

                FormatAddr.SalesHeaderSellTo(CustAddr, "Sales Header");

                FormatAddr.SalesHeaderBillTo(BillToAddr, "Sales Header");

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

    var
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        ShippingAgent: Record "Shipping Agent";
        FormatAddr: Codeunit "Format Address";
        CustAddr: array[8] of Text[50];
        BillToAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        SalesPersonText: Text[30];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        OutputNo: Integer;
        JobName: Text[50];
        Text000Lbl: Label 'Vendeur';
        TitreDocumentFRALbl: Label 'Bon de préparation';
        PageCaptionLbl: Label 'Page';
        VATRegNoCaptionLbl: Label 'VAT Registration No.';
        SalesHeaderNoCaptionLbl: Label 'No.';
        EmailCaptionLbl: Label 'E-Mail';
        ShiptoAddrCaptionLbl: Label 'Adresse de livraison';
        BilltoAddrCaptionLbl: Label 'Commandé par';
        ShipmentMethodCaptionLbl: Label 'Shipment Method:';
        LabelNoLocationNameLbl: Label 'Magasin :';
        CommentaireLbl: Label 'Commentaires : ';
        TotalWeightLbl: Label 'Poids net total';
        //MarchandiseLbl: Label 'Product Information';
        PaletteLbl: Label 'Nb palettes : ';
        DateChargementLbl: Label 'Date chargement :';
        TotalGrossWeightLbl: Label 'Poids brut total :';
        CustOrderNoLbl: Label 'N° commande client';
        PackageLbl: Label 'Nombre colis : ';
        SalesCopyTextTxt: Text[100];
        NoCdeFournisseur: Text[100];
        NoArticleLbl: Label 'N° article';
        DesignationLbl: Label 'Désignation';
        QuantiteLigneLbl: Label 'Quantité';
        PhaseLbl: Label 'Phase';
        NoCdeFournLbl: Label 'N° commande fournisseur';
        NoPaletteLbl: Label 'N° palette';
        ManquantsLbl: Label 'Manquants';

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

