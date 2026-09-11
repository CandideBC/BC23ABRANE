page 50101 "SF Dossier BE"
{
    ApplicationArea = All;
    Caption = 'Références';
    //InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "Ligne fiche BE";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Reference"; rec.Reference)
                {
                    ToolTip = 'Référence';
                    Caption = 'Référence';
                    //Editable = false;
                }
                field("No. ligne"; rec."No. ligne")
                {
                    ToolTip = 'N° ligne';
                    Caption = 'N° ligne';
                }
                field("Date demande"; Rec."Date demande")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date à laquelle la demande a été émise';
                }
                
                field("Description de la demande"; rec."Description de la demande")
                {
                    ToolTip = 'Description de la demande';
                    Caption = 'Description de la demande';
                }
                field("Statut ligne"; Rec."Statut ligne")
                {
                    ApplicationArea = All;
                    ToolTip = 'Statut ligne';
                }
                field("Nom fournisseur"; Rec."Nom fournisseur")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nom du fournisseur';
                }
                
                field("Periode planification"; Rec."Periode planification")
                {
                    ApplicationArea = All;
                    ToolTip = 'Vous pouvez saisir sur quels numéros de semaines le travail est planifié. Exempl : 35..38 pour dire "De la semaine 35 à la semaine 38.';
                }
                field("Date limite reponse BE"; Rec."Date limite reponse BE")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date avant laquelle le BE doit avoir donné sa réponse.';
                }
                field("Semaine limite reponse BE"; Rec."Semaine limite reponse BE")
                {
                    ApplicationArea = All;
                    ToolTip = 'Semaine avant laquelle le BE doit avoir donné sa réponse.';
                }
                
                field("Charge pour le BE (h)"; Rec."Charge pour le BE (h)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Charge de travail pour le BE estimée en heures.';
                }
                
                field("Semaine debut traitement BE"; Rec."Semaine debut traitement BE")
                {
                    ToolTip = 'Semaine début traitement BE';
                    Visible = false;
                }
                field("Nb dessinateurs"; Rec."Nb dessinateurs")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre de dessinateurs';
                    trigger OnDrillDown()
                    var
                        DessinateursFicheBE: Record "Dessinateurs fiche BE";
                    begin
                        DessinateursFicheBE.SetRange("No. dossier BE",Rec."No. dossier BE");
                        DessinateursFicheBE.SetRange("No. ligne",Rec."No. ligne");
                        Page.Run(Page::"Dessinateurs fiche BE",DessinateursFicheBE);
                    end;
                }
                
                field(Dessinateurs; Rec.Dessinateurs)
                {
                    ToolTip = 'Dessinateurs';
                }
                field("Commentaire fiche BE"; Rec."Commentaire fiche BE")
                {
                    ApplicationArea = All;
                    ToolTip = 'Commentaire propre à cette fiche.';
                }
                field("No. article B.E."; Rec."No. article B.E.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Référence attribuée à l''article correspondant à ce DIV.';
                }
                
            }
        }
    }

    actions
    {
        area(processing)
        {

        }
    }


}

