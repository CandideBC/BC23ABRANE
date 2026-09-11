page 50081 "Fiche enseigne"
{
    ApplicationArea = All;
    PageType = Card;
    PromotedActionCategories = 'Nouveau document,Traitements,Etats,Naviguer';
    SourceTable = Enseigne;

    layout
    {
        area(content)
        {
            group("Général")
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Code';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                }
                field("Code groupe"; Rec."Code groupe")
                {
                    ToolTip = 'Code groupe';
                }
                field("Concept obligatoire"; Rec."Concept obligatoire")
                {
                    Importance = Additional;
                    ToolTip = 'Concept obligatoire';
                }
                field("Code conditions paiement"; Rec."Code conditions paiement")
                {
                    Importance = Standard;
                    Caption = 'Cond. paiement';
                    ToolTip = 'Code conditions paiement';
                }
                field("Code cond. paiement acomptes"; Rec."Code cond. paiement acomptes")
                {
                    Importance = Standard;
                    Caption = 'Cond. paiement acomptes';
                    ToolTip = 'Conditions de paiement pour les factures d''acomptes';
                }
                field("Code cond. paiement situation"; Rec."Code cond. paiement situation")
                {
                    Importance = Standard;
                    Caption = 'Cond. paiement situation';
                    ToolTip = 'Code cond. paiement situation';
                }
                field("% acompte situation"; Rec."% acompte situation")
                {
                    ApplicationArea = All;
                    ToolTip = '% acompte situation';
                }
                field("Prefixe chantier"; Rec."Prefixe chantier")
                {
                    ToolTip = 'Préfixe chantier';
                }
                field("No. dern. chantier"; Rec."No. dern. chantier")
                {
                    ToolTip = 'N° dern. chantier';
                    Importance = Additional;
                }
                field("Enseigne interne"; Rec."Enseigne interne")
                {
                    ToolTip = 'Enseigne interne';
                    Importance = Additional;
                }
                field("Chemin acces PDF Devis Stock"; Rec."Chemin acces PDF Devis Stock")
                {
                    Importance = Additional;
                    ToolTip = 'Chemin acces PDF Devis Stock';
                }
                field("Chemin acces PDF Achats Stock"; Rec."Chemin acces PDF Achats Stock")
                {
                    Importance = Additional;
                    ToolTip = 'Chemin acces PDF Achats Stock';
                }
                field("Nombre interlocuteurs"; Rec."Nombre interlocuteurs")
                {
                    ToolTip = 'Nombre d''interlocuteurs';
                }
            }
            group("Rentabilité - Détail")
            {
                fixed(Control1000000072)
                {
                    ShowCaption = false;
                    group(CA)
                    {
                        Caption = 'CA';
                        //The GridLayout property is only supported on controls of type Grid
                        //GridLayout = Rows;
                        field(CAMobilier; Rec."CA Mobilie")
                        {
                            ToolTip = 'CA Mobilier';
                            BlankZero = true;
                            Caption = 'Mobilier';
                        }
                        field(CApose; Rec."CA Pose/Audit")
                        {
                            ToolTip = 'CA Pose';
                            BlankZero = true;
                            Caption = 'Pose/audit';
                        }
                        field(CATransport; Rec."CA Transport")
                        {
                            ToolTip = 'CA Transport';
                            BlankZero = true;
                            Caption = 'Transport';
                        }
                        field(CABennes; Rec."CA Bennes/Fenwick")
                        {
                            ToolTip = 'CA Bennes';
                            BlankZero = true;
                            Caption = 'Bennes/Fenwick';
                        }
                        field(CASAV; Rec."CA SAV")
                        {
                            ToolTip = 'CA SAV';
                            BlankZero = true;
                            Caption = 'SAV';
                        }
                    }
                    group("Coût total")
                    {
                        Caption = 'Coût total';
                        //The GridLayout property is only supported on controls of type Grid
                        //GridLayout = Rows;
                        field("Cout total Mobilier"; Rec."Cout total Mobilier")
                        {
                            ToolTip = 'Coût total Mobilier';
                            Caption = 'Mobilier';
                        }
                        field("Cout total Pose/Audit"; Rec."Cout total Pose/Audit")
                        {
                            ToolTip = 'Coût total Pose';
                            Caption = 'Pose/audit';
                        }
                        field("Cout total Transport"; Rec."Cout total Transport")
                        {
                            ToolTip = 'Coût total Transport';
                            Caption = 'Transport';
                        }
                        field("Cout total Bennes/Fenwick"; Rec."Cout total Bennes/Fenwick")
                        {
                            ToolTip = 'Coût total Bennes';
                            Caption = 'Bennes/Fenwick';
                        }
                        field("Cout total SAV"; Rec."Cout total SAV")
                        {
                            ToolTip = 'Coût total SAV';
                            Caption = 'SAV';
                        }
                    }
                    group("Marge brute (Montant)")
                    {
                        Caption = 'Marge brute (Montant)';
                        //The GridLayout property is only supported on controls of type Grid
                        //GridLayout = Rows;
                        field(MargeMobilierRenta; Rec."CA Mobilie" - Rec."Cout total Mobilier")
                        {
                            ToolTip = 'Marge Mobilier';
                            BlankZero = true;
                            Caption = 'Mobilier';
                        }
                        field(MargePoseAuditRenta; Rec."CA Pose/Audit" - Rec."Cout total Pose/Audit")
                        {
                            ToolTip = 'Marge Pose';
                            BlankZero = true;
                            Caption = 'Pose/audit';
                        }
                        field(MargeTransportRenta; Rec."CA Transport" - Rec."Cout total Transport")
                        {
                            ToolTip = 'Marge Transport';
                            BlankZero = true;
                            Caption = 'Transport';
                        }
                        field(MargeBennesRenta; Rec."CA Bennes/Fenwick" - Rec."Cout total Bennes/Fenwick")
                        {
                            ToolTip = 'Marge Bennes';
                            BlankZero = true;
                            Caption = 'Bennes/Fenwick';
                        }
                        field(MargeSAVRenta; Rec."CA SAV" - Rec."Cout total SAV")
                        {
                            ToolTip = 'Marge SAV';
                            BlankZero = true;
                            Caption = 'SAV';
                        }
                    }
                    group("Marge brute (%)")
                    {
                        Caption = 'Marge brute (%)';
                        //The GridLayout property is only supported on controls of type Grid
                        //GridLayout = Rows;
                        field(PctMargeMobilierRenta; Pourcentage(Rec."CA Mobilie" - Rec."Cout total Mobilier", Rec."CA Mobilie"))
                        {
                            ToolTip = '% Marge Mobilier';
                            BlankZero = true;
                            Caption = 'Mobilier';
                        }
                        field(PctMargePoseRenta; Pourcentage(Rec."CA Pose/Audit" - Rec."Cout total Pose/Audit", Rec."CA Pose/Audit"))
                        {
                            ToolTip = '% Marge Pose';
                            BlankZero = true;
                            Caption = 'Pose/audit';
                        }
                        field(PctMargeTransportRenta; Pourcentage(Rec."CA Transport" - Rec."Cout total Transport", Rec."CA Transport"))
                        {
                            ToolTip = '% Marge Transport';
                            BlankZero = true;
                            Caption = 'Transport';
                        }
                        field(PctMargeBennesRenta; Pourcentage(Rec."CA Bennes/Fenwick" - Rec."Cout total Bennes/Fenwick", Rec."CA Bennes/Fenwick"))
                        {
                            BlankZero = true;
                            ToolTip = '% Marge Bennes';
                            Caption = 'Bennes/Fenwick';
                        }
                        field(PctMargeSAVRenta; Pourcentage(Rec."CA SAV" - Rec."Cout total SAV", Rec."CA SAV"))
                        {
                            BlankZero = true;
                            Caption = 'SAV';
                            ToolTip = '% Marge SAV';
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
                    //The GridLayout property is only supported on controls of type Grid
                    //GridLayout = Rows;
                    field("Cout total Achats+Stock-Cout total hors catégorie"; Rec."Cout total Achats+Stock" - Rec."Cout total hors catégorie")
                    {
                        ToolTip = 'Coût total catégorisé';
                        Caption = 'Coût total catégorisé';
                    }
                    field("Cout total hors catégorie"; Rec."Cout total hors catégorie")
                    {
                        ToolTip = 'Coût total non catégorisé';
                        Caption = 'Coût total non catégorisé';
                    }
                    field(CoutVentes; Rec."Cout total Achats+Stock")
                    {
                        ToolTip = 'Coût total (hors frais)';
                        Caption = 'Coût total (hors frais)';
                    }
                    field(CATotal; Rec."CA Total")
                    {
                        Caption = 'CA Total';
                        ToolTip = 'CA Total';
                    }
                    field("CA Total-Cout total Achats+Stock"; Rec."CA Total" - Rec."Cout total Achats+Stock")
                    {
                        ToolTip = 'CA Total-Cout total Achats+Stock';
                        Caption = 'Marge brute';
                    }
                    field("Pourcentage([CA Total]-[Cout total Achats+Stock]/[CA Total])"; Pourcentage(Rec."CA Total" - Rec."Cout total Achats+Stock", Rec."CA Total"))
                    {
                        ToolTip = 'Pourcentage([CA Total]-[Cout total Achats+Stock]/[CA Total])';
                        Caption = 'Marge brute (%)';
                    }
                }
                group(Frais)
                {
                    Caption = 'Frais';
                    //The GridLayout property is only supported on controls of type Grid
                    //GridLayout = Rows;
                    field("Frais d'approche"; Rec."Frais d'approche")
                    {
                        ToolTip = 'Frais d''approche';
                    }
                    field("Frais d'emballage"; Rec."Frais d'emballage")
                    {
                        ToolTip = 'Frais d''emballage';
                    }
                }
                field(MargeNetteMontant; Rec."CA Total" - Rec."Cout total Achats+Stock" - Rec."Frais d'approche" - Rec."Frais d'emballage")
                {
                    ToolTip = 'Marge nette';
                    Caption = 'Marge nette';
                }
                field(MargeNettePct; Pourcentage(Rec."CA Total" - Rec."Cout total Achats+Stock" - Rec."Frais d'approche" - Rec."Frais d'emballage", Rec."CA Total"))
                {
                    ToolTip = 'Marge nette (%)';
                    Caption = 'Marge nette (%)';
                }
            }
            group(Statistiques)
            {
                Caption = 'Statistiques';
                group(Ventes)
                {
                    Caption = 'Ventes';
                    field("Montant factures ventes"; Rec."Montant factures ventes")
                    {
                        ToolTip = 'Montant factures ventes';
                    }
                    field("Montant avoirs ventes"; Rec."Montant avoirs ventes")
                    {
                        ToolTip = 'Montant avoirs ventes';
                    }
                    field("Montant factures ventes-Montant avoirs ventes"; Rec."Montant factures ventes" - Rec."Montant avoirs ventes")
                    {
                        ToolTip = 'Chiffre d''affaires';
                        Caption = 'Chiffre d''affaires';
                    }
                    field("OD Chiffre affaires"; Rec."OD Chiffre affaires")
                    {
                        ToolTip = 'OD Chiffre affaires';
                    }
                    field("Montant factures ventes-Montant avoirs ventes+OD Chiffre affaires"; Rec."Montant factures ventes" - Rec."Montant avoirs ventes" + Rec."OD Chiffre affaires")
                    {
                        ToolTip = 'CA total';
                        Caption = 'CA total';
                    }
                    field("Montant reste a livrer"; Rec."Montant reste a livrer")
                    {
                        ToolTip = 'Montant reste à livrer';
                    }
                    field("Montant livre non facture"; Rec."Montant livre non facture")
                    {
                        ToolTip = 'Montant livré non facturé';
                    }
                }
                group(Achats)
                {
                    Caption = 'Achats';
                    field("Montant factures achats"; Rec."Montant factures achats")
                    {
                        ToolTip = 'Montant factures achats';
                    }
                    field("Montant avoirs achats"; Rec."Montant avoirs achats")
                    {
                        ToolTip = 'Montant avoirs achats';
                    }
                    field("Montant sur cdes achats"; Rec."Montant sur cdes achats")
                    {
                        ToolTip = 'Montant sur cdes achats';
                    }
                    field("Montant recu non facture"; Rec."Montant recu non facture")
                    {
                        ToolTip = '"Montant reçu non facturé"';
                    }
                }
                group("Achats Stock")
                {
                    Caption = 'Achats Stock';
                    field(Control1000000017; Rec."Commandes achat STOCK")
                    {
                        ToolTip = 'Commandes achat STOCK';
                        DrillDownPageID = "Purchase Order List";
                    }
                    field("Montant factures achats STOCK"; Rec."Montant factures achats STOCK")
                    {
                        ToolTip = 'Montant factures achats STOCK';
                    }
                    field("Montant avoirs achats STOCK"; Rec."Montant avoirs achats STOCK")
                    {
                        ToolTip = 'Montant avoirs achats STOCK';
                    }
                    field("Montant sur cdes achats STOCK"; Rec."Montant sur cdes achats STOCK")
                    {
                        ToolTip = 'Montant sur cdes achats STOCK';
                    }
                    field("Montant recu non facture STOCK"; Rec."Montant recu non facture STOCK")
                    {
                        ToolTip = 'Montant reçu non facturé STOCK';
                    }
                }
                group("Devis Stock")
                {
                    Caption = 'Devis Stock';
                    field(Control1000000021; Rec."Devis STOCK")
                    {
                        ToolTip = 'Devis STOCK';
                        DrillDownPageID = "Sales Quotes";
                    }
                }
            }
            part(Chantiers; "SF Fiche Enseigne")
            {
                Caption = 'Chantiers';
                SubPageLink = "Code enseigne" = field(Code);
            }
            part("Chantiers clôturés"; "SF Enseigne-Chantiers clotures")
            {
                Caption = 'Chantiers clôturés';
                SubPageLink = "Code enseigne" = field(Code);
            }
        }
    }

    actions
    {
        area(processing)
        {

        }
        area(creation)
        {
            action("Créer commande achat STOCK")
            {
                Caption = 'Créer commande achat STOCK';
                ToolTip = 'Créer commande achat STOCK';
                Image = NewWarehouseReceipt;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.CreerCdeAchatStock();
                end;
            }
            action("Créer devis stock")
            {
                Caption = 'Créer devis stock';
                ToolTip = 'Créer devis stock';
                Image = NewWarehouseShipment;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.CreerDevisVenteStock();
                end;
            }
            action("Nouveau chantier")
            {
                Caption = 'Nouveau chantier';
                ToolTip = 'Nouveau chantier';
                Image = WIP;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.CreerNouveauChantier('', Rec."Prefixe chantier"); //On cree un chantier vide, pas depuis un chantier archivé
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
                RunObject = Page InterlocuteursEnseigne;
                RunPageLink = "Code enseigne" = field(Code);
            }
            action(Phases)
            {
                ApplicationArea = All;
                Caption = 'Phases';
                ToolTip = 'Phases';
                Image = JobLines;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "Phases enseigne";
                RunPageLink = "Code enseigne" = field(Code);
            }
            action("Commandes achat STOCK")
            {
                Caption = 'Commandes achat STOCK';
                ToolTip = 'Commandes achat STOCK';
                Image = Receipt;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "Purchase Order List";
                RunPageLink = "Code groupe" = field("Code groupe"),
                              "Code enseigne" = field(Code),
                              "Achat pour stock" = const(true);
                RunPageView = sorting("Code groupe", "Code enseigne", "Code chantier", "Achat pour stock");
            }
            action("Factures achats STOCK")
            {
                Caption = 'Factures achats STOCK';
                ToolTip = 'Factures achats STOCK';
                Image = Purchase;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = false;
                RunObject = Page "Posted Purchase Invoices";
                RunPageLink = "Code groupe" = field("Code groupe"),
                              "Code enseigne" = field(Code),
                              "Achat pour stock" = const(true);
                RunPageView = sorting("Code groupe", "Code enseigne", "Code chantier", "Achat pour stock");
            }
            action("Avoirs achats STOCK")
            {
                Caption = 'Avoirs achats STOCK';
                ToolTip = 'Avoirs achats STOCK';
                Image = CreditMemo;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = false;
                RunObject = Page "Posted Purchase Credit Memos";
                RunPageLink = "Code groupe" = field("Code groupe"),
                              "Code enseigne" = field(Code),
                              "Achat pour stock" = const(true);
                RunPageView = sorting("Code groupe", "Code enseigne", "Code chantier", "Achat pour stock");
            }

            action("Liste Devis STOCK")
            {
                Caption = 'Liste Devis STOCK';
                ToolTip = 'Liste Devis STOCK';
                Image = ListPage;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "Sales Quotes";
                RunPageLink = "Code enseigne" = field(Code),
                              "Devis Stock" = const(true);
            }
            action("OD Chiffre d'affaires")
            {
                Caption = 'OD Chiffre d''affaires';
                ToolTip = 'OD Chiffre d''affaires';
                Image = Balance;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "OD CA Enseigne";
                RunPageLink = "Code enseigne" = field(Code);
                RunPageView = sorting("Code enseigne");
            }
            action("Factures ventes")
            {
                Caption = 'Factures ventes';
                ToolTip = 'Factures ventes';
                Image = Documents;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Posted Sales Invoices";
                RunPageLink = "Code enseigne" = field(Code);
                RunPageView = sorting("Code enseigne");
            }
            action("Avoirs ventes")
            {
                Caption = 'Avoirs ventes';
                ToolTip = 'Avoirs ventes';
                Image = PostedMemo;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Posted Sales Credit Memos";
                RunPageLink = "Code enseigne" = field(Code);
                RunPageView = sorting("Code enseigne");
            }
        }
    }

    procedure Pourcentage(Valeur1: Decimal; Valeur2: Decimal): Decimal
    begin
        if Valeur2 = 0 then
            exit(0)
        else
            exit(Round(Valeur1 / Valeur2 * 100, 1));
    end;
}

