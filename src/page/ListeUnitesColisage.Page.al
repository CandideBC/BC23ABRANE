page 50126 "Liste unites colisage"
{
    ApplicationArea = All;
    Caption = 'Liste unites colisage';
    PageType = List;
    SourceTable = "Unite colisage";
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "Fiche unite colisage";
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("No. client"; Rec."No. client")
                {
                }
                field("Type UC"; Rec."Type UC")
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
        }
    }
}
