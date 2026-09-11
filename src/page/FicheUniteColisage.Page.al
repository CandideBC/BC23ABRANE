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
                field("No. container"; Rec."No. container")
                {
                    ApplicationArea = All;
                }
                field("Numero camion reception"; Rec."Numero camion reception")
                {
                    ApplicationArea = All;
                }
                field("Numero camion expedition";Rec."Numero camion expedition")
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
