codeunit 50009 "Fonctions ABRANE"
{
    procedure StyleLigneDevisCommande(LigneVente: Record "Sales Line"): Text
    var
        EnteteVente: Record "Sales Header";
        Article: Record Item;
        Style: Text;
        
    begin
        EnteteVente.GET(LigneVente."Document Type", LigneVente."Document No.");

        if (LigneVente.Type = LigneVente.Type::" ") or (Article.GET(LigneVente."No.") and (LigneVente."Cout unitaire force")) then begin
            Style := 'Standard';
            exit(Style);
        end;

        if LigneVente."Article divers" then begin
            LigneVente.CalcFields("Nb affectations achats");
            if LigneVente."Nb affectations achats" = 0 then begin
                Style := 'Unfavorable';
                exit(Style);
            end;

            LigneVente.CALCFIELDS("Statut commande achat");
            CASE LigneVente."Statut commande achat" of
                LigneVente."Statut commande achat"::Ouverte, LigneVente."Statut commande achat"::"Lancée":
                    Style := 'Ambiguous';
                LigneVente."Statut commande achat"::"Totalement reçue":
                    Style := 'Favorable';
            END;
            exit(Style);
        end;

        IF (LigneVente."Attached to Line No." <> 0) or (LigneVente."Linked to line" <> 0) then begin
            Style := 'Subordinate';
            exit(Style);
        end;

        Style := 'StrongAccent';
        exit(Style);
    end;
}
