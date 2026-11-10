page 50068 WSListeFnsSuiviContainer
{
    ApplicationArea = All;
    Caption = 'WSListeFnsSuiviContainer';
    PageType = List;
    SourceTable = Vendor;
    SourceTableView = sorting("Suivi container") where ("Suivi container"=const(true));
    UsageCategory = None;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Name 2"; Rec."Name 2")
                {
                }
                field(Address; Rec.Address)
                {
                }
                field("Address 2"; Rec."Address 2")
                {
                }
                field("Post Code"; Rec."Post Code")
                {
                }
                field(City; Rec.City)
                {
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                }
            }
        }
    }
}
