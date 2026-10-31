page 50123 "Fiche saisie expedition"
{
    ApplicationArea = All;
    Caption = 'Fiche saisie expédition';
    PageType = Card;
    SourceTable = "Sales Header";
    SourceTableView = where("Document Type" = const(Order));
    DeleteAllowed = false;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'Général';

                field("No."; Rec."No.")
                {
                    ToolTip = 'N° commande';
                    Editable = false;
                }
                group(AdrLivraison)
                {
                    Caption = 'Adresse livraison';
                    field("Ship-to Name"; Rec."Ship-to Name")
                    {
                        ToolTip = 'Nom du destinataire';
                        Editable = false;

                    }
                    field("Ship-to Name 2"; Rec."Ship-to Name 2")
                    {
                        ToolTip = 'Nom du destinataire 2';
                        Editable = false;

                    }
                    field("Ship-to Address"; Rec."Ship-to Address")
                    {
                        ToolTip = 'Adresse du destinataire';
                        Editable = false;
                    }
                    field("Ship-to Address 2"; Rec."Ship-to Address 2")
                    {
                        ToolTip = 'Adresse 2 du destinataire';
                        Editable = false;
                    }

                    field("Ship-to Post Code"; Rec."Ship-to Post Code")
                    {
                        ToolTip = 'Code postal du destinataire';
                        Editable = false;
                    }
                    field("Ship-to City"; Rec."Ship-to City")
                    {
                        ToolTip = 'Ville du destinataire';
                        Editable = false;
                    }
                    field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Pays de livraison';
                        Editable = false;
                    }
                    field("Ship-to Contact"; Rec."Ship-to Contact")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Contact livraison';
                        Editable = false;
                    }
                }
                group(Donnees)
                {
                    Caption = 'Données';
                    field("Code groupe"; Rec."Code groupe")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Code groupe';
                        Editable = false;
                    }

                    field("Code enseigne"; Rec."Code enseigne")
                    {
                        ToolTip = 'Code enseigne';
                        Editable = false;
                    }
                    field("Code chantier"; Rec."Code chantier")
                    {
                        ToolTip = 'Code chantier';
                        Editable = false;
                    }
                    field("Location Code"; Rec."Location Code")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Code magasin';
                        Editable = false;
                    }
                    field("Salesperson Code"; Rec."Salesperson Code")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Code vendeur';
                        Editable = false;
                    }
                }
                group(Dates)
                {
                    field("Date chargement"; Rec."Date chargement")
                    {
                        ToolTip = 'Date de chargement';
                        Editable = false;
                    }
                    field("Requested Delivery Date"; Rec."Requested Delivery Date")
                    {
                        ToolTip = 'Date de livraison demandée';
                        Editable = false;
                    }
                }
                /*
                field(QteAExpedier; Rec.RecupQteAExpedier())
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Quantités à expédier';
                    ToolTip = 'Indique la somme des [Quantité à expédier] des lignes d''articles.';
                    DecimalPlaces = 0 : 5;
                }
                */


                group("Commentaires Prepa")
                {
                    Caption = 'Commentaires Prépa';

                    field(CommentairesPrepa; CommentairesPrepa)
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Standard;
                        MultiLine = true;
                        ShowCaption = false;
                        ToolTip = 'Indique les commentaires généraux concernant le dossier BE. Ce champ est synchronisé avec le dossier BE.';

                        trigger OnValidate()
                        begin
                            Rec.SetCommentairesPrepa(CommentairesPrepa);
                        end;

                    }
                    field("External Document No."; Rec."External Document No.")
                    {
                        ToolTip = 'N° doc. externe';
                        Editable = false;

                    }
                    field("Commentaire factu."; Rec."Commentaire factu.")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Commentaire factu.';
                        //Editable = false;
                    }
                    field("Facturation en compta (O/N)"; Rec."Facturation en compta (O/N)")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Indique si le dossier a été ramené à la compta.';
                        //Editable = false;
                    }
                    field("Posting Date"; Rec."Posting Date")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Date comptabilisation';
                    }
                    field(NombreColis; Rec."Nombre de colis")
                    {
                        ToolTip = 'Nombre de colis';
                    }
                    field(NombrePalettes; Rec."Nombre de palettes")
                    {
                        ToolTip = 'Nombre de palettes';
                    }

                    field("Total Net Weight"; Rec."Total Net Weight")
                    {
                        ToolTip = 'Poids net total';
                        Editable = false;
                    }
                    field("Poids brut total"; Rec."Poids brut total")
                    {
                        ToolTip = 'Poids brut total que vous allez expédier, ne saisissez cette information qu''après avoir saisi les [Quantité à expédier] de chaque ligne.';

                    }
                    /*
                    field("Colisages non valides"; Rec."Colisages non valides")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Indique combien de colisages sont en cours de préparation (non encore expédiés).';
                        Visible = false;
                    }
                    */

                    field("Nb UC en prepa"; Rec."Nb UC en prepa")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Indique combien de colis/palettes ont été associés à la préparation de cette commande.';
                        Visible = false;
                    }

                }
            }
            part(SFSaisieExpedition; "SF Saisie expedition")
            {
                SubPageLink = "Document No." = field("No.");
            }

        }
    }
    actions
    {
        area(Processing)
        {
            action(VoirCommande)
            {
                Caption = 'Commande';
                ToolTip = 'Permet d''afficher la commande.';
                Image = ViewOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Sales Order";
                RunPageLink = "Document Type" = field("Document Type"), "No." = field("No.");
            }
            action(AfficherColisage)
            {
                Caption = 'Palettes/Colis';
                ToolTip = 'Permet d''afficher ou définir les palettes et colis nécessaires à la préparation de cette commande.';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Fiche colisage commande";
                RunPageLink = "Document Type" = field("Document Type"), "No." = field("No.");
            }
            action(SuiviAchats)
            {
                ApplicationArea = All;
                Caption = 'Suivi achats';
                ToolTip = 'Affiche la liste des commandes achats passées pour cette commande.';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = OrderTracking;

                trigger OnAction()
                var
                begin
                    Rec.EtablirSuiviAchats();
                    Page.Run(Page::SuiviAchatsParDocVente);
                end;
            }
            action(RemplirQteAExpedier)
            {
                ApplicationArea = All;
                Caption = 'Remplir Qté. à expédier';
                ToolTip = 'Affiche la liste des phases où vous pourrez cocher quels phases doivent être livrées.';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = AutofillQtyToHandle;

                trigger OnAction()
                var
                begin
                    Rec.RemplirQteAExpedierPhasesCochees();
                end;
            }
            action(Expedier)
            {
                Caption = 'Expédier';
                ToolTip = 'Vous permet de générer le bon de livraison pour une des phases.';
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    //PhasesDocVente: Record "Phases document";
                    LigneCommande: Record "Sales Line";

                    EnteteColisageExpedie: Record "Entete colisage expedie";
                    UCColisageExpedie: Record "UC colisage expedie";
                    DetailColisageExpedie: Record "Detail UC colisage expedie";
                    UC: Record "Unite colisage";
                    UCCommande: Record "UC Commande";
                    UCCommandeMAJ: Record "UC Commande";
                    DetailUCCommande: Record "Detail UC Commande";
                    CU80: codeunit "Sales-Post";
                    ListeUCCommande: Page "UC Commande a expedier";
                    //PagePhases: Page "Phases document vente";
                    //PrecisionArrondi: Decimal;
                    //NbPhasesDocument: Integer;
                    NumLigne: integer;
                    DetailPalettesFourni: Boolean;
                //PhaseNonChoisieErr: Label 'Vous devez choisir une phase.';
                //ExpedierQst: Label 'Souhaitez-vous expédier cette commande ?';
                //OperationAnnuleeErr: Label 'Opération interrompue';

                begin
                    Rec.CalcSubTotal(Rec);
                    Commit();

                    //Deux cas peuvent se présenter :
                    // - on a detaillé le contenu de palettes ==>On va proposer quelles palettes l'utilisateur souhaite
                    //   expédier (le système va alors remplir les quantités à expédier par rapport aux palettes choisies
                    // - on n'a pas détaillé de contenu de palettes ==>On se trouve dans le cas de fonctionnement 'standard',
                    //   ce sont les quantités à expédier de chaque ligne qui doivent être remplies.
                    rec.CalcFields("Palettisation en cours");

                    DetailPalettesFourni := rec."Palettisation en cours";

                    if DetailPalettesFourni then begin
                        //On liste les palettes liées à la commande pour que l'utilisateur puisse choisir lesquelles il va expédier
                        Clear(ListeUCCommande);
                        UCCommande.SetCurrentKey("No. commande", "Statut UC");

                        UCCommande.SetRange("No. commande", Rec."No.");
                        UCCommande.SetRange("Statut UC", UCCommande."Statut UC"::" ", UCCommande."Statut UC"::"Reçue");

                        ListeUCCommande.SetTableView(UCCommande);
                        ListeUCCommande.LookupMode(true);
                        if ListeUCCommande.RunModal() = Action::LookupOK then begin
                            Commit();

                            Rec.ViderQteAExpedierAutresPhases(-999); //Pour vider les quantités de toutes les phases

                            UCCommande.SetRange("A expedier", true);
                            if UCCommande.FindSet(false) then begin
                                DetailUCCommande.SetCurrentKey("No. commande", "No. UC");
                                DetailUCCommande.SetRange("No. commande", Rec."No.");

                                repeat
                                    DetailUCCommande.Setrange("No. UC", UCCommande."No. UC");
                                    if DetailUCCommande.FindSet(false) then
                                        repeat
                                            LigneCommande.Get(LigneCommande."Document Type"::Order, UCCommande."No. commande", DetailUCCommande."No. ligne commande");
                                            LigneCommande.Validate("Qty. to Ship", LigneCommande."Qty. to Ship" + DetailUCCommande."Quantite dans UC");
                                            LigneCommande.Modify();
                                        until DetailUCCommande.Next() = 0;
                                until UCCommande.Next() = 0;
                            end;
                        end;
                    end;

                    //Quel que soit le cas (détail de palettes/colis a été saisi ou non), on crée un colisage expédié
                    EnteteColisageExpedie.Init();
                    EnteteColisageExpedie."No." := '';
                    EnteteColisageExpedie.Insert(true);
                    //NumColisage := EnteteColisage."No.";
                    EnteteColisageExpedie."Sell-to Customer No." := Rec."Sell-to Customer No.";
                    EnteteColisageExpedie.Validate("No. commande", Rec."No.");
                    EnteteColisageExpedie."Poids brut non colise" := Rec."Poids brut total";
                    EnteteColisageExpedie."Date comptabilisation" := Rec."Posting Date";
                    EnteteColisageExpedie.Modify();
                    NumLigne := 1;

                    //Si le détail de chaque palette n'a pas été donné et uniquement dans ce cas,
                    //on inscrit le N° du colisage expédié sur l'entete de la commande car c'est dans le CU80
                    //que le système va ensuite aller compléter les lignes du colisage (1 ligne de BL = 1 ligne de colisage dans ce cas).
                    //A l'inverse, si le contenu de chaque palette est connu, c'est ici (pas dans le CU80) qu'on rattacher
                    //le détai de chaque palette au colisage (plusieurs lignes possibles par ligne de BL).
                    if not DetailPalettesFourni then
                        Rec."Utiliser colisage No." := EnteteColisageExpedie."No.";

                    //Quel que soit le cas (détail de palettes/colis a été saisi ou non), on copie les UC 
                    // (L'utilisateur peut s'être contenté de dire 3 palettes et 2 colis sans les détailler)
                    UCCommande.Reset();
                    UCCommande.SetCurrentKey("No. commande", "Statut UC");
                    UCCommande.SetRange("No. commande", Rec."No.");
                    UCCommande.SetRange("Statut UC", UCCommande."Statut UC"::" ", UCCommande."Statut UC"::"Reçue");
                    if DetailPalettesFourni then
                        UCCommande.SetRange("A expedier",true);
                    if UCCommande.FindSet(true) then 
                        repeat
                            UCColisageExpedie.Init();
                            UCColisageExpedie."No. colisage" := EnteteColisageExpedie."No.";
                            UCColisageExpedie."No. UC" := UCCommande."No. UC";
                            UCColisageExpedie."Type UC" := UCCommande."Type UC";
                            UCColisageExpedie.Numerotation := UCCommande.Numerotation;
                            UCColisageExpedie."Numero camion" := UCCommande."Numero camion";
                            UCColisageExpedie."Poids brut UC" := UCCommande."Poids brut";
                            UCColisageExpedie.Insert();
                            if DetailPalettesFourni then begin
                                DetailUCCommande.Reset();
                                DetailUCCommande.SetCurrentKey("No. commande", "No. UC");
                                DetailUCCommande.SetRange("No. commande", UCCommande."No. commande");
                                DetailUCCommande.Setrange("No. UC", UCCommande."No. UC");
                                if DetailUCCommande.FindSet(false) then
                                    repeat
                                        DetailColisageExpedie.Init();
                                        DetailColisageExpedie."No. colisage" := EnteteColisageExpedie."No.";
                                        DetailColisageExpedie."No. ligne" := NumLigne;
                                        NumLigne := NumLigne + 1;
                                        DetailColisageExpedie."Item No." := DetailUCCommande."No. article";
                                        DetailColisageExpedie.Description := DetailUCCommande.Designation;
                                        DetailColisageExpedie."Description 2" := DetailUCCommande."Designation 2";
                                        DetailColisageExpedie."Quantite dans UC" := DetailUCCommande."Quantite dans UC";
                                        DetailColisageExpedie.Insert();
                                    until DetailUCCommande.Next() = 0;
                            end;
                            UCCommandeMAJ.Get(UCCommande."No. commande",UCCommande."No. UC");
                            UCCommandeMAJ."Statut UC" := UCCommande."Statut UC"::"Expédiée";
                            UCCommandeMAJ.Modify();
                            UC.Get(UCCommande."No. UC");
                            UC."Statut UC" := UC."Statut UC"::"Expédiée";
                            UC.Modify();
                        until UCCommande.Next() = 0;
                    
                    EnteteColisageExpedie.MAJPoidsSurContenuColisage();

                    //On valide le BL
                    Rec.Ship := true;
                    Rec.Invoice := false;
                    CU80.Run(Rec);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
    begin
        CommentairesPrepa := Rec.GetCommentairesPrepa();

    end;

    var
        CommentairesPrepa: Text;
}
