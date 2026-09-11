page 50067 "Edit Sales Inv. Line Unit Cost"
{
    Caption = 'Edit Posted Sales Inv. Address';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Edit Sales Invoice";

    layout
    {
        area(content)
        {
            group(Ligne)
            {
                field("Posted Sales Invoice No."; Rec."Posted Sales Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("Posted Sales Invoice Line No."; Rec."Posted Sales Invoice Line No.")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Line Description"; Rec."Line Description")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnModifyRecord(): Boolean
    begin
        CODEUNIT.RUN(CODEUNIT::"Posted Sales Invoice - Edit", Rec);
        exit(false);
    end;
}

