page 50145 "SF FichE Expe UC Commande"
{
    ApplicationArea = All;
    Caption = 'UC Commande';
    PageType = ListPart;
    SourceTable = "UC Commande";
    
    layout
    {
        area(Content)
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
                field("Numero camion"; Rec."Numero camion")
                {
                    ToolTip = 'Specifies the value of the Numéro camion field.';
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
                field("Poids brut"; Rec."Poids brut")
                {
                    ToolTip = 'Poids réel (pesé) de la palette chargée.';
                }
            }
        }
    }
}
