pageextension 50119 SalesOrderStatisticsExtension extends "Sales Order Statistics"
{

    layout
    {
        movebefore(Invoicing;Customer,Prepayment,Shipping)

        modify(InvDiscountAmount_General)
        {
            trigger OnAfterValidate()
            begin
                CalculerTotaux();
            end;
        }
        modify("TotalAmount1[1]")
        {
            Visible = false;
        }

        modify("TotalAmount2[1]")
        {
            Visible = false;
        }

        modify("ProfitLCY[1]")
        {
            Visible = false;
        }
        modify("ProfitPct[1]")
        {
            Visible = false;
        }
        modify("AdjProfitLCY[1]")
        {
            Visible = false;
        }
        modify("AdjProfitPct[1]")
        {
            Visible = false;
        }
        modify("TotalSalesLineLCY[1].""Unit Cost (LCY)""")
        {
            Visible = false;
        }
        modify("TotalAdjCostLCY[1] - TotalSalesLineLCY[1].""Unit Cost (LCY)""")
        {
            Visible = false;
        }
        //modify("TotalSalesLine[1].Quantity")
        //{
        //    Visible = false;
        //}
        modify("TotalSalesLineLCY[1].Amount")
        {
            Visible = false;
        }
        modify("TotalAdjCostLCY[1]")
        {
            Visible = false;
        }
        modify(VATAmount)
        {
            Visible = false;
        }


        modify("TotalSalesLine[1].""Units per Parcel""")
        {
            Visible = false;
        }
        modify("TotalSalesLine[1].""Net Weight""")
        {
            Visible = false;
        }
        modify("TotalSalesLine[1].""Gross Weight""")
        {
            Visible = false;
        }
        modify("TotalSalesLine[1].""Unit Volume""")
        {
            Visible = false;
        }
        modify(AmountInclVAT_Invoicing)
        {
            Visible = false;
        }
        modify(InvDiscountAmount_Invoicing)
        {
            Visible = false;
        }
        modify("TotalSalesLineLCY[2].Amount")
        {
            Visible = false;
        }
        modify("TotalAdjCostLCY[2]")
        {
            Visible = false;
        }
        modify("ProfitLCY[2]")
        {
            Visible = false;
        }
        modify("ProfitPct[2]")
        {
            Visible = false;
        }
        modify("AdjProfitLCY[2]")
        {
            Visible = false;
        }
        modify("AdjProfitPct[2]")
        {
            Visible = false;
        }
        modify("TotalSalesLineLCY[2].""Unit Cost (LCY)""")
        {
            Visible = false;
        }
        modify("TotalAdjCostLCY[2] - TotalSalesLineLCY[2].""Unit Cost (LCY)""")
        {
            Visible = false;
        }
        modify("TotalSalesLine[2].""Units per Parcel""")
        {
            Visible = false;
        }
        modify("TotalSalesLine[2].""Net Weight""")
        {
            Visible = false;
        }
        modify("TotalSalesLine[2].""Gross Weight""")
        {
            Visible = false;
        }
        modify("TotalSalesLine[2].""Unit Volume""")
        {
            Visible = false;
        }
        modify("TotalSalesLine[3].""Line Amount""")
        {
            Visible = false;
        }
        modify("TotalSalesLine[3].""Inv. Discount Amount""")
        {
            Visible = false;
        }
        modify("TotalSalesLineLCY[3].Amount")
        {
            Visible = false;
        }
        modify("TotalSalesLineLCY[3].""Unit Cost (LCY)""")
        {
            Visible = false;
        }
        modify("ProfitLCY[3]")
        {
            Visible = false;
        }
        modify("ProfitPct[3]")
        {
            Visible = false;
        }
        modify("TempVATAmountLine3.COUNT")
        {
            Visible = false;
        }
        modify("TotalSalesLine[3].""Units per Parcel""")
        {
            Visible = false;
        }
        modify("TotalSalesLine[3].""Net Weight""")
        {
            Visible = false;
        }
        modify("TotalSalesLine[3].""Gross Weight""")
        {
            Visible = false;
        }
        modify("TotalSalesLine[3].""Unit Volume""")
        {
            Visible = false;
        }
        modify("Reserved From Stock")
        {
            Visible = false;
        }
        modify(NoOfVATLines_General)
        {
            Visible = false;
        }
        addafter(LineAmountGeneral)
        {

        }

        addbefore(LineAmountGeneral)
        {
            field(MontantInitialHT; TotalSalesLine[1]."Line Amount" - MontantAcompteDS)
            {
                ApplicationArea = All;
                Caption = 'Montant initial H.T';
                ToolTip = 'Montant initial H.T';
            }
            
        }
        addafter(InvDiscountAmount_General)
        {
            field(TotalHT; TotalSalesLine[1]."Line Amount" - MontantAcompteDS - TotalSalesLine[1]."Inv. Discount Amount")
            {
                ApplicationArea = All;
                Caption = 'Total H.T.';
                ToolTip = 'Total H.T.';
            }
        }

        
        modify(LineAmountGeneral)
        {
            Visible = false;
        }
        modify(TotalInclVAT_Invoicing)
        {
            Editable = false;
        }

        addbefore(NoOfVATLines_General)
        {
            field(MontantAchatsPrevusDS; MontantAchatsPrevusDS)
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Montant achats prévus';
                ToolTip = 'Montant indicatif des achats si la totalité des articles vendus étaient achetés. En cas de devise, le taux de change est celui du jour.';
            }
            field(FraisApprocheDS; FraisApprocheDS)
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Budget approche (DS)';
                ToolTip = 'Montant estimé des frais d''approche.';
            }
            /*
            field(MontantVentesDS; MontantVentesDS)
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Montant ventes DS';
                ToolTip = 'Montant du document éventuellement converti en devise société (taux de change à la date de chargement)';
            }
            */
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
                ApplicationArea = All;
                ToolTip = 'Poids net total';
            }
            field("Poids brut total"; Rec."Poids brut total")
            {
                ApplicationArea = All;
                ToolTip = 'Poids brut total';
            }
            field("Nombre de colis"; Rec."Nombre de colis")
            {
                ApplicationArea = All;
                ToolTip = 'Nombre de colis';
            }
            field("Nombre de palettes"; Rec."Nombre de palettes")
            {
                ApplicationArea = All;
                ToolTip = 'Nombre de palettes';
            }
        }
        moveafter("Nombre de palettes";"TotalSalesLine[1].Quantity")

        addafter(PrepmtTotalAmount)
        {
            field("Montant acompte"; MontantAcompteDS)
            {
                ApplicationArea = All;
                Caption = 'Acompte';
                Editable = false;
                ToolTip = 'Montant acompte';
            }
        }


        modify(PrepmtDeductedPct)
        {
            Visible = false;
        }
        modify(PrepmtVATAmount)
        {
            Visible = false;
        }
        modify(PrepmtTotalAmount)
        {
            Visible = false;
        }
        modify(PrepmtInvPct)
        {
            Visible = false;
        }
        modify(PrepmtTotalAmount2)
        {
            Visible = false;
        }
        modify("TotalSalesLine[1].""Prepmt Amt Deducted""")
        {
            Visible = false;
        }
        modify("TotalSalesLine[1].""Prepmt Amt to Deduct""")
        {
            Visible = false;
        }
        modify("TotalSalesLine[1].""Prepmt. Amt. Inv.""")
        {
            Visible = false;
        }

        addbefore(Customer)
        {
            part(Approche; SFApprocheParPaysStatsDocVente)
            {
                SubPageLink = "Type document" = field("document type"), "No. document" = field("No.");
            }
        }
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
        
        MontantVentesDS := MontantVentesDS - TotalSalesLine[1]."Inv. Discount Amount";

        if Rec."Currency Code" <> '' then
            MontantVentesDS := FacteurDevise.ExchangeAmtFCYToLCY(Rec."Date chargement", Rec."Currency Code", MontantVentesDS, Rec."Currency Factor");

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
        TotalTVAHorsAcompte: Decimal;


}

