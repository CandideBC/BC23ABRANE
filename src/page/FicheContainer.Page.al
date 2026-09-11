page 50089 "Fiche container"
{
    ApplicationArea = All;
    UsageCategory = None;
    Caption = 'Fiche container';
    PageType = Card;
    SourceTable = Container;

    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Caption = 'N°';
                    ToolTip = 'N°';
                    Importance = Promoted;
                }
                field("No. Immat / Container"; Rec."No. Immat / Container")
                {
                    Caption = 'N° Immat / Container';
                    ToolTip = 'N° Immat / Container';
                }
                field("Code transporteur"; Rec."Code transporteur")
                {
                    Caption = 'Code transporteur';
                    ToolTip = 'Code transporteur';
                }
                field("Nom transporteur"; Rec."Nom transporteur")
                {
                    Caption = 'Nom transporteur';
                    ToolTip = 'Nom transporteur';
                }
                field("No. fournisseur"; Rec."No. fournisseur")
                {
                    Caption = 'N° fournisseur';
                    ToolTip = 'N° fournisseur';
                }
                field("Nom fournisseur"; Rec."Nom fournisseur")
                {
                    Caption = 'Nom fournisseur';
                    ToolTip = 'Nom fournisseur';
                }
                field("Mode de transport"; Rec."Mode de transport")
                {
                    Caption = 'Mode de transport';
                    ToolTip = 'Mode de transport';
                }
                field("Volume charge"; Rec."Volume charge")
                {
                    Caption = 'Volume chargé';
                    ToolTip = 'Volume chargé';
                }
                field("Date depart port"; Rec."Date depart port")
                {
                    Caption = 'Date départ port';
                    ToolTip = 'Date départ port';
                }
                field("Date chargement fournisseur"; Rec."Date chargement fournisseur")
                {
                    Caption = 'Date chargement fournisseur';
                    ToolTip = 'Date chargement fournisseur';
                }
                field(Commentaire; Rec.Commentaire)
                {
                    Caption = 'Commentaire';
                    ToolTip = 'Commentaire';
                }
                field("Lieu Incoterm"; Rec."Lieu Incoterm")
                {
                    Caption = 'Lieu Incoterm';
                    ToolTip = 'Lieu Incoterm';
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
                field("Code magasin destination"; Rec."Code magasin destination")
                {
                    Caption = 'Code magasin destination';
                    ToolTip = 'Code magasin destination';
                }
                field("No. packing list / BL"; Rec."No. packing list / BL")
                {
                    Caption = 'N° packing list / BL';
                    ToolTip = 'N° packing list / BL';
                }
                field("Nombre de palettes"; Rec."Nombre de palettes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre de palettes dans le container';
                }
                field("Nombre de colis"; Rec."Nombre de colis")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre de colis dans le container';
                }
                
                
                field("Date comptabilisation"; Rec."Date comptabilisation")
                {
                    Caption = 'Date comptabilisation';
                    ToolTip = 'Date comptabilisation';
                }
                field("No. commande transitaire"; Rec."No. commande transitaire")
                {
                    Caption = 'N° commande transitaire';
                    ToolTip = 'N° commande transitaire';
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
                field("Statut container"; Rec."Statut container")
                {
                    Caption = 'Statut container';
                    ToolTip = 'Statut container';
                }
            }
            part(Lignes; "SF Container")
            {
                Caption = 'Lignes';
                SubPageLink = "No. container" = field("No.");
            }
        }
        area(factboxes)
        {
            part("Attached Documents";"Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Documents joints';
                SubPageLink = "Table ID" = const(50040),"No."=field("No.");
            }
            systempart(ContainerLinks; Links)
            {
                Visible = true;
                ApplicationArea = RecordLinks;
            }
            systempart(ContainerNotes; Notes)
            {
                Visible = true;
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Mettre à jour suivi")
            {
                Caption = 'Mettre à jour suivi';
                ToolTip = 'Mettre à jour suivi';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "MAJ suivi container / achats";
            }
            action("Créer commande transitaire")
            {
                Caption = 'Créer commande transitaire';
                ToolTip = 'Créer commande transitaire';
                Image = NewWarehouseShipment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.CreerCommandeTransitaire();
                end;
            }
            action("Remplir qté à recevoir")
            {
                Caption = 'Remplir qté à recevoir';
                ToolTip = 'Remplir qté à recevoir';
                Image = AutofillQtyToHandle;

                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.RemplirOuViderQteARecevoir(0); //Remplir
                end;
            }
            action("Vider qté à recevoir")
            {
                Caption = 'Vider qté à recevoir';
                ToolTip = 'Vider qté à recevoir';
                Image = DeleteQtyToHandle;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.RemplirOuViderQteARecevoir(1); //Vider
                end;
            }
            action("Réceptionner")
            {
                Caption = 'Réceptionner';
                ToolTip = 'Réceptionner';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = true;

                trigger OnAction()
                begin
                    Rec.Receptionner();
                end;
            }
            action("Créer retour(s)")
            {
                Caption = 'Créer retour(s)';
                ToolTip = 'Créer retour(s)';
                Image = ReturnShipment;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    EnteteRetourCree: Record "Purchase Header";
                    NoRetour: Code[20];
                    OuvrirRetourQst: Label 'Le retour %1 a été créé, souhaitez-vous l''afficher ?', Comment = '%1 = N° retour';

                    RetoursCreesMsg: Label 'Les retours ont été créés.';
                begin
                    NoRetour := '';
                    if Rec.CreerRetourFournisseur(NoRetour) then
                        if NoRetour <> '' then //Un seul retour cree ==> on demande si on doit l'afficher
                            if Confirm(OuvrirRetourQst, true, NoRetour) then begin
                                EnteteRetourCree.Get(EnteteRetourCree."Document Type"::"Return Order", NoRetour);
                                PAGE.Run(PAGE::"Purchase Return Order", EnteteRetourCree);
                            end else
                                Message(RetoursCreesMsg)
                        else
                            Message(RetoursCreesMsg)

                end;
            }
        }
        area(navigation)
        {
            action(Statistiques)
            {
                Caption = 'Statistiques';
                ToolTip = 'Statistiques';
                Image = Statistics;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F7';

                trigger OnAction()
                begin
                    Rec.AfficherStatsContainer();
                end;
            }
            action(Colisage)
            {
                Caption = 'Colisage';
                ToolTip = 'Permet de consulter/saisir le détail du colisage (palettes/colis présents dans le container)';
                Image = ViewDetails;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Fiche colisage container";
                RunPageLink = "No." = field("No.");
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
            action("Expéditions retours enregistrées")
            {
                Caption = 'Expéditions retours enregistrées';
                ToolTip = 'Expéditions retours enregistrées';
                Image = ReturnShipment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Posted Return Shipments";
                RunPageLink = "No. container" = field("No.");
                RunPageView = sorting("No. container");
            }
        }
        area(reporting)
        {
            action("Etiquettes palettes")
            {
                Caption = 'Etiquettes palettes';
                ToolTip = 'Etiquettes palettes';
                Image = SuggestItemCost;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.ListerChantiersPourEtiquettesPalettes();
                end;
            }
        }
    }
}

