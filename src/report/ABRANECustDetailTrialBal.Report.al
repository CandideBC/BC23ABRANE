report 50054 "ABRANE: Cust. Detail Trial Bal"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ABRANECustDetailTrialBal.rdlc';
    Caption = 'ABRANE: Cust. Detail Trial Bal';

    dataset
    {
        dataitem(Customer; Customer)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(TodayFormatted; Format(Today))
            {
            }
            column(CompanyName; CompanyName)
            {
            }
            column(No_Cust; "No.")
            {
            }
            column(Name_Cust; Name)
            {
            }
            column(PhoneNo_Cust; "Phone No.")
            {
                IncludeCaption = true;
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(PreviousEndDate; CalcDate('<-1D>', StartDate))
            {
            }
            column(Company; CompanyName)
            {
            }
            column(Titre; Titre)
            {
            }
            column(Periode; StrSubstNo(Periode, StartDate, EndDate))
            {
            }
            column(Solde; StrSubstNo(Solde, GLSetup."LCY Code"))
            {
            }
            column(DSChoice; DSChoice)
            {
            }
            column(LetChoice; LetChoice)
            {
            }
            column(Filtres; 'Filtres : ' + Customer.GetFilters)
            {
            }
            dataitem(CustLedgerEntryBefore; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD ("No.");
                DataItemTableView = SORTING ("Customer No.", "Posting Date", "Currency Code") ORDER(Ascending);
                column(BPostDate_CustLedgEntry; Format("Posting Date"))
                {
                }
                column(BDocType_CustLedgEntry; "Document Type")
                {
                    IncludeCaption = true;
                }
                column(BDocNo_CustLedgEntry; "Document No.")
                {
                    IncludeCaption = true;
                }
                column(BDesc_CustLedgEntry; Description)
                {
                    IncludeCaption = true;
                }
                column(BCustAmount; CustBalance)
                {
                    AutoFormatType = 1;
                }
                column(BDebitAmt; DebitAmt)
                {
                }
                column(BCreditAmt; CreditAmt)
                {
                }
                column(BCustEntryDueDate; CustLedgerEntryBefore."Due Date")
                {
                }
                column(BEntryNo_CustLedgEntry; App.NumberToLetterCust(CustLedgerEntryBefore))
                {
                }
                column(BCustCurrencyCode; CustLedgerEntryBefore."Currency Code")
                {
                }
                column(Old; 'Old')
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if Letter <> Letter::Toutes then begin
                        CustEntry.Get(CustLedgerEntryBefore."Entry No.");
                        CustEntry.SetFilter("Date Filter", '..%1', EndDate);
                        CustEntry.CalcFields("Remaining Amount");
                        if (Letter = Letter::"Non-lettrées") and (CustEntry."Remaining Amount" = 0) then
                            CurrReport.Skip;
                        if (Letter = Letter::"Lettrées") and (CustEntry."Remaining Amount" <> 0) then
                            CurrReport.Skip;
                    end;

                    if Letter = Letter::"Non-lettrées" then
                        CustLedgerEntryBefore.SetFilter("Date Filter", '..%1', EndDate);
                    CustLedgerEntryBefore.CalcFields("Remaining Amount", "Remaining Amt. (LCY)");
                    if CustLedgerEntryBefore."Remaining Amount" > 0 then begin
                        if DSAmount then
                            DebitAmt := CustLedgerEntryBefore."Remaining Amt. (LCY)"
                        else
                            DebitAmt := CustLedgerEntryBefore."Remaining Amount";
                        CreditAmt := 0;
                    end else begin
                        DebitAmt := 0;
                        if DSAmount then
                            CreditAmt := -CustLedgerEntryBefore."Remaining Amt. (LCY)"
                        else
                            CreditAmt := -CustLedgerEntryBefore."Remaining Amount";
                    end;
                    CustBalance += CustLedgerEntryBefore."Remaining Amt. (LCY)";
                    CustBalanceStart += CustLedgerEntryBefore."Remaining Amt. (LCY)";
                    TotalBalance += CustLedgerEntryBefore."Remaining Amt. (LCY)";
                end;

                trigger OnPreDataItem()
                begin
                    SetRange("Posting Date", 0D, CalcDate('<-1D>', StartDate));
                    CustLedgerEntryBefore.SetFilter("Date Filter", '..%1', CalcDate('<-1D>', StartDate));
                    CustLedgerEntryBefore.SetFilter("Remaining Amount", '<>0');
                end;
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD ("No.");
                DataItemTableView = SORTING ("Customer No.", "Posting Date", "Currency Code") ORDER(Ascending);
                column(PostDate_CustLedgEntry; Format("Posting Date"))
                {
                }
                column(DocType_CustLedgEntry; "Document Type")
                {
                    IncludeCaption = true;
                }
                column(DocNo_CustLedgEntry; "Document No.")
                {
                    IncludeCaption = true;
                }
                column(Desc_CustLedgEntry; Description)
                {
                    IncludeCaption = true;
                }
                column(CustAmount; CustBalance)
                {
                    AutoFormatType = 1;
                }
                column(DebitAmt; DebitAmt)
                {
                }
                column(CreditAmt; CreditAmt)
                {
                }
                column(CustEntryDueDate; CustLedgerEntryBefore."Due Date")
                {
                }
                column(EntryNo_CustLedgEntry; App.NumberToLetterCust("Cust. Ledger Entry"))
                {
                }
                column(CustCurrencyCode; CustLedgerEntryBefore."Currency Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if Letter <> Letter::Toutes then begin
                        CustEntry.Get("Entry No.");
                        CustEntry.SetFilter("Date Filter", '..%1', EndDate);
                        CustEntry.CalcFields("Remaining Amount");
                        if (Letter = Letter::"Non-lettrées") and (CustEntry."Remaining Amount" = 0) then
                            CurrReport.Skip;
                        if (Letter = Letter::"Lettrées") and (CustEntry."Remaining Amount" <> 0) then
                            CurrReport.Skip;
                    end;

                    CalcFields(Amount, "Amount (LCY)");
                    if Amount > 0 then begin
                        if DSAmount then
                            DebitAmt := "Amount (LCY)"
                        else
                            DebitAmt := Amount;
                        CreditAmt := 0;
                    end else begin
                        DebitAmt := 0;
                        if DSAmount then
                            CreditAmt := -"Amount (LCY)"
                        else
                            CreditAmt := -Amount;
                    end;

                    CustBalance += "Amount (LCY)";
                    TotalBalance += "Amount (LCY)";
                end;

                trigger OnPreDataItem()
                begin
                    SetRange("Posting Date", StartDate, EndDate);
                end;
            }
            dataitem(TotCust; "Integer")
            {
                DataItemTableView = SORTING (Number) WHERE (Number = CONST (1));
                column(CustBalance; CustBalance)
                {
                }
                column(CustBalanceStart; CustBalanceStart)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if (CustBalance = 0) and (CustBalanceStart = 0) then
                        CurrReport.Skip;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CustBalance := 0;
                CustBalanceStart := 0;
            end;
        }
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING (Number) WHERE (Number = CONST (1));
            column(TotalBalance; TotalBalance)
            {
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group("Paramètres")
                {
                    Caption = 'Paramètres';
                    field(StartDate; StartDate)
                    {
                        Caption = 'From';
                    }
                    field(EndDate; EndDate)
                    {
                        Caption = 'To';
                    }
                    field(Letter; Letter)
                    {
                        Caption = 'Entry choice';
                    }
                    field(DSAmount; DSAmount)
                    {
                        Caption = 'Show DS Amount';
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
    }

    trigger OnPreReport()
    begin
        GLSetup.Get;

        if DSAmount then
            DSChoice := StrSubstNo(DebCreDS, GLSetup."LCY Code")
        else
            DSChoice := DebCreDev;

        case Letter of
            Letter::Toutes:
                LetChoice := '';
            Letter::"Lettrées":
                LetChoice := EcrLet;
            Letter::"Non-lettrées":
                LetChoice := EctNonLet;
        end;
    end;

    var
        StartDate: Date;
        EndDate: Date;
        Letter: Option Toutes,"Lettrées","Non-lettrées";
        DSAmount: Boolean;
        DebitAmt: Decimal;
        CreditAmt: Decimal;
        CustBalance: Decimal;
        CustBalanceStart: Decimal;
        TotalBalance: Decimal;
        App: Codeunit "Apply entries";
        CustEntry: Record "Cust. Ledger Entry";
        GLSetup: Record "General Ledger Setup";
        Titre: Label 'Customer detail trial balance';
        Solde: Label 'Balance %1';
        Periode: Label 'Period from %1 to %2';
        DebCreDev: Label 'Debit/Credit original currency';
        DebCreDS: Label 'Debit/Credit in %1';
        DSChoice: Text;
        EcrLet: Label 'Open entries';
        EctNonLet: Label 'Closed entries';
        LetChoice: Text;
}

