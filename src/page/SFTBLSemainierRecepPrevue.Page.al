page 50138 "SF TBL Semainier recep prevue"
{
    ApplicationArea = All;
    Caption = 'Réceptions import';
    PageType = ListPart;
    SourceTable = "Semainier chargement import";
    SourceTableView = sorting("Date semaine reception prevue", "No. fournisseur");
    UsageCategory = None;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Nom du fournisseur"; Rec."Nom du fournisseur")
                {
                    ToolTip = 'Nom du fournisseur';
                }
                field("Mnt restant a charger liv. dir"; Rec."Mnt restant a charger liv. dir")
                {
                    ApplicationArea = All;
                    ToolTip = 'Montant restant à charger en livraison directe';
                }
                field("Mnt restant a charger"; Rec."Mnt restant a charger")
                {
                    ToolTip = 'Montant restant à charger';
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
                        Page.Run(page::"Purchase Order List", EnteteAchat);
                    end;
                }
                //field("Date semaine reception prevue"; Rec."Date semaine reception prevue")
                //{
                //    ApplicationArea = All;
                //    ToolTip = 'Date semaine réception prévue';
                //}
                field("No. semaine reception prevue"; Rec."No. semaine reception prevue")
                {
                    ApplicationArea = All;
                    ToolTip = 'N° semaine réception prévue';
                    Visible = false;
                }

                field("No. fournisseur"; Rec."No. fournisseur")
                {
                    ToolTip = 'N° fournisseur';
                    Visible = false;
                }
                field("No. semaine"; Rec."No. semaine")
                {
                    Caption = 'Semaine chargement';
                    ToolTip = 'N° de semaine';
                    Visible = false;
                }
                field("Remplissages transport"; Rec."Remplissages transport")
                {
                    ToolTip = 'Remplissages transport';
                    ApplicationArea = All;
                }
                

            }
        }
    }
    
    actions
    {
        area(Processing)
        {



        }
        
    }
    
    /*
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
    */
}
