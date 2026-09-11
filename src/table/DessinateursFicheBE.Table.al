table 50058 "Dessinateurs fiche BE"
{
    Caption = 'Dessinateurs fiche BE';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Dessinateurs fiche BE";

    fields
    {
        field(1; "No. dossier BE"; Code[20])
        {
            Caption = 'N° dossier BE';
            TableRelation = "Dossier BE";
        }
        field(10; "No. ligne"; Integer)
        {
            Caption = 'N° ligne';
        }

        field(20; "Code dessinateur"; Code[20])
        {
            Caption = 'Code dessinateur';
            TableRelation = "Salesperson/Purchaser" where(Dessinateur = const(true));
            trigger OnValidate()
            var
                ParamUtil: Record "User Setup";
                UtilNonAutoriseErr: Label 'Vous n''êtes pas autorisé à compléter ce champ.';
            begin
                if not ParamUtil.Get(UserId) then
                    ParamUtil.init();
                if not ParamUtil."Completer fiches BE" then
                    error(UtilNonAutoriseErr);
            end;
        }
        field(30; Affecte; Boolean)
        {
            Caption = 'Affecté';
            trigger OnValidate()
            var
                ParamUtil: Record "User Setup";
                LigneBE: Record "Ligne fiche BE";
                UtilNonAutoriseErr: Label 'Vous n''êtes pas autorisé à compléter ce champ.';
            begin
                if not ParamUtil.Get(UserId) then
                    ParamUtil.init();
                if not ParamUtil."Completer fiches BE" then
                    error(UtilNonAutoriseErr);

            end;
        }
    }
    keys
    {
        key(PK; "No. dossier BE", "No. ligne","Code dessinateur")
        {
            Clustered = true;
        }
        key(MyKey1; "No. dossier BE","No. ligne",Affecte)
        {
            
        }

    }

}
