pageextension 50126 OrderProcessorRCExtension extends "Order Processor Role Center"
{
    layout
    {

        addafter("User Tasks Activities")
        {
            part(MesChantiers; "Mes chantiers")
            {

            }

        }
        addfirst(rolecenter)
        {
            part(ActivitesBE; "Piles BE")
            {

            }
            part(ActivitesCompta; ActivitesCompta)
            {

            }
        }
    }

    actions
    {
        addfirst(sections)
        {
            group(Affaires)
            {
                Caption = 'Affaires';
                action(Enseignes)
                {
                    Caption = 'Enseignes';
                    RunObject = page "Enseignes";
                    ToolTip = 'Enseignes';
                }
                action(Chantiers)
                {
                    Caption = 'Chantiers';
                    RunObject = page "Liste des chantiers";
                    ToolTip = 'Chantiers';
                }
                action(Groupes)
                {
                    Caption = 'Groupes';
                    RunObject = page "Liste groupes";
                    ToolTip = 'Groupes';
                }
            }
            group(Projets)
            {
                Caption = 'Projets';
                action(Clients)
                {
                    Caption = 'Clients';
                    RunObject = page "Customer List";
                    Tooltip = 'Clients';
                }
            }
            group(BE)
            {
                Caption = 'BE';
                action(FichesBE)
                {
                    Caption = 'Gestion par chantier';
                    RunObject = page "Liste dossiers BE";
                    Tooltip = 'Liste des dossiers BE';
                }
                action(LignesBE)
                {
                    Caption = 'Gestion par lignes';
                    RunObject = page "Liste fiches BE";
                    Tooltip = 'Liste des fiches BE';
                }

                action(ArchivesBE)
                {
                    Caption = 'Dossiers archivés';
                    RunObject = page "Liste dossiers BE archives";
                    Tooltip = 'Liste des dossiers BE archivés';
                }
            }
            group(ImportExport)
            {
                Caption = 'Import/Export';
                action(CommandesExport)
                {
                    Caption = 'Commandes export';
                    Tooltip = 'Commandes export';
                    RunObject = page "Commandes ventes Export";
                }
                action(MntAAChargerParSemParFns)
                {
                    Caption = 'Semainier chargement';
                    Tooltip = 'Affiche le montant restant à charger par semaine et par fns';
                    RunObject = page "Semainier chargement import";
                }
                /*
                action(SuiviContainer)
                {
                    Caption = 'Commandes achats à traiter';
                    RunObject = page "Cdes achats container a faire";
                    ToolTip = 'Commandes achats à traiter';
                }
                */
                action(ContainersTous)
                {
                    Caption = 'Containers (Tous)';
                    RunObject = page "Liste containers";
                    ToolTip = 'Containers (Tous)';
                }
                action(ContainersEnCours)
                {
                    Caption = 'Containers en cours';
                    RunObject = page "Liste containers";
                    RunPageView = sorting("Statut container") where("statut container" = const("En cours"));
                    ToolTip = 'Containers (Tous)';
                }
                action(ContainersReceptionnes)
                {
                    Caption = 'Containers réceptionnés';
                    RunObject = page "Liste containers";
                    RunPageView = sorting("Statut container") where("statut container" = const(Réceptionné));
                    ToolTip = 'Containers réceptionnés';
                }
                action(ContainersArchives)
                {
                    Caption = 'Containers archivés';
                    RunObject = page "Liste containers";
                    RunPageView = sorting("Statut container") where("statut container" = const(Archivé));
                    ToolTip = 'Containers archivés';
                }

                action(ResteAAffecterContainer)
                {
                    Caption = 'Reste à affecter à container';
                    RunObject = page "Reste à affecter container";
                    ToolTip = 'Reste à affecter à container';
                }

                action(ControleCodeDouanier)
                {
                    Caption = 'Contrôle code douanier';
                    RunObject = page "Ctrl. code douanier/Achat DIV";
                    ToolTip = 'Contrôle code douanier';
                }

                action(SuiviSAVFournisseur)
                {
                    Caption = 'Suivi SAV Fournisseur';
                    RunObject = page "Suivi SAV Fournisseur";
                    ToolTip = 'Suivi SAV Fournisseur';
                }

                action(DEB)
                {
                    Caption = 'DEB';
                    RunObject = page "Liste DEB";
                    ToolTip = 'DEB';
                }
                action(Pays)
                {
                    Caption = 'Pays';
                    RunObject = page "Countries/Regions";
                    ToolTip = 'Pays';
                }

            }

            group(Logistique)
            {

                action(TBL)
                {
                    Caption = 'TBL';
                    RunObject = page "Tableau logistique";
                    Tooltip = 'TBD';
                }
                action(TachesLogistiques)
                {
                    Caption = 'Tâches logistiques';
                    RunObject = page "Liste taches logistiques";
                    Tooltip = 'Affiche la liste des tâches logistiques à réaliser';
                }
                /*
                action(CommandesAPreparer)
                {
                    Caption = 'Commandes à préparer';
                    RunObject = page "Liste saisie expedition";
                    Tooltip = 'Commandes à préparer';
                }
                action(UnitesColisage)
                {
                    Caption = 'Unités de colisages';
                    RunObject = page "Liste unites colisage";
                    Tooltip = 'Liste des unités de colisage';
                }
                */

                action(Colisages)
                {
                    Caption = 'Colisages';
                    RunObject = page "Liste colisages";
                    RunPageView = order(descending);
                    Tooltip = 'Liste des colisages';
                }

            }
            group(Comptabilite)
            {
                Caption = 'Comptabilité';
                action(PlanComptable)
                {
                    Caption = 'Plan comptable';
                    RunObject = page "Chart of Accounts";
                    Tooltip = 'Plan comptable';
                }
            }
        }
        moveafter(Logistique; Action62) //Volet "Stocks"
        moveafter(Clients; "Sales Quotes", "Sales Orders", Vendors, "Purchase Orders")
        addafter(Vendors)
        {
            action(CommandesCadresAchats)
            {
                ApplicationArea = All;
                Caption = 'Commandes cadres achats';
                ToolTip = 'Commandes cadres achats';
                RunObject = page "Blanket Purchase Orders";
            }
        }
        movebefore(PlanComptable; "Purchase Invoices", "Purchase Credit Memos", "Purchase Return Orders", "Sales Invoices", "Sales Return Orders", "Sales Credit Memos")
        moveafter(Comptabilite; "Posted Documents")

        modify(Action76) //Sales - Ventes
        {
            Visible = false;
        }
        movefirst("Posted Documents"; "Sales Quote Archive", "Sales Order Archive", "Posted Sales Shipments")

        addafter("Posted Sales Shipments")
        {
            action(BLRemisEnStock)
            {
                ApplicationArea = All;
                Caption = 'BL remis en stock';
                ToolTip = 'BL remis en stock';
                RunObject = page BLRemisEnStock;
                //RunPageView = where("Remis en stock depuis BL"=const(true));

            }
        }

        modify("Posted Transfer Receipts")
        {
            Visible = false;
        }
        modify("Posted Transfer Shipments")
        {
            Visible = false;
        }

        modify("Posted Documents") //Marche pas
        {
            Caption = 'Archives';

        }


        modify(Action63) //Purchases - Achats
        {
            Visible = false;
        }

        addafter("Sales Orders")
        {
            action(DevisTypes)
            {
                Caption = 'Devis types';
                RunObject = page "Standard Sales Codes";
                ToolTip = 'Devis types';
            }
        }

        addafter("Purchase Orders")
        {
            action(CommandesAchatsTypes)
            {
                Caption = 'Commandes achats types';
                RunObject = page "Standard Purchase Codes";
                ToolTip = 'Commandes achats types';
            }

            action("SupprimerDocumentsFactures")
            {
                ApplicationArea = all;
                Caption = 'Supprimer commandes facturées';
                ToolTip = 'Supprimer commandes achats et ventes complètement facturées.';
                Image = Delete;
                RunObject = codeunit SupprimerCommandesFacturees;
            }
        }
        modify("Assembly Orders")
        {
            Visible = false;
        }
        modify("Drop Shipments")
        {
            Visible = false;
        }
        modify("Sales Orders - Microsoft Dynamics 365 Sales")
        {
            Visible = false;
        }

        modify("Blanket Sales Orders")
        {
            Visible = false;
        }
        modify("Sales Journals")
        {
            Visible = false;
        }
        modify("Sales &Journal")
        {
            Visible = false;
        }
        modify(SalesJournals)
        {
            Visible = false;
        }
        modify(CashReceiptJournals)
        {
            Visible = false;
        }
        modify(Reminders)
        {
            Visible = false;
        }
        modify("Finance Charge Memos")
        {
            Visible = false;
        }
        modify("Blanket Purchase Orders")
        {
            Visible = false;
        }
        modify(PurchaseJournals)
        {
            Visible = false;
        }
        modify("Purchase Quotes")
        {
            Visible = false;
        }
        modify("Item Attributes")
        {
            Visible = false;
        }
        modify("Item Charges")
        {
            Visible = false;
        }
        modify("Item Tracking")
        {
            Visible = false;
        }
        modify("Issued Finance Charge Memos")
        {
            Visible = false;
        }
        modify("Issued Reminders")
        {
            Visible = false;
        }
        modify("Blanket Sales Order Archives")
        {
            Visible = false;
        }
        modify("Sales Return Order Archives")
        {
            Visible = false;
        }


        addafter(Locations)
        {
            action(CreationArticle102)
            {
                RunObject = page "Saisie article 102";
                Caption = 'Création article 102';
            }
            action(CreationArticleNomenclature)
            {
                RunObject = page "Saisie article nomenclature";
                Caption = 'Création article nomenclaturé';
            }

            action(Valorisation)
            {
                RunObject = page Stock;
                Caption = 'Valorisation';
            }
            action("Supprimer articles annulés")
            {
                ApplicationArea = All;
                //Promoted = true;
                //PromotedCategory = Category8;
                RunObject = report "Supprimer Articles ANNULE";
                ToolTip = 'Supprime tous les articles dont le champ [Ref. client] vaut ANNULE';
                Image = Delete;
            }
        }

        //movebefore("Posted Sales Invoices";"Sales Quote Archive","Sales Order Archive","Posted Sales Shipments")


    }

}