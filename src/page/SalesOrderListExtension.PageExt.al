pageextension 50049 SalesOrderListExtension extends "Sales Order List"
{
    layout
    {
        moveafter("No."; Status)

        modify("Sell-to Customer No.")
        {
            Visible = false;
        }
        modify("Sell-to Customer Name")
        {
            Visible = false;
        }

        modify("Location Code")
        {
            Visible = false;
        }
        modify("Document Date")
        {
            Visible = false;
        }
        addafter("Bill-to Contact")
        {
            field("Commentaire"; Rec.Commentaire)
            {
                ApplicationArea = All;
                ToolTip = 'Commentaires';
            }
            field("Nombre phases"; Rec."Nombre phases")
            {
                ApplicationArea = All;
                ToolTip = 'Nombre de phases';
            }
            field(PctAvancementBE; PctAvancementBE)
            {
                ApplicationArea = All;
                Caption = '% avancement BE';
                ToolTip = '% avancement BE';
                BlankZero = true;
            }
            
        }
        moveafter(PctAvancementBE; "Completely Shipped", Amount)
        modify(Amount)
        {
            Caption = 'Montant dû';
        }
        addbefore("Amount")
        {
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
        }
        addafter(Amount)
        {
            field("Montant deja verse TTC"; Rec."Montant deja verse TTC")
            {
                ApplicationArea = All;
            }

        }
        modify("Requested Delivery Date")
        {
            Visible = true;
        }
        modify("Salesperson Code")
        {
            Visible = true;
        }
        addbefore("Requested Delivery Date")
        {
            field("Date chargement"; Rec."Date chargement")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Montant deja verse TTC"; "Salesperson Code", "External Document No.")
        addafter("Requested Delivery Date")
        {
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
                ApplicationArea = All;
                ToolTip = 'Code chantier';
            }
            field("Code enseigne"; Rec."Code enseigne")
            {
                ApplicationArea = All;
                ToolTip = 'Code enseigne';
            }
            field("Annee commande"; Rec."Annee commande")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Code enseigne"; "Shipment Method Code")

        modify("Assigned User ID")
        {
            Visible = false;
        }

        modify("Amt. Ship. Not Inv. (LCY)")
        {
            Visible = false;
        }
        modify("Amount Including VAT")
        {
            Visible = false;
        }
        modify("Amt. Ship. Not Inv. (LCY) Base")
        {
            Visible = false;
        }
    }
    actions
    {
        modify("Post &Batch")
        {
            Visible = false;
        }
        modify(Reopen)
        {
            Enabled = (Rec.Status = Rec.Status::Released);
            ShortcutKey = 'Ctrl+Q';
        }
        modify(Warehouse)
        {
            Visible = false;
        }
        modify(Approvals)
        {
            Visible = false;
        }
        modify(Dimensions)
        {
            Visible = false;
        }
        modify("Create &Warehouse Shipment")
        {
            Visible = false;
        }
        modify("Create Inventor&y Put-away/Pick")
        {
            Visible = false;
        }
        modify("Pick Instruction")
        {
            Visible = false;
        }
        modify("Request Approval")
        {
            Visible = false;
        }
        modify("Pla&nning")
        {
            Visible = false;
        }
        modify("Send IC Sales Order Cnfmn.")
        {
            Visible = false;
        }
        modify("Order &Promising")
        {
            Visible = false;
        }
        modify("Work Order")
        {
            Visible = false;
        }
        modify(Documents)
        {
            Visible = false;
        }
        modify("Sales Reservation Avail.")
        {
            Visible = false;
        }
        modify("P&osting")
        {
            Visible = false;
        }


        addafter("Delete Invoiced")
        {
            action(MAJPhases)
            {
                ApplicationArea = All;
                Caption = 'MAJ phases';
                ToolTip = 'Mettre à jour les dates sur les phases des commandes';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category7;
                RunObject = Page "MAJ phases commandes vente";
            }
            action(CreerCdeText)
            {
                ApplicationArea = All;
                Caption = 'Créer cde test';
                ToolTip = 'Crée une commande de test sur la base de KANOPI, ne pas utiliser';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category7;
                trigger OnAction()
                var
                    EnteteVente: Record "Sales Header";
                    LigneVente: Record "Sales Line";
                begin
                    EnteteVente.Init();
                    EnteteVente."Document Type" := EnteteVente."Document Type"::Order;
                    EnteteVente.Insert(true);
                    EnteteVente.Validate("Sell-to Customer No.", 'C1922');
                    EnteteVente.Validate("Code chantier", 'QUI-0027');
                    EnteteVente.Validate("Requested Delivery Date", 20260331D);
                    EnteteVente.Validate("Salesperson Code", 'JORDAN J.');
                    EnteteVente.Validate("Posting Date", 20260123D);
                    EnteteVente.Modify();
                    LigneVente.Init();
                    LigneVente."Document Type" := LigneVente."Document Type"::Order;
                    LigneVente."Document No." := EnteteVente."No.";
                    LigneVente."Line No." := 10000;
                    LigneVente.insert();
                    LigneVente.Validate(Type, LigneVente.Type::Item);
                    LigneVente.Validate("No.", '102 LEGA.041643');
                    LigneVente.Validate(Quantity, 5000);
                    LigneVente.Validate("Unit Price", 2);
                    LigneVente.Phase := 0;
                    LigneVente.Modify();
                    LigneVente.Init();
                    LigneVente."Document Type" := LigneVente."Document Type"::Order;
                    LigneVente."Document No." := EnteteVente."No.";
                    LigneVente."Line No." := 20000;
                    LigneVente.insert();
                    LigneVente.Validate(Type, LigneVente.Type::Item);
                    LigneVente.Validate("No.", '102 LEGA.101222');
                    LigneVente.Validate(Quantity, 8000);
                    LigneVente.Validate("Unit Price", 3);
                    LigneVente.Phase := 0;
                    LigneVente.Modify();
                    EnteteVente.SetRecFilter();
                    Page.Run(Page::"Sales Order", EnteteVente);
                end;

            }

        }
        addafter(Post)
        {
            group(Imprimer)
            {
                Caption = 'Imprimer';
                action("Facture Proforma")
                {
                    ApplicationArea = All;
                    Image = Print;
                    ToolTip = 'Facture Proforma';
                    PromotedCategory = Category8;
                    Promoted = true;
                    trigger OnAction()
                    var
                        RecSalesHeader: Record "Sales Header";
                    begin
                        CurrPage.SETSELECTIONFILTER(RecSalesHeader);
                        REPORT.RUN(50008, true, false, RecSalesHeader);
                    end;
                }

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
