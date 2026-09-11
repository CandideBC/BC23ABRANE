page 50107 "Planning BE"
{
    ApplicationArea = All;
    Caption = 'Planning BE';
    PageType = List;
    SourceTable = TamponPlanningBE;
    SourceTableView = sorting("No. semaine");
    UsageCategory = None;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No. ligne"; Rec."No. ligne")
                {
                }
                field("No. semaine"; Rec."No. semaine")
                {
                }
                field(Separation0; '||')
                {
                    Caption = '';
                    Style = StrongAccent;
                }
                //field("Code dessinateur 1"; Rec."Code dessinateur 1")
                //{
                //}
                field("No. document D1"; Rec."No. document D1")
                {
                    StyleExpr = StyleD1;
                }
                field("Nom chantier D1"; Rec."Nom chantier D1")
                {
                    StyleExpr = StyleD1;
                }
                field("Description de la demande D1"; Rec."Description de la demande D1")
                {
                    StyleExpr = StyleD1;
                }

                field("PJ D1 ?"; Rec."PJ D1 ?")
                {
                }
                field("DLC D1"; Rec."DLC D1")
                {
                    StyleExpr = StyleD1;
                }
                field("Statut ligne D1"; Rec."Statut ligne D1")
                {
                    StyleExpr = StyleD1;
                }
                field(Separation1; '||')
                {
                    Caption = '';
                    Style = StrongAccent;
                }
                //field("Code dessinateur 2"; Rec."Code dessinateur 2")
                //{
                //}
                field("No. document D2"; Rec."No. document D2")
                {
                    StyleExpr = StyleD2;
                }
                field("Nom chantier D2"; Rec."Nom chantier D2")
                {
                    StyleExpr = StyleD2;
                }
                field("Description de la demande D2"; Rec."Description de la demande D2")
                {
                    StyleExpr = StyleD2;
                }
                field("PJ D2 ?"; Rec."PJ D2 ?")
                {
                }
                field("DLC D2"; Rec."DLC D2")
                {
                    StyleExpr = StyleD2;
                }
                field("Statut ligne D2"; Rec."Statut ligne D2")
                {
                    StyleExpr = StyleD2;
                }
                field(Separation2; '||')
                {
                    Caption = '';
                    Style = StrongAccent;
                }
                //field("Code dessinateur 3"; Rec."Code dessinateur 3")
                //{
                //}
                field("No. document D3"; Rec."No. document D3")
                {
                    StyleExpr = StyleD3;
                }
                field("Nom chantier D3"; Rec."Nom chantier D3")
                {
                    StyleExpr = StyleD3;
                }
                field("Description de la demande D3"; Rec."Description de la demande D3")
                {
                    StyleExpr = StyleD3;
                }
                field("PJ D3 ?"; Rec."PJ D3 ?")
                {
                }
                field("DLC D3"; Rec."DLC D3")
                {
                    StyleExpr = StyleD3;
                }
                field("Statut ligne D3"; Rec."Statut ligne D3")
                {
                    StyleExpr = StyleD3;
                }
                field(Separation3; '||')
                {
                    Caption = '';
                    Visible = false;
                    Style = StrongAccent;
                }
                //field("Code dessinateur 4"; Rec."Code dessinateur 4")
                //{
                //    Visible = false;
                //}
                field("No. document D4"; Rec."No. document D4")
                {
                    Visible = false;
                    StyleExpr = StyleD4;
                }
                field("Nom chantier D4"; Rec."Nom chantier D4")
                {
                    Visible = false;
                    StyleExpr = StyleD4;
                }
                field("Description de la demande D4"; Rec."Description de la demande D4")
                {
                    Visible = false;
                    StyleExpr = StyleD4;
                }
                field("PJ D4 ?"; Rec."PJ D4 ?")
                {
                    Visible = false;
                }
                field("DLC D4"; Rec."DLC D4")
                {
                    Visible = false;
                    StyleExpr = StyleD4;
                }
                field("Statut ligne D4"; Rec."Statut ligne D4")
                {
                    Visible = false;
                    StyleExpr = StyleD4;
                }
                field(Separation4; '||')
                {
                    Caption = '';
                    Visible = false;
                    Style = StrongAccent;
                }
                //field("Code dessinateur 5"; Rec."Code dessinateur 5")
                //{
                //    Visible = false;
                //}
                field("No. document D5"; Rec."No. document D5")
                {
                    Visible = false;
                    StyleExpr = StyleD5;
                }
                field("Nom chantier D5"; Rec."Nom chantier D5")
                {
                    Visible = false;
                    StyleExpr = StyleD5;
                }
                field("Description de la demande D5"; Rec."Description de la demande D5")
                {
                    Visible = false;
                    StyleExpr = StyleD5;
                }
                field("PJ D5 ?"; Rec."PJ D5 ?")
                {
                    Visible = false;
                }
                field("DLC D5"; Rec."DLC D5")
                {
                    Visible = false;
                    StyleExpr = StyleD5;
                }
                field("Statut ligne D5"; Rec."Statut ligne D5")
                {
                    Visible = false;
                    StyleExpr = StyleD5;
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        DefinirStyles();
    end;

    trigger OnAfterGetRecord()
    begin
        DefinirStyles();
    end;

    procedure DefinirStyles()
    var
    begin
        case Rec."Statut ligne D1" of
            'Standby':
                StyleD1 := 'StrongAccent';
            'En cours':
                StyleD1 := 'Ambiguous';
            'Annulé':
                StyleD1 := 'Attention';
            'Terminé':
                StyleD1 := 'Favorable';
            else
                StyleD1 := 'Standard';
        end;

        case Rec."Statut ligne D2" of
            'Standby':
                StyleD2 := 'StrongAccent';
            'En cours':
                StyleD2 := 'Ambiguous';
            'Annulé':
                StyleD2 := 'Attention';
            'Terminé':
                StyleD2 := 'Favorable';
            else
                StyleD2 := 'Standard';
        end;

        case Rec."Statut ligne D3" of
            'Standby':
                StyleD3 := 'StrongAccent';
            'En cours':
                StyleD3 := 'Ambiguous';
            'Annulé':
                StyleD3 := 'Attention';
            'Terminé':
                StyleD3 := 'Favorable';
            else
                StyleD3 := 'Standard';
        end;

        case Rec."Statut ligne D4" of
            'Standby':
                StyleD4 := 'StrongAccent';
            'En cours':
                StyleD4 := 'Ambiguous';
            'Annulé':
                StyleD4 := 'Attention';
            'Terminé':
                StyleD4 := 'Favorable';
            else
                StyleD4 := 'Standard';
        end;

        case Rec."Statut ligne D5" of
            'Standby':
                StyleD5 := 'StrongAccent';
            'En cours':
                StyleD5 := 'Ambiguous';
            'Annulé':
                StyleD5 := 'Attention';
            'Terminé':
                StyleD5 := 'Favorable';
            else
                StyleD5 := 'Standard';
        end;
    end;

    var
        StyleD1: Text;
        StyleD2: Text;
        StyleD3: Text;
        StyleD4: Text;
        StyleD5: Text;
}
