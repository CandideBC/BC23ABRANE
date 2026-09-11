report 50035 "MAJ renta du pris sur stock"
{
    // Les écritures de rentabilté où on a pris sur stock et qui ont moins de 3 moins voient leur cout recalculé chaque soir

    Permissions = TableData "Sales Invoice Line" = rm,
                  TableData "Sales Cr.Memo Line" = rm;
    ProcessingOnly = true;

    dataset
    {
        dataitem(PrisSurStock; "Ecriture rentabilite")
        {
            DataItemTableView = sorting ("Type de cout", "Date comptabilisation") where ("Type de cout" = const (Stock));

            trigger OnAfterGetRecord()
            begin
                PrisSurStock.MettreAJourCoutPrisSurStock();
            end;

            trigger OnPreDataItem()
            begin
                PrisSurStock.SetFilter("Date comptabilisation", '>=%1', DateMax);

                if FiltreCodeChantier <> '' then
                    PrisSurStock.SetRange("Code chantier", FiltreCodeChantier);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        DateMax := CalcDate('<-3M>', Today);
    end;

    var
        DateMax: Date;
        FiltreCodeChantier: Code[20];

    procedure DefFiltreChantier(pCodeChantier: Code[20])
    begin
        FiltreCodeChantier := pCodeChantier;
    end;
}

