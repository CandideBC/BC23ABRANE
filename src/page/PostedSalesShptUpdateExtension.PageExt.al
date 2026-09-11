pageextension 50133 PostedSalesShptUpdateExtension extends "Posted Sales Shipment - Update"
{
    layout
    {
        addafter("Package Tracking No.")
        {
            field("Annee commande"; Rec."Annee commande")
            {
                ToolTip = 'Année commande';
                Caption = 'Année commande';
                ApplicationArea = All;
            }
            
        }
        addlast(content)
        {
            part(Lignes;"SF Editer BL")
            {
                Caption = 'Lignes';
                SubPageLink = "Document No."=field("No.");
            }
        }
    }
}
