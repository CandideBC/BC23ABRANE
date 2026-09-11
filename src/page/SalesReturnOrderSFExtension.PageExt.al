pageextension 50107 SalesReturnOrderSFExtension extends "Sales Return Order Subform"
{

    layout
    {
        
        addbefore(Description)
        {
            field("Reason Code";Rec."Reason Code")
            {
                ApplicationArea = All;
                ToolTip = 'Code motif';
            }
        }
        addbefore(Quantity)
        {
            field("Nomenclature produits";Rec."Nomenclature produits")
            {
                ToolTip = 'Nomenclature produits';
                ApplicationArea = All;
                
            }
        }
        
        addafter("Reserved Quantity")
        {
            field("Prix bloque"; Rec."Prix bloque")
            {
                ToolTip = 'Prix bloqué';
                Visible = false;
                Enabled = false;
            }
        }

        addafter("Quantity Invoiced")
        {
            field("Poids net"; Rec."Net Weight")
            {
                ToolTip = 'Poids net';
            }
            field("Poids brut"; Rec."Gross Weight")
            {
                ToolTip = 'Poids brut';
                Visible = false;
            }
        }
    }

    actions
    {
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
