page 50083 "Liste des chantiers"
{
    // InsertAllowed à Non car on doit créer un chantier depuis l'enseigne
    ApplicationArea = All;
    CardPageID = "Fiche chantier";
    UsageCategory = Lists;
    InsertAllowed = false;
    PageType = List;
    PromotedActionCategories = 'Nouveau document,Traitements,Etats,Naviguer';
    SourceTable = Chantier;
    SourceTableView = sorting ("Chantier archive")
                      where ("Chantier archive" = const (false));

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
                }
                field("Annee du chantier"; Rec."Annee du chantier")
                {
                    Caption = 'Année du chantier';
                    ToolTip = 'Année du chantier';
                }
                field("Date derniere facture vte"; Rec."Date derniere facture vte")
                {
                    ToolTip = 'Date dernière facture vte';
                }
                field("Statut chantier"; Rec."Statut chantier")
                {
                    ToolTip = 'Statut chantier';
                    Editable = false;
                }
                field("Chantier a verifier (>=2020)"; Rec."Chantier a verifier (>=2020)")
                {
                    ToolTip = 'Chantier à vérifier (>=2020)';
                    Visible = false;
                }
                field(Cloture; Rec.Cloture)
                {
                    ToolTip = 'Clôturé';
                }
                field("Chantier verifie"; Rec."Chantier verifie")
                {
                    ToolTip = 'Chantier vérifié';
                    Visible = false;
                }
                field("Code enseigne"; Rec."Code enseigne")
                {
                    ToolTip = 'Code enseigne';
                }
                field("Code concept"; Rec."Code concept")
                {
                    ToolTip = 'Code concept';
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
                }
                field("Ville client"; Rec."Ville client")
                {
                    ToolTip = 'Ville client';
                }
                field("Nom chantier"; Rec."Nom chantier")
                {
                    ToolTip = 'Nom chantier';
                }
                field("Nom chantier 2"; Rec."Nom chantier 2")
                {
                    ToolTip = 'Nom chantier 2';
                }
                field("Adresse chantier"; Rec."Adresse chantier")
                {
                    ToolTip = 'Adresse chantier';
                }
                field("Adresse chantier 2"; Rec."Adresse chantier 2")
                {
                    ToolTip = 'Adresse chantier 2';
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
                field("Adr. facture=Adr. livraison"; Rec."Adr. facture=Adr. livraison")
                {
                    ToolTip = 'Adr. facture=Adr. livraison';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Devis Vente")
            {
                Caption = 'Devis Vente';
                ToolTip = 'Devis Vente';
                Image = NewDocument;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.CreerDocumentVente(0);
                end;
            }
            action("Commande Vente")
            {
                Caption = 'Commande Vente';
                ToolTip = 'Commande Vente';
                Image = NewOrder;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.CreerDocumentVente(1);
                end;
            }
            action("Commande achat")
            {
                Caption = 'Commande achat';
                ToolTip = 'Commande achat';
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
            action(Devis)
            {
                Caption = 'Devis';
                ToolTip = 'Devis';
                Image = Document;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "Sales Quotes";
                RunPageLink = "Code chantier" = field (Code);
                RunPageView = sorting ("Document Type", "Code chantier");
            }
            action("Commandes ventes")
            {
                Caption = 'Commandes ventes';
                ToolTip = 'Commandes ventes';
                Image = "Order";
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "Sales Order List";
                RunPageLink = "Code chantier" = field (Code);
                RunPageView = sorting ("Document Type", "Code chantier");
            }
            action("Commandes achat")
            {
                Caption = 'Commandes achat';
                ToolTip = 'Commandes achat';
                Image = Receipt;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "Purchase Order List";
                RunPageLink = "Code chantier" = field (Code);
                RunPageView = sorting ("Code chantier");
            }
            action("Factures ventes")
            {
                Caption = 'Factures ventes';
                Image = Invoice;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "Posted Sales Invoices";
                RunPageLink = "Code chantier" = field (Code);
                RunPageView = sorting ("Code chantier", "Posting Date");
            }
            action("Avoirs ventes")
            {
                Caption = 'Avoirs ventes';
                Image = PostedCreditMemo;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = false;
                RunObject = Page "Posted Sales Credit Memos";
                RunPageLink = "Code chantier" = field (Code);
                RunPageView = sorting ("Code chantier", "Posting Date");
            }
            action("Factures achats")
            {
                Caption = 'Factures achats';
                Image = Purchase;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = false;
                RunObject = Page "Posted Purchase Invoices";
                RunPageLink = "Code chantier" = field (Code);
                RunPageView = sorting ("Code chantier");
            }
            action("Avoirs achats")
            {
                Caption = 'Avoirs achats';
                Image = CreditMemo;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = false;
                RunObject = Page "Posted Purchase Credit Memos";
                RunPageLink = "Code chantier" = field (Code);
                RunPageView = sorting ("Code chantier");
            }
        }
        area(processing)
        {
            action("Actualiser Statut")
            {
                Caption = 'Actualiser Statut';
                Image = NewStatusChange;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    rec.MAJStatutChantier();
                end;
            }
        }
        area(reporting)
        {
            action("Etiquettes palettes")
            {
                Caption = 'Etiquettes palettes';
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
}

