pageextension 50065 ReqWorksheetExtension extends "Req. Worksheet"
{
    layout
    {
        modify(Description)
        {
            Caption = 'Désignation ligne';
        }
        addafter("Description 2")
        {

            field("Complement ref. client"; Rec."Complement ref. client")
            {
                ApplicationArea = All;
                Caption = 'Complément ref. client';
                ToolTip = 'Complément ref. client';
            }
            field("No. 2"; Rec."No. 2")
            {
                ApplicationArea = All;
                Caption = 'N° 2';
                ToolTip = 'N° 2';
            }
        }

    }
    actions
    {


    }
}
