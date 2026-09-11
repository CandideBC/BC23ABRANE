page 50112 "Liste dossiers BE archives"
{
    ApplicationArea = All;
    Caption = 'Liste dossiers BE archivés';
    PageType = List;
    SourceTable = "Dossier BE";
    SourceTableView= sorting(Archive) where (Archive=const(true));
    UsageCategory = Lists;
    Editable = false;
    InsertAllowed = false;
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

                
                field("PJ sur serveur"; Rec."PJ sur serveur")
                {
                    ToolTip = 'PJ sur serveur';
                    Caption = 'PJ sur serveur';
                    Visible = true;
                }
                
                /*
                field("Alerte decalage date"; Rec."Alerte decalage date")
                {
                    ApplicationArea = All;
                }
                field("Detail alerte"; Rec."Detail alerte")
                {
                    ApplicationArea = All;
                }
                */
                
                
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
            action(Desarchiver)
            {
                ApplicationArea = All;
                ToolTip = 'Refait passer le dossier dans la liste des dossiers non archivés.';
                Caption = 'Désarchiver';
                Visible = (Rec.Archive);
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Restore;
                
                trigger OnAction()
                begin
                    Rec.Desarchiver();
                end;
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
        if Rec."Alerte decalage date" then 
            MonStyle := 'Unfavorable'
        else
            MonStyle := 'Standard';
    end;
    var
        MonStyle:Text;
}
