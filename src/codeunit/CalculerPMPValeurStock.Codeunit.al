codeunit 50020 CalculerPMP_ValeurStock
{
    //Executé une fois par mois par une tache planifiée
trigger OnRun()
var
    CalculStockReport: Report "Calculer stock a date";
    DateCalcul: Date;
begin
    Clear(CalculStockReport);
    DateCalcul := CalcDate('<-CM-1D>',Today);
    CalculStockReport.DefDate(DateCalcul);
    CalculStockReport.UseRequestPage(false);
    CalculStockReport.Run();
end;    
}
