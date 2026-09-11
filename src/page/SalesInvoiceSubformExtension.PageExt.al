pageextension 50078 SalesInvoiceSubformExtension extends "Sales Invoice Subform"
{
    layout
    {
        /*
        
        modify("Original Amount")
        {
            Visible = false;
        }
        */
        
        addafter("Location Code")
        {

            field("Reason Code";Rec."Reason Code")
            {
                ApplicationArea = All;
                ToolTip = 'Code motif';
            }
            field("Prix bloque"; Rec."Prix bloque")
            {
                ToolTip = 'Prix bloqué';
                Enabled = false;
            }
            
        }
        addafter("Allow Item Charge Assignment")
        {

            field("Code groupe";Rec."Code groupe")
            {
                ToolTip = 'Groupe';
            }
            field("Code enseigne";Rec."Code enseigne")
            {
                ApplicationArea = All;
                ToolTip = 'Code enseigne';
            }

            field("Code operation";Rec."Code operation")
            {
                ToolTip = 'Opération';
            }            
            field("Code chantier";Rec."Code chantier")
            {
                ToolTip = 'Chantier';
            }            
        }
        addafter("Qty. Assigned")
        {

            field("Qty. to Assemble to Order";Rec."Qty. to Assemble to Order")
            {
                ToolTip = 'Qté vers assembler à la commande';
                
            }
            

            
            field("Eco Tax Furniture Amount";Rec."Eco Tax Furniture Amount")
            {
                ToolTip = 'Montant taxe éco-mobilier';
                
            }
        }
    }
        
    
    actions
    {
        addafter(GetShipmentLines)
        {
            action(FiltrerCeLettrage)
            {
                ApplicationArea = All;
                ToolTip = 'Débloquer prix article';
                Image = EncryptionKeys;
                
                                    
                trigger OnAction()
                
                begin
                    rec.SetPrixBloque(false);
                end;
            }
        }
        
        
    }

    local procedure dInsertDEEE()
    var
        dNegDEEE: Codeunit "Gestion Ecopart";
    begin
      if dNegDEEE.SalesCheckIfAnyWEEE(Rec) then begin
        CurrPage.SAVERECORD();
        dNegDEEE.InsertWEEELine(Rec);
      end;
      if dNegDEEE.MakeUpdate() then
        CurrPage.Update(false);
      //+DIA.SCH - CPT02
    end;


    var

}
