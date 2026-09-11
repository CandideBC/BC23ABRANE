tableextension 50055 PaymentLineExtension extends "Payment Line"
{
    fields
    {

    }
    procedure RecupNomCompte():Text[100]
    var
        Vendor: Record Vendor;
        Customer: Record Customer;
        NameAccountNo : Text[100];
    begin
        NameAccountNo := '';
        if "Account Type" = "Account Type"::Customer then 
            if Customer.GET("Account No.") then
                NameAccountNo := Customer.Name;
        
        if "Account Type" = "Account Type"::Vendor then 
        if Vendor.GET("Account No.") then
            NameAccountNo := Vendor.Name;
        
        
        exit(NameAccountNo);
    end;
}

