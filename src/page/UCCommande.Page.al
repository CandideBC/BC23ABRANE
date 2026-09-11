page 50042 "UC Commande"
{
    ApplicationArea = All;
    Caption = 'UC Commande';
    PageType = List;
    SourceTable = "UC Commande";
    UsageCategory = None;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No. UC"; Rec."No. UC")
                {
                    ToolTip = 'Specifies the value of the N° field.';
                }
                field("Type UC"; Rec."Type UC")
                {
                    ToolTip = 'Specifies the value of the Type UC field.';
                }
                field(Numerotation; Rec.Numerotation)
                {
                    ToolTip = 'Specifies the value of the Numérotation field.';
                }

                field(Longueur; Rec.Longueur)
                {
                    ToolTip = 'Specifies the value of the Longueur field.';
                }
                field(Largeur; Rec.Largeur)
                {
                    ToolTip = 'Specifies the value of the Largeur field.';
                }
                field(Hauteur; Rec.Hauteur)
                {
                    ToolTip = 'Specifies the value of the Hauteur field.';
                }
                field(Dimensions; Rec.Dimensions)
                {
                    ToolTip = 'Specifies the value of the Dimensions field.';
                }
                field("Numero camion"; Rec."Numero camion")
                {
                    ToolTip = 'Specifies the value of the Numéro camion field.';
                }
                field("Poids brut"; Rec."Poids brut")
                {
                    ApplicationArea = All;
                    ToolTip = 'Poids réel (pesé) de la palette chargée.';
                }
                
            }
            
        }
        
    }
    actions
    {
        area(Processing)
        {
            action(ExtrairePalettesContainer)
            {
                ApplicationArea = All;
                ToolTip = 'Permet de sélectionner une palette arrivée par Container.';
                
                trigger OnAction()

                begin
                    Rec.ExtraireUCContainer();
                end;
            }
        }
    }
}
