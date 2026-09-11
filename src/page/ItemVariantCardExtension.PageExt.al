pageextension 50146 ItemVariantCardExtension extends "Item Variant Card"
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
