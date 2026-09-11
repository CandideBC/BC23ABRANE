page 50048 "SF tous composants crea nom."
{
    // Cette page est affichee en sous-form de la page 50046 (creation d'article nomenclature) mais sans lien avec l'article parent.
    // En effet, elle permet de coller depuis Excel tous les composants de toutes les nomenclatures en une seule fois et non parent par parent

    AutoSplitKey = true;
    DelayedInsert = false;
    PageType = ListPart;
    SourceTable = "Nomenclature saisie article";
    SourceTableView = sorting("Code utilisateur");

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. article parent"; Rec."No. article parent")
                {
                    ToolTip = 'N° article parent';
                }
                field("N° article"; Rec."N° article")
                {
                    ToolTip = 'N° article';
                }
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

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.SetRange("Code utilisateur", UserId);
        Rec.FilterGroup(0);
    end;
}

