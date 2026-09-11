table 50034 "Détail valeur stock à date"
{
    DrillDownPageID = "Achats Divers sans affectation";

    fields
    {
        field(10; "No. article"; Code[20])
        {
            Caption = 'N° article';
            TableRelation = Item;
        }
        field(12; "No. ecriture article"; Integer)
        {
            TableRelation = "Item Ledger Entry"."Entry No." WHERE ("Item No." = FIELD ("No. article"));
        }
        field(15; "Type document"; Option)
        {
            OptionMembers = "Achat marchandise","Factures manquantes";
        }
        field(20; "No. document"; Code[20])
        {
            Caption = 'N° facture achat';
            TableRelation = "Purch. Inv. Header";
        }
        field(30; "No. ligne document"; Integer)
        {
            Caption = 'N° ligne facture achat';
            TableRelation = "Purch. Inv. Line"."Line No." WHERE ("Document No." = FIELD ("No. document"));
        }
        field(33; "No. ecriture valeur"; Integer)
        {
            Caption = 'N° écriture valeur';
        }
        field(35; "Date comptabilisation"; Date)
        {
        }
        field(38; "Frais annexe"; Boolean)
        {
        }
        field(39; "Factures manquantes"; Boolean)
        {
        }
        field(40; Quantite; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
        }
        field(50; "Cout unitaire"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 2;
        }
        field(60; "Cout total"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "No. article", "No. ecriture article", "Type document", "No. document", "No. ligne document", "No. ecriture valeur")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

