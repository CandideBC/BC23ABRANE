pageextension 50001 CompanyInformationExtension extends "Company Information"
{
    layout
    {
        addafter(Picture)
        {
            field("Logo simple"; Rec."Logo simple")
            {
                ApplicationArea = All;
                ToolTip = 'Logo simple';
            }
            /*
            field("Ecotax Method"; Rec."Ecotax Method")
            {
                ApplicationArea = All;
                ToolTip = 'Méthode Ecotaxe';
            }
            */
            field("No. registre producteurs"; Rec."No. registre producteurs")
            {
                ApplicationArea = All;
                ToolTip = 'N° registre producteurs';
            }
        }
    }
}

