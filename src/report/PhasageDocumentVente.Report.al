report 50073 "Phasage document vente"
{
    // DIA@NDE 05/02/15  Archivage non systématique  à l'impression
    // DIA@NDE 19/02/15  Modification gestion poids
    DefaultLayout = RDLC;
    RDLCLayout = 'PhasageDocumentVente.rdlc';

    Caption = 'Document vente';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.");
            RequestFilterFields = "Document Type","No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Document vente';
            column(DocType_SalesHeader; "Document Type")
            {
            }
            column(No_SalesHeader; "No.")
            {
            }
            column(InfosPaiement; InfosPaiement)
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
            column(JobName_SalesHeader; JobName)
            {
            }
            column(RequestDelivreyDate; "Requested Delivery Date")
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
            column(LabelAffaire; LabelAffaire)
            {
            }
            column(LabelSite; LabelSite)
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
            column(LabelCommentraire; LabelCommentraire)
            {
            }
            column(LabelShipmentDate; LabelShipmentDate)
            {
            }
            column(LabelEcoTax; LabelEcoTax)
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
            column("LabelQuantité"; LabelQuantité)
            {
            }
            column(LabellTotalWeight; LabellTotalWeight)
            {
            }
            column(PackageNumber; "Nombre de colis")
            {
            }
            column(PalletNumber; "Nombre de palettes")
            {
            }
            column(LabelTotalGrossWeight; LabelTotalGrossWeight)
            {
            }
            column(LabelUnitCaption; LabelUnitCaption)
            {
            }
            column(VATMentionDebit; VATMentionDebit)
            {
            }
            column(LabelPalette; LabelPalette)
            {
            }
            column(LabelPackage; LabelPackage)
            {
            }
            column(LabelCustOrder; LabelCustOrder)
            {
            }
            column(LabelDevis; LabelDevis)
            {
            }
            column(MontantAcpte; "Acompte verse (Montant)")
            {
            }
            column(LabelAcompte; LabelAcompte)
            {
            }
            column(LabelAcompteverse; LabelAcompteverse)
            {
            }
            column(DiscountPercentCaption; DiscountPercentCaptionLbl)
            {
            }
            column(labelVariant; labelVariant)
            {
            }
            column(AcompteDemandeLbl; AcompteDemandeLbl)
            {
            }
            column(txtAcompteDemande; txtAcompteDemande)
            {
            }
            column(txtSolde; txtSolde)
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
                    column(SalesCopyText; TitreDocument)
                    {
                    }
                    column(FactureSansPaiement; FactureSansPaiement)
                    {
                    }
                    column(TotalZero; TotalZero)
                    {
                    }
                    column(TextNetAPayer; TextNetAPayer)
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
                    column(SalesPersonMailCaption; SalesPersonMailCaption)
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

                    dataitem("Sales Line"; "Sales Line")
                    {
                        DataItemLink = "Document No." = field("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = sorting("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem()
                        begin
                            //"Sales Line".SetRange("document","Phasage ligne vente"."Type document");
                            //CurrReport.Break();
                        end;
                    }
                    dataitem(RoundLoop; "Integer")
                    {
                        DataItemTableView = sorting(Number);

                        column(NoArticle_PhasageLigneVente; "Sales Line"."No.")
                        {
                        }
                        column(DesiArticle_PhasageLigneVente; "Sales Line".Description)
                        {
                        }


                        column(Qte_PhasageLigneVente; "Sales Line".Quantity )
                        {
                        }
                        column(NoLigneDocument_PhasageLigneVente; "Sales Line"."Line No." )
                        {
                        }
                        column(Desc_SalesLineCaption; 'Description') //A passer en label
                        {
                        }
                        column(No2_SalesLineCaption; 'No.') //A passer en label
                        {
                        }

                        column(SalesLineQuantityCaption; SalesLineQuantityCaptionLbl)
                        {
                        }
                        column(SalesLinePromisedDeliveryDateCaption; SalesLinePromisedDeliveryDateCaptionLbl)
                        {
                        }
                    }
                }
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture);

                CurrReport.Language := LanguageMgt.GetLanguageID("Language Code");

                FormatAddr.Company(CompanyAddr, CompanyInfo);

                if "Salesperson Code" = '' then begin
                    Clear(SalesPurchPerson);
                    SalesPersonText := Text000;
                end else begin
                    SalesPurchPerson.Get("Salesperson Code");
                    SalesPersonText := Text000;
                end;

                if not PaymentMethod.Get("Payment Method Code") then
                    PaymentMethod.Init();

                txtPaymentMethodDescription := PaymentMethod.Description;

                //KAN.FHA 08/02/2021 DEBUT
                txtAcompteDemande := '';
                txtSolde := PaymentTermsCaptionLbl;
                PctAcompteDemande := "Sales Header"."% acompte demande";
                if PctAcompteDemande = 100 then begin
                    txtSolde := '';
                    txtAcompteDemande := '';
                    txtPaymentMethodDescription := txtPaymentMethodDescription + ' 100% ' + PaiementComptantLbl;
                end else
                    if PctAcompteDemande > 0 then begin
                        txtSolde := SoldeLbl;
                        txtAcompteDemande := Format(PctAcompteDemande) + '%';
                        if "Code cond. paiement acomptes" <> '' then begin
                            CondPaiementAcompte.Get("Code cond. paiement acomptes");
                            txtAcompteDemande := txtAcompteDemande + ' ' + CondPaiementAcompte.Description;
                        end;
                    end;
                //KAN.FHA 08/02/2021 FIN

                //KAN.FHA 04/11/2022 DEBUT
                if "Factor Code" <> '' then begin
                    FactorTable.Get("Factor Code");
                    InfosPaiement := FactorTable."Text 1" + ' ' + FactorTable."Text 2" + ' ' + FactorTable."Text 3";
                end else
                    InfosPaiement := CompanyInfo."Bank Name" + ' - IBAN ' + CompanyInfo.IBAN + ' - BIC ' + CompanyInfo."SWIFT Code";
                //KAN.FHA 04/11/2022 FIN

                //KAN.FHA 02/12/2022 DEBUT
                FactureSansPaiement := false;
                TotalZero := '';
                //KAN.FHA 02/12/2022 FIN

                //KAN.FHA 14/05/2020 DEBUT
                if OptionTitreDocument = OptionTitreDocument::"AR de commande" then
                    TitreDocument := StrSubstNo(Text004)
                else
                    //KAN.FHA 07/09/2021 DEBUT
                    if OptionTitreDocument = OptionTitreDocument::Proforma then
                        TitreDocument := Text004Proforma
                    else
                        if OptionTitreDocument = OptionTitreDocument::"Facture sans paiement" then begin
                            TitreDocument := Text004FactureSansPaiement;
                            FactureSansPaiement := true;
                        end else

                            //KAN.FHA 07/09/2021 FIN
                            //On imprime des commandes en disant que c'est un devis
                            TitreDocument := StrSubstNo(Text004Devis);
                //KAN.FHA 14/05/2020 FIN

                //-DIA@FHA 09/04/2014 Je fais en sorte que les captions ne soient jamais vides pour ne pas avoir de lignes blanches sur le papier
                ReferenceText := FieldCaption("Your Reference");

                VATNoText := FieldCaption("VAT Registration No.");
                //+DIA@FHA 09/04/2014

                //KAN.FHA 16/07/2020 DEBUT
                SiteName := '';
                if "Code chantier" <> '' then begin
                    Chantier.Get("Code chantier");
                    SiteName := Chantier."Description chantier";
                end;
                    //KAN.FHA 16/07/2020 FIN

                //KAN.FHA 02/12/2022 DEBUT
                if OptionTitreDocument = OptionTitreDocument::"Facture sans paiement" then begin
                    if "Currency Code" = '' then begin
                        GLSetup.TestField("LCY Code");
                        TotalText := StrSubstNo(Text001, GLSetup."LCY Code");
                        TotalInclVATText := StrSubstNo(Text002FactureSansPaiement, GLSetup."LCY Code");
                        TotalExclVATText := StrSubstNo(Text006, GLSetup."LCY Code");
                        TotalZero := '0' + ' ' + GLSetup."LCY Code";
                    end else begin
                        TotalText := StrSubstNo(Text001, "Currency Code");
                        TotalInclVATText := StrSubstNo(Text002FactureSansPaiement, "Currency Code");
                        TotalExclVATText := StrSubstNo(Text006, "Currency Code");
                        TotalZero := '0' + ' ' + "Currency Code";
                    end;
                    //KAN.FHA 02/12/2022 FIN

                end else

                    if "Currency Code" = '' then begin
                        GLSetup.TestField("LCY Code");
                        TotalText := StrSubstNo(Text001, GLSetup."LCY Code");
                        TotalInclVATText := StrSubstNo(Text002, GLSetup."LCY Code");
                        TotalExclVATText := StrSubstNo(Text006, GLSetup."LCY Code");
                    end else begin
                        TotalText := StrSubstNo(Text001, "Currency Code");
                        TotalInclVATText := StrSubstNo(Text002, "Currency Code");
                        TotalExclVATText := StrSubstNo(Text006, "Currency Code");
                    end;

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
                //TotalWeight := "Total Net Weight";
                //<<
            end;

            trigger OnPreDataItem()
            begin
                Print := Print; //OR NOT CurrReport.PREVIEW;
                //AsmInfoExistsForLine := false;
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
                        Caption = 'No. of Copies';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information';
                        Visible = false;
                    }
                    field(ArchiveDocument; ArchiveDocument)
                    {
                        Caption = 'Archive Document';
                        Visible = false;

                        trigger OnValidate()
                        begin
                            if not ArchiveDocument then
                                LogInteraction := false;
                        end;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;

                        trigger OnValidate()
                        begin
                            if LogInteraction then
                                ArchiveDocument := ArchiveDocumentEnable;
                        end;
                    }
                    field(ShowAssemblyComponents; DisplayAssemblyInformation)
                    {
                        Caption = 'Show Assembly Components';
                        Visible = false;
                    }
                    field(OptionTitreDocument; OptionTitreDocument)
                    {
                        Caption = 'Titre du document';
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
            //>>DIA@NDE ArchiveDocument := SalesSetup."Archive Quotes and Orders";
            //Migration LogInteraction := SegManagement.FindInteractTmplCode(3) <> '';

            LogInteractionEnable := LogInteraction;

            //KAN.FHA 14/05/2020 DEBUT
            OptionTitreDocument := OptionTitreDocument::"AR de commande";
            //KAN.FHA 14/05/2020 FIN
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
        ShippingAgent: Record "Shipping Agent";
        Chantier: Record Chantier;
        CondPaiementAcompte: Record "Payment Terms";
        FactorTable: Record Factor;
        LanguageMgt: Codeunit Language;

        SalesCountPrinted: Codeunit "Sales-Printed";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        ArchiveManagement: Codeunit ArchiveManagement;
        SalesPostPrepmt: Codeunit "Sales-Post Prepayments";
        DimMgt: Codeunit DimensionManagement;
        Text000: Label 'Salesperson';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text002FactureSansPaiement: Label 'Total %1 Incl. VAT';
        TextNetAPayer: Label 'Remaining Amount to pay';
        Text003: Label 'COPY';
        Text004: Label 'ORDER';
        Text004Devis: Label 'QUOTE';
        Text004Proforma: Label 'Proforma Invoice';
        Text004FactureSansPaiement: Label 'Invoice without payment';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT (remaining)';


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
        ShowShippingAddr: Boolean;
        i: Integer;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
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
        //NNCVATAmt2: Decimal;
        //NNCTotalExclVAT2: Decimal;
        //NNCSalesLineLineAmt: Decimal;
        //NNCSalesLineInvDiscAmt: Decimal;
        Print: Boolean;

        ArchiveDocumentEnable: Boolean;
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        AsmInfoExistsForLine: Boolean;
        InvDiscAmtCaptionLbl: Label 'Invoice Discount Amount';
        VATRegNoCaptionLbl: Label 'VAT Registration No.';
        //ShipmentDateCaptionLbl: Label 'Shipment Date';
        SalesHeaderNoCaptionLbl: Label 'No.';
        HomePageCaptionLbl: Label 'Home Page';
        EmailCaptionLbl: Label 'E-Mail';
        //HeaderDimCaptionLbl: Label 'Header Dimensions';
        DiscountPercentCaptionLbl: Label 'Disc. %';
        //SubtotalCaptionLbl: Label 'Subtotal (excl. VAT)';
        //PaymentDiscountVATCaptionLbl: Label 'Payment Discount on VAT';
        //LineDimCaptionLbl: Label 'Line Dimensions';
        //InvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount';
        //VATIdentifierCaptionLbl: Label 'VAT Identifier';
        ShiptoAddrCaptionLbl: Label 'Ship-to Address';
        BilltoAddrCaptionLbl: Label 'Bill-To Address';
        //DescriptionCaptionLbl: Label 'Description';
        //GLAccountNoCaptionLbl: Label 'G/L Account No.';
        //PrepaymentSpecCaptionLbl: Label 'Prepayment Specification';
        //PrepaymentVATAmtSpecCapLbl: Label 'Prepayment VAT Amount Specification';
        //PrepmtPmtTermsDescCaptionLbl: Label 'Prepmt. Payment Terms';
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
        //UOM_SalesLineCaptionLbl: Label 'UOM';
        CompanyInfoNameCaptionLbl: Label 'Siège social';
        SelltoCustNoCaptionLbl: Label 'Customer No.';
        ThankYouCaptionLbl: Label 'Thank you for your order. We are pleased to confirm following conditions :';
        DearSirMadamCaptionLbl: Label 'Dear Sir/Madam,';
        SalesHeaderQuoteNoCaptionLbl: Label 'Quote No.';
        
        SalesLinePromisedDeliveryDateCaptionLbl: Label 'Deliv.';
        SalesHeaderOrderDateCaptionLbl: Label 'Date :';
        SalesPersonMailCaption: Label 'E-mail';
        JobName: Text[50];
        //recDimValue: Record "Dimension Value";
        //NNCSalesLineEcoAmt: Decimal;
        LabelAffaire: Label 'Job :';
        LabelNoLocationName: Label 'No. and Location Name :';
        LabelNoRayon: Label 'Range No. : ';
        LabelInterlocuteurclient: Label 'Contact Name :';
        LabelCommentraire: Label 'Comments : ';
        LabelShipmentDate: Label 'Shipment date :';
        LabelEcoTax: Label 'Eco Tax Furniture';
        LabelRefClient: Label 'Item Ref.';
        LabelDescription: Label 'Description';
        "LabelQuantité": Label 'Qty';
        //NNCVATEcoAMt: Decimal;
        TotalWeight: Decimal;
        LabellTotalWeight: Label 'Total Net Weight:';
        SiteName: Text[50];
        //RecDimSetEntry: Record "Dimension Set Entry";
        LabelSite: Label 'Site :';
        LabelUnitCaption: Label 'Unit';
        //LabelMarchandise: Label 'Product Information';
        LabelPalette: Label 'Number of Palett:';
        //LabelOrgMse: Label 'Origine marchandise';
        //LabelPays: Label 'Pays exportateur';
        //LabelExpDate: Label 'Shipment Date :';
        //LabelCurrency: Label 'Currency :';
        //LabelOrder: Label 'Order No. :';
        LabelTotalGrossWeight: Label 'Total Gross Weight:';
        LabelPackage: Label 'Number of Packages:';
        VATMentionDebit: Label '* TVA payée sur les débits - Aucun escompte accordé';
        LabelCustOrder: Label 'Customer Order No. :';
        LabelDevis: Label 'Quote No.:';
        LabelAcompte: Label 'Prepayment';
        //PrepAmount: Decimal;
        LabelAcompteverse: Label 'Prepayment Amount';
        //text50000: Label 'Ecarts constatés en Montant TTC global %1 et la répatition TTC et l''écotaxe %2, document %3 %4, %5';
        //booCtrlTTC: Boolean;
        labelVariant: Label 'Variant';
        //SousTotal: Boolean;
        TitreDocument: Text[30];
        OptionTitreDocument: Option "AR de commande",Devis,Proforma,"Facture sans paiement";
        txtTotalHT: Text[50];
        //LabelTotalHTDontEcoContrib: Label 'Total Amount (excl. VAT) incl. Ecocontribution';
        //LabelTotalHT: Label 'Total Amount (excl. VAT)';
        
        //PoidsObligatoireErr: Label 'Vous devez indiquer un poids net sur la ligne %1, article %2 %3.';
        txtAcompteDemande: Text[100];
        
        txtSolde: Text[80];
        AcompteDemandeLbl: Label 'Prepayment :';
        SoldeLbl: Label 'Remaining Amount:';
        PctAcompteDemande: Decimal;
        txtPaymentMethodDescription: Text[100];
        PaiementComptantLbl: Label 'pre-paid';
        //Article: Record Item;
        
        InfosPaiement: Text[1024];
        FactureSansPaiement: Boolean;
        TotalZero: Text[80];

    procedure InitializeRequest(NoOfCopiesFrom: Integer; ShowInternalInfoFrom: Boolean; ArchiveDocumentFrom: Boolean; LogInteractionFrom: Boolean; PrintFrom: Boolean; DisplayAsmInfo: Boolean)
    begin
        NoOfCopies := NoOfCopiesFrom;
        ShowInternalInfo := ShowInternalInfoFrom;
        ArchiveDocument := ArchiveDocumentFrom;
        LogInteraction := LogInteractionFrom;
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

