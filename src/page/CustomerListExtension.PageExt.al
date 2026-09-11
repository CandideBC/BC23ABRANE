pageextension 50007 CustomerListExtension extends "Customer List"
{
    layout
    {
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Search Name")
        {
            Visible = true;
        }
        modify("Payments (LCY)")
        {
            Visible = false;
        }

        modify(Contact)
        {
            Visible = false;
        }
        moveafter(Name; "Search Name")

        addafter("Post Code")
        {
            field("City"; Rec.City)
            {
                ToolTip = 'Ville';
            }
            field("Code enseigne"; Rec."Code enseigne")
            {
                ToolTip = 'Code enseigne';
            }
            field("Code groupe"; Rec."Code groupe")
            {
                ToolTip = 'Code groupe';
            }
        }
        moveafter("Code groupe"; "Balance (LCY)", "Balance Due (LCY)", "Sales (LCY)", "Phone No.")

        addafter("Phone No.")
        {
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = All;
                ToolTip = 'E-mail';
            }
        }
        moveafter("E-Mail"; "VAT Bus. Posting Group")
        modify("VAT Bus. Posting Group")
        {
            Visible = true;
        }

    }
    
    actions
    {
        modify(PaymentRegistration)
        {
            Visible = false;
        }
        modify("Request Approval")
        {
            Visible = false;
        }
        modify(Workflow)
        {
            Visible = false;
        }
        modify(NewServiceCrMemo)
        {
            Visible = false;
        }
        modify(NewServiceInvoice)
        {
            Visible = false;
        }
        modify(NewServiceOrder)
        {
            Visible = false;
        }
        modify(NewServiceQuote)
        {
            Visible = false;
        }
        modify("Sales Journal")
        {
            Visible = false;
        }
        modify("Cash Receipt Journal")
        {
            Visible = false;
        }
        modify(WordTemplate)
        {
            Visible = false;
        }
        addafter("Item References")
        {
            action("Conditions d'acomptes")
            {
                Caption = 'Conditions d''acomptes';
                ToolTip = 'Conditions d''acomptes';
                Image = PrepaymentPercentages;
                Promoted = true;
                PromotedCategory = Category7;
                //PromotedIsBig = true;
                RunObject = Page "Conditions acompte";
                RunPageLink = Type = const(Client),
                              Code = field("No.");
            }
        }
        addafter(ReportAgedAccountsReceivable)
        {
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
        }

        modify("Recurring Sales Lines")
        {
            Caption = 'Devis type';
        }
        modify(Statement)
        {
            Visible = false;
        }
        modify(BackgroundStatement)
        {
            Visible = false;
        }
        modify("Customer - Order Summary")
        {
            Visible = false;
        }
        modify(Reminder)
        {
            Visible = false;
        }
        modify(DimensionsMultiple)
        {
            Visible = false;
        }
        modify(Sales_InvoiceDiscounts)
        {
            Visible = false;
        }
        modify("Issued Documents")
        {
            Visible = false;
        }
        modify("Blanket Orders")
        {
            Visible = false;
        }
        modify(ApprovalEntries)
        {
            Visible = false;
        }

        modify("C&ontact")
        {
            Visible = false;
        }
        modify("Sent Emails")
        {
            Visible = false;
        }
        modify("Item &Tracking Entries")
        {
            Visible = false;
        }
        modify(Prices_InvoiceDiscounts)
        {
            Visible = false;
        }
        modify(PricesAndDiscounts)
        {
            Visible = false;
        }
        modify(Service)
        {
            Visible = false;
        }
        modify(ApplyTemplate)
        {
            Visible = false;
        }
        modify(NewFinChargeMemo)
        {
            Visible = false;
        }
        modify(NewReminder)
        {
            Visible = false;
        }
        modify(NewSalesBlanketOrder)
        {
            Visible = false;
        }
        modify(NewSalesCrMemo)
        {
            Visible = false;
        }
        modify(NewSalesInvoice)
        {
            Visible = false;
        }
        modify(NewSalesOrder)
        {
            Visible = false;
        }
        modify(NewSalesQuote)
        {
            Visible = false;
        }
        modify(NewSalesReturnOrder)
        {
            Visible = false;
        }
        
        modify(Quotes)
        {
            Visible = false;
        }
        modify(Orders)
        {
            Visible = false;
        }
        modify("Return Orders")
        {
            Visible = false;
        }
        modify(Statistics)
        {
            Visible = false;
        }

        modify(Email)
        {
            Visible = false;
        }

        modify(DimensionsSingle)
        {
            Visible = false;
        }
        
    }
}

