pageextension 50135 SOProcessorActivitiesExtension extends "SO Processor Activities"
{
    layout
    {
        modify(SalesOrdersReservedFromStock)
        {
            Visible = false;
        }
        /*
        modify(ReadyToShip)
        {
            Visible = false;
        }
        */
        modify("Sales Orders Released Not Shipped")
        {
            Visible = false;
        }

        
    }
    
    
}
