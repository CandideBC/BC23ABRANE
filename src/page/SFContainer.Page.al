page 50091 "SF Container"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Ligne container";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. commande achat"; Rec."No. commande achat")
                {
                    Caption = 'N° commande achat';
                    ToolTip = 'N° commande achat';
                }
                field("No. ligne commande achat"; Rec."No. ligne commande achat")
                {
                    Caption = 'N° ligne commande achat';
                    ToolTip = 'N° ligne commande achat';
                }
                field("No."; Rec."No.")
                {
                    Caption = 'N°';
                    ToolTip = 'N°';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Description';
                }
                field(Quantite; Rec.Quantite)
                {
                    Caption = 'Quantité';
                    ToolTip = 'Quantité';
                }
                field("Nomenclature produits"; Rec."Nomenclature produits")
                {
                    Caption = 'Nomenclature produits';
                    ToolTip = 'Nomenclature produits';
                }
                field("Poids net unitaire"; Rec."Poids net unitaire")
                {
                    Caption = 'Poids net unitaire';
                    ToolTip = 'Poids net unitaire';
                }
                field("Qte a recevoir"; Rec."Qte a recevoir")
                {
                    Caption = 'Qté à recevoir';
                    ToolTip = 'Qté à recevoir';
                }
                field("Quantite recue"; Rec."Quantite recue")
                {
                    Caption = 'Quantité reçue';
                    ToolTip = 'Quantité reçue';
                }
                field("Quantite restante"; Rec."Quantite restante")
                {
                    Caption = 'Quantité restante';
                    ToolTip = 'Quantité restante';
                }
                field("No. ligne"; Rec."No. ligne")
                {
                    Editable = false;
                    Caption = 'N° ligne';
                    ToolTip = 'N° ligne';
                }
                field("Code acheteur"; Rec."Code acheteur")
                {
                    Caption = 'Code acheteur';
                    ToolTip = 'Code acheteur';
                }
                field("Code enseigne"; Rec."Code enseigne")
                {
                    Caption = 'Code enseigne';
                    ToolTip = 'Code enseigne';
                }
                field("Qte a retourner"; Rec."Qte a retourner")
                {
                    Caption = 'Qté à retourner';
                    ToolTip = 'Qté à retourner';
                }
                field("Qte sur retour"; Rec."Qte sur retour")
                {
                    Caption = 'Qté sur retour';
                    ToolTip = 'Qté sur retour';
                }
                field("Qte retournee"; Rec."Qte retournee")
                {
                    Caption = 'Qté retournée';
                    ToolTip = 'Qté retournée';
                }
                field(Commentaire; Rec.Commentaire)
                {
                    Caption = 'Commentaire';
                    ToolTip = 'Commentaire';
                }
                field("No. fournisseur"; Rec."No. fournisseur")
                {
                    Caption = 'N° fournisseur';
                    ToolTip = 'N° fournisseur';
                }
                field("No. facture fournisseur"; Rec."No. facture fournisseur")
                {
                    Caption = 'N° facture fournisseur';
                    ToolTip = 'N° facture fournisseur';
                }
                field("Cout unitaire direct"; Rec."Cout unitaire direct")
                {
                    Caption = 'Coût unitaire direct';
                    ToolTip = 'Coût unitaire direct';
                }
                field(MontantLigne; MontantLigne)
                {
                    Caption = 'Montant';
                    Editable = false;
                    ToolTip = 'Montant';
                }
                field("Code devise"; Rec."Code devise")
                {
                    Caption = 'Code devise';
                    ToolTip = 'Code devise';
                }
                field("Cout unitaire facture (papier)"; Rec."Cout unitaire facture (papier)")
                {
                    Caption = 'Coût unitaire facture (papier)';
                    ToolTip = 'Coût unitaire facture (papier)';
                }
                field("Montant facture (papier)"; Rec."Montant facture (papier)")
                {
                    Editable = false;
                    Caption = 'Montant facture (papier)';
                    ToolTip = 'Montant facture (papier)';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Commande)
            {
                Caption = 'Commande';
                ToolTip = 'Commande';
                RunObject = Page "Purchase Order";
                RunPageLink = "Document Type" = const (Order),
                              "No." = field ("No. commande achat");
            }
            group("Fonction&s")
            {
                Caption = 'Fonctions';
                ToolTip= 'Fonctions';
                Image = "Action";
                action(ExtraireLignesAchat)
                {
                    Caption = 'Extraire lignes expéditions';
                    ToolTip = 'Extraire lignes expéditions';
                    Ellipsis = true;
                    Image = Shipment;

                    trigger OnAction()
                    begin
                        //KAN.FHA 01/03/2023
                        //ExtraireAchat;
                        Message('Cette fonction a été désactivée à la demande d''ABRANE.\Veuillez désormais utiliser la fonction "Pousser vers container" depuis les commandes d''achats.');
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //KAN.FHA 07/12/2022 DEBUT
        MontantLigne := 0;
        if LigneAchat.Get(LigneAchat."Document Type"::Order, Rec."No. commande achat", Rec."No. ligne commande achat") then
            if LigneAchat.Quantity <> 0 then
                MontantLigne := Round(Rec.Quantite / LigneAchat.Quantity * (LigneAchat."Line Amount" - LigneAchat."Inv. Discount Amount"), 0.01)
    end;

    var
        LigneAchat: Record "Purchase Line";

        MontantLigne: Decimal;

    procedure ExtraireAchat()
    begin
        //CODEUNIT.RUN(CODEUNIT::"Extraire achat vers container",Rec);
    end;
}

