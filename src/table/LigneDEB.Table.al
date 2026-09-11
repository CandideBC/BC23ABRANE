table 50045 "Ligne DEB"
{
    // KAN.FHA 09/09/2022
    //   Ajout d'une clé pour faire une rupture par pays d'origine et non par pays de destination
    //     Type,Country/Region of Origin Code,Tariff No.,Transaction Type,Transport Method

    Caption = 'Ligne DEB';

    fields
    {
        field(1; "Date debut periode comptable"; Date)
        {
            Caption = 'Date début période comptable';
        }
        field(4; "Type ligne DEB"; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Réception,Expédition';
            OptionMembers = Réception,Expédition;
        }
        field(5; Date; Date)
        {
            Caption = 'Date';
        }
        field(6; "Tariff No."; Code[20])
        {
            Caption = 'Nomenclature produits';
            NotBlank = true;
            TableRelation = "Tariff Number";

            trigger OnValidate()
            begin
                //KAN.FHA 06/09/2022 DEBUT
                "No. nomenclature reduit" := CopyStr("Tariff No.", 1, 8);
                //KAN.FHA 06/09/2022 FIN
            end;
        }
        field(7; "Item Description"; Text[100])
        {
            Caption = 'Désignation article';
        }
        field(8; "Country/Region Code"; Code[10])
        {
            Caption = 'Code pays';
            TableRelation = "Country/Region";
        }
        field(9; "Transaction Type"; Code[10])
        {
            Caption = 'Type transaction';
            TableRelation = "Transaction Type";
        }
        field(10; "Transport Method"; Code[10])
        {
            Caption = 'Mode de transport';
            TableRelation = "Transport Method";
        }
        field(13; "Net Weight"; Decimal)
        {
            Caption = 'Poids net';
            DecimalPlaces = 2 : 5;

            trigger OnValidate()
            begin
                if Quantity <> 0 then
                    "Total Weight" := Round("Net Weight" * Quantity, 0.00001)
                else
                    "Total Weight" := 0;
            end;
        }
        field(15; Quantity; Decimal)
        {
            Caption = 'Quantité';
            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            begin
                if (Quantity <> 0) and Item.Get("Item No.") then
                    Validate("Net Weight", Item."Net Weight")
                else
                    Validate("Net Weight", 0);
            end;
        }
        field(19; "Document No."; Code[20])
        {
            Caption = 'N° document';
        }
        field(20; "Item No."; Code[20])
        {
            Caption = 'N° article';
            TableRelation = Item;

            trigger OnValidate()
            begin
                if "Item No." = '' then
                    Clear(Item)
                else begin
                    Item.Get("Item No.");
                    Item.TestField("Tariff No.");
                end;

                Name := Item.Description;
                "Tariff No." := Item."Tariff No.";
                "Country/Region of Origin Code" := Item."Country/Region of Origin Code";
            end;
        }
        field(21; Name; Text[100])
        {
            Caption = 'Nom';
        }
        field(22; "Total Weight"; Decimal)
        {
            Caption = 'Poids total';
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(25; "Country/Region of Origin Code"; Code[10])
        {
            Caption = 'Code pays origine';
            TableRelation = "Country/Region";
        }
        field(26; "Entry/Exit Point"; Code[10])
        {
            Caption = 'Pays destination/provenance';
            TableRelation = "Entry/Exit Point";
        }
        field(27; "Area"; Code[10])
        {
            Caption = 'Dépt destination/provenance';
            TableRelation = Area;
        }
        field(28; "Transaction Specification"; Code[10])
        {
            Caption = 'Régime';
            TableRelation = "Transaction Specification";
        }
        field(10800; "Shipment Method Code"; Code[10])
        {
            Caption = 'Code condition livraison';
            TableRelation = "Shipment Method";
        }
        field(10801; "VAT Registration No."; Text[20])
        {
            Caption = 'N° identif intracom.';
            Description = 'KAN.FHA Je choisis de stocker aussi l''ID TVA du fournisseur donc champ renommé de [Cust. VAT Registration No.] en [VAT Registration No.]';
        }
        field(50000; "No. nomenclature reduit"; Code[8])
        {
            Caption = 'N° nomenclature réduit';
            Description = 'KAN.FHA 25/08/2022 8 premiers chiffres du code douanier. ABRANE doit déclarer sur les 8 premiers chiffres.';
        }
        field(50025; "Type document"; Option)
        {
            Caption = 'Type document';
            OptionMembers = Facture,Avoir;
        }
        field(50030; "No. document"; Code[20])
        {
            Caption = 'N° document';
            Description = 'N° de la facture d''achat ou de vente';
            TableRelation = if ("Type ligne DEB" = const ("Réception"),
                                "Type document" = const (Facture)) "Purch. Inv. Header"."No."
            else
            if ("Type ligne DEB" = const ("Réception"),
                                         "Type document" = const (Avoir)) "Purch. Cr. Memo Hdr."."No."
            else
            if ("Type ligne DEB" = const ("Expédition"),
                                                  "Type document" = const (Facture)) "Sales Invoice Header"."No."
            else
            if ("Type ligne DEB" = const ("Expédition"),
                                                           "Type document" = const (Avoir)) "Sales Cr.Memo Header"."No.";
        }
        field(50040; "No. ligne document"; Integer)
        {
            Caption = 'N° ligne document';
            Description = 'N° ligne de facture d''achat ou de vente';
            TableRelation = if ("Type ligne DEB" = const ("Réception"),
                                "Type document" = const (Facture)) "Purch. Inv. Line"."Line No." where ("Document No." = field ("No. document"))
            else
            if ("Type ligne DEB" = const ("Réception"),
                                         "Type document" = const (Avoir)) "Purch. Cr. Memo Line"."Line No." where ("Document No." = field ("No. document"))
            else
            if ("Type ligne DEB" = const ("Expédition"),
                                                  "Type document" = const (Facture)) "Sales Invoice Line"."Line No." where ("Document No." = field ("No. document"))
            else
            if ("Type ligne DEB" = const ("Expédition"),
                                                           "Type document" = const (Avoir)) "Purch. Cr. Memo Line"."Line No." where ("Document No." = field ("No. document"));
        }
        field(50050; "Montant marchandise (ligne)"; Decimal)
        {
            Description = 'Montant des articles ayant un code douanier, remise facture déduite.';

            trigger OnValidate()
            begin
                "Montant total (ligne)" := "Montant marchandise (ligne)" + "Montants autres (ligne)";
            end;
        }
        field(50060; "Montants autres (ligne)"; Decimal)
        {
            Description = 'Montants des lignes "999999" de la facture dispatchés au prorata du montant de chaque ligne non 999999';

            trigger OnValidate()
            begin
                "Montant total (ligne)" := "Montant marchandise (ligne)" + "Montants autres (ligne)";
            end;
        }
        field(50070; "Montant total (ligne)"; Decimal)
        {
            Description = 'Sommes des deux champs précédents';
            Editable = false;
        }
        field(50080; "Code douanier fictif"; Boolean)
        {
            Description = 'Vaut oui si le code douanier est 9999999.';
        }
        field(50090; "Num Derniere ligne facture"; Integer)
        {
            CalcFormula = max ("Ligne DEB"."No. ligne document" where ("Type ligne DEB" = const ("Expédition"),
                                                                      "Type document" = field ("Type document"),
                                                                      "No. document" = field ("No. document"),
                                                                      "Code douanier fictif" = const (false)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Date debut periode comptable", "Type ligne DEB", "No. document", "No. ligne document")
        {
            Clustered = true;
        }
        key(Key2; "Date debut periode comptable", "Type ligne DEB", "Type document", "No. document", "No. ligne document")
        {
        }
        key(Key3; "Date debut periode comptable", "Type ligne DEB", "Type document", "No. document", "Tariff No.")
        {
        }
        key(Key4; "Type ligne DEB", "Type document", "No. document", "Code douanier fictif", "No. ligne document")
        {
            SumIndexFields = "Montants autres (ligne)","No. ligne document";
        }
        key(Key5; "Date debut periode comptable", "Type ligne DEB", "Country/Region of Origin Code", "Tariff No.", "Transaction Type", "Transport Method", "VAT Registration No.")
        {
        }

    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        Periode.Get("Date debut periode comptable");
        case "Type ligne DEB" of
            "Type ligne DEB"::"Expédition":
                Periode.TestField("DEB Ventes cloturee", false);
        end;
    end;

    var
        Item: Record Item;
        Periode: Record "Accounting Period";
}

