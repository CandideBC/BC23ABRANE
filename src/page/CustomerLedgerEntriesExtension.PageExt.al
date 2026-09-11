pageextension 50077 CustomerLedgerEntriesExtension extends "Customer Ledger Entries"
{
    layout
    {
        addlast(content)
        {
            group(Totaux)
            {
                field(SoldeSelection; TotSel)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Solde sélection';
                    
                    Caption = 'Solde sélection';
                    trigger OnAssistEdit()
                        begin
                            CalcSel();
                        end;
                    
                }
                field(SoldeDSSelection; TotSelDS)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Solde DS sélection';
                    
                    Caption = 'Solde DS sélection';
                    trigger OnAssistEdit()
                        begin
                            CalcSel();
                        end;
                    
                }
            }
            part(BalGLEntries;"G/L Entries factbox")
            {
                ApplicationArea = All;

                SubPageView = sorting("Document No.","Posting Date");
                SubPageLink="Document No."=field("Document No."),
                            "Posting Date"=field("Posting Date");
            }

        }
        modify("Original Amount")
        {
            Visible = false;
        }
        
        modify(Amount)
        {
            Visible = false;
        }


        addafter("Remaining Amt. (LCY)")
        {

            
            field(Lettrage; App.NumberToLetterCust(Rec))
            {
                ApplicationArea = All;
                Caption = 'Lettrage';
                Editable = false;
                Style = Strong;
                StyleExpr = true;
                ToolTip = 'Lettrage';
            }
            field(SoldeDate; TempEntryNoAmountBuffer.Amount)
            {
                ApplicationArea = All;
                Caption = 'Solde date';
                Editable = false;
                ToolTip = 'Solde date';
            }
            
            field("Applied Cust. Ledger Entry No."; rec."Applied Cust. Ledger Entry No.")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'N° écriture client lettrée';
            }            
        }
        



        addafter(Description)
        {

            field("Facture acompte"; Rec."Facture acompte")
            {
                ApplicationArea = All;
                ToolTip = 'Facture d''acompte';
            }
            field("Facture situation"; Rec."Facture situation")
            {
                ApplicationArea = All;
                ToolTip = 'Facture de situation';
            }
            field("Code groupe"; Rec."Code groupe")
            {
                ApplicationArea = All;
                ToolTip = 'Groupe';
            }
            field("Nouveau Code enseigne"; Rec."Nouveau Code enseigne")
            {
                ApplicationArea = All;
                ToolTip = 'Enseigne';
            }
            field("Code operation"; Rec."Code operation")
            {
                ApplicationArea = All;
                ToolTip = 'Opération';
            }
            field("Code chantier"; Rec."Code chantier")
            {
                ApplicationArea = All;
                ToolTip = 'Chantier';
            }
            
        }
        
        
    }
    actions
    {
        modify(Dimensions)
        {
            Visible = false;
        }
        modify(SetDimensionFilter)
        {
            Visible = false;
        }
        modify("Create Finance Charge Memo")
        {
            Visible = false;
        }
        modify("Create Reminder")
        {
            Visible = false;
        }
        addafter("Apply Entries")
        {
            action(FiltrerCeLettrage)
            {
                ApplicationArea = All;
                Promoted = true;
                ToolTip = 'Filtrer sur ce lettrage';
                Image = FilterLines;
                
                                    
                trigger OnAction()
                var
                    CustApp: Codeunit "Apply entries";
                begin
                    CustApp.CustFilterOnApply(Rec);
                end;
            }
        }
        addafter("&Navigate")
        {
            action(AfficherDocEnreg)
            {
                ApplicationArea = All;
                ToolTip = 'Affichez les dtails pour l''avoir, la facture ou le paiement validé.';
                Promoted = true;
                PromotedIsBig = true;
                Image = Document;
                ShortcutKey = return;
                
                                    
                trigger OnAction()
                begin
                    Rec.ShowDoc();
                end;
            }
        }
        addlast(Reporting)
        {
            action(ExtraitDeCompte)
            {
                ApplicationArea = All;
                ToolTip = 'Extrait de compte';
                Caption = 'Extrait de compte';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;
                Image = Report2;
                
                                    
                trigger OnAction()
                var
                    Cust: Record Customer;
                    ReportExtraitCompteClient : Report "Extrait compte client";
                begin
                    if Cust.GET(Rec."Customer No.") then
                        Cust.SETRECFILTER();
                    ReportExtraitCompteClient.SETTABLEVIEW(Cust);
                    ReportExtraitCompteClient.RUN();

                end;
            }
        }
        
        
    }
        
    local procedure CalcSel()
    var
        SelCust: record "Cust. Ledger Entry";
    begin
        TotSel := 0;    
        TotSelDS := 0;
        CurrPage.SETSELECTIONFILTER(SelCust);
        if SelCust.FINDFIRST() then
            repeat
                SelCust.CALCFIELDS(Amount,"Amount (LCY)");
                TotSel += SelCust.Amount;
                TotSelDS += SelCust."Amount (LCY)";
            until SelCust.NEXT() = 0;       
    end;

    local procedure CalcTotalRemainingAmount()
    var
        CopyCustLedgerEntry: record "Cust. Ledger Entry";
        BalanceAmount: Decimal;
    begin
        BalanceAmount := 0;        
        // -> TRIX.027 LBO 15/10/2020
        CopyCustLedgerEntry.SETCURRENTKEY("Customer No.","Posting Date","Currency Code");
        CopyCustLedgerEntry.SETFILTER("Customer No.",Rec.GETFILTER(Rec."Customer No."));
        if CopyCustLedgerEntry.FINDSET() then
            repeat
            if not TempEntryNoAmountBuffer.GET('',CopyCustLedgerEntry."Entry No.") then begin
                CopyCustLedgerEntry.CALCFIELDS("Amount (LCY)");
                TempEntryNoAmountBuffer."Business Unit Code" := '';
                TempEntryNoAmountBuffer."Entry No." := CopyCustLedgerEntry."Entry No.";
                TempEntryNoAmountBuffer.Amount := BalanceAmount + CopyCustLedgerEntry."Amount (LCY)";
                TempEntryNoAmountBuffer.INSERT();
                BalanceAmount := TempEntryNoAmountBuffer.Amount;
            end;
            until (CopyCustLedgerEntry.NEXT() = 0) ;
        // <- TRIX.027 LBO 15/10/2020

    end;

    trigger OnOpenPage()
    begin
        // -> TRIX.027 LBO 15/10/2020
        if Rec.GETFILTER("Customer No.") <> '' then
            CalcTotalRemainingAmount();
        // <- TRIX.027 LBO 15/10/2020

    end;

    trigger OnAfterGetRecord()
    begin
        // -> TRIX.027 LBO 15/10/2020
        if not TempEntryNoAmountBuffer.GET('',Rec."Entry No.") then
            TempEntryNoAmountBuffer.INIT();
        // <- TRIX.027 LBO 15/10/2020
    end;
    var
               
        TempEntryNoAmountBuffer :  Record 386 temporary;
        App : Codeunit "Apply entries";
        TotSel : Decimal;
        TotSelDS : Decimal;
      
      

}
