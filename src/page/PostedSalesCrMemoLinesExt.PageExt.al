pageextension 50093 "PostedSalesCrMemoLinesExt" extends "Posted Sales Credit Memo Lines"
{
    layout
    {
        addafter("Document No.")
        {
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = All;
                ToolTip = 'Date comptabilisation';
            }
        }
        addafter("Sell-to Customer No.")
        {
            field("Bill-to Customer No."; Rec."Bill-to Customer No.")
            {
                ApplicationArea = All;
                ToolTip = 'N° client facturé';
            }
        }

        
        addafter("Job No.")
        {

            field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Groupe compta produit';
            }
            field("Code pays livraison"; Rec."Code pays livraison")
            {
                ApplicationArea = All;
                ToolTip = 'Code pays livraison';
            }
            field("Code matiere article"; Rec."Code matiere article")
            {
                ApplicationArea = All;
                ToolTip = 'Code matière article';
            }
            field("Code taxe éco-mobilier"; Rec."Eco Tax Furniture Code")
            {
                ApplicationArea = All;
                ToolTip = 'Code taxe éco-mobilier';
            }
            field("Montant taxe Codifab"; Rec."Montant taxe Codifab")
            {
                ApplicationArea = All;
                ToolTip = 'Montant taxe Codifab';
            }
        }
    }
}
