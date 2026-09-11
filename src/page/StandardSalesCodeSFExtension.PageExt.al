pageextension 50061 StandardSalesCodeSFExtension extends "Standard Sales Code Subform"
{
    layout
    {
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify("ShortcutDimCode[3]")
        {
            Visible = false;
        }
        modify("ShortcutDimCode[4]")
        {
            Visible = false;
        } 
        modify("ShortcutDimCode[5]")
        {
            Visible = false;
        }
        modify("ShortcutDimCode[6]")
        {
            Visible = false;
        }
        modify("ShortcutDimCode[7]")
        {
            Visible = false;
        }
        modify("ShortcutDimCode[8]")
        {
            Visible = false;
        }

        addafter(Description)
        {
            field("Type ligne"; Rec."Type ligne")
            {
                ToolTip = 'Type ligne';
            }
            field("Type Fiche BE"; Rec."Type Fiche BE")
            {
                ApplicationArea = All;
                ToolTip = 'Type fiche BE';
            }
            field(Phase; Rec.Phase)
            {
                ApplicationArea = All;
                ToolTip = 'Phase';
            }
            field("Description phase"; Rec."Description phase")
            {
                ApplicationArea = All;
                ToolTip = 'Description phase';
            }
            field("No. fournisseur"; Rec."No. fournisseur")
            {
                ApplicationArea = All;
            }
            
        }
        addafter(Quantity)
        {
            field("Poids net"; Rec."Poids net")
            {
                ToolTip = 'Poids net';
            }
            field("Prix achat prevu"; Rec."Prix achat prevu")
            {
                ApplicationArea = All;
                ToolTip = 'Prix d''achat prévu.';
            }
            field("Prix unitaire"; Rec."Prix unitaire")
            {
                ToolTip = 'Prix unitaire';
            }
            field("Nomenclature produits"; Rec."Nomenclature produits")
            {
                ToolTip = 'Nomenclature produits';
            }
            field("Country/Region of Origin Code"; Rec."Country/Region of Origin Code")
            {
                ToolTip = 'Code pays d''origine';
            }
        }
    }
    actions
    {
 
    }
}

