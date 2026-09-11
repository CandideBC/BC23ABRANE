report 50055 "Vendor due entries"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Vendordueentries.rdlc';
    Caption = 'Vendor due entries';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    
    dataset
    {
        dataitem(Vendor; Vendor)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Payment Method Code", "No.";
            column(No; Vendor."No.")
            {
            }
            column(Name; Vendor.Name)
            {
            }
            column(CompanyName; CompanyName)
            {
            }
            column(TermsCode; Vendor."Payment Terms Code")
            {
            }
            column(MethodCode; Vendor."Payment Method Code")
            {
            }
            column(Filtres; 'Filtres : ' + Vendor.GetFilters + ' ' + "Vendor Ledger Entry".GetFilters)
            {
            }
            column(CustomerTop10ListCaption; 'Extrait de compte fournisseurs')
            {
            }
            column(CurrReportPageNoCaption; 'Page ')
            {
            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Vendor No." = field ("No.");
                DataItemTableView = sorting ("Vendor No.", Open, Positive, "Due Date", "Currency Code") order(ascending) where (Open = const (true));
                RequestFilterFields = "Due Date";
                column(PostingDate; "Vendor Ledger Entry"."Posting Date")
                {
                }
                column(DocType; "Vendor Ledger Entry"."Document Type")
                {
                }
                column(DocNo; "Vendor Ledger Entry"."Document No.")
                {
                }
                column(ExtDocNo; "Vendor Ledger Entry"."External Document No.")
                {
                }
                column(Desc; "Vendor Ledger Entry".Description)
                {
                }
                column(DueDate; "Vendor Ledger Entry"."Due Date")
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
                column(Curr; "Vendor Ledger Entry"."Currency Code")
                {
                }
                column(OnHold; "Vendor Ledger Entry"."On Hold")
                {
                }
                column(SoldeTot; SoldeTot)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    "Vendor Ledger Entry".CalcFields("Remaining Amt. (LCY)", "Remaining Amount");

                    if "Vendor Ledger Entry"."Remaining Amount" > 0 then begin
                        Deb := Abs("Vendor Ledger Entry"."Remaining Amount");
                        Cred := 0;
                    end else begin
                        Cred := Abs("Vendor Ledger Entry"."Remaining Amount");
                        Deb := 0;
                    end;

                    Solde += "Vendor Ledger Entry"."Remaining Amt. (LCY)";
                    SoldeTot += "Vendor Ledger Entry"."Remaining Amt. (LCY)";
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

