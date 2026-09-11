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
                    field("Colisages non valides"; Rec."Colisages non valides")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Indique combien de colisages sont en cours de préparation (non encore expédiés).';
                        Visible = false;
                    }

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
            part(SF_UC_Commande; "SF FichE Expe UC Commande")
            {
                SubPageLink = "No. commande" = field("No.");
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
            action(AfficherUC)
            {
                Caption = 'Palettes/Colis';
                ToolTip = 'Permet d''afficher ou définir les palettes et colis nécessaires à la préparation de cette commande.';
                //Image = ;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "UC Commande";
                RunPageLink = "No. commande" = field("No.");
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
                    PhasesDocVente: Record "Phases document";
                    LigneCommande: Record "Sales Line";
                    EnteteColisage: Record "Entete colisage";
                    ContenuColisage: Record "Contenu colisage";
                    DetailColisage: Record "Detail colisage";
                    LignePrepa: Record "Prepa colisage";
                    UC: Record "Unite colisage";
                    CU80: codeunit "Sales-Post";
                    PagePhases: Page "Phases document vente";
                    PrecisionArrondi: Decimal;
                    NbPhasesDocument: Integer;
                    NumLigne: integer;
                    PhaseNonChoisieErr: Label 'Vous devez choisir une phase.';
                    ExpedierQst: Label 'Souhaitez-vous expédier cette commande ?';
                    OperationAnnuleeErr: Label 'Opération interrompue';

                begin
                    Rec.CalcSubTotal(Rec);
                    NbPhasesDocument := Rec.CompterPhasesActives();
                    if NbPhasesDocument in [0, 1] then
                        if not Confirm(ExpedierQst, false) then
                            Error(OperationAnnuleeErr);
                    if NbPhasesDocument >= 1 then
                        if NbPhasesDocument = 1 then begin
                            PhasesDocVente.SetRange("Type document", PhasesDocVente."Type document"::Order);
                            PhasesDocVente.SetRange("No. document", Rec."No.");

                            PhasesDocVente.FindFirst();
                            Rec."Phase a expedier" := PhasesDocVente.Phase;
                            Rec."Libelle phase a expedier" := PhasesDocVente.Description;
                            Rec.Status := Rec.Status::Open;
                            Rec.Modify();
                            Commit();
                        end else begin //Plus d'une phase, on va demander quelle phase on souhaite expédier
                            Commit();
                            Clear(PagePhases);
                            PhasesDocVente.SetRange("Type document", PhasesDocVente."Type document"::Order);
                            PhasesDocVente.SetRange("No. document", Rec."No.");
                            PagePhases.DefinirConditionsAppel(true);
                            PagePhases.SetTableView(PhasesDocVente);
                            PagePhases.LookupMode(true);
                            if PagePhases.RunModal() = Action::LookupOK then begin
                                PagePhases.GetRecord(PhasesDocVente);
                                Rec."Phase a expedier" := PhasesDocVente.Phase;
                                Rec."Libelle phase a expedier" := PhasesDocVente.Description;
                                if PhasesDocVente."Date comptabilisation" <> 0D then
                                    Rec.Validate("Posting Date", PhasesDocVente."Date comptabilisation");
                                Rec.Status := Rec.Status::Open;
                                Rec.Modify();
                                Commit();
                                Rec.ViderQteAExpedierAutresPhases(PhasesDocVente.Phase);
                            end else
                                error(PhaseNonChoisieErr);
                        end;

                    //On crée un colisage
                    EnteteColisage.Init();
                    EnteteColisage."No." := '';
                    EnteteColisage.Insert(true);
                    //NumColisage := EnteteColisage."No.";
                    EnteteColisage."Sell-to Customer No." := Rec."Sell-to Customer No.";
                    EnteteColisage.Validate("No. commande", Rec."No.");
                    EnteteColisage."Poids brut non colise" := Rec."Poids brut total";
                    EnteteColisage.Phase := PhasesDocVente.Phase;
                    EnteteColisage."Date comptabilisation" := Rec."Posting Date";
                    if PhasesDocVente.get(Rec."Document Type", Rec."No.", PhasesDocVente.Phase) then
                        EnteteColisage."Description phase" := PhasesDocVente.Description;
                    EnteteColisage.Modify();
                    NumLigne := 1;

                    //Concernant les lignes, il y a deux possibilités :
                    // - l'utilisateur a détaillé chaque palette (quel article est sur quelle palette en quelle quantité)
                    //          On va alors créer ces palettes dans le colisage = Table Contenu colisage
                    //          Et en parallèle on crée le détail du colisage (palette/article/quantité) = Table Detail colisage 
                    // - l'utilisateur ne l'a pas fait, on va juste lister les articles expédiés dans le colisage (Table Détail colisage) sans lien avec des palettes 
                    //On va donc d'abord voir si on une prepa en cours pour la phase qu'on veut expédier (des palettes associées aux lignes de commande)
                    LignePrepa.SetCurrentKey("No. commande", Phase);
                    LignePrepa.SetRange("No. commande", Rec."No.");
                    LignePrepa.SetRange(Phase, PhasesDocVente.Phase);
                    if LignePrepa.FindSet() then
                        repeat
                            if not DetailColisage.Get(EnteteColisage."No.", LignePrepa."No. UC") then begin
                                DetailColisage.Init();
                                DetailColisage."No. colisage" := EnteteColisage."No.";
                                DetailColisage."No. UC" := LignePrepa."No. UC";
                                //DetailColisage."Type UC" := LignePrepa."Type UC";
                                DetailColisage."Numero camion" := LignePrepa."Numero camion";
                                DetailColisage.Numerotation := LignePrepa.Numerotation;
                                DetailColisage."Type UC" := LignePrepa."Type UC";
                                if UC.GET(LignePrepa."No. UC") then
                                    DetailColisage."Poids brut UC" := UC."Poids brut";
                                DetailColisage.Insert()
                            end;
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
                                    if LigneCommande."Linked to line" <> 0 then begin
                                        ContenuColisage."Type produit" := ContenuColisage."Type produit"::Composant;
                                        ContenuColisage."No. ligne regroupement" := LigneCommande."Linked to line";
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

                    EnteteColisage.MAJPoidsSurContenuColisage();

                    //On valide le BL
                    Rec.Ship := true;
                    Rec.Invoice := false;
                    CU80.Run(Rec);

                    //On supprime la préparation (les palettes/colis associées aux lignes de commandes de la phase expediée)

                end;
            }

        }
    }
    trigger OnAfterGetRecord()
    var
    //DossierBE: Record "Dossier BE";
    begin
        //CommentairesDossierBE := Rec.GetCommentairesDossierBE();
        CommentairesPrepa := Rec.GetCommentairesPrepa();

    end;

    var
        //CommentairesDossierBE: Text;
        CommentairesPrepa: Text;
}
