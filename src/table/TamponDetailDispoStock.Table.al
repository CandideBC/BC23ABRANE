table 50060 TamponDetailDispoStock
{
    DrillDownPageId = DetailDispoStock;
    Caption = 'Détail dispo stock';

    //Cette table est utilisé depuis un devis ou une commande de vente lorsqu'on demande à afficher le stock dispo
    //de chaque article pour y stocker la quantité qu'on va prendre en stock pour chaque commande vente du système.
    //Une quantité prise sur stock est :
    //  - une ligne de commande vente qui est cochée [Prise sur stock] : toute la quantité va être décomptée
    //  - une ligne de commande qui n'est pas cochée [Prise sur stock] mais pour laquelle on a des affectations achat.
    //    Dans ce cas, si la quantité de la commande est de 12 et qu'on a acheté 8, cela signifie qu'on prendra 4 sur stock.
    //Les lignes de commandes qui ne sont pas cochées [Prise sur stock] et sans affectation achats, ne sont pas prises en compte.

    //La table est vidée et remplie au moment où on demande le stock dispo d'un devis/une commande.

    fields
    {
        field(1; "Code utilisateur"; Code[50])
        {
            Caption = 'Code utilisateur';
        }
        field(2; "No. article"; Code[20])
        {
            Caption = 'N° article';
        }
        field(10; "No. document"; Code[20])
        {
            Caption = 'N° document';
        }
        field(12; Commentaires; Text[250])
        {
            Caption = 'Commentaires';
            DataClassification = ToBeClassified;
        }
        
        field(16; "No. ligne"; Integer)
        {
            Caption = 'N° ligne';
        }

        field(20; "Quantite vendue"; Decimal)
        {
            BlankZero = true;
            Caption = 'Quantité vendue';
            DecimalPlaces = 0 : 5;
        }
        field(25; "Quantite achetee"; Decimal)
        {
            BlankZero = true;
            Caption = 'Quantité achetée';
            DecimalPlaces = 0 : 5;
        }
        field(30; "Quantite prise sur stock"; Decimal)
        {
            BlankZero = true;
            Caption = 'Quantité prise sur stock';
            DecimalPlaces = 0 : 5;
        }
        field(40; "Quantite non sourcee"; Decimal)
        {
            BlankZero = true;
            Caption = 'Quantité non sourcée';
            DecimalPlaces = 0 : 5;
            Description = 'Indique qu''on ne sait pas si la quantité sera prise sur stock ou achetée.';
        }
        field(42; "Quantite reservee"; Decimal)
        {
            BlankZero = true;
            Caption = 'Quantité réservée';
            DecimalPlaces = 0 : 5;
            Description = 'Quantité prise sur stock par d''autres commandes.';
        }
        field(44; "Date chargement"; Date)
        {
            Caption = 'Date chargement';
        }
        field(45; "Date livraison demandee"; Date)
        {
            Caption = 'Date livraison demandée';
        }

        field(50; "Quantite sur devis"; Decimal)
        {
            BlankZero = true;
            Caption = 'Quantité sur devis';
            DecimalPlaces = 0 : 5;
            Description = 'Quantité sur devis où on ne sait pas encore si elle sera prise sur stock ou sur achats.';
        }
        
        field(60; "Code vendeur"; Code[20])
        {
            Caption = 'Code vendeur';
        }
        field(70; "Proba transformation"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Proba transformation';
            OptionMembers = " ","1","50","100";
            OptionCaption = ' ,1,50,100';
        }
    }
    
    keys
    {
        key(Key1; "Code utilisateur", "No. article", "No. document", "No. ligne")
        {
            Clustered = true;
            SumIndexFields = "Quantite achetee", "Quantite non sourcee", "Quantite vendue", "Quantite prise sur stock", "Quantite reservee", "Quantite sur devis";
        }
        key(MyKey2; "Code utilisateur", "No. article","Proba transformation")
        {
            SumIndexFields = "Quantite sur devis";
        }
    }

    fieldgroups
    {
    }


}