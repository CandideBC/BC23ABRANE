report 50005 "ABRANE : Sales - Order"
{
    RDLCLayout = './src/ReportLayout/ABRANESalesOrder.rdlc';

    Caption = 'Commande vente';

    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = const(Order));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Devis vente';
            column(DocType_SalesHeader; "Document Type")
            {
            }
            column(No_SalesHeader; "No.")
            {
            }

            column(PhaseCaption; PhaseLbl)
            {
            }

            column(Phase_SalesHeader; Phase)
            {
            }
            column(VersionCaption; VersionLbl)
            {
            }
            column(VersionDate_SalesHeader; DateDernArchive)
            {
            }
            column(NoVersion_SalesHeader; NoVersionDernArchive)
            {
            }
            column(CondPaiementSituationTxt; CondPaiementSituationTxt)
            {
            }
            column(BankDetailsLbl; BankDetailsLbl)
            {

            }
            column(MentionsLegalesLbl; MentionsLegalesLbl)
            {
                
            }
            //column(InfosPaiement1; InfosPaiement1)
            //{
            //}
            column(InfosPaiement2; InfosPaiement2)
            {
            }
            column(SelltoCustNoCaption; SelltoCustNoCaptionLbl)
            {
            }
            column(DiscountPercentCaption; DiscountPercentCaptionLbl)
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
            column(DateChargement_SalesHeader; "Date chargement")
            {
            }
            column(ExternalDocumentNo_SalesHeader; "External Document No.")
            {
            }
            column(SellToContact_SalesHeader; "Sell-to Contact")
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

            column(txtAcceptationDevis; AcceptationDevisTxt)
            {
            }
            column(OrderDate_SalesHeader; "Order Date")
            {
            }
            column(JobName_SalesHeader; JobName)
            {
            }
            column(RequestedDeliveryDate; "Requested Delivery Date")
            {
            }
            column(Comments_SalesHeader; Commentaire)
            {
            }
            
            column(MontantDejaVerse; "Montant deja verse TTC")
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
            column(LabelAffaire; AffaireLbl)
            {
            }
            column(LabelSite; SiteLbl)
            {
            }
            column(LabelPackage; PackageLbl)
            {
            }
            column(SiteName; SiteName)
            {
            }
            column(LabelNoLocationName; NoLocationNameLbl)
            {
            }
            column(LabelNoRayon; NoRayonLbl)
            {
            }
            column(LabelInterlocuteurclient; InterlocuteurclientLbl)
            {
            }
            column(LabelCommentaire; CommentaireLbl)
            {
            }
            column(LabelShipmentDate; RequestedDeliveryDateLbl)
            {
            }
            column(DateChargementLbl; DateChargementLbl)
            {
            }
            column(LabelEcoTax; EcoTaxLbl)
            {
            }
            column(LabelMontantRemisesLignes; MontantRemisesLignesLbl)
            {
                
            }
            column(LabelTotalHTDontEcoContrib; txtTotalHT)
            {
            }
            column(LabelRefClient; RefClientLbl)
            {
            }
            column(LabelDescription; DescriptionLbl)
            {
            }
            column(LabelQuantite; QuantiteLbl)
            {
            }
            column(LabelAgreement; AgreementLbl)
            {
            }
            column(LabelPays; PaysLbl)
            {
            }
            column(LabelTotalGrossWeight; TotalGrossWeightLbl)
            {
            }
            column(LabelMarchandise; MarchandiseLbl)
            {
            }
            column(LabelPalette; PaletteLbl)
            {
            }
            column(LabelOrgMse; OrgMseLbl)
            {
            }
            column(ExternalDocNoLbl; ExternalDocNoLbl)
            {
            }
            column(LabelCurrency; CurrencyLbl)
            {
            }
            column(PackageNumber; "Nombre de colis")
            {
            }
            column(PalletNumber; "Nombre de palettes")
            {
            }
            column(TotalGrossWeight; "Poids brut total")
            {
            }
            column(QuoteValidityCaption; QuoteValidityCaptionLbl)
            {
            }
            column(QuoteAgreementLine1Caption; QuoteAgreementLine1CaptionLbl)
            {
            }
            column(LabelUnitCaption; UnitCaptionLbl)
            {
            }
            column(QuoteAgreementLine2Caption; QuoteAgreementLine2CaptionLbl)
            {
            }
            column(TexteTVA; TexteTVA)
            {
            }
            column(TextePenalitesRetard; TextePenalitesRetard)
            {
                
            }
            column(LabelEscompte; EscompteLbl)
            {
            }
            column(LabelAcompteverse; AcompteVerseLbl)
            {
            }
            column(LabelMontantDejaVerse; MontantDejaVerseLbl)
            {
            }
            column(LabelResteAPayer; ResteAPayerLbl)
            {
            }
            column(labelVariant; VariantLbl)
            {
            }
            column(AcompteLbl; AcompteLbl)
            {
            }
            column(SituationLbl; SituationLbl)
            {
            }
            column(SoldeLbl; SoldeLbl)
            {
            }
            column(CondPaiementAcompteTxt; CondPaiementAcompteTxt)
            {
            }
            column(ClientFrancais; ClientFrancais)
            {
            }
            column(CondPaiementSoldeTxt; CondPaiementSoldeTxt)
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
                    column(NumRegistreProducteurs; CompanyInfo."No. registre producteurs")
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
                    column(PageCaption; StrSubstNo(Text005Lbl, ''))
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PaymentTermsDescription; PaymentTerms.Description)
                    {
                    }
                    column(PaymentMethodDescription; txtPaymentMethodDescription)
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
                        DataItemTableView = sorting(Number) where(Number = filter(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(DimensionLoop1Number; Number)
                        {
                        }
                        column(HeaderDimCaption; HeaderDimCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then begin
                                if not DimSetEntry1.Find('-') then
                                    CurrReport.Break();
                            end else
                                if not Continue then
                                    CurrReport.Break();

                            Clear(DimText);
                            Continue := false;
                            /*
                            repeat
                                OldDimText := DimText;
                                if DimText = '' then
                                    DimText := StrSubstNo('%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                else
                                    DimText :=
                                      StrSubstNo(
                                        '%1, %2 %3', DimText,
                                        DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                if StrLen(DimText) > MaxStrLen(OldDimText) then begin
                                    DimText := OldDimText;
                                    Continue := true;
                                    exit;
                                end;
                            until DimSetEntry1.Next() = 0;
                            */
                        end;

                        trigger OnPreDataItem()
                        begin
                            if not ShowInternalInfoBool then
                                CurrReport.Break();
                        end;
                    }
                    dataitem("Sales Line"; "Sales Line")
                    {
                        DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = sorting("Document Type", "Document No.", "Line No.") where("Composant de la ligne No." = CONST(0));

                        trigger OnPreDataItem()
                        begin
                            CurrReport.Break();
                        end;
                    }
                    dataitem(RoundLoop; "Integer")
                    {
                        DataItemTableView = sorting(Number);

                        column(PrepAmount; -PrepAmount)
                        {
                        }
                        column(PrepLine; "Sales Line"."Ligne deduction acompte")
                        {
                        }
                        column(SituationLine; "Sales Line"."Ligne deduction situation")
                        {
                        }
                        column(TypeLigneSalesLine; Format("Sales Line"."Type ligne"))
                        {
                        }

                        column(SubTot; SousTotal)
                        {
                        }
                        column(SubAmount; "Sales Line"."SubTotal Amount")
                        {
                        }
                        column(SalesLineAmt; TempSalesLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
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
                        column(NNCVATEcoAmt; NNCVATEcoAmt)
                        {
                        }
                        column(NNCTotalInclVAT; NNCTotalInclVAT)
                        {
                        }
                        column(MontantRemisesLignes; MontantRemisesLignes)
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

                        column(VATBaseDisc_SalesHeader; "Sales Header"."VAT Base Discount %")
                        {
                        }
                        column(DisplayAssemblyInfo; DisplayAssemblyInformation)
                        {
                        }
                        column(ShowInternalInfo; ShowInternalInfoBool)
                        {
                        }
                        column(No2_SalesLine; "Sales Line"."No.")
                        {
                        }
                        column(CrossRef_SalesLine; "Sales Line"."Item Reference No.")
                        {
                        }
                        column(Qty_SalesLine; "Sales Line".Quantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(UOM_SalesLine; "Sales Line"."Unit of Measure")
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
                        column(SubtotalCaption; SousTotalText)
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
                        column(EcoMob; "Sales Line"."Eco Tax Furniture Line")
                        {
                        }
                        column(SalesLineSubTot; SousTotal)
                        {
                        }
                        dataitem(DimensionLoop2; "Integer")
                        {
                            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                            column(DimText2; DimText)
                            {
                            }


                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then begin
                                    if not DimSetEntry2.FindSet() then
                                        CurrReport.Break();
                                end else
                                    if not Continue then
                                        CurrReport.Break();

                                Clear(DimText);
                                Continue := false;
                                repeat
                                    OldDimText := DimText;
                                    if DimText = '' then
                                        DimText := StrSubstNo('%1 %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    else
                                        DimText :=
                                          StrSubstNo(
                                            '%1, %2 %3', DimText,
                                            DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                                    if StrLen(DimText) > MaxStrLen(OldDimText) then begin
                                        DimText := OldDimText;
                                        Continue := true;
                                        exit;
                                    end;
                                until DimSetEntry2.Next() = 0;
                            end;

                            trigger OnPreDataItem()
                            begin
                                if not ShowInternalInfoBool then
                                    CurrReport.Break();

                                DimSetEntry2.SetRange("Dimension Set ID", "Sales Line"."Dimension Set ID");
                            end;
                        }
                        dataitem(AsmLoop; "Integer")
                        {
                            DataItemTableView = sorting(Number);
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

                            //KAN.FHA 21/10/2020 DEBUT
                            if TempSalesLine.Type = TempSalesLine.Type::Item then
                                if TempSalesLine."Article divers" and TempSalesLine."Poids obligatoire" then
                                    if TempSalesLine."Net Weight" = 0 then
                                        Error(PoidsObligatoireErrLbl, TempSalesLine."Line No.", TempSalesLine."No.", TempSalesLine.Description);
                            //KAN.FHA 21/10/2020 FIN

                            //KAN.FHA 17/10/2022 DEBUT
                            if (TempSalesLine.Type = TempSalesLine.Type::Item) and ("Sales Header"."Ship-to Country/Region Code" <> CompanyInfo."Country/Region Code") then begin
                                TempSalesLine.TestField("Country/Region of Origin Code");
                                if not TempSalesLine."Article divers" then begin
                                    TempSalesLine.TestField("Net Weight");
                                    Article.Get(TempSalesLine."No.");
                                    Article.TestField("Tariff No.");
                                    Article.TestField("Country/Region of Origin Code");
                                end;
                                if TempSalesLine."Article divers" then begin
                                    Article.Get(TempSalesLine."No.");
                                    if Article."Poids obligatoire" then
                                        TempSalesLine.TestField("Nomenclature produits"); //Renseigné que sur les divers ; la feuille intracomm va chercher la nomenc produit sur l'article pour les non Divers
                                end;
                            end;
                            //KAN.FHA 17/10/2022 FIN

                            if not "Sales Header"."Prices Including VAT" and
                               (TempSalesLine."VAT Calculation Type" = TempSalesLine."VAT Calculation Type"::"Full VAT")
                            then
                                TempSalesLine."Line Amount" := 0;

                            if (TempSalesLine.Type = TempSalesLine.Type::"G/L Account") and (not ShowInternalInfoBool) then
                                "Sales Line"."No." := '';

                            if not TempSalesLine."Eco Tax Furniture Line" then
                                NNCSalesLineLineAmt += TempSalesLine."Line Amount" //;
                            else begin
                                NNCSalesLineEcoAmt += TempSalesLine."Line Amount";
                                NNCVATEcoAMt += TempSalesLine."Amount Including VAT" - TempSalesLine."Line Amount";
                            end;

                            MontantRemisesLignes := MontantRemisesLignes + TempSalesLine."Line Discount Amount"; 

                            //KAN.FHA 29/06/2020 DEBUT
                            //FHA 28/04/2025 if NNCSalesLineEcoAmt <> 0 then
                            //FHA 28/04/2025     txtTotalHT := LabelTotalHTDontEcoContrib
                            //FHA 28/04/2025 else
                            if "Sales Header"."Currency Code" = '' then
                                txtTotalHT := StrSubstNo(TotalHTLbl, GLSetup."LCY Code")
                            else
                                txtTotalHT := StrSubstNo(TotalHTLbl, "Sales Header"."Currency Code");
                            //KAN.FHA 29/06/2020 FIN

                            //DIA£LBO 15/12/2017
                            //TotalNetWeight += SalesLine."Net Weight" * SalesLine.Quantity;
                            //DIA£LBO 15/12/2017//

                            SousTotal := (TempSalesLine."Type ligne" = TempSalesLine."Type ligne"::"Fin total");

                            NNCSalesLineInvDiscAmt += TempSalesLine."Inv. Discount Amount";

                            NNCTotalLCY := NNCSalesLineLineAmt - NNCSalesLineInvDiscAmt;

                            NNCTotalExclVAT := NNCTotalLCY;
                            NNCVATAmt := VATAmount - NNCVATEcoAMt;
                            NNCTotalInclVAT := NNCTotalLCY - NNCVATAmt;

                            NNCPmtDiscOnVAT := -VATDiscountAmount;

                            NNCTotalInclVAT2 := TotalAmountInclVAT;

                            NNCVATAmt2 := VATAmount - NNCVATEcoAMt;
                            NNCTotalExclVAT2 := VATBaseAmount;

                            //DIA.SCH - 15/04/15 - P1 gestion des acomptes
                            if TempSalesLine."Ligne deduction acompte" or TempSalesLine."Ligne deduction situation" then
                                PrepAmount += TempSalesLine."Line Amount";
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
                            TempSalesLine.SetRange("Composant de la ligne No.", 0);
                            SetRange(Number, 1, TempSalesLine.Count);
                            //KAN.FHA 01/10/2026 DEBUT
                            //CurrReport.CreateTotals(SalesLine."Line Amount", SalesLine."Inv. Discount Amount");
                            //KAN.FHA 01/10/2026 FIN
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = sorting(Number);
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
                            //KAN.FHA 23/09/2026 DEBUT
                            /*
                            CurrReport.CreateTotals(
                              VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
                              VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount");
                            */
                            //KAN.FHA 23/09/2026 FIN
                        end;
                    }
                    dataitem(VATCounterLCY; "Integer")
                    {
                        DataItemTableView = sorting(Number);
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
                            //KAN.FHA 01/10/2026 DEBUT
                            //CurrReport.CreateTotals(VALVATBaseLCY, VALVATAmountLCY);
                            //KAN.FHA 01/10/2026 FIN

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
                        DataItemTableView = sorting(Number) where(Number = filter(1 ..));
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
                            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                            column(DimText3; DimText)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then begin
                                    if not TempPrepmtDimSetEntry.Find('-') then
                                        CurrReport.Break();
                                end else
                                    if not Continue then
                                        CurrReport.Break();

                                Clear(DimText);
                                Continue := false;
                                repeat
                                    OldDimText := DimText;
                                    if DimText = '' then
                                        DimText :=
                                          StrSubstNo('%1 %2', TempPrepmtDimSetEntry."Dimension Code", TempPrepmtDimSetEntry."Dimension Value Code")
                                    else
                                        DimText :=
                                          StrSubstNo(
                                            '%1, %2 %3', DimText,
                                            TempPrepmtDimSetEntry."Dimension Code", TempPrepmtDimSetEntry."Dimension Value Code");
                                    if StrLen(DimText) > MaxStrLen(OldDimText) then begin
                                        DimText := OldDimText;
                                        Continue := true;
                                        exit;
                                    end;
                                until TempPrepmtDimSetEntry.Next() = 0;
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var

                        begin
                            if Number = 1 then begin
                                if not TempPrepmtInvBuf.Find('-') then
                                    CurrReport.Break();
                            end else
                                if TempPrepmtInvBuf.Next() = 0 then
                                    CurrReport.Break();

                            if ShowInternalInfoBool then
                                DimMgt.GetDimensionSet(TempPrepmtDimSetEntry, TempPrepmtInvBuf."Dimension Set ID");

                            if "Sales Header"."Prices Including VAT" then
                                PrepmtLineAmount := TempPrepmtInvBuf."Amount Incl. VAT"
                            else
                                PrepmtLineAmount := TempPrepmtInvBuf.Amount;
                        end;

                        trigger OnPreDataItem()
                        begin
                            //KAN.FHA 23/09/2026 DEBUT
                            /*
                            CurrReport.CreateTotals(
                              PrepmtInvBuf.Amount, PrepmtInvBuf."Amount Incl. VAT",
                              PrepmtVATAmountLine."Line Amount", PrepmtVATAmountLine."VAT Base",
                              PrepmtVATAmountLine."VAT Amount",
                              PrepmtLineAmount);
                            */
                            //KAN.FHA 23/09/2026 FIN
                        end;
                    }
                    dataitem(PrepmtVATCounter; "Integer")
                    {
                        DataItemTableView = sorting(Number);
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
                        DataItemTableView = sorting(Number) where(Number = CONST(1));
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
                    TempSalesLineDisc: Record "Sales Line" temporary;
                    TempSalesLine: Record "Sales Line" temporary;
                    TempPrepmtSalesLine: Record "Sales Line" temporary;
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
                    SalesPost.GetSalesLines("Sales Header", TempSalesLineDisc, 0);
                    TempSalesLineDisc.CalcVATAmountLines(0, "Sales Header", TempSalesLineDisc, TempVATAmountLine);
                    TempSalesLineDisc.UpdateVATOnLines(0, "Sales Header", TempSalesLineDisc, TempVATAmountLine);
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

                    SalesPostPrepmt.UpdateVATOnLines("Sales Header", TempPrepmtSalesLine, TempPrepmtVATAmountLine, 0);
                    SalesPostPrepmt.BuildInvLineBuffer("Sales Header", TempPrepmtSalesLine, 0, TempPrepmtInvBuf);
                    PrepmtVATAmount := TempPrepmtVATAmountLine.GetTotalVATAmount();
                    PrepmtVATBaseAmount := TempPrepmtVATAmountLine.GetTotalVATBase();
                    PrepmtTotalAmountInclVAT := TempPrepmtVATAmountLine.GetTotalAmountInclVAT();

                    if Number > 1 then
                        //  CopyText := Text003;
                        OutputNo += 1;

                    //Migration CurrReport.PageNo := 1;

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
                    //DIA.SCH - 15/04/15 - P1 gestion des acomptes
                    PrepAmount := 0;
                    //
                    NNCSalesLineEcoAmt := 0;
                    NNCVATEcoAMt := 0;
                    MontantRemisesLignes := 0;
                end;

                trigger OnPostDataItem()
                begin
                    if Print then
                        SalesCountPrinted.Run("Sales Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := Abs(NoOfCopiesInt) + 1;
                    CopyText := '';
                    SetRange(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInfo.Get();
                //-DIA
                CompanyInfo.CalcFields(Picture);
                //+DIA
                //KAN.FHA 21/10/2022 DEBUT
                if "Factor Code" <> '' then begin
                    FactorTable.Get("Factor Code");
                    //KAN.FHA 12/05/2025 DEBUT
                    //InfosPaiement := FactorTable."Text 1" + ' ' + FactorTable."Text 2" + FactorTable."Text 3";
                    //Remplace par :
                    //InfosPaiement1 := FactorTable."Text 1";
                    InfosPaiement2 := FactorTable."Text 2" + FactorTable."Text 3";
                    //KAN.FHA 12/05/2025 FIN
                end else //begin
                    //KAN.FHA 12/05/2025 DEBUT
                    //InfosPaiement := CompanyInfo."Bank Name" + ' - IBAN ' + CompanyInfo.IBAN + ' - BIC ' + CompanyInfo."SWIFT Code";
                    //Remplace par :
                    //InfosPaiement1 := CompanyInfo."Bank Name";
                    InfosPaiement2 := 'IBAN ' + CompanyInfo.IBAN + ' - BIC ' + CompanyInfo."SWIFT Code";
                    //KAN.FHA 12/05/2025 FIN
                //end;
                //KAN.FHA 21/10/2022 FIN

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

                "Sales Header".RecupInfosDerniereArchive(MontantDernArchive, NoVersionDernArchive, DateDernArchive);

                //-DIA@FHA 09/04/2014 Je fais en sorte que les captions ne soient jamais vides pour ne pas avoir de lignes blanches sur le papier
                ReferenceText := FieldCaption("Your Reference");

                VATNoText := FieldCaption("VAT Registration No.");
                //+DIA@FHA 09/04/2014

                ClientFrancais := ("Sell-to Country/Region Code" = '') OR ("Sell-to Country/Region Code" = CompanyInfo."Country/Region Code");

                CondPaiementAcompteTxt := '';
                if "% acompte demande" > 0 then
                    if "% acompte demande" = 100 then begin
                        CondPaiementSoldeTxt := '';
                        CondPaiementAcompteTxt := '';

                        txtPaymentMethodDescription := txtPaymentMethodDescription + ' 100% ' + PaiementComptantLbl;
                    end else begin
                        //txtSolde := SoldeLbl;
                        CondPaiementAcompteTxt := format("% acompte demande") + ' %';
                        if PaymentTerms.Get("Code cond. paiement acomptes") then begin
                            PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
                            CondPaiementAcompteTxt := CondPaiementAcompteTxt + ' - ' + PaymentTerms.Description;
                        end;
                    end;

                CondPaiementSituationTxt := '';
                if "% acompte situation demande" <> 0 then begin
                    CondPaiementSituationTxt := format("% acompte situation demande") + ' %';
                    if PaymentTerms.Get("Code cond. paiement situation") then begin
                        PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
                        CondPaiementSituationTxt := CondPaiementSituationTxt + ' - ' + PaymentTerms.Description;
                    end;
                end;

                CondPaiementSoldeTxt := '';
                if ("% acompte demande" <> 0) or ("% acompte situation demande" <> 0) then begin
                    if not PaymentTerms.Get("Sales Header"."Payment Terms Code") then
                        PaymentTerms.Init();
                    CondPaiementSoldeTxt := format(100 - ("% acompte demande" + "% acompte situation demande")) + '%';
                    PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
                    CondPaiementSoldeTxt := CondPaiementSoldeTxt + ' - ' + PaymentTerms.Description;
                end;

                SiteName := '';
                if "Code chantier" <> '' then begin
                    Chantier.Get("Code chantier");
                    SiteName := Chantier."Description chantier";
                end;

                MentionEcoContribution := '';
                CalcFields("Montant eco-taxe");
                if "Montant eco-taxe" <> 0 then
                    MentionEcoContribution := MentionEcoContribution1Lbl + format("Montant eco-taxe");

                if "Currency Code" = '' then begin
                    GLSetup.TestField("LCY Code");
                    TotalText := StrSubstNo(Text001Lbl, GLSetup."LCY Code");
                    TotalInclVATText := Text002Lbl;
                    TotalExclVATText := Text006Lbl;
                    SousTotalText := SubtotalCaptionLbl;

                    if "Montant eco-taxe" <> 0 then
                        MentionEcoContribution := MentionEcoContribution + ' ' + GLSetup."LCY Code" + MentionEcoContribution2Lbl;
                end else begin
                    TotalText := StrSubstNo(Text001Lbl, "Currency Code");
                    TotalInclVATText := Text002Lbl;
                    TotalExclVATText := Text006Lbl;
                    SousTotalText := SubtotalCaptionLbl;
                    if "Montant eco-taxe" <> 0 then
                        MentionEcoContribution := MentionEcoContribution + "Currency Code" + MentionEcoContribution2Lbl;
                end;

                FormatAddr.SalesHeaderSellTo(CustAddr, "Sales Header");

                FormatAddr.SalesHeaderBillTo(BillToAddr, "Sales Header");
                if not PaymentMethod.Get("Payment Method Code") then
                    PaymentMethod.Init();

                if "Payment Terms Code" = '' then
                    PaymentTerms.Init()
                else begin
                    PaymentTerms.Get("Payment Terms Code");
                    PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
                end;

                txtPaymentMethodDescription := PaymentMethod.Description;
                txtSolde := PaymentTermsCaptionLbl;

                if not ShippingAgent.Get("Sales Header"."Shipping Agent Code") then
                    ShippingAgent.Init();

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


                FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, "Sales Header");

                TexteTVA := '';
                if "Bill-to Country/Region Code" = CompanyInfo."Country/Region Code" then begin
                    TexteTVA := MentionTVAFRLbl;
                    TextePenalitesRetard := PenalitesRetardFRLbl;
                end else begin
                    TextePenalitesRetard := PenalitesRetardENULbl;
                    if not Pays.Get("Bill-to Country/Region Code") then
                        Pays.init();
                    if Pays."Intrastat Code" <> '' then
                        TexteTVA := MentionTVAUELbl
                    else
                        TexteTVA := MentionTVAExportLbl;
                end;
            end;

            trigger OnPreDataItem()
            begin
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
                    field(NoOfCopies; NoOfCopiesInt)
                    {
                        Caption = 'Nb. de copies';
                        ToolTip = 'Nb. de copies';
                    }
                    field(ShowInternalInfo; ShowInternalInfoBool)
                    {
                        Caption = 'Afficher infos. internes';
                        ToolTip = 'Afficher infos. internes';
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
        //FooterTextLine1 = 'TVA acquittée sur les débits - Exonération de TVA, art 262 ter-1 du CGI - TVA non applicable art 293B du CGI.';
        //FooterTextLine2 = 'En cas de retard de paiement, le taux ne peut en aucun cas être inférieur à 1,5 fois le taux légal Art L 441-6 du code du commerce. Les pénalités de retard sont';
        //FooterTextLine3 = 'exigibles sans rappel préalable. Le montant de l''indemnité forfaitaire pour frais de recouvrement due au créancier en cas de retard de paiement, conformément';
        //FooterTextLine4 = 'à l''article 121-II de la loi n° 2012-387 du 22 mars 2012 est fixée à 40 € par le décret n° 2012-115 du 2 octobre 2012.';
        //FooterTextLine5 = 'Réserve de propriété : nous nous réservons la propriété des marchandises jusqu''au paiement du prix complet par l''acheteur. Notre revendication porte aussi bien sur';
        //FooterTextLine6 = 'les marchandises que sur leur prix si elles ont déjà été revendues (loi du 12 mai 1980).';
        FooterTextLine7 = 'Le client est réputé accepter nos conditions de vente disponibles sur simple demande.';
    }

    trigger OnInitReport()
    begin
        GLSetup.Get();
        SalesSetup.Get();
    end;

    var
        GLSetup: Record "General Ledger Setup";
        Pays: Record "Country/Region";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PrepmtPaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        ShippingAgent: Record "Shipping Agent";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        TempPrepmtVATAmountLine: Record "VAT Amount Line" temporary;
        TempPrepmtVATAmountLineDeduct: Record "VAT Amount Line" temporary;
        TempSalesLine: Record "Sales Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        TempPrepmtDimSetEntry: Record "Dimension Set Entry" temporary;
        TempPrepmtInvBuf: Record "Prepayment Inv. Line Buffer" temporary;
        RespCenter: Record "Responsibility Center";
        CurrExchRate: Record "Currency Exchange Rate";
        AsmHeader: Record "Assembly Header";
        AsmLine: Record "Assembly Line";
        Chantier: Record Chantier;
        Article: Record Item;
        FactorTable: Record Factor;

        LanguageMgt: codeunit Language;
        SalesPostPrepmt: Codeunit "Sales-Post Prepayments";
        DimMgt: Codeunit DimensionManagement;

        SalesCountPrinted: Codeunit "Sales-Printed";
        FormatAddr: Codeunit "Format Address";
        Text000Lbl: Label 'Followed by :'; //Salesperson :
        Text001Lbl: Label 'Total %1',Comment = '%1 = Total';
        Text002Lbl: Label 'Total Incl. VAT'; //FRA = Total TTC
        //Migration Text003: Label 'Copie';
        Text004Lbl: Label 'Order No.';
        Text005Lbl: Label 'Page %1',Comment = '%1 = N° page';
        Text006Lbl: Label 'Total'; //FRA = Total H.T.
        BankDetailsLbl: Label 'Bank Details :';
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
        NoOfCopiesInt: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        DimText: Text[120];
        OldDimText: Text[120];
        ShowInternalInfoBool: Boolean;
        Continue: Boolean;
        //LogInteraction: Boolean;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        Text007Lbl: Label 'VAT Amount Specification in ';
        Text008Lbl: Label 'Local Currency';
        Text009Lbl: Label 'Exchange rate: %1/%2',Comment = '%1 = Devise 1 ; %2 = Devise 2';
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

        //ArchiveManagement: Codeunit ArchiveManagement;
        Print: Boolean;
        DisplayAssemblyInformation: Boolean;
        AsmInfoExistsForLine: Boolean;
        InvDiscAmtCaptionLbl: Label 'Invoice Discount Amount';
        VATRegNoCaptionLbl: Label 'VAT Registration No.';
        SalesHeaderNoCaptionLbl: Label 'No.';
        HomePageCaptionLbl: Label 'Home Page';
        EmailCaptionLbl: Label 'E-Mail';
        HeaderDimCaptionLbl: Label 'Header Dimensions';
        DiscountPercentCaptionLbl: Label 'Disc. %';
        SubtotalCaptionLbl: Label 'Subtotal'; //FRA : Sous-total H.T.
        PaymentDiscountVATCaptionLbl: Label 'Payment Discount on VAT';

        InvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount';
        VATIdentifierCaptionLbl: Label 'VAT Identifier';
        ShiptoAddrCaptionLbl: Label 'Ship-to Address';
        BilltoAddrCaptionLbl: Label 'Bill-To Address';
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
        SalesHeaderQuoteNoCaptionLbl: Label 'Quote No.';
        
        SalesHeaderOrderDateCaptionLbl: Label 'Date :';
        SalesPersonMailCaptionLbl: Label 'E-mail';
        JobName: Text[50];
        NNCSalesLineEcoAmt: Decimal;
        AffaireLbl: Label 'Job :';
        NoLocationNameLbl: Label 'No. and Location Name :';
        NoRayonLbl: Label 'Range No. : ';
        InterlocuteurclientLbl: Label 'Contact Name :';
        CommentaireLbl: Label 'Comments : ';
        RequestedDeliveryDateLbl: Label 'Delivery date:';
        DateChargementLbl: Label 'Shipment Date';
        EcoTaxLbl: Label 'Including Ecocontribution Amount';
        MontantRemisesLignesLbl: Label 'Including line discounts';
        RefClientLbl: Label 'Customer Ref.';
        DescriptionLbl: Label 'Description';
        QuantiteLbl: Label 'Qty';
        NNCVATEcoAMt: Decimal;
        MontantRemisesLignes: Decimal;
        //TotalNetWeight: Decimal;
        //LabellTotalWeight: Label 'Total Net Weight:';
        QuoteValidityCaptionLbl: Label 'Quote valid for two months.';
        QuoteAgreementLine1CaptionLbl: Label 'Agreement';
        QuoteAgreementLine2CaptionLbl: Label '(Date, signature and official stamp)';
        SiteLbl: Label 'Site :';
        SiteName: Text[50];
        AgreementLbl: Label 'In                         , the';
        UnitCaptionLbl: Label 'Unit';
        MarchandiseLbl: Label 'Product Information';
        PaletteLbl: Label 'Number of Pallets';
        OrgMseLbl: Label 'Origine marchandise';
        PaysLbl: Label 'Pays exportateur';
        CurrencyLbl: Label 'Currency :';
        ExternalDocNoLbl: Label 'External Doc. No. :';
        TotalGrossWeightLbl: Label 'Total Gross Weight (kg):';
        PackageLbl: Label 'Number of Packages:';
        TexteTVA: Text[1024];
        MentionTVAFRLbl: Label 'TVA sur les débits';
        MentionTVAUELbl: Label 'Intra-Community Supply : VAT Exemption under Article 262 ter I of the French General Tax Code';
        MentionTVAExportLbl: Label 'VAT exempt under Article 262 I of the French General Tax Code (CGI)';
        TextePenalitesRetard: Text[1024];
        PenalitesRetardFRLbl: label 'Pénalité de retard : 3 fois le taux d''intérêt légal en vigueur + indemnité forfaitaire de frais de recouvrement de 40 € (Art. L. 441-6 du Code du Commerce)';
        PenalitesRetardENULbl: Label 'Pénalité de retard : 3 fois le taux d''intérêt légal en vigueur + indemnité forfaitaire de frais de recouvrement de 40 € (Art. L. 441-6 du Code du Commerce)';
        PrepAmount: Decimal;
        AcompteverseLbl: Label 'Prepayment Amount';
        MontantDejaVerseLbl: Label 'Already Paid';
        ResteAPayerLbl: Label 'Still to pay (€)';
        VariantLbl: Label 'Variant';
        SousTotal: Boolean;
        ClientFrancais: Boolean;
        TotalHTLbl: Label 'Total Amount - %1 (excl. VAT)',Comment = '%1 = Devise';
        txtTotalHT: Text[50];
        
        PoidsObligatoireErrLbl: Label 'Vous devez indiquer un poids net sur la ligne %1, article %2 %3.',Comment = '%1 = Ligne ; %2 = N° article ; %3 = Description';
        MentionEcoContribution: Text;
        MentionEcoContribution1Lbl: Label 'Ce document inclut une éco-participation de  ';
        MentionEcoContribution2Lbl: Label ' , reversée à un éco-organisme agréé conformément à la réglementation en vigueur.';
        

        SoldeLbl: Label 'Remaining Amount:';
        txtSolde: Text[80];
        txtPaymentMethodDescription: Text;
        PaiementComptantLbl: Label 'pre-paid';
        SousTotalText: Text[50];
        
        InfosPaiement2: Text[1024];
        
        AcceptationDevisTxt: Label 'The signature of this offer implies the acceptance of the general conditions of sales (annexed).';
        //TitreAcceptationDevisTxt: Label '**Offer acceptance:';
        MentionsLegalesLbl: Label 'Legal notices:';
        PhaseLbl: Label 'Phase :';
        VersionLbl: Label 'Version ';
        DateDernArchive: Date;
        NoVersionDernArchive: Integer;
        MontantDernArchive: Decimal;
        AcompteLbl: Label 'Prepayment :';
        SituationLbl: Label 'Interim Invoice :';
        CondPaiementSituationTxt: Text;
        CondPaiementAcompteTxt: Text;
        CondPaiementSoldeTxt: Text;
        EscompteLbl: Label 'No prompt-payment discount granted in the case of payment before invoice due date.';

    procedure InitializeRequest(NoOfCopiesFrom: Integer; ShowInternalInfoFrom: Boolean; ArchiveDocumentFrom: Boolean; LogInteractionFrom: Boolean; PrintFrom: Boolean; DisplayAsmInfo: Boolean)
    begin
        NoOfCopiesInt := NoOfCopiesFrom;
        ShowInternalInfoBool := ShowInternalInfoFrom;
        Print := PrintFrom;
        DisplayAssemblyInformation := DisplayAsmInfo;
    end;

    procedure GetUnitOfMeasureDescr(UOMCode: Code[10]): Text[50]
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        if not UnitOfMeasure.Get(UOMCode) then
            exit(UOMCode);
        exit(UnitOfMeasure.Description);
    end;

    procedure BlanksForIndent(): Text[10]
    begin
        exit(PadStr('', 2, ' '));
    end;

    procedure SalesPurchPerson_PhoneNoEmail() PhoneNoEmail: Text[1024]
    begin
        Clear(PhoneNoEmail);
        PhoneNoEmail := SalesPurchPerson."Phone No.";
        if SalesPurchPerson."E-Mail" <> '' then begin
            if PhoneNoEmail <> '' then
                PhoneNoEmail := PhoneNoEmail + ' / ';
            PhoneNoEmail := PhoneNoEmail + SalesPurchPerson."E-Mail"
        end;
    end;

}

