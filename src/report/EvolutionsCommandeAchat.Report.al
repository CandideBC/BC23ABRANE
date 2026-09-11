report 50000 "Evolutions Commande Achat"
{

    DefaultLayout = RDLC;
    RDLCLayout = './src/ReportLayout/EvolutionsCommandeAchat.rdlc';

    Caption = 'Evolutions commande achat';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = const(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Commande achat';
            column(DocType_PurchHeader; "Document Type")
            {
            }
            column(No_PurchHeader; "No.")
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }


            column(PaymentTermsDescCaption; PaymentTermsDescCaptionLbl)
            {
            }
            column(ShipmentMethodDescCaption; ShipmentMethodDescCaptionLbl)
            {
            }


            column(EmailIDCaption; EmailIDCaptionLbl)
            {
            }

            column(FaxNoComp; CompanyInfo."Fax No.")
            {
            }
            column(FaxNoCompCptn; CompanyInfo.FieldCaption("Fax No."))
            {
            }
            column(DateReception; DateReception)
            {
            }
            column(DateReceptionCaption; DateReceptionLbl)
            {
            }
            column(DateAvailable; "Purchase Header"."Date intention chargement")
            {
            }
            column(DateAvailableCaption; DateDispoLbl)
            {
            }
            column(LabelDocument; DocumentLbl)
            {
            }
            column(LabelCurrency; CurrencyLbl)
            {
            }
            column(LabelDocumentVendor; DocumentVendorLbl)
            {
            }
            column(currency_txt; currency_txt)
            {
            }
            column(LabelCust; CustomerLbl)
            {
            }
            column(LabelJob; LabelJob)
            {
            }
            column(LabelSite; LabelSite)
            {
            }
            column(LabelDu; LabelDu)
            {
            }
            column(LabelQty; LabelQty)
            {
            }
            column(JobName; JobName)
            {
            }
            column(CustName; CustName)
            {
            }
            column(SiteName; SiteName)
            {
            }
            column(LabelRef; LabelRef)
            {
            }
            column(Mentiontext; txtMention)
            {
            }
            column(LabelCommentaire; LabelCommentaire)
            {
            }
            column(Comments_PurchHeader; Commentaires)
            {
            }
            column(labelVariant; labelVariant)
            {
            }
            column(FournisseurPoseur; FournisseurPoseur)
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = sorting(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = const(1));
                    column(ReportTitleCopyText; StrSubstNo(Text004, CopyText))
                    {
                    }

                    column(CompanyInfoPicture; CompanyInfo.Picture)
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
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(CompanyInfoFaxNo; CompanyInfo."Fax No.")
                    {
                    }
                    column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfoBankName; CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoBankAccNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(CompanySiretNo; CompanyInfo."Registration No.")
                    {
                    }
                    column(DocDate_PurchHeader; "Purchase Header"."Document Date")
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_PurchHeader; "Purchase Header"."VAT Registration No.")
                    {
                    }
                    column(PurchaserText; PurchaserText)
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
                    column(YourRef_PurchHeader; "Purchase Header"."Your Reference")
                    {
                    }

                    column(BuyFrmVendNo_PurchHeader; "Purchase Header"."Buy-from Vendor No.")
                    {
                    }
                    column(BuyFromAddr1; BuyFromAddr[1])
                    {
                    }
                    column(BuyFromAddr2; BuyFromAddr[2])
                    {
                    }
                    column(BuyFromAddr3; BuyFromAddr[3])
                    {
                    }
                    column(BuyFromAddr4; BuyFromAddr[4])
                    {
                    }
                    column(BuyFromAddr5; BuyFromAddr[5])
                    {
                    }
                    column(BuyFromAddr6; BuyFromAddr[6])
                    {
                    }
                    column(BuyFromAddr7; BuyFromAddr[7])
                    {
                    }
                    column(BuyFromAddr8; BuyFromAddr[8])
                    {
                    }
                    column(PricesInclVAT_PurchHeader; "Purchase Header"."Prices Including VAT")
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(VATBaseDisc_PurchHeader; "Purchase Header"."VAT Base Discount %")
                    {
                    }

                    column(PaymentTermsDesc; PaymentTerms.Description + '-' + "Purchase Header"."Payment Method Code")
                    {
                    }
                    column(ShipmentMethodDesc; ShipmentMethod.Description)
                    {
                    }
                    column(PrepmtPaymentTermsDesc; PrepmtPaymentTerms.Description)
                    {
                    }

                    column(TotalText; TotalText)
                    {
                    }

                    column(CompanyInfoPhoneNoCaption; CompanyInfoPhoneNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoVATRegNoCaption; CompanyInfoVATRegNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoGiroNoCaption; CompanyInfoGiroNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoBankNameCaption; CompanyInfoBankNameCaptionLbl)
                    {
                    }
                    column(CompanyInfoBankAccNoCaption; CompanyInfoBankAccNoCaptionLbl)
                    {
                    }
                    column(OrderNoCaption; OrderNoCaptionLbl)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(DocumentDateCaption; DocumentDateCaptionLbl)
                    {
                    }
                    column(BuyFrmVendNo_PurchHeaderCaption; "Purchase Header".FieldCaption("Buy-from Vendor No."))
                    {
                    }
                    column(PricesInclVAT_PurchHeaderCaption; "Purchase Header".FieldCaption("Prices Including VAT"))
                    {
                    }
                    column(ShipmentMethodCode; ShipmentMethod.Code)
                    {
                    }
                    column(VersionLbl; VersionLbl)
                    {
                    }
                    column(VersionNo; VersionNo)
                    {
                    }
                    column(VersionDate; VersionDate)
                    {
                    }
                    dataitem(ComparaisonVersionsCdeAchat; ComparaisonVersionsDocument)
                    {
                        DataItemLink = "Type document"=field("Document type"),"No. document" = field("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = sorting("No. document", "Ligne modifiee") order(descending);
                        column(NoArticle; "No. article")
                        {

                        }

                        column(Description; Description)
                        {

                        }
                        column(NoVersion_1; "No. version A")
                        {

                        }
                        column(NoVersion_2; "No. version B")
                        {

                        }
                        column(TexteLigneModifiee; TexteLigneModifiee)
                        {

                        }
                        column(QuantiteVersionA; "Quantite version A")
                        {

                        }
                        column(QuantiteVersionB; "Quantite version B")
                        {

                        }
                        column(EcartQuantite; "Quantite ecart (B-A)")
                        {

                        }

                        trigger OnAfterGetRecord()
                        begin
                            if ComparaisonVersionsCdeAchat."Ligne modifiee" then
                                TexteLigneModifiee := 'Yes - Oui'
                            else
                                TexteLigneModifiee := 'No - Non';
                        end;

                    }
                }

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
                CurrReport.Language := LanguageMgt.GetLanguageIdOrDefault("Language Code");

                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture);

                "Purchase Header".RecupInfosDerniereArchive(MontantArchive, VersionNo, VersionDate);

                //VersionArrivee := VersionNo;
                //VersionOrigine := VersionArrivee - 1;
                //"Purchase Header".ComparerVersionsArchives(VersionOrigine,VersionArrivee);
                //Commit();

                //KAN.FHA 02/12/2022 DEBUT
                txtMention := Mentiontext;
                Fournisseur.Get("Purchase Header"."Buy-from Vendor No.");
                FournisseurPoseur := (Fournisseur."Type fournisseur" = 'POSEURS'); //Dans le layout on aura toute une série de libelles propres aux poseurs
                                                                                   //KAN.FHA 02/12/2022 FIN

                FormatAddr.Company(CompanyAddr, CompanyInfo);

                if "Purchaser Code" = '' then begin
                    SalesPurchPerson.Init();
                    PurchaserText := '';
                end else begin
                    SalesPurchPerson.Get("Purchaser Code");
                    PurchaserText := Text000
                end;
                if "Your Reference" = '' then
                    ReferenceText := ''
                else
                    ReferenceText := FieldCaption("Your Reference");
                if "VAT Registration No." = '' then
                    VATNoText := ''
                else
                    VATNoText := FieldCaption("VAT Registration No.");
                if "Currency Code" = '' then begin
                    GLSetup.TestField("LCY Code");
                    TotalText := StrSubstNo(Text001, GLSetup."LCY Code");
                    TotalInclVATText := StrSubstNo(Text002, GLSetup."LCY Code");
                    TotalExclVATText := StrSubstNo(Text006, GLSetup."LCY Code");
                    currency_txt := GLSetup."LCY Code";
                end else begin
                    TotalText := StrSubstNo(Text001, "Currency Code");
                    TotalInclVATText := StrSubstNo(Text002, "Currency Code");
                    TotalExclVATText := StrSubstNo(Text006, "Currency Code");
                    currency_txt := "Currency Code";
                end;

                FormatAddr.PurchHeaderBuyFrom(BuyFromAddr, "Purchase Header");
                if "Buy-from Vendor No." <> "Pay-to Vendor No." then
                    FormatAddr.PurchHeaderPayTo(VendAddr, "Purchase Header");
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
                if "Shipment Method Code" = '' then
                    ShipmentMethod.Init()
                else begin
                    ShipmentMethod.Get("Shipment Method Code");
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Language Code");
                end;

                FormatAddr.PurchHeaderShipTo(ShipToAddr, "Purchase Header");

                DateReception := "Requested Receipt Date";
                if DateReception = 0D then
                    DateReception := "Promised Receipt Date";

                if "Code chantier" <> '' then begin
                    CustName := '';
                    if Chantier.Get("Code chantier") then
                        if Client.Get(Chantier."No. client") then
                            CustName := Client.Name;
                end;

                SiteName := '';

            end;

            trigger OnPreDataItem()
            begin
            end;
        }
    }

    requestpage
    {
        layout
        {

        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.Get();
        PurchSetup.Get();

        CompanyInfo.CalcFields(Picture);
    end;

    var
        GLSetup: Record "General Ledger Setup";
        CompanyInfo: Record "Company Information";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PrepmtPaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        Client: Record Customer;
        Chantier: Record Chantier;
        Fournisseur: Record Vendor;
        PurchSetup: Record "Purchases & Payables Setup";
        LanguageMgt: Codeunit Language;
        FormatAddr: Codeunit "Format Address";
        VendAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        BuyFromAddr: array[8] of Text[50];
        PurchaserText: Text[30];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        TotalText: Text[50];
        TotalInclVATText: Text[50];
        TotalExclVATText: Text[50];
        NoOfLoops: Integer;
        CopyText: Text[30];
        TexteLigneModifiee: Text[10];
        VersionOrigine:Integer;
        VersionArrivee:Integer;
        OutputNo: Integer;
        OptSend: Option "Hard Copy","E-Mail",Fax;
        Text000: Label 'Purchaser';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text004: Label 'Order No.%1';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT';
        Text007: Label 'VAT Amount Specification in ';
        Text008: Label 'Local Currency';
        Text009: Label 'Exchange rate: %1/%2';
        CompanyInfoPhoneNoCaptionLbl: Label 'Phone No.';
        CompanyInfoVATRegNoCaptionLbl: Label 'VAT Registration No.';
        CompanyInfoGiroNoCaptionLbl: Label 'Giro No.';
        CompanyInfoBankNameCaptionLbl: Label 'Bank';
        CompanyInfoBankAccNoCaptionLbl: Label 'Account No.';
        OrderNoCaptionLbl: Label 'Order No.';
        PageCaptionLbl: Label 'Page';
        DocumentDateCaptionLbl: Label 'Document Date : ';
        AmountCaptionLbl: Label 'Amount';
        PaymentTermsDescCaptionLbl: Label 'Payment Terms : ';
        ShipmentMethodDescCaptionLbl: Label 'Incoterm :';
        EmailIDCaptionLbl: Label 'E-Mail';
        DateReception: Date;
        DateReceptionLbl: Label 'Receipt date of the goods :';
        DocumentVendorLbl: Label 'ORDER VENDOR';
        currency_txt: Text;
        CurrencyLbl: Label 'Currency :';
        DocumentLbl: Label 'Order No. :';

        JobName: Text[50];
        CustName: Text[50];
        SiteName: Text[50];
        CustomerLbl: Label 'Customer :';
        LabelJob: Label 'Job :';
        LabelSite: Label 'Site :';

        LabelRef: Label 'Reference';
        LabelDu: Label 'Date :';
        LabelQty: Label 'Qty';
        Mentiontext: Label 'Any invoice without mention of the correspondig Purchase Order No. will be not recorded in accounting.';
        LabelCommentaire: Label 'Comments : ';
        HSCode_wTxt: Text;
        LabelHSCode: Label 'HS Code : %1';
        labelVariant: Label 'Variant';

        DateDispoLbl: Label 'Shipment Date';

        FournisseurPoseur: Boolean;
        txtMention: Text;
        MontantArchive: Decimal;
        NoOfCopies: Integer;
        VersionLbl: Label 'Version';
        VersionNo: Integer;
        VersionDate: Date;

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

