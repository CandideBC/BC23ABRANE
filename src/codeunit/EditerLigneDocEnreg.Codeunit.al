codeunit 50014 "Editer ligne doc. enreg."
{
    Permissions = TableData "Sales Invoice Header" = m,
                  TableData "Sales Invoice Line" = m,
                  TableData "Sales Cr.Memo Line" = m;

    TableNo = "Editer ligne doc. enregistre";

    trigger OnRun()
    var
    begin
        case rec."Type document" of
            Rec."Type document"::"Avoir enreg. vente":
                //On est dans le cas d'une modification de ligne d'avoir enregistré vente
                if SalesCrMemoLine.Get(Rec."No. document", Rec."No. ligne document") then begin
                    SalesCrMemoLine.LockTable();
                    SalesCrMemoLine."Annee commande" := Rec."Annee commande";
                    SalesCrMemoLine.Modify();
                end;
            Rec."Type document"::"Avoir enreg. achat":
                //On est dans le cas d'une modification de ligne d'avoir enregistré achat
                if PurchCrMemoLine.Get(Rec."No. document", Rec."No. ligne document") then begin
                    PurchCrMemoLine.LockTable();
                    PurchCrMemoLine."Annee commande" := Rec."Annee commande";
                    PurchCrMemoLine.Modify();
                end
        end;
    end;

    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
}

