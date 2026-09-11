pageextension 50025 CustomerPostingGroupsExtension extends "Customer Posting Groups"
{

    layout
    {

        
        addafter("Payment Tolerance Credit Acc.")
        {

            field("Prepayment deducted Acc."; Rec."Prepayment deducted Acc.")
            {
                ToolTip = 'Compte acompte déduit';
            }

        }

        
    }




        
}

