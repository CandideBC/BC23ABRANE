page 50017 TestsSemaines
{
    ApplicationArea = All;
    Caption = 'TestsSemaines';
    PageType = List;
    SourceTable = "Date";
    SourceTableView = where ("Period Type" = const(Week));
    UsageCategory = Lists;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Period Type"; Rec."Period Type")
                {
                }
                field("Period Start"; Rec."Period Start")
                {
                }
                field("Period End"; Rec."Period End")
                {
                }
                field("Period No."; Rec."Period No.")
                {
                }
                field("Period Name"; Rec."Period Name")
                {
                }
                field("Period Invariant Name"; Rec."Period Invariant Name")
                {
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.Setrange("Period Start",today,20260807D);
    end;
}
