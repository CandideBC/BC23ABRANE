pageextension 50021 GeneralJournalExtension extends "General Journal"
{
    layout
    {
        modify("Direct Debit Mandate ID")
        {
          Visible = false;
        }
        addafter("VAT Amount")
        {
            field("VAT Base Amount"; Rec."VAT Base Amount")
            {
                ApplicationArea = All;
                ToolTip = 'Montant base TVA';
            }
        }

        
    }
    
        


}

