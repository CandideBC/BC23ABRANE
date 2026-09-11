report 50023 "Bank Account Statement Cancel"
{
    Permissions = TableData "Bank Account Ledger Entry" = rmd;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Bank Account"; "Bank Account")
        {
            DataItemTableView = sorting ("No.");
            dataitem("Bank Account Statement"; "Bank Account Statement")
            {
                DataItemLink = "Bank Account No." = field ("No.");
                DataItemTableView = sorting ("Bank Account No.", "Statement No.");

                trigger OnAfterGetRecord()
                begin

                    if (LastBankAccountStatement."Statement No." <> StatementNoCode) and
                       ("Bank Account"."Balance Last Statement" <> "Bank Account Statement"."Statement Ending Balance") then
                        Error(Text001Lbl, "Bank Account No.");

                    if not Confirm(Text002Lbl, false, "Statement No.", "Bank Account No.") then
                        CurrReport.Break();

                    EcrCptBqe.SetRange("Bank Account No.", "Bank Account Statement"."Bank Account No.");
                    EcrCptBqe.SetRange("Statement No.", "Bank Account Statement"."Statement No.");
                    if EcrCptBqe.FindSet(true)
                    then
                        repeat
                            EcrCptBqe."Remaining Amount" := EcrCptBqe.Amount;
                            EcrCptBqe.Open := true;
                            EcrCptBqe."Statement Status" := EcrCptBqe."Statement Status"::Open;
                            EcrCptBqe."Statement No." := '';
                            EcrCptBqe."Statement Line No." := 0;
                            EcrCptBqe.Modify();
                        until EcrCptBqe.Next() = 0;
                    Delete();//(TRUE);

                    LastBankAccountStatement.Reset();
                    LastBankAccountStatement.SetCurrentKey("Bank Account No.", "Statement Date");
                    LastBankAccountStatement.SetRange("Bank Account No.", BankAccNoCode);
                    if LastBankAccountStatement.FindLast() then begin
                        "Bank Account"."Last Statement No." := LastBankAccountStatement."Statement No.";
                        "Bank Account"."Balance Last Statement" := LastBankAccountStatement."Statement Ending Balance";
                    end else begin
                        "Bank Account"."Last Statement No." := '';
                        "Bank Account"."Balance Last Statement" := 0;
                    end;
                    "Bank Account".Modify();
                end;

                trigger OnPreDataItem()
                begin
                    SetRange("Statement No.", StatementNoCode);
                end;
            }

            trigger OnAfterGetRecord()
            begin

                LastBankAccountStatement.SetCurrentKey("Bank Account No.", "Statement Date");
                LastBankAccountStatement.SetRange("Bank Account No.", BankAccNoCode);
                LastBankAccountStatement.FindLast();
            end;

            trigger OnPreDataItem()
            begin
                SetRange("No.", BankAccNoCode);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(BankAccNo; BankAccNoCode)
                {
                    Caption = 'N° compte bancaire';
                    ToolTip = 'N° compte bancaire';
                    TableRelation = "Bank Account";
                }
                field(StatementNo; StatementNoCode)
                {
                    Caption = 'N° relevé';
                    ToolTip = 'N° relevé';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        BankAccountStatementRecL: Record "Bank Account Statement";
                    begin

                        BankAccountStatementRecL.Reset();
                        BankAccountStatementRecL.SetCurrentKey("Bank Account No.", "Statement Date");
                        BankAccountStatementRecL.Ascending(false);
                        BankAccountStatementRecL.FilterGroup(2);
                        BankAccountStatementRecL.SetRange("Bank Account No.", BankAccNoCode);
                        BankAccountStatementRecL.FilterGroup(0);
                        BankAccountStatementRecL.SetFilter("Statement No.", Text);
                        if BankAccountStatementRecL.FindFirst() then;
                        BankAccountStatementRecL.SetRange("Statement No.");
                        if PAGE.RunModal(PAGE::"Bank Account Statement List", BankAccountStatementRecL,
                                         BankAccountStatementRecL."Statement No.") = ACTION::LookupOK then
                            StatementNoCode := BankAccountStatementRecL."Statement No.";
                    end;

                    trigger OnValidate()
                    var
                        BankAccountStatementRecL: Record "Bank Account Statement";
                        AucunReleveTrouveErr : Label 'Aucun relevé n''a été trouvé';
                    begin

                        BankAccountStatementRecL.Reset();
                        BankAccountStatementRecL.SetRange("Bank Account No.", BankAccNoCode);
                        BankAccountStatementRecL.SetFilter("Statement No.", StatementNoCode);
                        if not BankAccountStatementRecL.Findfirst() then
                          error(AucunReleveTrouveErr);
                        StatementNoCode := BankAccountStatementRecL."Statement No.";
                    end;
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

    var
        LastBankAccountStatement: Record "Bank Account Statement";
        EcrCptBqe: Record "Bank Account Ledger Entry";
        BankAccNoCode: Code[20];
        StatementNoCode: Code[20];
        Text001Lbl: Label 'Vous devez sélectionner le dernier relevé du compte bancaire n° %1.',Comment='%1 = N° compte bancaire';
        Text002Lbl: Label 'Voulez-vous supprimer le relevé bancaire n° %1 du compte bancaire n° %2  ?',Comment='%1 N° relevé ; %2 = N° compte bancaire';
}

