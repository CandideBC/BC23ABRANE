pageextension 50000 CountriesRegionsExtension extends "Countries/Regions"
{
    
    layout
    {
        addafter("VAT Scheme")
        {
            field("Pays Codifab"; Rec."Pays Codifab")
            {
                ApplicationArea = All;
                ToolTip = 'Pays Codifab';
            }
            field("Language Code"; Rec."Language Code")
            {
                ApplicationArea = All;
                ToolTip = 'Code langue';
            }
            field("Soumis eco-contribution"; Rec."Soumis eco-contribution")
            {
                ApplicationArea = All;
                ToolTip = 'Soumis éco-contribution';
            }
            field("SIRET obligatoire"; Rec."SIRET obligatoire")
            {
                ApplicationArea = All;
                ToolTip = 'SIRET obligatoire ?';
            }
            field("No. TVA intracom. oblig."; Rec."No. TVA intracom. oblig.")
            {
                ApplicationArea = All;
                ToolTip = 'N° TVA intracom. obligatoire ?';
            }
            field("Delai transit (jours)"; Rec."Delai transit (jours)")
            {
                ApplicationArea = All;
                ToolTip = 'Délai de transit qui s''applique sur la date de livraison demandée pour obtenir la date de chargement au niveau des ventes.';
            }
            field("% frais approche"; Rec."% frais approche")
            {
                ApplicationArea = All;
                ToolTip = 'Permet d''estimer les frais d''approche sur les devis et commandes de vente en fonction des fournisseurs chez qui on achète.';
            }
            field("Montant VAN"; Rec."Montant VAN")
            {
                ApplicationArea = All;
                ToolTip = 'Montant de marchandise max pour affréter un VAN';
            }
            field("Montant Porteur"; Rec."Montant Porteur")
            {
                ApplicationArea = All;
                ToolTip = 'Montant de marchandise max pour affréter un Porteur';
            }
            field("Montant Semi"; Rec."Montant Semi")
            {
                ApplicationArea = All;
                ToolTip = 'Montant de marchandise max pour affréter un Semi-remorque';
            }
            field("Montant Container 20p";Rec."Montant Container 20p")
            {
                ApplicationArea = All;
                ToolTip = 'Montant de marchandise max pour affréter un container de 20 pieds';
            }
            field("Montant Container 40p";Rec."Montant Container 40p")
            {
                ApplicationArea = All;
                ToolTip = 'Montant de marchandise max pour affréter un container de 40 pieds';
            }
        }
    }
    
}

