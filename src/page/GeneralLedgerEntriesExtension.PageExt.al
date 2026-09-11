pageextension 50005 GeneralLedgerEntriesExtension extends "General Ledger Entries"
{
    layout
    {
        addafter("External Document No.")
        {
            field("Commentaire interne"; Rec."Commentaire interne")
            {
                ApplicationArea = All;
                ToolTip = 'Commentaire interne';
            }
            field("Code enseigne"; Rec."Code enseigne")
            {
                ApplicationArea = All;
                ToolTip = 'Code enseigne';
            }
        }

    }
    actions
    {
        addafter(DocsWithoutIC)
        {
            action("Modifier libellé écritures")
            {
                ApplicationArea = All;
                Caption = 'Modifier libellé écritures';
                Image = EditLines;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Update Description Entry";
                RunPageOnRec = true;
                ToolTip = 'Modifier libellé écritures';


            }
        }
    }

    var
        

        
        EcranInterditErr: Label 'Vos autorisations ne vous permettant pas d''ouvrir cet écran.';

        //Unsupported feature: Code Insertion on "OnOpenPage".
        //trigger OnOpenPage()
        //begin
        /*
        //KAN.FHA 06/07/2020 DEBUT
        if not ParamUtil.Get(UserId) then
          ParamUtil.Init;

        if not ParamUtil."Voir ecritures comptables" then
          Error(EcranInterditErr);
        //KAN.FHA 06/07/2020 FIN
        */
        //end;
}

