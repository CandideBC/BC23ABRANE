codeunit 50007 "Posted Sales Invoice - Edit"
{
    //Codeunit supprimable car fonction standard de Microsoft pour pouvoir modifier entête de facture vente enregistrée.
    //Par contre, pour les lignes, je n'ai pas trouvé de standard donc peut etre pas supprimable.
    Permissions = TableData "Sales Invoice Header" = m,
                  TableData "Sales Invoice Line" = m;
    TableNo = "Edit Sales Invoice";

    trigger OnRun()
    var
        CurrExchRate: Record "Currency Exchange Rate";
    begin
        if rec."Posted Sales Invoice Line No." = 0 then begin //On est dans le cas d'une modification d'adresse (entete)
            if PostedSalesInvoiceHeader.Get(Rec."Posted Sales Invoice No.") then begin
                PostedSalesInvoiceHeader.LockTable();
                //PostedSalesInvoiceHeader.FIND;
                PostedSalesInvoiceHeader."Bill-to Name" := Rec."Bill-to Name";
                PostedSalesInvoiceHeader."Bill-to Name 2" := Rec."Bill-to Name 2";
                PostedSalesInvoiceHeader."Bill-to Address" := Rec."Bill-to Address";
                PostedSalesInvoiceHeader."Bill-to Address 2" := Rec."Bill-to Address 2";
                PostedSalesInvoiceHeader."Bill-to Post Code" := Rec."Bill-to Post Code";
                PostedSalesInvoiceHeader."Bill-to City" := Rec."Bill-to City";
                PostedSalesInvoiceHeader."Bill-to Contact" := Rec."Bill-to Contact";
                PostedSalesInvoiceHeader."Bill-to Country/Region Code" := Rec."Bill-to Country/Region Code";
                PostedSalesInvoiceHeader."Sell-to Customer Name" := Rec."Sell-to Customer Name";
                PostedSalesInvoiceHeader."Sell-to Customer Name 2" := Rec."Sell-to Customer Name 2";
                PostedSalesInvoiceHeader."Sell-to Address" := Rec."Sell-to Address";
                PostedSalesInvoiceHeader."Sell-to Address 2" := Rec."Sell-to Address 2";
                PostedSalesInvoiceHeader."Sell-to Post Code" := Rec."Sell-to Post Code";
                PostedSalesInvoiceHeader."Sell-to City" := Rec."Sell-to City";
                PostedSalesInvoiceHeader."Sell-to Country/Region Code" := Rec."Sell-to Country/Region Code";
                PostedSalesInvoiceHeader."Sell-to Contact" := Rec."Sell-to Contact";
                //KAN.FHA 16/06/2025 DEBUT
                PostedSalesInvoiceHeader."VAT Registration No." := Rec."VAT Registration No.";
                //KAN.FHA 10/08/2020 DEBUT
                PostedSalesInvoiceHeader."Shipment Method Code" := Rec."Shipment Method Code";
                PostedSalesInvoiceHeader."Number Of Packages" := Rec."Number Of Packages";
                PostedSalesInvoiceHeader."Pallet Number" := Rec."Pallet Number";
                PostedSalesInvoiceHeader."Total Net Weight" := Rec."Total Net Weight";
                PostedSalesInvoiceHeader."Total Gross Weight" := Rec."Total Gross Weight";
                //KAN.FHA 10/08/2020 FIN
                //KAN.FHA 03/06/2021 DEBUT
                PostedSalesInvoiceHeader."Montant deja verse TTC" := Rec."Montant deja verse TTC";
                //KAN.FHA 03/06/2021 FIN
                //KAN.FHA 29/09/2021 DEBUT
                PostedSalesInvoiceHeader."External Document No." := Rec."External Document No.";
                //KAN.FHA 29/09/2021 FIN
                //KAN.FHA 02/02/2022 DEBUT
                PostedSalesInvoiceHeader."Ship-to Name" := Rec."Ship-to Name";
                PostedSalesInvoiceHeader."Ship-to Name 2" := Rec."Ship-to Name 2";
                PostedSalesInvoiceHeader."Ship-to Address" := Rec."Ship-to Address";
                PostedSalesInvoiceHeader."Ship-to Address 2" := Rec."Ship-to Address 2";
                PostedSalesInvoiceHeader."Ship-to City" := Rec."Ship-to City";
                PostedSalesInvoiceHeader."Ship-to Contact" := Rec."Ship-to Contact";
                PostedSalesInvoiceHeader."Ship-to Post Code" := Rec."Ship-to Post Code";
                PostedSalesInvoiceHeader."Ship-to Country/Region Code" := Rec."Ship-to Country/Region Code";
                //KAN.FHA 02/02/2022 FIN
                //KAN.FHA 23/02/2023 DEBUT
                PostedSalesInvoiceHeader."Concernee DEB" := Rec."Concernee DEB";
                //KAN.FHA 23/02/2023 FIN
                PostedSalesInvoiceHeader.Modify();
            end
        end else //On est dans le cas d'une modification de cout unitaire d'un article divers sur une ligne de facture
            if SalesInvoiceLine.Get(Rec."Posted Sales Invoice No.", Rec."Posted Sales Invoice Line No.") then begin
                if SalesInvoiceLine."Unit Cost (LCY)" <> Rec."Unit Cost (LCY)" then begin
                    SalesInvoiceLine."Cout unitaire force" := true;
                    SalesInvoiceLine."Cout unitaire force par" := COPYSTR(UserId,1,50);
                end;
                SalesInvoiceLine."Unit Cost (LCY)" := Rec."Unit Cost (LCY)";
                SalesInvoiceLine."Cout ligne HT (DS)" := Rec."Total Cost";
                PostedSalesInvoiceHeader.Get(SalesInvoiceLine."Document No.");
                if PostedSalesInvoiceHeader."Currency Code" <> '' then 
                    SalesInvoiceLine."Unit Cost" :=
                      Round(
                        CurrExchRate.ExchangeAmtLCYToFCY(
                          PostedSalesInvoiceHeader."Posting Date", PostedSalesInvoiceHeader."Currency Code",
                          SalesInvoiceLine."Unit Cost (LCY)", PostedSalesInvoiceHeader."Currency Factor"),
                        0.01)
                else
                    SalesInvoiceLine."Unit Cost" := SalesInvoiceLine."Unit Cost (LCY)";

                SalesInvoiceLine.Modify();
            end;
    end;

    var
        PostedSalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine: Record "Sales Invoice Line";
}

