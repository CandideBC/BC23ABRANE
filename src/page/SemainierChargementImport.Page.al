page 50137 "Semainier chargement import"
{
    ApplicationArea = All;
    Caption = 'Semainier chargement import';
    PageType = List;
    SourceTable = "Semainier chargement import";
    UsageCategory = None;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Date debut semaine"; Rec."Date debut semaine")
                {
                    ToolTip = 'Date du lundi de la semaine de chargement';
                }
                field("No. semaine"; Rec."No. semaine")
                {
                    ToolTip = 'N° de semaine';
                }
                field("No. fournisseur"; Rec."No. fournisseur")
                {
                    ToolTip = 'N° fournisseur';
                }
                field("Nom du fournisseur"; Rec."Nom du fournisseur")
                {
                    ToolTip = 'Nom du fournisseur';
                }
                field("Mnt restant a charger liv. dir"; Rec."Mnt restant a charger liv. dir")
                {
                    ApplicationArea = All;
                    ToolTip = 'Montant restant à charger en livraison directe';
                    BlankZero = true;
                }
                field("Mnt restant a charger"; Rec."Mnt restant a charger")
                {
                    ToolTip = 'Montant restant à charger';
                    BlankZero = true;
                }
                field("Budget approche"; Rec."Budget approche")
                {
                    ApplicationArea = All;
                    ToolTip = 'Budget approche';
                    BlankZero = true;
                }
                field("Remplissages transport";Rec."Remplissages transport")
                {
                    ApplicationArea = All;
                    ToolTip = 'Remplissage transport';
                }


                field("Nombre commandes"; Rec."Nombre commandes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre de commandes concernées';
                    trigger OnDrillDown()
                    var
                        EnteteAchat: Record "Purchase Header";
                    begin
                        EnteteAchat.SetCurrentKey("No. fournisseur", "Suivi container", "Suivi container OK", "Date intention chargement");
                        EnteteAchat.SetRange("No. fournisseur", Rec."No. fournisseur");
                        EnteteAchat.SetRange("Suivi container", true);
                        EnteteAchat.SetRange("Suivi container OK", false);
                        EnteteAchat.SetRange("Date intention chargement", Rec."Date debut semaine");
                        Page.Run(page::ListeCommandesAchatsImport, EnteteAchat);
                    end;
                }
                /*
                field("Type transport pressenti"; Rec."Type transport pressenti")
                {
                    ApplicationArea = All;
                    ToolTip = 'Transport pressenti';
                }
                */
                field("Date semaine reception prevue"; Rec."Date semaine reception prevue")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date semaine réception prévue';
                    Visible = false;
                }
                field("No. semaine reception prevue"; Rec."No. semaine reception prevue")
                {
                    ApplicationArea = All;
                    ToolTip = 'N° semaine réception prévue';
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Recalculer)
            {
                ApplicationArea = All;
                ToolTip = 'Recalculer le montant à charger par semaine.';
                Caption = 'Calculer';
                RunObject = codeunit CalculerMontantACharger;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Calculate;
            }

            action(VuePlanning)
            {
                ApplicationArea = All;
                ToolTip = 'Affichage sous la forme de planning';
                Caption = 'Vue planning';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Planning;
                trigger OnAction()
                var
                    StatParSemaine: Record "Tampon reste a charger par sem";
                    PagePlanning: Page "Planning chargement par sem.";
                begin
                    Clear(PagePlanning);
                    StatParSemaine.Reset();
                    /*
                    KAN.FHA 07/05/2026 StatParSemaine.FilterGroup(2);
                    //StatParSemaine.SetRange("Code utilisateur", 'BC');
                    //StatParSemaine.FilterGroup(0);
                    */
                    PagePlanning.SetTableView(StatParSemaine);
                    PagePlanning.Run();
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        DateLundiCetteSemaine: date;
    begin
        // 1. On cherche d'abord s'il existe un enregistrement avec un montant > 0
        // On applique un filtre temporaire sur le champ Montant
        Rec.SetFilter("Mnt restant a charger", '>0');

        // 2. On tente de trouver le premier enregistrement correspondant
        if Rec.FindFirst() then 
            // 3. IMPORTANT : On enlève le filtre sur le montant 
            // pour que l'utilisateur voie tous les lundis (même ceux à 0)
            Rec.SetRange("Mnt restant a charger")

            // Le curseur de la page restera positionné sur l'enregistrement 
            // trouvé par le FindFirst, mais la liste affichera tout.
        else begin
            DateLundiCetteSemaine := CalcDate('<-CW>',Today);
            // Si aucun montant n'est trouvé, on se replace au début par défaut
            Rec.SetFilter("Date debut semaine",'>=%1',DateLundiCetteSemaine);
            if Rec.FindFirst() then;
        end;
    end;
}
