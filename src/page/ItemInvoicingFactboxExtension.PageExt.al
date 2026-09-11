pageextension 50129 ItemInvoicingFactboxExtension extends "Item Invoicing FactBox"
{
    layout
    {
        modify("Cost is Adjusted")
        {
            Visible = false;
        }
        modify("Cost is Posted to G/L")
        {
            Visible = false;
        }        
        modify("Standard Cost")
        {
            Visible = false;
        }
        modify("Unit Cost")
        {
            Visible = false;
        }
        modify("Last Direct Cost")
        {
            Visible = false;
        }
        modify("Overhead Rate")
        {
            Visible = false;
        }
        modify("Indirect Cost %")
        {
            Visible = false;
        }
        modify("Profit %")
        {
            Visible = false;
        }
        modify("Costing Method")
        {
            Visible = false;
        }
        modify("Unit Price")
        {
            Visible = false;
        }
        addlast(content)
        {
            field(Stock; Rec.Stock)
            {
                ApplicationArea = All;
            }

            field("Inventory trash"; Rec."Inventory trash")
            {
                ApplicationArea = All;
                Caption = 'Stock rebut';
            }
            field("Qty. on Purch. Order";Rec."Qty. on Purch. Order")
            {
                ApplicationArea = All;
            }
            field("Qty. on Sales Order";Rec."Qty. on Sales Order")
            {
                ApplicationArea = All;
            }

            
            field(PMP;Rec.PMP)
            {
                ApplicationArea = all;
            }
        }
    }
}
