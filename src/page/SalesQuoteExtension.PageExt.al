pageextension 50087 SalesQuoteExtension extends "Sales Quote"
{
    layout
    {
        modify("Language Code")
        {
            Visible = true;
        }
        modify("Sell-to Customer Templ. Code")
        {
            Visible = false;
        }
        modify("Sell-to Contact No.")
        {
            Visible = false;
        }
        modify(SellToPhoneNo)
        {
            Visible = false;
        }
        modify(SellToMobilePhoneNo)
        {
            Visible = false;
        }
        modify(SellToEmail)
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
        modify("Tax Liable")
        {
            Visible = false;
        }
        modify("Tax Area Code")
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
            field("Devis Stock"; Rec."Devis Stock")
            {
                ToolTip = 'Devis Stock';

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
        modify("Requested Delivery Date")
        {
            ShowMandatory = true;
        }

        modify("Quote Valid Until Date")
        {
            Visible = false;
        }



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
            field("Proba transformation"; Rec."Proba transformation")
            {
                ApplicationArea = All;
                ToolTip = 'Proba transformation';
                ShowMandatory = true;
            }
        }
        moveafter("Facturation en compta (O/N)"; "Work Description")

        moveafter("Proba transformation"; "Language Code")

        moveafter("Language Code"; "No. of Archived Versions")

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

        addafter("Payment Method Code")
        {
            field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Groupe compta. marché';
            }
            field("Customer Posting Group"; Rec."Customer Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Groupe compta client';
            }
            field("VAT Registration No."; Rec."VAT Registration No.")
            {
                ApplicationArea = All;
                ToolTip = 'N° TVA Intracom.';
            }

            field("Factor Code"; Rec."Factor Code")
            {
                ApplicationArea = All;
                ToolTip = 'Code banque';
            }
            field("Posting Description"; Rec."Posting Description")
            {
                ApplicationArea = All;
                ToolTip = 'Libellé écriture';
            }
        }
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

    }

    actions
    {
        modify(PageInteractionLogEntries)
        {
            Visible = false;
        }

        modify("C&reate Customer")
        {
            Visible = false;
        }
        modify("Create &Task")
        {
            Visible = false;
        }
        modify(SendApprovalRequest)
        {
            Visible = false;
        }

        modify(CancelApprovalRequest)
        {
            Visible = false;
        }

        modify(IncomingDocument)
        {
            Visible = false;
        }

        modify(CalculateInvoiceDiscount)
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
        modify("C&ontact")
        {
            Visible = false;
        }

        modify(Reopen)
        {
            Promoted = true;
            PromotedIsBig = true;
            ShortcutKey = 'Ctrl+Q';
        }
        modify(MakeOrder)
        {
            Visible = false;
        }

        addafter(GetRecurringSalesLines)
        {
            /*L'action visant à extraire un document type complet est désactivée car j'ai développé en remplacement
            //une action permettant d'extraire que certaines lignes du document type
            action(ExtraireDevisType)
            {
                ApplicationArea = Suite;
                Caption = 'Extraire devis type';
                Ellipsis = true;
                Image = CustomerCode;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Extraire un devis type lié au client';

                trigger OnAction()
                var
                    StdCustSalesCode: Record "Standard Customer Sales Code";
                begin
                    StdCustSalesCode.InsertSalesLines(Rec);
                end;
            }
            */
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

        addafter(Approvals)
        {
            action(CopierDocument)
            {
                ApplicationArea = Suite;
                Caption = 'Copier document';
                Ellipsis = true;
                Enabled = Rec."No." <> '';
                Image = CopyDocument;
                ToolTip = 'Copier un autre document vers ce document';
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if not Rec.Find() then begin
                        Rec.Insert(true);
                        Commit();
                    end;
                    Rec.CopyDocument();
                    if Rec.Get(Rec."Document Type", Rec."No.") then;
                    CurrPage.SalesLines.Page.ForceTotalsCalculation();
                    CurrPage.Update();
                end;
            }
            action("Achats affectés")
            {
                ApplicationArea = All;
                ToolTip = 'Achats affectés';
                ShortcutKey = 'Ctrl+D';
                RunObject = page "Affectations achat vente";
                RunPageView = sorting("Type document vente", "No. document vente", "No. ligne document vente")
                                  where("Type document vente" = const(Devis));
                RunPageLink = "No. document vente" = field("No.");
                //Promoted = true;
                //PromotedIsBig = true;
                Image = LinkAccount;
                //PromotedCategory = Process;
            }
            action("Calculer sous-totaux")
            {
                ApplicationArea = All;
                ToolTip = 'Calculer sous-totaux';
                Promoted = true;
                PromotedIsBig = true;
                Image = NewSum;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.CalcSubTotal(Rec);
                end;
            }

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
                //ShortcutKey = 'Ctrl+D';
                //RunObject = page "Phases document vente";
                //RunPageView = where("Type document" = const("Devis vente"));
                //RunPageLink = "No. document" = field("No.");
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
                    PhasesDocument.SetRange("Type document", PhasesDocument."Type document"::Quote);
                    PhasesDocument.SetRange("No. document", Rec."No.");
                    PagePhases.SetTableView(PhasesDocument);
                    PagePhases.Run();
                end;
            }
            action(ComparerVersions)
            {
                ApplicationArea = All;
                Caption = 'Comparer versions';
                ToolTip = 'Comparer deux versions archivées de ce devis';
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

        }
        addlast(Action59)
        {
            action(ImprimerBP)
            {
                ApplicationArea = All;
                Caption = 'Bon de prépa';
                Promoted = true;
                PromotedCategory = Category9;
                Image = Print;
                ToolTip = 'Bon de préparation';

                trigger OnAction()
                var
                    EnteteVente: Record "Sales Header";

                begin
                    EnteteVente.SETRANGE("Document Type", Rec."Document Type");
                    EnteteVente.SETRANGE("No.", Rec."No.");
                    if EnteteVente.FINDSET() then
                        REPORT.RUN(Report::"ABRANE : picking Quote", true, true, EnteteVente);
                end;
            }
        }
        addlast(processing)
        {
            action("Créer cde d'achat")
            {
                ToolTip = 'Créer commande(s) d''achat';
                Promoted = true;
                PromotedIsBig = true;
                Image = NewWarehouseReceipt;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    LigneVente: Record 37;
                    CreatedPurchHeader: Record 38;
                    PhasesDocVente: Record "Phases document";
                    PagePhases: Page "Liste phases document";
                    PurchOrderNo: Code[20];
                    CodeFournisseurIndefini: Code[20];
                    OpenPurchOrderQst: Label 'Une commande d''achat (%1) a été créée/complétée, voulez-vous l''ouvrir ?', Comment = '%1 = N° commande';
                    txtMessage: Text;
                    Text50001Msg: Label '%1 commandes d''achat créées.', Comment = '%1 = Nb de commandes créées.';
                    Text50002Msg: Label 'Aucune commande d''achat créée. Soit vous avez fermé la fenêtre volontairement, soit vous n''avez pas indiqué de fournisseur sur les lignes du document.';
                    Text50003Msg: Label '%1 lignes ajoutées à des commandes existantes.', Comment = '%1 = Nb de lignes ajoutées.';
                    ChoisirAuMoinsUnePhaseErr: Label 'Vous devez au moins choisir une phase à acheter.';
                    OperationInterrompueErr: Label 'Vous devez au moins choisir une phase à acheter.';

                    NbCdesCreees: Integer;
                    NbCdesCompletees: Integer;
                    NbLignesAjoutees: Integer;
                    NbPhasesAvecArticles: Integer;
                    AcheterQueCertainesPhases: Boolean;
                begin
                    NbPhasesAvecArticles := Rec.CompterPhasesActives();
                    //KAN.FHA 26/05/2026 DEBUT
                    LigneVente.SetRange("Document Type", Rec."Document Type");
                    LigneVente.SetRange("Document No.", Rec."No.");
                    LigneVente.ModifyAll("A acheter", true);
                    //KAN.FHA 26/05/2026 FIN
                    if NbPhasesAvecArticles > 1 then begin
                        PhasesDocVente.SetRange("Type document", Rec."Document Type");
                        PhasesDocVente.SetRange("No. document", Rec."No.");
                        //KAN.FHA 22/04/2026 DEBUT
                        PhasesDocVente.ModifyAll(Acheter, true);
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
                    /*
                    end else begin
                        //KAN.FHA 22/04/2026 DEBUT
                        LigneVente.SetRange("Document Type", Rec."Document Type");
                        LigneVente.SetRange("Document No.", Rec."No.");
                        LigneVente.ModifyAll("A acheter", true);
                        //KAN.FHA 22/04/2026 FIN
                    */
                    end;
                    

                    PurchOrderNo := '';
                    CodeFournisseurIndefini := '_INDEFINI';
                    if Rec.CreerCommandesAchats(PurchOrderNo, CodeFournisseurIndefini, NbCdesCreees, NbCdesCompletees, NbLignesAjoutees, AcheterQueCertainesPhases) then begin
                        if PurchOrderNo <> '' then //Only one purch order created => ask if open it
                            if Confirm(OpenPurchOrderQst, true, PurchOrderNo) then begin
                                CreatedPurchHeader.GET(CreatedPurchHeader."Document Type"::Order, PurchOrderNo);
                                page.RUN(page::"Purchase Order", CreatedPurchHeader);
                            end else
                                MESSAGE(Text50001Msg, NbCdesCreees)
                        else begin
                            txtMessage := '';
                            if NbCdesCreees > 0 then
                                txtMessage := strsubstno(Text50001Msg, NbCdesCreees);
                            if NbLignesAjoutees > 0 then begin
                                if txtMessage <> '' then
                                    txtMessage := txtMessage + '\';
                                txtMessage := txtMessage + StrSubstNo(Text50003Msg, NbLignesAjoutees);
                            end;
                            Message(txtMessage);
                        end;
                    end else begin
                        //On vide le N° fournisseur sur chaque ligne si c'est le code INDEFINI
                        LigneVente.RESET();
                        LigneVente.SETRANGE("Document Type", Rec."Document Type");
                        LigneVente.SETRANGE("Document No.", Rec."No.");
                        if LigneVente.FINDSET(true) then
                            repeat
                                if LigneVente."Vendor No." = CodeFournisseurIndefini then begin
                                    LigneVente."Vendor No." := '';
                                    LigneVente.MODIFY();
                                end;
                            until LigneVente.NEXT() = 0;

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

            action(CreerCommandeVente)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Créer commande vente';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = MakeOrder;
                ToolTip = 'Transforme le devis en commande';

                trigger OnAction()
                begin
                    CODEUNIT.Run(CODEUNIT::"Sales-Quote to Order (Yes/No)", Rec);
                end;
            }
            action("Créer facture acompte")
            {
                ToolTip = 'Créer facture acompte/Situation';
                Caption = 'Créer facture acompte/situation';
                Promoted = true;
                PromotedIsBig = true;
                Image = PrepaymentPost;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    if (rec."No. facture acompte" = '') and (rec."No. facture acompte enregistre" = '') then
                        Rec.CreerFactureAcompte()
                    else
                        Rec.CreerFactureSituation();
                end;
            }

            action(Interlocuteurs)
            {
                Caption = 'Interlocuteurs';
                ToolTip = 'Interlocuteurs';
                Image = Employee;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page InterlocuteursChantier;
                RunPageLink = "Code chantier" = field("Code chantier");
            }

            action(AfficherStockDispo)
            {
                ApplicationArea = All;
                Caption = 'Stock dispo';
                ToolTip = 'Afficher stock dispo';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    Rec.AfficherStockDispo();
                end;
            }

            group(Traduire)
            {
                Caption = 'Traduire';

                action("En FRA")
                {
                    ApplicationArea = All;
                    Caption = 'FRA';
                    ToolTip = 'Traduire les désignations en français';
                    Image = Translate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    trigger OnAction()
                    begin
                        rec.MAJDescriptionsEnFRA();
                    end;
                }
                action("En ENU")
                {
                    ApplicationArea = All;
                    Caption = 'ENU';
                    ToolTip = 'Traduire les désignations en anglais';
                    Promoted = true;
                    PromotedCategory = Process;
                    //Promoted = true;
                    //PromotedIsBig = true;
                    //PromotedCategory = Process;
                    Image = Translate;
                    trigger OnAction()
                    begin
                        rec.MAJDescriptionsEnENU();
                    end;
                }
            }
        }
        modify(CopyDocument) //Ruse pour masquer le groupe d'action "Preparer" qui ne contient que cette action
        {
            Visible = false;
        }


    }
    trigger OnAfterGetRecord()
    var
        DossierBE: Record "Dossier BE";
    begin
        CommentairesDossierBE := Rec.GetCommentairesDossierBE();
        CommentairesPrepa := Rec.GetCommentairesPrepa();
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
        PctAvancementBE: Decimal;
        AlerteBE: Text;


}

