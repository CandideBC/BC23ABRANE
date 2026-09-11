pageextension 50109 PurchReturnListArchExtension extends "Purchase Return List Archive"
{
    layout
    {
        addafter("Currency Code")
        {

            field("Comments"; Rec."Comments")
            {
                ToolTip = 'Commentaires';
            }
        }
    }
    actions
    {

    }
}
