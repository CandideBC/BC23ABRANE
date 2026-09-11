page 50136 "Commandes ventes Export"
{
    ApplicationArea = All;
    Caption = 'Commandes ventes Export';
    PageType = List;
    SourceTable = "Sales Header";
    SourceTableView = sorting("Commande export") where ("Commande export" = const(true),"Document Type"=const(Order));
    UsageCategory = Lists;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'N° commande';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies whether the document is open, waiting to be approved, has been invoiced for prepayment, or has been released to the next stage of processing.';
                }
                field(Commentaire; Rec.Commentaire)
                {
                    ToolTip = 'Commentaire';
                }
                field("Completely Shipped"; Rec."Completely Shipped")
                {
                    ToolTip = 'Complètement expédiée';
                }
                field("Date chargement"; Rec."Date chargement")
                {
                    ToolTip = 'Date de chargement';
                }
                field("Code enseigne"; Rec."Code enseigne")
                {
                    ToolTip = 'Code enseigne';
                }
                field("Code chantier"; Rec."Code chantier")
                {
                    ToolTip = 'Code chantier';
                }
            }
        }
    }
}
