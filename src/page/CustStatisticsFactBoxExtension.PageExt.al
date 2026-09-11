pageextension 50132 CustStatisticsFactBoxExtension extends "Customer Statistics FactBox"
{
    layout
    {
        modify(BalanceAsVendor)
        {
            Visible = false;
        }
        modify(Payments)
        {
            Visible = false;
        }
        modify(Service)
        {
            Visible = false;
        }
        modify("Credit Limit (LCY)")
        {
            Visible = false;
        }
        modify("Total (LCY)")
        {
            Visible = false;
        }
        modify("Outstanding Invoices (LCY)")
        {
            Visible = false;
        }
        modify("Refunds (LCY)")
        {
            Visible = false;
        }
    }
}
