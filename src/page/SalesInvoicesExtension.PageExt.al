pageextension 50046 SalesInvoicesExtension extends "Sales invoice list"
{
    layout
    {
        addafter("Location Code")
        {


          
            field("Code groupe"; Rec."Code groupe")
            {
                ApplicationArea = All;
                ToolTip = 'Code groupe';
            }
            field("Code enseigne"; Rec."Code enseigne")
            {
                ApplicationArea = All;
                ToolTip = 'Code enseigne';
            }
            field("Code operation"; Rec."Code operation")
            {
                ApplicationArea = All;
                ToolTip = 'Code opération';
            }
            field("Code chantier"; Rec."Code chantier")
            {
                ApplicationArea = All;
                ToolTip = 'Code chantier';
            }
        }
        addafter("Shipment Date")
        {
            field("Facture acompte"; Rec."Facture acompte")
            {
                ApplicationArea = All;
                ToolTip = 'Facture acompte';
            }

        }


    }
}
