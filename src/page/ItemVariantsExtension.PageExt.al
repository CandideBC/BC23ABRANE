pageextension 50147 ItemVariantsExtension extends "Item Variants"
{
        layout
    {
        addafter(Description)
        {
            field("Remplacer desi. sur vente"; Rec."Remplacer desi. sur vente")
            {
                ApplicationArea = All;
                ToolTip = 'Si coché, la désignation de la variante remplacer la désignation de l''article sur les lignes de ventes.';
            }
            
        }

    }
}
