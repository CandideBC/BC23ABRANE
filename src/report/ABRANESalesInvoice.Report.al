report 50006 "ABRANE : Sales - Invoice"
{
    // DIA@NDE 20/02/15 : IncludeShptNo Forcé à Oui
    DefaultLayout = RDLC;
    RDLCLayout = 'ABRANESalesInvoice.rdlc';

    Caption = 'Facture vente';
    Permissions = TableData "Sales Shipment Buffer" = rimd;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice';
            column(No_SalesInvHdr; "No.")
            {
            }
            column(DiscPercentCaption; DiscPercentCaptionLbl)
            {
            }
            column(PmtTermsDescCaption; PmtTermsDescCaptionLbl)
            {
            }
            column(ShpMethodDescCaption; ShpMethodDescCaptionLbl)
            {
            }
            column(HomePageCaption; HomePageCaptionLbl)
            {
            }
            column(EMailCaption; EMailCaptionLbl)
            {
            }
            column(CompanyInfoNameCaption; CompanyInfoNameCaptionLbl)
            {
            }
            column(PaymentCaption; PaymentCaptionLbl)
            {
            }
            column(PhoneNoCaption; PhoneNoCaptionLbl)
            {
            }
            column(JobName_SalesInvHeader; JobName)
            {
            }
            column(LabelAffaire; LabelAffaireLbl)
            {
            }
            column(LabelNoLocationName; LabelNoLocationNameLbl)
            {
            }
            column(LabelCommentraire; LabelCommentraireLbl)
            {
            }
            column(Comments_SalesInvHeader; Commentaire)
            {
            }
            column(LabellTotalWeight; LabellTotalWeightLbl)
            {
            }
            column(LabelPalette; LabelPaletteLbl)
            {
            }
            column(LabelColis; LabelColisLbl)
            {
            }
            column(LabelEcoTax; LabelEcoTaxLbl)
            {
            }
            column(LabelSite; LabelSiteLbl)
            {
            }
            column(SiteName; SiteName)
            {
            }
            column(MontantAcpte; Prepayment)
            {
            }
            column(LabelNetaPayer; LabelNetaPayerLbl)
            {
            }
            column(LabelEcoTaxText; LabelEcoTaxTextLbl)
            {
            }
            column(NoLocationName_SalesInvHeader; "No. And Location Name")
            {
            }
            column(Facto; Factoring)
            {
            }
            column(LabelAcompte; LabelAcompteLbl)
            {
            }
            column(LabelDevis; LabelDevisLbl)
            {
            }
            column(LabelNoRayon; LabelNoRayonLbl)
            {
            }
            column(LabelInterlocuteurclient; LabelInterlocuteurclientLbl)
            {
            }
            column(LableOrder; LableOrderLbl)
            {
            }
            column(LabelRefClient; LabelRefClientLbl)
            {
            }
            column(VATLegalMention; VATLegalMention)
            {
            }
            column(PackageNumber; "Number Of Packages")
            {
            }
            column(PalletNumber; "Pallet Number")
            {
            }
            column(LabelCustOrder; LabelCustOrderLbl)
            {
            }
            column(VATMentionDebit; MentionVAT)
            {
            }
            column(TotalGrossWeight; "Sales Invoice Header"."Total Gross Weight")
            {
            }
            column(LabelTotalGrossWeight; LabelTotalGrossWeightLbl)
            {
            }
            column(PiedTxt1; PiedTxt1)
            {
            }
            column(PiedTxt2; PiedTxt2)
            {
            }
            column(LabelRefARticle; LabelRefARticleLbl)
            {
            }
            column(LabelAcompteverse; LabelAcompteverseLbl)
            {
            }
            column(labelVariant; labelVariantLbl)
            {
            }
            column(LabelMontantDejaVerse; LabelMontantDejaVerseLbl)
            {
            }
            column(LabelResteAPayer; LabelResteAPayerLbl)
            {
            }
            column(MontantDejaVerseTTC; "Sales Invoice Header"."Montant deja verse TTC")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = sorting(Number);
                column(NoOfLoops; NoOfLoops)
                {
                }
                column(OutputNoOLD; OutputNo)
                {
                }
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = const(1));
                    column(CompanyInfoPicture; CompanyInfo.Picture)
                    {
                    }
                    column(DocCaptCopyText; StrSubstNo(DocumentCaption(), CopyText))
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
                    column(CompanyInfoBankAccountNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(CompanyInfoHomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfoEMail; CompanyInfo."E-Mail")
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
                    column(BilltoCustNo_SalesInvHdr; "Sales Invoice Header"."Bill-to Customer No.")
                    {
                    }
                    column(SelltoCustNoCaption; SelltoCustNoCaptionLbl)
                    {
                    }
                    column(SelltoCustomerNo_SalesInvHeader; "Sales Invoice Header"."Sell-to Customer No.")
                    {
                    }
                    column(PostingDate_SalesInvHdr; "Sales Invoice Header"."Posting Date")
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_SalesInvHdr; "Sales Invoice Header"."VAT Registration No.")
                    {
                    }
                    column(DueDate_SalesInvHdr; "Sales Invoice Header"."Due Date")
                    {
                    }
                    column(SalesPersonText; SalesPersonText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(SalesPurchPersonMail; SalesPurchPerson_PhoneNoEmail())
                    {
                    }
                    column(No1_SalesInvHdr; "Sales Invoice Header"."No.")
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(YourRef_SalesInvHdr; "Sales Invoice Header"."Your Reference")
                    {
                    }
                    column(ExternalDocumentNo_SalesInvHeader; "Sales Invoice Header"."External Document No.")
                    {
                    }
                    column(OrderNoText; OrderNoText)
                    {
                    }
                    column(OrderNo_SalesInvHdr; txtOrderNo)
                    {
                    }
                    column(QuoteNo_SalesInvHdr; "Sales Invoice Header"."Quote No.")
                    {
                    }
                    column(DocDate_SalesInvHdr; Format("Sales Invoice Header"."Document Date", 0, 4))
                    {
                    }
                    column(PricesInclVAT_SalesInvHdr; "Sales Invoice Header"."Prices Including VAT")
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PricesInclVAT1_SalesInvHdr; Format("Sales Invoice Header"."Prices Including VAT"))
                    {
                    }
                    column(PageCaption; StrSubstNo(Text005Lbl, ''))
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
                    column(VATRegNoCaption; VATRegNoCaptionLbl)
                    {
                    }
                    column(GiroNoCaption; GiroNoCaptionLbl)
                    {
                    }
                    column(BankNameCaption; BankNameCaptionLbl)
                    {
                    }
                    column(BankAccNoCaption; BankAccNoCaptionLbl)
                    {
                    }
                    column(DueDateCaption; DueDateCaptionLbl)
                    {
                    }
                    column(InvoiceNoCaption; InvoiceNoCaptionLbl)
                    {
                    }
                    column(PostingDateCaption; PostingDateCaptionLbl)
                    {
                    }
                    column(CompanyInfoFaxNoCaption; CompanyInfoFaxNoCaptionLbl)
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
                    column(CompanyInfoVATRegNoCaption; CompanyInfoVATRegNoCaptionLbl)
                    {
                    }
                    column(TexteFacto1; SalesSetup."Notice Factor FR")
                    {
                    }
                    column(TexteFacto2; SalesSetup."Notice Factor FR 2")
                    {
                    }
                    column(TexteFacto3; SalesSetup."Notice Factor FR 3")
                    {
                    }
                    column(BilltoCustNo_SalesInvHdrCaption; "Sales Invoice Header".FieldCaption("Bill-to Customer No."))
                    {
                    }
                    column(PricesInclVAT_SalesInvHdrCaption; "Sales Invoice Header".FieldCaption("Prices Including VAT"))
                    {
                    }
                    column(SelltoAddrCaption; SellltoAddrCaptionLbl)
                    {
                    }
                    column(SellToAddr1; SellToAddr[1])
                    {
                    }
                    column(SellToAddr2; SellToAddr[2])
                    {
                    }
                    column(SellToAddr3; SellToAddr[3])
                    {
                    }
                    column(SellToAddr4; SellToAddr[4])
                    {
                    }
                    column(SellToAddr5; SellToAddr[5])
                    {
                    }
                    column(SellToAddr6; SellToAddr[6])
                    {
                    }
                    column(SellToAddr7; SellToAddr[7])
                    {
                    }
                    column(SellToAddr8; SellToAddr[8])
                    {
                    }
                    column(SelltoCustNo_SalesInvHdr; "Sales Invoice Header"."Sell-to Customer No.")
                    {
                    }
                    column(Contact_SalesInvHdr; "Sales Invoice Header"."Sell-to Contact")
                    {
                    }
                    column(Range_SalesInvHdr; "Sales Invoice Header"."Range No.")
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
                    column(ShiptoAddrCaption; ShiptoAddrCaptionLbl)
                    {
                    }
                    column(SelltoCustNo_SalesInvHdrCaption; "Sales Invoice Header".FieldCaption("Sell-to Customer No."))
                    {
                    }
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = sorting(Number) where(Number = filter(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(Number_DimensionLoop1; DimensionLoop1.Number)
                        {
                        }
                        column(HdrDimsCaption; HdrDimsCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then begin
                                if not DimSetEntry1.FindSet() then
                                    CurrReport.Break();
                            end else
                                if not Continue then
                                    CurrReport.Break();

                            Clear(DimText);
                            Continue := false;
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
                            until (DimSetEntry1.Next()) = 0;
                        end;

                        trigger OnPreDataItem()
                        begin
                            if not ShowInternalInfo then
                                CurrReport.Break();
                        end;
                    }
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = field("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = sorting("Document No.", "Line No.") where("Linked to line" = const(0));
                        column(PrepAmount; -PrepAmount)
                        {
                        }
                        column(PrepLine; "Sales Invoice Line"."Ligne deduction acompte")
                        {
                        }
                        column(LineAmt_SalesInvLine; "Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(Desc_SalesInvLine; Description + ' ' + "Description 2")
                        {
                        }
                        column(No_SalesInvLine; codNoImprime)
                        {
                        }
                        column(Variante; "Sales Invoice Line"."Variant Code")
                        {
                        }
                        column(Quantity_SalesInvLine; Quantity)
                        {
                        }
                        column(UnitofMeasure_SalesInvLine; "Unit of Measure")
                        {
                        }
                        column(UnitPrice_SalesInvLine; "Unit Price")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 2;
                        }
                        column(LineDisc_SalesLine; "Line Discount %")
                        {
                        }
                        column(VATIdentifier_SalesInvLine; "VAT Identifier")
                        {
                        }
                        column(PostedShipmentDate; Format(PostedShipmentDate))
                        {
                        }
                        column(Type_SalesInvLine; Format("Sales Invoice Line".Type))
                        {
                        }
                        column(GetTotalLineAmt; GetTotalLineAmount)
                        {
                        }
                        column(GetTotalAmtIncVAT; GetTotalAmountIncVAT)
                        {
                        }
                        column(InvDiscAmt; -"Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(TotalSubTotal; TotalSubTotal)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInvoiceDiscAmt; TotalInvoiceDiscountAmount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(TotalWeight; TotalWeight)
                        {
                        }
                        column(Amt_SalesInvLine; Amount)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(TotalAmt; TotalAmount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AmtIncludingVATAmt_SalesInvLine; "Amount Including VAT" - Amount)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(AmtInclVAT_SalesInvLine; "Amount Including VAT")
                        {
                            AutoFormatExpression = ("Sales Invoice Line".GetCurrencyCode());
                            AutoFormatType = 1;
                        }
                        column(VATAmtText_SalesInvLine; TempVATAmountLine.VATAmountText())
                        {
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(TotalAmtInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmtVAT; TotalAmountVAT)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(NNCSalesLineEcoAmt; NNCSalesLineEcoAmt)
                        {
                        }
                        column(NNCVATEcoAMt; NNCVATEcoAMt)
                        {
                        }
                        column(VATBaseDisc_SalesInvHdr; "Sales Invoice Header"."VAT Base Discount %")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalPaymentDiscOnVAT; TotalPaymentDiscountOnVAT)
                        {
                            AutoFormatType = 1;
                        }
                        column(EcoMob; "Eco Tax Furniture Line")
                        {
                        }
                        column(LineNo_SalesInvLine; "Line No.")
                        {
                        }
                        column(UnitPriceCaption; UnitPriceCaptionLbl)
                        {
                        }
                        column(AmtCaption; AmtCaptionLbl)
                        {
                        }
                        column(PostedShpDateCaption; PostedShpDateCaptionLbl)
                        {
                        }
                        column(InvDiscAmtCaption; InvDiscAmtCaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(PmtDiscVATCaption; PmtDiscVATCaptionLbl)
                        {
                        }
                        column(Desc_SalesInvLineCaption; FieldCaption(Description))
                        {
                        }
                        column(No_SalesInvLineCaption; FieldCaption("No."))
                        {
                        }
                        column(Quantity_SalesInvLineCaption; FieldCaption(Quantity))
                        {
                        }
                        column(UnitofMeasure_SalesInvLineCaption; UnitofMeasure_SalesInvLineCaptionLbl)
                        {
                        }
                        column(VATIdentifier_SalesInvLineCaption; FieldCaption("VAT Identifier"))
                        {
                        }
                        column(SalesLineQuantityCaption; SalesLineQuantityCaptionLbl)
                        {
                        }
                        dataitem("Sales Shipment Buffer"; "Integer")
                        {
                            DataItemTableView = sorting(Number);
                            column(SalesShipmentBufferPostingDate; Format(TempSalesShipmentBuffer."Posting Date"))
                            {
                            }
                            column(SalesShipmentBufferQty; TempSalesShipmentBuffer.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(ShpCaption; ShpCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then
                                    TempSalesShipmentBuffer.Find('-')
                                else
                                    TempSalesShipmentBuffer.Next();
                            end;

                            trigger OnPreDataItem()
                            begin
                                TempSalesShipmentBuffer.SetRange("Document No.", "Sales Invoice Line"."Document No.");
                                TempSalesShipmentBuffer.SetRange("Line No.", "Sales Invoice Line"."Line No.");

                                SetRange(Number, 1, TempSalesShipmentBuffer.Count);
                            end;
                        }
                        dataitem(DimensionLoop2; "Integer")
                        {
                            DataItemTableView = sorting(Number) where(Number = filter(1 ..));
                            column(DimText1; DimText)
                            {
                            }
                            column(LineDimsCaption; LineDimsCaptionLbl)
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

                                DimSetEntry2.SetRange("Dimension Set ID", "Sales Invoice Line"."Dimension Set ID");
                            end;
                        }
                        dataitem(AsmLoop; "Integer")
                        {
                            DataItemTableView = sorting(Number);
                            column(TempPostedAsmLineUOMCode; GetUOMText(TempPostedAsmLine."Unit of Measure Code"))
                            {
                            }
                            column(TempPostedAsmLineQty; TempPostedAsmLine.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(TempPostedAsmLineVariantCode; BlanksForIndent() + TempPostedAsmLine."Variant Code")
                            {
                            }
                            column(TempPostedAsmLineDesc; BlanksForIndent() + TempPostedAsmLine.Description)
                            {
                            }
                            column(TempPostedAsmLineNo; BlanksForIndent() + TempPostedAsmLine."No.")
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then
                                    TempPostedAsmLine.FindSet()
                                else
                                    TempPostedAsmLine.Next();
                            end;

                            trigger OnPreDataItem()
                            begin
                                Clear(TempPostedAsmLine);
                                if not DisplayAssemblyInformation then
                                    CurrReport.Break();
                                CollectAsmInformation();
                                Clear(TempPostedAsmLine);
                                SetRange(Number, 1, TempPostedAsmLine.Count);
                            end;
                        }
                        dataitem(ShipmentDatas; "Integer")
                        {
                            DataItemTableView = sorting(Number);
                            column(NoShipmentText; NoShipmentText)
                            {
                            }
                            column(NoShipmentDatas1; NoShipmentDatas[1])
                            {
                            }
                            column(NoShipmentDatas2; NoShipmentDatas[2])
                            {
                            }
                            column(NoShipmentDatas3; NoShipmentDatas[3])
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                // FR0001.begin
                                Clear(NoShipmentDatas);
                                NoShipmentNumLoop := 0;
                                if Number = 1 then begin
                                    ShipmentInvoiced.Find('-');

                                    NoShipmentText := Text10800Lbl;
                                    repeat
                                        ShipmentInvoiced.CalcFields("Shipment Date");
                                        NoShipmentNumLoop := NoShipmentNumLoop + 1;
                                        NoShipmentDatas[NoShipmentNumLoop] := ShipmentInvoiced."Shipment No." + ' du ' + Format(ShipmentInvoiced."Shipment Date");
                                    until (ShipmentInvoiced.Next() = 0) or (NoShipmentNumLoop = 2);
                                end else begin
                                    NoShipmentText := '';
                                    repeat
                                        ShipmentInvoiced.CalcFields("Shipment Date");
                                        NoShipmentNumLoop := NoShipmentNumLoop + 1;
                                        NoShipmentDatas[NoShipmentNumLoop] := ShipmentInvoiced."Shipment No." + ' du ' + Format(ShipmentInvoiced."Shipment Date");
                                        Message('je passe');
                                    until (ShipmentInvoiced.Next() = 0) or (NoShipmentNumLoop = 2);
                                end;
                                // FR0001.end
                            end;

                            trigger OnPreDataItem()
                            begin
                                // FR0001.begin
                                if not IncludeShptNo then
                                    CurrReport.Break();

                                if "Sales Invoice Line"."Eco Tax Furniture Line" then
                                    CurrReport.Break();
                                if "Sales Invoice Line".Type = "Sales Invoice Line".Type::"G/L Account" then
                                    CurrReport.Break();

                                if ShipmentInvoiced.Count < 1 then
                                    CurrReport.Break();
                                ShipmentDatas.SetRange(Number, 1, Round(ShipmentInvoiced.Count / 3, 1, '>'));
                                // FR0001.end
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            PostedShipmentDate := 0D;
                            if Quantity <> 0 then
                                PostedShipmentDate := FindPostedShipmentDate();

                            if (Type = Type::"G/L Account") and (not ShowInternalInfo) then
                                "No." := '';

                            TempVATAmountLine.Init();
                            TempVATAmountLine."VAT Identifier" := "VAT Identifier";
                            TempVATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                            TempVATAmountLine."Tax Group Code" := "Tax Group Code";
                            TempVATAmountLine."VAT %" := "VAT %";
                            TempVATAmountLine."VAT Base" := Amount;
                            TempVATAmountLine."Amount Including VAT" := "Amount Including VAT";
                            TempVATAmountLine."Line Amount" := "Line Amount";
                            if "Allow Invoice Disc." then
                                TempVATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                            TempVATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                            TempVATAmountLine.InsertLine();
                            //TotalWeight+="Net Weight"*Quantity;
                            TotalSubTotal += "Line Amount";
                            TotalInvoiceDiscountAmount -= "Inv. Discount Amount";
                            TotalAmount += Amount;
                            TotalAmountVAT += "Amount Including VAT" - Amount;
                            TotalAmountInclVAT += "Amount Including VAT";
                            TotalPaymentDiscountOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");
                            //
                            if "Eco Tax Furniture Line" then begin
                                NNCSalesLineEcoAmt += "Line Amount";
                                NNCVATEcoAMt += "Amount Including VAT" - Amount;
                            end;

                            //DIA£NBE 17/02/2015 DEBUT
                            if "Sales Invoice Line"."Explode Line" = false then
                                TotalWeight += "Net Weight" * Quantity
                            else begin
                                recLigneFacture.Reset();
                                recLigneFacture.SetRange("Document No.", "Document No.");
                                recLigneFacture.SetRange("Linked to line", "Line No.");
                                if recLigneFacture.FindSet(false) then
                                    repeat
                                        TotalWeight += recLigneFacture."Net Weight" * recLigneFacture.Quantity
                                    until recLigneFacture.Next() = 0;

                            end;
                            if "Sales Invoice Header"."Total Net Weight" <> 0 then
                                TotalWeight := "Sales Invoice Header"."Total Net Weight";

                            codNoImprime := "No.";
                            if "Item Reference No." <> '' then
                                codNoImprime := "Item Reference No.";
                            //DIA£NBE 17/02/2015 FIN

                            // FR0001.begin
                            if IncludeShptNo then begin
                                ShipmentInvoiced.Reset();
                                ShipmentInvoiced.SetRange("Invoice No.", "Sales Invoice Line"."Document No.");
                                ShipmentInvoiced.SetRange("Invoice Line No.", "Sales Invoice Line"."Line No.");
                            end;
                            // FR0001.end

                            //Gestion des acomptes
                            if "Ligne deduction acompte" then
                                PrepAmount += "Line Amount";
                        end;

                        trigger OnPreDataItem()
                        begin
                            TempVATAmountLine.DeleteAll();
                            TempSalesShipmentBuffer.Reset();
                            TempSalesShipmentBuffer.DeleteAll();
                            FirstValueEntryNo := 0;
                            MoreLines := Find('+');
                            while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) and (Amount = 0) do
                                MoreLines := Next(-1) <> 0;
                            if not MoreLines then
                                CurrReport.Break();
                            SetRange("Line No.", 0, "Line No.");
                            CurrReport.CreateTotals("Line Amount", Amount, "Amount Including VAT", "Inv. Discount Amount");

                            GetTotalLineAmount := 0;
                            //GetTotalInvDiscAmount := 0;
                            //GetTotalAmount := 0;
                            GetTotalAmountIncVAT := 0;
                            NNCSalesLineEcoAmt := 0;
                            TotalWeight := 0;
                            NNCVATEcoAMt := 0;
                            //DIA.SCH - 15/04/15 - P1 gestion des acomptes
                            PrepAmount := 0;
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = sorting(Number);
                        column(VATAmtLineVATBase; TempVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; TempVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; TempVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvoiceDiscAmt; TempVATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT; TempVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier; TempVATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATPercentCaption; VATPercentCaptionLbl)
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
                        column(VATIdentCaption; VATIdentCaptionLbl)
                        {
                        }
                        column(InvDiscBaseAmtCaption; InvDiscBaseAmtCaptionLbl)
                        {
                        }
                        column(LineAmtCaption; LineAmtCaptionLbl)
                        {
                        }
                        column(InvDiscAmtCaption1; InvDiscAmtCaption1Lbl)
                        {
                        }
                        column(TotalCaption; TotalCaptionLbl)
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
                            SetRange(Number, 1, TempVATAmountLine.Count);
                            CurrReport.CreateTotals(
                              TempVATAmountLine."Line Amount", TempVATAmountLine."Inv. Disc. Base Amount",
                              TempVATAmountLine."Invoice Discount Amount", TempVATAmountLine."VAT Base", TempVATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VatCounterLCY; "Integer")
                    {
                        DataItemTableView = sorting(Number);
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
                        {
                        }
                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmtLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT1; TempVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier1; TempVATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);

                            VALVATBaseLCY := Round(TempVATAmountLine."VAT Base" / "Sales Invoice Header"."Currency Factor");
                            VALVATAmountLCY := Round(TempVATAmountLine."VAT Amount" / "Sales Invoice Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            if (not GLSetup."Print VAT specification in LCY") or
                               ("Sales Invoice Header"."Currency Code" = '')
                            then
                                CurrReport.Break();

                            SetRange(Number, 1, TempVATAmountLine.Count);
                            CurrReport.CreateTotals(VALVATBaseLCY, VALVATAmountLCY);

                            if GLSetup."LCY Code" = '' then
                                VALSpecLCYHeader := Text007Lbl + Text008Lbl
                            else
                                VALSpecLCYHeader := Text007Lbl + Format(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code", 1);
                            CalculatedExchRate := Round(1 / "Sales Invoice Header"."Currency Factor" * CurrExchRate."Exchange Rate Amount", 0.000001);
                            VALExchRate := StrSubstNo(Text009Lbl, CalculatedExchRate, CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total; "Integer")
                    {
                        DataItemTableView = sorting(Number) where(Number = const(1));
                    }
                    dataitem(Total2; "Integer")
                    {
                        DataItemTableView = sorting(Number) where(Number = const(1));

                        trigger OnPreDataItem()
                        begin
                            if not ShowShippingAddr then
                                CurrReport.Break();
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    //DIA.SCH - P11
                    if Number > 1 then
                        OutputNo += 1;

                    //Migration CurrReport.PageNo := 1;

                    TotalSubTotal := 0;
                    TotalInvoiceDiscountAmount := 0;
                    TotalAmount := 0;
                    TotalAmountVAT := 0;
                    TotalAmountInclVAT := 0;
                    TotalPaymentDiscountOnVAT := 0;

                    //DIA.SCH - 15/04/15 - P1 gestion des acomptes
                    PrepAmount := 0;
                end;

                trigger OnPostDataItem()
                begin
                    //IF NOT CurrReport.PREVIEW THEN
                    //  SalesInvCountPrinted.RUN("Sales Invoice Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := Abs(NoOfCopies) + Cust."Invoice Copies" + 1;
                    if NoOfLoops <= 0 then
                        NoOfLoops := 1;
                    CopyText := '';
                    SetRange(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.Language := LanguageMgt.GetLanguageID("Language Code");

                if RespCenter.Get("Responsibility Center") then begin
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                end else
                    FormatAddr.Company(CompanyAddr, CompanyInfo);


                DimSetEntry1.SetRange("Dimension Set ID", "Dimension Set ID");

                if "Order No." = '' then
                    OrderNoText := ''
                else
                    OrderNoText := copystr(FieldCaption("Order No."), 1, 80);
                if "Salesperson Code" = '' then begin
                    SalesPurchPerson.Init();
                    SalesPersonText := '';
                end else begin
                    SalesPurchPerson.Get("Salesperson Code");
                    SalesPersonText := Text000Lbl;
                end;

                if ("Sales Invoice Header"."Facture acompte") and
                    ("Sales Invoice Header"."Acompte pour type doc." = "Sales Invoice Header"."Acompte pour type doc."::Commande) and
                    ("Sales Invoice Header"."Acompte pour No. document" <> '')
                then
                    txtOrderNo := "Sales Invoice Header"."Acompte pour No. document"
                else
                    txtOrderNo := "Sales Invoice Header"."Order No.";

                ReferenceText := copystr(FieldCaption("Your Reference"), 1, 80);

                VATNoText := copystr(FieldCaption("VAT Registration No."), 1, 80);

                if ("Sales Invoice Header"."Bill-to Country/Region Code" = '') or ("Sales Invoice Header"."Bill-to Country/Region Code" = CompanyInfo."Country/Region Code") then
                    MentionVAT := VATMentionDebitLbl
                else
                    MentionVAT := VATMentionDebitExportLbl;
                GLSetup.Get();
                SiteName := '';
                if "Code chantier" <> '' then begin
                    Chantier.Get("Code chantier");
                    SiteName := Chantier."Description chantier";
                end else
                    if RecDimSetEntry.Get("Dimension Set ID", GLSetup."Shortcut Dimension 3 Code") then begin
                        RecDimSetEntry.CalcFields("Dimension Value Name");
                        SiteName := RecDimSetEntry."Dimension Value Name";
                    end; 

                if "Currency Code" = '' then begin
                    GLSetup.TestField("LCY Code");
                    TotalText := StrSubstNo(Text001Lbl, GLSetup."LCY Code");
                    TotalInclVATText := StrSubstNo(Text002Lbl, GLSetup."LCY Code");
                    TotalExclVATText := StrSubstNo(Text006Lbl, GLSetup."LCY Code");
                end else begin
                    TotalText := StrSubstNo(Text001Lbl, "Currency Code");
                    TotalInclVATText := StrSubstNo(Text002Lbl, "Currency Code");
                    TotalExclVATText := StrSubstNo(Text006Lbl, "Currency Code");
                end;
                FormatAddr.SalesInvBillTo(CustAddr, "Sales Invoice Header");

                FormatAddr.SalesInvSellTo(SellToAddr, "Sales Invoice Header");

                if not PaymentMethod.Get("Payment Method Code") then
                    PaymentMethod.Init();

                if not Cust.Get("Bill-to Customer No.") then
                    Clear(Cust);

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
                FormatAddr.SalesInvShipTo(ShipToAddr, CustAddr, "Sales Invoice Header");

                ShowShippingAddr := true;

                if LogInteraction then
                    if "Bill-to Contact No." <> '' then
                        SegManagement.LogDocument(
                          4, "No.", 0, 0, DATABASE::Contact, "Bill-to Contact No.", "Salesperson Code",
                          "Campaign No.", "Posting Description", '')
                    else
                        SegManagement.LogDocument(
                          4, "No.", 0, 0, DATABASE::Customer, "Bill-to Customer No.", "Salesperson Code",
                          "Campaign No.", "Posting Description", '');

                VATLegalMention := '';
                RecVatposting.SetFilter("VAT Clause Code", '>%1', '');

                RecVatposting.SetRange("VAT Bus. Posting Group", "VAT Bus. Posting Group");
                if RecVatposting.FindSet(false) then begin
                    if recVatClause.Get(RecVatposting."VAT Clause Code") then;
                    if recVatClause.Description <> '' then
                        VATLegalMention := recVatClause.Description + ' ' + recVatClause."Description 2"
                    else
                        VATLegalMention := '';
                end;
                if "Factor Code" <> '' then begin
                    FactorTable.Get("Factor Code");
                    PiedTxt1 := FactorTable."Text 1" + ' ' + FactorTable."Text 2" + '<br>' + FactorTable."Text 3" + '</br>';
                end else
                    PiedTxt1 := CompanyInfo."Bank Name" + ' - IBAN ' + CompanyInfo.IBAN + ' - BIC ' + CompanyInfo."SWIFT Code";

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
                        Caption = 'Nombre de copies';
                        ToolTip = 'Nombre de copies';
                    }
                    field(ShowInternalInfoField; ShowInternalInfo)
                    {
                        Caption = 'Afficher infos. internes';
                        ToolTip = 'Afficher infos. internes';
                        Visible = false;
                    }
                    field(LogInteractionField; LogInteraction)
                    {
                        Caption = 'Créer interaction';
                        ToolTip = 'Créer interaction';
                        Enabled = LogInteractionEnable;
                    }
                    field(IncludeShptNoField; IncludeShptNo)
                    {
                        Caption = 'Inclure N° BL';
                        ToolTip = 'Inclure N° BL';
                    }
                    field(DisplayAsmInformation; DisplayAssemblyInformation)
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

        trigger OnInit()
        begin
            LogInteractionEnable := true;
        end;

        trigger OnOpenPage()
        begin
            InitLogInteraction();
            LogInteractionEnable := LogInteraction;
            //>>DIA@NDE 20/02/15
            IncludeShptNo := false; //SCH - 220515
            //<<
        end;
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
        CompanyInfo.Get();
        SalesSetup.Get();

        CompanyInfo.CalcFields(Picture);
    end;

    trigger OnPreReport()
    begin

        if not CurrReport.UseRequestPage then
            InitLogInteraction();
    end;

    var
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        Cust: Record Customer;
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        RespCenter: Record "Responsibility Center";

        CurrExchRate: Record "Currency Exchange Rate";
        TempPostedAsmLine: Record "Posted Assembly Line" temporary;
        TempSalesShipmentBuffer: Record "Sales Shipment Buffer" temporary;
        ShipmentInvoiced: Record "Shipment Invoiced";
        PaymentMethod: Record "Payment Method";
        recVatClause: Record "VAT Clause";
        RecVatposting: Record "VAT Posting Setup";
        RecDimSetEntry: Record "Dimension Set Entry";
        recLigneFacture: Record "Sales Invoice Line";
        FactorTable: Record Factor;
        Chantier: Record Chantier;
        SegManagement: Codeunit SegManagement;
        LanguageMgt: codeunit Language;
        FormatAddr: Codeunit "Format Address";
        Text000Lbl: Label 'Salesperson';
        Text001Lbl: Label 'Total %1', Comment = '%1 = Devise';
        Text002Lbl: Label 'Total %1 Incl. VAT', Comment = '%1 = Devise';
        Text004Lbl: Label 'Invoice No.%1', Comment = '%1 = N° factire';
        Text005Lbl: Label 'Page %1', Comment = '%1 = N° page';
        Text006Lbl: Label 'Total %1 Excl. VAT', Comment = '%1 = Devise';
        PostedShipmentDate: Date;
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        OrderNoText: Text[80];
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
        ShowShippingAddr: Boolean;
        NextEntryNo: Integer;
        FirstValueEntryNo: Integer;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        Text007Lbl: Label 'VAT Amount Specification in ';
        Text008Lbl: Label 'Local Currency';
        VALExchRate: Text[50];
        Text009Lbl: Label 'Exchange rate: %1/%2', Comment = '%1 = Devise 1 , %2 = Devise 2';
        Text010Lbl: Label 'Ventes - Facture acompte %1', Comment = '%1 = N° facture';
        Text10800Lbl: Label '  Exp. : ';
        CalculatedExchRate: Decimal;
        OutputNo: Integer;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvoiceDiscountAmount: Decimal;
        TotalPaymentDiscountOnVAT: Decimal;

        NoShipmentNumLoop: Integer;
        NoShipmentDatas: array[3] of Text[25];
        NoShipmentText: Text[30];
        IncludeShptNo: Boolean;
        GetTotalLineAmount: Decimal;
        GetTotalAmountIncVAT: Decimal;
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        PhoneNoCaptionLbl: Label 'Phone No.';
        VATRegNoCaptionLbl: Label 'VAT Registration No.';
        GiroNoCaptionLbl: Label 'Giro No.';
        BankNameCaptionLbl: Label 'Bank';
        BankAccNoCaptionLbl: Label 'Account No.';
        DueDateCaptionLbl: Label 'Due Date';
        InvoiceNoCaptionLbl: Label 'Invoice No.';
        PostingDateCaptionLbl: Label 'Date :';
        HdrDimsCaptionLbl: Label 'Header Dimensions';
        UnitPriceCaptionLbl: Label 'Unit Price';
        DiscPercentCaptionLbl: Label 'Disc %';
        AmtCaptionLbl: Label 'Amount';
        PostedShpDateCaptionLbl: Label 'Posted Shipment Date';
        InvDiscAmtCaptionLbl: Label 'Inv. Discount Amount';
        SubtotalCaptionLbl: Label 'Subtotal';
        PmtDiscVATCaptionLbl: Label 'Payment Discount on VAT';
        ShpCaptionLbl: Label 'Shipment';
        LineDimsCaptionLbl: Label 'Line Dimensions';
        VATPercentCaptionLbl: Label 'VAT %';
        VATBaseCaptionLbl: Label 'VAT Base';
        VATAmtCaptionLbl: Label 'VAT Amount';
        VATAmtSpecCaptionLbl: Label 'VAT Amount Specification';
        VATIdentCaptionLbl: Label 'VAT Identifier';
        InvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount';
        LineAmtCaptionLbl: Label 'Line Amount';
        InvDiscAmtCaption1Lbl: Label 'Invoice Discount Amount';
        TotalCaptionLbl: Label 'Total';
        ShiptoAddrCaptionLbl: Label 'Ship-to Address';
        PmtTermsDescCaptionLbl: Label 'Payment Terms';
        ShpMethodDescCaptionLbl: Label 'Incoterm :';
        HomePageCaptionLbl: Label 'Home Page';
        EMailCaptionLbl: Label 'E-Mail';
        CompanyInfoFaxNoCaptionLbl: Label 'Fax No.';
        CompanyInfoVATRegNoCaptionLbl: Label 'VAT Registration No.';
        ContactCaptionLbl: Label 'For the attention of ';
        CompanyInfoStockCapitalCaptionLbl: Label 'with a capital of';
        CompanyInfoAPECodeCaptionLbl: Label 'APE Code';
        CompanyInfoIBANCaptionLbl: Label 'IBAN';
        CompanyInfoSWIFTCodeCaptionLbl: Label 'SWIFT Code';
        SalesLineQuantityCaptionLbl: Label 'Qty';
        UnitofMeasure_SalesInvLineCaptionLbl: Label 'UOM';
        SelltoCustNoCaptionLbl: Label 'Customer No.';

        SellltoAddrCaptionLbl: Label 'Bill-To Address';
        CompanyInfoNameCaptionLbl: Label 'Siège social';
        PaymentCaptionLbl: Label 'Payment :';
        SellToAddr: array[8] of Text[50];
        JobName: Text[50];
        LabelAffaireLbl: Label 'Job :';
        LabelNoLocationNameLbl: Label 'No. and Location Name :';
        LabelCommentraireLbl: Label 'Comments : ';
        LabellTotalWeightLbl: Label 'Total Net Weight :';
        LabelPaletteLbl: Label 'Palette''s Number';
        LabelColisLbl: Label 'Package''s Number';
        LabelNetaPayerLbl: Label 'Net Cash';
        NNCSalesLineEcoAmt: Decimal;
        NNCVATEcoAMt: Decimal;
        TotalWeight: Decimal;
        LabelAcompteLbl: Label 'Prepayment';

        VATLegalMention: Text;

        LabelSiteLbl: Label 'Site :';
        SiteName: Text[50];

        LabelEcoTaxLbl: Label 'Eco Tax Furniture';
        LabelEcoTaxTextLbl: Label 'Eco Tax VAT';
        LabelDevisLbl: Label 'Quote No. :';
        LabelNoRayonLbl: Label 'Range No. : ';
        LabelInterlocuteurclientLbl: Label 'Contact Name :';
        LableOrderLbl: Label 'Order No. :';
        LabelRefClientLbl: Label 'Customer Order No. :';
        LabelCustOrderLbl: Label 'Customer Order No. :';
        LabelTotalGrossWeightLbl: Label 'Total Gross Weight:';
        VATMentionDebitLbl: Label '* VAT paid on debits - No discount granted';
        PiedTxt1: Text[1024];
        PiedTxt2: Text[1024];
        VATMentionDebitExportLbl: Label '* No discount granted';
        LabelRefARticleLbl: Label 'Item Ref.';

        codNoImprime: Code[50];
        PrepAmount: Decimal;
        LabelAcompteverseLbl: Label 'Prepayment';

        labelVariantLbl: Label 'Variant';
        MentionVAT: Text;
        txtOrderNo: Code[20];

        LabelMontantDejaVerseLbl: Label 'Amount Already Paid:';
        LabelResteAPayerLbl: Label 'Remaining Amount to Pay:';

    procedure InitLogInteraction()
    begin
        //Migration LogInteraction := SegManagement.FindInteractTmplCode(4) <> '';
    end;

    procedure FindPostedShipmentDate(): Date
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
        TempSalesShipmentBuffer2: Record "Sales Shipment Buffer" temporary;
    begin
        NextEntryNo := 1;
        if "Sales Invoice Line"."Shipment No." <> '' then
            if SalesShipmentHeader.Get("Sales Invoice Line"."Shipment No.") then
                exit(SalesShipmentHeader."Posting Date");

        if "Sales Invoice Header"."Order No." = '' then
            exit("Sales Invoice Header"."Posting Date");

        case "Sales Invoice Line".Type of
            "Sales Invoice Line".Type::Item:
                GenerateBufferFromValueEntry("Sales Invoice Line");
            "Sales Invoice Line".Type::"G/L Account", "Sales Invoice Line".Type::Resource,
          "Sales Invoice Line".Type::"Charge (Item)", "Sales Invoice Line".Type::"Fixed Asset":
                GenerateBufferFromShipment("Sales Invoice Line");
            "Sales Invoice Line".Type::" ":
                exit(0D);
        end;

        TempSalesShipmentBuffer.Reset();
        TempSalesShipmentBuffer.SetRange("Document No.", "Sales Invoice Line"."Document No.");
        TempSalesShipmentBuffer.SetRange("Line No.", "Sales Invoice Line"."Line No.");
        if TempSalesShipmentBuffer.Find('-') then begin
            TempSalesShipmentBuffer2 := TempSalesShipmentBuffer;
            if TempSalesShipmentBuffer.Next() = 0 then begin
                TempSalesShipmentBuffer.Get(
                  TempSalesShipmentBuffer2."Document No.", TempSalesShipmentBuffer2."Line No.", TempSalesShipmentBuffer2."Entry No.");
                TempSalesShipmentBuffer.Delete();
                exit(TempSalesShipmentBuffer2."Posting Date");
            end;
            TempSalesShipmentBuffer.CalcSums(Quantity);
            if TempSalesShipmentBuffer.Quantity <> "Sales Invoice Line".Quantity then begin
                TempSalesShipmentBuffer.DeleteAll();
                exit("Sales Invoice Header"."Posting Date");
            end;
        end else
            exit("Sales Invoice Header"."Posting Date");
    end;

    procedure GenerateBufferFromValueEntry(SalesInvoiceLine2: Record "Sales Invoice Line")
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity := SalesInvoiceLine2."Quantity (Base)";
        ValueEntry.SetCurrentKey("Document No.");
        ValueEntry.SetRange("Document No.", SalesInvoiceLine2."Document No.");
        ValueEntry.SetRange("Posting Date", "Sales Invoice Header"."Posting Date");
        ValueEntry.SetRange("Item Charge No.", '');
        ValueEntry.SetFilter("Entry No.", '%1..', FirstValueEntryNo);
        if ValueEntry.Find('-') then
            repeat
                if ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.") then begin
                    if SalesInvoiceLine2."Qty. per Unit of Measure" <> 0 then
                        Quantity := ValueEntry."Invoiced Quantity" / SalesInvoiceLine2."Qty. per Unit of Measure"
                    else
                        Quantity := ValueEntry."Invoiced Quantity";
                    AddBufferEntry(
                      SalesInvoiceLine2,
                      -Quantity,
                      ItemLedgerEntry."Posting Date");
                    TotalQuantity := TotalQuantity + ValueEntry."Invoiced Quantity";
                end;
                FirstValueEntryNo := ValueEntry."Entry No." + 1;
            until (ValueEntry.Next() = 0) or (TotalQuantity = 0);
    end;

    procedure GenerateBufferFromShipment(SalesInvoiceLine: Record "Sales Invoice Line")
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine2: Record "Sales Invoice Line";
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity := 0;
        SalesInvoiceHeader.SetCurrentKey("Order No.");
        SalesInvoiceHeader.SetFilter("No.", '..%1', "Sales Invoice Header"."No.");
        SalesInvoiceHeader.SetRange("Order No.", "Sales Invoice Header"."Order No.");
        if SalesInvoiceHeader.Find('-') then
            repeat
                SalesInvoiceLine2.SetRange("Document No.", SalesInvoiceHeader."No.");
                SalesInvoiceLine2.SetRange("Line No.", SalesInvoiceLine."Line No.");
                SalesInvoiceLine2.SetRange(Type, SalesInvoiceLine.Type);
                SalesInvoiceLine2.SetRange("No.", SalesInvoiceLine."No.");
                SalesInvoiceLine2.SetRange("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
                if SalesInvoiceLine2.Find('-') then
                    repeat
                        TotalQuantity := TotalQuantity + SalesInvoiceLine2.Quantity;
                    until SalesInvoiceLine2.Next() = 0;
            until SalesInvoiceHeader.Next() = 0;

        SalesShipmentLine.SetCurrentKey("Order No.", "Order Line No.");
        SalesShipmentLine.SetRange("Order No.", "Sales Invoice Header"."Order No.");
        SalesShipmentLine.SetRange("Order Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentLine.SetRange("Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentLine.SetRange(Type, SalesInvoiceLine.Type);
        SalesShipmentLine.SetRange("No.", SalesInvoiceLine."No.");
        SalesShipmentLine.SetRange("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
        SalesShipmentLine.SetFilter(Quantity, '<>%1', 0);

        if SalesShipmentLine.Find('-') then
            repeat
                if "Sales Invoice Header"."Get Shipment Used" then
                    CorrectShipment(SalesShipmentLine);
                if Abs(SalesShipmentLine.Quantity) <= Abs(TotalQuantity - SalesInvoiceLine.Quantity) then
                    TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity
                else begin
                    if Abs(SalesShipmentLine.Quantity) > Abs(TotalQuantity) then
                        SalesShipmentLine.Quantity := TotalQuantity;
                    Quantity :=
                      SalesShipmentLine.Quantity - (TotalQuantity - SalesInvoiceLine.Quantity);

                    TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity;
                    SalesInvoiceLine.Quantity := SalesInvoiceLine.Quantity - Quantity;

                    if SalesShipmentHeader.Get(SalesShipmentLine."Document No.") then
                        AddBufferEntry(
                          SalesInvoiceLine,
                          Quantity,
                          SalesShipmentHeader."Posting Date");

                end;
            until (SalesShipmentLine.Next() = 0) or (TotalQuantity = 0);
    end;

    procedure CorrectShipment(var SalesShipmentLine: Record "Sales Shipment Line")
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        SalesInvoiceLine.SetCurrentKey("Shipment No.", "Shipment Line No.");
        SalesInvoiceLine.SetRange("Shipment No.", SalesShipmentLine."Document No.");
        SalesInvoiceLine.SetRange("Shipment Line No.", SalesShipmentLine."Line No.");
        if SalesInvoiceLine.Find('-') then
            repeat
                SalesShipmentLine.Quantity := SalesShipmentLine.Quantity - SalesInvoiceLine.Quantity;
            until SalesInvoiceLine.Next() = 0;
    end;

    procedure AddBufferEntry(SalesInvoiceLine: Record "Sales Invoice Line"; QtyOnShipment: Decimal; PostingDate: Date)
    begin
        TempSalesShipmentBuffer.SetRange("Document No.", SalesInvoiceLine."Document No.");
        TempSalesShipmentBuffer.SetRange("Line No.", SalesInvoiceLine."Line No.");
        TempSalesShipmentBuffer.SetRange("Posting Date", PostingDate);
        if TempSalesShipmentBuffer.Find('-') then begin
            TempSalesShipmentBuffer.Quantity := TempSalesShipmentBuffer.Quantity + QtyOnShipment;
            TempSalesShipmentBuffer.Modify();
            exit;
        end;

        TempSalesShipmentBuffer."Document No." := SalesInvoiceLine."Document No.";
        TempSalesShipmentBuffer."Line No." := SalesInvoiceLine."Line No.";
        TempSalesShipmentBuffer."Entry No." := NextEntryNo;
        TempSalesShipmentBuffer.Type := SalesInvoiceLine.Type;
        TempSalesShipmentBuffer."No." := SalesInvoiceLine."No.";
        TempSalesShipmentBuffer.Quantity := QtyOnShipment;
        TempSalesShipmentBuffer."Posting Date" := PostingDate;
        TempSalesShipmentBuffer.Insert();
        NextEntryNo := NextEntryNo + 1
    end;

    local procedure DocumentCaption(): Text[250]
    begin
        if "Sales Invoice Header"."Prepayment Invoice" then
            exit(Text010Lbl);
        exit(Text004Lbl);
    end;

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean; pIncludeShptNo: Boolean; DisplAsmInfo: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        LogInteraction := NewLogInteraction;
        IncludeShptNo := pIncludeShptNo;
        DisplayAssemblyInformation := DisplAsmInfo;
    end;

    procedure CollectAsmInformation()
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        PostedAsmHeader: Record "Posted Assembly Header";
        PostedAsmLine: Record "Posted Assembly Line";
        SalesShipmentLine: Record "Sales Shipment Line";
    begin
        TempPostedAsmLine.DeleteAll();
        if "Sales Invoice Line".Type <> "Sales Invoice Line".Type::Item then
            exit;

        ValueEntry.SetCurrentKey("Document No.");
        ValueEntry.SetRange("Document No.", "Sales Invoice Line"."Document No.");
        ValueEntry.SetRange("Document Type", ValueEntry."Document Type"::"Sales Invoice");
        ValueEntry.SetRange("Document Line No.", "Sales Invoice Line"."Line No.");
        if not ValueEntry.FindSet() then
            exit;

        repeat
            if ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.") then
                if ItemLedgerEntry."Document Type" = ItemLedgerEntry."Document Type"::"Sales Shipment" then begin
                    SalesShipmentLine.Get(ItemLedgerEntry."Document No.", ItemLedgerEntry."Document Line No.");
                    if SalesShipmentLine.AsmToShipmentExists(PostedAsmHeader) then begin
                        PostedAsmLine.SetRange("Document No.", PostedAsmHeader."No.");
                        if PostedAsmLine.FindSet() then
                            repeat
                                TreatAsmLineBuffer(PostedAsmLine);
                            until PostedAsmLine.Next() = 0;
                    end;
                end;

        until ValueEntry.Next() = 0;
    end;

    procedure TreatAsmLineBuffer(PostedAsmLine: Record "Posted Assembly Line")
    begin
        Clear(TempPostedAsmLine);
        TempPostedAsmLine.SetRange(Type, PostedAsmLine.Type);
        TempPostedAsmLine.SetRange("No.", PostedAsmLine."No.");
        TempPostedAsmLine.SetRange("Variant Code", PostedAsmLine."Variant Code");
        TempPostedAsmLine.SetRange(Description, PostedAsmLine.Description);
        TempPostedAsmLine.SetRange("Unit of Measure Code", PostedAsmLine."Unit of Measure Code");
        if TempPostedAsmLine.FindFirst() then begin
            TempPostedAsmLine.Quantity += PostedAsmLine.Quantity;
            TempPostedAsmLine.Modify();
        end else begin
            Clear(TempPostedAsmLine);
            TempPostedAsmLine := PostedAsmLine;
            TempPostedAsmLine.Insert();
        end;
    end;

    procedure GetUOMText(UOMCode: Code[10]): Text[10]
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
        //with SalesPurchPerson do begin
        Clear(PhoneNoEmail);
        PhoneNoEmail := SalesPurchPerson."Phone No.";
        if SalesPurchPerson."E-Mail" <> '' then begin
            if PhoneNoEmail <> '' then
                PhoneNoEmail := PhoneNoEmail + ' / ';
            PhoneNoEmail := PhoneNoEmail + SalesPurchPerson."E-Mail"
        end;
        //end;
    end;
}

