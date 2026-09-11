table 50069 "Tampon dispo cde cadre achat"
{
    //Lorsqu'on fait 'Créer commande achat" depuis un devis ou une commande de vente
    //on doit venir "consommer" les commandes cadres achats qui seraient dans le système.
    //Cette table est vidée puis remplie à ce moment-là avec les lignes de commandes cadres où toute la quantité n'a pas encore été commandée ou reçue.
    //Le programme vient alors "consommer" la quantité encore disponible sur la commande cadre.

    Caption = 'Tampon dispo cde cadre achat';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code utilisateur"; Code[50])
        {
            Caption = 'Code utilisateur';
        }
        field(3; "No. fournisseur"; Code[20])
        {
            Caption = 'N° fournisseur';
            TableRelation = Vendor;
        }
        
        field(10; "No. commande cadre"; Code[20])
        {
            Caption = 'No. commande cadre';
            TableRelation = "Purchase Header"."No." where ("Document Type"=const("Blanket Order"));
        }
        field(20; "No. ligne commande cadre"; Integer)
        {
            Caption = 'No. ligne commande cadre';
            TableRelation = "Purchase Line"."Line No." where ("Document Type"=const("Blanket Order"),"Document No."=field("No. commande cadre"));
        }
        field(30; "No. article"; Code[20])
        {
            Caption = 'No. article';
            TableRelation = Item;
        }
        
        field(80; "Qte commande cadre"; Decimal)
        {
            Caption = 'Qté commande cadre';
            BlankZero = true;
            DecimalPlaces = 0:2;
            DataClassification = ToBeClassified;
        }
        
        field(85; "Qte sur commande achat"; Decimal)
        {
            Caption = 'Qté sur cde achat';
            BlankZero = true;
            DecimalPlaces = 0:2;
            DataClassification = ToBeClassified;
        }
        
        field(90; "Quantite recue"; Decimal)
        {
            Caption = 'Quantité reçue';
            BlankZero = true;
            DecimalPlaces = 0:2;
            DataClassification = ToBeClassified;
        }
        
        field(100; "Quantite dispo"; Decimal)
        {
            Caption = 'Quantité dispo'; //Qté commande cadre - qté sur commande achat - qté recue
            BlankZero = true;
            DecimalPlaces = 0:2;
            DataClassification = ToBeClassified;
        }
        field(110; "Qte pour cette vente"; Decimal)
        {
            Caption = 'Qté pour cette vente'; //Qté qu'on va prendre sur la commande cadre
            BlankZero = true;
            DecimalPlaces = 0:2;
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Code utilisateur", "No. commande cadre","No. ligne commande cadre")
        {
            Clustered = true;
        }
    }
}
