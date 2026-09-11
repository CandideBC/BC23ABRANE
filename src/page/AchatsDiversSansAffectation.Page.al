page 50070 "Achats Divers sans affectation"
{
    ApplicationArea = all;
    PageType = StandardDialog;
    SourceTable = "Purchase Line";
    SourceTableView = sorting ("Article divers", "Document Type", "Document No.")
                      where ("Article divers" = const (true),
                            "Document Type" = const (Order),
                            "Nb lignes ventes liees" = const (0));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'N°';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Quantité';
                }
            }
            part(Lignes; "SF Achats Divers sans affectat")
            {
                Caption = 'Lignes';
                SubPageLink = "No. document achat" = field ("Document No."),
                              "No. ligne document achat" = field ("Line No.");
            }
        }
    }

    actions
    {

    }

    trigger OnOpenPage()
    begin
        if NumCde <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Document Type",Rec."Document Type"::Order);
            Rec.SetRange("Document No.", NumCde);
            Rec.FilterGroup(0);
        end;
    end;

    var
        NumCde: Code[20];

    procedure DefFiltre(pNumCde: Code[20])
    begin
        NumCde := pNumCde;
    end;
}

