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
                }
                field("Date demande"; Rec."Date demande")
                {
                    Editable = false;
                    StyleExpr = MonStyle;
                }
                field("No. document"; Rec."No. document")
                {
                    ApplicationArea = All;
                    StyleExpr = MonStyle;
                }
                field("Nom du prospect/client"; Rec."Nom du prospect/client")
                {
                    ApplicationArea = All;
                    StyleExpr = MonStyle;
                    Visible = false;
                }
                field(Commentaires; Rec.Commentaires)
                {
                    ApplicationArea = All;
                    StyleExpr = MonStyle;
                }

                field("Description de la demande"; Rec."Description de la demande")
                {
                    Editable = false;
                    StyleExpr = MonStyle;
                }
                field("Code vendeur"; Rec."Code vendeur")
                {
                    ApplicationArea = All;
                    StyleExpr = MonStyle;
                }
                field("Nom fournisseur"; Rec."Nom fournisseur")
                {
                    ApplicationArea = All;
                    StyleExpr = MonStyle;
                }

                field("Date chargement"; Rec."Date chargement")
                {
                    ApplicationArea = All;
                    StyleExpr = MonStyle;
                }
                field("Date livraison demandée"; Rec."Date livraison demandée")
                {
                    ApplicationArea = All;
                    StyleExpr = MonStyle;
                }
                field("Date limite reponse BE"; Rec."Date limite reponse BE")
                {
                    ApplicationArea = All;
                    StyleExpr = MonStyle;
                }
                field("Semaine limite reponse BE"; Rec."Semaine limite reponse BE")
                {
                    ApplicationArea = All;
                    StyleExpr = MonStyle;
                }
                field("PJ sur serveur"; Rec."PJ sur serveur")
                {
                    ApplicationArea = All;
                }
                field("Statut ligne"; Rec."Statut ligne")
                {
                }

                field("Periode planification"; Rec."Periode planification")
                {
                }
                field("Semaine debut traitement BE"; Rec."Semaine debut traitement BE")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Nb dessinateurs"; Rec."Nb dessinateurs")
                {
                    ApplicationArea = All;
                }
                field(Dessinateurs; Rec.Dessinateurs)
                {
                }
                field("Commentaire fiche BE"; Rec."Commentaire fiche BE")
                {
                    ApplicationArea = All;
                }
                field("No. article B.E."; Rec."No. article B.E.")
                {
                    ApplicationArea = All;
                }
                field("Alerte decalage date"; Rec."Alerte decalage date")
                {
                    Editable = false;
                }
                field("Detail alerte"; Rec."Detail alerte")
                {
                    ApplicationArea = All;
                }
                field("Alerte vue par BE"; Rec."Alerte vue par BE")
                {
                    ApplicationArea = All;
                }


                field("No. dossier BE"; Rec."No. dossier BE")
                {
                    Editable = false;
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
