page 50140 "Liste taches logistiques"
{
    ApplicationArea = All;
    Caption = 'Liste tâches logistiques';
    PageType = List;
    SourceTable = "Tache logistique";
    UsageCategory = Lists;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Date à laquelle la tâche doit être réalisée.';
                }
                field("Description tache"; Rec."Description tache")
                {
                    ToolTip = 'Description de la tâche à réaliser.';
                }
                field("Tache effectuee"; Rec."Tache effectuee")
                {
                    ToolTip = 'Permet d''indiquer que la tâche a été réalisée.';
                }
            }
        }
    }
}
