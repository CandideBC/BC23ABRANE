page 50071 "SF Achats Divers sans affectat"
{
    PageType = ListPart;
    SourceTable = "Affectations achat vente";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. donneur ordre"; Rec."No. donneur ordre")
                {
                    ToolTip = 'N° donneur d''ordre';
                }
                field("Nom donneur ordre"; Rec."Nom donneur ordre")
                {
                    ToolTip = 'Nom donneur ordre';
                }
                field("Type document vente"; Rec."Type document vente")
                {
                    ToolTip = 'Type document vente';
                }
                field("No. document vente"; Rec."No. document vente")
                {
                    ToolTip = 'N° document vente';
                }
                field("No. ligne document vente"; Rec."No. ligne document vente")
                {
                    ToolTip = 'N° ligne document vente';
                }
                field("Quantite affectee"; Rec."Quantite affectee")
                {
                    ToolTip = 'Quantité affectée';
                }
            }
        }
    }

    actions
    {
    }
}

