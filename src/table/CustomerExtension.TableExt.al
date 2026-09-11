tableextension 50027 CustomerExtension extends Customer
{
    fields
    {
        field(50000; "Eco Tax Furniture Liable"; Boolean)
        {
            Caption = 'Soumis taxe éco mobilier';
            DataClassification = ToBeClassified;
            Description = 'CPT02';
            InitValue = true;
        }

        field(50002; Factoring; Boolean)
        {
            Caption = 'Affacturage';
            DataClassification = ToBeClassified;
            Description = 'X01';
        }
        field(50010; "Price Included Eco Tax"; Boolean)
        {
            Caption = 'Prix écotaxe compris';
            DataClassification = ToBeClassified;
            Description = 'CPT02';
        }

        field(50060; "Shipment Blocked"; Boolean)
        {
            Caption = 'Bloquer expédition';
            DataClassification = ToBeClassified;
        }
        field(50550; "Factor Code"; Code[10])
        {
            Caption = 'Code Banque';
            DataClassification = ToBeClassified;
            Description = 'Facto';
            TableRelation = Factor."Factor Code";
        }
        field(50560; "Code enseigne"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Affaires';
            TableRelation = Enseigne;
            trigger OnValidate()
            var
                Enseigne: Record Enseigne;
                MAJCondPaiementQst: Label 'Voulez-compléter les conditions de paiement en appliquant les valeurs de l''enseigne (%1)',Comment='%1 = Conditions de paiement de l''enseigne.';
                RemplirCondPaiementMsg: Label 'N''oubliez pas de renseigner les condition de paiement (pour les acomptes et les factures de situation également)';
            begin
                if ("Code enseigne" <> '') and (Rec."Payment Terms Code" = '') then
                    if Enseigne.get("Code enseigne") then
                        if confirm(MAJCondPaiementQst,true) then begin
                            Rec.validate("Payment Terms Code",Enseigne."Code conditions paiement");
                            Rec.Validate("Code cond. paiement acomptes",Enseigne."Code conditions paiement");
                            Rec.Validate("Code cond. paiement situation",Enseigne."Code conditions paiement");
                        end else
                            Message(RemplirCondPaiementMsg);
            end;
        }
        field(50565; "Code groupe"; Code[20])
        {
            CalcFormula = lookup(Enseigne."Code groupe" where(Code = field("Code enseigne")));
            Description = 'KAN.FHA 19/02/2021';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Groupe client";
        }
        
        field(50570; "Code cond. paiement acomptes"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'Peut paraitre idiot, on mettra "COMPTANT" sur toutes les enseignes mais cela évite de coder en dur "COMPTANT"';
            TableRelation = "Payment Terms";
        }

        field(50580; "% acompte situation"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50590; "Code cond. paiement situation"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Terms";
        }
    }
    keys
    {
        key(MyKey1; "Customer Price Group")
        {
            
        }
        key(MyKey2; "Code enseigne")
        {
            
        }
        key(MyKey3; "Registration Number")
        {
            
        }
        key(MyKey4; "VAT Registration No.")
        {
            
        }
    }
    procedure DupliquerReferencesArticles()
    var
        ClientOrigine: Record Customer;
        ReferenceArticleClientOrigine: Record "Item Reference";
        ReferenceArticleClientCourant: Record "Item Reference";
        Fenetre: Dialog;
        TitreFenetre: Label 'Mise à jour des références depuis autres clients %1';
    begin
        //On va parcourir tous les clients ayant meme [Groupe prix client] et de meme langue que le client actif
        ClientOrigine.SetCurrentKey("Customer Price Group");
        ClientOrigine.SetRange("Customer Price Group", Rec."Customer Price Group");
        ClientOrigine.SetRange("Language Code",Rec."Language Code");

        IF ClientOrigine.Findset(false) then begin
            ReferenceArticleClientOrigine.SetCurrentKey("Reference Type", "Reference Type No.");
            Fenetre.open(StrSubstNo(TitreFenetre,"Customer Price Group"));
            repeat
                ReferenceArticleClientOrigine.SetRange("Reference Type", ReferenceArticleClientOrigine."Reference Type"::Customer);
                ReferenceArticleClientOrigine.SetRange("Reference Type No.", ClientOrigine."No.");
                IF ReferenceArticleClientOrigine.FindSet(false) then
                    repeat
                        IF not ReferenceArticleClientCourant.GET
                            (ReferenceArticleClientOrigine."Item No.", ReferenceArticleClientOrigine."Variant Code", ReferenceArticleClientOrigine."Unit of Measure",
                             ReferenceArticleClientOrigine."Reference Type", rec."No.", ReferenceArticleClientOrigine."Reference No.")
                        then begin
                            ReferenceArticleClientCourant.Init();
                            ReferenceArticleClientCourant := ReferenceArticleClientOrigine;
                            ReferenceArticleClientCourant.Validate("Reference Type No.",Rec."No.");
                            ReferenceArticleClientCourant.Insert();
                        end;
                    until ReferenceArticleClientOrigine.Next() = 0;
            until ClientOrigine.Next() = 0;
            Fenetre.Close();
        end;
    end;

    procedure SupprimerReferencesArticles()
    var
        ReferenceArticle: Record "Item Reference";
    begin
        ReferenceArticle.SetCurrentKey("Reference Type", "Reference Type No.");
        ReferenceArticle.SetRange("Reference Type", ReferenceArticle."Reference Type"::Customer);
        ReferenceArticle.SetRange("Reference Type No.", Rec."No.");
        ReferenceArticle.DeleteAll(true);
    end;
}

