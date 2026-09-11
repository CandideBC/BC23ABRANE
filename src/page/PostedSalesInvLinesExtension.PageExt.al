pageextension 50015 "PostedSalesInvLinesExtension" extends "Posted Sales Invoice Lines"
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
        addafter("Shortcut Dimension 2 Code")
        {
            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = All;
                ToolTip = 'Code magasin';
            }
        }
        addafter("Appl.-to Item Entry")
        {
            field("Code enseigne"; Rec."Code enseigne")
            {
                ApplicationArea = All;
                ToolTip = 'Code enseigne';
            }
            field("Code groupe"; Rec."Code groupe")
            {
                ApplicationArea = All;
                ToolTip = 'Code groupe';
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


        modify(Quantity)
        {
            BlankZero = true;
        }
        modify("Unit Price")
        {
            BlankZero = true;
        }
        modify("Unit Cost (LCY)")
        {
            BlankZero = true;
        }
        modify(Amount)
        {
            BlankZero = true;
        }
        modify("Amount Including VAT")
        {
            BlankZero = true;
        }
        addafter("Unit Cost (LCY)")
        {

            field("Cout ligne HT (DS)"; Rec."Cout ligne HT (DS)")
            {
                ApplicationArea = All;
                ToolTip = 'Coût ligne HT (DS)';
            }
            field("Cout ligne au PMP recalc"; Rec."Cout ligne au PMP recalc")
            {
                ApplicationArea = All;
                ToolTip = 'Code magasin';
            }
            field("Cout detaille"; Rec."Cout detaille")
            {
                ApplicationArea = All;
                ToolTip = 'Coût détaillé';
            }
        }

    }
}
