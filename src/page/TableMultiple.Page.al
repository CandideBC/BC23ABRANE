page 50041 "Table multiple"
{
    PageType = List;
    SourceTable = "Table multiple";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ToolTip = 'Type';
                    Visible = booType;
                }
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Code';
                }
                field("Libellé"; Rec.Libellé)
                {
                    ToolTip = 'Libellé';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        if Rec.GetFilter(Type) <> '' then begin
            CurrPage.Caption := Rec.GetFilter(Type);
            booType := false;
        end else
            booType := true;
    end;

    var
        booType: Boolean;
}

