page 50077 "Liste groupes"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageID = "Fiche groupe";
    PageType = List;
    SourceTable = "Groupe client";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Code';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                }
                field("Montant factures ventes"; Rec."Montant factures ventes")
                {
                    ToolTip = 'Montant factures ventes';
                    Visible = UserAutorise;
                }
                field("Montant avoirs ventes"; Rec."Montant avoirs ventes")
                {
                    ToolTip = 'Montant avoirs ventes';
                    Visible = UserAutorise;
                }
                field("Montant factures ventes-Montant avoirs ventes"; Rec."Montant factures ventes" - Rec."Montant avoirs ventes")
                {
                    ToolTip = 'Montant factures ventes-Montant avoirs ventes';
                    BlankZero = true;
                    Caption = 'Chiffre d''affaires';
                    Visible = UserAutorise;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(Enseignes)
            {
                Caption = 'Enseignes';
                ToolTip = 'Enseignes';
                Image = Company;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Enseignes";
                RunPageLink = "Code groupe" = field (Code);
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not ParamUtil.Get(UserId) then
            ParamUtil.Init();

        UserAutorise := ParamUtil."Voir CA groupes et enseignes";
    end;

    var
        ParamUtil: Record "User Setup";
        UserAutorise: Boolean;

}

