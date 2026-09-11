pageextension 50063 CashReceiptJournalExtension extends "Cash Receipt Journal"
{
    layout
    {
        modify("Direct Debit Mandate ID")
        {
          Visible = false;
        }
        modify(Description)
        {
          Caption = 'Désignation ligne';
        }
        addbefore(Description)
        {
            field("DesignationCompte"; Rec.RecupNomCompte())
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Désignation compte';
                ToolTip = 'Désignation compte';
            }
        }
        addafter(Description)
        {
            field("Payment Method Code"; Rec."Payment Method Code")
            {
                ApplicationArea = All;
                Caption = 'Code mode règlement';
                ToolTip = 'Code mode règlement';
            }

        }

        
    }
    
        


}

