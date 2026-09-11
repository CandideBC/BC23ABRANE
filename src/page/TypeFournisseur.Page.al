page 50039 "Type fournisseur"
{
    PageType = List;
    SourceTable = "Type fournisseur";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code type"; Rec."Code type")
                {
                    Caption = 'Code';
                    ToolTip = 'Code';
                    
                }
                field("Libellé"; Rec.Libellé)
                {
                    ToolTip = 'Description';
                }
                field("Annee cde ach = annee chargt"; Rec."Annee cde ach = annee chargt")
                {
                    ApplicationArea = All;
                    ToolTip = 'Si coché, c''est l''année de chargement qui servira comme valeur pour l''année de la commande d''achat';
                }
                
            }
        }
    }

    actions
    {
    }
}

