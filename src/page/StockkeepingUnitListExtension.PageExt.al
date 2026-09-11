pageextension 50124 "StockkeepingUnitListExtension" extends "Stockkeeping Unit List"
{
    layout
    {
        addafter(Inventory)
        {
            field("Unit Cost";Rec."Unit Cost")
            {
                ApplicationArea = All;
                ToolTip = 'Coût unitaire';
            }
            field("Réf. client";Rec."Réf. client")
            {
                ApplicationArea = All;
                ToolTip = 'Réf. client';
            }

        }
    }
}
