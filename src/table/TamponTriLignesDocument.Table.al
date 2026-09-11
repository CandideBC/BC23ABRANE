table 50018 TamponTriLignesDocument
{
    Caption = 'TamponTriLignesDocument';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code utilisateur"; Code[50])
        {
            Caption = 'Code utilisateur';
        }
        field(2; "Type document"; Text[20])
        {
            Caption = 'Type document';
        }
        field(10; "No. document"; Code[20])
        {
            Caption = 'No. document';
        }

        field(15; "No. ligne"; Integer)
        {
            Caption = 'N° ligne';
        }

        field(20; "No. ligne document"; Integer)
        {
            Caption = 'No. ligne document';
        }
        field(30; "Achete pour phase (si unique)"; Integer)
        {
            Caption = 'Acheté pour phase (si unique)';
            DataClassification = ToBeClassified;
        }
        
        field(50; "Creer nouvelle commande"; Boolean)
        {
            Caption = 'Créer nouvelle commande';
        }
        field(55; "Ajouter a la cde No."; Code[20])
        {
            Caption = 'Ajouter à la cde N°';
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No." where("Document Type" = const(Order), "Buy-from Vendor No." = field("No. fournisseur"));
        }

        field(59; "No. commande achat creee"; Code[20]) //Champ utilisé par le programme lorsqu'on crée les commandes d'achats depuis une vente
        {
            Caption = 'N° commande achat créée';
            DataClassification = ToBeClassified;
        }
        field(60; "Qte a prendre hors cadre"; Decimal) //Champ utilisé par le programme lorsqu'on crée les commandes d'achats depuis une vente
        {
            Caption = 'Qté à prendre hors cadre';
            DataClassification = ToBeClassified;
        }

        field(100; "No. fournisseur"; Code[20])
        {
            Caption = 'N° fournisseur';
        }
        field(102; "Fournisseur divers"; Boolean)
        {
            Caption = 'Fournisseur divers';
            DataClassification = ToBeClassified;
        }
        field(103; "Code pays origine"; Code[10])
        {
            Caption = 'Code pays d''origine';
            DataClassification = ToBeClassified;
        }
        
        field(105; "Code magasin"; Code[20])
        {
            Caption = 'Code magasin';
        }

        field(109; Type; Enum "Sales Line Type")
        {
            Caption = 'Type';
        }
        field(110; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(115; "Code variante"; Code[10])
        {
            Caption = 'Code variante';
        }
        field(120; Quantite; Decimal)
        {
            Caption = 'Quantite';
        }
        field(130; "Prix achat prevu"; Decimal)
        {
            Caption = 'Prix achat prévu';
            DataClassification = ToBeClassified;
        }
        
        field(200; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(210; "Nomenclature produits"; Code[20])
        {
            Caption = 'Nomenclature produits';
        }
        field(220; "Poids net"; Decimal)
        {
            Caption = 'Poids net';
        }
        field(230; "Code chantier"; Code[20])
        {
            Caption = 'Code chantier';
        }
        field(240; "No. document vente"; Code[20])
        {
            Caption = 'No. document vente';
        }
        field(250; "No. ligne doc. vente"; Integer)
        {
            Caption = 'No. ligne doc. vente';
        }
        

    }
    keys
    {
        key(PK; "Code utilisateur", "Type document", "No. document", "No. ligne document")
        {
            Clustered = true;
        }
        key(MyKey1; "Code utilisateur", "No. fournisseur", Type, "No.")
        {

        }
        key(MyKey2; "Code utilisateur", "Creer nouvelle commande","Type Document", "No. fournisseur", Type, "No.", "Code Variante")
        {

        }
        key(MyKey3; "Code utilisateur","Creer nouvelle commande","Ajouter a la cde No.",Type,"No.","Code variante")
        {
            
        }

    }
}
