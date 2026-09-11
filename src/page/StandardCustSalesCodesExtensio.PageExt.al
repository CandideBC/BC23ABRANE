pageextension 50136 StandardCustSalesCodesExtensio extends "Standard Customer Sales Codes"
{
    layout
    {
        modify(Code)
        {
             trigger OnDrillDown()
                begin
                    //Pour empecher de valider sa selection juste en cliquant sur le code (trop rapide)
                    error('');
                end;

        }
        
    }
    actions
       {
        modify(Card)
        {
            Promoted = true;
            PromotedIsBig = true;
            PromotedCategory = Process;
        }
       }
}
