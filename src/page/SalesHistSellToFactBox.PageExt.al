pageextension 50131 SalesHistSellToFactBox extends "Sales Hist. Sell-to FactBox"
{
    layout
    {
        modify(NoofBlanketOrdersTile)
        {
            Visible = false;
        }
        modify(NoofInvoicesTile)
        {
            Visible = false;
        }
        modify(NoofCreditMemosTile)
        {
            Visible = false;
        }
        modify(NoofReturnOrdersTile)
        {
            Visible = false;
        }
        modify(NoofPstdReturnReceiptsTile)
        {
            Visible = false;
        }
    }
}
