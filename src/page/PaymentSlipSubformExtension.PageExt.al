pageextension 50057 PaymentSlipSubformExtension extends "Payment Slip Subform"
{
    layout
    {
        addafter("Account No.")
        {

            field("Nom compte"; Rec.RecupNomCompte())
            {
                ApplicationArea = All;
                Caption = 'Désignation compte';
                ToolTip = 'Désignation compte';
            }

        }

    }
    actions
    {


    }
}
