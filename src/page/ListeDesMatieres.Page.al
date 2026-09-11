page 50009 "Liste des matieres"
{
    Caption = 'Liste des matieres';
    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = List;
    SourceTable = Matiere;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Code eco-taxe obligatoire"; Rec."Code eco-taxe obligatoire")
                {
                    ApplicationArea = all;
                    ToolTip = 'Imposera de saisir un code éco-taxe au moment de la création d''article.';
                }
                
            }
        }
    }

    actions
    {
    }
}

