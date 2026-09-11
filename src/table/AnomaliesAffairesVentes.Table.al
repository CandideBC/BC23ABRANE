table 50000 "Anomalies affaires ventes"
{
    Caption = 'Anomalies affaires ventes';
    Permissions = TableData "Sales Invoice Line" = rm,
                  TableData "Sales Cr.Memo Line" = rm;

    fields
    {
        field(2; "Sell-to Customer No."; Code[20])
        {
            Caption = 'N° donneur d''ordre';
            Editable = false;
            TableRelation = Customer;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'N° document';
            TableRelation = if ("Type document" = const (Facture)) "Sales Invoice Header"
            else
            if ("Type document" = const (Avoir)) "Sales Cr.Memo Header";
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'N° ligne';
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        }
        field(6; "No."; Code[20])
        {
            Caption = 'N°';
            TableRelation = if (Type = const ("G/L Account")) "G/L Account"
            else
            if (Type = const (Item)) Item
            else
            if (Type = const (Resource)) Resource
            else
            if (Type = const ("Fixed Asset")) "Fixed Asset"
            else
            if (Type = const ("Charge (Item)")) "Item Charge";
        }
        field(11; Description; Text[50])
        {
            Caption = 'Désignation';
        }
        field(15; Quantity; Decimal)
        {
            Caption = 'Quantité';
            DecimalPlaces = 0 : 5;
        }
        field(22; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Prix unitaire';
        }
        field(23; "Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Coût unitaire (DS)';
        }
        field(29; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Montant';
        }
        field(43; "Salesperson Code"; Code[20])
        {
            CalcFormula = lookup ("Sales Invoice Header"."Salesperson Code" where ("No." = field ("Document No.")));
            Caption = 'Code vendeur';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Salesperson/Purchaser";
        }
        field(51190; "Code groupe"; Code[20])
        {
            Description = 'KAN';
            TableRelation = "Groupe client";
        }
        field(51200; "Code enseigne"; Code[20])
        {
            Description = 'KAN';
            TableRelation = Enseigne;
        }
        field(51220; "Code chantier"; Code[20])
        {
            Description = 'KAN';
            TableRelation = Chantier.Code where ("Code enseigne" = field ("Code enseigne"));

            trigger OnValidate()
            begin
                case "Type document" of
                    "Type document"::Facture:
                        
                            if "Code chantier" <> xRec."Code chantier" then begin
                                LigneFactureVente.Get("Document No.", "Line No.");
                                LigneFactureVente."Code chantier" := "Code chantier";
                                LigneFactureVente.Modify();
                                LigneFactureVente.VerifChampsAffaire();
                            end;
                        
                    "Type document"::Avoir:
                        
                            if "Code chantier" <> xRec."Code chantier" then begin
                                LigneAvoirVente.Get("Document No.", "Line No.");
                                LigneAvoirVente."Code chantier" := "Code chantier";
                                LigneAvoirVente.Modify();
                                LigneAvoirVente.VerifChampsAffaire();
                            end;
                        
                end;
            end;
        }
        field(55555; "Description anomalie"; Text[100])
        {
        }
        field(55556; "Commentaire facture"; Text[250])
        {
            CalcFormula = lookup ("Sales Invoice Header".Commentaire where ("No." = field ("Document No.")));
            Caption = 'Commentaire facture';
            FieldClass = FlowField;
        }
        field(55557; "Type document"; Option)
        {
            OptionCaption = 'Avoir,Facture';
            OptionMembers = Avoir,Facture;
        }
    }

    keys
    {
        key(Key1; "Type document", "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        LigneFactureVente: Record "Sales Invoice Line";
        LigneAvoirVente: Record "Sales Cr.Memo Line";
}

