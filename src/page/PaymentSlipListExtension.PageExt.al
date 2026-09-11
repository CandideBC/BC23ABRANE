pageextension 50058 PaymentSlipListExtension extends "Payment Slip List"
{
    layout
    {


    }
    actions
    {

        addfirst(Processing)
        {
            action("Créer bordereau de paiement")
            {
                ApplicationArea = All;
                RunObject = codeunit 10860;
                Promoted = true;
                ToolTip = 'Créer bordereau de paiement';
                Image = New;
                trigger OnAction()
                begin
                    
                end;
            }
        }
    }
}
