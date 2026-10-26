tableextension 50064 SalesCueExtension extends "Sales Cue"
{
    fields
    {
        field(50000; "Nombre doc. OCR en attente"; Integer)
        {
            Caption = 'Nombre doc. OCR en attente';
            FieldClass = FlowField;
            CalcFormula = count("Entete OCR vente" where ("Document OCR traite"=const(false)));
            Editable = false;
        }
    }
}
