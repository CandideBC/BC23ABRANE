page 50095 "Cdes achats container a faire"
{
    CardPageID = "Purchase Order";
    UsageCategory = Lists;
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Purchase Header";
    SourceTableView = sorting("Document Type", "Suivi container", "Suivi container OK")
                      where("Document Type" = const(Order),
                            "Suivi container" = const(true),
                            "Suivi container OK" = const(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ToolTip = 'N°';
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    Editable = false;
                    ToolTip = 'N° preneur d''ordre';
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    Editable = false;
                    ToolTip = 'Nom preneur d''ordre';
                }
                field("Buy-from City"; Rec."Buy-from City")
                {
                    Editable = false;
                    ToolTip = 'Ville preneur d''ordre';
                }
                field("Buy-from Country/Region Code"; Rec."Buy-from Country/Region Code")
                {
                    Editable = false;
                    ToolTip = 'Code pays preneur d''ordre';
                }
                field("Order Date"; Rec."Order Date")
                {
                    Editable = false;
                    ToolTip = 'Date commande';
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ToolTip = 'Code acheteur';
                }
                field(Commentaires; Rec.Commentaires)
                {
                    Editable = false;
                    ToolTip = 'Commentaires';
                }
                field("Commentaires pour AIE"; Rec."Commentaires pour AIE")
                {
                    ToolTip = 'Commentaires pour AIE';
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    Editable = false;
                    ToolTip = 'Date réception demandée';
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                    Editable = false;
                    ToolTip = 'Date réception confirmée';
                }
                field("Date intention chargement"; Rec."Date intention chargement")
                {
                    Caption = 'Date intention chargement';
                    ToolTip = 'Date intention chargement';
                    Editable = false;

                }
                field("Date chargement confirmee";Rec."Date chargement confirmee")
                {
                    Caption = 'Date chargement confirmée';
                    ToolTip = 'Date chargement confirmée';
                    Editable = false;

                }
                field("Semaine chargement"; Rec."Semaine chargement")
                {
                    BlankZero = true;
                    ToolTip = 'Semaine chargement';
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    Editable = false;
                    ToolTip = 'Date réception prévue';
                }
                field("Semaine reception prevue"; Rec."Semaine reception prevue")
                {
                    BlankZero = true;
                    ToolTip = 'Semaine réception prévue';
                }
                field(MontantRestantACharger; MontantRestantACharger)
                {
                    Caption = 'Montant reste à charger';
                    ToolTip = 'Montant reste à charger';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(Fiche)
            {
                Caption = 'Fiche';
                ToolTip = 'Fiche';
                Image = DocumentEdit;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Purchase Order";
                RunPageLink = "Document Type" = field("Document Type"),
                              "No." = field("No.");
            }
        }
        area(processing)
        {
            action("Pousser vers container")
            {
                Caption = 'Pousser vers container';
                ToolTip = 'Pousser vers container';
                Image = CreateWarehousePick;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //KAN.FHA 01/03/2023
                    //Avant on ouvrait (par RunObject) la page "Pousser vers container" et l'utilisateur pouvait cliquer sur "Remplir qtés vers container"
                    //Maintenant on va remplir les quantités vers container automatiquement avant d'ouvrir cette page.
                    Rec.RemplirQuantiteVersContainer();
                    Commit();
                    EnteteAchat.SetRange("Document Type", Rec."Document Type");
                    EnteteAchat.SetRange("No.", Rec."No.");
                    PAGE.Run(PAGE::"Pousser achat vers container", EnteteAchat);
                end;
            }
            action("Supprimer cdes achats facturées")
            {
                Caption = 'Supprimer cdes achats facturées';
                ToolTip = 'Supprimer cdes achats facturées';
                Image = CancelAllLines;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Report "Delete Invoiced Purch. Orders";
            }
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
            action("Montant à charger par semaine")
            {
                Caption = 'Montant à charger par semaine';
                ToolTip = 'Montant à charger par semaine';
                Image = CalendarWorkcenter;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    //StatParSemaine: Record "Tampon reste a charger par sem";
                    PageListeSemaine: Page "Planning chargement par sem.";
                    //txtFiltreSemaine: Text[50];
                    //MettreFiltreSemaineMsg: Label 'Vous devez mettre un filtre sur le N° de semaine de chargement.';

                begin
                    //On profite de cette action pour mettre à jour un champ sur toutes les lignes de commandes d'achat suivies en containers
                    //On part du principe qu'on passe par ici plusieurs fois par jour et que c'est le bon moment pour recalculer ce champ.
                    //Ce champ [Complement chargee] (O/N) permet de savoir si une commande a été completement chargee ou non. On se base sur la quantite de chaque ligne car le montant restant à charger
                    //pouvait être de zéro alors qu'on avait encore des articles à charger (gratuits, SAV...).
                    Rec.MAJCompletementChargee();
                    COMMIT();

                    //Maintenant on va calculer le montant restant à charger par semaine pour la plage de semaines de chargement filtrée
                    //txtFiltreSemaine := Copystr(Rec.GetFilter("Semaine chargement"),1,50);
                    //if txtFiltreSemaine <> '' then begin
                        //KAN.FHA 07/05/2026 DEBUT
                        //Rec.CalculerResteAChargerParSemParFns(txtFiltreSemaine);
                        Codeunit.Run(Codeunit::CalculerMontantACharger);
                        //KAN.FHA 07/05/2026 FIN
                        Commit();
                        Clear(PageListeSemaine);
                        /*
                        StatParSemaine.Reset();
                        StatParSemaine.FilterGroup(2);
                        StatParSemaine.SetRange("Code utilisateur", UserId);
                        StatParSemaine.FilterGroup(0);
                        PageListeSemaine.SetTableView(StatParSemaine);
                        */
                        PageListeSemaine.Run();

                    //end else
                    //    Message(MettreFiltreSemaineMsg);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
        begin
        Rec.CalcValeursResteACharger(MontantRestantACharger,PoidsNetACharger,LignesSansCout,NbDIVSansHSCode,NbLignesSansPoids);
    end;

    var
        EnteteAchat: Record "Purchase Header";
        MontantRestantACharger: Decimal;
        PoidsNetACharger: Decimal;
        LignesSansCout:Integer;
        NbDIVSansHSCode: Integer;
        NbLignesSansPoids: Integer;

}

