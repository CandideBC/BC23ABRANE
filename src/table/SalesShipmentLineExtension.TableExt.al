tableextension 50041 SalesShipmentLineExtension extends "Sales Shipment Line"
{
    fields
    {
        field(50090; "Nomenclature produits"; Code[20])
        {
            Caption = 'Nomenclature produits';
            DataClassification = ToBeClassified;
            TableRelation = "Tariff Number";
        }
        field(50100; "Eco Tax Furniture Code"; Code[10])
        {
            Caption = 'Code taxe éco mobilier';
            DataClassification = ToBeClassified;
            Description = 'CPT02';
            Editable = false;
            TableRelation = "Taxe eco-mobilier";
        }
        field(50110; "Eco Tax Furniture Amount"; Decimal)
        {
            Caption = 'Montant taxe éco mobilier';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 4;
            Editable = false;
        }
        field(50120; "Eco Tax Furniture Qty Per"; Decimal)
        {
            Caption = 'Eco mobilier Quantité Par';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50130; "Eco Tax Furniture Line"; Boolean)
        {
            Caption = 'Ligne éco mobilier';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50140; "Eco Tax Furniture Family"; Text[50])
        {
            CalcFormula = lookup("Taxe eco-mobilier".Family where(Code = field("Eco Tax Furniture Code")));
            Caption = 'Famille taxe éco mobilier';
            FieldClass = FlowField;
        }
        field(50150; "Eco Tax Furniture Sub Family"; Text[50])
        {
            CalcFormula = lookup("Taxe eco-mobilier"."Sub Family" where(Code = field("Eco Tax Furniture Code")));
            Caption = 'Sous famille taxe éco mobilier';
            FieldClass = FlowField;
        }
        field(50200; "Linked to line"; Integer)
        {
            Caption = 'Lié à la ligne';
            DataClassification = ToBeClassified;
            Description = 'BOM';
        }
        field(50210; "Explode Line"; Boolean)
        {
            Caption = 'Ligne éclatée';
            DataClassification = ToBeClassified;
            Description = 'BOM';
        }
        field(50230; "Prepayment Deducted Line"; Boolean)
        {
            Caption = 'Ligne acompte déductible';
            DataClassification = ToBeClassified;
        }
        field(50240; "Salesperson Code"; Code[10])
        {
            Caption = 'Code vendeur';
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";
        }
        field(50250; "Reason Code"; Code[10])
        {
            Caption = 'Code motif retour';
            DataClassification = ToBeClassified;
            TableRelation = "Reason Code";
        }
        field(50500; "Quantite commandee"; Decimal)
        {
            Caption = 'Quantité commandée';
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = ToBeClassified;
            Description = 'X01';
        }
        field(50510; "Quantite deja livree"; Decimal)
        {
            Caption = 'Quantité déjà livrée';
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = ToBeClassified;
            Description = 'X01';
        }
        field(51010; "Country/Region of Origin Code"; Code[10])
        {
            Caption = 'Code pays/région origine]';
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
        field(51190; "Code groupe"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Groupe client";
        }
        field(51200; "Code enseigne"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Enseigne;
        }
        field(51210; "Code operation"; Code[20])
        {
            Caption = 'Code opération';
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = Operations.Code where("Code enseigne" = field("Code enseigne"));
        }
        field(51220; "Code chantier"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Chantier;
        }
        field(78550; "Quantite a remettre en stock"; Decimal)
        {
            BlankZero = true;
            Caption = 'Quantité à remettre en stock';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'DV0035';
            Editable = true;

            trigger OnValidate()
            var
                QteTropGrandeErr: Label 'Vous ne pouvez pas remettre en stock plus de %1.', Comment = '%1 = Quantité';
            begin
                TestField(Type, Type::Item);
                TestField(Correction, false);
                if "Quantite a remettre en stock" > (Quantity - "Quantite deja remise en stock") then
                    Error(QteTropGrandeErr, Quantity - "Quantite deja remise en stock");
            end;
        }
        field(78560; "Quantite deja remise en stock"; Decimal)
        {
            BlankZero = true;
            Caption = 'Quantité déjà remise en stock';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'DV0035';
            Editable = false;
        }
        field(78570; "No. colisage"; Code[20])
        {
            Caption = 'N° colisage';
            DataClassification = ToBeClassified;
            Description = 'Champ 8056420 renumeroté pendant la migration BC23';
            Editable = false;
            TableRelation = "Entete colisage";
        }
        field(78580; "Packing in Progress"; Boolean)
        {
            Caption = 'Colisage en cours';
            DataClassification = ToBeClassified;
            Description = 'Champ 8056421 renumeroté pendant la migration BC23';
            Editable = false;
        }
        field(78585; "Quantite colisee"; Decimal)
        {
            Caption = 'Quantité colisée';
            Editable = false;
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
            CalcFormula = sum("Contenu colisage"."Quantite UC" where("Shipment No." = field("Document No."), "Shipment Line No." = field("Line No.")));
        }
        field(78590; SubTotal; Boolean)
        {
            Caption = 'Sous-total';
            DataClassification = ToBeClassified;
            Description = 'Champ 8056601 renumeroté pendant la migration BC23';
        }
        field(78600; "SubTotal Amount"; Decimal)
        {
            Caption = 'Montant sous-total HT';
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            DataClassification = ToBeClassified;
            Description = 'Champ 8056602 renumeroté pendant la migration BC23';
            Editable = false;
        }
    }

    procedure TransferLine(precShptLines: Record "Sales Shipment Line")
    var
        lItemJnlLine: record "Item Journal Line";
        LocDest: record Location;
        InvSetup: record "Inventory Setup";
        ItemJnlTemplate: record "Item Journal Template";
        Batch: record "Item Journal Batch";
        lEcr: Record "Item Ledger Entry";
        ItemJnlMgt: Codeunit ItemJnlManagement;
        LocList: page "Location List";
        LineNo: Integer;

    begin

        InvSetup.GET();
        InvSetup.TESTFIELD("Mod. feuil. art. remise stk BL");
        InvSetup.TESTFIELD("Nom feuil. art. remise stk BL");

        ItemJnlTemplate.GET(InvSetup."Mod. feuil. art. remise stk BL");
        Batch.GET(InvSetup."Mod. feuil. art. remise stk BL", InvSetup."Nom feuil. art. remise stk BL");

        LocList.LOOKUPMODE(true);

        if LocList.RUNMODAL() = ACTION::LookupOK then
            LocList.GETRECORD(LocDest)
        else
            exit;
        COMMIT();

        lItemJnlLine.RESET();
        lItemJnlLine.SETRANGE("Journal Template Name", InvSetup."Mod. feuil. art. remise stk BL");
        lItemJnlLine.SETRANGE("Journal Batch Name", InvSetup."Nom feuil. art. remise stk BL");
        if lItemJnlLine.FINDLAST() then
            LineNo := lItemJnlLine."Line No.";
        if precShptLines.FINDSET(false) then
            repeat
                if (Type = Type::Item) and not Correction and (Quantity > 0) and ("Location Code" <> LocDest.Code) then begin
                    LineNo += 10000;
                    lEcr.GET("Item Shpt. Entry No.");

                    lItemJnlLine.INIT();
                    lItemJnlLine."Journal Template Name" := InvSetup."Mod. feuil. art. remise stk BL";
                    lItemJnlLine."Journal Batch Name" := InvSetup."Nom feuil. art. remise stk BL";
                    lItemJnlLine."Line No." := LineNo;
                    lItemJnlLine.INSERT();

                    lItemJnlLine."Posting Date" := WORKDATE();
                    lItemJnlLine."Document Date" := WORKDATE();
                    lItemJnlLine."Document No." := precShptLines."Document No.";
                    lItemJnlLine."Entry Type" := lItemJnlLine."Entry Type"::"Positive Adjmt.";
                    lItemJnlLine.VALIDATE("Item No.", precShptLines."No.");
                    lItemJnlLine.VALIDATE("Variant Code", precShptLines."Variant Code");
                    lItemJnlLine."Dimension Set ID" := precShptLines."Dimension Set ID";
                    lItemJnlLine."Location Code" := LocDest.Code;
                    lItemJnlLine.VALIDATE("Unit of Measure Code", precShptLines."Unit of Measure Code");
                    lItemJnlLine.VALIDATE(Quantity, precShptLines.Quantity);
                    lItemJnlLine.VALIDATE("Unit Cost", (lEcr."Cost Amount (Expected)" + lEcr."Cost Amount (Actual)") / lEcr.Quantity);
                    lItemJnlLine."Source Code" := ItemJnlTemplate."Source Code";
                    lItemJnlLine.MODIFY();
                end;
            until precShptLines.NEXT() = 0;

        ItemJnlMgt.TemplateSelectionFromBatch(Batch);
    end;
}

