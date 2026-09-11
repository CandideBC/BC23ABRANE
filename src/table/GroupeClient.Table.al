table 50024 "Groupe client"
{
    LookupPageID = 50077;

    fields
    {
        field(10; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(20; Description; Text[50])
        {
        }
        field(30; "Filtre date"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(35; "Filtre annee commande"; Integer)
        {
            Caption = 'Filtre année commande';
            FieldClass = FlowFilter;
        }
        field(500; "Montant factures ventes"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Sales Invoice Line"."Montant ligne HT (DS)" where ("Code groupe" = field (Code),
                                                                                  "Exclure de la rentabilite" = const (false),
                                                                                  "Posting Date" = field ("Filtre date")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(501; "Montant avoirs ventes"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Sales Cr.Memo Line"."Montant ligne HT (DS)" where ("Code groupe" = field (Code),
                                                                                  "Exclure de la rentabilite" = const (false),
                                                                                  "Posting Date" = field ("Filtre date")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(510; "Montant factures achats"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Purch. Inv. Line"."Montant ligne HT (DS)" where ("Code groupe" = field (Code),
                                                                                "Posting Date" = field ("Filtre date")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(511; "Montant avoirs achats"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Purch. Cr. Memo Line"."Montant ligne HT (DS)" where ("Code groupe" = field (Code),
                                                                                    "Posting Date" = field ("Filtre date")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(520; "Montant reste a livrer"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Sales Line"."Montant restant HT (DS)" where ("Document Type" = const (Order),
                                                                            "Code groupe" = field (Code),
                                                                            "Exclure de la rentabilite" = const (false),
                                                                            SAV = const (false),
                                                                            "Annee commande" = field ("Filtre annee commande")));
            Caption = 'Montant reste à livrer';
            Editable = false;
            FieldClass = FlowField;
        }
        field(525; "Montant livre non facture"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Sales Line"."Livre non facture HT (DS)" where ("Document Type" = const (Order),
                                                                              "Code groupe" = field (Code),
                                                                              "Exclure de la rentabilite" = const (false),
                                                                              "Annee commande" = field ("Filtre annee commande")));
            Caption = 'Montant livré non facturé';
            Editable = false;
            FieldClass = FlowField;
        }
        field(530; "Montant sur cdes achats"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Purchase Line"."Montant restant HT (DS)" where ("Document Type" = const (Order),
                                                                               "Code groupe" = field (Code),
                                                                               "Annee commande" = field ("Filtre annee commande")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(535; "Montant recu non facture"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Purchase Line"."A. Rcd. Not Inv. Ex. VAT (LCY)" where ("Document Type" = const (Order),
                                                                                      "Code groupe" = field (Code),
                                                                                      "Annee commande" = field ("Filtre annee commande")));
            Caption = 'Montant reçu non facturé';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1000; "Cout total Achats+Stock"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Ecriture rentabilite"."Montant total (DS)" where ("Code groupe" = field (Code),
                                                                                 "Type ecriture" = const ("Coût"),
                                                                                 "Type de cout" = filter (Stock .. Achat)));
            Caption = 'Coût total Achats+Stock';
            Description = 'Correspond de toutes les natures de vente donc des champs 1001 à 1054';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1001; "Cout total hors catégorie"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Ecriture rentabilite"."Montant total (DS)" where ("Code groupe" = field (Code),
                                                                                 "Type ecriture" = const ("Coût"),
                                                                                 "Nature vente" = const ("Indéfini"),
                                                                                 "Type de cout" = filter (Stock .. Achat)));
            Caption = 'Coût total hors catégorie';
            Description = 'Renta : Coût dont la nature de vente est "Indéfinie"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1002; "Cout total Mobilier"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Ecriture rentabilite"."Montant total (DS)" where ("Code groupe" = field (Code),
                                                                                 "Type ecriture" = const ("Coût"),
                                                                                 "Nature vente" = const (Mobilier),
                                                                                 "Type de cout" = filter (Stock .. Achat)));
            Caption = 'Coût total Mobilier';
            Description = 'Renta';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1012; "Cout total Pose/Audit"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Ecriture rentabilite"."Montant total (DS)" where ("Code groupe" = field (Code),
                                                                                 "Type ecriture" = const ("Coût"),
                                                                                 "Nature vente" = const ("Pose/Audit"),
                                                                                 "Type de cout" = filter (Stock .. Achat)));
            Caption = 'Coût total Pose/Audit';
            Description = 'Renta';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1022; "Cout total Transport"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Ecriture rentabilite"."Montant total (DS)" where ("Code groupe" = field (Code),
                                                                                 "Type ecriture" = const ("Coût"),
                                                                                 "Nature vente" = const (Transport),
                                                                                 "Type de cout" = filter (Stock .. Achat)));
            Caption = 'Coût total Transport';
            Description = 'Renta';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1032; "Cout total Bennes/Fenwick"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Ecriture rentabilite"."Montant total (DS)" where ("Code groupe" = field (Code),
                                                                                 "Type ecriture" = const ("Coût"),
                                                                                 "Nature vente" = const ("Bennes/Fenwick"),
                                                                                 "Type de cout" = filter (Stock .. Achat)));
            Caption = 'Coût total Bennes/Fenwick';
            Description = 'Renta';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1042; "Cout total SAV"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Ecriture rentabilite"."Montant total (DS)" where ("Code groupe" = field (Code),
                                                                                 "Type ecriture" = const ("Coût"),
                                                                                 "Nature vente" = const (SAV),
                                                                                 "Type de cout" = filter (Stock .. Achat)));
            Caption = 'Coût total SAV';
            Description = 'Renta';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1052; "Frais d'approche"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Ecriture rentabilite"."Montant total (DS)" where ("Code groupe" = field (Code),
                                                                                 "Type ecriture" = const ("Coût"),
                                                                                 "Type de cout" = const (Approche)));
            Caption = 'Frais d''approche';
            Description = 'Renta';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1054; "Frais d'emballage"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Ecriture rentabilite"."Montant total (DS)" where ("Code groupe" = field (Code),
                                                                                 "Type ecriture" = const ("Coût"),
                                                                                 "Type de cout" = const (Emballage)));
            Caption = 'Frais d''emballage';
            Description = 'Renta';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2000; "CA Total"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Ecriture rentabilite"."Montant total (DS)" where ("Type ecriture" = const (CA),
                                                                                 "Code groupe" = field (Code),
                                                                                 "Date comptabilisation" = field ("Filtre date")));
            Description = 'Renta';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2020; "CA Mobilie"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Ecriture rentabilite"."Montant total (DS)" where ("Code groupe" = field (Code),
                                                                                 "Type ecriture" = const (CA),
                                                                                 "Nature vente" = const (Mobilier),
                                                                                 "Date comptabilisation" = field ("Filtre date")));
            Caption = 'CA Mobilier';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2030; "CA Pose/Audit"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Ecriture rentabilite"."Montant total (DS)" where ("Type ecriture" = const (CA),
                                                                                 "Code groupe" = field (Code),
                                                                                 "Nature vente" = const ("Pose/Audit"),
                                                                                 "Date comptabilisation" = field ("Filtre date")));
            Caption = 'CA Pose/Audit';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2040; "CA Transport"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Ecriture rentabilite"."Montant total (DS)" where ("Type ecriture" = const (CA),
                                                                                 "Code groupe" = field (Code),
                                                                                 "Nature vente" = const (Transport),
                                                                                 "Date comptabilisation" = field ("Filtre date")));
            Caption = 'CA Transport';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2050; "CA Bennes/Fenwick"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Ecriture rentabilite"."Montant total (DS)" where ("Type ecriture" = const (CA),
                                                                                 "Code groupe" = field (Code),
                                                                                 "Nature vente" = const ("Bennes/Fenwick"),
                                                                                 "Date comptabilisation" = field ("Filtre date")));
            Caption = 'CA Bennes/Fenwick';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2060; "CA SAV"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Ecriture rentabilite"."Montant total (DS)" where ("Type ecriture" = const (CA),
                                                                                 "Code groupe" = field (Code),
                                                                                 "Nature vente" = const (SAV),
                                                                                 "Date comptabilisation" = field ("Filtre date")));
            Caption = 'CA SAV';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Enseigne.SetRange("Code groupe", Code);
        if Enseigne.FindFirst() then
            Error(GroupeAvecEnseigneErr);
    end;

    var
        Enseigne: Record Enseigne;
        GroupeAvecEnseigneErr: Label 'Vous ne pouvez pas supprimer un Groupe auquel des enseignes sont rattachées.';
}

