tableextension 50033 ItemLedgerEntryExtension extends "Item Ledger Entry"
{
    fields
    {
        field(50000; "Document Type BOM"; enum "Sales Document Type")
        {
            Caption = 'Document Type BOM';
            DataClassification = ToBeClassified;
            Description = 'BOM';
            Editable = false;
            //OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            //OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(50010; "Document No. BOM"; Code[20])
        {
            Caption = 'Document No.BOM';
            DataClassification = ToBeClassified;
            Description = 'BOM';
            Editable = false;
            TableRelation = "Sales Header"."No." where ("Document Type" = field ("Document Type BOM"));
        }
        field(50020; "Document Line No. BOM"; Integer)
        {
            Caption = 'Document Line No.';
            DataClassification = ToBeClassified;
            Description = 'BOM';
            Editable = false;
        }
        field(50030; "Cost Amount (Expected) BOM"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum ("Value Entry"."Cost Amount (Expected)" where ("Document Type BOM" = field ("Document Type BOM"),
                                                                            "Document No. BOM" = field ("Document No. BOM"),
                                                                            "Document Line No. BOM" = field ("Document Line No. BOM")));
            Caption = 'Cost Amount (Expected) BOM';
            Description = 'BOM';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50040; "Cost Amount (Actual) BOM"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum ("Value Entry"."Cost Amount (Actual)" where ("Document Type BOM" = field ("Document Type BOM"),
                                                                          "Document No. BOM" = field ("Document No. BOM"),
                                                                          "Document Line No. BOM" = field ("Document Line No. BOM")));
            Caption = 'Cost Amount (Actual) BOM';
            Description = 'BOM';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50041; "Ref Client"; Code[20])
        {
            CalcFormula = lookup (Item."No. 2" where ("No." = field ("Item No.")));
            Caption = 'Réf Client';
            FieldClass = FlowField;
        }
        field(50050; "Remis en stock depuis BL"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'DV0035';
        }
        field(50060; "Transfert reception achat"; Boolean)
        {
            Caption = 'Transfert réception achat';
            DataClassification = ToBeClassified;
            Description = 'DV0035';
        }
        field(60000; "Revalorisation cout mvt"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'FTS';
        }
        field(60010; "SAV fournisseur"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Le recalcul d''un PMP doit exclure les achats liés à des SAV Fournisseurs.';
        }
        field(60020; "Exclure DEB"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 18/10/2022 Les mouvements de SAV vente et SAV achats (Type fournisseur uniquement) ne doivent pas être extraits sur la feuille intracomm';
        }
    }

    keys
    {
        key(MyKey1; "Item No.","Posting Date",Positive,"Location Code")
        {
            SumIndexFields = Quantity;
        }
        key(MyKey2; "Remis en stock depuis BL")
        {
            
        }
        key(MyKey3; "Posting Date","Document No.")
        {
            
        }
        key(MyKey5; "Item No.","Positive","Posting Date")
        {
            
        }
        key(MyKey6; "Item No.","Location Code","Posting Date")
        {
            
        }
        key(MyKey7; "Item No.","Variant Code","Location Code","Drop Shipment")
        {
            SumIndexFields = Quantity;
        }
        key(MyKey8; "Item No.","Entry Type","Posting Date")
        {
            
        }
    }

}

