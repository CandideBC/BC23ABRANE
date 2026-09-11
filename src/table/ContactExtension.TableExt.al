tableextension 50061 ContactExtension extends Contact
{
    fields
    {
        field(66666; "Copier vers Enseigne"; Code[20])
        {
            Caption = 'Copier vers Enseigne';
            TableRelation = Enseigne;
            DataClassification = ToBeClassified;
            Description = 'Champ temporaire utilisé au moment de la bascule vers BC qu''pourra ensuite supprimer car Contact plus utilisée.';
            trigger OnValidate()
            var
                InterlocuteurEnseigne: Record "Interlocuteurs Enseigne";
            begin
                TestField(Type,Type::Person);
                IF Rec."Copier vers Enseigne" <> '' then begin
                    InterlocuteurEnseigne.Init();
                    InterlocuteurEnseigne."Code enseigne" := rec."Copier vers Enseigne";
                    InterlocuteurEnseigne."No. contact NAV" := Rec."No.";
                    InterlocuteurEnseigne."Nom complet" := rec.Name;
                    InterlocuteurEnseigne."No. telephone" := rec."Phone No.";
                    InterlocuteurEnseigne."No. telephone mobile" := rec."Mobile Phone No.";
                    InterlocuteurEnseigne."E-Mail" := Rec."E-Mail";
                    InterlocuteurEnseigne."Code appellation" := Rec."Salutation Code";
                    InterlocuteurEnseigne.Fonction := Rec."Job Title";
                    InterlocuteurEnseigne.Insert(true);
                end;


            end;
        }
    }
}
