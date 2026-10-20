page 50022 "SF Colisage expedie : detailUC"
{
    ApplicationArea = All;
    Caption = 'Détail colisage';
    PageType = ListPart;
    SourceTable = "Detail UC colisage expedie";
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No. ligne"; Rec."No. ligne")
                {
                }
                field("Item No."; Rec."Item No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Designation article"; Rec."Designation article")
                {
                }
                field("Description 2"; Rec."Description 2")
                {
                }
                field("Quantite colisee totale"; Rec."Quantite colisee totale")
                {
                }
                /*
                field("Qte commandee"; Rec."Qte commandee")
                {
                }
                field("Qte expediee"; Rec."Qte expediee")
                {
                }
                */
                field("Quantite dans UC"; Rec."Quantite dans UC")
                {
                }
                field("No. UC"; Rec."No. UC")
                {
                }
            }
        }
    }
}
