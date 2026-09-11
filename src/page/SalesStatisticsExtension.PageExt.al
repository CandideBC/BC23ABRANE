pageextension 50059 SalesStatisticsExtension extends "Sales Statistics"
{

    layout
    {
        
        modify("TotalSalesLineLCY.Amount")
        {
            Visible = false;
        }
        modify(ProfitLCY)
        {
            Visible = false;
        }
        modify(AdjProfitLCY)
        {
            Visible = false;
        }
        modify(ProfitPct)
        {
            Visible = false;
        }
        modify(AdjProfitPct)
        {
            Visible = false;
        }

        modify("TotalSalesLineLCY.""Unit Cost (LCY)""")
        {
            Visible = false;
        }
        modify(TotalAdjCostLCY)
        {
            Visible = false;
        }

        modify("TotalSalesLine.""Units per Parcel""")
        {
            Visible = false;
        }

        modify("TotalSalesLine.""Gross Weight""")
        {
            Visible = false;
        }
        modify("TotalSalesLine.""Unit Volume""")
        {
            Visible = false;
        }
        modify("TotalAdjCostLCY - TotalSalesLineLCY.""Unit Cost (LCY)""")
        {
            Visible = false;
        }

        addbefore(Amount)
        {
            field(MontantInitialHT; TotalSalesLine."Line Amount" - MontantAcompteDS)
            {
                ApplicationArea = All;
                Caption = 'Montant initial H.T';
                ToolTip = 'Montant initial H.T';
            }
            /*
            field("Montant acompte";MontantAcompteDS) 
            {
                ApplicationArea = All;
                Caption = 'Acompte';
                Editable = false;
            }
            */
        }


        modify(Amount)
        {
            Visible = false;
        }
        modify(TotalAmount1)
        {
            Visible = false;
        }

        addafter(InvDiscountAmount)
        {
            field(TotalHT; TotalSalesLine."Line Amount" - MontantAcompteDS - TotalSalesLine."Inv. Discount Amount")
            {
                ApplicationArea = All;
                Caption = 'Total H.T.';
                ToolTip = 'Total H.T.';
            }
        }
        modify(InvDiscountAmount)
        {
            trigger OnAfterValidate()
            begin
                CalculerTotaux();
            end;
        }

        addafter("TotalSalesLine.""Unit Volume""")
        {
            field(MontantAchatsPrevusDS; MontantAchatsPrevusDS)
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Montant achats prévus (DS)';
                ToolTip = 'Montant indicatif des achats si la totalité des articles vendus étaient achetés. En cas de devise, le taux de change est celui du jour.';
            }
            field(FraisApprocheDS; FraisApprocheDS)
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Budget approche (DS)';
                ToolTip = 'Montant estimé des frais d''approche.';
            }
            field(MargeDS; MargeDS)
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Marge prévue (DS)';
                ToolTip = 'Marge prévue en devise société';
            }
            field(PctMargeDS; PctMargeDS)
            {
                ApplicationArea = All;
                Editable = false;
                Caption = '% marge prévue';
                ToolTip = '% marge prévue.';
            }
            field("Total Net Weight"; Rec."Total Net Weight")
            {
                ToolTip = 'Poids net total';
            }
            field("Poids brut total"; Rec."Poids brut total")
            {
                ToolTip = 'Poids brut total';
            }
            field("Nombre de colis"; Rec."Nombre de colis")
            {
                ToolTip = 'Nombre de colis';
            }
            field("Nombre de palettes"; Rec."Nombre de palettes")
            {
                ToolTip = 'N° palette';
            }
        }
        moveafter("Nombre de palettes";"TotalSalesLine.Quantity")

        addbefore(SubForm)
        {
            part(Approche; SFApprocheParPaysStatsDocVente)
            {
                SubPageLink = "Type document" = field("document type"), "No. document" = field("No.");
            }
        }
        
        addafter(Approche)
        {
            group(Acompte)
            {
                Caption = 'Acompte';
                field("Montant acompte"; MontantAcompteDS)
                {
                    ApplicationArea = All;
                    ToolTip = 'Montant de l''acompte';
                    Caption = 'Acompte';
                    Editable = false;
                }
            }
        }
        moveafter(Approche;Customer)
    }
    procedure CalculerTotaux()
    var
        LigneVente: Record "Sales Line";
        FacteurDevise: Record "Currency Exchange Rate";
        TamponApproche: Record TamponBudgetApprocheDocument;
    begin
        MontantAchatsPrevusDS := 0;
        MontantVentesDS := 0;
        MontantAcompteDS := 0;
        LigneVente.SetRange("Document Type", Rec."Document Type");
        LigneVente.SetRange("Document No.", Rec."No.");
        if LigneVente.FindSet(false) then
            repeat
                MontantAchatsPrevusDS := MontantAchatsPrevusDS + LigneVente."Montant achats prevus (DS)";
                if (LigneVente."Ligne deduction acompte" or LigneVente."Ligne deduction situation") then
                    MontantAcompteDS := MontantAcompteDS + LigneVente."Line Amount"
                else
                    MontantVentesDS := MontantVentesDS + LigneVente."Line Amount";
            until LigneVente.Next() = 0;
        if Rec."Currency Code" <> '' then begin
            MontantVentesDS := FacteurDevise.ExchangeAmtFCYToLCY(Rec."Date chargement", Rec."Currency Code", MontantVentesDS, Rec."Currency Factor");
            MontantAcompteDS := FacteurDevise.ExchangeAmtFCYToLCY(Rec."Date chargement", Rec."Currency Code", MontantAcompteDS, Rec."Currency Factor");
        end;

        MontantVentesDS := MontantVentesDS - TotalSalesLine."Inv. Discount Amount";

        MargeDS := MontantVentesDS - MontantAchatsPrevusDS;
        PctMargeDS := 0;
        if MontantVentesDS <> 0 then
            PctMargeDS := round(MargeDS / MontantVentesDS * 100, 0.01);

        FraisApprocheDS := 0;
        TamponApproche.Reset();
        TamponApproche.SetRange("Code utilisateur", UserId);
        TamponApproche.SetRange("Type document", Rec."Document Type");
        TamponApproche.SetRange("No. document", Rec."No.");
        TamponApproche.SetRange("Type ligne",TamponApproche."Type ligne"::"Budget approche");
        if TamponApproche.FindSet(false) then
            repeat
                FraisApprocheDS := FraisApprocheDS + TamponApproche."Budget frais approche (DS)";
            until TamponApproche.Next() = 0;
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.EstimerFraisApproche();
        Commit();
        CalculerTotaux();
    end;

    var
        MontantAchatsPrevusDS: Decimal;
        MontantVentesDS: Decimal;
        MargeDS: Decimal;
        PctMargeDS: Decimal;
        MontantAcompteDS: Decimal;
        FraisApprocheDS: Decimal;

}

