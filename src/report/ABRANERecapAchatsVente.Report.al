report 50075 "ABRANE : recap achats vente"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/ReportLayout/ABRANERecapAchatsVente.rdlc';

    Caption = 'Récap achats vente';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = filter(Quote | Order));
            RequestFilterFields = "No.", "Sell-to Customer No.";
            column(DocType_SalesHeader; "Document Type")
            {
            }
            column(No_SalesHeader; "No.")
            {
            }
            column(DocDate_SalesHeader; "Order Date")
            {
            }
            column(NoLocationName_SalesHeader; "No. And Location Name")
            {
            }
            column(LabelNoLocationName_SalesHeader; LabelNoLocationNameLbl)
            {
            }
            column(CompanyInfoPicture; CompanyInfo.Picture)
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
            column(CompanyInfoTradeRegister; CompanyInfo."Trade Register")
            {
            }
            column(SalesCopyText; SalesCopyTextTxt)
            {
            }
            column(TitreDocument; TitreDocumentLbl)
            {
            }
            column(SalesPersonText; SalesPersonText)
            {
            }
            column(SalesPurchPersonName; SalesPurchPerson.Name)
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
            column(LabelCol1; LabelCol1Lbl)
            {
            }
            column(LabelCol2; LabelCol2Lbl)
            {
            }
            column(LabelCol3; LabelCol3Lbl)
            {
            }
            column(LabelCol4; LabelCol4Lbl)
            {
            }
            column(LabelCol5; LabelCol5Lbl)
            {
            }
            column(LabelCol6; LabelCol6Lbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if "Document Type" = "Document Type"::Order then
                    SalesCopyTextTxt := CommandeLbl
                else
                    SalesCopyTextTxt := DevisLbl;

                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture);

                if "Salesperson Code" = '' then begin
                    Clear(SalesPurchPerson);
                    SalesPersonText := '';
                end else begin
                    SalesPurchPerson.Get("Salesperson Code");
                    SalesPersonText := SuiviParLbl;
                end;

                FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, "Sales Header");
            end;
        }
    }

    var
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        FormatAddr: Codeunit "Format Address";
        ShipToAddr: array[8] of Text[100];
        CustAddr: array[8] of Text[100];
        SalesPersonText: Text[30];
        SalesCopyTextTxt: Text[100];
        SuiviParLbl: Label 'Suivi par';
        CommandeLbl: Label 'Commande';
        DevisLbl: Label 'Devis';
        TitreDocumentLbl: Label 'Récap achats vente';
        ShiptoAddrCaptionLbl: Label 'Adresse de livraison';
        LabelNoLocationNameLbl: Label 'Magasin :';
        LabelCol1Lbl: Label 'Colonne 1';
        LabelCol2Lbl: Label 'Colonne 2';
        LabelCol3Lbl: Label 'Colonne 3';
        LabelCol4Lbl: Label 'Colonne 4';
        LabelCol5Lbl: Label 'Colonne 5';
        LabelCol6Lbl: Label 'Colonne 6';
}
