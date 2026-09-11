page 50139 "SF TBL Taches logistiques"
{
    ApplicationArea = All;
    Caption = 'Tâches logistiques';
    PageType = ListPart;
    SourceTable = "Tache logistique";
    SourceTableView = sorting("Tache effectuee","Date semaine") where ("Tache effectuee"=const(false));
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
    actions
    {
        area(Processing)
        {
            action(Editer)
            {
                ApplicationArea = All;
                Caption = 'Modifier';
                ToolTip = 'Permet de modifier la tâche, par exemple en indiquant qu''elle est terminée.';
                
                trigger OnAction()
                begin
                    Page.Run(Page::"Liste taches logistiques",Rec);
                end;
            }
        }
    }
}
