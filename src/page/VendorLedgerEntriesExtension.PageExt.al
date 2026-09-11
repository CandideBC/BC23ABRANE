pageextension 50081 VendorLedgerEntriesExtension extends "Vendor Ledger Entries"
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



            field(Lettrage; App.NumberToLetterVend(Rec))
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
            
            field("Applied Vend. Ledger Entry No." ; Rec."Applied Vend. Ledger Entry No.")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'N° écriture fns lettrée';
                Visible = false;
            }            
        }
        



        
        
    }
    actions
    {
        addafter(ActionApplyEntries)
        {
            action(FiltrerCeLettrage)
            {
                ApplicationArea = All;
                Promoted = true;
                ToolTip = 'Filtrer sur ce lettrage';
                Image = FilterLines;
                
                                    
                trigger OnAction()
                var
                    VendApp: Codeunit "Apply entries";
                begin
                    VendApp.VendFilterOnApply(Rec);
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
        addafter(IncomingDocument)
        {
            action(ExtraitDeCompte)
            {
                ApplicationArea = All;
                ToolTip = 'Extrait de compte';
                Promoted = true;
                PromotedIsBig = true;
                Image = Report2;
                
                                    
                trigger OnAction()
                var
                    Vend: Record Vendor;
                    VendDue : Report "Vendor due entries";
                begin
                    if Vend.GET(Rec."Vendor No.") then
                        Vend.SETRECFILTER();
                    VendDue.SETTABLEVIEW(Vend);
                    VendDue.RUN();

                end;
            }
        }
        
        
    }

    local procedure CalcSel();
    var
      SelCust : Record "Vendor Ledger Entry";
    begin
      // -> TRIX.027 LBO 14/10/2020
      TotSel := 0;
      TotSelDS := 0;
      CurrPage.SETSELECTIONFILTER(SelCust);
      if SelCust.FINDFIRST() then
        repeat
          SelCust.CALCFIELDS(Amount,"Amount (LCY)");
          TotSel += SelCust.Amount;
          TotSelDS += SelCust."Amount (LCY)";
        until SelCust.NEXT() = 0;
      // <- TRIX.027 LBO 14/10/2020
    end;

    procedure CalcTotalAmount();
    var
      CopyVendLedgerEntry : Record 25;
      BalanceAmount : Decimal;
    begin
      // -> TRIX.027 LBO 15/10/2020
      BalanceAmount := 0;
      CopyVendLedgerEntry.SETCURRENTKEY("Vendor No.","Posting Date","Currency Code");
      CopyVendLedgerEntry.SETFILTER("Vendor No.",Rec.GETFILTER(Rec."Vendor No."));

      if CopyVendLedgerEntry.FINDSET(false) then
        repeat
          if not TempEntryNoAmountBuffer.GET('',CopyVendLedgerEntry."Entry No.") then begin
            CopyVendLedgerEntry.CALCFIELDS("Amount (LCY)");
            TempEntryNoAmountBuffer."Business Unit Code" := '';
            TempEntryNoAmountBuffer."Entry No." := CopyVendLedgerEntry."Entry No.";
            TempEntryNoAmountBuffer.Amount := BalanceAmount + CopyVendLedgerEntry."Amount (LCY)";
            TempEntryNoAmountBuffer.INSERT();
            BalanceAmount := TempEntryNoAmountBuffer.Amount;
          end;
        until (CopyVendLedgerEntry.NEXT() = 0) ;
      // <- TRIX.027 LBO 15/10/2020
    end;

    var
               
        TempEntryNoAmountBuffer :  Record 386 temporary;
        App : Codeunit "Apply entries";
        TotSel : Decimal;
        TotSelDS : Decimal;
      
    trigger OnOpenPage()
    begin
        // -> TRIX.027 LBO 15/10/2020
        if Rec.GETFILTER("Vendor No.") <> '' then
            CalcTotalAmount();
        // <- TRIX.027 LBO 15/10/2020

    end;

    trigger OnAfterGetRecord()
    begin
        // -> TRIX.027 LBO 15/10/2020
        if not TempEntryNoAmountBuffer.GET('',Rec."Entry No.") then
            TempEntryNoAmountBuffer.INIT();
        // <- TRIX.027 LBO 15/10/2020


    end;

}
