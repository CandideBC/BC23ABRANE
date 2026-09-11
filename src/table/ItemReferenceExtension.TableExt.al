tableextension 50049 ItemReferenceExtension extends "Item Reference"
{
    fields
    {
        field(50010; "Nom client/fournisseur"; Text[100])
        {
            Caption = 'Nom client/fournisseur';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50011; "Complément réf. client"; Text[30])
        {
            CalcFormula = lookup (Item."Complement ref. client" where ("No." = field ("Item No.")));
            FieldClass = FlowField;
        }
        field(50020; "Customer Price Group"; Code[20])
        {
            CalcFormula = lookup (Customer."Customer Price Group" where ("No." = field ("Reference Type No.")));
            Caption = 'Groupe prix client';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Customer Price Group";
        }
    }
    keys
    {
        key(MyKey1; "Item No.","Reference Type")
        {
            
        }
    }

    procedure DuplicateFromItemCrossReference_T(OnInsertAction: Boolean)
    var
        Cust_lrc: Record Customer;
        Client: Record Customer;
        ConfirmationDialogQst: Label 'Souhaitez vous dupliquer cette référence externe sur tous les clients ayant comme groupe prix client %1?',Comment='%1 = Groupe prix';
        AttenteLbl: Label 'Mise à jour de la table %1 en cours. Merci de patienter ...',Comment = '%1 = Table';
        window: Dialog;
        
    begin
        //- DIA.160527-P2/BPE
        if "Reference Type" <> "Reference Type"::Customer then
            exit;
        Cust_lrc.SetRange("No.", "Reference Type No.");

        if Cust_lrc.FindSet(false) then begin
            if Cust_lrc."Customer Price Group" = '' then
                exit;
            if OnInsertAction then
                if not Confirm(StrSubstNo(ConfirmationDialogQst, Cust_lrc."Customer Price Group"), true) then
                    exit;
            window.Open(StrSubstNo(AttenteLbl, TableCaption));
            Cust_lrc.SetRange("Customer Price Group", Cust_lrc."Customer Price Group");
            Cust_lrc.SetFilter("No.", '<>%1', Cust_lrc."No.");
            //KAN.FHA 25/02/2022 DEBUT
            if "Reference Type" = "Reference Type"::Customer then
                if Client.Get("Reference Type No.") then
                    Cust_lrc.SetRange("Language Code", Client."Language Code");
            //KAN.FHA 25/02/2022 FIN

            if Cust_lrc.FindSet(false) then
                repeat
                    Sub_Duplicate_T(Rec, Cust_lrc, OnInsertAction)
                until Cust_lrc.Next() = 0;
            window.Close();
        end;
        //+ DIA.160527-P2/BPE
    end;

    procedure DuplicateFromCustomer_T(Cust_prc: Record Customer)
    var
        Cust_lrc: Record Customer;
        ItemCrossRef_lrc: Record "Item Reference";
        
        AttenteLbl: Label 'Mise à jour de la table %1 en cours.\Merci de patienter ...',Comment = '%1 = Table';
        window: Dialog;
        ErrorFieldNotNullErr: Label 'Le groupe prix client doit être renseigné pour exécuter cette action.';
    begin
        //- DIA.160527-P2/BPE
        if Cust_prc."Customer Price Group" = '' then
            Error(ErrorFieldNotNullErr);
        window.Open(StrSubstNo(AttenteLbl, TableCaption));
        Cust_lrc.SetRange("Customer Price Group", Cust_prc."Customer Price Group");
        //KAN.FHA 25/02/2022 DEBUT
        Cust_lrc.SetRange(Cust_lrc."Language Code", Cust_prc."Language Code");
        //KAN.FHA 25/02/2022 FIN
        Cust_lrc.SetFilter("No.", '<>%1', Cust_prc."No.");
        if Cust_lrc.FindSet(false) then
            repeat
                ItemCrossRef_lrc.SetRange("Reference Type", ItemCrossRef_lrc."Reference Type"::Customer);
                ItemCrossRef_lrc.SetRange("Reference Type No.", Cust_prc."No.");
                if ItemCrossRef_lrc.FindSet(false) then
                    repeat
                        Sub_Duplicate_T(ItemCrossRef_lrc, Cust_lrc, true);
                    until ItemCrossRef_lrc.Next() = 0;
            until Cust_lrc.Next() = 0;
        window.Close();
        //+ DIA.160527-P2/BPE
    end;

    local procedure Sub_Duplicate_T(ItemCrossRef_prc: Record "Item Reference"; Cust_prc: Record Customer; OnInsertAction: Boolean)
    var
        ItemCrossRef_lrc: Record "Item Reference";
        
    begin
        //- DIA.160527-P2/BPE
        ItemCrossRef_lrc.SetRange("Item No.", ItemCrossRef_prc."Item No.");
        ItemCrossRef_lrc.SetRange("Variant Code", ItemCrossRef_prc."Variant Code");
        ItemCrossRef_lrc.SetRange("Unit of Measure", ItemCrossRef_prc."Unit of Measure");
        ItemCrossRef_lrc.SetRange("Reference Type", ItemCrossRef_prc."Reference Type");
        ItemCrossRef_lrc.SetRange("Reference Type No.", Cust_prc."No.");
        ItemCrossRef_lrc.SetRange("Reference No.", ItemCrossRef_prc."Reference No.");
        if OnInsertAction then begin
            if ItemCrossRef_lrc.IsEmpty then begin
                ItemCrossRef_lrc := ItemCrossRef_prc;
                ItemCrossRef_lrc.Validate("Reference Type No.", Cust_prc."No.");
                ItemCrossRef_lrc.Insert();
            end;
        end else
            if ItemCrossRef_lrc.FindSet(true) then begin
                ItemCrossRef_lrc.Description := ItemCrossRef_prc.Description;
                //ItemCrossRef_lrc."Discontinue Bar Code" := ItemCrossRef_prc."Discontinue Bar Code";
                ItemCrossRef_lrc.Modify();
            end;
        
        //+ DIA.160527-P2/BPE
    end;



}

