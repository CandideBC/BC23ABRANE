pageextension 50006 CustomerCardExtension extends "Customer Card"
{
    layout
    {
        modify(Blocked)
        {
            Importance = Additional;
            Visible = false;
        }
        modify("Last Date Modified")
        {
            Importance = Additional;
            Visible = false;
        }
        modify("Disable Search by Name")
        {
            Importance = Additional;
            Visible = false;
        }
        modify("Prepayment %")
        {
            Visible = false;
        }
        modify("IC Partner Code")
        {
            Visible = false;
        }
        modify("Balance (LCY)")
        {
            Visible = false;
        }
        modify("Balance Due (LCY)")
        {
            Visible = false;
        }
        modify(AddressDetails)
        {
            Visible = false;
        }
        modify("Format Region")
        {
            Visible = false;
        }
        modify("Address & Contact")
        {
            Visible = false;
        }
        modify("Credit Limit (LCY)")
        {
            Visible = false;
        }
        modify("Home Page")
        {
            Visible = false;
        }
        modify(ShowMap)
        {
            Visible = false;
        }
        modify(ContactDetails)
        {
            Visible = false;
        }
        modify("Fax No.")
        {
            Visible = false;
        }
        modify(MobilePhoneNo)
        {
            Visible = false;
        }

        modify(ContactName)
        {
            Visible = false;
        }
        modify(BalanceAsVendor)
        {
            Visible = false;
        }
        modify("CustSalesLCY - CustProfit - AdjmtCostLCY")
        {
            Visible = false;
        }
        modify(AdjCustProfit)
        {
            Visible = false;
        }
        modify("Document Sending Profile")
        {
            Importance = Additional;
            Visible = false;
        }
        modify("Privacy Blocked")
        {
            Visible = false;
        }
        modify(TotalSales2)
        {
            Visible = false;
        }
        modify(AdjProfitPct)
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Service Zone Code")
        {
            Visible = false;
        }
        modify("Prices Including VAT")
        {
            Visible = false;
        }
        modify("Salesperson Code")
        {
            Visible = false;
        }
        modify(Control149)
        {
            Visible = false;
        }
        moveafter("Name"; "Search Name", Address, "Address 2", "Post Code", City, "Country/Region Code", "Phone No.", "E-Mail", "Language Code", "Currency Code")
        modify("Search Name")
        {
            Importance = Standard;
        }

        modify("Language Code")
        {
            Importance = Standard;
        }

        addafter("Country/Region Code")
        {
            field("Code enseigne"; Rec."Code enseigne")
            {
                ApplicationArea = All;
                ToolTip = 'Code enseigne';
            }
            field("Code groupe"; Rec."Code groupe")
            {
                ApplicationArea = All;
                ToolTip = 'Code groupe';
            }
        }
        moveafter("Currency Code"; "Location Code", "Combine Shipments", Reserve)
        modify(Shipping)
        {
            Visible = false;
        }

        movebefore("VAT Registration No."; "Gen. Bus. Posting Group", "VAT Bus. Posting Group", "Customer Posting Group", "Customer Price Group")
        addafter("Customer Price Group")
        {

            field("Eco Tax Furniture Liable"; Rec."Eco Tax Furniture Liable")
            {
                ApplicationArea = All;
                ToolTip = 'Soumis taxe éco-mobilier';
            }
        }
        addafter("Prices Including VAT")
        {

            field("Price Included Eco Tax"; Rec."Price Included Eco Tax")
            {
                ApplicationArea = All;
                ToolTip = 'Prix incluent éco-contribution';
            }
            field(Factoring; Rec.Factoring)
            {
                ApplicationArea = All;
                ToolTip = 'Factoring';
                Visible = false;
            }
        }
        addbefore("Payment Terms Code")
        {
            field("Factor Code"; Rec."Factor Code")
            {
                ApplicationArea = All;
                ToolTip = 'Code banque';
            }
        }
        addafter("Payment Terms Code")
        {
            field("Code cond. paiement acomptes"; Rec."Code cond. paiement acomptes")
            {
                ApplicationArea = All;
                ToolTip = 'Code cond. paiement acomptes';
            }
            field("Code cond. paiement situation"; Rec."Code cond. paiement situation")
            {
                ApplicationArea = All;
                ToolTip = 'Code cond. paiement situation';
            }
            field("% acompte situation"; Rec."% acompte situation")
            {
                ApplicationArea = All;
                ToolTip = '% acompte situation';
            }
        }
        moveafter("Address 2"; "Post Code")
        moveafter("Post Code"; City)

        modify(PostingDetails)
        {
            Visible = false;
        }
        modify("Use GLN in Electronic Document")
        {
            Visible = false;
        }
        modify("Tax Liable")
        {
            Visible = false;
        }
        modify(GLN)
        {
            Visible = false;
        }
        modify("Copy Sell-to Addr. to Qte From")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Invoice Disc. Code")
        {
            Visible = false;
        }
        modify(PricesandDiscounts)
        {
            Visible = false;
        }
        modify("Application Method")
        {
            Visible = false;
        }
        modify("Partner Type")
        {
            Visible = false;
        }
        modify("Intrastat Partner Type")
        {
            Visible = false;
        }
        modify("Cash Flow Payment Terms Code")
        {
            Visible = false;
        }
        modify("Reminder Terms Code")
        {
            Visible = false;
        }
        modify("Fin. Charge Terms Code")
        {
            Visible = false;
        }
        modify("Print Statements")
        {
            Visible = false;
        }
        modify("Last Statement No.")
        {
            Visible = false;
        }
        modify("Payment in progress (LCY)")
        {
            Visible = false;
        }
        modify("""Balance (LCY)"" - ""Payment in progress (LCY)""")
        {
            Visible = false;
        }
        modify("Block Payment Tolerance")
        {
            Visible = false;
        }
        modify("Balance (LCY)2")
        {
            Visible = false;
        }
        modify("Payment Balance (LCY)")
        {
            Visible = false;
        }
        modify("Exclude from Pmt. Practices")
        {
            Visible = false;
        }

        moveafter("VAT Registration No."; "Shipment Method Code")
        modify("Shipment Method Code")
        {
            Caption = 'Incoterm';
        }
        modify("Shipping Agent Service Code")
        {
            Visible = false;
        }
    }
    actions
    {
        modify(Dimensions)
        {
            Visible = false;
        }
        modify("Sales Journal")
        {
            Visible = false;
        }
        modify(MergeDuplicate)
        {
            Visible = false;
        }
        modify(ApplyTemplate)
        {
            Visible = false;
        }
        modify(Contact)
        {
            Visible = false;
        }
        modify("Prices and Discounts")
        {
            Visible = false;
        }
        modify("Request Approval")
        {
            Visible = false;
        }
        modify(ApprovalEntries)
        {
            Visible = false;
        }

        /*
        modify("Item References")
        {
            Promoted = true;
            PromotedIsBig = true;
            PromotedCategory = Process;
        }
        */

        modify("Post Cash Receipts")
        {
            Visible = false;
        }

        modify(SaveAsTemplate)
        {
            Visible = false;
        }

        modify(Templates)
        {
            Visible = false;
        }

        modify(Email)
        {
            Visible = false;
        }

        modify(CustomerReportSelections)
        {
            Visible = false;
        }

        modify(Service)
        {
            Visible = false;
        }

        modify("&Jobs")
        {
            Visible = false;
        }

        modify("Issued Documents")
        {
            Visible = false;
        }

        modify(Workflow)
        {
            Visible = false;
        }

        modify(PaymentRegistration)
        {
            Visible = false;
        }

        modify(WordTemplate)
        {
            Visible = false;
        }

        modify("Blanket Orders")
        {
            Visible = false;
        }

        modify("Direct Debit Mandates")
        {
            Visible = false;
        }

        modify("Report Customer Detailed Aging")
        {
            Visible = false;
        }

        modify("Report Customer - Labels")
        {
            Visible = false;
        }

        modify(Approval)
        {
            Visible = false;
        }
        modify(NewBlanketSalesOrder)
        {
            Visible = False;
        }
        modify(NewFinanceChargeMemo)
        {
            Visible = False;
        }
        modify(NewReminder)
        {
            Visible = False;
        }
        modify(NewSalesCreditMemo)
        {
            Visible = False;
        }
        modify(NewSalesInvoice)
        {
            Visible = False;
        }
        modify(NewSalesOrder)
        {
            Visible = False;
        }
        modify(NewSalesQuote)
        {
            Visible = False;
        }
        modify(NewSalesReturnOrder)
        {
            Visible = False;
        }
        modify(NewServiceCreditMemo)
        {
            Visible = False;
        }
        modify(NewServiceInvoice)
        {
            Visible = False;
        }
        modify(NewServiceOrder)
        {
            Visible = False;
        }
        modify(NewServiceQuote)
        {
            Visible = False;
        }

        modify("Report Statement")
        {
            Visible = false;
        }

        modify(BackgroundStatement)
        {
            Visible = false;
        }

        
        

        addafter("Report Customer - Balance to Date")
        {
            action(BalanceClient)
            {
                ApplicationArea = All;
                Caption = 'Balance client';
                RunObject = report "Customer - Trial Balance";
                ToolTip = 'Balance client';
            }
            action(GrandLivreClient)
            {
                ApplicationArea = All;
                Caption = 'Grand livre client';
                RunObject = report "ABRANE: Cust. Detail Trial Bal";
                ToolTip = 'Grand livre client';
            }

            action(ListeDesVentes)
            {
                ApplicationArea = All;
                Caption = 'Client : liste des ventes';
                RunObject = report "Customer - Sales List";
                ToolTip = 'Client : liste des ventes';
            }
            action(ExtraitDeCompte)
            {
                //ApplicationArea = All;
                ToolTip = 'Extrait de compte';
                Caption = 'Extrait de compte';
                //Promoted = true;
                //PromotedIsBig = true;
                //PromotedCategory = Report;
                Image = Report;

                trigger OnAction()
                var
                    Cust: Record Customer;
                    ReportExtraitCompteClient: Report "Extrait compte client";
                begin
                    if Cust.GET(Rec."No.") then
                        Cust.SETRECFILTER();
                    ReportExtraitCompteClient.SETTABLEVIEW(Cust);
                    ReportExtraitCompteClient.RUN();
                end;
            }
            action(ComptaClientAgee)
            {
                //ApplicationArea = All;
                Caption = 'Comptabilité client agée';
                RunObject = report "Aged Accounts Receivable";
                ToolTip = 'Comptabilité client agée';
            }
        }

        
        modify("S&ales")
        {
            Promoted = false;
        }
        modify("Report Customer - Balance to Date")
        {
            Promoted = false;
        }

        addfirst("F&unctions")
        {
            /*
            action(DuplicateItemCrossReference)
            {
                ApplicationArea = All;
                Caption = 'Dupliquer références externes';
                ToolTip = 'Dupliquer références externes';
                Image = CheckDuplicates;

                trigger OnAction()
                begin
                    //- DIA.160527-P2/BPE
                    Rec.DupliquerReferencesArticles();
                    //+ DIA.160527-P2/BPE
                end;
            }
            */
        }
        addafter("Item References")
        {
            action("Conditions d'acomptes")
            {
                ApplicationArea = All;
                Caption = 'Conditions d''acomptes';
                ToolTip = 'Conditions d''acomptes';
                Image = PrepaymentPercentages;
                Promoted = true;
                PromotedCategory = Category9;
                //PromotedIsBig = true;
                RunObject = Page "Conditions acompte";
                RunPageLink = Type = const(Client),
                              Code = field("No.");
            }
        }
    }
}

