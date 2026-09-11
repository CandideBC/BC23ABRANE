pageextension 50071 PhysInventoryJournalExtension extends "Phys. Inventory Journal"
{

    layout
    {

        
        addafter("Reason Code")
        {

            field("Qté sur commande achat"; Rec."Qté sur commande achat")
            {
                ApplicationArea = All;
                ToolTip = 'Qté sur commande achat';
                Caption = 'Qté sur commande achat';
                BlankZero = true;
                DecimalPlaces = 0:5;
            }
            field("Qté sur commande vente"; Rec."Qté sur commande vente")
            {
                ApplicationArea = All;
                ToolTip = 'Qté sur commande vente';
                Caption = 'Qté sur commande vente';
                BlankZero = true;
                DecimalPlaces = 0:5;
            }
            
            field("Cust. Ref"; Rec."Cust Ref.")
            {
                ToolTip = 'Réf. Client';
            }

        }

        
    }
       
}

