page 50128 "Fiche unite colisage"
{
    ApplicationArea = All;
    Caption = 'Fiche unité colisage';
    PageType = Card;
    SourceTable = "Unite colisage";
    
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("No."; Rec."No.")
                {
                }
                field("Type UC"; Rec."Type UC")
                {
                }
                field("No. client"; Rec."No. client")
                {
                }
                field("Nom client"; Rec."Nom client")
                {
                }
                field("Statut UC"; Rec."Statut UC")
                {
                }
                field(Numerotation; Rec.Numerotation)
                {
                }
                field("Numero camion"; Rec."Numero camion")
                {
                }
            }
            part(SFPrepa;SFFicheUniteColisage)
            {
                SubPageLink = "No. UC" = field("No.");
            }
        }
    }
}
