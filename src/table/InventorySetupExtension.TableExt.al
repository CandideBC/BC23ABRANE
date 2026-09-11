tableextension 50046 InventorySetupExtension extends "Inventory Setup"
{
    fields
    {
        field(50020; "Mod. feuil. art. remise stk BL"; Code[10])
        {
            Caption = 'Mod. feuil. art. remise stk BL';
            DataClassification = ToBeClassified;
            Description = 'Utilisé au moins dans DV0035 (Remise en stock d''un BL)';
            TableRelation = "Item Journal Template".Name where (Type = const (Item));
        }
        field(50030; "Nom feuil. art. remise stk BL"; Code[10])
        {
            Caption = 'Nom feuil. art. remise stk BL';
            DataClassification = ToBeClassified;
            Description = 'FHA : plus utilisé je pense';
            TableRelation = "Item Journal Batch".Name where ("Journal Template Name" = field ("Mod. feuil. art. remise stk BL"));
        }
        field(50040; "Mod. feuil. recl. transf. rcpt"; Code[10])
        {
            Caption = 'Mod. feuil. recl. transf. rcpt';
            DataClassification = ToBeClassified;
            Description = 'DV0035 : modèle de feuille de reclassement utilisé par le programme de transfert d''un bon de réception vers un nouveau magasin.';
            TableRelation = "Item Journal Template".Name where (Type = const (Transfer));
        }
        field(50100; "Article : unite mesure/defaut"; Code[10])
        {
            Caption = 'Article : unité mesure/défaut';
            DataClassification = ToBeClassified;
            Description = 'FL0031';
            TableRelation = "Unit of Measure";
        }
        field(50130; "Dernier calcul stock"; Date)
        {
            Caption = 'Dernier calcul stock';
            Description = 'Le report 50061 est censé tourner une fois par mois (Codeunit50011 l''exécute). Ce champ sert à savoir quand il a tourné pour la dern fois. Si avant le mois dernier, on doit relancer...';
            DataClassification = ToBeClassified;
        }
        
        /*
        field(50120; "Article : code period inv./def"; Code[10])
        {
            Caption = 'Article : code période inv./défaut';
            DataClassification = ToBeClassified;
            Description = 'FL0031';
            TableRelation = "Phys. Invt. Counting Period";
        }
        */

        field(56050; "Groupe compta produit defaut"; Code[20])
        {
            Caption = 'Groupe compta produit par défaut';
            TableRelation= "Gen. Product Posting Group";
            DataClassification = ToBeClassified;
        }
        field(56060; "Gpe compta produit TVA defaut"; Code[20])
        {
            Caption = 'Groupe compta produit TVA par défaut';
            TableRelation= "VAT Product Posting Group";
            DataClassification = ToBeClassified;
        }
        field(56070; "Groupe compta stock defaut"; Code[20])
        {
            Caption = 'Groupe compta stock par défaut';
            TableRelation= "Inventory Posting Group";
            DataClassification = ToBeClassified;
        }
        field(56100; "No. article divers BE"; Code[20])
        {
            Caption = 'N° article divers BE';
            TableRelation= "No. Series";
            DataClassification = ToBeClassified;
        }
    }
}

