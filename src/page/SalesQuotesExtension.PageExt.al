pageextension 50045 SalesQuotesExtension extends "Sales Quotes"
{
    layout
    {
        
        modify(Amount)
        {
            Caption = 'Montant dû';
        }
        modify("Sell-to Customer No.")
        {
            Visible = false;
        }
        modify("Sell-to Customer Name")
        {
            Visible = false;
        }
        modify("Sell-to Contact")
        {
            Visible = false;
        }
        modify("Posting Date")
        {
            Visible = false;
        }
        modify("Due Date")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Quote Valid Until Date")
        {
            Visible = false;
        }

        addafter("No.")
        {
            field("Devis Stock"; Rec."Devis Stock")
            {
                ApplicationArea = All;
                ToolTip = 'Devis stock';
            }

            field(Commentaire; Rec.Commentaire)
            {
                ApplicationArea = All;
                ToolTip = 'Commentaires';
            }
        }

        modify(Status)
        {
            Visible = true;
        }

        moveafter("No."; Status)

        moveafter(Commentaire; Amount)
        addbefore(Amount)
        {
            field("Nombre phases"; Rec."Nombre phases")
            {
                ApplicationArea = All;
                ToolTip = 'Nombre de phases';
            }
            field("Proba transformation"; Rec."Proba transformation")
            {
                ApplicationArea = All;
                ToolTip = 'Proba transformation';
            }
            
            field(PctAvancementBE; PctAvancementBE)
            {
                ApplicationArea = All;
                Caption = '% avancement BE';
                ToolTip = '% avancement BE';
                BlankZero = true;
            }
            
            
            field("Montant CA"; Rec."Montant CA")
            {
                ApplicationArea = All;
                ToolTip = 'Montant du devis';
            }
            field("Montant fact. acompte"; Rec."Montant fact. acompte")
            {
                ApplicationArea = All;
                ToolTip = 'Montant facture acompte';
            }
            field("Montant fact. situation"; Rec."Montant fact. situation")
            {
                ApplicationArea = All;
                ToolTip = 'Montant facture situation';
            }
        }

        addafter(amount)
        {
            field("Montant deja verse TTC"; Rec."Montant deja verse TTC")
            {
                ApplicationArea = All;
                ToolTip = 'Montant déjà versé TTC';
            }
        }
        modify("Salesperson Code")
        {
            Visible = true;
        }
        moveafter("Montant deja verse TTC"; "Salesperson Code", "External Document No.")
        addafter("External Document No.")
        {
            field("Date chargement"; Rec."Date chargement")
            {
                ApplicationArea = All;
                ToolTip = 'Date de chargement';
            }
        }
        moveafter("Date chargement"; "Requested Delivery Date")

        addafter("Requested Delivery Date")
        {
            field("Facturation en compta (O/N)"; Rec."Facturation en compta (O/N)")
            {
                ApplicationArea = All;
                ToolTip = 'Facturation en compta (O/N)';
            }
            field("Nb affectations achats"; Rec."Nb affectations achats")
            {
                ApplicationArea = All;
                ToolTip = 'Permet de savoir si des commandes d''achats ont déjà été engagées et de se demander si le devis n''aurait pas dû être transformé en commande.';
            }
            field("Code chantier"; Rec."Code chantier")
            {
                ApplicationArea = All;
                ToolTip = 'Code chantier';
            }

            field("Code enseigne"; Rec."Code enseigne")
            {
                ApplicationArea = All;
                ToolTip = 'Code enseigne';
            }
            field("Total Net Weight"; Rec."Total Net Weight")
            {
                ApplicationArea = All;
                ToolTip = 'Poids net total';
                Visible = false;
            }
            field("Poids brut total"; Rec."Poids brut total")
            {
                ApplicationArea = All;
                ToolTip = 'Poids brut total';
                Visible = false;
            }
            field("Nombre de palettes"; Rec."Nombre de palettes")
            {
                ApplicationArea = All;
                ToolTip = 'Nombre de palettes';
                Visible = false;
            }
            field("Nombre de colis"; Rec."Nombre de colis")
            {
                ApplicationArea = All;
                ToolTip = 'Nombre de colis';
                Visible = false;
            }
            field("Shipment Method Code"; Rec."Shipment Method Code")
            {
                ApplicationArea = All;
                ToolTip = 'Conditions de livraison';
            }
            field("Annee commande"; Rec."Annee commande")
            {
                ApplicationArea = All;
                ToolTip = 'Année commande';
            }
        }
    }

    actions
    {
        modify(MakeOrder)
        {
            Visible = false;
        }
        modify(Reopen)
        {
            Enabled = (Rec.Status = Rec.Status::Released);
            ShortcutKey = 'Ctrl+Q';
        }
        modify("Request Approval")
        {
            Visible = false;
        }
        modify(Dimensions)
        {
            Visible = false;
        }
        modify(Approvals)
        {
            Visible = false;
        }
        modify(CreateTask)
        {
            Visible = false;
        }
        modify("&Quote")
        {
            Visible = false;
        }
        modify(MakeInvoice)
        {
            Visible = false;
        }

        addafter(DeleteOverdueQuotes)
        {
            action(CreerCommandeVente)
            {
                ApplicationArea = All;
                Caption = 'Créer cmde vente';
                ToolTip = 'Créer cmde vente';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    CODEUNIT.Run(CODEUNIT::"Sales-Quote to Order (Yes/No)", Rec);
                end;
            }
            action(MAJPhases)
            {
                ApplicationArea = All;
                Caption = 'MAJ phases';
                ToolTip = 'Mettre à jour les dates sur les phases des devis';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = Page "MAJ phases devis vente";
            }

        }
        

    }
    var
        PctAvancementBE: Decimal;

    trigger OnAfterGetRecord()
    var
        DossierBE: Record "Dossier BE";
    begin
        PctAvancementBE := 0;
        if Rec."No. dossier BE" <> '' then
            if DossierBE.get(Rec."No. dossier BE") then
                PctAvancementBE := DossierBE.CalcAvancement();
            
    end;
}
