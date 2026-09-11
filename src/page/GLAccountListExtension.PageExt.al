pageextension 50004 GLAccountListExtension extends "G/L Account List"
{
    trigger OnOpenPage()
    var
        
        ParamUtil: Record "User Setup";
        EcranInterditErr: Label 'Vos autorisations ne vous permettant pas d''ouvrir cet écran.';
    
    begin
        //KAN.FHA 06/07/2020 DEBUT
        if not ParamUtil.Get(UserId) then
          ParamUtil.Init();

        if not ParamUtil."Voir ecritures comptables" then
          Error(EcranInterditErr);
        //KAN.FHA 06/07/2020 FIN
    end;


}

