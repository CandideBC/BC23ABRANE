report 50033 "Fiche palette"
{
    UsageCategory = None;
    // DIA£NBE 02/01/2015
    DefaultLayout = RDLC;
    RDLCLayout = './src/ReportLayout/FichePalette.rdlc';
    Description = 'Etat imprimable depuis une fiche article';

    dataset
    {
        dataitem(Item; Item)
        {
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = sorting (Number);
                column(Item_No; Item."No.")
                {
                }
                column(Item_Description; Item.Description)
                {
                }
                column(CopyLoop_Regroupement; txtRegroupement)
                {
                }
                column(Item_Ref; Item."No. 2")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    txtRegroupement := Item."No." + Format(Number);
                end;

                trigger OnPreDataItem()
                begin
                    if intCopyLoop = 0 then
                        intCopyLoop := 1;

                    SetRange(Number, 1, intCopyLoop);
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(CopyLoop; intCopyLoop)
                {
                    Caption = 'Nombre de copies';
                    ToolTip = 'Nombre de copies';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        labQuantite = 'QUANTITE';
        labJour = 'JOUR';
        labSemaine = 'SEMAINE';
    }

    trigger OnInitReport()
    begin
        intCopyLoop := 1;
    end;

    var
        intCopyLoop: Integer;
        txtRegroupement: Text[30];
}

