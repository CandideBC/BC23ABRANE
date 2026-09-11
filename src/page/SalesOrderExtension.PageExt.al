pageextension 50086 SalesOrderExtension extends "Sales Order"
{
    layout
    {
        modify("Language Code")
        {
            Visible = true;
        }

        modify("Sell-to Contact No.")
        {
            Visible = false;
        }
        modify(
            "Sell-to Phone No."
        )
        {
            Visible = false;
        }
        modify(SellToMobilePhoneNo)
        {
            Visible = false;
        }
        modify("Sell-to E-Mail")
        {
            Visible = false;
        }
        modify("Due Date")
        {
            Visible = false;
        }

        modify("Sell-to Customer No.")
        {
            Importance = Standard;
            ShowMandatory = true;
        }

        modify("Sell-to Customer Name")
        {
            ShowMandatory = false;
        }
        modify("Salesperson Code")
        {
            Importance = Standard;
            ShowMandatory = true;
        }
        modify("Campaign No.")
        {
            Visible = false;
        }
        modify("Opportunity No.")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify("Payment Discount %")
        {
            Visible = false;
        }
        modify("Pmt. Discount Date")
        {
            Visible = false;
        }
        modify("Prices Including VAT")
        {
            Visible = false;
        }
        modify("Shipping Agent Code")
        {
            Visible = false;
        }
        modify("Shipping Agent Service Code")
        {
            Visible = false;
        }
        modify("Package Tracking No.")
        {
            Visible = false;
        }
        modify("Order Date")
        {
            Visible = true;
        }
        modify("Document Date")
        {
            Visible = true;
        }
        modify("Your Reference")
        {
            Visible = false;
        }

        addbefore("No.")
        {
            field(ass; Rec.ass)
            {
                ApplicationArea = All;
                ToolTip = 'SAV';
            }

        }
        movebefore(ass; Status)

        movebefore("Sell-to Address"; "Sell-to Customer No.", "Sell-to Customer Name")
        moveafter("Sell-to Country/Region Code"; "Sell-to Contact")

        addafter("Sell-to")
        {
            group(Donnees)
            {
                Caption = 'Données';
                field("Code groupe"; Rec."Code groupe")
                {
                    ApplicationArea = All;
                    ToolTip = 'Code groupe';
                }
                field("Code enseigne"; Rec."Code enseigne")
                {
                    ApplicationArea = All;
                    ToolTip = 'Code enseigne';
                    ShowMandatory = true;
                }

                field("Code chantier"; Rec."Code chantier")
                {
                    ToolTip = 'Code chantier';
                    ShowMandatory = true;
                }

                field("Code operation"; Rec."Code operation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Code opération';
                    Importance = Additional;
                    Visible = false;
                }
            }
        }
        moveafter("Code chantier"; "Location Code", "Salesperson Code")

        addafter("Salesperson Code")
        {
            group(Dates)
            {
                Caption = 'Dates';
                field("Date chargement"; Rec."Date chargement")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date chargement';
                    ShowMandatory = true;
                }
            }
        }
        movebefore("Date chargement"; "Document Date", "Order Date")
        moveafter("Date chargement"; "Requested Delivery Date")

        modify("Location Code")
        {
            ShowMandatory = true;
        }


        addafter("Requested Delivery Date")
        {
            field("Annee commande"; Rec."Annee commande")
            {
                ApplicationArea = All;
                ToolTip = 'Année commande';
            }
        }
        modify("Requested Delivery Date")
        {
            ShowMandatory = true;
        }
        modify("Promised Delivery Date")
        {
            Visible = false;
        }

        addafter(Donnees)
        {
            group("Commentaires dossier BE")
            {
                Caption = 'Commentaires dossier BE';

                field(CommentairesDossierBE; CommentairesDossierBE)
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Standard;
                    MultiLine = true;
                    ShowCaption = false;
                    ToolTip = 'Indique les commentaires généraux concernant le dossier BE. Ce champ est synchronisé avec le dossier BE.';

                    trigger OnValidate()
                    begin
                        Rec.SetCommentairesDossierBE(CommentairesDossierBE);
                    end;

                }
                field("No. dossier BE"; Rec."No. dossier BE")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indique si une fiche BE est liée au document';
                    Editable = false;
                    Lookup = false;

                    trigger OnDrillDown()
                    var
                        DossierBE: Record "Dossier BE";
                    begin
                        if Rec."No. dossier BE" <> '' then begin
                            DossierBE.Get(Rec."No. dossier BE");
                            Page.RunModal(Page::"Fiche dossier BE", DossierBE);
                        end;
                    end;
                }
                field(RetardBE; AlerteBE)
                {
                    ApplicationArea = All;
                    Caption = 'BE';
                    ShowCaption = false;
                    Editable = false;
                    ToolTip = 'Indique si une fiche du dossier a un délai de réponse du BE qui est dépassé alors que la fiche est en cours.';
                    Style = Unfavorable;
                }
                field(PctAvancementBE; PctAvancementBE)
                {
                    ApplicationArea = All;
                    Caption = '% avancement BE';
                    DecimalPlaces = 0 : 0;
                    Editable = false;
                    ToolTip = '% de fiches qui sont terminées ou annulées.';
                }

                group("Commentaires Prepa")
                {
                    Caption = 'Commentaires Prépa';

                    field(CommentairesPrepa; CommentairesPrepa)
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Standard;
                        MultiLine = true;
                        ShowCaption = false;
                        ToolTip = 'Indique les commentaires généraux pour la logistique.';

                        trigger OnValidate()
                        begin
                            Rec.SetCommentairesPrepa(CommentairesPrepa);
                        end;
                    }
                }
                /*
                group("Commentaires Prepa")
                {
                    Caption = 'Commentaires Prépa';

                    field(CommentairesPrepa; CommentairesPrepa)
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Standard;
                        MultiLine = true;
                        ShowCaption = false;
                        ToolTip = 'Indique les commentaires généraux pour la logistique.';

                        trigger OnValidate()
                        begin
                            Rec.SetCommentairesPrepa(CommentairesPrepa);
                        end;
                    }
                }
                */
            }
        }


        addafter("Commentaires Prepa")
        {
            field("Range No."; Rec."Range No.")
            {
                ToolTip = 'Code rayon';
                ApplicationArea = All;
            }
            field("Commentaire factu."; Rec."Commentaire factu.")
            {
                ApplicationArea = All;
                ToolTip = 'Commentaire facturation';
            }
            field("Facturation en compta (O/N)"; Rec."Facturation en compta (O/N)")
            {
                ToolTip = 'Facturation en compta (O/N)';
                ApplicationArea = All;
            }
        }

        moveafter("Range No."; "External Document No.")

        addafter("Work Description")
        {
            field(Commentaire; Rec.Commentaire)
            {
                ApplicationArea = All;
                ToolTip = 'Commentaires';
                ShowMandatory = true;
            }
        }
        moveafter("Facturation en compta (O/N)"; "Work Description")
        moveafter("Facturation en compta (O/N)"; "Posting Date")

        moveafter(Commentaire; "Language Code", "No. of Archived Versions")

        modify("External Document No.")
        {
            ShowMandatory = true;
        }

        modify("Shipment Date")
        {
            Caption = 'Date d''expédition';
            Visible = false;
        }

        addbefore("Currency Code")
        {
            field("Amount included Ecotax"; Rec."Amount included Ecotax")
            {
                ApplicationArea = All;
                ToolTip = 'Montant écotaxe inclus';
            }
            field("Code cond. paiement acomptes"; Rec."Code cond. paiement acomptes")
            {
                ApplicationArea = All;
                ToolTip = 'Code cond. paiement acomptes';
            }
            field("% acompte demande"; Rec."% acompte demande")
            {
                ApplicationArea = All;
                ToolTip = '"% acompte demandé';
            }

            field("No. facture acompte"; Rec."No. facture acompte")
            {
                ApplicationArea = All;
                ToolTip = 'N° facture acompte';
                AssistEdit = true;

                trigger OnAssistEdit()
                var
                    EnteteVente: Record "Sales Header";
                begin
                    if rec."No. facture acompte" <> '' then
                        if EnteteVente.get(EnteteVente."Document Type"::Invoice, rec."No. facture acompte") then
                            page.run(page::"Sales Invoice", EnteteVente)

                end;
            }
            field("No. facture acompte enregistre"; Rec."No. facture acompte enregistre")
            {
                ApplicationArea = All;
                ToolTip = 'N° facture acompte enregistrée';
                AssistEdit = true;
                trigger OnAssistEdit()
                var
                    EnteteFactureVente: Record "Sales Invoice Header";
                begin
                    if rec."No. facture acompte enregistre" <> '' then
                        if EnteteFactureVente.get(rec."No. facture acompte enregistre") then
                            page.run(page::"Posted Sales Invoice", EnteteFactureVente)
                end;
            }
            field("Code cond. paiement situation"; Rec."Code cond. paiement situation")
            {
                ApplicationArea = All;
                ToolTip = 'Code cond. paiement situation';
            }

            field("% acompte situation demande"; Rec."% acompte situation demande")
            {
                ApplicationArea = All;
                ToolTip = '% acompte situation demandé';
            }

            field("Creer facture situation le"; Rec."Creer facture situation le")
            {
                ApplicationArea = All;
                ToolTip = 'Date à laquelle la facture de situation devra être créée.';
            }
            field("Demander situ. a la compta"; Rec."Demander situ. a la compta")
            {
                ApplicationArea = All;
                ToolTip = 'Indique si la demande de facturation a été transmise (via la pile sur le tableau de bord) à la compta';
            }

            field("No. facture situation"; Rec."No. facture situation")
            {
                ApplicationArea = All;
                ToolTip = 'N° facture situation';
                AssistEdit = true;

                trigger OnAssistEdit()
                var
                    EnteteVente: Record "Sales Header";
                begin
                    if rec."No. facture situation" <> '' then
                        if EnteteVente.get(EnteteVente."Document Type"::Invoice, rec."No. facture situation") then
                            page.run(page::"Sales Invoice", EnteteVente)
                end;
            }
            field("No. facture situat. enregistre"; Rec."No. facture situat. enregistre")
            {
                ApplicationArea = All;
                ToolTip = 'N° facture situat. enregistrée';
                AssistEdit = true;
                trigger OnAssistEdit()
                var
                    EnteteFactureVente: Record "Sales Invoice Header";
                begin
                    if rec."No. facture acompte enregistre" <> '' then
                        if EnteteFactureVente.get(rec."No. facture acompte enregistre") then
                            page.run(page::"Posted Sales Invoice", EnteteFactureVente)
                end;
            }
            field("Montant deja verse TTC"; Rec."Montant deja verse TTC")
            {
                ApplicationArea = All;
                ToolTip = 'Montant déjà versé TTC';
            }
        }

        movebefore("Amount included Ecotax"; "Due Date", "VAT Reporting Date")

        addafter("Payment Method Code")
        {
            field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Groupe compta. marché';
            }

            field("Factor Code"; Rec."Factor Code")
            {
                ApplicationArea = All;
                ToolTip = 'Code banque';
            }
        }
        moveafter("Gen. Bus. Posting Group"; "Customer Posting Group", "VAT Registration No.", "Posting Description")
        moveafter("Customer Posting Group"; "VAT Bus. Posting Group")

        addafter(ShippingOptions)
        {
            field("Total Net Weight"; Rec."Total Net Weight")
            {
                ApplicationArea = All;
                ToolTip = 'Poids net total';
            }
            field("Poids brut total"; Rec."Poids brut total")
            {
                ApplicationArea = All;
                ToolTip = 'Poids brut total';
            }
            field("Nombre de colis"; Rec."Nombre de colis")
            {
                ApplicationArea = All;
                ToolTip = 'Nombre de colis';
            }
            field("Nombre de palettes"; Rec."Nombre de palettes")
            {
                ApplicationArea = All;
                ToolTip = 'N° palette';
            }
        }
        modify("Direct Debit Mandate ID")
        {
            Visible = false;
        }
        modify("Prepayment %")
        {
            Visible = false;
        }
        modify("Compress Prepayment")
        {
            Visible = false;
        }
        modify("Prepayment Due Date")
        {
            Visible = false;
        }
        modify("Prepmt. Payment Discount %")
        {
            Visible = false;
        }
        modify("Prepmt. Pmt. Discount Date")
        {
            Visible = false;
        }
        modify("Prepmt. Payment Terms Code")
        {
            Visible = false;
        }
        modify(Control76) //Onglet Acompte
        {
            Visible = false;
        }
        modify(Control1900201301) //Service de paiement
        {
            Visible = false;
        }





    }

    actions
    {
        modify(Release)
        {
            Enabled = (Rec.Status = Rec.Status::Open);
        }
        modify(Reopen)
        {
            Enabled = (Rec.Status = Rec.Status::Released);
            ShortcutKey = 'Ctrl+Q';
        }
        modify(AssemblyOrders)
        {
            Visible = false;
        }
        modify(Warehouse)
        {
            Visible = false;
        }
        modify(PageInteractionLogEntries)
        {
            Visible = false;
        }
        modify(IncomingDocument)
        {
            Visible = false;
        }
        modify(MoveNegativeLines)
        {
            Visible = false;
        }
        modify(Dimensions)
        {
            Visible = false;
        }
        modify("Create Inventor&y Put-away/Pick")
        {
            Visible = false;
        }

        modify("Work Order")
        {
            Visible = false;
        }

        modify("Create &Warehouse Shipment")
        {
            Visible = false;
        }
        modify(Approvals)
        {
            Visible = false;
        }

        modify("Request Approval")
        {
            Visible = false;
        }

        modify(SendApprovalRequest)
        {
            Visible = false;
        }
        modify("Print Confirmation")
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(Plan)
        {
            Visible = false;
        }
        addafter(GetRecurringSalesLines)
        {
            action(ExtraireDevisTypePartiel)
            {
                ApplicationArea = Suite;
                Caption = 'Extraire devis type';
                Ellipsis = true;
                Image = CustomerCode;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Extraire un devis type lié au client puis sélectionner les lignes qu''on souhaite ajouter.';

                trigger OnAction()

                begin
                    rec.AjouterDocumentType();
                end;
            }
        }
        modify(GetRecurringSalesLines)
        {
            Visible = false;
        }
        addafter("Print Confirmation")
        {
            action("Facture Proforma2")
            {
                ToolTip = 'Facture Proforma';
                Image = Print;

                trigger OnAction()
                var
                    RecSalesHeader: Record "Sales Header";
                begin
                    Rec.CalcSubTotal(Rec);
                    COMMIT();

                    CurrPage.SETSELECTIONFILTER(RecSalesHeader);
                    REPORT.RUN(Report::"ABRANE : Sales Proforma Inv.", true, false, RecSalesHeader);
                end;
            }
            action("Packing List")
            {
                ToolTip = 'Packing List';
                Image = Print;

                trigger OnAction()
                var
                    RecSalesHeader: Record "Sales Header";
                begin
                    Rec.CalcSubTotal(Rec);
                    COMMIT();

                    CurrPage.SETSELECTIONFILTER(RecSalesHeader);
                    REPORT.RUN(Report::"ABRANE : Packing List", true, false, RecSalesHeader);
                end;
            }

        }

        addafter(AssemblyOrders)
        {
            action("Achats affectés")
            {
                ApplicationArea = All;
                ToolTip = 'Achats affectés';
                ShortcutKey = 'Ctrl+D';
                RunObject = page "Affectations achat vente";
                RunPageView = sorting("Type document vente", "No. document vente", "No. ligne document vente")
                                  where("Type document vente" = const(Commande));
                RunPageLink = "No. document vente" = field("No.");
                //Promoted = true;
                //PromotedIsBig = true;
                Image = LinkAccount;
                //PromotedCategory = Process;
            }
            action(Interlocuteurs)
            {
                Caption = 'Interlocuteurs';
                ToolTip = 'Interlocuteurs';
                Image = Employee;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page InterlocuteursChantier;
                RunPageLink = "Code chantier" = field("Code chantier");
            }
        }

        addlast(processing)
        {
            action("Calculer sous-totaux")
            {
                ApplicationArea = All;
                ToolTip = 'Calculer sous-totaux';
                Image = NewSum;

                trigger OnAction()
                begin
                    Rec.CalcSubTotal(Rec);
                end;
            }

            action("Calculer Poids total")
            {
                ToolTip = 'Calculer poids net total';
                Promoted = true;
                Image = SuggestNumber;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    CalculerPoidsNet();
                end;
            }
            action(ComparerVersions)
            {
                ApplicationArea = All;
                Caption = 'Comparer versions';
                ToolTip = 'Comparer deux versions';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = CompareCost;

                trigger OnAction()
                var
                    ComparaisonPage: Page ComparaisonVersionsDocVente;
                    AuMoinsDeuxArchivesErr: Label 'Il faut qu''il y ait au moins deux versions archivées pour les comparer. Les versions sont archivées en imprimant et à condition que le montant total varie.';
                begin
                    rec.CalcFields("No. of Archived Versions");
                    if Rec."No. of Archived Versions" < 2 then
                        error(AuMoinsDeuxArchivesErr);
                    Clear(ComparaisonPage);
                    ComparaisonPage.DefFiltreDocVente(Rec."Document Type", Rec."No.");
                    ComparaisonPage.Run();
                end;
            }

            group(Traduire)
            {
                Caption = 'Traduire';
                action("En FRA")
                {
                    ToolTip = 'Traduire les désignations en français.';
                    trigger OnAction()
                    begin
                        rec.MAJDescriptionsEnFRA();
                    end;
                }
                action("En ENU")
                {
                    ToolTip = 'Traduire les désignations en anglais.';
                    trigger OnAction()
                    begin
                        rec.MAJDescriptionsEnENU();
                    end;
                }
            }

            action("Créer cde d'achat")
            {
                ToolTip = 'Créer commande(s) d''achat';
                Promoted = true;
                PromotedIsBig = true;
                Image = NewWarehouseReceipt;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    LigneVente: Record 37;
                    CreatedPurchHeader: Record 38;
                    PhasesDocVente: Record "Phases document";
                    PagePhases: page "Liste phases document";
                    PurchOrderNo: Code[20];
                    CodeFournisseurIndefini: Code[20];
                    OpenPurchOrderQst: Label 'Une commande d''achat (%1) a été créée/complétée, voulez-vous l''ouvrir ?', Comment = '%1 = N° commande';
                    txtMessage: Text;
                    Text50001Msg: Label '%1 commandes d''achat créées.', Comment = '%1 = Nb de commandes créées.';
                    Text50002Msg: Label 'Aucune commande d''achat créée. Soit vous avez fermé la fenêtre volontairement, soit vous n''avez pas indiqué de fournisseur sur les lignes du document.';
                    Text50003Msg: Label '%1 lignes ajoutées à des commandes existantes.', Comment = '%1 = Nb de lignes ajoutées.';
                    ChoisirAuMoinsUnePhaseErr: Label 'Vous devez au moins choisir une phase à acheter.';
                    OperationInterrompueErr: Label 'Vous devez au moins choisir une phase à acheter.';
                    UneCommandeCreeeMsg: Label 'Une commande achat a été créée/modifiée.';
                    NbCdesCreees: Integer;
                    NbCdesCompletees: Integer;
                    NbLignesAjoutees: Integer;
                    NbPhasesAvecArticles: Integer;
                    AcheterQueCertainesPhases: Boolean;
                begin
                    clear(PagePhases);
                    NbPhasesAvecArticles := Rec.CompterPhasesActives();
                    AcheterQueCertainesPhases := false;
                    LigneVente.SetRange("Document Type", Rec."Document Type");
                    LigneVente.SetRange("Document No.", Rec."No.");
                    LigneVente.ModifyAll("A acheter", true);
                    if NbPhasesAvecArticles > 1 then begin
                        PhasesDocVente.SetRange("Type document", Rec."Document Type");
                        PhasesDocVente.SetRange("No. document", Rec."No.");
                        //KAN.FHA 22/04/2026 DEBUT
                        PhasesDocVente.ModifyAll(Acheter,true);
                        //KAN.FHA 27/04/2026 DEBUT
                        //LigneVente.SetRange("Document Type", Rec."Document Type");
                        //LigneVente.SetRange("Document No.", Rec."No.");
                        //LigneVente.SetRange(Phase, Rec.Phase);
                        //LigneVente.ModifyAll("A acheter", true);
                        //KAN.FHA 27/04/2026 FIN
                        Commit();
                        //KAN.FHA 22/04/2026 DEBUT
                        PagePhases.SetTableView(PhasesDocVente);
                        PagePhases.DefinirTypeAppel('Acheter');
                        PagePhases.LookupMode(true);
                        if PagePhases.RunModal() = Action::LookupOK then begin
                            PhasesDocVente.SetRange(Acheter, true);
                            if PhasesDocVente.IsEmpty then
                                Error(ChoisirAuMoinsUnePhaseErr);
                            AcheterQueCertainesPhases := true;
                        end else
                            error(OperationInterrompueErr);
                    end;
                    /*
                    else begin
                        //KAN.FHA 22/04/2026 DEBUT
                        LigneVente.SetRange("Document Type", Rec."Document Type");
                        LigneVente.SetRange("Document No.", Rec."No.");
                        //LigneVente.SetRange(Phase, Rec.Phase);
                        LigneVente.ModifyAll("A acheter", true);
                        //KAN.FHA 22/04/2026 FIN
                    end;
                    */

                    PurchOrderNo := '';
                    CodeFournisseurIndefini := '_INDEFINI';
                    if Rec.CreerCommandesAchats(PurchOrderNo, CodeFournisseurIndefini, NbCdesCreees, NbCdesCompletees,NbLignesAjoutees, AcheterQueCertainesPhases) then begin
                        if PurchOrderNo <> '' then //Only one purch order created => ask if open it
                            if CONFIRM(OpenPurchOrderQst, true, PurchOrderNo) then begin
                                CreatedPurchHeader.GET(CreatedPurchHeader."Document Type"::Order, PurchOrderNo);
                                page.RUN(page::"Purchase Order", CreatedPurchHeader);
                            end else
                                message(UneCommandeCreeeMsg)
                        else begin
                            txtMessage := '';
                            if NbCdesCreees > 0 then
                                txtMessage := strsubstno(Text50001Msg, NbCdesCreees);
                            if NbLignesAjoutees > 0 then begin
                                if txtMessage <> '' then
                                    txtMessage := txtMessage + '\';
                                txtMessage := txtMessage + StrSubstNo(Text50003Msg, NbLignesAjoutees)
                            end;
                        end;
                        PhasesDocVente.Reset();
                        PhasesDocVente.SetRange("Type document", Rec."Document Type");
                        PhasesDocVente.SetRange("No. document", Rec."No.");
                        PhasesDocVente.ModifyAll(Acheter, false);
                    end else begin
                        //On vide le Nø fournisseur sur chaque ligne si c'est le code INDEFINI
                        LigneVente.Reset();
                        LigneVente.SetRange("Document Type", Rec."Document Type");
                        LigneVente.SetRange("Document No.", Rec."No.");
                        if LigneVente.FindSet(true) then
                            repeat
                                if LigneVente."Vendor No." = CodeFournisseurIndefini then begin
                                    LigneVente."Vendor No." := '';
                                    LigneVente.Modify();
                                end;
                            until LigneVente.Next() = 0;

                        MESSAGE(Text50002Msg);
                    end;
                end;
            }
            action(SuiviAchats)
            {
                ApplicationArea = All;
                Caption = 'Suivi achats';
                ToolTip = 'Affiche la liste des commandes achats passées pour ce document.';
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


            action("Créer facture acompte")
            {
                ToolTip = 'Créer facture acompte';
                Promoted = true;
                PromotedIsBig = true;
                Image = PrepaymentPost;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Rec.CreerFactureAcompte();
                end;
            }

            /*
            action("Déplacer ligne acompte")
            {
                ToolTip = 'Déplacer ligne acompte';
                Promoted = true;
                PromotedIsBig = true;
                Image = MoveDown;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Rec.RepousserAcompte();
                end;
            }
            */

            /*FHA 08/09/2025 Action plus utilise suite à la mise en place du phasage
            action("Remplir qté expédier / phase")
            {
                ToolTip = 'Remplir qté expédier / phase';
                Promoted = true;
                PromotedIsBig = true;
                Image = AutofillQtyToHandle;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.RemplirQteExpedierPhase();
                end;
            }
            */
            action(VueSimplifiee)
            {
                ApplicationArea = All;
                ToolTip = 'Vue simplifiée';
                Caption = 'Vue simplifiée';
                ShortcutKey = 'Ctrl+M';
                Promoted = true;
                PromotedCategory = Process;
                Image = ViewJob;

                trigger OnAction()
                begin
                    Rec.AfficherVueSimplifiee();
                end;
            }
            action(PhasesDocument)
            {
                ApplicationArea = All;
                Caption = 'Phases';
                ToolTip = 'Affiche les phases du document ainsi que les articles rattachés à chaque phase.';
                Promoted = true;
                PromotedIsBig = true;
                Image = JobTimeSheet;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    PhasesDocument: Record "Phases document";
                    PagePhases: page "Phases document vente";
                begin
                    Clear(PagePhases);
                    PagePhases.DefinirConditionsAppel(false);
                    PhasesDocument.SetRange("Type document", PhasesDocument."Type document"::Order);
                    PhasesDocument.SetRange("No. document", Rec."No.");
                    PagePhases.SetTableView(PhasesDocument);
                    PagePhases.Run();
                end;
            }
            action(SaisiePrepa)
            {
                ApplicationArea = All;
                Caption = 'Fiche expédition';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = PickWorksheet;
                ToolTip = 'Fiche expédition';

                trigger OnAction()
                var
                    RecSalesHeader: Record "Sales Header";
                begin
                    RecSalesHeader.Get(Rec."Document Type", Rec."No.");
                    page.run(page::"Fiche saisie expedition", RecSalesHeader);
                end;

            }
            action(Expedier)
            {
                Caption = 'Expédier';
                ToolTip = 'Si vous aves plusieurs phases dans la commande, vous pourrez sélectionner quelle phase vous souhaitez livrer.';
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    PhasesDocVente: Record "Phases document";
                    CU80: codeunit "Sales-Post";
                    PagePhases: Page "Phases document vente";
                    NbPhasesDocument: Integer;
                    PhaseNonChoisieErr: Label 'Vous devez choisir une phase.';
                    ExpedierQst: Label 'Souhaitez-vous expédier cette commande ?';
                    OperationAnnuleeErr: Label 'Opération interrompue';
                begin
                    Rec.CalcSubTotal(Rec);
                    PhasesDocVente.SetRange("Type document", PhasesDocVente."Type document"::Order);
                    PhasesDocVente.SetRange("No. document", Rec."No.");
                    NbPhasesDocument := PhasesDocVente.Count;
                    if NbPhasesDocument in [0, 1] then
                        if not Confirm(ExpedierQst, false) then
                            Error(OperationAnnuleeErr);
                    if NbPhasesDocument >= 1 then
                        if NbPhasesDocument = 1 then begin
                            PhasesDocVente.FindFirst();
                            Rec."Phase a expedier" := PhasesDocVente.Phase;
                            Rec."Libelle phase a expedier" := PhasesDocVente.Description;
                            Rec.Status := Rec.Status::Open;
                            Rec.Modify();
                            Commit();
                        end else begin //Plus d'une phase, on va demander quelle phase on souhaite expédier
                            Commit();
                            Clear(PagePhases);
                            PagePhases.DefinirConditionsAppel(true);
                            PagePhases.SetTableView(PhasesDocVente);
                            PagePhases.LookupMode(true);
                            if PagePhases.RunModal() = Action::LookupOK then begin
                                PagePhases.GetRecord(PhasesDocVente);
                                Rec."Phase a expedier" := PhasesDocVente.Phase;
                                Rec."Libelle phase a expedier" := PhasesDocVente.Description;
                                Rec.Status := Rec.Status::Open;
                                if PhasesDocVente."Date comptabilisation" <> 0D then
                                    Rec.Validate("Posting Date", PhasesDocVente."Date comptabilisation");

                                Rec.Modify();
                                Commit();
                                Rec.ViderQteAExpedierAutresPhases(PhasesDocVente.Phase);
                            end else
                                error(PhaseNonChoisieErr);
                        end;

                    Rec.Ship := true;
                    Rec.Invoice := false;
                    CU80.Run(Rec);
                end;
            }
            action(Facturer)
            {
                Caption = 'Facturer';
                ToolTip = 'Vous permet de facturer les quantités livrées et non facturées.';
                Image = Invoice;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    CU80: codeunit "Sales-Post";

                begin
                    Rec.CalcSubTotal(Rec);
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify();
                    Commit();
                    Rec.Ship := false;
                    Rec.Invoice := true;
                    CU80.Run(Rec);
                end;
            }

            action(AfficherStockDispo)
            {
                ApplicationArea = All;
                Caption = 'Stock dispo';
                ToolTip = 'Afficher stock dispo';

                trigger OnAction()
                begin
                    rec.AfficherStockDispo();
                end;
            }
        }
    }
    procedure CalculerPoidsNet();
    var
        l_SalesLine: Record 37;
        l_TotalNetWeight: Decimal;
    begin
        l_TotalNetWeight := 0;
        l_SalesLine.SETRANGE("Document Type", l_SalesLine."Document Type"::Order);
        l_SalesLine.SETRANGE("Document No.", Rec."No.");
        l_SalesLine.SETRANGE(Type, l_SalesLine.Type::Item);
        l_SalesLine.SETRANGE("Ligne eclatee", false);
        if l_SalesLine.FINDSET(false) then
            repeat
                l_TotalNetWeight := l_TotalNetWeight + (l_SalesLine."Net Weight" * l_SalesLine."Qty. to Ship");
            until l_SalesLine.NEXT() = 0;
        Rec."Total Net Weight" := l_TotalNetWeight;

    end;

    trigger OnAfterGetRecord()
    var
        DossierBE: Record "Dossier BE";
    begin
        CommentairesDossierBE := Rec.GetCommentairesDossierBE();
        CommentairesPrepa := rec.GetCommentairesPrepa();
        PctAvancementBE := 0;
        AlerteBE := '';
        if Rec."No. dossier BE" <> '' then
            if DossierBE.get(Rec."No. dossier BE") then begin
                PctAvancementBE := DossierBE.CalcAvancement();
                AlerteBE := DossierBE.LigneEnRetard();
            end;
    end;

    var
        CommentairesDossierBE: Text;
        CommentairesPrepa: Text;
        AlerteBE: Text;
        PctAvancementBE: Decimal;
}
