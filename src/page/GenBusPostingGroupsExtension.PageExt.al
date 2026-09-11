pageextension 50068 GenBusPostingGroupsExtension extends "Gen. Business Posting Groups"
{
    layout
    {

        addafter("Auto Insert Default")
        {
            field("Compte acompte"; Rec."Compte acompte")
            {
                ApplicationArea = All;
                Caption = 'Compte acompte';
                ToolTip = 'Compte acompte';
            }
            field("Soumis Eco-Taxe"; Rec."Soumis Eco-Taxe")
            {
                ApplicationArea = All;
                Caption = 'Soumis Eco-Taxe';
                ToolTip = 'Soumis Eco-Taxe';
            }         
            field("Code conditions de paiement"; Rec."Code conditions de paiement")
            {
                ApplicationArea = All;
                Caption = 'Code conditions de paiement';
                ToolTip = 'Code conditions de paiement';
            }            
        }
    }
    actions
    {


    }
}
