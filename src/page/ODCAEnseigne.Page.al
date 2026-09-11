page 50088 "OD CA Enseigne"
{
    PageType = List;
    SourceTable = "OD CA Enseigne";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Type OD"; Rec."Type OD")
                {
                    ApplicationArea = All;
                    ToolTip = 'Type d''OD';
                    Editable = false;
                }
                field("Code enseigne"; Rec."Code enseigne")
                {
                    ApplicationArea = All;
                    ToolTip = 'Code enseigne';
                }
                field("Code groupe"; Rec."Code groupe")
                {
                    ApplicationArea = All;
                    ToolTip = 'Code groupe';
                }
                field("No. sequence"; Rec."No. sequence")
                {
                    ApplicationArea = All;
                    ToolTip = 'N° de séquence';
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Date';
                }
                field("Date contrepartie"; Rec."Date contrepartie")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date contrepartie';
                }
                field("CA transfere"; Rec."CA transfere")
                {
                    ApplicationArea = All;
                    ToolTip = 'CA transféré';
                }
                field(Commentaire; Rec.Commentaire)
                {
                    ApplicationArea = All;
                    ToolTip = 'Commentaire';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Type OD" := Rec."Type OD"::Saisie;
    end;
}

