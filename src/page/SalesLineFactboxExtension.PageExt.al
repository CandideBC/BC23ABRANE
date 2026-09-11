pageextension 50138 SalesLineFactboxExtension extends "Sales Line FactBox"
{
    layout
    {
        addafter("Required Quantity")
        {
            field(RecupQuantiteEnTransit; Rec.RecupQuantiteEnTransit())
            {
                ApplicationArea = All;
                Caption = 'Quantité en transit';
                ToolTip = 'Quantité en containers';
                DecimalPlaces = 0:5;
            }
            field("Reference Fiche BE"; Rec."Reference Fiche BE")
            {
                ApplicationArea = All;
                Caption = 'Réf. BE';
                Lookup = false;
                trigger OnDrillDown()
                var
                    FicheBE: Record "Ligne fiche BE";
                begin
                    if Rec."Reference Fiche BE" <> '' then begin
                        FicheBE.SetCurrentKey(Reference);
                        FicheBE.SetRange(Reference,Rec."Reference Fiche BE");
                        Page.RunModal(page::"Fiche fiche BE",FicheBE);

                    end;
                end;
            }
            
            
        }
    }
}
