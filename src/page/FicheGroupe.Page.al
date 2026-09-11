page 50076 "Fiche groupe"
{
    ApplicationArea = All;
    UsageCategory = None;    
    PageType = Card;
    SourceTable = "Groupe client";

    layout
    {
        area(content)
        {
            group("Général")
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Code';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                }
                field("Montant factures ventes"; Rec."Montant factures ventes")
                {
                    ToolTip = 'Montant factures ventes';
                }
                field("Montant avoirs ventes"; Rec."Montant avoirs ventes")
                {
                    ToolTip = 'Montant avoirs ventes';
                }
                field("Montant factures achats"; Rec."Montant factures achats")
                {
                    ToolTip = 'Montant factures achats';
                }
                field("Montant avoirs achats"; Rec."Montant avoirs achats")
                {
                    ToolTip = 'Montant avoirs achats';
                }
                field("Montant reste a livrer"; Rec."Montant reste a livrer")
                {
                    ToolTip = 'Montant reste à livrer';
                }
                field("Montant livre non facture"; Rec."Montant livre non facture")
                {
                    ToolTip = 'Montant livré non facturé';
                }
                field("Montant sur cdes achats"; Rec."Montant sur cdes achats")
                {
                    ToolTip = 'Montant sur cdes achats';
                }
                field("Montant recu non facture"; Rec."Montant recu non facture")
                {
                    ToolTip = 'Montant reçu non facturé';
                }
            }
            group("Rentabilité - Détail")
            {
                
                fixed(Control1000000037)
                {
                    ShowCaption = false;
                    group(CA)
                    {
                        Caption = 'CA';
                        //The GridLayout property is only supported on controls of type Grid
                        //GridLayout = Rows;
                        field(CAMobilier; Rec."CA Mobilie")
                        {
                            ToolTip = 'CA Mobilier';
                            BlankZero = true;
                            Caption = 'Mobilier';
                        }
                        field(CApose; Rec."CA Pose/Audit")
                        {
                            ToolTip = 'CA Pose';
                            BlankZero = true;
                            Caption = 'Pose/audit';
                        }
                        field(CATransport; Rec."CA Transport")
                        {
                            ToolTip = 'CA Transport';
                            BlankZero = true;
                            Caption = 'Transport';
                        }
                        field(CABennes; Rec."CA Bennes/Fenwick")
                        {
                            ToolTip = 'CA Bennes/Fenwick';
                            BlankZero = true;
                            Caption = 'Bennes/Fenwick';
                        }
                        field(CASAV; Rec."CA SAV")
                        {
                            ToolTip = 'CA SAV';
                            BlankZero = true;
                            Caption = 'SAV';
                        }
                    }
                    group("Coût total")
                    {
                        
                        Caption = 'Coût total';
                        //The GridLayout property is only supported on controls of type Grid
                        //GridLayout = Rows;
                        field("Cout total Mobilier"; Rec."Cout total Mobilier")
                        {
                            ToolTip = 'Coût total Mobilier';
                            Caption = 'Mobilier';
                        }
                        field("Cout total Pose/Audit"; Rec."Cout total Pose/Audit")
                        {
                            ToolTip = 'Coût total Pose/Audit';
                            Caption = 'Pose/audit';
                        }
                        field("Cout total Transport"; Rec."Cout total Transport")
                        {
                            ToolTip = 'Coût total Transport';
                            Caption = 'Transport';
                        }
                        field("Cout total Bennes/Fenwick"; Rec."Cout total Bennes/Fenwick")
                        {
                            ToolTip = 'Coût total Bennes/Fenwick';
                            Caption = 'Bennes/Fenwick';
                        }
                        field("Cout total SAV"; Rec."Cout total SAV")
                        {
                            ToolTip = 'Coût total SAV';
                            Caption = 'SAV';
                        }
                    }
                    group("Marge brute (Montant)")
                    {
                        Caption = 'Marge brute (Montant)';
                        //The GridLayout property is only supported on controls of type Grid
                        //GridLayout = Rows;
                        field(MargeMobilierRenta; Rec."CA Mobilie" - Rec."Cout total Mobilier")
                        {
                            ToolTip = 'Marge Mobilier';
                            BlankZero = true;
                            Caption = 'Mobilier';
                        }
                        field(MargePoseAuditRenta; Rec."CA Pose/Audit" - Rec."Cout total Pose/Audit")
                        {
                            ToolTip = 'Marge Pose/Audit';
                            BlankZero = true;
                            Caption = 'Pose/audit';
                        }
                        field(MargeTransportRenta; Rec."CA Transport" - Rec."Cout total Transport")
                        {
                            ToolTip = 'Marge Transport';
                            BlankZero = true;
                            Caption = 'Transport';
                        }
                        field(MargeBennesRenta; Rec."CA Bennes/Fenwick" - Rec."Cout total Bennes/Fenwick")
                        {
                            ToolTip = 'Marge Bennes';
                            BlankZero = true;
                            Caption = 'Bennes/Fenwick';
                        }
                        field(MargeSAVRenta; Rec."CA SAV" - Rec."Cout total SAV")
                        {
                            ToolTip = 'Marge SAV';
                            BlankZero = true;
                            Caption = 'SAV';
                        }
                    }
                    group("Marge brute (%)")
                    {
                        Caption = 'Marge brute (%)';
                        //The GridLayout property is only supported on controls of type Grid
                        //GridLayout = Rows;
                        field(PctMargeMobilierRenta; Pourcentage(Rec."CA Mobilie" - Rec."Cout total Mobilier", Rec."CA Mobilie"))
                        {
                            
                            ToolTip = '% Marge Mobilier';
                            Caption = 'Mobilier';
                        }
                        field(PctMargePoseRenta; Pourcentage(Rec."CA Pose/Audit" - Rec."Cout total Pose/Audit", Rec."CA Pose/Audit"))
                        {
                            ToolTip = '% Marge Pose';
                            
                            Caption = 'Pose/audit';
                        }
                        field(PctMargeTransportRenta; Pourcentage(Rec."CA Transport" - Rec."Cout total Transport", Rec."CA Transport"))
                        {
                            ToolTip = '% Marge Transport';
                            
                            Caption = 'Transport';
                        }
                        field(PctMargeBennesRenta; Pourcentage(Rec."CA Bennes/Fenwick" - Rec."Cout total Bennes/Fenwick", Rec."CA Bennes/Fenwick"))
                        {
                            ToolTip = '% Marge Bennes';
                            
                            Caption = 'Bennes/Fenwick';
                        }
                        field(PctMargeSAVRenta; Pourcentage(Rec."CA SAV" - Rec."Cout total SAV", Rec."CA SAV"))
                        {
                            ToolTip = '% Marge SAV';
                            BlankZero = true;
                            Caption = 'SAV';
                        }
                    }
                }
            }
            group(MargeNette)
            {
                Caption = 'Rentabilité - Synthèse';
                group(Marge)
                {
                    Caption = 'Marge';
                    //The GridLayout property is only supported on controls of type Grid
                    //GridLayout = Rows;
                    field("Cout total Achats+Stock-Cout total hors catégorie"; Rec."Cout total Achats+Stock" - Rec."Cout total hors catégorie")
                    {
                        Caption = 'Coût total catégorisé';
                    }
                    field("Cout total hors catégorie"; Rec."Cout total hors catégorie")
                    {
                        Caption = 'Coût total non catégorisé';
                    }
                    field(CoutVentes; Rec."Cout total Achats+Stock")
                    {
                        Caption = 'Coût total (hors frais)';
                    }
                    field(CATotal; Rec."CA Total")
                    {
                        Caption = 'CA Total';
                    }
                    field("CA Total-Cout total Achats+Stock"; Rec."CA Total" - Rec."Cout total Achats+Stock")
                    {
                        Caption = 'Marge brute';
                    }
                    field("Pourcentage([CA Total]-[Cout total Achats+Stock]/[CA Total]"; Pourcentage(Rec."CA Total" - Rec."Cout total Achats+Stock", Rec."CA Total"))
                    {
                        Caption = 'Marge brute (%)';
                    }
                }
                group(Frais)
                {
                    Caption = 'Frais';
                    //The GridLayout property is only supported on controls of type Grid
                    //GridLayout = Rows;
                    field("Frais d'approche"; Rec."Frais d'approche")
                    {
                    }
                    field("Frais d'emballage"; Rec."Frais d'emballage")
                    {
                    }
                }
                field(MargeNetteMontant; Rec."CA Total" - Rec."Cout total Achats+Stock" - Rec."Frais d'approche" - Rec."Frais d'emballage")
                {
                    Caption = 'Marge nette';
                }
                field(MargeNettePct; Pourcentage(Rec."CA Total" - Rec."Cout total Achats+Stock" - Rec."Frais d'approche" - Rec."Frais d'emballage", Rec."CA Total"))
                {
                    Caption = 'Marge nette (%)';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(Enseignes)
            {
                Caption = 'Enseignes';
                Image = Company;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                
                RunObject = Page "Enseignes";
                RunPageLink = "Code groupe" = field (Code);
            }
        }
    }

    
    procedure Pourcentage(Valeur1: Decimal; Valeur2: Decimal): Decimal
    begin
        if Valeur2 = 0 then
            exit(0)
        else
            exit(Round(Valeur1 / Valeur2 * 100, 1));
    end;
}

