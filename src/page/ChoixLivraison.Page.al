page 50157 "Choix Livraison"
{
    PageType = StandardDialog;
    Caption = 'Expédition';

layout
    {
        area(Content)
        {
            group(General)
            {
                ShowCaption = false;

                field(SelonColisage; SelonColisage)
                {
                    ApplicationArea = All;
                    Caption = 'Livrer selon colisage';
                    Visible = ColisageDisponible;

                    trigger OnValidate()
                    begin
                        // se comporte comme un radio : on ne peut pas tout décocher
                        SelonQuantites := not SelonColisage;
                        CurrPage.Update(false);
                    end;
                }
                field(SelonQuantites; SelonQuantites)
                {
                    ApplicationArea = All;
                    Caption = 'Livrer selon quantités à expédier';

                    trigger OnValidate()
                    begin
                        if SelonQuantites then
                            SelonColisage := false
                        else
                            if ColisageDisponible then
                                SelonColisage := true
                            else
                                SelonQuantites := true; // seule option possible
                        CurrPage.Update(false);
                    end;
                }
                field(DateCompta; DateCompta)
                {
                    ApplicationArea = All;
                    Caption = 'Date comptabilisation';
                    ShowMandatory = true;
                }
            }
        }
    }
    var
        SelonColisage: Boolean;
        SelonQuantites: Boolean;
        ModeLivraison: Option Quantites,Colisage;
        DateCompta: Date;
        ColisageDisponible: Boolean;

    procedure Init(NewColisageDisponible: Boolean; NewDate: Date)
    begin
        ColisageDisponible := NewColisageDisponible;
        DateCompta := NewDate;
        if ColisageDisponible then
            ModeLivraison := ModeLivraison::Colisage
        else
            ModeLivraison := ModeLivraison::Quantites;
    end;

    procedure GetResult(var OutColisage: Boolean; var OutDate: Date)
    begin
        OutColisage := ModeLivraison = ModeLivraison::Colisage;
        OutDate := DateCompta;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction = Action::OK then
            if DateCompta = 0D then
                Error('La date de comptabilisation est obligatoire.');
    end;
}