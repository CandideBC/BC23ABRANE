pageextension 50023 AccountingPeriodsExtension extends "Accounting Periods"
{

    layout
    {
        addafter("Period Reopened Date")
        {
            field("DEB Ventes cloturee"; Rec."DEB Ventes cloturee")
            {
                ApplicationArea = All;
                ToolTip = 'DEB Ventes clôturée';
            }
            field("DEB Achats cloturee"; Rec."DEB Achats cloturee")
            {
                ApplicationArea = All;
                ToolTip = 'DEB Achats clôturée';
            }
            
        }
    }
}

