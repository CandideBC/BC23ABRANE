page 50090 "Liste containers"
{
    Caption = 'Container List';
    CardPageID = "Fiche container";
    Editable = false;
    PageType = List;
    SourceTable = Container;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    Caption = 'N°';
                    ToolTip = 'N°';
                }
                field("Statut container"; Rec."Statut container")
                {
                    Caption = 'Statut container';
                    ToolTip = 'Statut container';
                }
                field("Nom fournisseur"; Rec."Nom fournisseur")
                {
                    Caption = 'Nom fournisseur';
                    ToolTip = 'Nom fournisseur';
                }
                field("Date chargement fournisseur"; Rec."Date chargement fournisseur")
                {
                    Caption = 'Date chargement fournisseur';
                    ToolTip = 'Date chargement fournisseur';
                }
                field("Nom transporteur"; Rec."Nom transporteur")
                {
                    Caption = 'Nom transporteur';
                    ToolTip = 'Nom transporteur';
                }
                field("Date depart port"; Rec."Date depart port")
                {
                    Caption = 'Date départ port';
                    ToolTip = 'Date départ port';
                }
                field("Date reception prevue"; Rec."Date reception prevue")
                {
                    Caption = 'Date réception prévue';
                    ToolTip = 'Date réception prévue';
                }
                field("Semaine reception prevue"; Rec."Semaine reception prevue")
                {
                    Caption = 'Semaine réception prévue';
                    ToolTip = 'Semaine réception prévue';
                }
                field("No. Immat / Container"; Rec."No. Immat / Container")
                {
                    Caption = 'N° Immat / Container';
                    ToolTip = 'N° Immat / Container';
                }
                field("Volume charge"; Rec."Volume charge")
                {
                    Caption = 'Volume chargé';
                    ToolTip = 'Volume chargé';
                }
                field(Commentaire; Rec.Commentaire)
                {
                    Caption = 'Commentaire';
                    ToolTip = 'Commentaire';
                }

                field("Description mode transport"; Rec."Description mode transport")
                {
                    Caption = 'Description mode transport';
                    ToolTip = 'Description mode transport';
                }
                field("No. packing list / BL"; Rec."No. packing list / BL")
                {
                    Caption = 'N° packing list / BL';
                    ToolTip = 'N° packing list / BL';
                }
                field("No. commande transitaire"; Rec."No. commande transitaire")
                {
                    Caption = 'N° cde transitaire';
                    ToolTip = 'N° cde transitaire';
                    trigger OnDrillDown()
                    begin
                        Rec.AfficherCommandeTransitaire();
                    end;
                }
                field("No. cde transitaire (facturee)"; Rec."No. cde transitaire (facturee)")
                {
                    Caption = 'N° cde transitaire (facturée)';
                    ToolTip = 'N° cde transitaire (facturée)';
                    trigger OnDrillDown()
                    begin
                        Rec.AfficherFactureTransitaire();
                    end;
                }
                field("Frais transport ventiles"; Rec."Frais transport ventiles")
                {
                    Caption = 'Frais transport ventilés';
                    ToolTip = 'Frais transport ventilés';
                }
                field("Montant facture (papier)"; Rec."Montant facture (papier)")
                {
                    ApplicationArea = All;
                }
                field(PctTransport; PctTransport)
                {

                    AutoFormatExpression = '<precision, 0:1><standard format,0>%';
                    AutoFormatType = 10;
                    BlankZero = true;
                    Caption = 'Taux approche';

                    ToolTip = 'Taux approche';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(Statistiques)
            {
                Caption = 'Statistiques';
                Image = Statistics;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Statistiques';

                trigger OnAction()
                begin
                    Rec.AfficherStatsContainer();
                end;
            }
            action("Réceptions enregistrées")
            {
                Caption = 'Réceptions enregistrées';
                ToolTip = 'Réceptions enregistrées';
                Image = ExportReceipt;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Posted Purchase Receipts";
                RunPageLink = "No. container" = field("No.");
                RunPageView = sorting("No. container");
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //KAN.FHA 09/11/2026 DEBUT
        Rec.CalcFields("Montant facture (papier)");
        //KAN.FHA 09/11/2026 FIN
        //KAN.FHA 09/11/2026 DEBUT
        //decMontantCharge := Rec.CalculerMontantChargeDS();
        //Remplace par :
        decMontantCharge := Rec."Montant facture (papier)";
        //KAN.FHA 09/11/2026 FIN
        decMontantTransport := Rec.RecupMontantEncoursCdeTransitaire() + Rec.RecupMontantFactureTransitaire();
        if decMontantCharge <> 0 then
            PctTransport := Round(decMontantTransport / decMontantCharge, 0.01)
        else
            PctTransport := 0;
    end;

    var
        PctTransport: Decimal;
        decMontantCharge: Decimal;
        decMontantTransport: Decimal;
}

