pageextension 50075 SalesCrMemoStatisticsExtension extends "Sales Credit Memo Statistics"
{

    layout
    {

        modify(LineQty)
        {
            Visible = false;
        }
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
            field("Total Gross Weight"; Rec."Total Gross Weight")
            {
                ToolTip = 'Poids brut total';
            }
            field("Number Of Packages"; Rec."Number Of Packages")
            {
                ToolTip = 'Nombre de colis';
            }
            field("Pallet Number"; Rec."Pallet Number")
            {
                ToolTip = 'N° palette';
            }
        }
    }
 

}

