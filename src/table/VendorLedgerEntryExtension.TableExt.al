tableextension 50032 VendorLedgerEntryExtension extends "Vendor Ledger Entry"
{
    fields
    {
        field(50500; "Applied Vend. Ledger Entry No."; Integer)
        {
            CalcFormula = max ("Detailed Vendor Ledg. Entry"."Applied Vend. Ledger Entry No." where ("Vendor Ledger Entry No." = field ("Entry No."),
                                                                                                    "Entry Type" = const (Application),
                                                                                                    Unapplied = const (false)));
            Caption = 'N° écriture fournisseur lettrée';
            Description = 'TRIX.027';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}

