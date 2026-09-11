pageextension 50105 SalesReturnListArchExtension extends "Sales Return List Archive"
{
    layout
    {
        addafter("Currency Code")
        {
            field(Comments; Rec.Comments)
            {
                ApplicationArea = All;
                ToolTip = 'Commentaires';
            }
            
            field("Posting No. Series";Rec."Posting No. Series")
            {
                ApplicationArea = All;
                ToolTip = 'Souche validation';
            }
            field(ass; Rec.ass)
            {
                ApplicationArea = All;
                ToolTip = 'SAV';
            }
        }
    }
    actions
    {

    }
}
