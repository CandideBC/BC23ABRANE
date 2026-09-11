pageextension 50094 PostedPurchRcptLinesExtension extends "Posted Purchase Receipt Lines"
{
    actions
    {
        addlast("&Line")
        {
            action("Lignes facture article")
            {
                ApplicationArea = All;
                ToolTip = 'Lignes facture article';
                Promoted=true;
                PromotedIsBig=true;
                Image=ItemInvoice;
                PromotedCategory=Process;

                
                trigger OnAction()
                begin
                    Rec.ShowItemPurchInvLines();
                end;
            }
        }
    }
}
