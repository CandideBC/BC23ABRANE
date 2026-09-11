page 50010 "Feuille rentabilite"
{
    AutoSplitKey = true;
    Caption = 'Item Journal';
    DelayedInsert = true;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = "Ligne feuille rentabilite";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            field(CurrentJnlBatchName; CurrentJnlBatchName)
            {
                Caption = 'Batch Name';
                Lookup = true;
                ToolTip = 'Nom feuille';

                trigger OnLookup(var Text: Text): Boolean
                begin
                    CurrPage.SaveRecord();

                    //IF PAGE.RUNMODAL(9800,recUser) = ACTION::LookupOK THEN BEGIN
                    if PAGE.RunModal(119, recUser) = ACTION::LookupOK then begin
                        CurrentJnlBatchName := recUser."User ID";
                        Rec.FilterGroup := 2;
                        Rec.SetRange(Rec."Code utilisateur", CurrentJnlBatchName);
                        Rec.FilterGroup := 0;
                        if Rec.Find('-') then;
                    end;

                    CurrPage.Update(false);
                end;

                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                    Rec.FilterGroup := 2;
                    Rec.SetRange("Code utilisateur", CurrentJnlBatchName);
                    Rec.FilterGroup := 0;
                    CurrPage.Update(false);
                end;
            }
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code chantier"; Rec."Code chantier")
                {
                    ToolTip = 'Code chantier';
                }
                field("Date comptabilisation"; Rec."Date comptabilisation")
                {
                    ToolTip = 'Date comptabilisation';
                }
                field("Type ecriture"; Rec."Type ecriture")
                {
                    Caption = 'Type écriture';
                    ToolTip = 'Type écriture';
                }
                field("Type de cout"; Rec."Type de cout")
                {
                    Caption = 'Type de coût';
                    ToolTip = 'Type de coût';
                }
                field("Nature vente"; Rec."Nature vente")
                {
                    ToolTip = 'Nature vente';
                }
                field(Quantite; Rec.Quantite)
                {
                    Caption = 'Quantité';
                    ToolTip = 'Quantité';
                }
                field("Cout unitaire (DS)"; Rec."Cout unitaire (DS)")
                {
                    Caption = 'Coût unitaire (DS)';
                    ToolTip = 'Coût unitaire (DS)';
                }
                field("Cout total (DS)"; Rec."Cout total (DS)")
                {
                    Caption = 'Coût total (DS)';
                    ToolTip = 'Coût total (DS)';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                }
            }
            group(Control22)
            {
                ShowCaption = false;
                fixed(Control1900669001)
                {
                    ShowCaption = false;
                    group("Désignation article")
                    {
                        Caption = 'Item Description';
                        field(NomChantier; NomChantier)
                        {
                            Caption = 'Nom du chantier';
                            Editable = false;
                            ToolTip = 'Nom du chantier';
                        }
                    }
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Valider)
            {
                Caption = 'Valider';
                ToolTip = 'Valider';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ValiderFeuilleQst: Label 'Voulez-vous valider cette feuille ?';
                begin
                    if Confirm(ValiderFeuilleQst) then
                        Rec.Valider(CurrentJnlBatchName);
                end;
            }
        }
    }



    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Code utilisateur" := CurrentJnlBatchName;

        if FiltreCodeChantier <> '' then
            Rec."Code chantier" := FiltreCodeChantier;

        Rec."Type ecriture" := Rec."Type ecriture"::"Coût";
        Rec."Type de cout" := Rec."Type de cout"::Achat;
    end;

    trigger OnOpenPage()
    var
        UserNonAutoriseErr: Label 'Vous n''êtes pas autorisé à utiliser cette fonctionnalité.';
    begin
        if not ParamUtil.Get(UserId) then
            ParamUtil.Init();

        if not ParamUtil."Utiliser feuille rentabilite" then
            Error(UserNonAutoriseErr);

        CurrentJnlBatchName := COPYSTR(UserId,1,50);
        Rec.FilterGroup := 2;
        Rec.SetRange("Code utilisateur", CurrentJnlBatchName);
        if FiltreCodeChantier <> '' then
            Rec.SetRange("Code chantier", FiltreCodeChantier);
        Rec.FilterGroup := 0;
        if Rec.Find('-') then;

        /*
        OpenedFromBatch := ("Journal Batch Name" <> '') AND ("Journal Template Name" = '');
        IF OpenedFromBatch THEN BEGIN
          CurrentJnlBatchName := "Journal Batch Name";
          ItemJnlMgt.OpenJnl(CurrentJnlBatchName,Rec);
          EXIT;
        END;
        ItemJnlMgt.TemplateSelection(PAGE::"Item Journal",0,FALSE,Rec,JnlSelected);
        IF NOT JnlSelected THEN
          ERROR('');
        ItemJnlMgt.OpenJnl(CurrentJnlBatchName,Rec);
        */

    end;

    var
        
        ParamUtil: Record "User Setup";
        recUser: Record "User Setup";
        CurrentJnlBatchName: Code[50];
        
        

        FiltreCodeChantier: Code[20];
        NomChantier: Text[50];


    procedure DefContexteAppel(pCodeChantier: Code[20])
    begin
        FiltreCodeChantier := pCodeChantier;
    end;
}

