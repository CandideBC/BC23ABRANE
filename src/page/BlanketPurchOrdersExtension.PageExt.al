pageextension 50144 BlanketPurchOrdersExtension extends "Blanket Purchase Orders"
{
    layout
    {
        
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Buy-from Vendor No.")
        {
            Visible = false;
        }
        modify("Vendor Authorization No.")
        {
            Visible = false;
        }
        moveafter("No."; Status)

        addafter("Buy-from Vendor Name")
        {
            field(Commentaires; Rec.Commentaires)
            {
                ApplicationArea = All;
                ToolTip = 'Commentaires';
            }
        }
        addafter("Location Code")
        {
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
                ToolTip = 'Montant H.T.';
            }

            field("Date validite"; Rec."Date validite")
            {
                ApplicationArea = All;
                ToolTip = 'Date validité';
            }

        }
        moveafter("Date validite"; "Purchaser Code")

        modify("Purchaser Code")
        {
            Visible = true;
        }
        addafter("Purchaser Code")
        {
            field("Code enseigne"; Rec."Code enseigne")
            {
                ApplicationArea = All;
                ToolTip = 'Enseigne';
            }
        }
    }
}
