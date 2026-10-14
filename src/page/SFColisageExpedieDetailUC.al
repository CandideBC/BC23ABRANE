page 50022 "SF Colisage expedie ; detailUC"
{
    ApplicationArea = All;
    Caption = 'SF Colisage expedie ; detailUC';
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
                field("Qte commandee"; Rec."Qte commandee")
                {
                }
                field("Qte expediee"; Rec."Qte expediee")
                {
                }
                field("Quantite UC"; Rec."Quantite UC")
                {
                }
                field("No. UC"; Rec."No. UC")
                {
                }
            }
        }
    }
}
