page 50134 "SF TBL containers attendus"
{
    ApplicationArea = All;
    Caption = 'Containers attendus';
    PageType = ListPart;
    SourceTable = Container;
    SourceTableView = sorting("Date semaine reception prevue", "Statut container") where("Statut container" = const("En cours"));
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'N°';
                }
                field("Statut container"; Rec."Statut container")
                {
                    ApplicationArea = All;
                    ToolTip = 'Statut container';
                }
                field("Nom transporteur"; Rec."Nom transporteur")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nom transporteur';
                }
                field("Nom fournisseur"; Rec."Nom fournisseur")
                {
                    ToolTip = 'Nom fournisseur';
                }
                field("No. Immat / Container"; Rec."No. Immat / Container")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Immat';
                }
                field("Date reception prevue"; Rec."Date reception prevue")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date réception prévue';
                }
                field("Volume charge"; Rec."Volume charge")
                {
                    ToolTip = 'Volume chargé';
                }
                field("Montant facture (papier)"; Rec."Montant facture (papier)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Montant facture (papier)';
                }
                field(Commentaire; Rec.Commentaire)
                {
                    ToolTip = 'Commentaire';
                }

                field("Nb commandes"; Rec."Nb commandes")
                {
                    ApplicationArea = All;
                    Caption = 'Nb commandes';
                    ToolTip = 'Bombre de commandes dans le container';
                }
                

                field("No. packing list / BL"; Rec."No. packing list / BL")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. packing list / BL';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(OuvrirContainer)
            {
                Caption = 'Ouvrir container';
                ToolTip = 'Ouvre la fiche du container';
                ApplicationArea = All;
                RunObject = page "Fiche container";
                RunPageLink = "No." = field("No.");

            }
            action(CommandesAchats)
            {
                Caption = 'Cdes achats';
                ToolTip = 'Liste des commandes contenues dans le container';
                ApplicationArea = All;
                trigger OnAction()
                var 
                    StatContainer: Record "Statistique container";
                begin
                    Rec.CalculerStatsContainer();
                    Commit();
                    StatContainer.SetRange("No. container",Rec."No.");
                    Page.Run(Page::"Commandes achats container",StatContainer);
                end;
            }
            action(PalettesColis)
            {
                Caption = 'Palettes/Colis';
                ToolTip = 'Liste des palettes et colis associés au container';
                ApplicationArea = All;
                RunObject = page "Fiche colisage container";
                RunPageLink = "No." = field("No.");
            }
            action(EtiquettesPalettes)
            {
                Caption = 'Etiquettes palettes';
                ToolTip = 'Liste pour impression d''étiquettes selon chantiers';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Rec.ListerChantiersPourEtiquettesPalettes();
                end;
            }
            
            action(ReceptionsEnregistrees)
            {
                Caption = 'Afficher réceptions';
                ToolTip = 'Affiche la liste des réceptions liées à ce container';
                ApplicationArea = All;
                RunObject = page "Posted Purchase Receipts";
                RunPageLink = "No. container" = field("No.");
            }
            action("Expéditions retours enregistrées")
            {
                Caption = 'Expéditions retours enregistrées';
                ToolTip = 'Expéditions retours enregistrées';
                Image = ReturnShipment;
                RunObject = Page "Posted Return Shipments";
                RunPageLink = "No. container" = field("No.");
                RunPageView = sorting("No. container");
            }
        }
    }
}
