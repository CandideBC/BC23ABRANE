codeunit 50010 SupprimerCommandesFacturees
{
    var
        SupprQst: Label 'Voulez-vous supprimer les commandes achats et ventes complètement facturées ?';
    trigger OnRun()
    begin
        if not Confirm(SupprQst) then
            exit;

        Report.run(Report::"Delete Invoiced Purch. Orders");
        Commit();
        Report.Run(Report::"Delete Invoiced Sales Orders");

    end;
}
