tableextension 50056 ShipmentInvoicedExtension extends "Shipment Invoiced"
{
    
    fields
    {
        field(50000; "Shipment Date"; Date)
        {
            CalcFormula = lookup ("Sales Shipment Header"."Posting Date" where ("No." = field ("Shipment No.")));
            Caption = 'Date d''expédition';
            FieldClass = FlowField;
        }

        
    }
    
}


