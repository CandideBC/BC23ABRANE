pageextension 50112 PostedReturnReceiptSFExtension extends "Posted Return Receipt Subform"
{
    layout
    {
        addafter("Return Reason Code")
        {

            field("Reason Code";Rec."Reason Code")
            {
                ToolTip = 'Code motif';
            }
        }
    }
    actions
    {

    }
}
