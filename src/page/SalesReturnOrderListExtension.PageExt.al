pageextension 50048 SalesReturnOrderListExtension extends "Sales Return Order List"
{
    layout
    {
        addafter("Salesperson Code")
        {


            field("Code groupe"; Rec."Code groupe")
            {
                ApplicationArea = All;
                ToolTip = 'Code groupe';
            }
            field("Code enseigne"; Rec."Code enseigne")
            {
                ApplicationArea = All;
                ToolTip = 'Code enseigne';
            }
            field("Code operation"; Rec."Code operation")
            {
                ApplicationArea = All;
                ToolTip = 'Code opération';
            }
            field("Code chantier"; Rec."Code chantier")
            {
                ApplicationArea = All;
                ToolTip = 'Code chantier';
            }
            field("Reason Code"; Rec."Reason Code")
            {
                ApplicationArea = All;
                ToolTip = 'Code motif';
            }


        }


    }
}
