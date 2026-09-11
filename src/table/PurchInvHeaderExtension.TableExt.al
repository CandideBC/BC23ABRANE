tableextension 50017 PurchInvHeaderExtension extends "Purch. Inv. Header"
{
    fields
    {
        field(50008; "No. container"; Code[20])
        {
            Caption = 'N° container';
            DataClassification = ToBeClassified;
            TableRelation = Container;
        }
        field(50016; "Commande transitaire container"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50060; Comments; Text[250])
        {
            Caption = 'Commentaires';
            DataClassification = ToBeClassified;
        }
        field(50070; "Annee commande"; Integer)
        {
            Caption = 'Année commande';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 06/03/2023';

            trigger OnValidate()
            var
                AutresTriggersTableCodeunit : Codeunit AutresTriggersTable;
            begin
                AutresTriggersTableCodeunit.PurchInvoiceHeaderOnValidateAnneeCommande(Rec);

            end;
        }
        field(50190; "Code groupe"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = "Groupe client";

            trigger OnValidate()
            var
                AutresTriggersTableCodeunit : Codeunit AutresTriggersTable;
            begin
                AutresTriggersTableCodeunit.PurchInvoiceHeaderOnValidateCodeGroupe(Rec);
            end;
        }
        field(50200; "Code enseigne"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = Enseigne;

            trigger OnValidate()
            var
                AutresTriggersTableCodeunit : Codeunit AutresTriggersTable;
            begin
                AutresTriggersTableCodeunit.PurchInvoiceHeaderOnValidateCodeEnseigne(Rec);
            end;
        }
        field(50210; "Code operation"; Code[20])
        {
            Caption = 'Code opération';
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = Operations.Code where ("Code enseigne" = field ("Code enseigne"));

            trigger OnValidate()
            var
                AutresTriggersTableCodeunit : Codeunit AutresTriggersTable;
            begin
                AutresTriggersTableCodeunit.PurchInvoiceHeaderOnValidateCodeOperation(Rec);
            end;
        }
        field(50220; "Code chantier"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = if ("Code enseigne" = const ('')) Chantier.Code where ("Chantier archive" = const (false))
            else
            Chantier.Code where ("Code enseigne" = field ("Code enseigne"));

            trigger OnValidate()
            var
                AutresTriggersTableCodeunit : Codeunit AutresTriggersTable;
            begin
                AutresTriggersTableCodeunit.PurchInvoiceHeaderOnValidateCodeChantier(Rec);
            end;
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
        }
        field(50610; "SAV Type"; Option)
        {
            Caption = 'Type SAV';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,FOURNISSEUR,ABRANE';
            OptionMembers = " ",FOURNISSEUR,ABRANE;
        }
        field(50620; "Achat pour stock"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';

            trigger OnValidate()
            var
                AutresTriggersTableCodeunit : Codeunit AutresTriggersTable;
            begin
                AutresTriggersTableCodeunit.PurchInvoiceHeaderOnValidateAchatPourStock(Rec);
            end;
        }
        field(88860; "Concernee DEB"; Boolean)
        {
            Caption = 'Concernée DEB';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 16/02/2023';
        }
        field(88870; "Periode validation DEB"; Date)
        {
            Caption = 'Période validation DEB';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 16/02/2023 Permet de savoir à quelle période comptable la facture a été déclarée. Si vide, cela veut dire qu''il faudra l''extraire sur la prochaine déclaration.';
        }
        field(88888; "Code chantier archive"; Code[20])
        {
            Caption = 'Code chantier archivé';
            DataClassification = ToBeClassified;
            Description = 'KAN. Quand renseigné, le chantier n''est pas pris en compte dans le tableau d''affaires "Enseigne" car les chiffres sont faux (vieux chantiers d''avant 2020)';
            TableRelation = Chantier;
        }
        field(88889; "Code groupe  archive"; Code[20])
        {
            Caption = 'Code groupe archivé';
            DataClassification = ToBeClassified;
            Description = 'KAN';
        }
        field(88890; "Code enseigne  archive"; Code[20])
        {
            Caption = 'Code enseigne archivé';
            DataClassification = ToBeClassified;
            Description = 'KAN';
        }
        field(88891; "Code operation archive"; Code[20])
        {
            Caption = 'Code opération archivé';
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = Operations.Code where ("Code enseigne" = field ("Code enseigne"));
        }
    }

    keys
    {
        key(MyKey1; "Code groupe", "Code enseigne", "Code chantier", "Achat pour stock")
        {
            
        }
        key(MyKey2; "Code chantier")
        {
            
        }
        key(MyKey3; "Commande transitaire container","No. container")
        {
            
        }
        key(MyKey4; "Concernee DEB","Periode validation DEB")
        {
            
        }
    }

    /*
    Migration : j'ai adapté le standard qui inclut maintenant une fonctionnalité de mise à jour de la facture
    procedure EditAddress()
    var
        EditAddressRecord: Record "Edit Purchase Invoice";
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(UserId) then
            UserSetup.Init();

        UserSetup.TestField("Modifier adresse sur factures");

        EditAddressRecord.DeleteAll();
        EditAddressRecord.Init();
        EditAddressRecord.TransferFields(Rec);
        EditAddressRecord."Posted Purchase Invoice No." := "No.";
        EditAddressRecord.Insert();
        PAGE.Run(PAGE::EditPostedPurchInvAddress, EditAddressRecord);
    end;
    */
}

