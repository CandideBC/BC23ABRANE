pageextension 50135 SOProcessorActivitiesExtension extends "SO Processor Activities"
{
    layout
    {
        modify(SalesOrdersReservedFromStock)
        {
            Visible = false;
        }
        /*
        modify(ReadyToShip)
        {
            Visible = false;
        }
        */
        modify("Sales Orders Released Not Shipped")
        {
            Visible = false;
        }
        addafter(Returns)
        {
            cuegroup(OCR)
            {
                Caption = 'OCR';
                field("Nombre doc. OCR en attente"; Rec."Nombre doc. OCR en attente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indique combien de documents ont été OCRisés sans avoir été encore été traités.';
                    trigger OnDrillDown()
                    var
                        EnteteOCRVente:Record "Entete OCR vente";
                        ListeDocOCRPage: page "Liste documents OCR Vente";
                    begin
                        EnteteOCRVente.Reset();
                        EnteteOCRVente.SetCurrentKey("Document OCR traite");
                        EnteteOCRVente.SetRange("Document OCR traite",false);
                        clear(ListeDocOCRPage);
                        ListeDocOCRPage.SetTableView(EnteteOCRVente);
                        ListeDocOCRPage.Run();
                    end;
                }
                
            }
        }    
    }
    
    
    
}
