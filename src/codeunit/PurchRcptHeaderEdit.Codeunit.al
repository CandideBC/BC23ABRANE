codeunit 50006 "Purch. Rcpt. Header - Edit"
{
    // DV0035

    Permissions = TableData "Purch. Rcpt. Header" = m;
    TableNo = "Purch. Rcpt. Header";

    trigger OnRun()
    begin
        PurchRcptHeader := Rec;
        PurchRcptHeader.LockTable();
        PurchRcptHeader.Find();
        PurchRcptHeader."Code magasin transfert" := Rec."Code magasin transfert";
        PurchRcptHeader."Date transfert" := Rec."Date transfert";
        //KAN.FHA 24/03/2022 DEBUT
        PurchRcptHeader."Vu controle SAV / Avoir" := Rec."Vu controle SAV / Avoir";
        //KAN.FHA 24/03/2022 FIN
        //KAN.FHA 21/09/2022 DEBUT
        PurchRcptHeader."No. container" := Rec."No. container";
        //KAN.FHA 21/09/2022 FIN
        PurchRcptHeader.Modify();
        Rec := PurchRcptHeader;
    end;

    var
        PurchRcptHeader: Record "Purch. Rcpt. Header";
}

