page 50023 "Fiche colisage"
{
    UsageCategory = Documents;
    ApplicationArea = All;
    Caption = 'Fiche colisage';

    InsertAllowed = false;
    PageType = ListPlus;
    Permissions = TableData "Sales Line" = rm,
                  TableData "Sales Shipment Line" = rm;
    SourceTable = "Entete colisage";

    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'Général';
                field("No."; Rec."No.")
                {
                    ToolTip = 'N°';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'N° donneur d''ordre';
                }
                field("No. expedition enregistree"; Rec."No. expedition enregistree")
                {
                    ApplicationArea = All;
                    ToolTip = 'N° expédition enregistrée';
                }

                field("No. commande"; Rec."No. commande")
                {
                    ToolTip = 'N° commande';
                }
                field(Phase; Rec.Phase)
                {
                    ApplicationArea = All;
                    ToolTip = 'Phase';
                }
                field("Description phase"; Rec."Description phase")
                {
                    ApplicationArea = All;
                    ToolTip = 'Description de la phase';
                }
                

                field("Range No."; Rec."Range No.")
                {
                    ToolTip = 'Range No.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'N° doc. externe';
                }
                field("Ship-To Address Code"; Rec."Ship-To Address Code")
                {
                    ToolTip = 'Code destinataire';
                }
                field("Ship-To Name"; Rec."Ship-To Name")
                {
                    ToolTip = 'Nom destinataire';
                }
                field("Ship-To Address"; Rec."Ship-To Address")
                {
                    ToolTip = 'Adresse destinataire';
                }
                field("Ship-To Address 2"; Rec."Ship-To Address 2")
                {
                    ToolTip = 'Adresse destinataire 2';
                }
                field("Ship-To Post Code"; Rec."Ship-To Post Code")
                {
                    ToolTip = 'Code postal destinataire';
                }
                field("Ship-To City"; Rec."Ship-To City")
                {
                    ToolTip = 'Ville destinataire';
                }
                field("Ship-To Country Code"; Rec."Ship-To Country Code")
                {
                    ToolTip = 'Code pays destinataire';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'N° téléphone';
                }

                field(Email; Rec.Email)
                {
                    ToolTip = 'E-Mail';
                }

                field(Destination; Rec.Destination)
                {
                    ToolTip = 'Destination';
                }
                field("Nombre de colis"; Rec."Nombre de colis")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre de colis';
                }

                field("Nombre de palettes"; Rec."Nombre de palettes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre de palettes';
                }
                field("Nb UC"; Rec."Nb UC")
                {
                    ToolTip = 'Nombre UC';
                }
                field("Poids net total articles"; Rec."Poids net total articles")
                {
                    ApplicationArea = All;
                    ToolTip = 'Somme des poids nets des articles présents dans le colisage';
                }

                field("Poids brut non colise"; Rec."Poids brut non colise")
                {
                    ApplicationArea = All;
                    ToolTip = 'Si vous ne voulez/pouvez pas peser chaque UC du colisage, ce champ permet de saisir le poids total brut du colisage.';
                }

                field("Poids brut total colise"; Rec."Poids brut total colise")
                {
                    ToolTip = 'Somme des poids bruts des colis et palettes du colisage.';
                }
                field("Poids net total colise"; Rec."Poids net total colise")
                {
                    ToolTip = 'Poids net total';
                }


                field("Packing Status"; Rec."Packing Status")
                {
                    ToolTip = 'Statut colisage';
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ToolTip = 'Date création';
                }
                field("Code transporteur"; Rec."Code transporteur")
                {
                    ToolTip = 'Code transporteur';
                }

                field("Date comptabilisation"; Rec."Date comptabilisation")
                {
                    ToolTip = 'Date comptabilisation';
                }
                field("Commentaire validation"; Rec."Commentaire validation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indique le message d''erreur lorsque le BL ne peut pas être généré.';
                }
                
            }
            part(UC; "SF Ligne Colisage")
            {
                SubPageLink = "No. colisage" = field("No.");
                SubPageView = sorting("No. colisage", "No. UC");

            }
            part(ContenuUC; "SF Contenu colisage")
            {
                SubPageLink = "No. colisage" = field("No.");
            }

        }
    }

    actions
    {
        area(processing)
        {
            group("&Validation")
            {
                Caption = 'Posting';
                action("Valider")
                {
                    Caption = 'Valider';
                    ToolTip = 'Valider';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        Rec.CheckPacking();
                    end;
                }
            }
            group("Fonction&s")
            {
                Caption = 'F&unctions';
                action("R&ouvrir")
                {
                    Caption = 'Rouvrir';
                    ToolTip = 'Rouvrir';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Rec.Reopen();
                        CurrPage.Update();
                    end;
                }
                action(Expedier)
                {
                    Caption = 'Expédier';
                    ToolTip = 'Permet de générer le BL pour chaque commande présente dans le colisage.';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Rec.Expedier();
                    end;
                }
                action(ExtraireColisage)
                {
                    Caption = 'Extraire colisage';
                    ToolTip = 'Permet d''ajouter le contenu d''un autre colisage à ce colisage (le colisage extrait sera supprimé).';
                    Image = GetLines;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Rec.ExtraireColisage();
                    end;
                }


                action(CalculerPoids)
                {
                    Caption = 'Calculer poids';
                    ToolTip = 'Va répartir le poids brut total sur les articles pour obtenir un poids brut unitaire de chaque article.';
                    Image = Calculate;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Rec.TestField("Packing Status", 0);
                        Rec.MAJPoidsSurContenuColisage();
                    end;
                }

            }
        }
        area(reporting)
        {
            action("Edition Liste de colisage")
            {
                Caption = 'Edition liste de colisage';
                ToolTip = 'Edition liste de colisage';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    EnteteColisage: Record "Entete colisage";
                begin
                    Rec.TestField("Packing Status", Rec."Packing Status"::"Terminé");
                    EnteteColisage.SetRange("No.", Rec."No.");
                    REPORT.RunModal(50032, true, true, EnteteColisage);
                end;
            }
            action("Edition étiquette livraison")
            {
                Caption = 'Edition étiquette livraison';
                ToolTip = 'Edition étiquette livraison';
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    EnteteColisage: Record "Entete colisage";
                begin
                    Rec.TestField("Packing Status", Rec."Packing Status"::"Terminé");
                    EnteteColisage.SetRange("No.", Rec."No.");
                    REPORT.RunModal(50030, true, true, EnteteColisage);
                end;
            }
            action("Edition Détail Palette")
            {
                Caption = 'Edition détail palette';
                ToolTip = 'Edition détail palette';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                var
                    EnteteColisage: Record "Entete colisage";
                begin
                    Rec.TestField("Packing Status", Rec."Packing Status"::"Terminé");
                    EnteteColisage.SetRange("No.", Rec."No.");
                    REPORT.RunModal(50031, true, true, EnteteColisage);
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."No." := '';
        Rec.Reset();
        Rec.Init();
        Rec.Validate("Sell-to Customer No.", Rec.GetFilter(Rec."Sell-to Customer No."));
        //Rec.Validate("Bill-To Customer No.", Rec.GetFilter(Rec."Bill-To Customer No."));
    end;

}

