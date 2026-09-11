tableextension 50044 RequisitionLineExtension extends "Requisition Line"
{
    fields
    {
        field(50000; "Complement ref. client"; Text[30])
        {
            CalcFormula = lookup (Item."Complement ref. client" where ("No." = field ("No.")));
            Caption = 'Complément réf. client';
            Description = 'DIA';
            FieldClass = FlowField;
        }
        field(50001; "No. 2"; Code[20])
        {
            CalcFormula = lookup (Item."No. 2" where ("No." = field ("No.")));
            Caption = 'N° 2';
            FieldClass = FlowField;
        }
        field(50050; LineSelected; Boolean)
        {
            Caption = 'Sélectionnée';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var

            begin
                if (Type = Type::" ") then
                    Error('Seules les lignes de détail peuvent être sélectionnées');
            end;
        }
    }
}

