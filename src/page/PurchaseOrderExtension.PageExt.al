pageextension 50080 PurchaseOrderExtension extends "Purchase Order"
{
    layout
    {
        modify("Buy-from Vendor No.")
        {
            ShowMandatory = true;
        }
        modify("Buy-from Vendor Name")
        {
            ShowMandatory = true;
        }

        modify("Responsibility Center")
        {
            Visible = false;
        }

        modify("Buy-from Contact")
        {
            Visible = false;
        }
        modify("Buy-from County")
        {
            Visible = false;
        }
        modify("Pay-to County")
        {
            Visible = false;
        }
        modify("Vendor Invoice No.")
        {
            ShowMandatory = false;
        }

        modify("Purchaser Code")
        {
            Caption = 'Code acheteur/Chargé affaire';
            Importance = Standard;
            ShowMandatory = true;
        }
        modify("Buy-from Country/Region Code")
        {
            ShowMandatory = true;
        }

        modify("Vendor Order No.")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Job Queue Status")
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
        modify("On Hold")
        {
            Visible = false;
            Editable = false;
        }
        modify("Quote No.")
        {
            Visible = false;
        }
        modify("Prices Including VAT")
        {
            Visible = false;
        }


        modify(Prepayment)
        {
            Visible = false;
        }

        modify("Language Code")
        {
            Visible = true;
        }

        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify("Order Address Code")
        {
            Visible = false;
        }

        moveafter("Order Address Code"; "Location Code")

        modify("Location Code")
        {
            ShowMandatory = true;
        }

        movebefore("No."; Status)

        addafter("No.")
        {
            field("SAV Type"; Rec."SAV Type")
            {
                ToolTip = 'Type SAV';
                //Editable = false;
                //Enabled = false;
            }
            field("Achat pour stock"; Rec."Achat pour stock")
            {
                ToolTip = 'Achat pour stock';
            }
        }
        movebefore("Buy-from Address"; "Buy-from Vendor No.", "Buy-from Vendor Name")

        modify(BuyFromContactPhoneNo)
        {
            Visible = false;
        }
        modify(BuyFromContactMobilePhoneNo)
        {
            Visible = false;
        }
        modify(BuyFromContactEmail)
        {
            Visible = false;
        }
        modify("Buy-from Contact No.")
        {
            Visible = false;
        }

        addafter("Buy-from")
        {
            group(Donnees)
            {
                Caption = 'Données';
                field("Code groupe"; Rec."Code groupe")
                {
                    ToolTip = 'Groupe';
                }
                field("Code enseigne"; Rec."Code enseigne")
                {
                    ToolTip = 'Enseigne';
                }
                field("Code chantier"; Rec."Code chantier")
                {
                    ToolTip = 'Chantier';
                    Editable = not Rec."Achat pour stock";
                    ShowMandatory = true;
                }
                field("Code operation"; Rec."Code operation")
                {
                    ToolTip = 'Opération';
                    Visible = false;
                }

            }
        }

        moveafter("Code chantier"; "Location Code", "Purchaser Code")

        addafter(Donnees)
        {
            group(Dates)
            {
                Caption = 'Dates';
                field("Date intention chargement"; Rec."Date intention chargement")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date du lundi de la semaine prévisionnelle de chargement.';
                    Editable = Rec."Suivi container";
                    ShowMandatory = true;
                }
                
                field("Date chargement confirmee"; Rec."Date chargement confirmee")
                {
                    ToolTip = 'Date de chargement réelle saisie par l''AIE';
                }
            }
        }
        movebefore("Date intention chargement"; "Document Date", "Order Date")
        addafter("Date intention chargement")
        {
            field("Livraison directe"; Rec."Livraison directe")
            {
                ApplicationArea = All;
                ToolTip = 'Livraison directe';
            }
            
        }

        moveafter("Date chargement confirmee"; "Expected Receipt Date")
        addafter("Expected Receipt Date")
        {
            field("Annee commande"; Rec."Annee commande")
            {
                ToolTip = 'Année commande';
            }
        }
        modify("Invoice Received Date")
        {
            Visible = false;
        }


        addafter(Dates)
        {
            group(DescriptionTravail)
            {
                Caption = 'Description du travail';
                field(Commentaires; Rec.Commentaires)
                {
                    ToolTip = 'Commentaires';
                    ShowMandatory = true;
                }
                field("Commentaires pour AIE"; Rec."Commentaires pour AIE")
                {
                    ToolTip = 'Commentaires pour AIE';
                }
            }
        }
        moveafter("Commentaires pour AIE"; "Language Code", "No. of Archived Versions")

        modify("Your Reference")
        {
            Visible = false;
        }

        //movebefore("Vendor Invoice No.";"Vendor Shipment No.")
        //moveafter("Vendor Invoice No.";"Posting Description")

        modify("Posting Description")
        {
            Visible = true;
        }

        addafter(DescriptionTravail)
        {
            group(Comptabilisation)
            {

            }
        }

        movefirst(Comptabilisation; "Vendor Shipment No.", "Vendor Invoice No.", "Posting Date", "Posting Description")

        addbefore("VAT Bus. Posting Group")
        {
            field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
            {
                ToolTip = 'Groupe compta marché';
            }
        }
        addafter("VAT Bus. Posting Group")
        {
            field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
            {
                ToolTip = 'Type doc. lettrage';
            }
            field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
            {
                ToolTip = 'N° doc. lettrage';
            }
        }


        movebefore("Currency Code"; "Due Date", "VAT Reporting Date")

        modify("VAT Reporting Date")
        {
            Importance = Standard;
        }
        modify("Due Date")
        {
            Importance = Standard;
        }

        modify("Tax Liable")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Promised Receipt Date")
        {
            Visible = false;
        }
        modify("Inbound Whse. Handling Time")
        {
            Visible = false;
        }
        addafter("Area")
        {
            field("Suivi container"; Rec."Suivi container")
            {
                ToolTip = 'Suivi container';
            }
            field("No. container"; Rec."No. container")
            {
                ToolTip = 'N° container';
            }
            field("Commande transitaire container"; Rec."Commande transitaire container")
            {
                ToolTip = 'Commande transitaire container';
            }

            field("Frais transitaire eclates"; Rec."Frais transitaire eclates")
            {
                ToolTip = 'Frais transitaire éclatés';
            }
        }
        addlast(content)
        {
            part(InfosTransitaire; "SF Cde achat : infos transit.")
            {
                ApplicationArea = All;

                SubPageLink = "No. commande transitaire" = field("No.");
            }
        }
    }

    actions
    {
        modify(GetRecurringPurchaseLines)
        {
            Caption = 'Extraire commande d''achat type';
        }

        modify("Create &Whse. Receipt")
        {
            Visible = false;
        }
        modify("Send Intercompany Purchase Order")
        {
            Visible = false;
        }
        modify("Create Inventor&y Put-away/Pick")
        {
            Visible = false;
        }

        modify("Archive Document")
        {
            Promoted = false;
        }

        modify("Dr&op Shipment")
        {
            Visible = false;
        }
        modify("Speci&al Order")
        {
            Visible = false;
        }
        modify("Create Tracking Information")
        {
            Visible = false;
        }
        modify(Warehouse)
        {
            Visible = false;
        }
        modify("Request Approval")
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
        modify("Prepa&yment")
        {
            Visible = false;
        }
        modify("Get &Sales Order")
        {
            Visible = false;
        }
        modify(Functions_GetSalesOrder)
        {
            Visible = false;
        }
        modify(Warehouse_GetSalesOrder)
        {
            Visible = false;
        }
        modify(PostPrepaymentInvoice)
        {
            Visible = false;
        }
        modify(PostedPrepaymentCrMemos)
        {
            Visible = false;
        }
        modify(Action225)
        {
            Visible = false;
        }
        modify(Action186)
        {
            Visible = false;
        }
        modify(Action187)
        {
            Visible = false;
        }
        modify(PostAndNew)
        {
            Visible = false;
        }

        addlast(processing)
        {

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
                    Image = Translate;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        rec.MAJDescriptionsEnENU();
                    end;
                }
            }
        }
        addafter("Co&mments")
        {
            action(Affectations)

            {
                ApplicationArea = All;
                ToolTip = 'Affectations achat/ventes';
                ShortcutKey = 'Ctrl+D';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Affectations achat vente";
                RunPageLink = "No. document achat" = field("No.");
                Image = LinkAccount;
            }

            action(AffectationsManquantes)
            {
                ApplicationArea = All;
                Caption = 'Affectations manquantes';
                ToolTip = 'Affectations manquantes';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = QuestionaireSetup;

                trigger OnAction()

                begin
                    AfficherDiversSansAffectation();
                end;
            }
            action("Affectations Containers (transitaire)")

            {
                ApplicationArea = All;
                ToolTip = 'Affectations containers (transitaire)';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = LinkAccount;
                RunObject = Page "Lien cde transitaire-reception";
                RunPageLink = "No. commande transitaire" = field("No.");

                trigger OnAction()

                begin
                    AfficherDiversSansAffectation();
                end;
            }

            action("Pousser vers container")

            {
                ApplicationArea = All;
                ToolTip = 'Pousser vers container';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = CreateWarehousePick;

                trigger OnAction()
                var
                    EnteteAchat: record "Purchase Header";
                begin
                    Rec.RemplirQuantiteVersContainer();
                    COMMIT();
                    EnteteAchat.SETRANGE("Document Type", Rec."Document Type");
                    EnteteAchat.SETRANGE("No.", Rec."No.");
                    PAGE.RUN(PAGE::"Pousser achat vers container", EnteteAchat);

                end;
            }
            /*
            action("Envoyer par mail")

            {
                ApplicationArea = All;
                ToolTip = 'Envoyer par mail';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = SendEmailPDF;

                trigger OnAction()
                var
                //cuEnvoiMail: Codeunit "Envoi doc par mail";

                begin
                    //cuEnvoiMail.GenererPDFAchat(Rec,TRUE); 

                end;
            }
            */
            action("Etiquette palette")
            {
                ApplicationArea = All;
                ToolTip = 'Etiquette palette';
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Image = SuggestItemPrice;

                trigger OnAction()

                begin
                    Rec.GenererEtiquettePalette(true);

                end;
            }
            action(ComparerVersions)
            {
                ApplicationArea = All;
                Caption = 'Comparer versions';
                ToolTip = 'Comparer deux versions archivées de cette commande';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = CompareCost;

                trigger OnAction()
                var
                    ComparaisonPage: Page ComparaisonVersionsCdeAchat;
                    AuMoinsDeuxArchivesErr: Label 'Il faut qu''il y ait au moins deux versions archivées pour les comparer. Les versions sont archivées en imprimant et à condition que le montant total évolue.';
                begin
                    rec.CalcFields("No. of Archived Versions");
                    if Rec."No. of Archived Versions" < 2 then
                        error(AuMoinsDeuxArchivesErr);
                    Clear(ComparaisonPage);
                    ComparaisonPage.DefFiltreNumCde(Rec."No.");
                    ComparaisonPage.Run();
                end;
            }
            action(ChoisirImpressions)
            {
                ApplicationArea = All;
                Caption = 'Choisir impressions';
                Ellipsis = true;
                ToolTip = 'Choisir quels documents liés à la commande vous voulez imprimer.';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = SelectReport;

                trigger OnAction()
                var
                begin
                    Rec.ProposerImpressions();
                end;
            }
        }
        modify(Reopen)
        {
            ShortcutKey = 'Ctrl+Q';
        }
        modify("Post &Batch")
        {
            Visible = false;
        }
        modify(Preview)
        {
            Visible = false;
        }
        modify(Invoices)
        {
            Visible = false;
        }
        modify("Co&mments")
        {
            Visible = false;
        }
        modify("Test Report")
        {
            Visible = false;
        }
        modify(CalculateInvoiceDiscount)
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




    }
    local procedure AfficherDiversSansAffectation()
    var
        ListeDiversSansAffectationPage: page "Achats Divers sans affectation"; //50070
        TousDiversAffectesMsg: Label 'Tous les articles divers sont affectés à un document de vente.';
        LineNo: integer;
    begin
        if Rec.DiversNonAffecte(LineNo) then begin //LineNo ne sert à rien ici
            CLEAR(ListeDiversSansAffectationPage);
            ListeDiversSansAffectationPage.DefFiltre(Rec."No.");
            ListeDiversSansAffectationPage.RUNMODAL();
        end else
            MESSAGE(TousDiversAffectesMsg)
    end;






    var





}
