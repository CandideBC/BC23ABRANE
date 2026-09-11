page 50082 "SF Fiche Enseigne"
{
    ApplicationArea = All;
    Caption = 'Chantiers';
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = Chantier;
    SourceTableView = sorting ("Code enseigne", "Chantier archive")
                      where ("Chantier archive" = const (false),
                            Cloture = const (false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; rec.Code)
                {
                    ToolTip = 'Code';
                    Caption = 'Code';
                }
                field("Description chantier"; rec."Description chantier")
                {
                    ToolTip = 'Description chantier';
                    Caption = 'Description chantier';
                    Style = Unfavorable;
                    StyleExpr = Impaye;
                }
                field("Chantier a verifier (>=2020)"; rec."Chantier a verifier (>=2020)")
                {
                    ToolTip = 'Chantier à vérifier (>=2020)';
                    Caption = 'Chantier à vérifier (>=2020)';
                    Visible = false;
                }
                field("Chantier verifie"; Rec."Chantier verifie")
                {
                    ToolTip = 'Chantier vérifié';
                    Caption = 'Chantier vérifié';
                    Visible = false;
                }
                field("Nom chantier"; Rec."Nom chantier")
                {
                    ToolTip = 'Nom chantier';
                    Caption = 'Nom chantier';
                }
                field("Nom chantier 2"; Rec."Nom chantier 2")
                {
                    ToolTip = 'Nom chantier 2';
                    Caption = 'Nom chantier 2';
                    Visible = false;
                }
                field("Adresse chantier"; Rec."Adresse chantier")
                {
                    ToolTip = 'Adresse chantier';
                    Caption = 'Adresse chantier';
                    Visible = false;
                }
                field("Adresse chantier 2"; Rec."Adresse chantier 2")
                {
                    ToolTip = 'Adresse chantier 2';
                    Caption = 'Adresse chantier 2';

                    Visible = false;
                }
                field("Code postal chantier"; Rec."Code postal chantier")
                {
                    ToolTip = 'Code postal chantier';
                    Caption = 'Code postal chantier';
                }
                field("Ville chantier"; Rec."Ville chantier")
                {
                    ToolTip = 'Ville chantier';
                    Caption = 'Ville chantier';
                }
                field("Code pays chantier"; Rec."Code pays chantier")
                {
                    ToolTip = 'Code pays chantier';
                    Caption = 'Code pays chantier';
                }
                field("Contact chantier"; Rec."Contact chantier")
                {
                    ToolTip = 'Contact chantier';
                    Caption = 'Contact chantier';
                }
                field("No. client"; rec."No. client")
                {
                    ToolTip = 'N° client';
                    Caption = 'N° client';
                }
                field("Nom client"; rec."Nom client")
                {
                    ToolTip = 'Nom client';
                    Caption = 'Nom client';
                }
                field("Code postal client"; rec."Code postal client")
                {
                    ToolTip = 'Code postal client';
                    Caption = 'Code postal client';
                    Visible = false;
                }
                field("Ville client"; rec."Ville client")
                {
                    ToolTip = 'Ville client';
                    Caption = 'Ville client';
                    Visible = false;
                }
                field("Statut chantier"; rec."Statut chantier")
                {
                    ToolTip = 'Statut chantier';
                    Caption = 'Statut chantier';
                }
                field("Nombre devis"; rec."Nombre devis")
                {
                    DrillDownPageID = "Sales Quotes";
                    ToolTip = 'Nombre devis';
                    Caption = 'Nombre devis';
                }
                field("Montant factures vente"; rec."Montant factures vente")
                {
                    ToolTip = 'Montant factures vente';
                    Caption = 'Montant factures vente';
                }
                field("Montant avoirs vente"; rec."Montant avoirs vente")
                {
                    ToolTip = 'Montant avoirs vente';
                    Caption = 'Montant avoirs vente';
                }
                field("Montant factures achats"; rec."Montant factures achats")
                {
                    ToolTip = 'Montant factures achats';
                    Caption = 'Montant factures achats';
                }
                field("Montant avoirs achats"; rec."Montant avoirs achats")
                {
                    ToolTip = 'Montant avoirs achats';
                    Caption = 'Montant avoirs achats';
                }
                field("Montant reste a livrer"; rec."Montant reste a livrer")
                {
                    ToolTip = 'Montant reste à livrer';
                    Caption = 'Montant reste à livrer';
                }
                field("Montant livre non facture"; rec."Montant livre non facture")
                {
                    ToolTip = 'Montant livré non facturé';
                    Caption = 'Montant livré non facturé';
                }
                field("Montant sur cdes achats"; rec."Montant sur cdes achats")
                {
                    ToolTip = 'Montant sur cdes achats';
                    Caption = 'Montant sur cdes achats';
                }
                field("Montant recu non facture"; rec."Montant recu non facture")
                {
                    ToolTip = 'Montant reçu non facturé';
                    Caption = 'Montant reçu non facturé';
                }
                field("Date premiere facture vte"; rec."Date premiere facture vte")
                {
                    ToolTip = 'Date première facture vente';
                    Caption = 'Date première facture vente';
                }
                field("Date derniere facture vte"; rec."Date derniere facture vte")
                {
                    ToolTip = 'Date dernière facture vente';
                    Caption = 'Date dernière facture vente';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Fiche chantier")
            {
                Caption = 'Fiche chantier';
                ToolTip = 'Fiche chantier';
                RunObject = Page "Fiche chantier";
                RunPageLink = Code = field (Code);
            }
            action(NouvDevisVente)
            {
                Caption = 'Créer devis vente';
                ToolTip = 'Créer devis vente';
                trigger OnAction()
                begin
                    Rec.CreerDocumentVente(0);
                end;
            }
            action(NouvCdeAchat)
            {
                Caption = 'Créer commande achat';
                ToolTip = 'Créer commande achat';
                Visible = true;

                trigger OnAction()
                begin
                    Rec.CreerCdeAchat();
                end;
            }
            action(NouvCdeVente)
            {
                Caption = 'Créer commande vente';
                ToolTip = 'Créer commande vente';

                trigger OnAction()
                begin
                    Rec.CreerDocumentVente(1);
                end;
            }
            action("Ecritures client")
            {
                Caption = 'Ecritures client';
                ToolTip = 'Ecritures client';
                RunObject = Page "Customer Ledger Entries";
                RunPageLink = "Code chantier" = field (Code);
                RunPageView = sorting ("Code chantier", "Document Type", Open, "Due Date");
            }
            action("Etiquettes palettes")
            {
                Caption = 'Etiquettes palettes';
                ToolTip = 'Etiquettes palettes';
                Image = SuggestItemCost;
                //Promoted = true;
                //PromotedCategory = "Report";
                //PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.AfficherEtiquettePalette();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Impaye := Rec.FactureImpayee();
    end;

    var
        Impaye: Boolean;
}

