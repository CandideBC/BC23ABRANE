pageextension 50064 PaymentJournalExtension extends "Payment Journal"
{
    layout
    {
        modify(Description)
        {
            Caption = 'Désignation ligne';
        }
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
