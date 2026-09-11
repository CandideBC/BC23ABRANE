pageextension 50024 ExchRateAdjmtRegisterExtension extends "Exchange Rate Adjmt. Register"
{

    layout
    {

        
        addafter("Currency Code")
        {

            field("Currency Factor"; Rec."Currency Factor")
            {
                ToolTip = 'Facteur devise';
            }

        }

        
    }




        
}

