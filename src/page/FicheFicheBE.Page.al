page 50108 "Fiche Fiche BE"
{
    ApplicationArea = All;
    Caption = 'Fiche fiche BE';
    PageType = Card;
    SourceTable = "Ligne fiche BE";
    
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("No. dossier BE"; Rec."No. dossier BE")
                {
                    ToolTip = 'Indique à quel dossier BE la fiche est rattachée.';
                    Editable = false;
                }
                field("No. ligne"; Rec."No. ligne")
                {
                    ToolTip = 'N° ligne';
                    Editable = false;
                }
                field("Type document"; Rec."Type document")
                {
                    ToolTip = 'Indique à quel type de document le dossier de la fiche est rattaché.';
                    Editable = false;
                }
                field("No. document"; Rec."No. document")
                {
                    ToolTip = 'Indique à quel N° document le dossier de la fiche est rattaché.';
                    Editable = false;
                }

                field("Nom chantier"; Rec."Nom chantier")
                {
                    ToolTip = 'Indique le nom du chantier auquel le dossier de la fiche est rattaché.';
                    Editable = false;
                }
                field("Nom fournisseur"; Rec."Nom fournisseur")
                {
                    ToolTip = 'Nom du fournisseur';
                    ApplicationArea = All;
                }
                
                field("Date demande"; Rec."Date demande")
                {
                    ToolTip = 'Date à laquelle la demande a été émise';
                    Editable = false;
                }
                field(Reference; Rec.Reference)
                {
                    ToolTip = 'Référence';
                    Editable = false;
                }
                field("Description de la demande"; Rec."Description de la demande")
                {
                    ToolTip = 'Description de la demande';
                }
                field("Statut ligne"; Rec."Statut ligne")
                {
                    ToolTip = 'Statut ligne';
                }
                field("Periode planification"; Rec."Periode planification")
                {
                    ToolTip = '43..45 pour indiquer que le dessinateur a prévu de travailler sur cette fiche les semaines 43, 44 et 45.';
                }
                field("Semaine debut traitement BE"; Rec."Semaine debut traitement BE")
                {
                    ToolTip = 'Semaine début traitement BE';
                }
                field("Dessinateurs"; Rec."Dessinateurs")
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
                    ToolTip = 'Référence permettant d''échanger avec le fabricant même si l''article ne sera pas forcément créé sous cette référence.';
                    Editable = false;
                }
                
                
                field("Alerte decalage date"; Rec."Alerte decalage date")
                {
                    ToolTip = 'Indique si une alerte non lue par le BE est en cours (décalage de la date de réponse).';
                }
            }
        }
    }
}
