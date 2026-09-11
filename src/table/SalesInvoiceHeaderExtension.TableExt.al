tableextension 50004 SalesInvoiceHeaderExtension extends "Sales Invoice Header"
{
    fields
    {
        field(50020; "Surface m2"; Decimal)
        {
            Caption = 'Surface (m2)';
            DataClassification = ToBeClassified;
            Description = 'C11.01';
        }
        field(50030; "Eco Tax Furniture Liable"; Boolean)
        {
            Caption = 'Soumis taxe éco mobilier';
            DataClassification = ToBeClassified;
            Description = 'CPT02';
            InitValue = true;
        }
        field(50035; "Price included Eco Tax"; Boolean)
        {
            Caption = 'Prix écotaxe compris';
            DataClassification = ToBeClassified;
            Description = 'CPT02';
        }
        field(50040; "No. And Location Name"; Text[50])
        {
            Caption = 'N° et nom magasin';
            DataClassification = ToBeClassified;
            Description = 'X01';
        }
        field(50050; "Range No."; Text[30])
        {
            Caption = 'N° de rayon';
            DataClassification = ToBeClassified;
            Description = 'X01';
        }
        field(50060; Commentaire; Text[250])
        {
            Caption = 'Commentaires';
            DataClassification = ToBeClassified;
            Description = 'X01';
        }
        field(50070; Prepayment; Decimal)
        {
            Caption = 'Acompte versé';
            DataClassification = ToBeClassified;
            Description = 'X01';
        }
        field(50072; "Prepayment deducted"; Decimal)
        {
            Caption = 'Acompte à déduire (HT)';
            DataClassification = ToBeClassified;
        }
        field(50080; Factoring; Boolean)
        {
            Caption = 'Affacturage';
            DataClassification = ToBeClassified;
            Description = 'X01';
        }
        field(50090; "Number Of Packages"; Decimal)
        {
            Caption = 'Nombre de colis';
            DataClassification = ToBeClassified;
            Description = 'X01';
        }
        field(50091; "Pallet Number"; Decimal)
        {
            Caption = 'Nombre de palettes';
            DataClassification = ToBeClassified;
            Description = 'X01';
        }
        field(50100; ASS; Boolean)
        {
            Caption = 'SAV';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 13/10/2020';
        }
        field(50120; "Amount included Ecotax"; Decimal)
        {
            BlankZero = true;
            Caption = 'Montant écotaxe inclus';
            DataClassification = ToBeClassified;
            Description = 'CPTO2';
            Editable = false;
        }
        field(50130; "Total Net Weight"; Decimal)
        {
            Caption = 'Poids net total';
            DataClassification = ToBeClassified;
        }
        field(50140; "Total Gross Weight"; Decimal)
        {
            Caption = 'Poids brut total';
            DataClassification = ToBeClassified;
        }
        field(50170; "Return Reason Code"; Code[10])
        {
            Caption = 'Code motif SAV';
            DataClassification = ToBeClassified;
            TableRelation = "Return Reason";
        }
        field(50180; "Annee commande"; Integer)
        {
            Caption = 'Année commande';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 06/03/2023';

            trigger OnValidate()
            var
                AutresTriggersTablesCodeunit : Codeunit AutresTriggersTable;
            begin
                AutresTriggersTablesCodeunit.SalesInvoiceHeaderOnAfterValidateAnneeCommande(Rec,xRec);
            end;
        }
        field(50190; "Code groupe"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = "Groupe client";

            trigger OnValidate()
            var
                AutresTriggersTablesCodeunit : Codeunit AutresTriggersTable;
            begin
                AutresTriggersTablesCodeunit.SalesInvoiceHeaderOnAfterValidateCodeGroupe(Rec,xRec);
            end;
        }
        field(50200; "Code enseigne"; Code[20])
        {
            Caption = 'Code enseigne';
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = if ("Code groupe" = filter (<> '')) Enseigne.Code where ("Code groupe" = field ("Code groupe"))
            else
            Enseigne.Code;

            trigger OnValidate()
            var
                AutresTriggersTablesCodeunit : Codeunit AutresTriggersTable;
            begin
                AutresTriggersTablesCodeunit.SalesInvoiceHeaderOnAfterValidateCodeEnseigne(Rec,xRec);
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
                AutresTriggersTablesCodeunit : Codeunit AutresTriggersTable;
            begin
                AutresTriggersTablesCodeunit.SalesInvoiceHeaderOnAfterValidateCodeOperation(rec,xRec);
            end;
        }
        field(50220; "Code chantier"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = if ("Code enseigne" = const ('')) Chantier.Code where ("Chantier archive" = const (false))
            else
            if ("Code enseigne" = filter (<> '')) Chantier.Code where ("Chantier archive" = const (false),
                                                                                        "Code enseigne" = field ("Code enseigne"));

            trigger OnValidate()
            var
                AutresTriggersTablesCodeunit : Codeunit AutresTriggersTable;
                
            begin
                AutresTriggersTablesCodeunit.SalesInvoiceHeaderOnAfterValidateCodeChantier(rec,xRec);
            end;
        }
        field(50240; "Facture acompte"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
        }
        field(50250; "Acompte pour type doc."; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            OptionMembers = Devis,Commande;
        }
        field(50260; "Acompte pour No. document"; Code[20])
        {
            Caption = 'Acompte pour N° document';
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = if ("Acompte pour type doc." = const (Devis)) "Sales Header"."No." where ("Document Type" = const (Quote),
                                                                                                   "Bill-to Customer No." = field ("Bill-to Customer No."))
            else
            if ("Acompte pour type doc." = const (Commande)) "Sales Header"."No." where ("Document Type" = const (Order),
                                                                                                                                                                                  "Bill-to Customer No." = field ("Bill-to Customer No."));
        }
        field(50262; "Fact. situation : type doc."; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
            OptionMembers = Devis,Commande;
        }
        field(50263; "Fact. situation : No. document"; Code[20])
        {
            Caption = 'Fact. situation : No. document';
            DataClassification = ToBeClassified;
            Description = 'KAN';
            TableRelation = if ("Acompte pour type doc." = const (Devis)) "Sales Header"."No." where ("Document Type" = const (Quote),
                                                                                                   "Bill-to Customer No." = field ("Bill-to Customer No."))
            else
            if ("Acompte pour type doc." = const (Commande)) "Sales Header"."No." where ("Document Type" = const (Order),
                                                                                                                                                                                  "Bill-to Customer No." = field ("Bill-to Customer No."));
        }
        field(50300; "Montant deja verse TTC"; Decimal)
        {
            Caption = 'Montant déjà versé TTC';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 02/06/2021';

            trigger OnValidate()
            var
                AutresTriggersTablesCodeunit : Codeunit AutresTriggersTable;
            begin
                AutresTriggersTablesCodeunit.SalesInvoiceHeaderOnAfterValidateMontantDejaVerseTTC(Rec,xRec); 
            end;
        }
        
        field(50310;"Commentaire factu.";Text[50])
        {
            Caption = 'Commentaire factu.';
            DataClassification = ToBeClassified;
        }

        field(50550; "Factor Code"; Code[10])
        {
            Caption = 'Code banque';
            DataClassification = ToBeClassified;
            Description = 'Facto';
            TableRelation = Factor."Factor Code";
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
        field(88900; "Controle affaire OK"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN. Indique que les champs "Affaire" (Groupe, Enseigne, Chantier) ont été vérifés et sont cohérents.';
        }
        field(88910; "DEB : que des 999999"; Boolean)
        {
            CalcFormula = - exist ("Ligne DEB" where ("Type ligne DEB" = const ("Expédition"),
                                                    "Type document" = const (Facture),
                                                    "No. document" = field ("No."),
                                                    "Code douanier fictif" = const (false)));
            Description = 'Lorsque la facture est extraite pour la DEB, on a besoin de savoir si elle ne porte que des articles de code douanier 999999 ou non. Quand ce n''est pas le cas, les montants des lignes 999999 sont saupoudrés sur les lignes d''articles non 999999. Sinon, elles sont conservées.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(88920; "DEB : montant 999999"; Decimal)
        {
            CalcFormula = sum ("Ligne DEB"."Montants autres (ligne)" where ("Type ligne DEB" = const ("Expédition"),
                                                                           "Type document" = const (Facture),
                                                                           "No. document" = field ("No."),
                                                                           "Code douanier fictif" = const (true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(88925; "Totaux calcules"; Boolean)
        {
            Caption = 'Totaux calculés';
            DataClassification = ToBeClassified;
        }
        
    }
    keys
    {
        key(MyKey1; "Code chantier")
        {
        
        }
        key(MyKey2; "Code enseigne")
        {
            
        } 
        key(MyKey3; "Bill-to Country/Region Code")
        {
            
        }  
        key(MyKey4; "Code enseigne","Code chantier")
        {
            
        }
        key(MyKey5; "Concernee DEB", "Periode validation DEB")
        {
            
        }

    }
    
    /*
    Migration : j'ai adapté le standard qui inclut maintenant une fonctionnalité de mise à jour de la facture
    procedure EditAddress()
    var
        EditAddressRecord: Record "Edit Sales Invoice";
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(UserId) then
            UserSetup.Init();

        UserSetup.TestField("Modifier adresse sur factures");

        EditAddressRecord.DeleteAll();
        EditAddressRecord.Init();
        EditAddressRecord.TransferFields(Rec);
        EditAddressRecord."Posted Sales Invoice No." := "No.";
        EditAddressRecord.Insert();
        PAGE.Run(PAGE::EditPostedSalesInvAddress, EditAddressRecord);
    end;
    */
    procedure MontantAcompte(): Decimal
    var
        decMontant: Decimal;
    begin
        //Fonction utilisée dans le module DEB pour exclure le montant de l'acompte du montant total de la facture
        //lorsqu'on calcule le ratio de chaque ligne par rapport au montant total de la facture
        decMontant := 0;
        LigneFactVente.SetRange("Document No.", "No.");
        LigneFactVente.SetRange(Type, LigneFactVente.Type::"G/L Account");
        LigneFactVente.SetFilter("No.", '419*');
        if LigneFactVente.FindSet(false) then
            repeat
                decMontant := decMontant + LigneFactVente.Amount;
            until LigneFactVente.Next() = 0;

        exit(decMontant);
    end;

    var
        LigneFactVente: Record "Sales Invoice Line";
        

    
 
}

