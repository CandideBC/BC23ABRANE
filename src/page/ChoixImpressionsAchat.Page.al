page 50005 "Choix impressions achat"
{
    ApplicationArea = All;
    Caption = 'Choix impressions achat';
    PageType = List;
    SourceTable = "Choix impressions achat";
    UsageCategory = None;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Document; Rec.Document)
                {
                    ToolTip = 'Indique le document qu''il vous est possible d''imprimer.';
                }
                field(Imprimer; Rec.Imprimer)
                {
                    ToolTip = 'A cocher si vous voulez imprimer ce document.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(LancerImpressions)
            {
                ApplicationArea = All;  
                Caption = 'Lancer impression';
                ToolTip = 'Imprimer';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    EnteteAchat: Record "Purchase Header";
                    EtiqPalette: Record "Etiquettes palettes";
                    ChoixImpression: Record "Choix impressions achat";
                    //CommandeAchatReport: Report "ABRANE : Purchase Order";
                    CodeUtil: Code[50];
                begin
                    CodeUtil := CopyStr(UserId, 1, 50);
                    CurrPage.SaveRecord();
                    ChoixImpression.SetRange("Code utilisateur", CodeUtil);
                    if ChoixImpression.FindSet(false) then
                        repeat
                            if ChoixImpression.Imprimer then
                                case ChoixImpression.Document of
                                    'Commande achat':
                                        begin
                                            EnteteAchat.SetRange(EnteteAchat."Document Type", EnteteAchat."Document Type"::Order);
                                            EnteteAchat.SetRange("No.", ChoixImpression."No. document");
                                            //CommandeAchatReport.UseRequestPage(false);
                                            //CommandeAchatReport.SetTableView(EnteteAchat);
                                            //CommandeAchatReport.RunModal();
                                            Report.Run(Report::"ABRANE : Purchase Order", true, true, EnteteAchat);
                                        end;
                                    'Etiquette palette':
                                        begin
                                            EnteteAchat.get(EnteteAchat."Document Type"::Order, ChoixImpression."No. document");
                                            EnteteAchat.GenererEtiquettePalette(false);
                                            EtiqPalette.Reset();
                                            EtiqPalette.SetRange("Code utilisateur", UserId);
                                            Report.run(Report::"Etiquette palette", true, true, EtiqPalette);
                                        end;
                                    'Evolutions commande achat':
                                        begin
                                            EnteteAchat.SetRange(EnteteAchat."Document Type", EnteteAchat."Document Type"::Order);
                                            EnteteAchat.SetRange("No.", ChoixImpression."No. document");
                                            Report.Run(Report::"Evolutions Commande Achat", true, true, EnteteAchat);
                                        end;
                                end;

                        until ChoixImpression.Next() = 0;
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        CodeUtil: code[50];
    begin
        CodeUtil := CopyStr(UserId, 1, 50);
        rec.FilterGroup(2);
        Rec.SetRange("Code utilisateur", CodeUtil);
        Rec.FilterGroup(0);
    end;
}
