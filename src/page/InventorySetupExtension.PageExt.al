pageextension 50016 "InventorySetupExtension" extends "Inventory Setup"
{
    layout
    {
        addafter("Prevent Negative Inventory")
        {

            field("Posting Date"; Rec."Mod. feuil. art. remise stk BL")
            {
                ApplicationArea = All;
                ToolTip = 'Mod. feuil. art. remise stk BL';
            }
            field("Nom feuil. art. remise stk BL"; Rec."Nom feuil. art. remise stk BL")
            {
                ApplicationArea = All;
                ToolTip = 'Feuille article remise stock BL';
            }

            field("Article : unite mesure/defaut"; Rec."Article : unite mesure/defaut")
            {
                ApplicationArea = All;
                ToolTip = 'Article : unité mesure par défaut';
            }


            field("Groupe compta produit defaut"; Rec."Groupe compta produit defaut")
            {
                ApplicationArea = All;
                ToolTip = 'Groupe compta produit par défaut';
            }
            field("Gpe compta produit TVA defaut"; Rec."Gpe compta produit TVA defaut")
            {
                ApplicationArea = All;
                ToolTip = 'Groupe compta produit TVA par défaut';
            }
            field("Groupe compta stock defaut"; Rec."Groupe compta stock defaut")
            {
                ApplicationArea = All;
                ToolTip = 'Groupe compta stock par défaut';
            }
            field("Dernier calcul stock"; Rec."Dernier calcul stock")
            {
                ApplicationArea = All;
                ToolTip = 'Date de dernier calcul de la valeur du stock';
            }
            field("No. article divers BE"; Rec."No. article divers BE")
            {
                ApplicationArea = All;
                ToolTip = 'Les articles divers (qui ne sont pas autant d''articles au sens NAV) font l''objet d''une numérotation spécifique propre au BE et permettant de simplifier les échanges avec les fournisseurs.';
            }
            
            

        }
    }
}
