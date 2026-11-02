codeunit 50003 MAJInfosCommandes
{
    trigger OnRun()
    begin
        EnteteVente.SetRange("Document Type", EnteteVente."Document Type"::Order);
        if EnteteVente.FindSet(true) then
            repeat
                DossierFacturable := EnteteVente."Dossier facturable";
                EnteteVente.CalcFields("Completely Shipped");
                EnteteVente."Dossier facturable" :=
                    (EnteteVente."Completely Shipped") or
                    (EnteteVente."Requested Delivery Date" < today) or 
                    (EnteteVente."Facturation en compta (O/N)");
                if EnteteVente."Dossier facturable" <> DossierFacturable then 
                    EnteteVente.Modify();
            until EnteteVente.Next() = 0;
    end;

    var
        EnteteVente: Record "Sales Header";
        DossierFacturable: Boolean;
}
