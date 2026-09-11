pageextension 50101 GetReceiptLinesExtension extends "Get Receipt Lines"
{
    layout
    {
        addafter("Qty. Rcd. Not Invoiced")
        {
            field(totalHT;Totalht)
            {
                ApplicationArea = All;
                Caption = 'Total HT';
                ToolTip = 'Total HT';
                HideValue = DocumentNoHideValue;
            }
            field("Pontant remise"; MontantRemise)
            {
                ApplicationArea = All;
                Caption = 'Montant remise';
                ToolTip = 'Montant remise';
                HideValue = DocumentNoHideValue;
            }
            
            field("Total HT Net"; TotalHTNet)
            {
                ApplicationArea = All;
                ToolTip = 'Total HT Net';
                Caption = 'Total HT Net';
                HideValue = DocumentNoHideValue;
            }
            
            
        }
    }


    actions
    {

    }

    trigger
        OnAfterGetCurrRecord()
        var
            EnteteRecep: Record "Purch. Rcpt. Header";
        begin
            if IsFirstDocLine() then begin
                EnteteRecep.GET(Rec."Document No.");
                EnteteRecep.CalcTotalHT(TotalHT,MontantRemise);
                TotalHTNet := TotalHT - MontantRemise;
            end;
        end;
    var 
        TotalHT: Decimal;
        MontantRemise: Decimal;
        TotalHTNet: Decimal;
}
