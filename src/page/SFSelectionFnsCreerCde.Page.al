page 50074 "SF Selection fns/creer cde"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = "Sales Line";
    //KAN.FHA 28/01/2026 SourceTableView = sorting("Document Type", "Document No.", Type, "Vendor No.");
    //Remplace par :
    SourceTableView = sorting(TypeDocDuplique,NumDocDuplique,"Vendor No.",Phase);
    //Caption = 'Sélection des fns pour créer commande';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.")
                {
                    Caption = 'N° ligne';
                    ToolTip = 'N° ligne';
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    Caption = 'N°';
                    ToolTip = 'N°';
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Description';
                    Editable = false;
                }
                field("Nb affectations achats"; Rec."Nb affectations achats")
                {
                    Caption = 'Nb affectations achats';
                    ToolTip = 'Nb affectations achats';
                    Editable = false;
                    Visible = false;
                }
                field("Quantite affectee"; Rec."Quantite affectee")
                {
                    ApplicationArea = All;
                    ToolTip = 'Quantité affectée';
                }

                field("Vendor No."; Rec."Vendor No.")
                {
                    Caption = 'N° fournisseur';
                    ToolTip = 'N° fournisseur';
                }
                field(Quantity; Rec.Quantity)
                {
                    Caption = 'Quantité';
                    ToolTip = 'Quantité';
                    Editable = false;
                }
                field("Stock dispo instant t"; Rec."Stock dispo instant t")
                {
                    Caption = 'Stock dispo instant t';
                    ToolTip = 'Stock dispo instant t';
                }
                
                field("Quantite a acheter"; Rec."Quantite a acheter")
                {
                    Caption = 'Quantité à acheter';
                    ToolTip = 'Quantité à acheter';
                }

                field("Pris sur stock"; Rec."Pris sur stock")
                {
                    ApplicationArea = All;
                    ToolTip = 'A cocher si vous allez prendre l''intégralité de la quantité en stock.';
                }

                field("Creer cde achat"; Rec."Creer cde achat")
                {
                    Caption = 'Créer cde achat';
                    ToolTip = 'Créer cde achat';
                }
                field("Ajouter à cde achat No."; Rec."Ajouter à cde achat No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Ajouter à cde achat N°';
                    ToolTip = 'Ajouter à la commande d''achat N°';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Sélectionner tout")
            {
                Caption = 'Sélectionner tout';
                ToolTip = 'Sélectionner tout (Case "Créer cde achat")';

                trigger OnAction()
                begin
                    SelectionnerTout(0); //Tout sélectionner
                end;
            }
            action("Désélectionner tout")
            {
                Caption = 'Désélectionner tout';
                ToolTip = 'Désélectionner tout (Case "Créer cde achat")';
                trigger OnAction()
                begin
                    SelectionnerTout(1); //Tout désélectionner
                end;
            }
            /*
            action("Inverser sélection")
            {
                Caption = 'Inverser sélection';
                ToolTip = 'Inverser sélection (Case "Créer cde achat")';

                trigger OnAction()
                begin
                    SelectionnerTout(2); //Inverser la sélection
                end;
            }
            */


            action(ToutPrendreSurStock)
            {
                Caption = 'Tout prendre sur stock';
                ToolTip = 'Sélectionner tout (Case "Pris sur stock")';

                trigger OnAction()
                begin
                    SelectionnerToutPrisSurStock(0); //Tout sélectionner
                end;
            }
            action(RienPrendreSurStock)
            {
                Caption = 'Rien prendre sur stock';
                ToolTip = 'Désélectionner tout (Case "Pris sur stock")';
                trigger OnAction()
                begin
                    SelectionnerToutPrisSurStock(1); //Tout désélectionner
                end;
            }
            /*
            action(InverserPrisSurStock)
            {
                Caption = 'Inverser Pris sur stock';
                ToolTip = 'Inverser sélection (Case "Pris sur stock")';

                trigger OnAction()
                begin
                    SelectionnerToutPrisSurStock(2); //Inverser la sélection
                end;
            }
            */


        }
    }

    procedure SelectionnerTout(pOption: Option ToutSelectionner,ToutDeselectionner,InverserSelection)
    var
        LigneVente: Record "Sales Line";
    begin
        LigneVente.Reset();
        LigneVente.SetRange("Document Type", Rec."Document Type");
        LigneVente.SetRange("Document No.", Rec."Document No.");
        if LigneVente.FindSet(true) then
            repeat
                case pOption of
                    0:
                        LigneVente."Creer cde achat" := true;
                    1:
                        LigneVente."Creer cde achat" := false;
                    2:
                        LigneVente."Creer cde achat" := not LigneVente."Creer cde achat";
                end;
                LigneVente.Modify();
            until LigneVente.Next() = 0;
    end;

    procedure SelectionnerToutPrisSurStock(pOption: Option ToutSelectionner,ToutDeselectionner,InverserSelection)
    var
        LigneVente: Record "Sales Line";
    begin
        LigneVente.Reset();
        LigneVente.SetRange("Document Type", Rec."Document Type");
        LigneVente.SetRange("Document No.", Rec."Document No.");
        
        if LigneVente.FindSet(true) then
            repeat
                case pOption of
                    0:
                        LigneVente."Pris sur stock" := true;
                    1:
                        LigneVente."Pris sur stock" := false;
                    2:
                        LigneVente."Pris sur stock" := not LigneVente."Pris sur stock";
                end;
                LigneVente.Modify();
            until LigneVente.Next() = 0;
    end;
}

