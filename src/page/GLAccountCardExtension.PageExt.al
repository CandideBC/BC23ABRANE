pageextension 50003 GLAccountCardExtension extends "G/L Account Card"
{
    layout
    {
        addafter("Detailed Balance")
        {
            field("Exclure de la rentabilite"; Rec."Exclure de la rentabilite")
            {
                ApplicationArea = All;
                ToolTip = 'Exclure de la rentabilité';
            }
        }
    }
}

