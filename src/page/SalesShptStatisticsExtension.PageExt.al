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
                ToolTip = 'Poids net total';
            }
            field("Poids brut total";Rec."Poids brut total")
            {
                ToolTip = 'Poids brut total';
            }
            field("Nombre de colis";Rec."Nombre de colis")
            {
                ToolTip = 'Nombre de colis';
            }
            field("Nombre de palettes";Rec."Nombre de palettes")
            {
                ToolTip = 'Nombre de palettes';
            }
        }
    }
 

}

