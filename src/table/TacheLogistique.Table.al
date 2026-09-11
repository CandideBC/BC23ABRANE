table 50072 "Tache logistique"
{
    Caption = 'Tache logistique';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No. sequence"; Integer)
        {
            Caption = 'No. sequence';
        }
        field(10; "Date"; Date)
        {
            Caption = 'Date';
            trigger OnValidate()
            begin
                if Date <> 0D then begin
                    "No. semaine" := Date2DWY(Date, 2);
                    "Date semaine" := CalcDate('<-CW>', Date)
                end else begin
                    "No. semaine" := 0;
                    "Date semaine" := 0D;
                end;
            end;

        }
        field(15; "No. semaine"; Integer)
        {
            Caption = 'N° semaine';
        }
        field(20; "Date semaine"; Date)
        {
            Caption = 'Date semaine';
        }
        field(30; "Description tache"; Text[100])
        {
            Caption = 'Description tache';
        }
        field(40; "Tache effectuee"; Boolean)
        {
            Caption = 'Tâche effectuée';
        }
    }
    keys
    {
        key(PK; "No. sequence")
        {
            Clustered = true;
        }
        key(MyKey1; "Tache effectuee","Date semaine")
        {

        }
    }
    trigger OnInsert()
    var
        TacheLogistique: Record "Tache logistique";
    begin
        if TacheLogistique.FindLast() then
            Rec."No. sequence" := TacheLogistique."No. sequence" + 1
        else
            rec."No. sequence" := 1;
    end;
}
