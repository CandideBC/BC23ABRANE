codeunit 50015 "Posted Purchase Invoice - Edit"
{
    Permissions = TableData "Purch. Inv. Header" = m;
    TableNo = "Edit Purchase Invoice";

    trigger OnRun()
    var
    begin
            if PostedPurchInvoiceHeader.Get(Rec."Posted Purchase Invoice No.") then begin
                PostedPurchInvoiceHeader.LockTable();
                PostedPurchInvoiceHeader."Pay-to Name" := Rec."Pay-to Name";
                PostedPurchInvoiceHeader."Pay-to Name 2" := Rec."Pay-to Name 2";
                PostedPurchInvoiceHeader."Pay-to Address" := Rec."Pay-to Address";
                PostedPurchInvoiceHeader."Pay-to Address 2" := Rec."Pay-to Address 2";
                PostedPurchInvoiceHeader."Pay-to Post Code" := Rec."Pay-to Post Code";
                PostedPurchInvoiceHeader."Pay-to City" := Rec."Pay-to City";
                PostedPurchInvoiceHeader."Pay-to Contact" := Rec."Pay-to Contact";
                PostedPurchInvoiceHeader."Pay-to Country/Region Code" := Rec."Pay-to Country/Region Code";
                PostedPurchInvoiceHeader."Buy-from Vendor Name" := Rec."Buy-from Vendor Name";
                PostedPurchInvoiceHeader."Buy-from Vendor Name 2" := Rec."Buy-from Vendor Name 2";
                PostedPurchInvoiceHeader."Buy-from Address" := Rec."Buy-from Address";
                PostedPurchInvoiceHeader."Buy-from Address 2" := Rec."Buy-from Address 2";
                PostedPurchInvoiceHeader."Buy-from Post Code" := Rec."Buy-from Post Code";
                PostedPurchInvoiceHeader."Buy-from City" := Rec."Buy-from City";
                PostedPurchInvoiceHeader."Buy-from Country/Region Code" := Rec."Buy-from Country/Region Code";
                PostedPurchInvoiceHeader."Buy-from Contact" := Rec."Buy-from Contact";
                PostedPurchInvoiceHeader."VAT Registration No." := Rec."VAT Registration No.";
                PostedPurchInvoiceHeader."Concernee DEB" := Rec."Concernee DEB";
                PostedPurchInvoiceHeader.Modify();
            end
        
    end;

    var
        PostedPurchInvoiceHeader: Record "purch. inv. header";
}

