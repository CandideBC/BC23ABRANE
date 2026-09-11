tableextension 50003 SalesReceivablesSetupExtension extends "Sales & Receivables Setup"
{
    fields
    {
        field(50000; "Notice Factor FR"; Text[250])
        {
            Caption = 'Notice Factor FR';
            DataClassification = ToBeClassified;
            Description = 'X01';
        }
        field(50010; "Notice Factor FR 2"; Text[250])
        {
            Caption = 'Notice Factor FR 2';
            DataClassification = ToBeClassified;
            Description = 'X01';
        }
        field(50020; "Notice Factor FR 3"; Text[250])
        {
            Caption = 'Texte Affacturage France suite 2';
            DataClassification = ToBeClassified;
            Description = 'X01';
        }
        field(50030; "ASS Order Nos."; Code[20])
        {
            Caption = 'N° commande SAV';
            DataClassification = ToBeClassified;
            Description = 'X01';
            TableRelation = "No. Series";
        }
        field(50040; "ASS Invoice Nos."; Code[20])
        {
            Caption = 'N° facture SAV';
            DataClassification = ToBeClassified;
            Description = 'X01';
            TableRelation = "No. Series";
        }
        field(50050; "ASS Posted Invoice Nos."; Code[20])
        {
            Caption = 'N° facture enregistrée SAV';
            DataClassification = ToBeClassified;
            Description = 'X01';
            TableRelation = "No. Series";
        }
        field(50060; "ASS Credit Memo Nos."; Code[20])
        {
            Caption = 'N° avoir SAV';
            DataClassification = ToBeClassified;
            Description = 'X01';
            TableRelation = "No. Series";
        }
        field(50070; "ASS Posted Credit Memo Nos."; Code[20])
        {
            Caption = 'N° avoir enregistré SAV';
            DataClassification = ToBeClassified;
            Description = 'X01';
            TableRelation = "No. Series";
        }
        field(50080; "No. colisage"; Code[20])
        {
            Caption = 'N° colisage';
            DataClassification = ToBeClassified;
            Description = 'ABRA.COL';
            TableRelation = "No. Series";
        }
        field(50090; "No. UC"; Code[20])
        {
            Caption = 'N° UC';
            DataClassification = ToBeClassified;
            Description = 'ABRA.COL';
            TableRelation = "No. Series";
        }
        field(50092; "No. fiche BE"; Code[20])
        {
            Caption = 'N° fiche BE';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50100; "% taxe Codifab"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50110; "Code cond. relance par def."; Code[10])
        {
            Caption = 'Code cond. relance par déf.';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 08/02/2021. Valeur par défaut quand on crée un client.';
            TableRelation = "Reminder Terms";
        }
        field(50120; "Code cond. interets par def."; Code[10])
        {
            Caption = 'Code cond. intérêts par déf.';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 08/02/2021. Valeur par défaut quand on crée un client.';
            TableRelation = "Finance Charge Terms";
        }
        field(50130; "Code mode reglement par def."; Code[10])
        {
            Caption = 'Code mode règlement par déf.';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 08/02/2021. Valeur par défaut quand on crée un client.';
            TableRelation = "Payment Method";
        }
        field(50140; "Nature transaction vente"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 24/08/2022 Valeur par défaut quand on crée un document de vente';
            TableRelation = "Transaction Type";
        }
        field(50150; "Regime vente"; Code[10])
        {
            Caption = 'Régime vente';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 24/08/2022 Valeur par défaut quand on crée un document de vente';
            TableRelation = "Transaction Specification";
        }
        field(50160; "Departement destination"; Code[10])
        {
            Caption = 'Département destination';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 24/08/2022 Valeur par défaut quand on crée un document de vente';
            TableRelation = Area;
        }
        field(50170; "Nom fichier CGV"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 05/12/2022';
        }
        field(50180; "Racine dossier affaires"; Text[250])
        {
            Caption = 'Racine dossier affaires';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 04/01/2023. On génère des PDF dans un dossier lié au chantier. Ici on ne saisit que la racine du chemin et la suite du chemin est saisie sur chaque chantier. Ici, on saisit par exemple \\Srvdom\abrane\ alors que sur un chantier on saisira  00- CLIENTS\AMPLIFON\2023\26 - CARRY LE ROUET\02 - ADMINISTRATIF\00 - DEVIS & CMDES VENTES\';

            trigger OnValidate()
            begin
                if "Racine dossier affaires" <> '' then
                    if CopyStr("Racine dossier affaires", StrLen("Racine dossier affaires"), 1) <> '\' then
                        "Racine dossier affaires" := CopyStr("Racine dossier affaires" + '\',1,250);
            end;
        }
        field(50190; "Delai creation fact. situ"; DateFormula)
        {
            Caption = 'Délai création fact. situ';
            Description = 'Délai entre la date de chargement et la date à laquelle une facture de situation devra être créée.';
            DataClassification = ToBeClassified;
        }
        field(50200; "Date dern. verif situ."; Date)
        {
            Caption = 'Date dern. vérif situ.';
            Description = 'Une fois par jour le systeme verifie si des factures de situation doivent etre creees.';
            DataClassification = ToBeClassified;
            
        }
        
        
    }

}

