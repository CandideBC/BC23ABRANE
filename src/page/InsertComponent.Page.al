page 50020 "Insert Component"
{
    Caption = 'Insérer composant';
    InsertAllowed = false;
    PageType = Worksheet;

    layout
    {
        area(content)
        {
            group("Link To")
            {
                Caption = 'Article parent';
                field(NumArticleParent; NumArticleParent)
                {
                    Caption = 'N° article';
                    ToolTip = 'N° article';
                    Editable = false;
                    Lookup = true;
                }
                field(QuantiteLigneParent; QuantiteLigneParent)
                {
                    ApplicationArea = All;
                    Caption = 'Quantité';
                    ToolTip = 'Quantité de l''article parent';
                    Editable = false;
                    DecimalPlaces = 0 : 5;
                }

                field(NumLigneOrigine; NumLigneOrigine)
                {
                    Caption = 'N° ligne';
                    ToolTip = 'N° ligne';
                    Editable = false;
                }
            }
            group("Général")
            {
                Caption = 'Composant';
                field(NumComposantAjoute; NumComposantAjoute)
                {
                    Caption = 'N° article';
                    ToolTip = 'N° article';
                    TableRelation = Item."No.";
                }
                field(QuantitePour1; QuantitePour1)
                {
                    Caption = 'Quantité pour 1';
                    ToolTip = 'Quantité pour 1';
                    DecimalPlaces = 0 : 5;
                    trigger OnValidate()
                    var
                    begin
                        Quantity := QuantitePour1 * QuantiteLigneParent;
                    end;
                }
                field(Quantity; Quantity)
                {
                    Caption = 'Quantité';
                    ToolTip = 'Quantité';
                    Editable = false;
                    DecimalPlaces = 0 : 5;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        LigneVenteSimplifiee: Record "Ligne vente simplifiee";
        LigneParent: Record "Ligne vente simplifiee";
        LigneVente: Record "Sales Line";

    begin
        if CloseAction = ACTION::LookupOK then begin

            if Confirm(StrSubstNo(AjouterComposantQst), true, NumComposantAjoute) then begin
                if AppelDepuisVueSimplifiee then begin

                    LigneParent.get(TypeDocumentOrigine, NoDocumentOrigine, NumLigneParent);
                    LigneVenteSimplifiee.Init();
                    LigneVenteSimplifiee."Type Document" := TypeDocumentOrigine;
                    LigneVenteSimplifiee."No. document" := NoDocumentOrigine;
                    LigneVenteSimplifiee."No. ligne" := RecupProchNumLigne(NumLigneOrigine);
                    LigneVenteSimplifiee.Type := LigneVenteSimplifiee.Type::Item;

                    LigneVenteSimplifiee.Validate("No.", NumComposantAjoute);
                    
                    LigneVenteSimplifiee."Quantite pour 1" := QuantitePour1;
                    LigneVenteSimplifiee.Validate(Quantite, Quantity);
                    LigneVenteSimplifiee.Validate("Prix unitaire", 0);
                    LigneVenteSimplifiee."Type ligne simplifiee" := LigneVenteSimplifiee."Type ligne simplifiee"::Fille;
                    LigneVenteSimplifiee."Linked to line No." := LigneVenteSimplifiee."Linked to line No.";
                    LigneVenteSimplifiee."No. ligne mere" := NumLigneParent;
                    //LigneVenteSimplifiee."BOM Item No." := ItemLink;
                    LigneVenteSimplifiee.Validate("Code magasin", LigneParent."Code magasin");
                    LigneVenteSimplifiee.Insert();

                    //On ajoute maintenant le composant à la table Ligne vente également 
                    RecSalesLine.init();
                    RecSalesLine."Document Type" := TypeDocumentOrigine;
                    RecSalesLine."Document No." := NoDocumentOrigine;
                    RecSalesLine."Line No." := LigneVenteSimplifiee."No. ligne";
                    RecSalesLine.Type := RecSalesLine.Type::Item;
                    RecSalesLine.Validate("No.", NumComposantAjoute);
                    RecSalesLine.Validate(Quantity, Quantity);
                    RecSalesLine.Validate("Unit Price", 0);
                    RecSalesLine."Linked to line" := NumLigneParent;
                    RecSalesLine."BOM Item No." := NumArticleParent;
                    RecSalesLine."Quantite pour 1" := QuantitePour1;
                    RecSalesLine.Insert();
                    RecSalesLine.Validate("Location Code", LigneParent."Code magasin");
                    RecSalesLine.Modify();
                end else begin
                    LigneVente.Get(TypeDocumentOrigine, NoDocumentOrigine, NumLigneOrigine);
                    RecSalesLine.init();
                    RecSalesLine."Document Type" := TypeDocumentOrigine;
                    RecSalesLine."Document No." := NoDocumentOrigine;
                    RecSalesLine."Line No." := NumLigneOrigine + 1;
                    RecSalesLine.Type := RecSalesLine.Type::Item;
                    RecSalesLine.Validate("No.", NumComposantAjoute);
                    RecSalesLine.Validate(Quantity, Quantity);
                    RecSalesLine.Validate("Unit Price", 0);
                    RecSalesLine."Linked to line" := LigneVente."Linked to line";
                    RecSalesLine."BOM Item No." := NumArticleParent;
                    RecSalesLine.Insert();
                    RecSalesLine.Validate("Location Code", LigneVente."Location Code");
                    RecSalesLine.Modify();
                end;
            end else
                Message(MAJAnnuleeMsg);
        end else
            Message(MAJAnnuleeMsg);
    end;

    procedure RecupProchNumLigne(pNumLigneOrigine: Integer): Integer
    var
        ToutesLignesVentesSimplifiees: Record "Ligne vente simplifiee";
        LignesVentesSimplifieesCetteMere: Record "Ligne vente simplifiee";
        NumLignePossible: Integer;
        NumLigneControle: Integer;
    begin
        LignesVentesSimplifieesCetteMere.SetRange("Type document", TypeDocumentOrigine);
        LignesVentesSimplifieesCetteMere.SetRange("No. document", NoDocumentOrigine);
        LignesVentesSimplifieesCetteMere.SetRange("No. ligne mere", NumLigneParent);
        IF LignesVentesSimplifieesCetteMere.FindLast() then begin
            NumLignePossible := LignesVentesSimplifieesCetteMere."No. ligne" + 200;
            NumLigneControle := LignesVentesSimplifieesCetteMere."No. ligne";
        end else begin
            NumLignePossible := NumLigneParent + 200;
            NumLigneControle := NumLigneParent;
        end;
        //On va maintenant vérifier si le N° ligne possible est bien entre la ligne courante et la prochaine ligne (autre parent ou autre ligne indépendante)
        ToutesLignesVentesSimplifiees.SetRange("Type document", TypeDocumentOrigine);
        ToutesLignesVentesSimplifiees.SetRange("No. document", NoDocumentOrigine);
        ToutesLignesVentesSimplifiees.SetFilter("No. ligne", '>%1', NumLigneControle);
        IF ToutesLignesVentesSimplifiees.Findfirst() then begin
            if ToutesLignesVentesSimplifiees."No. ligne" <= NumLignePossible then begin //La prochaine ligne a un numero de ligne plus petit que celui qu'on voulait utiliser
                NumLignePossible := (ToutesLignesVentesSimplifiees."No. ligne" - NumLigneControle) div 2;
                exit(NumLignePossible);
            end else
                IF (ToutesLignesVentesSimplifiees."No. ligne" - NumLignePossible) > 1000 then //La prochaine ligne est assez éloignée pour continuer à ajouter 200 pour le prochain composant
                    exit(NumLignePossible)
                else begin //On est trop proche de la prochaine ligne, on va couper en deux
                    NumLignePossible := (ToutesLignesVentesSimplifiees."No. ligne" - NumLignePossible) div 2;
                    exit(NumLignePossible);
                end;
        end else
            exit(NumLignePossible)

    end;

    var
        RecSalesLine: Record "Sales Line";
        NumComposantAjoute: Code[20];
        QuantitePour1: Decimal;
        Quantity: Decimal;
        QuantiteLigneParent: Decimal;
        NumLigneOrigine: Integer;
        NumLigneParent: Integer;
        NumArticleParent: Code[20];
        TypeDocumentOrigine: enum "Sales Document Type";
        NoDocumentOrigine: Code[20];
        AppelDepuisVueSimplifiee: Boolean;
        AjouterComposantQst: label 'Confirmez-vous l''insertion du composant %1?', Comment = '%1 = N° composant';
        MAJAnnuleeMsg: Label 'Mise à jour annulée.';

    procedure SetData(pAppelDepuisVueSimplifiee: Boolean; pNumLigneParent: Integer; pNumArticleParent: Code[20]; pTypeDocOrigine: enum "Sales Document Type"; pNumDocOrigine: Code[20]; pNumLigneOrigine: Integer)
    var
        LigneMere: Record "Ligne vente simplifiee";
    begin
        AppelDepuisVueSimplifiee := pAppelDepuisVueSimplifiee;
        NumLigneParent := pNumLigneParent;
        NumLigneOrigine := pNumLigneOrigine;
        NumArticleParent := pNumArticleParent;
        TypeDocumentOrigine := pTypeDocOrigine;
        NoDocumentOrigine := pNumDocOrigine;
        QuantiteLigneParent := 0;
        if LigneMere.get(TypeDocumentOrigine, NoDocumentOrigine, NumLigneParent) then
            QuantiteLigneParent := LigneMere.Quantite;

    end;
}

