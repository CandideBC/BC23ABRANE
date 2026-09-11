report 50001 "Planning BE"
{
    ApplicationArea = All;
    Caption = 'Planning BE';
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = PlanningBEExcel;


    dataset
    {
        dataitem(TamponPlanningBE; TamponPlanningBE)
        {
            DataItemTableView = sorting("No. semaine");
            column(Nosemaine; "No. semaine")
            {
            }
            column(NodocumentD1; "No. document D1")
            {
            }
            column(NomchantierD1; "Nom chantier D1")
            {
            }
            column(DescriptiondelademandeD1; "Description de la demande D1")
            {
            }
            column(PJD1; "PJ D1 ?")
            {
            }
            column(DLCD1; "DLC D1")
            {
            }
            column(StatutLigneD1; "Statut ligne D1")
            {
            }
            column(NodocumentD2; "No. document D2")
            {
            }
            column(NomchantierD2; "Nom chantier D2")
            {
            }
            column(DescriptiondelademandeD2; "Description de la demande D2")
            {
            }
            column(PJD2; "PJ D2 ?")
            {
            }
            column(DLCD2; "DLC D2")
            {
            }
            column(StatutLigneD2; "Statut ligne D2")
            {
            }
            column(NodocumentD3; "No. document D3")
            {
            }
            column(NomchantierD3; "Nom chantier D3")
            {
            }
            column(DescriptiondelademandeD3; "Description de la demande D3")
            {
            }
            column(PJD3; "PJ D3 ?")
            {
            }
            column(DLCD3; "DLC D3")
            {
            }
            column(StatutLigneD3; "Statut ligne D3")
            {
            }

            column(NodocumentD4; "No. document D4")
            {
            }
            column(NomchantierD4; "Nom chantier D4")
            {
            }
            column(DescriptiondelademandeD4; "Description de la demande D4")
            {
            }
            column(PJD4; "PJ D4 ?")
            {
            }
            column(DLCD4; "DLC D4")
            {
            }
            column(StatutLigneD4; "Statut ligne D4")
            {
            }
            column(NodocumentD5; "No. document D5")
            {
            }
            column(NomchantierD5; "Nom chantier D5")
            {
            }
            column(DescriptiondelademandeD5; "Description de la demande D5")
            {
            }
            column(PJD5; "PJ D5 ?")
            {
            }
            column(DLCD5; "DLC D5")
            {
            }
            column(StatutLigneD5; "Statut ligne D5")
            {
            }

        }
    }

    rendering
    {
        layout(PlanningBEExcel)
        {
            Type = Excel;
            LayoutFile = './src/ReportLayout/PlanningBE.xlsx';
        }

    }

}
