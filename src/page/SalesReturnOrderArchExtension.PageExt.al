pageextension 50104 SalesReturnOrderArchExtension extends "Sales Return Order Archive"
{
    layout
    {
        addafter(Status)
        {
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
