page 50057 "Fiche DEB Ventes"
{
    ApplicationArea = All;
    UsageCategory = None;
    Caption = 'DEB Ventes';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Accounting Period";

    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'General';
                field("Starting Date"; Rec."Starting Date")
                {
                    ToolTip = 'Date début';
                    Editable = false;
                }
                field("DEB Ventes cloturee"; Rec."DEB Ventes cloturee")
                {
                    ToolTip = 'DEB Ventes clôturée';
                    Editable = false;
                }
            }
            part(LignesDEB; "SF DEB Ventes")
            {
                SubPageLink = "Date debut periode comptable"=field("Starting Date");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Extraire)
            {
                Caption = 'Extraire';
                ToolTip = 'Extraire';
                Image = GetLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ReportExtraireDEB: Report "Extraire DEB Ventes";
                begin
                    Rec.TESTFIELD("DEB Ventes cloturee", false);
                    CLEAR(ReportExtraireDEB);
                    ReportExtraireDEB.DefPeriode(Rec."Starting Date");
                    ReportExtraireDEB.USEREQUESTPAGE(false);
                    ReportExtraireDEB.RUN();
                end;
            }
            action("Synthèse vers Excel")
            {
                Caption = 'Synthèse vers Excel';
                ToolTip = 'Synthèse vers Excel';
                Image = ExportToExcel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    PeriodeComptable: Record "Accounting Period";
                begin
                    PeriodeComptable.SETRANGE("Starting Date", Rec."Starting Date");
                    REPORT.RUN(50026, true, false, PeriodeComptable);
                end;
            }
            action("Clôturer DEB Ventes")
            {
                Caption = 'Clôturer DEB Ventes';
                ToolTip = 'Clôturer DEB Ventes';
                Image = ClosePeriod;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.CloturerDEBVentes();
                end;
            }
        }
    }
}

