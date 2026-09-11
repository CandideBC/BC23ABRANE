tableextension 50036 ItemJournalLineExtension extends "Item Journal Line"
{
    fields
    {
        field(50000; "Document Type BOM"; Enum "Sales Document Type")
        {
            Caption = 'Type document composé';
            DataClassification = ToBeClassified;
            Description = 'BOM';
            Editable = false;
            //OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            //OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(50010; "Document No. BOM"; Code[20])
        {
            Caption = 'N° document composé';
            DataClassification = ToBeClassified;
            Description = 'BOM';
            Editable = false;
            TableRelation = "Sales Header"."No." where ("Document Type" = field ("Document Type BOM"));
        }
        field(50020; "Document Line No. BOM"; Integer)
        {
            Caption = 'N° ligne document composé';
            DataClassification = ToBeClassified;
            Description = 'BOM';
            Editable = false;
        }
        field(50030; "Cust Ref."; Code[20])
        {
            CalcFormula = lookup (Item."No. 2" where ("No." = field ("Item No.")));
            Caption = 'Réf. Client';
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
        field(50070; "Qté sur commande achat"; Decimal)
        {
            Caption = 'Qté sur commande achat';
            FieldClass = FlowField;
            CalcFormula = Sum("Purchase Line"."Outstanding Qty. (Base)" WHERE ("Document Type"=CONST(Order),Type=CONST(Item),"No."=FIELD("Item No."),"Variant Code"=FIELD("Variant Code")));
            Editable = false;

        }
        field(50080; "Qté sur commande vente"; Decimal)
        {
            Caption = 'Qté sur commande vente';
            FieldClass = FlowField;
            CalcFormula = sum("Sales Line"."Outstanding Qty. (Base)" where ("Document Type"=const(order),Type=const(item),"No."=field("Item No."),"Variant code"=field("Variant Code")));
            Editable = false;
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




 
 
 
}

