page 50047 "SFSaisieArticleNomenclature"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Nomenclature saisie article";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("N° article"; Rec."N° article")
                {
                    ToolTip = 'N° article';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                }
                //field("Indice article"; Rec."Indice article")
                //{
                //}
                field(Quantite; Rec.Quantite)
                {
                    ToolTip = 'Quantité';
                }
            }
        }
    }

    actions
    {
    }
}

