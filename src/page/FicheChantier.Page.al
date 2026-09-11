page 50084 "Fiche chantier"
{
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'Nouveau,Traitements,Etats,Naviguer';
    SourceTable = Chantier;
    ApplicationArea = All;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group("Général")
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Code du chantier';
                }
                field("Code enseigne"; Rec."Code enseigne")
                {
                    ToolTip = 'Code de l''enseigne à laquelle est rattaché le chantier.';
                }
                field("No. client"; Rec."No. client")
                {
                    ToolTip = 'N° du client';
                }
                field("Annee du chantier"; Rec."Annee du chantier")
                {
                    ToolTip = 'Année du chantier';
                }
                field("Nom chantier"; Rec."Nom chantier")
                {
                    ToolTip = 'Nom du chantier';
                }
                field("Description chantier"; Rec."Description chantier")
                {
                    ToolTip = 'Description du chantier';
                }
                field("Adresse chantier"; Rec."Adresse chantier")
                {
                    ToolTip = 'Adresse du chantier';
                }
                field("Adresse chantier 2"; Rec."Adresse chantier 2")
                {
                    ToolTip = 'Adresse 2 du chantier';
                }
                field("Code postal chantier"; Rec."Code postal chantier")
                {
                    ToolTip = 'Code postal du chantier';
                }
                field("Ville chantier"; Rec."Ville chantier")
                {
                    ToolTip = 'Ville du chantier';
                }
                field("Code pays chantier"; Rec."Code pays chantier")
                {
                    ToolTip = 'Code pays du chantier';
                }
                field("Contact chantier"; Rec."Contact chantier")
                {
                    ToolTip = 'Contact chantier';
                }
                field("No. téléphone chantier"; Rec."No. téléphone chantier")
                {
                    ToolTip = 'N° téléphone chantier';
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    Importance = Additional;
                    ToolTip = 'Conditions de livraison';
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    Importance = Additional;
                    ToolTip = 'Code du transporteur';
                }
                field("Adr. facture=Adr. livraison"; Rec."Adr. facture=Adr. livraison")
                {
                    ToolTip = 'Indique si l''adresse de facturation est la même que l''adresse de livraison.';
                }
                field("E-Mail chantier"; Rec."E-Mail chantier")
                {
                    ToolTip = 'Email du chantier';
                }
                field("Date premiere facture vte"; Rec."Date premiere facture vte")
                {
                    ToolTip = 'Date de la première facture de vente émise sur ce chantier';
                }
                field("Date derniere facture vte"; Rec."Date derniere facture vte")
                {
                    ToolTip = 'Date de la dernière facture de vente émise sur ce chantier';
                }
                field("Statut chantier"; Rec."Statut chantier")
                {
                    ToolTip = 'Statut du chantier';
                }
                field(Cloture; Rec.Cloture)
                {
                    Editable = false;
                    ToolTip = 'Indique si le chantier est clôturé.';
                }
                field("Chantier a verifier (>=2020)"; Rec."Chantier a verifier (>=2020)")
                {
                    Editable = false;
                    Importance = Additional;
                    Tooltip = 'Indique si le chantier fait partie des chantiers à vérifier (>=2020)';

                }
                field("Chantier verifie"; Rec."Chantier verifie")
                {
                    Editable = false;
                    Importance = Additional;
                    ToolTip = 'Indique si le chantier a été vérifié.';
                }
                field("Nombre interlocuteurs";Rec."Nombre interlocuteurs")
                {
                    ToolTip = 'Nombre d''interlocuteurs';
                }
            }
            group("Rentabilité - Détail")
            {
                fixed(Control1000000125)
                {
                    ShowCaption = false;
                    group(CA)
                    {
                        Caption = 'CA';
                        field(CAMobilier; Rec."CA Mobilier (Renta)")
                        {
                            BlankZero = true;
                            Caption = 'Mobilier';
                            ToolTip = 'Chiffre d''affaires réalisé sur une nature de vente de type Mobilier';
                        }
                        field(CApose; Rec."CA Pose/Audit (Renta)")
                        {
                            BlankZero = true;
                            Caption = 'Pose/audit';
                            ToolTip = 'Chiffre d''affaires réalisé sur une nature de vente de type Pose';
                        }
                        field(CATransport; Rec."CA Transport (Renta)")
                        {
                            BlankZero = true;
                            Caption = 'Transport';
                            ToolTip = 'Chiffre d''affaires réalisé sur une nature de vente de type Transport';
                        }
                        field(CABennes; Rec."CA Bennes/Fenwick (Renta)")
                        {
                            BlankZero = true;
                            Caption = 'Bennes/Fenwick';
                            ToolTip = 'Chiffre d''affaires réalisé sur une nature de vente de type Bennes';
                        }
                        field(CASAV; Rec."CA SAV (Renta)")
                        {
                            BlankZero = true;
                            Caption = 'SAV';
                            ToolTip = 'Chiffre d''affaires réalisé sur une nature de vente de type SAV';
                        }
                    }
                    group("Coût total")
                    {
                        Caption = 'Coût total';
                        field("Cout total Mobilier"; Rec."Cout total Mobilier")
                        {
                            Caption = 'Mobilier';
                            ToolTip = 'Charges enregistrées sur la nature de vente de type Mobilier';
                        }
                        field("Cout total Pose/Audit"; Rec."Cout total Pose/Audit")
                        {
                            Caption = 'Pose/audit';
                            ToolTip = 'Charges enregistrées sur la nature de vente de type Pose/Audit';
                        }
                        field("Cout total Transport"; Rec."Cout total Transport")
                        {
                            Caption = 'Transport';
                            ToolTip = 'Charges enregistrées sur la nature de vente de type Transport';
                        }
                        field("Cout total Bennes/Fenwick"; Rec."Cout total Bennes/Fenwick")
                        {
                            Caption = 'Bennes/Fenwick';
                            ToolTip = 'Charges enregistrées sur la nature de vente de type Bennes';
                        }
                        field("Cout total SAV"; Rec."Cout total SAV")
                        {
                            Caption = 'SAV';
                            ToolTip = 'Charges enregistrées sur la nature de vente de type SAV';
                        }
                    }
                    group("Marge brute (Montant)")
                    {
                        Caption = 'Marge brute (Montant)';
                        field(MargeMobilierRenta; Rec."CA Mobilier (Renta)" - Rec."Cout total Mobilier")
                        {
                            BlankZero = true;
                            Caption = 'Mobilier';
                            ToolTip = 'Marge réalisée sur la nature de vente de type Mobilier';
                        }
                        field(MargePoseAuditRenta; Rec."CA Pose/Audit (Renta)" - Rec."Cout total Pose/Audit")
                        {
                            BlankZero = true;
                            Caption = 'Pose/audit';
                            ToolTip = 'Marge réalisée sur la nature de vente de type Pose/Audit';
                        }
                        field(MargeTransportRenta; Rec."CA Transport (Renta)" - Rec."Cout total Transport")
                        {
                            BlankZero = true;
                            Caption = 'Transport';
                            ToolTip = 'Marge réalisée sur la nature de vente de type Transport';
                        }
                        field(MargeBennesRenta; Rec."CA Bennes/Fenwick (Renta)" - Rec."Cout total Bennes/Fenwick")
                        {
                            BlankZero = true;
                            Caption = 'Bennes/Fenwick';
                            ToolTip = 'Marge réalisée sur la nature de vente de type Bennes/Fenwick';
                        }
                        field(MargeSAVRenta; Rec."CA SAV (Renta)" - Rec."Cout total SAV")
                        {
                            BlankZero = true;
                            Caption = 'SAV';
                            ToolTip = 'Marge réalisée sur la nature de vente de type SAV';
                        }
                    }
                    group("Marge brute (%)")
                    {
                        Caption = 'Marge brute (%)';
                        field(PctMargeMobilierRenta; Pourcentage(Rec."CA Mobilier (Renta)" - Rec."Cout total Mobilier", Rec."CA Mobilier (Renta)"))
                        {
                            BlankZero = true;
                            Caption = 'Mobilier';
                            ToolTip = '% Marge réalisée sur la nature de vente de type Mobilier';
                        }
                        field(PctMargePoseRenta; Pourcentage(Rec."CA Pose/Audit (Renta)" - Rec."Cout total Pose/Audit", Rec."CA Pose/Audit (Renta)"))
                        {
                            BlankZero = true;
                            Caption = 'Pose/audit';
                            ToolTip = '% Marge réalisée sur la nature de vente de type Pose/Audit';
                        }
                        field(PctMargeTransportRenta; Pourcentage(Rec."CA Transport (Renta)" - Rec."Cout total Transport", Rec."CA Transport (Renta)"))
                        {
                            BlankZero = true;
                            Caption = 'Transport';
                            ToolTip = '% Marge réalisée sur la nature de vente de type Transport';
                        }
                        field(PctMargeBennesRenta; Pourcentage(Rec."CA Bennes/Fenwick (Renta)" - Rec."Cout total Bennes/Fenwick", Rec."CA Bennes/Fenwick (Renta)"))
                        {
                            BlankZero = true;
                            Caption = 'Bennes/Fenwick';
                            ToolTip = '% Marge réalisée sur la nature de vente de type Bennes/Fenwick';
                        }
                        field(PctMargeSAVRenta; Pourcentage(Rec."CA SAV (Renta)" - Rec."Cout total SAV", Rec."CA SAV (Renta)"))
                        {
                            BlankZero = true;
                            Caption = 'SAV';
                            ToolTip = '% Marge réalisée sur la nature de vente de type SAV';
                        }
                    }
                }
            }
            group(MargeNette)
            {
                Caption = 'Rentabilité - Synthèse';
                group(Marge)
                {
                    Caption = 'Marge';
                    field(CoutTotalAchatsPlusStockMoinsCoutTotalHorsCategorie; Rec."Cout total Achats+Stock" - Rec."Cout total hors catégorie")
                    {
                        Caption = 'Coût total catégorisé';
                        ToolTip = 'Coût total catégorisé';
                    }
                    field("Cout total hors catégorie"; Rec."Cout total hors catégorie")
                    {
                        Caption = 'Coût total non catégorisé';
                        ToolTip = 'Coût total non catégorisé';
                    }
                    field(CoutVentes; Rec."Cout total Achats+Stock")
                    {
                        Caption = 'Coût total (hors frais)';
                        ToolTip = 'Coût total (hors frais)';
                    }
                    field(CATotal; Rec."CA Total")
                    {
                        Caption = 'CA Total';
                        ToolTip = 'CA Total';
                    }
                    field(CATotalMoinsCoutTotalAchatsPlusStock; Rec."CA Total" - Rec."Cout total Achats+Stock")
                    {
                        Caption = 'Marge brute';
                        ToolTip = 'Marge brute';
                    }
                    field(PourcentageMargeBrute; Pourcentage(Rec."CA Total" - Rec."Cout total Achats+Stock", Rec."CA Total"))
                    {
                        Caption = 'Marge brute (%)';
                        ToolTip = '% marge brute';
                    }
                }
                group(Frais)
                {
                    Caption = 'Frais';
                    field(FraisApproche; Rec."Frais d'approche")
                    {
                        ToolTip = 'Frais d''approche';
                    }
                    field(FraisEmballage; Rec."Frais d'emballage")
                    {
                        ToolTip = 'Frais d''emballage';
                    }
                }
                field(MargeNetteMontant; Rec."CA Total" - Rec."Cout total Achats+Stock" - Rec."Frais d'approche" - Rec."Frais d'emballage")
                {
                    Caption = 'Marge nette';
                    Tooltip = 'Marge nette';
                }
                field(MargeNettePct; Pourcentage(Rec."CA Total" - Rec."Cout total Achats+Stock" - Rec."Frais d'approche" - Rec."Frais d'emballage", Rec."CA Total"))
                {
                    Caption = 'Marge nette (%)';
                    ToolTip = '% Marge nette';
                }
            }
            group("Statistiques globales")
            {
                group(Ventes)
                {
                    Caption = 'Ventes';
                    field(MontantFacturesVente; Rec."Montant factures vente")
                    {
                        ToolTip = 'Montant total des factures de vente.';
                    }
                    field(MontantAvoirsVente; Rec."Montant avoirs vente")
                    {
                        ToolTip = 'Montant total des avoirs de vente.';
                    }
                    field(MontantResteALivrer; Rec."Montant reste a livrer")
                    {
                        ToolTip = 'Montant du reste à livrer.';
                    }
                    field(MontantLivreNonFacture; Rec."Montant livre non facture")
                    {
                        ToolTip = 'Montant livré non facturé';
                    }
                }
                group(Achats)
                {
                    Caption = 'Achats';
                    field(MontantFacturesAchats; Rec."Montant factures achats")
                    {
                        ToolTip = 'Montant des factures d''achats';
                    }
                    field(MontantAvoirsAchats; Rec."Montant avoirs achats")
                    {
                        ToolTip = 'Montant des avoirs d''achats';
                    }
                    field(MontantSurCdesAchats; Rec."Montant sur cdes achats")
                    {
                        ToolTip = 'Montant en cours sur commandes d''achats';
                    }
                    field(MontantRecuNonFacture; Rec."Montant recu non facture")
                    {
                        ToolTip = 'Montant reçu non facturé';
                    }
                }
            }
            group(PDF)
            {
                Caption = 'PDF';
                field(CheminAccesPDFDevis; Rec."Chemin acces PDF Devis")
                {
                    ToolTip = 'Chemin d''accès vers le dossier contenant les PDF de devis.';

                }
                field(CheminAccesPDFAchats; Rec."Chemin acces PDF Achats")
                {
                    ToolTip = 'Chemin d''accès vers le dossier contenant les PDF des commandes achats.';
                }
                field(CheminAccesPDFBL; Rec."Chemin acces PDF BL")
                {
                    ToolTip = 'Chemin d''accès vers le dossier contenant les PDF des BL.';
                }
                field(CheminAccesPDFFactures; Rec."Chemin acces PDF Factures")
                {
                    ToolTip = 'Chemin d''accès vers le dossier contenant les PDF de factures.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(DevisVente)
            {
                Caption = 'Devis Vente';
                ToolTip = 'Permet de créer un nouveau devis lié à ce chantier.';
                Image = NewDocument;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.CreerDocumentVente(0);
                end;
            }
            action(CommandeVente)
            {
                Caption = 'Commande Vente';
                ToolTip = 'Permet de créer une nouvelle commande de vente liée à ce chantier.';
                Image = NewOrder;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.CreerDocumentVente(1);
                end;
            }
            action(CommandeAchat)
            {
                Caption = 'Commande achat';
                ToolTip = 'Permet de créer une nouvelle commande achat liée à ce chantier.';
                Image = NewWarehouseShipment;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.CreerCdeAchat();
                end;
            }
        }
        area(navigation)
        {
            action(Interlocuteurs)
            {
                Caption = 'Interlocuteurs';
                ToolTip = 'Interlocuteurs';
                Image = Employee;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page InterlocuteursChantier;
                RunPageLink = "Code chantier" = field (Code);
            }
            action(Devis)
            {
                Caption = 'Devis';
                ToolTip = 'Devis';
                Image = Document;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "Sales Quotes";
                RunPageLink = "Code chantier" = field(Code);
                RunPageView = sorting("Document Type", "Code chantier");
            }
            action(CommandesVentes)
            {
                Caption = 'Commandes ventes';
                ToolTip = 'Permet de consulter les commandes de ventes liées à ce chantier.';
                Image = "Order";
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "Sales Order List";
                RunPageLink = "Code chantier" = field(Code);
                RunPageView = sorting("Document Type", "Code chantier");
            }
            action(CommandesAchat)
            {
                Caption = 'Commandes achat';
                ToolTip = 'Permet de consulter les commandes achat liées à ce chantier.';
                Image = Receipt;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "Purchase Order List";
                RunPageLink = "Code chantier" = field(Code);
                RunPageView = sorting("Code chantier");
            }
            action(FacturesVentes)
            {
                Caption = 'Factures ventes';
                ToolTip = 'Permet de consulter les factures de ventes liées à ce chantier.';
                Image = Invoice;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "Posted Sales Invoices";
                RunPageLink = "Code chantier" = field(Code);
                RunPageView = sorting("Code chantier", "Posting Date");
            }
            action(AvoirsVentes)
            {
                Caption = 'Avoirs ventes';
                ToolTip = 'Permet de consulter les avoirs de ventes liées à ce chantier.';
                Image = PostedCreditMemo;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = false;
                RunObject = Page "Posted Sales Credit Memos";
                RunPageLink = "Code chantier" = field(Code);
                RunPageView = sorting("Code chantier", "Posting Date");
            }
            action(LignesFacturesAchats)
            {
                Caption = 'Lignes factures achats';
                ToolTip = 'Permet de consulter l''ensemble des lignes de factures d''achats liées à ce chantier.';
                Image = Purchase;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = false;
                RunObject = Page "Posted Purchase Invoice Lines";
                RunPageLink = "Code chantier" = field(Code);
                RunPageView = sorting("Code chantier");
            }
            action(LignesAvoirsAchats)
            {
                Caption = 'Lignes avoirs achats';
                ToolTip = 'Permet de consulter l''ensemble des lignes d''avoirs achats liées à ce chantier.';
                Image = CreditMemo;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = false;
                RunObject = Page "Posted Purchase Cr. Memo Lines";
                RunPageLink = "Code chantier" = field(Code);
                RunPageView = sorting("Code chantier");
            }

            action("Ecritures rentabilité")
            {
                Caption = 'Ecritures rentabilité';
                ToolTip = 'Ecritures rentabilité';
                Image = Entries;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Ecriture rentabilite";
                RunPageLink = "Code chantier" = field(Code);
                RunPageView = sorting("Code chantier");
            }
        }
        area(processing)
        {
            action("Actualiser Statut")
            {
                Caption = 'Actualiser Statut';
                ToolTip = 'Actualiser Statut';
                Image = NewStatusChange;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.MAJStatutChantier();
                end;
            }
            action("Clôturer ce chantier")
            {
                Caption = 'Clôturer ce chantier';
                ToolTip = 'Clôturer ce chantier';
                Image = ClosePeriod;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.Cloturer();
                end;
            }
            action("Feuille rentabilité")
            {
                Caption = 'Feuille rentabilité';
                ToolTip = 'Feuille rentabilité';
                Image = AdjustEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    //LigneRenta: Record "Ligne feuille rentabilite";
                    //Selection: Integer;
                    //OptionOuvrirFeuille: Label 'Ouvrir la feuille,Vider la feuille';
                    //FeuilleNonVideTxt: Label 'La feuille rentabilité %1 contient des lignes qui ne concernent pas la facture %2. Le système peut soit vous afficher ces lignes, soit les vider.';
                begin
                    Clear(PageFeuilleRenta);
                    PageFeuilleRenta.DefContexteAppel(Rec.Code);
                    PageFeuilleRenta.Run();
                end;
            }
        }
        area(reporting)
        {
            action("Etiquettes palettes")
            {
                Caption = 'Etiquettes palettes';
                Tooltip = 'Etiquettes palettes';
                Image = SuggestItemCost;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.AfficherEtiquettePalette();
                end;
            }
        }
    }

    var
        PageFeuilleRenta: Page "Feuille rentabilite";

    procedure Pourcentage(Valeur1: Decimal; Valeur2: Decimal): Decimal
    begin
        if Valeur2 = 0 then
            exit(0)
        else
            exit(Round(Valeur1 / Valeur2 * 100, 1));
    end;
}

