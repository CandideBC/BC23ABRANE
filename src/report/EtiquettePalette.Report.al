report 50098 "Etiquette palette"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/ReportLayout/EtiquettePalette.rdlc';
    Caption = 'Etiquette palette';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(ShipLab; "Etiquettes palettes")
        {
            column(Logo; InfoSoc."Logo simple")
            {
            }
            column(UserID_ShipLab; ShipLab."Code utilisateur")
            {
            }
            column(No_ShipLab; ShipLab."No. container")
            {
            }
            column(NumPalette_ShipLab; ShipLab."No. palette")
            {
            }
            column(Phase_ShipLab; ShipLab.Phase)
            {
            }
            column(PackingListNo_ShipLab; ShipLab."No. packing list")
            {
            }
            column(Name_ShipLab; ShipLab."Nom chantier")
            {
            }
            column(Name2_ShipLab; ShipLab."Nom chantier 2")
            {
            }
            column(Address_ShipLab; ShipLab."Adresse chantier")
            {
            }
            column(Address2_ShipLab; ShipLab."Adresse chantier 2")
            {
            }
            column(PostCode_ShipLab; ShipLab."Code postal chantier")
            {
            }
            column(City_ShipLab; ShipLab."Ville chantier")
            {
            }
            column(CountryRegionCode_ShipLab; Pays.Name)
            {
            }
            column(ContactChantier_ShipLab; ShipLab."Contact/No. tel chantier")
            {
            }
            column(NoCdeAchat_ShipLab; ShipLab."No. commande achat")
            {
            }
            dataitem(NoOfLabelsLoop; "Integer")
            {
                column(NoofLab; ShipLab."Nb etiquettes")
                {
                }
                column(LabelNo; ShipLab."Nb etiquettes" * 10 + NoOfLabelsLoop.Number)
                {
                }

                trigger OnPreDataItem()
                begin
                    NoOfLabelsLoop.SetRange(Number, 1, ShipLab."Nb etiquettes");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if not Pays.Get(ShipLab."Code pays chantier") then
                    Pays.Init();
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
        TitreEtiquetteLbl = 'PALETTE PRETE A PARTIR';
        PackingListNoLbl = 'N° PACKING LIST :';
        VerifieParLbl = 'VERIFIE PAR :';
        DateLbl = 'DATE :';
        PhaseLbl = 'PHASE N° :';
        NumPaletteAbraneLbl = 'N° PALETTE ABRANE';
    }

    trigger OnPreReport()
    begin
        //KAN.FHA 05/09/2022 DEBUT
        InfoSoc.Get();
        InfoSoc.CalcFields("Logo simple");
        //KAN.FHA 05/09/2022 FIN
    end;

    var

        Pays: Record "Country/Region";
        InfoSoc: Record "Company Information";
}

