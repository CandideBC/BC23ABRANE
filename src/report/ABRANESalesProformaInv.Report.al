report 50008 "ABRANE : Sales Proforma Inv."
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/ReportLayout/ABRANESalesProformaInv.rdlc';

    Caption = 'Facture Proforma';
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
            column(LabelAffaire; LabelAffaire)
            {
            }
            column(LabelSite; LabelSite)
            {
            }
            column(LabelPackage; LabelPackage)
            {
            }
            column(SiteName; SiteName)
            {
            }
            column(LabelNoLocationName; LabelNoLocationName)
            {
            }
            column(LabelNoRayon; LabelNoRayon)
            {
            }
            column(LabelInterlocuteurclient; LabelInterlocuteurclient)
            {
            }
            column(LabelCommentaire; LabelCommentaire)
            {
            }
            column(LabelShipmentDate; LabelRequestedDeliveryDate)
            {
            }
            column(DateChargementLbl; DateChargementLbl)
            {
            }
            column(LabelEcoTax; LabelEcoTax)
            {
            }
            column(LabelMontantRemisesLignes; LabelMontantRemisesLignes)
            {
                
            }
            column(LabelTotalHTDontEcoContrib; txtTotalHT)
            {
            }
            column(LabelRefClient; LabelRefClient)
            {
            }
            column(LabelDescription; LabelDescription)
            {
            }
            column(LabelQuantite; LabelQuantite)
            {
            }
            column(LabelAgreement; LabelAgreement)
            {
            }
            column(LabelPays; LabelPays)
            {
            }
            column(LabelTotalGrossWeight; LabelTotalGrossWeight)
            {
            }
            column(LabelMarchandise; LabelMarchandiseLbl)
            {
            }
            column(LabelPalette; LabelPalette)
            {
            }
            column(LabelOrgMse; LabelOrgMse)
            {
            }
            column(ExternalDocNoLbl; ExternalDocNoLbl)
            {
            }
            column(LabelCurrency; LabelCurrency)
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
            column(LabelUnitCaption; LabelUnitCaption)
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
            column(LabelEscompte; LabelEscompte)
            {
            }
            column(LabelAcompteverse; LabelAcompteverse)
            {
            }
            column(LabelMontantDejaVerse; LabelMontantDejaVerse)
            {
            }
            column(LabelResteAPayer; LabelResteAPayer)
            {
            }
            column(labelVariant; labelVariant)
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
                    column(SalesCopyText; Text004)
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
                    column(PageCaption; StrSubstNo(Text005, ''))
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
                            if not ShowInternalInfo then
                                CurrReport.Break();
                        end;
                    }
                    dataitem("Sales Line"; "Sales Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") WHERE("Linked to line" = CONST(0));

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
                        column(SalesLineAmt; SalesLine."Line Amount")
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
                        column(ShowInternalInfo; ShowInternalInfo)
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
                        column(SalesLineInvDiscAmt; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                            IncludeCaption = false;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(SalsLinAmtExclLineDiscAmt; SalesLine."Line Amount" - VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(VATAmtLineVATAmtText; VATAmountLine.VATAmountText())
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
                        column(SalesLineAmtExclLineDisc; SalesLine."Line Amount" - VATAmountLine."Invoice Discount Amount" + VATAmount)
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
                                if not ShowInternalInfo then
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
                                SalesLine.Find('-')
                            else
                                SalesLine.Next();
                            "Sales Line" := SalesLine;
                            if DisplayAssemblyInformation then
                                AsmInfoExistsForLine := SalesLine.AsmToOrderExists(AsmHeader);

                            //KAN.FHA 21/10/2020 DEBUT
                            if SalesLine.Type = SalesLine.Type::Item then
                                if SalesLine."Article divers" and SalesLine."Poids obligatoire" then
                                    if SalesLine."Net Weight" = 0 then
                                        Error(PoidsObligatoireErr, SalesLine."Line No.", SalesLine."No.", SalesLine.Description);
                            //KAN.FHA 21/10/2020 FIN

                            //KAN.FHA 17/10/2022 DEBUT
                            if (SalesLine.Type = SalesLine.Type::Item) and ("Sales Header"."Ship-to Country/Region Code" <> CompanyInfo."Country/Region Code") then begin
                                SalesLine.TestField("Country/Region of Origin Code");
                                if not SalesLine."Article divers" then begin
                                    SalesLine.TestField("Net Weight");
                                    Article.Get(SalesLine."No.");
                                    Article.TestField("Tariff No.");
                                    Article.TestField("Country/Region of Origin Code");
                                end;
                                if SalesLine."Article divers" then begin
                                    Article.Get(SalesLine."No.");
                                    if Article."Poids obligatoire" then
                                        SalesLine.TestField("Nomenclature produits"); //Renseigné que sur les divers ; la feuille intracomm va chercher la nomenc produit sur l'article pour les non Divers
                                end;
                            end;
                            //KAN.FHA 17/10/2022 FIN

                            if not "Sales Header"."Prices Including VAT" and
                               (SalesLine."VAT Calculation Type" = SalesLine."VAT Calculation Type"::"Full VAT")
                            then
                                SalesLine."Line Amount" := 0;

                            if (SalesLine.Type = SalesLine.Type::"G/L Account") and (not ShowInternalInfo) then
                                "Sales Line"."No." := '';

                            if not SalesLine."Eco Tax Furniture Line" then
                                NNCSalesLineLineAmt += SalesLine."Line Amount" //;
                            else begin
                                NNCSalesLineEcoAmt += SalesLine."Line Amount";
                                NNCVATEcoAMt += SalesLine."Amount Including VAT" - SalesLine."Line Amount";
                            end;

                            MontantRemisesLignes := MontantRemisesLignes + SalesLine."Line Discount Amount"; 

                            //KAN.FHA 29/06/2020 DEBUT
                            //FHA 28/04/2025 if NNCSalesLineEcoAmt <> 0 then
                            //FHA 28/04/2025     txtTotalHT := LabelTotalHTDontEcoContrib
                            //FHA 28/04/2025 else
                            if "Sales Header"."Currency Code" = '' then
                                txtTotalHT := StrSubstNo(LabelTotalHT, GLSetup."LCY Code")
                            else
                                txtTotalHT := StrSubstNo(LabelTotalHT, "Sales Header"."Currency Code");
                            //KAN.FHA 29/06/2020 FIN

                            //DIA£LBO 15/12/2017
                            //TotalNetWeight += SalesLine."Net Weight" * SalesLine.Quantity;
                            //DIA£LBO 15/12/2017//

                            SousTotal := (SalesLine."Type ligne" = SalesLine."Type ligne"::"Fin total");

                            NNCSalesLineInvDiscAmt += SalesLine."Inv. Discount Amount";

                            NNCTotalLCY := NNCSalesLineLineAmt - NNCSalesLineInvDiscAmt;

                            NNCTotalExclVAT := NNCTotalLCY;
                            NNCVATAmt := VATAmount - NNCVATEcoAMt;
                            NNCTotalInclVAT := NNCTotalLCY - NNCVATAmt;

                            NNCPmtDiscOnVAT := -VATDiscountAmount;

                            NNCTotalInclVAT2 := TotalAmountInclVAT;

                            NNCVATAmt2 := VATAmount - NNCVATEcoAMt;
                            NNCTotalExclVAT2 := VATBaseAmount;

                            //DIA.SCH - 15/04/15 - P1 gestion des acomptes
                            if SalesLine."Ligne deduction acompte" or SalesLine."Ligne deduction situation" then
                                PrepAmount += SalesLine."Line Amount";
                        end;

                        trigger OnPostDataItem()
                        begin
                            SalesLine.DeleteAll();
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := SalesLine.Find('+');
                            while MoreLines and (SalesLine.Description = '') and (SalesLine."Description 2" = '') and
                                  (SalesLine."No." = '') and (SalesLine.Quantity = 0) and
                                  (SalesLine.Amount = 0)
                            do
                                MoreLines := SalesLine.Next(-1) <> 0;
                            if not MoreLines then
                                CurrReport.Break();
                            SalesLine.SetRange("Line No.", 0, SalesLine."Line No.");
                            SalesLine.SetRange("Linked to line", 0);
                            SetRange(Number, 1, SalesLine.Count);
                            CurrReport.CreateTotals(SalesLine."Line Amount", SalesLine."Inv. Discount Amount");
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = sorting(Number);
                        column(VATAmountLineVATBase; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscAmt; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATPercentage; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(InvDiscBaseAmtCaption; InvDiscBaseAmtCaptionLbl)
                        {
                        }
                        column(VATIdentifierCaption; VATIdentifierCaptionLbl)
                        {
                        }
                        column(VATAmountLineCOUNT; VATAmountLine.Count)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            if VATAmount = 0 then
                                CurrReport.Break();
                            SetRange(Number, 1, VATAmountLine.Count);
                            CurrReport.CreateTotals(
                              VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
                              VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VATCounterLCY; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
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
                        column(VATAmtLineVATPercentage2; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier2; VATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);

                            VALVATBaseLCY := Round(CurrExchRate.ExchangeAmtFCYToLCY(
                                  "Sales Header"."Posting Date", "Sales Header"."Currency Code",
                                  VATAmountLine."VAT Base", "Sales Header"."Currency Factor"));
                            VALVATAmountLCY := Round(CurrExchRate.ExchangeAmtFCYToLCY(
                                  "Sales Header"."Posting Date", "Sales Header"."Currency Code",
                                  VATAmountLine."VAT Amount", "Sales Header"."Currency Factor"));
                        end;

                        trigger OnPreDataItem()
                        begin
                            if (not GLSetup."Print VAT specification in LCY") or
                               ("Sales Header"."Currency Code" = '') or
                               (VATAmountLine.GetTotalVATAmount() = 0)
                            then
                                CurrReport.Break();

                            SetRange(Number, 1, VATAmountLine.Count);
                            CurrReport.CreateTotals(VALVATBaseLCY, VALVATAmountLCY);

                            if GLSetup."LCY Code" = '' then
                                VALSpecLCYHeader := Text007 + Text008
                            else
                                VALSpecLCYHeader := Text007 + Format(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Sales Header"."Posting Date", "Sales Header"."Currency Code", 1);
                            VALExchRate := StrSubstNo(Text009, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(PrepmtLoop; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                        column(PrepmtLineAmount; PrepmtLineAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtInvBufDesc; PrepmtInvBuf.Description)
                        {
                        }
                        column(PrepmtInvBufGLAccNo; PrepmtInvBuf."G/L Account No.")
                        {
                        }
                        column(TotalExclVATText2; TotalExclVATText)
                        {
                        }
                        column(PrepmtVATAmtLineVATAmtTxt; PrepmtVATAmountLine.VATAmountText())
                        {
                        }
                        column(TotalInclVATText2; TotalInclVATText)
                        {
                        }
                        column(PrepmtInvAmount; PrepmtInvBuf.Amount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmount; PrepmtVATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtInvAmtInclVATAmt; PrepmtInvBuf.Amount + PrepmtVATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtText2; VATAmountLine.VATAmountText())
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
                                if not PrepmtInvBuf.Find('-') then
                                    CurrReport.Break();
                            end else
                                if PrepmtInvBuf.Next() = 0 then
                                    CurrReport.Break();

                            if ShowInternalInfo then
                                DimMgt.GetDimensionSet(TempPrepmtDimSetEntry, PrepmtInvBuf."Dimension Set ID");

                            if "Sales Header"."Prices Including VAT" then
                                PrepmtLineAmount := PrepmtInvBuf."Amount Incl. VAT"
                            else
                                PrepmtLineAmount := PrepmtInvBuf.Amount;
                        end;

                        trigger OnPreDataItem()
                        begin
                            CurrReport.CreateTotals(
                              PrepmtInvBuf.Amount, PrepmtInvBuf."Amount Incl. VAT",
                              PrepmtVATAmountLine."Line Amount", PrepmtVATAmountLine."VAT Base",
                              PrepmtVATAmountLine."VAT Amount",
                              PrepmtLineAmount);
                        end;
                    }
                    dataitem(PrepmtVATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(PrepmtVATAmtLineVATAmt; PrepmtVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineVATBase; PrepmtVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineLineAmt; PrepmtVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineVATPerc; PrepmtVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(PrepmtVATAmtLineVATIdent; PrepmtVATAmountLine."VAT Identifier")
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
                            PrepmtVATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            SetRange(Number, 1, PrepmtVATAmountLine.Count);
                        end;
                    }
                    dataitem(PrepmtTotal; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(PrepmtPmtTermsDesc; PrepmtPaymentTerms.Description)
                        {
                        }
                        column(PrepmtPmtTermsDescCaption; PrepmtPmtTermsDescCaptionLbl)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            if not PrepmtInvBuf.Find('-') then
                                CurrReport.Break();
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                var
                    TempSalesLineDisc: Record "Sales Line" temporary;
                    TempSalesLine: Record "Sales Line" temporary;
                    PrepmtSalesLine: Record "Sales Line" temporary;
                    SalesPost: Codeunit "Sales-Post";

                begin
                    Clear(SalesLine);
                    Clear(SalesPost);
                    Clear(TempSalesLineDisc);
                    VATAmountLine.DeleteAll();
                    SalesLine.DeleteAll();
                    TempSalesLineDisc.DeleteAll();
                    SalesPost.GetSalesLines("Sales Header", SalesLine, 0);
                    SalesLine.CalcVATAmountLines(0, "Sales Header", SalesLine, VATAmountLine);
                    SalesLine.UpdateVATOnLines(0, "Sales Header", SalesLine, VATAmountLine);
                    SalesPost.GetSalesLines("Sales Header", TempSalesLineDisc, 0);
                    TempSalesLineDisc.CalcVATAmountLines(0, "Sales Header", TempSalesLineDisc, VATAmountLine);
                    TempSalesLineDisc.UpdateVATOnLines(0, "Sales Header", TempSalesLineDisc, VATAmountLine);
                    SalesLine."Inv. Discount Amount" := VATAmountLine."Invoice Discount Amount";
                    VATAmount := VATAmountLine.GetTotalVATAmount();
                    VATBaseAmount := VATAmountLine.GetTotalVATBase();
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount("Sales Header"."Currency Code", "Sales Header"."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT();

                    PrepmtInvBuf.DeleteAll();
                    SalesPostPrepmt.GetSalesLines("Sales Header", 0, PrepmtSalesLine);

                    if not PrepmtSalesLine.IsEmpty then begin
                        SalesPostPrepmt.GetSalesLinesToDeduct("Sales Header", TempSalesLine);
                        if not TempSalesLine.IsEmpty then
                            SalesPostPrepmt.CalcVATAmountLines("Sales Header", TempSalesLine, PrepmtVATAmountLineDeduct, 1);
                    end;
                    SalesPostPrepmt.CalcVATAmountLines("Sales Header", PrepmtSalesLine, PrepmtVATAmountLine, 0);
                    if PrepmtVATAmountLine.FindSet() then
                        repeat
                            PrepmtVATAmountLineDeduct := PrepmtVATAmountLine;
                            if PrepmtVATAmountLineDeduct.Find() then begin
                                PrepmtVATAmountLine."VAT Base" := PrepmtVATAmountLine."VAT Base" - PrepmtVATAmountLineDeduct."VAT Base";
                                PrepmtVATAmountLine."VAT Amount" := PrepmtVATAmountLine."VAT Amount" - PrepmtVATAmountLineDeduct."VAT Amount";
                                PrepmtVATAmountLine."Amount Including VAT" := PrepmtVATAmountLine."Amount Including VAT" -
                                  PrepmtVATAmountLineDeduct."Amount Including VAT";
                                PrepmtVATAmountLine."Line Amount" := PrepmtVATAmountLine."Line Amount" - PrepmtVATAmountLineDeduct."Line Amount";
                                PrepmtVATAmountLine."Inv. Disc. Base Amount" := PrepmtVATAmountLine."Inv. Disc. Base Amount" -
                                  PrepmtVATAmountLineDeduct."Inv. Disc. Base Amount";
                                PrepmtVATAmountLine."Invoice Discount Amount" := PrepmtVATAmountLine."Invoice Discount Amount" -
                                  PrepmtVATAmountLineDeduct."Invoice Discount Amount";
                                PrepmtVATAmountLine."Calculated VAT Amount" := PrepmtVATAmountLine."Calculated VAT Amount" -
                                  PrepmtVATAmountLineDeduct."Calculated VAT Amount";
                                PrepmtVATAmountLine.Modify();
                            end;
                        until PrepmtVATAmountLine.Next() = 0;

                    SalesPostPrepmt.UpdateVATOnLines("Sales Header", PrepmtSalesLine, PrepmtVATAmountLine, 0);
                    SalesPostPrepmt.BuildInvLineBuffer("Sales Header", PrepmtSalesLine, 0, PrepmtInvBuf);
                    PrepmtVATAmount := PrepmtVATAmountLine.GetTotalVATAmount();
                    PrepmtVATBaseAmount := PrepmtVATAmountLine.GetTotalVATBase();
                    PrepmtTotalAmountInclVAT := PrepmtVATAmountLine.GetTotalAmountInclVAT();

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
                    NoOfLoops := Abs(NoOfCopies) + 1;
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
                    SalesPersonText := Text000;
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
                    TotalText := StrSubstNo(Text001, GLSetup."LCY Code");
                    TotalInclVATText := Text002;
                    TotalExclVATText := Text006;
                    SousTotalText := SubtotalCaptionLbl;

                    if "Montant eco-taxe" <> 0 then
                        MentionEcoContribution := MentionEcoContribution + ' ' + GLSetup."LCY Code" + MentionEcoContribution2Lbl;
                end else begin
                    TotalText := StrSubstNo(Text001, "Currency Code");
                    TotalInclVATText := Text002;
                    TotalExclVATText := Text006;
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
                    TexteTVA := MentionTVAFR;
                    TextePenalitesRetard := PenalitesRetardFR;
                end else begin
                    TextePenalitesRetard := PenalitesRetardENU;
                    if not Pays.Get("Bill-to Country/Region Code") then
                        Pays.init();
                    if Pays."Intrastat Code" <> '' then
                        TexteTVA := MentionTVAUE
                    else
                        TexteTVA := MentionTVAExport;
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
                    field(NoOfCopies; NoOfCopies)
                    {
                        Caption = 'Nb. de copies';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        Caption = 'Afficher infos. internes';
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
        VATAmountLine: Record "VAT Amount Line" temporary;
        PrepmtVATAmountLine: Record "VAT Amount Line" temporary;
        PrepmtVATAmountLineDeduct: Record "VAT Amount Line" temporary;
        SalesLine: Record "Sales Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        TempPrepmtDimSetEntry: Record "Dimension Set Entry" temporary;
        PrepmtInvBuf: Record "Prepayment Inv. Line Buffer" temporary;
        RespCenter: Record "Responsibility Center";
        CurrExchRate: Record "Currency Exchange Rate";
        AsmHeader: Record "Assembly Header";
        AsmLine: Record "Assembly Line";

        LanguageMgt: codeunit Language;
        SalesPostPrepmt: Codeunit "Sales-Post Prepayments";
        DimMgt: Codeunit DimensionManagement;

        SalesCountPrinted: Codeunit "Sales-Printed";
        FormatAddr: Codeunit "Format Address";
        Text000: Label 'Followed by :'; //Salesperson :
        Text001: Label 'Total %1';
        Text002: Label 'Total Incl. VAT'; //FRA = Total TTC
        Text004: Label 'Proforma Invoice No.';
        Text005: Label 'Page %1';
        Text006: Label 'Total'; //FRA = Total H.T.
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
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        //LogInteraction: Boolean;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        Text007: Label 'VAT Amount Specification in ';
        Text008: Label 'Local Currency';
        Text009: Label 'Exchange rate: %1/%2';
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
        ShippingAgent: Record "Shipping Agent";
        SalesHeaderOrderDateCaptionLbl: Label 'Date :';
        SalesPersonMailCaptionLbl: Label 'E-mail';
        JobName: Text[50];
        NNCSalesLineEcoAmt: Decimal;
        LabelAffaire: Label 'Job :';
        LabelNoLocationName: Label 'No. and Location Name :';
        LabelNoRayon: Label 'Range No. : ';
        LabelInterlocuteurclient: Label 'Contact Name :';
        LabelCommentaire: Label 'Comments : ';
        LabelRequestedDeliveryDate: Label 'Delivery date:';
        DateChargementLbl: Label 'Shipment Date';
        LabelEcoTax: Label 'Including Ecocontribution Amount';
        LabelMontantRemisesLignes: Label 'Including line discounts';
        LabelRefClient: Label 'Customer Ref.';
        LabelDescription: Label 'Description';
        LabelQuantite: Label 'Qty';
        NNCVATEcoAMt: Decimal;
        MontantRemisesLignes: Decimal;
        //TotalNetWeight: Decimal;
        //LabellTotalWeight: Label 'Total Net Weight:';
        QuoteValidityCaptionLbl: Label 'Quote valid for two months.';
        QuoteAgreementLine1CaptionLbl: Label 'Agreement';
        QuoteAgreementLine2CaptionLbl: Label '(Date, signature and official stamp)';
        LabelSite: Label 'Site :';
        SiteName: Text[50];
        RecDimSetEntry: Record "Dimension Set Entry";
        LabelAgreement: Label 'In                         , the';
        LabelUnitCaption: Label 'Unit';
        LabelMarchandiseLbl: Label 'Product Information';
        LabelPalette: Label 'Number of Pallets';
        LabelOrgMse: Label 'Origine marchandise';
        LabelPays: Label 'Pays exportateur';
        LabelCurrency: Label 'Currency :';
        ExternalDocNoLbl: Label 'External Doc. No. :';
        LabelTotalGrossWeight: Label 'Total Gross Weight (kg):';
        //TotalGrossWeight: Decimal;
        LabelPackage: Label 'Number of Packages:';
        TexteTVA: Text[1024];
        MentionTVAFR: Label 'TVA sur les débits';
        MentionTVAUE: Label 'Intra-Community Supply : VAT Exemption under Article 262 ter I of the French General Tax Code';
        MentionTVAExport: Label 'VAT exempt under Article 262 I of the French General Tax Code (CGI)';
        TextePenalitesRetard: Text[1024];
        PenalitesRetardFR: label 'Pénalité de retard : 3 fois le taux d''intérêt légal en vigueur + indemnité forfaitaire de frais de recouvrement de 40 € (Art. L. 441-6 du Code du Commerce)';
        PenalitesRetardENU: Label 'Pénalité de retard : 3 fois le taux d''intérêt légal en vigueur + indemnité forfaitaire de frais de recouvrement de 40 € (Art. L. 441-6 du Code du Commerce)';
        PrepAmount: Decimal;
        LabelAcompteverse: Label 'Prepayment Amount';
        LabelMontantDejaVerse: Label 'Already Paid';
        LabelResteAPayer: Label 'Still to pay (€)';
        labelVariant: Label 'Variant';
        SousTotal: Boolean;
        ClientFrancais: Boolean;
        LabelTotalHT: Label 'Total Amount - %1 (excl. VAT)';
        txtTotalHT: Text[50];
        Chantier: Record Chantier;
        PoidsObligatoireErr: Label 'Vous devez indiquer un poids net sur la ligne %1, article %2 %3.';
        MentionEcoContribution: Text;
        MentionEcoContribution1Lbl: Label 'Ce document inclut une éco-participation de  ';
        MentionEcoContribution2Lbl: Label ' , reversée à un éco-organisme agréé conformément à la réglementation en vigueur.';
        CondPaiementAcompte: Record "Payment Terms";

        SoldeLbl: Label 'Remaining Amount:';
        txtSolde: Text[80];
        txtPaymentMethodDescription: Text;
        PaiementComptantLbl: Label 'pre-paid';
        SousTotalText: Text[50];
        Article: Record Item;
        //PaiementCaptionLbl: Label 'Payment:';
        InfosPaiement1: Text[1024];
        InfosPaiement2: Text[1024];
        FactorTable: Record Factor;
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
        LabelEscompte: Label 'No prompt-payment discount granted in the case of payment before invoice due date.';

    procedure InitializeRequest(NoOfCopiesFrom: Integer; ShowInternalInfoFrom: Boolean; ArchiveDocumentFrom: Boolean; LogInteractionFrom: Boolean; PrintFrom: Boolean; DisplayAsmInfo: Boolean)
    begin
        NoOfCopies := NoOfCopiesFrom;
        ShowInternalInfo := ShowInternalInfoFrom;
        //ArchiveDocument := ArchiveDocumentFrom;
        //LogInteraction := LogInteractionFrom;
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

