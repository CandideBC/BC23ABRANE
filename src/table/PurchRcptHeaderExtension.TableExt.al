tableextension 50015 PurchRcptHeaderExtension extends "Purch. Rcpt. Header"
{
    fields
    {
        field(50008; "No. container"; Code[20])
        {
            Caption = 'N° container';
            DataClassification = ToBeClassified;
            Description = 'Utilisé uniquement au moment de la réception pour récupérer sur le bon de réception le N° de container. Au final, une commande aura vu passer plusieurs valeurs dans ce champ si elle se trouvait dans plusieurs containers.';
            TableRelation = Container;
        }
        field(50010; "Commentaire AIE"; Text[80])
        {
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA Gestion des containers. AIE = Assistant(e) Import/Export';
        }
        field(50060; Comments; Text[250])
        {
            Caption = 'Commentaires';
            DataClassification = ToBeClassified;
            Description = 'X01';
        }
        field(50190; "Code groupe"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = "Groupe client";
        }
        field(50200; "Code enseigne"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = Enseigne;
        }
        field(50210; "Code operation"; Code[20])
        {
            Caption = 'Code opération';
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = Operations.Code where ("Code enseigne" = field ("Code enseigne"));
        }
        field(50220; "Code chantier"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = Chantier;
        }
        field(50500; ShortCutDim3; Code[20])
        {
            CalcFormula = lookup ("Dimension Set Entry"."Dimension Value Code" where ("Dimension Set ID" = field ("Dimension Set ID"),
                                                                                     "Dimension Code" = const ('CHANTIER')));
            CaptionClass = '1,2,3';
            FieldClass = FlowField;
        }
        field(50510; ShortCutDim4; Code[20])
        {
            CalcFormula = lookup ("Dimension Set Entry"."Dimension Value Code" where ("Dimension Set ID" = field ("Dimension Set ID"),
                                                                                     "Dimension Code" = const ('GROUPE')));
            CaptionClass = '1,2,4';
            FieldClass = FlowField;
        }
        field(50520; ShortCutDim5; Code[20])
        {
            CalcFormula = lookup ("Dimension Set Entry"."Dimension Value Code" where ("Dimension Set ID" = field ("Dimension Set ID"),
                                                                                     "Dimension Code" = const ('ENSEIGNE')));
            CaptionClass = '1,2,5';
            FieldClass = FlowField;
        }
        field(50600; "Available date"; Date)
        {
            Caption = 'Date dispo marchandise';
            DataClassification = ToBeClassified;
            Description = 'AB1807';
        }
        field(50610; "SAV Type"; Option)
        {
            Caption = 'Type SAV';
            DataClassification = ToBeClassified;
            Description = 'AB1807';
            OptionCaption = ' ,FOURNISSEUR,ABRANE';
            OptionMembers = " ",FOURNISSEUR,ABRANE;
        }
        field(76880; "No. facture fournisseur"; Code[35])
        {
            Caption = 'N° facture fournisseur';
            DataClassification = ToBeClassified;
        }
        field(76888; "Code magasin transfert"; Code[10])
        {
            Caption = 'Code magasin transfert';
            DataClassification = ToBeClassified;
            Description = 'DV0035';
            TableRelation = Location where ("Use As In-Transit" = const (false),
                                            "Magasin bloque" = const (false));
        }
        field(76889; "Date transfert"; Date)
        {
            Caption = 'Date transfert';
            DataClassification = ToBeClassified;
            Description = 'DV0035';
        }
        field(76890; "Annee commande"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Année commande';
        }
        field(76954; "Vu controle SAV / Avoir"; Boolean)
        {
            Caption = 'Vu contrôle SAV / Avoir';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 24/03/2022 Pour faire le suivi de quels SAV Fournisseur ont été traités ou non.';
        }
        field(76955; "Commande en container"; Boolean)
        {
            CalcFormula = exist ("Ligne container" where ("No. commande achat" = field ("Order No.")));
            Description = 'KAN.FHA 24/03/2022 Pour faire le suivi de quels SAV Fournisseur ont été traités ou non.';
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
     {   
        key(MyKey1; "No. container")
        {
        
        }
        key(MyKey2; "SAV Type","Vu controle SAV / Avoir")
        {
            
        }
     }
    procedure Transferer()
    var
        PurchRcptLineEditCodeunit: Codeunit "Purch. Rcpt. Line - Edit";
    begin
        PurchRcptLineEditCodeunit.Transferer(Rec);
    end;

    procedure CalcTotalHT(var pTotalHT: Decimal; var pMontantRemise: Decimal)
    var
        LigneRecep: Record "Purch. Rcpt. Line";
    begin
        //Fonction qui est utilisee sur le "Extraire reception achat" pour faciliter le controle
        pTotalHT := 0;
        pMontantRemise := 0;
        LigneRecep.SetRange("Document No.", "No.");
        if LigneRecep.FindSet(false) then
            repeat
                pTotalHT := pTotalHT + LigneRecep.Quantity * LigneRecep."Direct Unit Cost";
                pMontantRemise := pMontantRemise + LigneRecep.Quantity * (LigneRecep."Direct Unit Cost" - LigneRecep."Unit Cost");
            until LigneRecep.Next() = 0;
    end;



}

