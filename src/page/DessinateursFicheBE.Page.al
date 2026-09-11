page 50116 "Dessinateurs fiche BE"
{
    ApplicationArea = All;
    Caption = 'Dessinateurs fiche BE';
    PageType = List;
    SourceTable = "Dessinateurs fiche BE";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code dessinateur"; Rec."Code dessinateur")
                {
                }
                field(Affecte; Rec.Affecte)
                {
                }
            }
        }
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        LigneBE: Record "Ligne fiche BE";
    begin
        if CloseAction = CloseAction::OK then begin
            LigneBE.Get(Rec."No. dossier BE", Rec."No. ligne");
            LigneBE.Dessinateurs := LigneBE.ListerDessinateurs();
            LigneBE.Modify();
        end;
    end;
}
