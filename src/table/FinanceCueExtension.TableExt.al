tableextension 50062 FinanceCueExtension extends "Finance Cue"
{
    fields
    {
        field(50130; "Acomptes a creer"; Integer)
        {
            Caption = 'Acomptes à créer';
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" where ("Document Type"=const(Order),"Acompte a creer"=const(true)));
            Editable = false;

        }
        field(50140; "Situations a creer"; Integer)
        {
            Caption = 'Situations à créer';
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" where ("Document Type"=const(Order),"Demander situ. a la compta"=const(true)));
            Editable = false;
        }
    }
}
