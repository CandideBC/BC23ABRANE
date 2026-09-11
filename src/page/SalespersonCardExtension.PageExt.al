pageextension 50139 SalespersonCardExtension extends "Salesperson/Purchaser Card"
{
    layout
    {
        addlast(General)
        {
            field(Pole; Rec.Pole)
            {
                ApplicationArea = All;
            }
            field(Dessinateur; Rec.Dessinateur)
            {
                ApplicationArea = All;
                ToolTip = 'Indique que ce code vendeur est un dessinateur';
            }
            field("Code utilisateur lie"; Rec."Code utilisateur lie")
            {
                ApplicationArea = All;
                ToolTip = 'Utilisateur lié à ce vendeur.';
            }
            
            
        }
    }
}
