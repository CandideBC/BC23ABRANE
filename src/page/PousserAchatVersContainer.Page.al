page 50060 "Pousser achat vers container"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Purchase Header";

    layout
    {
        area(content)
        {
            group("Général")
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'N°';
                }
                field("Buy-from Vendor No.";Rec."Buy-from Vendor No.")
                {
                    ToolTip = 'N° preneur d''ordre';
                }
                field("Pay-to Name";Rec."Pay-to Name")
                {
                    ToolTip = 'Nom fournisseur à payer';
                }
                field("Code enseigne"; Rec."Code enseigne")
                {
                    ToolTip = 'Enseigne';
                }
                field("Code operation"; Rec."Code operation")
                {
                    ToolTip = 'Opération';
                }
                field("Code chantier"; Rec."Code chantier")
                {
                    ToolTip = 'Chantier';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Statut';
                }
                field("Commentaires pour AIE"; Rec."Commentaires pour AIE")
                {
                    ToolTip = 'Commentaires pour AIE';

                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ToolTip = 'N° facture fournisseur';
                }
                field(Commentaires; Rec.Commentaires)
                {
                    ToolTip = 'Commentaires';
                }
                field("Montant vers container"; Rec."Montant vers container")
                {
                    ToolTip = 'Montant vers container';
                }
                field("Montant vers container papier"; Rec."Montant vers container papier")
                {
                    ToolTip = 'Montant vers container papier';
                }
                field("[Montant vers container]-[Montant vers container papier]"; Rec."Montant vers container" - Rec."Montant vers container papier")
                {
                    ToolTip = 'Différence NAV/Papier';
                    Caption = 'Différence montants';
                    DecimalPlaces = 2 : 2;
                    Editable = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Code devise';
                }
                field("No. container existant"; Rec."No. container existant")
                {
                    ToolTip = 'N° container existant';
                    ShowMandatory = true;
                }
                field("Choix container"; Rec."Choix container")
                {
                    ToolTip = 'Choix container';
                    ShowMandatory = true;
                }
            }
            part(Lignes; "SFPousser achat vers container")
            {
                Caption = 'Lignes';
                SubPageLink = "Document Type" = field ("Document Type"),
                              "Document No." = field ("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Remplir quantités")
            {
                Caption = 'Remplir quantités';
                ToolTip = 'Remplir quantités';
                Image = AutofillQtyToHandle;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.RemplirQuantiteVersContainer();
                end;
            }
            action("Vider quantités")
            {
                Caption = 'Vider quantités';
                ToolTip = 'Vider quantités';
                Image = DeleteQtyToHandle;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.ViderQuantiteVersContainer();
                end;
            }
            action("Mettre dans container")
            {
                Caption = 'Mettre dans container';
                ToolTip = 'Mettre dans container';
                Image = AddAction;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.EnvoyerLignesVersContainer();
                end;
            }
            action("Afficher commande")
            {
                Caption = 'Afficher commande';
                ToolTip = 'Afficher commande';
                Image = "Order";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Purchase Order";
                RunPageLink = "Document Type" = field ("Document Type"),
                              "No." = field ("No.");
            }
            action("Rouvrir commande")
            {
                Caption = 'Rouvrir commande';
                ToolTip = 'Rouvrir commande';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ReleasePurchDoc.PerformManualReopen(Rec);
                end;
            }
            action("Lancer commande")
            {
                Caption = 'Lancer commande';
                ToolTip = 'Lancer commande';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ReleasePurchDoc.PerformManualRelease(Rec);
                end;
            }
            action("Recalculer montant vers container")
            {
                Caption = 'Recalculer montant vers container';
                ToolTip = 'Recalculer montant vers container';
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = false;

                trigger OnAction()
                var
                    LigneAchat: Record "Purchase Line";
                    MontantVersContainer: Decimal;
                begin
                    LigneAchat.SetRange("Document Type", Rec."Document Type");
                    LigneAchat.SetRange("Document No.", Rec."No.");
                    if LigneAchat.FindSet(true) then
                        repeat
                            MontantVersContainer := 0;
                            if LigneAchat.Quantity <> 0 then
                                MontantVersContainer := Round(LigneAchat."Quantite vers container" / LigneAchat.Quantity * LigneAchat."Line Amount", 0.01);
                            if Rec."Montant vers container" <> MontantVersContainer then begin
                                LigneAchat."Montant vers container" := MontantVersContainer;
                                LigneAchat.Modify();
                            end;
                        until LigneAchat.Next() = 0;

                    CurrPage.Update(true);
                end;
            }
        }
    }

    var
        ReleasePurchDoc: Codeunit "Release Purchase Document";
}

