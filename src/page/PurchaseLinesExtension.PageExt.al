pageextension 50014 "PurchaseLinesExtension" extends "Purchase Lines"
{
    layout
    {
        addafter("Line Amount")
        {
            field("Code enseigne"; Rec."Code enseigne")
            {
                ApplicationArea = All;
                ToolTip = 'Code enseigne';
            }
            field("Code groupe"; Rec."Code groupe")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Code groupe';
            }
            field("Code operation"; Rec."Code operation")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Code opération';
            }
            field("Code chantier"; Rec."Code chantier")
            {
                ApplicationArea = All;
                ToolTip = 'Code chantier';
            }
        }
        moveafter(Quantity;"Outstanding Quantity")
        
        addafter("Outstanding Quantity")
        {
            field("Date chargement confirmee"; Rec."Date chargement confirmee")
            {
                ApplicationArea = All;
                ToolTip = 'Date chargement confirmée';
            }
            field("Annee commande"; Rec."Annee commande")
            {
                ApplicationArea = All;
                ToolTip = 'Année commande';
            }
            
        }
        moveafter("Code chantier";"Direct Unit Cost")
        moveafter("Direct Unit Cost";"Line Amount")
        moveafter("Outstanding Quantity";"Unit of Measure Code")
        
        modify(Type)
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Reserved Qty. (Base)")
        {
            Visible = false;
        }

        modify("Expected Receipt Date")
        {
            Visible = false;
        }


    }
}
