page 50013 "Eco Tax FurniturePosting Setup"
{
    Caption = 'Paramétrage taxe éco-mobilier';
    DataCaptionFields = "eco tax furniture code";
    PageType = List;
    SourceTable = "Parametrage taxe eco-mobilier";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control8055988)
            {
                ShowCaption = false;
                field("eco tax furniture code"; Rec."eco tax furniture code")
                {
                    Visible = false;
                    ToolTip = 'Code taxe éco-mobilier';
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Groupe compta marché';
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Groupe compta marché TVA';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Groupe compta produit';
                }
                field("Sales Account"; rec."Sales Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Compte de ventes';
                }
                field("Purchase Account"; Rec."Purchase Account")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Compte achats';
                }
            }
        }
    }

    actions
    {
    }
}

