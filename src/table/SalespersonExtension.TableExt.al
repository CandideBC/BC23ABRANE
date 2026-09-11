tableextension 50045 SalespersonExtension extends "Salesperson/Purchaser"
{
    fields
    {
        field(50000; Pole; Text[30])
        {
            Caption = 'Pole';
            DataClassification = ToBeClassified;
        }
        field(50010; "Dessinateur"; Boolean)
        {
            Caption = 'Dessinateur';
            DataClassification = ToBeClassified;
            Description = 'Indique que ce vendeur peut être sélectionné sur les fiches BE.';
        }
        field(50020; "Code utilisateur lie"; Code[50])
        {
            Caption = 'Code utilisateur lié';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
            ValidateTableRelation = false;
            Description = 'Pour préremplir le code vendeur/code acheteur sur les documents de ventes/achats.';
        }
    }
}
