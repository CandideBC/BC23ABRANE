pageextension 50142 BlanketPurchOrderSFExtension extends "Blanket Purchase Order Subform"
{
    layout
    {
        modify("Item Reference No.")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Tax Group Code")
        {
            Visible = false;
        }
        modify("Description 2")
        {
            Visible = true;
        }
        moveafter("Unit of Measure Code"; "Qty. to Receive")

        modify("Qty. to Receive")
        {
            Caption = 'Qté à commander';
        }
        addafter("Qty. to Receive")
        {
            field(CalcQteDispoCdeCadre; Rec.CalcQteDispoCdeCadre())
            {
                ApplicationArea = All;
                Caption = 'Qté restant à commander';
                ToolTip = 'La quantité restant à commander s''obtient en déduisant la quantité reçue et la quantité commandée mais non reçue de la quantité globale.';
                DecimalPlaces = 0 : 5;
                BlankZero = true;
                Editable = false;
            }
        }
        addafter("Line Amount")
        {
            field("Qte sur commande"; Rec."Qte sur commande")
            {
                ToolTip = 'Quantité déjà commandée mais pas encore reçue.';
                ApplicationArea = All;
            }

        }

        modify("Location Code")
        {
            Visible = true;
        }
    }
    actions
    {
        modify(Dimensions)
        {
            Visible = false;
        }
        modify(DocumentLineTracking)
        {
            Visible = false;
        }

        modify("E&xplode BOM")
        {
            Visible = false;
        }
        modify("Insert &Ext. Texts")
        {
            Visible = false;
        }
        modify("Co&mments")
        {
            Visible = false;
        }
        addfirst(processing)
        {
            action(RemplirQteACommander)
            {
                ApplicationArea = All;
                Caption = 'Remplir Qté à commander';
                Image = AutofillQtyToHandle;
                ToolTip = 'Remplit la quantité à commander en tenant compte de ce qui a déjà été commandé ou reçu.';

                trigger OnAction()
                begin
                    Rec.fctRemplirQuantitearecevoir();
                end;
            }
            action(ViderQteACommander)
            {
                ApplicationArea = All;
                Caption = 'Vider Qté à commander';
                Image = DeleteQtyToHandle;
                ToolTip = 'Vide la quantité à commander.';

                trigger OnAction()
                begin
                    rec.fctRAZQuantitearecevoir();
                end;
            }
        }
    }
}
