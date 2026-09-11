page 50086 "SF Enseigne-Chantiers clotures"
{
    ApplicationArea = All;
    Caption = 'Chantiers clôturés';
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = Chantier;
    SourceTableView = sorting ("Code enseigne", Cloture)
                      where (Cloture = const (true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Code';
                }
                field("Description chantier"; Rec."Description chantier")
                {
                    ToolTip = 'Description chantier';
                    Style = Unfavorable;
                    StyleExpr = Impaye;
                }
                field("Chantier a verifier (>=2020)"; Rec."Chantier a verifier (>=2020)")
                {
                    ToolTip = 'Chantier à vérifier (>=2020)';
                }
                field("Chantier verifie"; Rec."Chantier verifie")
                {
                    ToolTip = 'Chantier vérifié';
                }
                field("Nom chantier"; Rec."Nom chantier")
                {
                    ToolTip = 'Nom chantier';
                }
                field("Nom chantier 2"; Rec."Nom chantier 2")
                {
                    ToolTip = 'Nom chantier 2';
                    Visible = false;
                }
                field("Adresse chantier"; Rec."Adresse chantier")
                {
                    ToolTip = 'Adresse chantier';
                    Visible = false;
                }
                field("Adresse chantier 2"; Rec."Adresse chantier 2")
                {
                    ToolTip = 'Adresse chantier 2';
                    Visible = false;
                }
                field("Code postal chantier"; Rec."Code postal chantier")
                {
                    ToolTip = 'Code postal chantier';
                }
                field("Ville chantier"; Rec."Ville chantier")
                {
                    ToolTip = 'Ville chantier';
                }
                field("Code pays chantier"; Rec."Code pays chantier")
                {
                    ToolTip = 'Code pays chantier';
                }
                field("Contact chantier"; Rec."Contact chantier")
                {
                    ToolTip = 'Contact chantier';
                }
                field("No. client"; Rec."No. client")
                {
                    ToolTip = 'N° client';
                }
                field("Nom client"; Rec."Nom client")
                {
                    ToolTip = 'Nom client';
                }
                field("Code postal client"; Rec."Code postal client")
                {
                    ToolTip = 'Code postal client';
                    Visible = false;
                }
                field("Ville client"; Rec."Ville client")
                {
                    ToolTip = 'Ville client';
                    Visible = false;
                }
                field("Statut chantier"; Rec."Statut chantier")
                {
                    ToolTip = 'Statut chantier';
                }
                field("Nombre devis"; Rec."Nombre devis")
                {
                    ToolTip = 'Nombre devis';
                    DrillDownPageID = "Sales Quotes";
                }
                field("Montant factures vente"; Rec."Montant factures vente")
                {
                    ToolTip = 'Montant factures vente';
                }
                field("Montant avoirs vente"; Rec."Montant avoirs vente")
                {
                    ToolTip = 'Montant avoirs vente';
                }
                field("Montant factures achats"; Rec."Montant factures achats")
                {
                    ToolTip = 'Montant factures achats';
                }
                field("Montant avoirs achats"; Rec."Montant avoirs achats")
                {
                    ToolTip = 'Montant avoirs achats';
                }
                field("Montant reste a livrer"; Rec."Montant reste a livrer")
                {
                    ToolTip = 'Montant reste à livrer';
                }
                field("Montant livre non facture"; Rec."Montant livre non facture")
                {
                    ToolTip = 'Montant livré non facturé';
                }
                field("Montant sur cdes achats"; Rec."Montant sur cdes achats")
                {
                    ToolTip = 'Montant sur cdes achats';
                }
                field("Montant recu non facture"; Rec."Montant recu non facture")
                {
                    ToolTip = 'Montant reçu non facturé';
                }
                field("Date premiere facture vte"; Rec."Date premiere facture vte")
                {
                    ToolTip = 'Date première facture vente';
                }
                field("Date derniere facture vte"; Rec."Date derniere facture vte")
                {
                    ToolTip = 'Date dernière facture vente';
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
            action("Ecritures client")
            {
                Caption = 'Ecritures client';
                Tooltip = 'Ecritures client';
                RunObject = Page "Customer Ledger Entries";
                RunPageLink = "Code chantier" = field (Code);
                RunPageView = sorting ("Code chantier", "Document Type", Open, "Due Date");
            }
            action("Recréer ce chantier")
            {
                Caption = 'Recréer ce chantier';
                tooltip = 'Recréer ce chantier';

                trigger OnAction()
                begin
                    Rec.RecreerChantier();
                end;
            }
            action("Rouvrir ce chantier")
            {
                Tooltip = 'Rouvrir ce chantier';
                Caption = 'Rouvrir ce chantier';

                trigger OnAction()
                begin
                    Rec.Rouvrir();
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

