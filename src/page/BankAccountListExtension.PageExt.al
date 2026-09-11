pageextension 50069 BankAccountListExtension extends "Bank Account List"
{
    layout
    {

    }
    actions
    {
        addafter("Bank Account Statements")
        {
            action("Annuler rapprochement bancaire")
            {
                ApplicationArea = All;
                Image = DeleteQtyToHandle;
                ToolTip = 'Annuler rapprochement bancaire';
                RunObject = report "Bank Account Statement Cancel";

            }
        }
    }
}
