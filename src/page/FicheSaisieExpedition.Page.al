page 50123 "Fiche saisie expedition"
{
    ApplicationArea = All;
    Caption = 'Fiche saisie expédition';
    PageType = Card;
    SourceTable = "Sales Header";
    SourceTableView = where("Document Type" = const(Order));
    DeleteAllowed = false;

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
                /*
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'N° du client qui a commandé.';
                    Editable = false;

                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ToolTip = 'Nom du destinataire 2';
                    Editable = false;
                }
                */

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
                    DetailUCCommande: Record "Detail UC Commande";
                    CU80: codeunit "Sales-Post";
                    ListeUCCommande: Page "UC Commande a expedier";
                    //PagePhases: Page "Phases document vente";
                    PrecisionArrondi: Decimal;
                    //NbPhasesDocument: Integer;
                    NumLigne: integer;
                    DetailPalettesFourni: Boolean;
                //PhaseNonChoisieErr: Label 'Vous devez choisir une phase.';
                //ExpedierQst: Label 'Souhaitez-vous expédier cette commande ?';
                //OperationAnnuleeErr: Label 'Opération interrompue';

                begin
                    Rec.CalcSubTotal(Rec);

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

                        //ListeUCCommande.DefinirConditionsAppel(true);
                        ListeUCCommande.SetTableView(UCCommande);
                        ListeUCCommande.LookupMode(true);
                        if ListeUCCommande.RunModal() = Action::LookupOK then begin
                            Commit();
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

                            Rec.ViderQteAExpedierAutresPhases(-999); //Pour vider les quantités de toutes les phases

                            UCCommande.SetRange("A expedier", true);
                            if UCCommande.FindSet(false) then begin

                                DetailUCCommande.SetCurrentKey("No. commande", "No. UC");
                                DetailUCCommande.SetRange("No. commande", Rec."No.");

                                repeat
                                    //On copie les UC vers le colisage expédié
                                    UCColisageExpedie.Init();
                                    UCColisageExpedie."No. colisage" := EnteteColisageExpedie."No.";
                                    UCColisageExpedie."No. UC" := UCCommande."No. UC";
                                    UCColisageExpedie."Type UC" := UCCommande."Type UC";
                                    UCColisageExpedie."Numero camion" := UCCommande."Numero camion";
                                    UCColisageExpedie.Numerotation := UCCommande.Numerotation;
                                    UCColisageExpedie."Type UC" := UCCommande."Type UC";
                                    UCColisageExpedie."Poids brut UC" := UCCommande."Poids brut";
                                    UCColisageExpedie.Insert();

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


                    //Quel que soit le cas (détail de palettes/colis a été saisi ou non), on copie les UC 
                    // (L'utilisateur peut s'être contenté de dire 3 palette et 2 colis sans les détailler)
                    repeat
                        if not UCColisageExpedie.Get(EnteteColisage."No.", LignePrepa."No. UC") then begin
                        end;
                        if DetailPalettesFourni then begin
                            //Pour chaque ligne de prepa (chaque palette associée à une ligne de commande), on detaille le detail du colisage
                            ContenuColisage.Init();
                            ContenuColisage."No. colisage" := EnteteColisage."No.";
                            ContenuColisage."No. ligne" := NumLigne;
                            NumLigne := NumLigne + 1;
                            ContenuColisage."Item No." := LignePrepa."No. article";
                            ContenuColisage.Description := LignePrepa.Designation;
                            ContenuColisage."No. UC" := LignePrepa."No. UC";
                            LigneCommande.Get(LigneCommande."Document Type"::order, LignePrepa."No. commande", LignePrepa."No. ligne commande");
                            ContenuColisage."Poids net unitaire" := LigneCommande."Net Weight";
                            ContenuColisage.Validate("Quantite UC", LignePrepa."Quantite dans UC");
                            ContenuColisage."Order No." := LignePrepa."No. commande";
                            ContenuColisage."Order Line No." := LignePrepa."No. ligne commande";
                            ContenuColisage.Insert();
                        until LignePrepa.Next() = 0
                            else begin //On va se contenter de rattacher les articles au colisage sans lien avec des palettes 
                                LigneCommande.SetCurrentKey(TypeDocDuplique, NumDocDuplique, Phase);
                                LigneCommande.SetRange(TypeDocDuplique, Rec."Document Type");
                                LigneCommande.SetRange(NumDocDuplique, Rec."No.");
                                LigneCommande.SetRange(Phase, PhasesDocVente.Phase);
                                LigneCommande.SetRange(Type, LigneCommande.Type::Item);
                                if LigneCommande.FindSet(false) then
                                    repeat
                                        if LigneCommande."Qty. to Ship" <> 0 then begin
                                            ContenuColisage.Init();
                                            ContenuColisage."No. colisage" := EnteteColisage."No.";
                                            ContenuColisage."No. ligne" := LigneCommande."Line No.";
                                            ContenuColisage.Type := ContenuColisage.Type::Item;
                                            ContenuColisage."Item No." := LigneCommande."No.";
                                            ContenuColisage."Quantite UC" := LigneCommande."Qty. to Ship (Base)";
                                            ContenuColisage.Description := LigneCommande.Description;
                                            ContenuColisage."Order No." := Rec."No.";
                                            ContenuColisage."Order Line No." := LigneCommande."Line No.";
                                            if LigneCommande."Composant de la ligne No." <> 0 then begin
                                                ContenuColisage."Type produit" := ContenuColisage."Type produit"::Composant;
                                                ContenuColisage."No. ligne regroupement" := LigneCommande."Composant de la ligne No.";
                                            end else begin
                                                ContenuColisage."Type produit" := ContenuColisage."Type produit"::"Produit fini";
                                                ContenuColisage."No. ligne regroupement" := ContenuColisage."No. ligne";
                                            end;
                                            ContenuColisage."Poids net unitaire" := LigneCommande."Net Weight";
                                            PrecisionArrondi := 0;
                                            if ContenuColisage."Poids net unitaire" < 1 then
                                                PrecisionArrondi := 0.001
                                            else
                                                PrecisionArrondi := 0.01;
                                            ContenuColisage."Poids net ligne" := ROUND(ContenuColisage."Quantite UC" * ContenuColisage."Poids net unitaire", PrecisionArrondi);
                                            ContenuColisage.Insert();
                                        end;
                                    until LigneCommande.Next() = 0;

                            end;

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
