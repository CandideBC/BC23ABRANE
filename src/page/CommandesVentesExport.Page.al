page 50136 "Commandes ventes Export"
{
    ApplicationArea = All;
    Caption = 'Commandes ventes Export';
    PageType = List;
    SourceTable = "Sales Header";
    SourceTableView = sorting("Commande export") where("Commande export" = const(true), "Document Type" = const(Order));

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
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies whether the document is open, waiting to be approved, has been invoiced for prepayment, or has been released to the next stage of processing.';
                    Editable = false;
                }
                field("Quote No."; Rec."Quote No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'N° devis';
                }

                field(Commentaire; Rec.Commentaire)
                {
                    ToolTip = 'Commentaire';
                    Editable = false;
                }
                field("Nombre phases"; Rec."Nombre phases")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre de phases';
                }

                field("Completely Shipped"; Rec."Completely Shipped")
                {
                    ToolTip = 'Complètement expédiée';
                }
                field("Montant CA"; Rec."Montant CA")
                {
                    ApplicationArea = All;
                }
                field("Montant fact. acompte"; Rec."Montant fact. acompte")
                {
                    ApplicationArea = All;
                }
                field("Montant fact. situation"; Rec."Montant fact. situation")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Caption = 'Montant dû';
                }
                field("Montant deja verse"; Rec."Montant deja verse TTC")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                }
                field("Date chargement"; Rec."Date chargement")
                {
                    ToolTip = 'Date de chargement';
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("Facturation en compta (O/N)"; Rec."Facturation en compta (O/N)")
                {
                    ApplicationArea = All;
                }
                field("Nb affectations achats"; Rec."Nb affectations achats")
                {
                    ApplicationArea = All;
                }




                field("Code chantier"; Rec."Code chantier")
                {
                    ToolTip = 'Code chantier';
                    Editable = false;
                }
                field("Code enseigne"; Rec."Code enseigne")
                {
                    ToolTip = 'Code enseigne';
                    Editable = false;
                }
                field("Annee commande"; Rec."Annee commande")
                {
                    ApplicationArea = All;
                    ToolTip = 'Année commande';
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Conditions de livraisons';
                }


            }
        }
    }
}
