page 50019 "Update Component"
{
    UsageCategory = None;
    ApplicationArea = All;
    Caption = 'Mise à jour composant';
    InsertAllowed = false;
    PageType = Worksheet;

    layout
    {
        area(content)
        {
            //group("Général")
            //{
                field(ItemNo; ItemNo)
                {
                    Caption = 'N° article';
                    ToolTip = 'N° article';
                    TableRelation = Item."No.";
                }
                field(QuantitePourUnParent; QuantitePourUnParent)
                {
                    Caption = 'Quantité pour 1';
                    ToolTip = 'Quantité pour 1';
                    DecimalPlaces = 0:5;
                }
            //}
        }
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        LigneMere: Record "Sales Line";
        QuantiteLigneParent: Decimal;
    begin
        if CloseAction = ACTION::LookupOK then begin
            if Confirm(diatext001Qst) then begin
                if LigneMere.get(DocType, DocNo,LinkLine) then
                    QuantiteLigneParent := LigneMere.Quantity;

                RecSalesLine.SetRange("Document Type", DocType);
                RecSalesLine.SetRange("Document No.", DocNo);
                RecSalesLine.SetRange("Line No.", LineNo);
                if RecSalesLine.FindSet() then begin
                    RecSalesLine.Validate("No.", ItemNo);
                    RecSalesLine.Validate(Quantity, QuantitePourUnParent * QuantiteLigneParent);
                    RecSalesLine."Quantite pour 1" := QuantitePourUnParent;
                    RecSalesLine.Validate("Unit Price", 0);
                    RecSalesLine."Linked to line" := LinkLine;
                    RecSalesLine."BOM Item No." := ItemLink;
                    RecSalesLine.Validate("Location Code", Location);
                    RecSalesLine.Modify();

                end;
            end else
                Message(diatext002Msg);
        end else
            Message(diatext002Msg);
    end;

    var
        RecSalesLine: Record "Sales Line";
        ItemNo: Code[20];
        QuantitePourUnParent: Decimal;
        LinkLine: Integer;
        ItemLink: Code[20];
        DocType: Enum "Sales Document Type";
        DocNo: Code[20];
        LineNo: Integer;
        
        diatext001Qst: Label 'Mettre à jour composant';
        diatext002Msg: Label 'Mise à jour annulée';
        Location: Code[20];

    procedure SetData(ItemCode: Code[20]; pQuantitePourUnParent: Decimal; pLinkLine: Integer; pItemLink: Code[20]; pDocType: Enum "Sales Document Type"; pDocNo: Code[20]; pLineNo: Integer; pLocation: Code[20])
    begin
        ItemNo := ItemCode;
        QuantitePourUnParent := pQuantitePourUnParent;
        LinkLine := pLinkLine;
        ItemLink := pItemLink;
        DocType := pDocType;
        DocNo := pDocNo;
        LineNo := pLineNo;
        Location := pLocation;
    end;
}

