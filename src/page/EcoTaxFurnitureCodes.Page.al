page 50012 "Eco Tax Furniture Codes"
{
    Caption = 'Codes taxes Eco-mobilier';
    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = List;
    SourceTable = "Taxe eco-mobilier";

    layout
    {
        area(content)
        {
            repeater(Control8055985)
            {
                ShowCaption = false;
                field("Code"; rec.Code)
                {
                    ToolTip = 'Code';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                }
                field("Code matiere associe"; Rec."Code matiere associe")
                {
                    ToolTip = 'Code matière associé';
                }
                field(Family; Rec.Family)
                {
                    ToolTip = 'Famille';
                }
                field("Sub Family"; Rec."Sub Family")
                {
                    ToolTip = 'Sous-famille';
                }
                field("Unit Amount"; Rec."Unit Amount")
                {
                    ToolTip = 'Montant unitaire';
                }
                field("Account No."; Rec."Account No.")
                {
                    ToolTip = 'N° compte';
                }
                field("Beginning Date"; Rec."Beginning Date")
                {
                    Visible = true;
                    ToolTip = 'Date début';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Paramètres")
            {
                Caption = 'Paramètres';
                ToolTip = 'Paramètres';
                Image = TaxSetup;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Eco Tax FurniturePosting Setup";
                RunPageLink = "eco tax furniture code" = field (Code);
                RunPageView = sorting ("Gen. Bus. Posting Group", "eco tax furniture code")
                              order(ascending);
            }
        }
    }
}

