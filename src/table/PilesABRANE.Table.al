table 50063 "Piles ABRANE"
{
    Caption = 'Piles ABRANE';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
        }
        field(10; "Nouvelles fiches BE"; Integer)
        {
            Caption = 'Nouvelles fiches BE';
            CalcFormula = count("Ligne fiche BE" where ("Statut ligne" = const(" ")));
            FieldClass = FlowField;
        }
        field(20; "Fiches BE en cours"; Integer)
        {
            Caption = 'Fiches BE en cours';
            CalcFormula = count("Ligne fiche BE" where ("Statut ligne" = const("En cours")));
            FieldClass = FlowField;
        }
        field(30; "Alertes decalages date"; Integer)
        {
            Caption = 'Notif. changements pour BE';
            CalcFormula = count("Dossier BE" where ("Alerte decalage date" = const(true)));
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
