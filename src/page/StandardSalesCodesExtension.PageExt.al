pageextension 50062 StandardSalesCodesExtension extends "Standard Sales Codes"
{
    Caption = 'Devis types';
    layout
    {
        
        addafter("Currency Code")
        {

            field("Groupe prix client"; Rec."Groupe prix client")
            {
                ApplicationArea = All;
                ToolTip = 'Groupe prix client';
            }
            field("No. client"; Rec."No. client")
            {
                ApplicationArea = All;
                ToolTip = 'N° client';
            }
            field("Nom du client"; Rec."Nom du client")
            {
                ApplicationArea = All;
                ToolTip = 'Nom du client';
            }
            field("Code enseigne"; Rec."Code enseigne")
            {
                ApplicationArea = All;
                ToolTip = 'Code enseigne';
            }
            
            field("Devis Stock"; Rec."Devis Stock")
            {
                ApplicationArea = All;
                ToolTip = 'Devis Stock';
            }
        }
    }
}

