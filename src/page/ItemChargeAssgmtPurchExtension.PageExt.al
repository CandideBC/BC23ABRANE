pageextension 50103 ItemChargeAssgmtPurchExtension extends "Item Charge Assignment (Purch)"
{
    layout
    {
    }
    actions
    {
        modify(SuggestItemChargeAssignment)
        {
            Promoted = true;
            PromotedIsBig = true;
            PromotedCategory = Process;
        }
    }
}
