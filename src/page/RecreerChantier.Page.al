page 50003 "Recreer chantier"
{
    Caption = 'Recréer un chantier';
    PageType = StandardDialog;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(Copier)
            {
                Caption = 'Copier';
                group("Chantier origine")
                {
                    Caption = 'Chantier origine';
                    field("AncienChantier.Code"; AncienChantier.Code)
                    {
                        Caption = 'N° chantier';
                        Editable = false;
                        ToolTip = 'Code de l''ancien chantier';
                    }
                    field("AncienChantier.Nom chantier"; AncienChantier."Nom chantier")
                    {
                        Caption = 'Nom chantier';
                        Editable = false;
                        ToolTip = 'Nom chantier';
                    }
                    field("AncienChantier.Ville chantier"; AncienChantier."Ville chantier")
                    {
                        Caption = 'Ville chantier';
                        Editable = false;
                        ToolTip = 'Ville chantier';
                    }
                    field("AncienChantier.Nom client"; AncienChantier."Nom client")
                    {
                        Caption = 'Nom du client';
                        Editable = false;
                        ToolTip = 'Nom du client';
                    }
                }
                group("Préfixes")
                {
                    Caption = 'Préfixes';
                    field(PrefixeChantierOrigine; PrefixeChantierOrigine)
                    {
                        Caption = 'Préfixe chantier origine';
                        Editable = false;
                        ToolTip = 'Préfixe chantier origine';
                    }
                    field(PrefixeEnseigne; PrefixeEnseigne)
                    {
                        Caption = 'Préfixe enseigne';
                        Editable = false;
                        ToolTip = 'Préfixe enseigne';



                    }
                    field(PrefixeNouveauChantier; PrefixeNouveauChantier)
                    {
                        Caption = 'Préfixe Nouveau chantier';
                        ToolTip = 'Préfixe Nouveau chantier';
                    }
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        AncienChantier.Get(NumChantierOrigine);
        AncienChantier.CalcFields("Nom client");
        PrefixeChantierOrigine := AncienChantier."Prefixe chantier";
        Enseigne.Get(AncienChantier."Code enseigne");
        PrefixeEnseigne := Enseigne."Prefixe chantier";
        PrefixeNouveauChantier := PrefixeEnseigne;
    end;

    var
        
        
        Enseigne: Record Enseigne;
        AncienChantier: Record Chantier;
        PrefixeNouveauChantier: Code[5];
        NumChantierOrigine: Code[20];

        PrefixeEnseigne: Code[5];
        PrefixeChantierOrigine: Code[5];

    procedure DefChantierOrigine(pNumChantierOrigine: Code[20])
    begin
        NumChantierOrigine := pNumChantierOrigine;
    end;

    procedure RecupPrefixe(var pPrefixe: Code[5])
    begin
        pPrefixe := PrefixeNouveauChantier;
    end;
}

