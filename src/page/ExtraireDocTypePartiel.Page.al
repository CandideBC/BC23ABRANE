page 50113 ExtraireDocTypePartiel
{
    ApplicationArea = All;
    Caption = 'Extraire document type partiel';
    PageType = List;
    SourceTable = TamponExtraireDocType;
    UsageCategory = None;
    InsertAllowed = false;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No. ligne"; Rec."No. ligne")
                {
                }
                field("Ajouter au document"; Rec."Ajouter au document")
                {
                    ApplicationArea = All;
                }
                field("Type ligne"; Rec."Type ligne")
                {
                    ApplicationArea = All;
                    ToolTip = 'Type ligne';
                }
                field("Type Fiche BE"; Rec."Type Fiche BE")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Type Fiche BE';
                }
                
                field(Phase; Rec.Phase)
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Phase';
                }
                
                
                field("Type"; Rec."Type")
                {
                }
                field("No."; Rec."No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Quantite; Rec.Quantite)
                {
                }
                field("Code unite"; Rec."Code unite")
                {
                }
                field("Code variante"; Rec."Code variante")
                {
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(SelectionnerTout)
            {
                ApplicationArea = All;
                Caption = 'Sélectionner tout';
                ToolTip = 'Va cocher toutes les lignes.';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = AllLines;

                trigger OnAction()
                begin
                    Rec.SelectionMultiple(true);
                end;
            }
            action(DeselectionnerTout)
            {
                ApplicationArea = All;
                Caption = 'Désélectionner tout';
                ToolTip = 'Va décocher toutes les lignes.';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = CancelAllLines;
                
                trigger OnAction()
                begin
                    Rec.SelectionMultiple(false);
                end;
            }
        }
    }
}
