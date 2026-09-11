page 50102 "Liste dossiers BE"
{
    ApplicationArea = All;
    Caption = 'Liste dossiers BE';
    PageType = List;
    SourceTable = "Dossier BE";
    SourceTableView= sorting(Archive, "Date chargement") where (Archive=const(false));
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "Fiche dossier BE";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'N°';
                    Editable = false;
                }
                field("Date demande"; Rec."Date demande")
                {
                    ToolTip = 'Date de la demande';
                    Editable = false;
                }
                field("Type document"; Rec."Type document")
                {
                    ToolTip = 'Type document';
                    Editable = false;
                }
                field("No. document"; Rec."No. document")
                {
                    ToolTip = 'N° document';
                    Editable = false;
                }
                field("Nom du prospect/client"; Rec."Nom du prospect/client")
                {
                    ToolTip = 'Nom du prospect/client';
                    Editable = false;
                    StyleExpr = MonStyle;
                }
                field(Commentaires; Rec.Commentaires)
                {
                    ApplicationArea = All;
                    ToolTip = 'Commentaires';
                    Editable = false;
                }
                field("Code vendeur"; Rec."Code vendeur")
                {
                    ToolTip = 'Indique le code vendeur';
                    Editable = false;
                }

                field("Date chargement"; Rec."Date chargement")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date chargement';
                    Editable = false;
                }
                field("Date livraison demandée"; Rec."Date livraison demandée")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date livraison demandée';
                    Editable = false;
                }

                field("Nb fiches BE actives"; Rec."Nb fiches BE actives")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indique le nombre de fiches dont le statut est Vide ou En cours';
                }
                field("Nb fiches BE"; Rec."Nb fiches BE")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre total de fiches du dossier';
                }
                field(PctAvancementBE; PctAvancementBE)
                {
                    ApplicationArea = All;
                    Caption = '% avancement BE';
                    DecimalPlaces = 0:0;
                    Editable = false;
                    ToolTip = '% de fiches qui sont terminées ou annulées.';
                }
                field("PJ sur serveur"; Rec."PJ sur serveur")
                {
                    ToolTip = 'PJ sur serveur';
                    Caption = 'PJ sur serveur';
                    Visible = true;
                }
                
                field("Alerte decalage date"; Rec."Alerte decalage date")
                {
                    ApplicationArea = All;
                }
                field("Detail alerte"; Rec."Detail alerte")
                {
                    ApplicationArea = All;
                }
                
                field(Annule; Rec.Annule)
                {
                    ToolTip = 'Indique si la fiche a été annulée';
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(AfficherDocument)
            {
                    Caption = 'Afficher document';
                    Tooltip = 'Affiche le document lié au dossier.';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = ViewOrder;
                    trigger OnAction()
                    begin
                        Rec.AfficherDocument();
                    end;
            }
            group(Planning)
            {
                Caption = 'Planning';
                action(PlanningEcran)
                {
                    Caption = 'Planning Ecran';
                    Tooltip = 'Afficher le planning BE dans BC';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = TaskPage;
                    trigger OnAction()
                    var
                        DossierBE: Record "Dossier BE";
                    begin
                        DossierBE.CreerPlanningBE(0);
                    end;

                }
                action(PlanningExcel)
                {
                    Caption = 'Planning Excel';
                    Tooltip = 'Afficher le planning BE dans Excel';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = Excel;
                    trigger OnAction()
                    var
                        DossierBE: Record "Dossier BE";
                    begin
                        DossierBE.CreerPlanningBE(1);
                    end;
                }
            }
            action(Archiver)
            {
                Caption = 'Archiver les dossiers';
                ToolTip = 'Archive les dossiers dont toutes les fiches sont annulées, terminées ou "BE fournisseur"';
                RunObject = codeunit ArchiverDossiersBE;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        DefinirStyle();
        PctAvancementBE := Rec.CalcAvancement();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        DefinirStyle();
    end;

    procedure DefinirStyle()
    var

    begin
        if Rec."Alerte decalage date" then 
            MonStyle := 'Unfavorable'
        else
            MonStyle := 'Standard';
    end;
        
    var
        MonStyle:Text;
        PctAvancementBE: Decimal;
}
