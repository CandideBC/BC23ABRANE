pageextension 50097 AssemblySetupExtension extends "Assembly Setup"
{
    layout
    {
        addafter("Copy Comments when Posting")
        {
            field("Delai due date";Rec."Delai due date")
            {
                ApplicationArea = All;
                ToolTip = 'Délai date échéance (j)';
            }
            
        }
    }
    actions
    {

    }
}
