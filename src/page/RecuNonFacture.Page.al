page 50052 "Recu non facture"
{   
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Reçu non facturé';
    Editable = false;
    PageType = List;
    SourceTable = "Purchase Line";
    SourceTableView = where ("Qty. Rcd. Not Invoiced" = filter (<> 0));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'N° document';
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ToolTip = 'N° preneur d''ordre';
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'N° ligne';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Type';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'N°';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Quantité';
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                    ToolTip = 'Quantité restante';
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ToolTip = 'Coût unitaire (DS)';
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ToolTip = 'Montant ligne';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Montant';
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ToolTip = 'Montant TTC';
                }
                field("Qty. Rcd. Not Invoiced"; Rec."Qty. Rcd. Not Invoiced")
                {
                    ToolTip = 'Qté reçue non facturée';
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    ToolTip = 'Quantité reçue';
                }
                field("VAT %"; Rec."VAT %")
                {
                    ToolTip = '% TVA';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Code devise';
                }
                field("Amt. Rcd. Not Invoiced (LCY)"; Rec."Amt. Rcd. Not Invoiced (LCY)")
                {
                    ToolTip = 'Montant reçu non facturé (DS)';
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    ToolTip = 'Quantité facturée';
                }
            }
        }
    }

    actions
    {
    }
}

