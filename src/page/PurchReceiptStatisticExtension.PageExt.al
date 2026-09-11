pageextension 50130 PurchReceiptStatisticExtension extends "Purchase Receipt Statistics"
{
    layout
    {
        addafter(TotalVolume)
        {

            field("Montant HT"; MontantHT)
            {
                Caption = 'Montant HT';
                ToolTip = 'Montant HT';
            }
            field("Montant remise"; MontantRemise)
            {
                Caption = 'Montant remise';
                ToolTip = 'Montant remise';
            }
            field("Total HT Net"; MontantHT - MontantRemise)
            {
                Caption = 'Total HT Net';
                ToolTip = 'Total HT Net';
            }
        }
    }
    var
        MontantHT : Decimal;
        MontantRemise : Decimal;

    trigger OnOpenPage()
    begin
        rec.CalcTotalHT(MontantHT,MontantRemise);
    end;

}

