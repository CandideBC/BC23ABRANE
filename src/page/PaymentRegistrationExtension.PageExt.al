pageextension 50100 PaymentRegistrationExtension extends "Payment Registration"
{
    layout
    {

        addafter(Name)
        {

            field("Payment Method Code";Rec."Payment Method Code")
            {
                ApplicationArea = All;
                Caption = 'Code mode de règlement';
                ToolTip = 'Code mode de règlement';
            }

        }
        addafter(Description)
        {

            field("External Document No.";Rec."External Document No.")
            {
                ApplicationArea = All;
                Caption = 'N° doc. externe';
                ToolTip = 'N° doc. externe';
            }

        }

    }
    actions
    {


    }
}
