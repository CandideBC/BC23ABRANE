pageextension 50055 "SalesQuoteArchivesExtension" extends "Sales Quote Archives"
{
    layout
    {


        
        addafter("Salesperson Code")
        {
            field(Comments; Rec.Comments)
            {
                ApplicationArea = All;
                ToolTip = 'Commentaires';
            }
            field(Ass; Rec.ASS)
            {
                ApplicationArea = All;
                ToolTip = 'SAV';
            }
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = All;
                ToolTip = 'N° souche validation';
            }
        }

    }
}
