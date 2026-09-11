page 50044 "SF TBL Phases a preparer"
{
    ApplicationArea = All;
    Caption = 'Expéditions';
    PageType = ListPart;
    SourceTable = "Phases document";
    SourceTableView = sorting("Type document", "Date semaine chargement") where("Type document" = const(Order));
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("No. commande"; Rec."No. document")
                {
                    Caption = 'N° commande';
                    ToolTip = 'N° commande';
                    Editable = false;
                    trigger OnDrillDown()
                    begin
                        OuvrirFicheSaisieExpe();
                    end;
                }

                field("No. doc externe"; Rec."No. doc externe")
                {
                    ApplicationArea = All;
                    ToolTip = 'N° doc. externe';
                    Editable = false;
                }



                field(PctPrepaSurStock; PctPrepaSurStock)
                {
                    ApplicationArea = All;
                    Caption = '% prépa / stock';
                    ToolTip = '% prépa / stock';
                    BlankZero = true;
                    DecimalPlaces = 0 : 0;
                    Editable = false;
                }


                field(NbArticlesAPreparer; NbArticlesAPreparer)
                {
                    ApplicationArea = All;
                    Caption = 'Nb articles à préparer';
                    ToolTip = 'Nb articles à préparer';
                    BlankZero = true;
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                }


                field(PctExpedie; PctExpedie)
                {
                    ApplicationArea = All;
                    Caption = '% expédié';
                    BlankZero = true;
                    DecimalPlaces = 0 : 0;
                    ToolTip = '% expédié';
                    Editable = false;
                }

                field("Completely Shipped"; EnteteVente."Completely Shipped")
                {
                    ApplicationArea = All;
                    Caption = 'Complètement expédiée';
                    ToolTip = 'Complètement expédiée';
                    Editable = false;
                }
                field(Commentaire; EnteteVente.Commentaire)
                {
                    ApplicationArea = All;
                    ToolTip = 'Commentaire';
                    Editable = false;
                }

                field(CompterCdesAchatsLiees; Rec.CompterCdesAchatsLiees())
                {
                    Caption = 'Nb cdes achats';
                    ToolTip = 'Indique combien de commandes d''achats sont liées aux articles de cette phase.';
                }
                field("Prepa finie"; EnteteVente."Prepa finie")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indique si la préparation de commande est finie';
                    trigger OnValidate()
                    var
                        EnteteCommande: Record "Sales Header";
                    begin
                        if EnteteCommande.Get(Rec."Type document", Rec."No. document") then begin
                            EnteteCommande."Prepa finie" := EnteteVente."Prepa finie";
                            EnteteCommande.Modify();
                        end;
                    end;
                }
                field("Commentaire factu."; Rec."Commentaire factu.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Commentaire factu.';
                }
                field("Facturation en compta (O/N)"; EnteteVente."Facturation en compta (O/N)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Facturation en compta (O/N)';
                    trigger OnValidate()
                    var
                        EnteteCommande: Record "Sales Header";
                    begin
                        if EnteteCommande.Get(Rec."Type document", Rec."No. document") then begin
                            EnteteCommande."Facturation en compta (O/N)" := EnteteVente."Facturation en compta (O/N)";
                            EnteteCommande.Modify();
                        end;
                    end;
                }
                field("Nombre phases"; EnteteVente."Nombre phases")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre de phases';
                }
                field("Date chargement"; EnteteVente."Date chargement")
                {
                    ToolTip = 'Date de chargement';
                    //Editable = false;
                }
                field("Requested Delivery Date"; EnteteVente."Requested Delivery Date")
                {
                    Caption = 'Date livraison demandée';
                    ToolTip = 'Date de livraison demandée';
                }
                field("Ship-to Name"; EnteteVente."Ship-to Name")
                {
                    Caption = 'Nom destinataire';
                    ToolTip = 'Nom du destinataire';
                }
                field("Ship-to Name 2"; EnteteVente."Ship-to Name 2")
                {
                    Caption = 'Nom destinataire 2';
                    ToolTip = 'Nom du destinataire 2';
                    Visible = false;
                }
                field("Ship-to Address"; EnteteVente."Ship-to Address")
                {
                    Caption = 'Adresse destinataire';
                    ToolTip = 'Adresse du destinataire';
                }
                field("Ship-to Address 2"; EnteteVente."Ship-to Address 2")
                {
                    Caption = 'Adresse destinataire 2';
                    ToolTip = 'Adresse 2 du destinataire';
                }

                field("Ship-to Post Code"; EnteteVente."Ship-to Post Code")
                {
                    Caption = 'Code postal destinataire';
                    ToolTip = 'Code postal du destinataire';
                }
                field("Ship-to City"; EnteteVente."Ship-to City")
                {
                    Caption = 'Ville destinataire';
                    ToolTip = 'Ville du destinataire';
                }
                field("Ship-to Country/Region Code"; EnteteVente."Ship-to Country/Region Code")
                {
                    ApplicationArea = All;
                    Caption = 'Code pays destinataire';
                    ToolTip = 'Code pays destinataire';
                }

                field("Nombre de colis"; EnteteVente."Nombre de colis")
                {
                    ToolTip = 'Nombre de colis';
                }
                field("Nombre de palettes"; EnteteVente."Nombre de palettes")
                {
                    ToolTip = 'Nombre de palettes';

                }
                field("Total Net Weight"; EnteteVente."Total Net Weight")
                {
                    Caption = 'Poids net total';
                    ToolTip = 'Poids net total';
                    Editable = false;
                }
                field("Poids brut total"; EnteteVente."Poids brut total")
                {
                    ToolTip = 'Poids brut total';
                }
                field(Phase; Rec.Phase)
                {
                    ApplicationArea = All;
                    ToolTip = 'Phase';
                }
            }
        }

    }
    actions
    {
        area(Processing)
        {
            action(OuvrirFicheExp)
            {
                Caption = 'Fiche expé';
                ToolTip = 'Ouvrir la fiche de préparation (généralement avant de générer le BL)';
                Image = RegisterPick;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    OuvrirFicheSaisieExpe();
                end;
            }

            action(ImprimerBP)
            {
                Caption = 'Imprimer BP';
                ToolTip = 'Imprimer le bon de préparation';
                Image = Print;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Message('Ceci est le bouton qui ne fait rien, vous l''avez trouvé, bravo !');
                end;
            }

            action(AfficherUC)
            {
                Caption = 'Palettes/Colis';
                ToolTip = 'Permet d''afficher ou définir les palettes et colis nécessaires à la préparation de cette commande.';
                Image = Track;
                trigger OnAction()
                var
                    UCCommande: Record "UC Commande";
                    PageUCCommande: page "UC Commande";
                begin
                    Clear(PageUCCommande);

                    UCCommande.setrange("No. commande", Rec."No. document");
                    PageUCCommande.SetTableView(UCCommande);
                    PageUCCommande.Run();
                end;
            }
            action(SuiviAchats)
            {
                ApplicationArea = All;
                Caption = 'Suivi achats';
                ToolTip = 'Affiche la liste des commandes achats passées pour cette commande.';
                Image = OrderPromising;

                trigger OnAction()
                var
                    EnteteCommande: Record "Sales Header";
                begin
                    EnteteCommande.Get(Rec."Type document", Rec."No. document");
                    EnteteCommande.EtablirSuiviAchats();
                    Page.Run(Page::SuiviAchatsParDocVente);
                end;
            }
            action(ComparerVersions)
            {
                ApplicationArea = All;
                Caption = 'Comparer versions';
                ToolTip = 'Comparer deux versions';
                Image = CompareCost;

                trigger OnAction()
                var
                    EnteteCommande: Record "Sales Header";
                    ComparaisonPage: Page ComparaisonVersionsDocVente;
                    AuMoinsDeuxArchivesErr: Label 'Il faut qu''il y ait au moins deux versions archivées pour les comparer. Les versions sont archivées en imprimant et à condition que le montant total varie.';
                begin
                    EnteteCommande.Get(Rec."Type document", Rec."No. document");
                    EnteteCommande.CalcFields("No. of Archived Versions");
                    if EnteteCommande."No. of Archived Versions" < 2 then
                        error(AuMoinsDeuxArchivesErr);
                    Clear(ComparaisonPage);
                    ComparaisonPage.DefFiltreDocVente(Rec."Type document", Rec."No. document");
                    ComparaisonPage.Run();
                end;
            }
        }
    }
    var
        EnteteVente: Record "Sales Header";
        PctPrepaSurStock: Decimal;
        NbArticlesAPreparer: Decimal;
        PctExpedie: Decimal;

    procedure OuvrirFicheSaisieExpe()
    var
        EnteteCommande: Record "Sales Header";
        FicheSaisieExpe: page "Fiche saisie expedition";
    begin
        EnteteCommande.SetRange("Document Type", Rec."Type document");
        EnteteCommande.SetRange("No.", Rec."No. document");
        if EnteteCommande.FindSet(false) then begin
            FicheSaisieExpe.SetTableView(EnteteCommande);
            Clear(FicheSaisieExpe);
            FicheSaisieExpe.Run();
        end;
    end;

    procedure OuvrirFicheCommande()
    var
        EnteteCommande: Record "Sales Header";
        FicheCommande: page "Sales Order";
    begin
        EnteteCommande.SetRange("Document Type", Rec."Type document");
        EnteteCommande.SetRange("No.", Rec."No. document");
        FicheCommande.SetTableView(EnteteCommande);
        Clear(FicheCommande);
        FicheCommande.Run();
    end;

    trigger OnAfterGetRecord()
    begin
        if not EnteteVente.get(Rec."Type document", Rec."No. document") then
            EnteteVente.Init();
    end;
}
