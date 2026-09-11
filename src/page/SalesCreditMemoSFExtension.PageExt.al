pageextension 50092 SalesCreditMemoSFExtension extends "Sales Cr. Memo Subform"
{

    layout
    {
        addbefore(Type)
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'N° ligne';
            }

        }
        addafter("Return Reason Code")
        {
            field("Reason Code"; Rec."Reason Code")
            {
                ApplicationArea = All;
                ToolTip = 'Code motif';
            }
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Tax Liable")
        {
            Visible = false;
        }

        addafter("Line Amount")
        {

            field("Prix bloque"; Rec."Prix bloque")
            {
                ToolTip = 'Prix bloqué';
                Enabled = false;
            }
            field("Code groupe"; Rec."Code groupe")
            {
                ToolTip = 'Code groupe';
                Visible = false;
            }
            field("Code enseigne"; Rec."Code enseigne")
            {
                ToolTip = 'Code enseigne';
                Visible = false;
            }
            field("Operation"; Rec."Code operation")
            {
                ToolTip = 'Code opération';
                Visible = false;
            }
            field("Chantier"; Rec."Code chantier")
            {
                ToolTip = 'Code chantier';
                Visible = false;
            }
            field("Poids net"; Rec."Net Weight")
            {
                ToolTip = 'Poids net';
            }

            field("Eco Tax Furniture Amount"; Rec."Eco Tax Furniture Amount")
            {
                ToolTip = 'Montant taxe éco-mobilier';
            }
            field("Annee commande"; Rec."Annee commande")
            {
                ToolTip = 'Année commande';
                ApplicationArea = All;
            }
            
        }
    }

    

    actions
    {    
        modify(Dimensions)
        {
            Visible = false;
        }

        addlast("F&unctions")
        {
            action("Débloquer prix article")
            {
                ApplicationArea = All;
                Image = EncryptionKeys;
                ToolTip = 'Débloquer prix article';
                
                trigger OnAction()
                begin
                    Rec.SetPrixBloque(false);

                end;
            }
        }


    }
}
