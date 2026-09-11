page 50049 "Ecritures clients non lettrees"
{

    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Factures et avoirs non lettrés';
    DataCaptionFields = "Customer No.";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Cust. Ledger Entry";
    SourceTableView = sorting (Open, "Due Date")
                      where (Open = const (true));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                    ToolTip = 'Date comptabilisation';
                }
                field("Document Type"; Rec."Document Type")
                {
                    Editable = false;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Type document';
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                    StyleExpr = StyleTxt;
                    ToolTip = 'N° document';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'N° document externe';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'N° client';
                    Editable = false;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Nom du client';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                    Editable = false;
                }
                field("Facture acompte"; Rec."Facture acompte")
                {
                    ToolTip = 'Facture acompte';
                }
                field("Facture situation"; Rec."Facture situation")
                {
                    ToolTip = 'Facture situation';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ToolTip = 'Code vendeur';
                    Editable = false;
                    Visible = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Code devise';
                    Editable = false;
                    Visible = false;
                }
                field("Original Amount"; Rec."Original Amount")
                {
                    ToolTip = 'Montant origine';
                    Editable = false;
                    Visible = false;
                }
                field("Original Amt. (LCY)"; Rec."Original Amt. (LCY)")
                {
                    ToolTip = 'Montant origine (DS)';
                    Editable = false;
                    Visible = true;
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Montant';
                    Editable = false;
                    Visible = false;
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ToolTip = 'Montant (DS)';
                    Editable = false;
                    Visible = false;
                }
                field("Remaining Amt. (LCY)"; Rec."Remaining Amt. (LCY)")
                {
                    ToolTip = 'Montant ouvert (DS)';
                    Editable = false;
                    Visible = true;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Date échéance';
                    StyleExpr = StyleTxt;
                }
                field(Open; Rec.Open)
                {
                    ToolTip = 'Ouvert';
                    Editable = false;
                }
                field("Code groupe"; Rec."Code groupe")
                {
                    ToolTip = 'Code groupe';
                }
                field("Nouveau Code enseigne"; Rec."Nouveau Code enseigne")
                {
                    ToolTip = 'Nouveau code enseigne';
                }
                field("Code operation"; Rec."Code operation")
                {
                    ToolTip = 'Code opération';
                }
                field("Code chantier"; Rec."Code chantier")
                {
                    ToolTip = 'Code chantier';
                }
                field("On Hold"; Rec."On Hold")
                {
                    ToolTip = 'En attente';
                }
                field("Source Code"; Rec."Source Code")
                {
                    ToolTip = 'Code journal';
                    Editable = false;
                    Visible = false;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'N° écriture';
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part(Control1903096107; "Customer Ledger Entry FactBox")
            {
                SubPageLink = "Entry No." = field ("Entry No.");
                Visible = true;
            }
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("É&criture")
            {
                Caption = 'Ent&ry';
                Image = Entry;
                action("Écr. relance/fact. intérêts")
                {
                    Caption = 'Écr. relance/fact. intérêts';
                    ToolTip = 'Écr. relance/fact. intérêts';
                    Image = Reminder;
                    RunObject = Page "Reminder/Fin. Charge Entries";
                    RunPageLink = "Customer Entry No." = field ("Entry No.");
                    RunPageView = sorting ("Customer Entry No.");
                }
                action("É&critures lettrées")
                {
                    Caption = 'Ecritures lettrées';
                    ToolTip = 'Ecritures lettrées';
                    Image = Approve;
                    RunObject = Page "Applied Customer Entries";
                    RunPageOnRec = true;
                }
                action("Axes analytiques")
                {
                    Caption = 'Axes analytiques';
                    ToolTip = 'Axes analytiques';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions();
                    end;
                }
                action("Écritures comptables &détaillées")
                {
                    Caption = 'Écritures comptables &détaillées';
                    ToolTip = 'Écritures comptables &détaillées';
                    Image = View;
                    RunObject = Page "Detailed Cust. Ledg. Entries";
                    RunPageLink = "Cust. Ledger Entry No." = field ("Entry No."),
                                  "Customer No." = field ("Customer No.");
                    RunPageView = sorting ("Cust. Ledger Entry No.", "Posting Date");
                    ShortCutKey = 'Ctrl+F7';
                }
            }
        }
        area(processing)
        {
            group("Fonction&s")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Apply Entries")
                {
                    Caption = 'Lettrer';
                    ToolTip = 'Lettrer';
                    Image = ApplyEntries;
                    ShortCutKey = 'Shift+F11';

                    trigger OnAction()
                    var
                        CustLedgEntry: Record "Cust. Ledger Entry";
                        CustEntryApplyPostEntries: Codeunit "CustEntry-Apply Posted Entries";
                    begin
                        CustLedgEntry.Copy(Rec);
                        CustEntryApplyPostEntries.ApplyCustEntryFormEntry(CustLedgEntry);
                        Rec := CustLedgEntry;
                        CurrPage.Update();
                    end;
                }
                separator(Action63)
                {
                }
                action(UnapplyEntries)
                {
                    Caption = 'Délettrer';
                    ToolTip = 'Délettrer';
                    Ellipsis = true;
                    Image = UnApply;

                    trigger OnAction()
                    var
                        CustEntryApplyPostedEntries: Codeunit "CustEntry-Apply Posted Entries";
                    begin
                        CustEntryApplyPostedEntries.UnApplyCustLedgEntry(Rec."Entry No.");
                    end;
                }
                separator(Action65)
                {
                }
                action(ReverseTransaction)
                {
                    Caption = 'Contrepasser trnsaction';
                    ToolTip = 'Contrepasser transaction';
                    Ellipsis = true;
                    Image = ReverseRegister;

                    trigger OnAction()
                    var
                        ReversalEntry: Record "Reversal Entry";
                    begin
                        Clear(ReversalEntry);
                        if Rec.Reversed then
                            ReversalEntry.AlreadyReversedEntry(Rec.TableCaption, Rec."Entry No.");
                        if Rec."Journal Batch Name" = '' then
                            ReversalEntry.TestFieldError();
                        Rec.TestField("Transaction No.");
                        ReversalEntry.ReverseTransaction(Rec."Transaction No.");
                    end;
                }
            }
            action("Na&viguer")
            {
                Caption = 'Naviguer';
                ToolTip = 'Naviguer';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Navigate.SetDoc(Rec."Posting Date", Rec."Document No.");
                    Navigate.Run();
                end;
            }
            action("Document entrant")
            {
                Caption = 'Document entrant';
                ToolTip = 'Document entrant';
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    IncomingDocument: Record "Incoming Document";
                begin
                    IncomingDocument.HyperlinkToDocument(Rec."Document No.", Rec."Posting Date");
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        StyleTxt := Rec.SetStyle();
    end;

    trigger OnModifyRecord(): Boolean
    begin
        CODEUNIT.Run(CODEUNIT::"Cust. Entry-Edit", Rec);
        exit(false);
    end;

    var
        Navigate: Page Navigate;
        StyleTxt: Text;
        
        
}

