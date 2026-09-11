page 50069 Stock
{
    Editable = false;
    PageType = List;
    SourceTable = "Valorisation stock à date";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. article"; Rec."No. article")
                {
                }
                field(Designation; Rec.Designation)
                {
                }
                field("Annee N"; Rec."Annee N")
                {
                }
                field("Ref client"; Rec."Ref client")
                {
                }
                field("Date dernier mouvement"; Rec."Date dernier mouvement")
                {
                }
                field("Code magasin"; Rec."Code magasin")
                {
                }
                field("Stock au (Date)"; Rec."Stock au (Date)")
                {
                }
                field("Quantite en stock magasin"; Rec."Quantite en stock magasin")
                {
                }
                field("Quantite stock tous magasins"; Rec."Quantite stock tous magasins")
                {
                }
                field("Cout unitaire NAV"; Rec."Cout unitaire NAV")
                {
                }
                field("Valeur au cout unitaire NAV"; Rec."Valeur au cout unitaire NAV")
                {
                }
                field("PMP recalcule"; Rec."PMP recalcule")
                {
                    Caption = 'PMP recalculé';
                }
                field("Valeur au PMP recalcule"; Rec."Valeur au PMP recalcule")
                {
                }
                field("% depreciation"; Rec."% depreciation")
                {
                }
                field("Conso annee N"; Rec."Conso annee N")
                {
                }
                field(RatioConsoNVsStock; RatioConsoNVsStock)
                {
                    Caption = 'Conso N / Stock';
                }
                field("Conso annee N-1"; Rec."Conso annee N-1")
                {
                }
                field("Conso annee N-2"; Rec."Conso annee N-2")
                {
                }
                field("Conso annee N-3"; Rec."Conso annee N-3")
                {
                }
                field("Ecart valeur PMP/NAV (Montant)"; Rec."Ecart valeur PMP/NAV (Montant)")
                {
                }
                field("Ecart absolu PMP/NAV (Mnt)"; Rec."Ecart absolu PMP/NAV (Mnt)")
                {
                }
                field("Ecart valeur PMP/NAV (%)"; Rec."Ecart valeur PMP/NAV (%)")
                {
                }
                field(Commentaire; Rec.Commentaire)
                {
                }
                field("Dernier prix achat"; Rec."Dernier prix achat")
                {
                }
                field("Date dernier achat"; Rec."Date dernier achat")
                {
                }
                field("Valeur au DPA"; Rec."Valeur au DPA")
                {
                }
                field("Commentaire PMP"; Rec."Commentaire PMP")
                {
                }
                field("Dernier prix achat N"; Rec."Dernier prix achat N")
                {
                }
                field("Date dernier prix achat N"; Rec."Date dernier prix achat N")
                {
                }
                field("Origine dernier achat N"; Rec."Origine dernier achat N")
                {
                }
                field("Dernier prix achat N-1"; Rec."Dernier prix achat N-1")
                {
                }
                field("Origine dernier achat N-1"; Rec."Origine dernier achat N-1")
                {
                }
                field("Date dernier prix achat N-1"; Rec."Date dernier prix achat N-1")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Extraire...")
            {
                Caption = 'Extraire...';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Calculer stock à date";
            }

        }
        area(navigation)
        {
            action("Ecritures articles")
            {
                Caption = 'Ecritures articles';
                Image = ItemLedger;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Item Ledger Entries";
                RunPageLink = "Item No." = FIELD ("No. article");
                RunPageView = SORTING ("Item No.", "Posting Date")
                              ORDER(Descending);
            }
            action("Ecritures achats")
            {
                Caption = 'Ecritures achats';
                Image = ItemLedger;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Item Ledger Entries";
                RunPageLink = "Item No." = FIELD ("No. article"),
                              "Entry Type" = CONST (Purchase);
                RunPageView = SORTING ("Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date")
                              ORDER(Descending);
            }
            action("Détail du PMP")
            {
                Caption = 'Détail du PMP';
                Image = Split;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Détail valeur stock PMP";
                RunPageLink = "No. article" = field ("No. article");
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Rec."Quantite stock tous magasins" <> 0 then
            RatioConsoNVsStock := Round(Rec."Conso annee N" / Rec."Quantite stock tous magasins", 0.01)
        else
            RatioConsoNVsStock := 0;
    end;

    trigger OnOpenPage()
    begin
        DefFiltresDate();
    end;

    var
        DateDebutConso: Date;
        DateFinConso: Date;
        RatioConsoNVsStock: Decimal;
    
    procedure DefFiltresDate()
    var
        Valo: Record "Valorisation stock à date";
    begin
        Rec.SetFilter("Filtre magasin conso", 'D_1|D_1_R');

        if not Valo.FindFirst() then
            exit;
        //Année N
        DateDebutConso := DMY2Date(1, 1, Date2DMY(Valo."Stock au (Date)", 3));
        DateFinConso := DMY2Date(31, 12, Date2DMY(DateDebutConso, 3));
        Rec.SetRange("Filtre date annee N", DateDebutConso, DateFinConso);

        //Année N-1
        DateDebutConso := CalcDate('<-1Y>', DateDebutConso);
        DateFinConso := CalcDate('<-1Y>', DateFinConso);
        Rec.SetRange("Filtre date annee N-1", DateDebutConso, DateFinConso);

        //Année N-2
        DateDebutConso := CalcDate('<-1Y>', DateDebutConso);
        DateFinConso := CalcDate('<-1Y>', DateFinConso);
        Rec.SetRange("Filtre date annee N-2", DateDebutConso, DateFinConso);

        //Année N-3
        DateDebutConso := CalcDate('<-1Y>', DateDebutConso);
        DateFinConso := CalcDate('<-1Y>', DateFinConso);
        Rec.SetRange("Filtre date annee N-3", DateDebutConso, DateFinConso);
    end;
}

