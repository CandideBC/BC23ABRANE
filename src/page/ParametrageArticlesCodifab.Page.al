page 50051 "Parametrage articles Codifab"
{
    ApplicationArea = All;
    
    Caption = 'Paramétrage articles Codifab';
    PageType = List;
    SourceTable = "Parametrage articles Codifab";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code matiere"; Rec."Code matiere")
                {
                    ToolTip = 'Code matière';
                }
                field("Code taxe eco-mobilier"; Rec."Code taxe eco-mobilier")
                {
                    ToolTip = 'Code taxe éco-mobilier';
                }
                field("Montant Codifab factures"; Rec."Montant Codifab factures")
                {
                    ToolTip = 'Montant Codifab factures';
                }
                field("Montant Codifab avoirs"; Rec."Montant Codifab avoirs")
                {
                    ToolTip = 'Montant Codifab avoirs';
                }
            }
        }
    }

    actions
    {
    }
}

