report 50056 "Extrait compte client"
{
    DefaultLayout = RDLC;
    ApplicationArea = All;
    UsageCategory = Lists;

    RDLCLayout = './src/ReportLayout/ExtraitCompteClient.rdlc';
    Caption = 'Extrait de compte client';

    dataset
    {
        dataitem(Customer; Customer)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Payment Method Code", "No.";
            column(No; Customer."No.")
            {
            }
            column(Name; Customer.Name)
            {
            }
            column(CompanyName; CompanyName)
            {
            }
            column(TermsCode; Customer."Payment Terms Code")
            {
            }
            column(MethodCode; Customer."Payment Method Code")
            {
            }
            column(Filtres; 'Filtres : ' + Customer.GetFilters + ' ' + "Cust. Ledger Entry".GetFilters)
            {
            }
            column(CustomerTop10ListCaption; 'Extrait de compte client')
            {
            }
            column(CurrReportPageNoCaption; 'Page ')
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field ("No.");
                DataItemTableView = sorting ("Customer No.", Open, Positive, "Due Date", "Currency Code") order(ascending) where (Open = const (true));
                RequestFilterFields = "Due Date";
                column(PostingDate; "Cust. Ledger Entry"."Posting Date")
                {
                }
                column(DocType; "Cust. Ledger Entry"."Document Type")
                {
                }
                column(DocNo; "Cust. Ledger Entry"."Document No.")
                {
                }
                column(ExtDocNo; "Cust. Ledger Entry"."External Document No.")
                {
                }
                column(Desc; "Cust. Ledger Entry".Description)
                {
                }
                column(DueDate; "Cust. Ledger Entry"."Due Date")
                {
                }
                column(Debit; Deb)
                {
                }
                column(Credit; Cred)
                {
                }
                column(Solde; Solde)
                {
                }
                column(Curr; "Cust. Ledger Entry"."Currency Code")
                {
                }
                column(OnHold; "Cust. Ledger Entry"."On Hold")
                {
                }
                column(SoldeTot; SoldeTot)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    "Cust. Ledger Entry".CalcFields("Remaining Amount", "Remaining Amt. (LCY)");

                    if "Cust. Ledger Entry"."Remaining Amount" > 0 then begin
                        Deb := Abs("Cust. Ledger Entry"."Remaining Amount");
                        Cred := 0;
                    end else begin
                        Cred := Abs("Cust. Ledger Entry"."Remaining Amount");
                        Deb := 0;
                    end;

                    Solde += "Cust. Ledger Entry"."Remaining Amt. (LCY)";
                    SoldeTot += "Cust. Ledger Entry"."Remaining Amt. (LCY)";
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Solde := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Deb: Decimal;
        Cred: Decimal;
        Solde: Decimal;
        SoldeTot: Decimal;
}

