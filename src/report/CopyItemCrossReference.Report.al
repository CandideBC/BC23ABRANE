report 50020 "Copy Item Cross Reference"
{
    // DIA.ABRA.REF NBE 08/12/2014
    UsageCategory = None;
    

    Caption = 'Copier références externes';
    ProcessingOnly = true;

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(codClient; codClient)
                    {
                        Caption = 'N° client';
                        ToolTip = 'N° client';
                        NotBlank = true;
                        TableRelation = Customer;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        if not Confirm(StrSubstNo(Text50000Qst, codClient)) then
            Error(Text50001Err);

        if codClient <> '' then begin
            if recRefExterne.FindSet() then begin
                repeat
                    if not recRefExterneInsert.Get(recRefExterne."Item No.",recRefExterne."Variant Code",recRefExterne."Unit of Measure",recRefExterne."Reference Type",codClient,recRefExterne."Reference No.")
                    then begin
                        recRefExterneInsert.Init();
                        recRefExterneInsert := recRefExterne;
                        recRefExterneInsert."Reference Type No." := codClient;
                        recRefExterneInsert.Insert();
                    end;
                until recRefExterne.Next() = 0;
                Message(StrSubstNo(Text50003Msg, codClient));
            end;
        end else
            Error(Text50002Err);
    end;

    var
        recRefExterneInsert: Record "Item Reference";
        recRefExterne: Record "Item Reference";
        codClient: Code[20];
        Text50000Qst: Label 'Voulez-vous copier les références articles vers le client %1 ?',Comment='%1 = N° client';
        Text50001Err: Label 'Opération annulée';
        Text50002Err: Label 'Client obligatoire';
        Text50003Msg: Label 'Les références ont été copiées vers le client N°%1.',Comment='%1 = N° client';

    
    procedure fctInitValue(var p_recReferenceExterne: Record "Item Reference")
    begin
        recRefExterne.Copy(p_recReferenceExterne);
    end;
}

