page 50065 "G/L Entries factbox"
{
    Caption = 'Balance G/L Entries';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    ShowFilter = false;
    SourceTable = "G/L Entry";
    SourceTableView = sorting ("Document No.", "Posting Date");

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ToolTip = 'N° compte général';
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ToolTip = 'Montant débit';
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ToolTip = 'Montant crédit';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Affciher écritures")
            {
                Caption = 'Afficher écritures';
                ToolTip = 'Afficher écritures';
                Image = GeneralLedger;
                RunObject = Page "General Ledger Entries";
                RunPageLink = "Document No." = field ("Document No."),
                              "Posting Date" = field ("Posting Date");
                RunPageView = sorting ("Document No.", "Posting Date");
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if AccFilter <> '' then
            Rec.SetFilter("G/L Account No.", '<>%1', AccFilter);
    end;

    var
        AccFilter: Code[20];

    procedure SetAccFilter(AccExcluded: Code[20])
    begin
        AccFilter := AccExcluded;
    end;
}

