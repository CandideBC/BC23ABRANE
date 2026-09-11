page 50015 "Update Eco Tax posted"
{
    UsageCategory = Lists;
    ApplicationArea = All;
    Caption = 'Update Eco Tax posted';
    PageType = Card;
    SourceTable = "Eco Tax Furniture posted";

    layout
    {
        area(content)
        {
            Description = 'Filtre';
            field(DateFilterDebut; DateFilterDebut)
            {
                ToolTip = 'Filtre date début';
                Caption = 'Date début';
            }
            field(DateFilterFin; DateFilterFin)
            {
                ToolTip = 'Filtre date fin';
                Caption = 'Date fin';
            }
        }
    }

    actions
    {
    }

    trigger OnClosePage()
    begin
        Rec.UpdateBoard(DateFilterDebut, DateFilterFin);
    end;

    var
        DateFilterDebut: Date;
        DateFilterFin: Date;
}

