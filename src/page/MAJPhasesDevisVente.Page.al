page 50114 "MAJ phases devis vente"
{
    ApplicationArea = All;
    Caption = 'MAJ phases devis vente';
    PageType = List;
    SourceTable = "Phases document";
    SourceTableView = where("Type document" = const(Quote));
    UsageCategory = Tasks;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No. document"; Rec."No. document")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'N° document';
                }
                field(Commentaires; Rec.Commentaires)
                {
                    ApplicationArea = All;
                    ToolTip = 'Commentaires';
                    Editable = false;
                }
                field("No. doc externe"; Rec."No. doc externe")
                {
                    ApplicationArea = All;
                    ToolTip = 'N° doc. externe';
                }
                field("Nb lignes dans phase"; Rec."Nb lignes dans phase")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indique combien de lignes sont associées à la phase.';
                }
                
                field("Proba transformation"; Rec."Proba transformation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Probabilité de transformation en commande.';
                }
                field("Code enseigne"; Rec."Code enseigne")
                {
                    ApplicationArea = All;
                    ToolTip = 'Code enseigne';
                }
                field("Code chantier"; Rec."Code chantier")
                {
                    ApplicationArea = All;
                    ToolTip = 'Code chantier';
                }
                field("Code vendeur"; Rec."Code vendeur")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Code vendeur';
                }

                field(Phase; Rec.Phase)
                {
                    ToolTip = 'Indique la phase, la phase 0 correspondant à la phase "Indéfinie"';
                    Editable = false;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description de la phase, cela peut correspondre à un découpage du chantier par étage ou par étapes de réalisation par exemple.';
                    StyleExpr = MonStyle;
                }
                field("Date chargement"; Rec."Date chargement")
                {
                    ToolTip = 'Indique la date à laquelle les articles devraient être chargés pour satisfaire la date de livraison demandée.';
                }
                field("Date livraison demandee"; Rec."Date livraison demandee")
                {
                    ToolTip = 'Indique la date à laquelle les articles liés à cette phase doivent être livrés (date demandée par le client)';
                }
            }
        }

    }
    actions
    {
        area(Processing)
        {
            action(SupprimerLignesErreur)
            {
                ApplicationArea = All;
                Caption = 'Suppr lignes err';
                ToolTip = 'Supprimer les lignes liées à des documents incohérents.';
                trigger OnAction()
                var
                    PhasesDoc: Record "Phases document";
                    PhasesDoc2: Record "Phases document";
                    EnteteVente: Record "Sales Header";
                begin
                    if PhasesDoc.FindSet() then
                        repeat
                            if PhasesDoc."No. document" <> '' then
                                if not EnteteVente.get(PhasesDoc."Type document", PhasesDoc."No. document") then begin
                                    PhasesDoc2.Get(PhasesDoc."Type document", PhasesDoc."No. document", PhasesDoc.Phase);
                                    PhasesDoc2.Delete();
                                end;
                        until PhasesDoc.Next() = 0;

                end;
            }
            /*
            action(PhaserReliquat)
            {
                ApplicationArea = All;
                Caption = 'Phaser le reliquat';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = MoveNegativeLines;
                ToolTip = 'Déplace les quantités non encore expédiées vers la phase 99 = phase dédiée à la livraison du reliquat';
                
                trigger OnAction()
                var
                    EnteteVente: Record "Sales Header";
                    ConfirmerQst: label 'Souhaitez-vous déplacer les quantités non livrées vers la phase 99 RELIQUAT';
                begin
                    if not Confirm(ConfirmerQst,true) then
                        exit;

                    EnteteVente.get(EnteteVente."Document Type"::Order,Rec."No. document");
                    EnteteVente.PhaserReliquat();
                end;
            }
            */
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetFilter("Nb lignes dans phase",'>%1',0);
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.calcfields("Nb lignes dans phase");
        DefinirStyle();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        Rec.calcfields("Nb lignes dans phase");
        DefinirStyle();
    end;

    procedure DefinirStyle()
    var

    begin
        if Rec."Nb lignes dans phase" = 0 then 
            MonStyle := 'Subordinate'
        else
            MonStyle := 'Standard';
    end;

    var
        MonStyle: Text;




}
