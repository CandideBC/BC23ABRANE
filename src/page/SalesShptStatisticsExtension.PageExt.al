pageextension 50073 SalesShptStatisticsExtension extends "Sales Shipment Statistics"
{

    layout
    {


        modify(TotalParcels)
        {
            Visible = false;
        }
        modify(TotalNetWeight)
        {
            Visible = false;
        }
        modify(TotalGrossWeight)
        {
            Visible = false;
        }
        modify(TotalVolume)
        {
            Visible = false;
        }



        addafter(TotalVolume)
        {

            field("Total Net Weight"; Rec."Total Net Weight")
            {
                ApplicationArea = All;
                ToolTip = 'Poids net total';
            }
            field("Poids brut total";Rec."Poids brut total")
            {
                ApplicationArea = All;
                ToolTip = 'Poids brut total';
            }
            field("Nombre de colis";Rec."Nombre de colis")
            {
                ApplicationArea = All;
                ToolTip = 'Nombre de colis';
            }
            field("Nombre de palettes";Rec."Nombre de palettes")
            {
                ApplicationArea = All;
                ToolTip = 'Nombre de palettes';
            }
        }
    }
 

}

