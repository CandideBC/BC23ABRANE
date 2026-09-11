report 50009 "ABRANE : Packing List"
{
    // DIA@NDE 05/02/15  Archivage non systématique
    // DIA@NDE 19/02/15  Modification gestion Total Poids net avec champ en-tête de commande vente
    // DIA@NDE 25/02/15  Qté mentionnée= Qté à expédier et non qté commandée
    DefaultLayout = RDLC;
    RDLCLayout = './src/ReportLayout/ABRANEPackingList.rdlc';

    Caption = 'Liste de colisage';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = sorting ("Document Type", "No.") WHERE ("Document Type" = CONST (Order));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Sales Order';
            column(DocType_SalesHeader; "Document Type")
            {
            }
            column(No_SalesHeader; "No.")
            {
            }
            column(DiscountPercentCaption; DiscountPercentCaptionLbl)
            {
            }
            column(SelltoCustNoCaption; SelltoCustNoCaptionLbl)
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
            column(InvDiscAmtCaption; InvDiscAmtCaptionLbl)
            {
            }
            column(PhoneNoCaption; PhoneNoCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(VATPercentageCaption; VATPercentageCaptionLbl)
            {
            }
            column(VATBaseCaption; VATBaseCaptionLbl)
            {
            }
            column(VATAmtCaption; VATAmtCaptionLbl)
            {
            }
            column(VATAmtSpecCaption; VATAmtSpecCaptionLbl)
            {
            }
            column(LineAmtCaption; LineAmtCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(UnitPriceCaption; UnitPriceCaptionLbl)
            {
            }
            column(PaymentTermsDescriptionCaption; PaymentTermsCaptionLbl)
            {
            }
            column(ShipmentMethodDescriptionCaption; ShipmentMethodCaptionLbl)
            {
            }
            column(PaymentCaption; PaymentCaptionLbl)
            {
            }
            column(ShippingAgentCaption; ShippingAgentCaptionLbl)
            {
            }
            column(AllowInvDiscCaption; AllowInvDiscCaptionLbl)
            {
            }
            column(DearSirMadamCaption; DearSirMadamCaptionLbl)
            {
            }
            column(ThankYouCaption; ThankYouCaptionLbl)
            {
            }
            column(OrderDate_SalesHeader; "Order Date")
            {
            }
            column(DueDate; "Due Date")
            {
            }
            column(JobName_SalesHeader; JobName)
            {
            }
            column(RequestDelivreyDate; "Requested Delivery Date")
            {
            }
            column(ShipmentDate; "Shipment Date")
            {
            }
            column(Comments_SalesHeader; Commentaire)
            {
            }
            column(Range_SalesHeader; "Range No.")
            {
            }
            column(NoLocationName_SalesHeader; "No. And Location Name")
            {
            }
            column(SalesHeaderOrderDateCaption; SalesHeaderOrderDateCaptionLbl)
            {
            }
            column(LabelAffaire; LabelAffaireLbl)
            {
            }
            column(LabelSite; LabelSiteLbl)
            {
            }
            column(SiteName; SiteName)
            {
            }
            column(LabelNoLocationName; LabelNoLocationNameLbl)
            {
            }
            column(LabelNoRayon; LabelNoRayonLbl)
            {
            }
            column(LabelInterlocuteurclient; LabelInterlocuteurclientLbl)
            {
            }
            column(LabelCommentraire; LabelCommentraireLbl)
            {
            }
            column(LabelShipmentDate; LabelShipmentDateLbl)
            {
            }
            column(LabelEcoTax; LabelEcoTaxLbl)
            {
            }
            column(LabelEcoTaxText; LabelEcoTaxTextLbl)
            {
            }
            column(LabelNetaPayer; LabelNetaPayerLbl)
            {
            }
            column(LabelRefClient; LabelRefClientLbl)
            {
            }
            column(LabelDescription; LabelDescriptionLbl)
            {
            }
            column("LabelQuantité"; LabelQuantiteLblLbl)
            {
            }
            column(LabellTotalWeight; LabellTotalWeightLbl)
            {
            }
            column(LabelTotalGrossWeight; LabelTotalGrossWeightLbl)
            {
            }
            column(LabelTariff; LabelTariffLbl)
            {
            }
            column(LabelMarchandise; LabelMarchandiseLbl)
            {
            }
            column(LabelPalette; LabelPaletteLbl)
            {
            }
            column(LabelOrgMse; LabelOrgMseLbl)
            {
            }
            column(LabelOrder; LabelOrderLbl)
            {
            }
            column(LabelPays; LabelPaysLbl)
            {
            }
            column(LabelExpDate; LabelExpDateLbl)
            {
            }
            column(LabelCurrency; LabelCurrencyLbl)
            {
            }
            column(CurrencyCode; CurrencyCode)
            {
            }
            column(PackageNumber; "Nombre de colis")
            {
            }
            column(PalletNumber; "Nombre de palettes")
            {
            }
            column(LabelDevis; LabelDevisLbl)
            {
            }
            column(LabelCustOrder; LabelCustOrderLbl)
            {
            }
            column(LabelUnitCaption; LabelUnitCaptionLbl)
            {
            }
            column(LabelDuedate; LabelDuedateLbl)
            {
            }
            column(TotalNetWeight; "Total Net Weight")
            {
            }
            column(TotalGrossWeight; "Poids brut total")
            {
            }
            column(LabelPackage; LabelPackageLbl)
            {
            }
            column(labelVariant; labelVariantLbl)
            {
            }
            column(labelOrigine; labelOrigineLbl)
            {
            }
            column(labelWeight; labelWeightLbl)
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING (Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING (Number) WHERE (Number = CONST (1));
                    column(CompanyInfoPicture; CompanyInfo.Picture)
                    {
                    }
                    column(SalesCopyText; Text004Lbl)
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
                    column(SalesPersonMailCaption; SalesPersonMailCaptionLbl)
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(PageCaption; Text005Lbl)
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PaymentTermsDescription; PaymentTerms.Description)
                    {
                    }
                    column(PaymentMethodDescription; PaymentMethod.Description)
                    {
                    }
                    column(ShipmentMethodDescription; ShipmentMethod.Description)
                    {
                    }
                    column(ShippingAgentName; ShippingAgent.Name)
                    {
                    }
                    column(PricesInclVAT_SalesHeader; "Sales Header"."Prices Including VAT")
                    {
                    }
                    column(CompanyInfoVATRegNoCaption; VATRegNoCaptionLbl)
                    {
                    }
                    column(SalesHeaderNoCaption; SalesHeaderNoCaptionLbl)
                    {
                    }
                    column(SalesHeaderQuoteNoCaption; SalesHeaderQuoteNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoHomePageCaption; HomePageCaptionLbl)
                    {
                    }
                    column(CompanyInfoEmailCaption; EmailCaptionLbl)
                    {
                    }
                    column(CompanyInfoPhoneNoCaption; CompanyInfoPhoneNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoFaxNoCaption; CompanyInfoFaxNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoNameCaption; CompanyInfoNameCaptionLbl)
                    {
                    }
                    column(ContactCaption; ContactCaptionLbl)
                    {
                    }
                    column(CompanyInfoStockCapitalCaption; CompanyInfoStockCapitalCaptionLbl)
                    {
                    }
                    column(CompanyInfoAPECodeCaption; CompanyInfoAPECodeCaptionLbl)
                    {
                    }
                    column(CompanyInfoIBANCaption; CompanyInfoIBANCaptionLbl)
                    {
                    }
                    column(CompanyInfoSWIFTCodeCaption; CompanyInfoSWIFTCodeCaptionLbl)
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
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING (Number) WHERE (Number = FILTER (1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(DimensionLoop1Number; Number)
                        {
                        }
                        column(HeaderDimCaption; HeaderDimCaptionLbl)
                        {
                        }



                        trigger OnPreDataItem()
                        begin
                            if not ShowInternalInfo then
                                CurrReport.Break();
                        end;
                    }
                    dataitem("Sales Line"; "Sales Line")
                    {
                        DataItemLink = "Document Type" = FIELD ("Document Type"), "Document No." = FIELD ("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING ("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem()
                        begin
                            CurrReport.Break();
                        end;
                    }
                    dataitem(RoundLoop; "Integer")
                    {
                        DataItemTableView = SORTING (Number);
                        column(TotalWeight; TotalWeight)
                        {
                        }
                        column(PrepLine; "Sales Line"."Ligne deduction acompte")
                        {
                        }
                        column(SalesLineAmt; TempSalesLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TariffNo; TariffNo)
                        {
                        }
                        column(Desc_SalesLine; "Sales Line".Description + ' ' + "Sales Line"."Description 2")
                        {
                        }
                        column(Variante; "Sales Line"."Variant Code")
                        {
                        }
                        column(NNCSalesLineLineAmt; NNCSalesLineLineAmt)
                        {
                        }
                        column(NNCSalesLineInvDiscAmt; NNCSalesLineInvDiscAmt)
                        {
                        }
                        column(NNCTotalLCY; NNCTotalLCY)
                        {
                        }
                        column(NNCTotalExclVAT; NNCTotalExclVAT)
                        {
                        }
                        column(NNCVATAmt; NNCVATAmt)
                        {
                        }
                        column(bExport; BExport)
                        {
                        }
                        column(Compose; Compose)
                        {
                        }
                        column(NNCTotalInclVAT; NNCTotalInclVAT)
                        {
                        }
                        column(NNCPmtDiscOnVAT; NNCPmtDiscOnVAT)
                        {
                        }
                        column(NNCTotalInclVAT2; NNCTotalInclVAT2)
                        {
                        }
                        column(NNCVATAmt2; NNCVATAmt2)
                        {
                        }
                        column(NNCTotalExclVAT2; NNCTotalExclVAT2)
                        {
                        }
                        column(NNCSalesLineEcoAmt; NNCSalesLineEcoAmt)
                        {
                        }
                        column(NNCVATEcoAMt; NNCVATEcoAMt)
                        {
                        }
                        column(VATBaseDisc_SalesHeader; "Sales Header"."VAT Base Discount %")
                        {
                        }
                        column(DisplayAssemblyInfo; DisplayAssemblyInformation)
                        {
                        }
                        column(ShowInternalInformation; ShowInternalInfo)
                        {
                        }
                        column(No2_SalesLine; "Sales Line"."No.")
                        {
                        }
                        column(CrossRef_SalesLine; "Sales Line"."Item Reference No.")
                        {
                        }
                        column(Qty_SalesLine; "Sales Line"."Qty. to Ship (Base)")
                        {
                        }
                        column(UOM_SalesLine; "Sales Line"."Unit of Measure Code")
                        {
                        }
                        column(UnitPrice_SalesLine; "Sales Line"."Unit Price")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 2;
                            IncludeCaption = false;
                        }
                        column(LineDisc_SalesLine; "Sales Line"."Line Discount %")
                        {
                        }
                        column(LineAmt_SalesLine; "Sales Line"."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AllowInvDisc_SalesLine; "Sales Line"."Allow Invoice Disc.")
                        {
                        }
                        column(VATIdentifier_SalesLine; "Sales Line"."VAT Identifier")
                        {
                        }
                        column(Type_SalesLine; Format("Sales Line".Type))
                        {
                        }
                        column(No_SalesLine; "Sales Line"."Line No.")
                        {
                        }
                        column(AllowInvDiscountYesNo_SalesLine; Format("Sales Line"."Allow Invoice Disc."))
                        {
                        }
                        column(AsmInfoExistsForLine; AsmInfoExistsForLine)
                        {
                        }
                        column(SalesLineInvDiscAmt; TempVATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                            IncludeCaption = false;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(SalsLinAmtExclLineDiscAmt; TempSalesLine."Line Amount" - TempVATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(VATAmtLineVATAmtText; TempVATAmountLine.VATAmountText())
                        {
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(VATAmount; VATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLineAmtExclLineDisc; TempSalesLine."Line Amount" - TempVATAmountLine."Invoice Discount Amount" + VATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATDiscountAmount; VATDiscountAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATBaseAmount; VATBaseAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(PaymentDiscountVATCaption; PaymentDiscountVATCaptionLbl)
                        {
                        }
                        column(Desc_SalesLineCaption; "Sales Line".FieldCaption(Description))
                        {
                        }
                        column(No2_SalesLineCaption; "Sales Line".FieldCaption("No."))
                        {
                        }
                        column(Qty_SalesLineCaption; "Sales Line".FieldCaption(Quantity))
                        {
                        }
                        column(UOM_SalesLineCaption; UOM_SalesLineCaptionLbl)
                        {
                        }
                        column(VATIdentifier_SalesLineCaption; "Sales Line".FieldCaption("VAT Identifier"))
                        {
                        }
                        column(SalesLineQuantityCaption; SalesLineQuantityCaptionLbl)
                        {
                        }
                        column(SalesLinePromisedDeliveryDateCaption; SalesLinePromisedDeliveryDateCaptionLbl)
                        {
                        }
                        column(PromisedDeliveryDate_SalesLine; "Sales Line"."Promised Delivery Date")
                        {
                        }
                        column(LinkedNo; "Sales Line"."Linked to line")
                        {
                        }
                        column(SalesLineSubTot; SousTotal)
                        {
                        }
                        column(EcoMob; "Sales Line"."Eco Tax Furniture Line")
                        {
                        }
                        column(RequestedDeliveryDate_SalesLine; "Sales Line"."Requested Delivery Date")
                        {
                        }
                        column(Origine; Origine)
                        {
                        }
                        column(PdsNet; "Sales Line"."Net Weight")
                        {
                        }
                        dataitem(DimensionLoop2; "Integer")
                        {
                            DataItemTableView = SORTING (Number) WHERE (Number = FILTER (1 ..));
                            column(DimText2; DimText)
                            {
                            }
                            column(LineDimCaption; LineDimCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                CurrReport.Break();
                            end;


                        }
                        dataitem(AsmLoop; "Integer")
                        {
                            DataItemTableView = SORTING (Number);
                            column(AsmLineType; AsmLine.Type)
                            {
                            }
                            column(AsmLineNo; BlanksForIndent() + AsmLine."No.")
                            {
                            }
                            column(AsmLineDescription; BlanksForIndent() + AsmLine.Description)
                            {
                            }
                            column(AsmLineQuantity; AsmLine.Quantity)
                            {
                            }
                            column(AsmLineUOMText; GetUnitOfMeasureDescr(AsmLine."Unit of Measure Code"))
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then
                                    AsmLine.FindSet()
                                else
                                    AsmLine.Next();
                            end;

                            trigger OnPreDataItem()
                            begin
                                if not DisplayAssemblyInformation then
                                    CurrReport.Break();
                                if not AsmInfoExistsForLine then
                                    CurrReport.Break();
                                AsmLine.SetRange("Document Type", AsmHeader."Document Type");
                                AsmLine.SetRange("Document No.", AsmHeader."No.");
                                SetRange(Number, 1, AsmLine.Count);
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then
                                TempSalesLine.Find('-')
                            else
                                TempSalesLine.Next();
                            "Sales Line" := TempSalesLine;
                            if DisplayAssemblyInformation then
                                AsmInfoExistsForLine := TempSalesLine.AsmToOrderExists(AsmHeader);

                            if not "Sales Header"."Prices Including VAT" and
                               (TempSalesLine."VAT Calculation Type" = TempSalesLine."VAT Calculation Type"::"Full VAT")
                            then
                                TempSalesLine."Line Amount" := 0;

                            if (TempSalesLine.Type = TempSalesLine.Type::"G/L Account") and (not ShowInternalInfo) then
                                "Sales Line"."No." := '';

                            if (TempSalesLine.Type = TempSalesLine.Type::Item) and (TempSalesLine."No." <> '') then begin
                                RecItem.Get(TempSalesLine."No.");
                                TariffNo := RecItem."Tariff No.";
                                Origine := TempSalesLine."Country/Region of Origin Code";
                            end else begin
                                TariffNo := '';
                                Origine := '';
                            end;

                            SousTotal := (TempSalesLine."Type ligne" = TempSalesLine."Type ligne"::"Fin total");

                            if not TempSalesLine."Eco Tax Furniture Line" then
                                NNCSalesLineLineAmt += TempSalesLine."Line Amount" //;
                            else begin
                                NNCSalesLineEcoAmt += TempSalesLine."Line Amount";
                                NNCVATEcoAMt += TempSalesLine."Amount Including VAT" - TempSalesLine."Line Amount";
                                //MESSAGE('%1',NNCSalesLineEcoAmt);
                            end;
                            //DIA£NBE 17/02/2015 DEBUT


                            //DIA£LBO 06/12/2017

                            SalesCompLine.SetRange("Document Type", TempSalesLine."Document Type");
                            SalesCompLine.SetRange("Document No.", TempSalesLine."Document No.");
                            SalesCompLine.SetRange("Linked to line", TempSalesLine."Line No.");
                            Compose := SalesCompLine.FindFirst();
                            if Compose then 
                                TariffNo := ''
                            else
                                if TempSalesLine."Linked to line" <> 0 then
                                    "Sales Line"."Item Reference No." := '';

                            TotalWeight += TempSalesLine."Net Weight" * TempSalesLine.Quantity;


                            NNCSalesLineInvDiscAmt += TempSalesLine."Inv. Discount Amount";

                            NNCTotalLCY := NNCSalesLineLineAmt - NNCSalesLineInvDiscAmt;

                            NNCTotalExclVAT := NNCTotalLCY;
                            NNCVATAmt := VATAmount - NNCVATEcoAMt;
                            NNCTotalInclVAT := NNCTotalLCY - NNCVATAmt;

                            NNCPmtDiscOnVAT := -VATDiscountAmount;

                            NNCTotalInclVAT2 := TotalAmountInclVAT;

                            NNCVATAmt2 := VATAmount - NNCVATEcoAMt;
                            NNCTotalExclVAT2 := VATBaseAmount;
                        end;

                        trigger OnPostDataItem()
                        begin
                            TempSalesLine.DeleteAll();
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := TempSalesLine.Find('+');
                            while MoreLines and (TempSalesLine.Description = '') and (TempSalesLine."Description 2" = '') and
                                  (TempSalesLine."No." = '') and (TempSalesLine.Quantity = 0) and
                                  (TempSalesLine.Amount = 0)
                            do
                                MoreLines := TempSalesLine.Next(-1) <> 0;
                            if not MoreLines then
                                CurrReport.Break();
                            TempSalesLine.SetRange("Line No.", 0, TempSalesLine."Line No.");
                            SetRange(Number, 1, TempSalesLine.Count);
                            CurrReport.CreateTotals(TempSalesLine."Line Amount", TempSalesLine."Inv. Discount Amount");
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING (Number);
                        column(VATAmountLineVATBase; TempVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; TempVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; TempVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscAmt; TempVATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATPercentage; TempVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier; TempVATAmountLine."VAT Identifier")
                        {
                        }
                        column(InvDiscBaseAmtCaption; InvDiscBaseAmtCaptionLbl)
                        {
                        }
                        column(VATIdentifierCaption; VATIdentifierCaptionLbl)
                        {
                        }
                        column(VATAmountLineCOUNT; TempVATAmountLine.Count)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            if VATAmount = 0 then
                                CurrReport.Break();
                            SetRange(Number, 1, TempVATAmountLine.Count);
                            CurrReport.CreateTotals(
                              TempVATAmountLine."Line Amount", TempVATAmountLine."Inv. Disc. Base Amount",
                              TempVATAmountLine."Invoice Discount Amount", TempVATAmountLine."VAT Base", TempVATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VATCounterLCY; "Integer")
                    {
                        DataItemTableView = SORTING (Number);
                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
                        {
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATPercentage2; TempVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier2; TempVATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);

                            VALVATBaseLCY := Round(CurrExchRate.ExchangeAmtFCYToLCY(
                                  "Sales Header"."Posting Date", "Sales Header"."Currency Code",
                                  TempVATAmountLine."VAT Base", "Sales Header"."Currency Factor"));
                            VALVATAmountLCY := Round(CurrExchRate.ExchangeAmtFCYToLCY(
                                  "Sales Header"."Posting Date", "Sales Header"."Currency Code",
                                  TempVATAmountLine."VAT Amount", "Sales Header"."Currency Factor"));
                        end;

                        trigger OnPreDataItem()
                        begin
                            if (not GLSetup."Print VAT specification in LCY") or
                               ("Sales Header"."Currency Code" = '') or
                               (TempVATAmountLine.GetTotalVATAmount() = 0)
                            then
                                CurrReport.Break();

                            SetRange(Number, 1, TempVATAmountLine.Count);
                            CurrReport.CreateTotals(VALVATBaseLCY, VALVATAmountLCY);

                            if GLSetup."LCY Code" = '' then
                                VALSpecLCYHeader := Text007Lbl + Text008Lbl
                            else
                                VALSpecLCYHeader := Text007Lbl + Format(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Sales Header"."Posting Date", "Sales Header"."Currency Code", 1);
                            VALExchRate := StrSubstNo(Text009Lbl, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(PrepmtLoop; "Integer")
                    {
                        DataItemTableView = SORTING (Number) WHERE (Number = FILTER (1 ..));
                        column(PrepmtLineAmount; PrepmtLineAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtInvBufDesc; TempPrepmtInvBuf.Description)
                        {
                        }
                        column(PrepmtInvBufGLAccNo; TempPrepmtInvBuf."G/L Account No.")
                        {
                        }
                        column(TotalExclVATText2; TotalExclVATText)
                        {
                        }
                        column(PrepmtVATAmtLineVATAmtTxt; TempPrepmtVATAmountLine.VATAmountText())
                        {
                        }
                        column(TotalInclVATText2; TotalInclVATText)
                        {
                        }
                        column(PrepmtInvAmount; TempPrepmtInvBuf.Amount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmount; PrepmtVATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtInvAmtInclVATAmt; TempPrepmtInvBuf.Amount + PrepmtVATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtText2; TempVATAmountLine.VATAmountText())
                        {
                        }
                        column(PrepmtTotalAmountInclVAT; PrepmtTotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATBaseAmount; PrepmtVATBaseAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtLoopNumber; Number)
                        {
                        }
                        column(DescriptionCaption; DescriptionCaptionLbl)
                        {
                        }
                        column(GLAccountNoCaption; GLAccountNoCaptionLbl)
                        {
                        }
                        column(PrepaymentSpecCaption; PrepaymentSpecCaptionLbl)
                        {
                        }
                        dataitem(PrepmtDimLoop; "Integer")
                        {
                            DataItemTableView = SORTING (Number) WHERE (Number = FILTER (1 ..));
                            column(DimText3; DimText)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                        CurrReport.Break();

                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then begin
                                if not TempPrepmtInvBuf.Find('-') then
                                    CurrReport.Break();
                            end else
                                if TempPrepmtInvBuf.Next() = 0 then
                                    CurrReport.Break();

                            if ShowInternalInfo then
                                DimMgt.GetDimensionSet(TempPrepmtDimSetEntry, TempPrepmtInvBuf."Dimension Set ID");

                            if "Sales Header"."Prices Including VAT" then
                                PrepmtLineAmount := TempPrepmtInvBuf."Amount Incl. VAT"
                            else
                                PrepmtLineAmount := TempPrepmtInvBuf.Amount;
                        end;

                        trigger OnPreDataItem()
                        begin
                            CurrReport.CreateTotals(
                              TempPrepmtInvBuf.Amount, TempPrepmtInvBuf."Amount Incl. VAT",
                              TempPrepmtVATAmountLine."Line Amount", TempPrepmtVATAmountLine."VAT Base",
                              TempPrepmtVATAmountLine."VAT Amount",
                              PrepmtLineAmount);
                        end;
                    }
                    dataitem(PrepmtVATCounter; "Integer")
                    {
                        DataItemTableView = SORTING (Number);
                        column(PrepmtVATAmtLineVATAmt; TempPrepmtVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineVATBase; TempPrepmtVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineLineAmt; TempPrepmtVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineVATPerc; TempPrepmtVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(PrepmtVATAmtLineVATIdent; TempPrepmtVATAmountLine."VAT Identifier")
                        {
                        }
                        column(PrepmtVATCounterNumber; Number)
                        {
                        }
                        column(PrepaymentVATAmtSpecCap; PrepaymentVATAmtSpecCapLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            TempPrepmtVATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            SetRange(Number, 1, TempPrepmtVATAmountLine.Count);
                        end;
                    }
                    dataitem(PrepmtTotal; "Integer")
                    {
                        DataItemTableView = SORTING (Number) WHERE (Number = CONST (1));
                        column(PrepmtPmtTermsDesc; PrepmtPaymentTerms.Description)
                        {
                        }
                        column(PrepmtPmtTermsDescCaption; PrepmtPmtTermsDescCaptionLbl)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            if not TempPrepmtInvBuf.Find('-') then
                                CurrReport.Break();
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                var
                    TempPrepmtSalesLine: Record "Sales Line" temporary;
                    TempSalesLine: Record "Sales Line" temporary;
                    TempSalesLineDisc: Record "Sales Line" temporary;
                    SalesPost: Codeunit "Sales-Post";
                begin
                    Clear(TempSalesLine);
                    Clear(SalesPost);
                    Clear(TempSalesLineDisc);
                    TempVATAmountLine.DeleteAll();
                    TempSalesLine.DeleteAll();
                    TempSalesLineDisc.DeleteAll();
                    SalesPost.GetSalesLines("Sales Header", TempSalesLine, 0);
                    TempSalesLine.CalcVATAmountLines(0, "Sales Header", TempSalesLine, TempVATAmountLine);
                    TempSalesLine.UpdateVATOnLines(0, "Sales Header", TempSalesLine, TempVATAmountLine);
                    SalesPost.GetSalesLines("Sales Header", TempSalesLineDisc, 1);
                    TempSalesLineDisc.CalcVATAmountLines(1, "Sales Header", TempSalesLineDisc, TempVATAmountLine);
                    TempSalesLineDisc.UpdateVATOnLines(1, "Sales Header", TempSalesLineDisc, TempVATAmountLine);
                    TempSalesLine."Inv. Discount Amount" := TempVATAmountLine."Invoice Discount Amount";
                    VATAmount := TempVATAmountLine.GetTotalVATAmount();
                    VATBaseAmount := TempVATAmountLine.GetTotalVATBase();
                    VATDiscountAmount :=
                      TempVATAmountLine.GetTotalVATDiscount("Sales Header"."Currency Code", "Sales Header"."Prices Including VAT");
                    TotalAmountInclVAT := TempVATAmountLine.GetTotalAmountInclVAT();

                    TempPrepmtInvBuf.DeleteAll();
                    SalesPostPrepmt.GetSalesLines("Sales Header", 0, TempPrepmtSalesLine);

                    if not TempPrepmtSalesLine.IsEmpty then begin
                        SalesPostPrepmt.GetSalesLinesToDeduct("Sales Header", TempSalesLine);
                        if not TempSalesLine.IsEmpty then
                            SalesPostPrepmt.CalcVATAmountLines("Sales Header", TempSalesLine, TempPrepmtVATAmountLineDeduct, 1);
                    end;
                    SalesPostPrepmt.CalcVATAmountLines("Sales Header", TempPrepmtSalesLine, TempPrepmtVATAmountLine, 0);
                    if TempPrepmtVATAmountLine.FindSet() then
                        repeat
                            TempPrepmtVATAmountLineDeduct := TempPrepmtVATAmountLine;
                            if TempPrepmtVATAmountLineDeduct.Find() then begin
                                TempPrepmtVATAmountLine."VAT Base" := TempPrepmtVATAmountLine."VAT Base" - TempPrepmtVATAmountLineDeduct."VAT Base";
                                TempPrepmtVATAmountLine."VAT Amount" := TempPrepmtVATAmountLine."VAT Amount" - TempPrepmtVATAmountLineDeduct."VAT Amount";
                                TempPrepmtVATAmountLine."Amount Including VAT" := TempPrepmtVATAmountLine."Amount Including VAT" -
                                  TempPrepmtVATAmountLineDeduct."Amount Including VAT";
                                TempPrepmtVATAmountLine."Line Amount" := TempPrepmtVATAmountLine."Line Amount" - TempPrepmtVATAmountLineDeduct."Line Amount";
                                TempPrepmtVATAmountLine."Inv. Disc. Base Amount" := TempPrepmtVATAmountLine."Inv. Disc. Base Amount" -
                                  TempPrepmtVATAmountLineDeduct."Inv. Disc. Base Amount";
                                TempPrepmtVATAmountLine."Invoice Discount Amount" := TempPrepmtVATAmountLine."Invoice Discount Amount" -
                                  TempPrepmtVATAmountLineDeduct."Invoice Discount Amount";
                                TempPrepmtVATAmountLine."Calculated VAT Amount" := TempPrepmtVATAmountLine."Calculated VAT Amount" -
                                  TempPrepmtVATAmountLineDeduct."Calculated VAT Amount";
                                TempPrepmtVATAmountLine.Modify();
                            end;
                        until TempPrepmtVATAmountLine.Next() = 0;

                    /* Migration FHA pas sur qu'on ait besoin de ce code qui ne se compile pas
                    SalesPostPrepmt.UpdateVATOnLines("Sales Header", PrepmtSalesLine, TempPrepmtVATAmountLine, 0);
                    SalesPostPrepmt.BuildInvLineBuffer2("Sales Header", PrepmtSalesLine, 0, TempPrepmtInvBuf);
                    PrepmtVATAmount := TempPrepmtVATAmountLine.GetTotalVATAmount;
                    PrepmtVATBaseAmount := TempPrepmtVATAmountLine.GetTotalVATBase;
                    PrepmtTotalAmountInclVAT := TempPrepmtVATAmountLine.GetTotalAmountInclVAT;
                    */

                    if Number > 1 then 
                        OutputNo += 1;

                    NNCTotalLCY := 0;
                    NNCTotalExclVAT := 0;
                    NNCVATAmt := 0;
                    NNCTotalInclVAT := 0;
                    NNCPmtDiscOnVAT := 0;
                    NNCTotalInclVAT2 := 0;
                    NNCVATAmt2 := 0;
                    NNCTotalExclVAT2 := 0;
                    NNCSalesLineLineAmt := 0;
                    NNCSalesLineInvDiscAmt := 0;
                    NNCSalesLineEcoAmt := 0;
                    TotalWeight := 0;
                    NNCVATEcoAMt := 0;
                end;

                trigger OnPostDataItem()
                begin
                    if Print then
                        SalesCountPrinted.Run("Sales Header");
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
                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture);
                CurrReport.Language := LanguageMgt.GetLanguageID("Language Code");

                if RespCenter.Get("Responsibility Center") then begin
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                end else
                    FormatAddr.Company(CompanyAddr, CompanyInfo);

                DimSetEntry1.SetRange("Dimension Set ID", "Dimension Set ID");

                if "Salesperson Code" = '' then begin
                    Clear(SalesPurchPerson);
                    SalesPersonText := '';
                end else begin
                    SalesPurchPerson.Get("Salesperson Code");
                    SalesPersonText := Text000Lbl;
                end;

                //-DIA@FHA 09/04/2014 Je fais en sorte que les captions ne soient jamais vides pour ne pas avoir de lignes blanches sur le papier
                ReferenceText := CopyStr(FieldCaption("Your Reference"),1,80);

                VATNoText := copystr(FieldCaption("VAT Registration No."),1,80);
                //+DIA@FHA 09/04/2014

                //DIA£LBO 06/12/2017
                if Country.Get("Ship-to Country/Region Code") and ("Ship-to Country/Region Code" <> CompanyInfo."Country/Region Code") and (Country."EU Country/Region Code" = '') then
                    BExport := true
                else
                    BExport := false;
                //DIA£LBO 06/12/2017//

                recDimValue.SetRange("Global Dimension No.", 2);
                recDimValue.SetRange(Code, "Sales Header"."Shortcut Dimension 2 Code");
                if recDimValue.FindSet() then
                    JobName := recDimValue.Name
                else
                    JobName := '';
                if RecDimSetEntry.Get("Sales Header"."Dimension Set ID", GLSetup."Shortcut Dimension 3 Code") then begin
                    RecDimSetEntry.CalcFields("Dimension Value Name");
                    SiteName := RecDimSetEntry."Dimension Value Name";
                end else
                    SiteName := '';

                if "Currency Code" = '' then begin
                    GLSetup.TestField("LCY Code");
                    TotalText := StrSubstNo(Text001Lbl, GLSetup."LCY Code");
                    TotalInclVATText := StrSubstNo(Text002Lbl, GLSetup."LCY Code");
                    TotalExclVATText := StrSubstNo(Text006Lbl, GLSetup."LCY Code");
                    CurrencyCode := GLSetup."LCY Code";
                end else begin
                    TotalText := StrSubstNo(Text001Lbl, "Currency Code");
                    TotalInclVATText := StrSubstNo(Text002Lbl, "Currency Code");
                    TotalExclVATText := StrSubstNo(Text006Lbl, "Currency Code");
                    CurrencyCode := "Currency Code";
                end;

                FormatAddr.SalesHeaderSellTo(CustAddr, "Sales Header");

                FormatAddr.SalesHeaderBillTo(BillToAddr, "Sales Header");
                if not PaymentMethod.Get("Payment Method Code") then
                    PaymentMethod.Init();

                if not ShippingAgent.Get("Sales Header"."Shipping Agent Code") then
                    ShippingAgent.Init();

                if "Payment Terms Code" = '' then
                    PaymentTerms.Init()
                else begin
                    PaymentTerms.Get("Payment Terms Code");
                    PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
                end;
                if "Prepmt. Payment Terms Code" = '' then
                    PrepmtPaymentTerms.Init()
                else begin
                    PrepmtPaymentTerms.Get("Prepmt. Payment Terms Code");
                    PrepmtPaymentTerms.TranslateDescription(PrepmtPaymentTerms, "Language Code");
                end;
                if "Prepmt. Payment Terms Code" = '' then
                    PrepmtPaymentTerms.Init()
                else begin
                    PrepmtPaymentTerms.Get("Prepmt. Payment Terms Code");
                    PrepmtPaymentTerms.TranslateDescription(PrepmtPaymentTerms, "Language Code");
                end;
                if "Shipment Method Code" = '' then
                    ShipmentMethod.Init()
                else begin
                    ShipmentMethod.Get("Shipment Method Code");
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Language Code");
                end;

                //Migration : var inutilisée ?? ShowShippingAddr := true;

                FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr,"Sales Header");
                /*Migration : var inutilisée ??
                //ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                for i := 1 to ArrayLen(ShipToAddr) do 
                    if ShipToAddr[i] <> CustAddr[i] then
                        ShowShippingAddr := true;
                */

                if Print then begin
                    if ArchiveDocument then
                        ArchiveManagement.StoreSalesDocument("Sales Header", LogInteraction);

                    if LogInteraction then begin
                        CalcFields("No. of Archived Versions");
                        if "Bill-to Contact No." <> '' then
                            SegManagement.LogDocument(
                              3, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", DATABASE::Contact, "Bill-to Contact No."
                              , "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.")
                        else
                            SegManagement.LogDocument(
                              3, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", DATABASE::Customer, "Bill-to Customer No.",
                              "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.");
                    end;
                end;

                //>>DIA@NDE 19/02/15
                //DIA£LBO 15/12/2017 TotalWeight:="Sales Header"."Total Net Weight";
                //<<DIA@NDE
            end;

            trigger OnPreDataItem()
            begin
                Print := Print;//OR NOT CurrReport.PREVIEW;
                AsmInfoExistsForLine := false;
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
                    field(NumberOfCopies; NoOfCopies)
                    {
                        Caption = 'Nombre de copies';
                        ToolTip = 'Nombre de copies';
                    }
                    field(ShowInternalInformation; ShowInternalInfo)
                    {
                        Caption = 'Afficher infos. internes';
                        ToolTip = 'Afficher infos. internes';
                        Visible = false;
                    }
                    field(ArchiveDocumentField; ArchiveDocument)
                    {
                        Caption = 'Archiver document';
                        ToolTip = 'Archiver document';
                        Visible = false;

                        trigger OnValidate()
                        begin
                            if not ArchiveDocument then
                                LogInteraction := false;
                        end;
                    }
                    field(LogInteractionField; LogInteraction)
                    {
                        Caption = 'Créer interaction';
                        ToolTip = 'Créer interaction';
                        Enabled = LogInteractionEnable;

                        trigger OnValidate()
                        begin
                            if LogInteraction then
                                ArchiveDocument := ArchiveDocumentEnable;
                        end;
                    }
                    field(ShowAssemblyComponents; DisplayAssemblyInformation)
                    {
                        Caption = 'Afficher composants assemblage';
                        ToolTip = 'Afficher composants assemblage';
                        Visible = false;
                    }
                }
            }
        }

        actions
        {
        }




    }

    labels
    {
        FooterTextLine1 = 'TVA acquittée sur les débits - Exonération de TVA, art 262 ter-1 du CGI - TVA non applicable art 293B du CGI.';
        FooterTextLine2 = 'En cas de retard de paiement, le taux ne peut en aucun cas être inférieur à 1,5 fois le taux légal Art L 441-6 du code du commerce. Les pénalités de retard sont';
        FooterTextLine3 = 'exigibles sans rappel préalable. Le montant de l''indemnité forfaitaire pour frais de recouvrement due au créancier en cas de retard de paiement, conformément';
        FooterTextLine4 = 'à l''article 121-II de la loi n° 2012-387 du 22 mars 2012 est fixée à 40 € par le décret n° 2012-115 du 2 octobre 2012.';
        FooterTextLine5 = 'Réserve de propriété : nous nous réservons la propriété des marchandises jusqu''au paiement du prix complet par l''acheteur. Notre revendication porte aussi bien sur';
        FooterTextLine6 = 'les marchandises que sur leur prix si elles ont déjà été revendues (loi du 12 mai 1980).';
        FooterTextLine7 = 'Le client est réputé accepter nos conditions de vente disponibles sur simple demande.';
    }

    trigger OnInitReport()
    begin
        GLSetup.Get();

        SalesSetup.Get();
    end;

    var
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PrepmtPaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        CurrExchRate: Record "Currency Exchange Rate";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        TempPrepmtVATAmountLine: Record "VAT Amount Line" temporary;
        TempPrepmtVATAmountLineDeduct: Record "VAT Amount Line" temporary;
        TempSalesLine: Record "Sales Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        TempPrepmtDimSetEntry: Record "Dimension Set Entry" temporary;
        TempPrepmtInvBuf: Record "Prepayment Inv. Line Buffer" temporary;
        RespCenter: Record "Responsibility Center";
        AsmHeader: Record "Assembly Header";
        AsmLine: Record "Assembly Line";
        RecItem: Record Item;
        ShippingAgent: Record "Shipping Agent";
        recDimValue: Record "Dimension Value";
        RecDimSetEntry: Record "Dimension Set Entry";
        Country: Record "Country/Region";
        SalesCompLine: Record "Sales Line";
        LanguageMgt: Codeunit Language;
        SalesCountPrinted: Codeunit "Sales-Printed";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        ArchiveManagement: Codeunit ArchiveManagement;
        SalesPostPrepmt: Codeunit "Sales-Post Prepayments";
        DimMgt: Codeunit DimensionManagement;
        CustAddr: array[8] of Text[50];
        BillToAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        SalesPersonText: Text[30];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        DimText: Text[120];
        ShowInternalInfo: Boolean;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        PrepmtVATAmount: Decimal;
        PrepmtVATBaseAmount: Decimal;
        PrepmtTotalAmountInclVAT: Decimal;
        PrepmtLineAmount: Decimal;
        OutputNo: Integer;
        NNCTotalLCY: Decimal;
        NNCTotalExclVAT: Decimal;
        NNCVATAmt: Decimal;
        NNCTotalInclVAT: Decimal;
        NNCPmtDiscOnVAT: Decimal;
        NNCTotalInclVAT2: Decimal;
        NNCVATAmt2: Decimal;
        NNCTotalExclVAT2: Decimal;
        NNCSalesLineLineAmt: Decimal;
        NNCSalesLineInvDiscAmt: Decimal;
        Print: Boolean;
        ArchiveDocumentEnable: Boolean;
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        AsmInfoExistsForLine: Boolean;
        
        JobName: Text[50];
        
        NNCSalesLineEcoAmt: Decimal;
        NNCVATEcoAMt: Decimal;
        TotalWeight: Decimal;
        
        TariffNo: Code[30];
        Text000Lbl: Label 'Vendeur';
        Text001Lbl: Label 'Total %1',Comment = '%1 = Total';
        Text002Lbl: Label 'Total %1 TTC',Comment = '%1 = Total TTC';
        Text004Lbl: Label 'N° commande colisage';
        Text005Lbl: Label 'Page ';
        Text006Lbl: Label 'Total %1 H.T.',Comment = '%1 = Total HT';
        Text007Lbl: Label 'VAT Amount Specification in ';
        Text008Lbl: Label 'Devise locale';
        Text009Lbl: Label 'Taux de change : %1/%2',Comment = '%1 = Devise 1 %2 = Devise 2';
        InvDiscAmtCaptionLbl: Label 'Montant remise facture';
        VATRegNoCaptionLbl: Label 'N° ident. intracom.';
        SalesHeaderNoCaptionLbl: Label 'No.';
        HomePageCaptionLbl: Label 'Home Page';
        EmailCaptionLbl: Label 'E-Mail';
        HeaderDimCaptionLbl: Label 'Header Dimensions';
        DiscountPercentCaptionLbl: Label 'Disc. %';
        SubtotalCaptionLbl: Label 'Subtotal';
        PaymentDiscountVATCaptionLbl: Label 'Payment Discount on VAT';
        LineDimCaptionLbl: Label 'Line Dimensions';
        InvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount';
        VATIdentifierCaptionLbl: Label 'VAT Identifier';
        ShiptoAddrCaptionLbl: Label 'Ship-to Address';
        BilltoAddrCaptionLbl: Label 'Sell-To Address';
        DescriptionCaptionLbl: Label 'Description';
        GLAccountNoCaptionLbl: Label 'G/L Account No.';
        PrepaymentSpecCaptionLbl: Label 'Prepayment Specification';
        PrepaymentVATAmtSpecCapLbl: Label 'Prepayment VAT Amount Specification';
        PrepmtPmtTermsDescCaptionLbl: Label 'Prepmt. Payment Terms';
        PhoneNoCaptionLbl: Label 'Phone No.';
        AmountCaptionLbl: Label 'Amount';
        VATPercentageCaptionLbl: Label 'VAT %';
        VATBaseCaptionLbl: Label 'VAT Base';
        VATAmtCaptionLbl: Label 'VAT Amount';
        VATAmtSpecCaptionLbl: Label 'VAT Amount Specification';
        LineAmtCaptionLbl: Label 'Line Amount';
        TotalCaptionLbl: Label 'Total';
        UnitPriceCaptionLbl: Label 'Unit Price';
        PaymentTermsCaptionLbl: Label 'Payment Terms';
        ShipmentMethodCaptionLbl: Label 'Incoterm :';
        PaymentCaptionLbl: Label 'Payment :';
        ShippingAgentCaptionLbl: Label 'Shipping Agent :';
        AllowInvDiscCaptionLbl: Label 'Allow Invoice Discount';
        CompanyInfoPhoneNoCaptionLbl: Label 'Phone No.';
        CompanyInfoFaxNoCaptionLbl: Label 'Fax No.';
        ContactCaptionLbl: Label 'For the attention of ';
        CompanyInfoStockCapitalCaptionLbl: Label 'with a capital of';
        CompanyInfoAPECodeCaptionLbl: Label 'NAF Code';
        CompanyInfoIBANCaptionLbl: Label 'IBAN';
        CompanyInfoSWIFTCodeCaptionLbl: Label 'SWIFT Code';
        SalesLineQuantityCaptionLbl: Label 'Qty';
        UOM_SalesLineCaptionLbl: Label 'UOM';
        CompanyInfoNameCaptionLbl: Label 'Siège social';
        SelltoCustNoCaptionLbl: Label 'Customer No.';
        ThankYouCaptionLbl: Label 'Thank you for your order. We are pleased to confirm following conditions :';
        DearSirMadamCaptionLbl: Label 'Dear Sir/Madam,';
        SalesHeaderQuoteNoCaptionLbl: Label 'Quote No. :';
        SalesLinePromisedDeliveryDateCaptionLbl: Label 'Deliv.';
        SalesHeaderOrderDateCaptionLbl: Label 'Date :';
        SalesPersonMailCaptionLbl: Label 'E-mail';
        LabelAffaireLbl: Label 'Affaire :';
        LabelNoLocationNameLbl: Label 'N° et nom Magasin :';
        LabelNoRayonLbl: Label 'N° de rayon : ';
        LabelInterlocuteurclientLbl: Label 'Interlocuteur client :';
        LabelCommentraireLbl: Label 'Commentaires : ';
        LabelShipmentDateLbl: Label 'Date de livraison :';
        LabelEcoTaxLbl: Label 'Eco taxe mobilier';
        LabelNetaPayerLbl: Label 'Net à payer';
        LabelRefClientLbl: Label 'Référence client';
        LabelDescriptionLbl: Label 'Description';
        LabelQuantiteLblLbl: Label 'Qté';
        LabelEcoTaxTextLbl: Label 'TVA sur Eco Taxe';
        LabellTotalWeightLbl: Label 'Poids net total:';
        LabelTariffLbl: Label 'Code douanier';
        LabelMarchandiseLbl: Label 'Information sur la marchandise';
        LabelPaletteLbl: Label 'Nombre de palettes :';
        LabelOrgMseLbl: Label 'Origine marchandise :';
        LabelPaysLbl: Label 'Pays exportateur :';
        LabelExpDateLbl: Label 'Date d''expédition:';
        LabelCurrencyLbl: Label 'Devis :';
        LabelSiteLbl: Label 'Site :';
        LabelOrderLbl: Label 'N° commande :';
        LabelTotalGrossWeightLbl: Label 'Poids brut total :';
        LabelCustOrderLbl: Label 'N° de commande client :';
        LabelDevisLbl: Label 'N° devis :';
        LabelUnitCaptionLbl: Label 'Unité';
        LabelDuedateLbl: Label 'Date d''échéance';
        LabelPackageLbl: Label 'Nombre de colis:';
        CurrencyCode: Code[10];
        SiteName: Text[50];
        
        labelVariantLbl: Label 'Variante';

        BExport: Boolean;
        
        Compose: Boolean;
        labelOrigineLbl: Label 'Origine';
        labelWeightLbl: Label 'Poids/U (Klg)';
        Origine: Text;
        SousTotal: Boolean;

    procedure InitializeRequest(NoOfCopiesFrom: Integer; ShowInternalInfoFrom: Boolean; ArchiveDocumentFrom: Boolean; LogInteractionFrom: Boolean; PrintFrom: Boolean; DisplayAsmInfo: Boolean)
    begin
        NoOfCopies := NoOfCopiesFrom;
        ShowInternalInfo := ShowInternalInfoFrom;
        ArchiveDocument := ArchiveDocumentFrom;
        LogInteraction := LogInteractionFrom;
        Print := PrintFrom;
        DisplayAssemblyInformation := DisplayAsmInfo;
    end;

    procedure GetUnitOfMeasureDescr(UOMCode: Code[10]): Text[10]
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        if not UnitOfMeasure.Get(UOMCode) then
            exit(UOMCode);
        exit(Copystr(UnitOfMeasure.Description,1,10));
    end;

    procedure BlanksForIndent(): Text[10]
    begin
        exit(PadStr('', 2, ' '));
    end;

    procedure SalesPurchPerson_PhoneNoEmail() PhoneNoEmail: Text[1024]
    begin
        //with SalesPurchPerson do begin
            Clear(PhoneNoEmail);
            PhoneNoEmail := SalesPurchPerson."Phone No.";
            if SalesPurchPerson."E-Mail" <> '' then begin
                if PhoneNoEmail <> '' then
                    PhoneNoEmail := copystr(PhoneNoEmail + ' / ',1,1024);
                PhoneNoEmail := copystr(PhoneNoEmail + SalesPurchPerson."E-Mail",1,1024)
            end;
        //end;
    end;
}

