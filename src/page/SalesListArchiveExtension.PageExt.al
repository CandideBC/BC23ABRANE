pageextension 50120 "SalesListArchiveExtension" extends "Sales List Archive"
{
    layout
    {
        addafter("Time Archived")
        {
            field("Montant archive"; Rec."Montant archive")
            {
                ApplicationArea = All;
                ToolTip = 'Montant archivé';
            }
        }
        addafter("Currency Code")
        {
            field(ASS; Rec.ASS)
            {
                ApplicationArea = All;
                ToolTip = 'SAV';
            }
            field("No. Series"; Rec."No. Series")
            {
                ApplicationArea = All;
                ToolTip = 'Souche de N°';
            }
        }

    }
}
