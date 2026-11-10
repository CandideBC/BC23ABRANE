page 50104 "Liste fiches BE"
{
    ApplicationArea = All;
    Caption = 'Liste fiches BE';
    PageType = List;
    SourceTable = "Ligne fiche BE";
    SourceTableView = sorting("Date limite reponse BE");
    UsageCategory = Lists;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Reference; Rec.Reference)
                {
                    Editable = false;
                    StyleExpr = MonStyle;
                    ToolTip = 'Référence';
                }
                field("Date demande"; Rec."Date demande")
                {
                    Editable = false;
                    StyleExpr = MonStyle;
                    ToolTip = 'Date de la demande';
                }
                field("No. document"; Rec."No. document")
                {
                    ApplicationArea = All;
                    ToolTip = 'N° de document';
                    StyleExpr = MonStyle;
                }
                field("Nom du prospect/client"; Rec."Nom du prospect/client")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nom du prospect/client';
                    StyleExpr = MonStyle;
                    Visible = false;
                }
                field(Commentaires; Rec.Commentaires)
                {
                    ApplicationArea = All;
                    ToolTip = 'Commentaires';
                    StyleExpr = MonStyle;
                }

                field("Description de la demande"; Rec."Description de la demande")
                {
                    Editable = false;
                    ToolTip = 'Description de la demande';
                    StyleExpr = MonStyle;
                }
                field("Code vendeur"; Rec."Code vendeur")
                {
                    ApplicationArea = All;
                    ToolTip = 'Code vendeur';
                    StyleExpr = MonStyle;
                }
                field("Nom fournisseur"; Rec."Nom fournisseur")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nom du fournisseur';
                    StyleExpr = MonStyle;
                }

                field("Date chargement"; Rec."Date chargement")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date de chargement';
                    StyleExpr = MonStyle;
                }
                field("Date livraison demandée"; Rec."Date livraison demandée")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date de livraison demandée';
                    StyleExpr = MonStyle;
                }
                field("Date limite reponse BE"; Rec."Date limite reponse BE")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date limite réponse BE';
                    StyleExpr = MonStyle;
                }
                field("Semaine limite reponse BE"; Rec."Semaine limite reponse BE")
                {
                    ApplicationArea = All;
                    ToolTip = 'Semaine limite réponse BE';
                    StyleExpr = MonStyle;
                }
                field("PJ sur serveur"; Rec."PJ sur serveur")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indique si des pièces jointes se trouvent sur le serveur.';
                }
                field("Statut ligne"; Rec."Statut ligne")
                {
                    ToolTip = 'Statut de la ligne';
                }

                field("Periode planification"; Rec."Periode planification")
                {
                    ToolTip = 'Période de planification';
                }
                field("Semaine debut traitement BE"; Rec."Semaine debut traitement BE")
                {
                    ApplicationArea = All;
                    ToolTip = 'Semaine où le B.E. va commencer à traiter la fiche.';
                    Visible = false;
                }
                field("Nb dessinateurs"; Rec."Nb dessinateurs")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre de dessinateurs intervenant sur la fiche.';
                }
                field(Dessinateurs; Rec.Dessinateurs)
                {
                    ToolTip = 'Dessinateurs';
                }
                field("Commentaire fiche BE"; Rec."Commentaire fiche BE")
                {
                    ApplicationArea = All;
                    ToolTip = 'Commentaire propre à la fiche';
                }
                field("No. article B.E."; Rec."No. article B.E.")
                {
                    ApplicationArea = All;
                    ToolTip = 'N° d''article défini par le B.E.';
                }
                field("Alerte decalage date"; Rec."Alerte decalage date")
                {
                    Editable = false;
                    ToolTip = 'Indique si la date a été décalée.';
                }
                field("Detail alerte"; Rec."Detail alerte")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indique du détail quant à l''alerte de décalage de date.';
                }
                field("Alerte vue par BE"; Rec."Alerte vue par BE")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indique si l''alerte a été visée par le B.E.';
                }


                field("No. dossier BE"; Rec."No. dossier BE")
                {
                    Editable = false;
                    ToolTip = 'N° de dossier du B.E.';
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Afficher)
            {
                ApplicationArea = All;
                Caption = 'Ouvrir';
                ToolTip = 'Permet d''ouvrir la fiche BE';
                RunObject = page "Fiche dossier BE";
                RunPageLink = "No." = field("No. dossier BE");
                Image = Card;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
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
        }
    }
    trigger OnAfterGetRecord()
    begin
        DefinirStyle();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        DefinirStyle();
    end;

    procedure DefinirStyle()
    var

    begin
        Rec.calcfields("Alerte decalage date");
        if (Rec."Statut ligne" in [Rec."Statut ligne"::" ", Rec."Statut ligne"::"En cours", Rec."Statut ligne"::"En attente validation client"]) and (Rec."Date limite reponse BE" < Today) then
            MonStyle := 'Unfavorable'
        else
            if Rec."Alerte decalage date" then
                MonStyle := 'StrongAccent'
            else
                MonStyle := 'Standard';
    end;

    var
        MonStyle: Text;
}
