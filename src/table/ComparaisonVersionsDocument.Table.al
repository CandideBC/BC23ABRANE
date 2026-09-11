table 50047 ComparaisonVersionsDocument
{
    Caption = 'Comparaison versions document';
    DataClassification = ToBeClassified;
    Description = 'Table permettant de comparer les versions d''un même document d''achat ou de vente.';
    fields
    {
        field(1; "Type document"; Enum "Purchase Document Type")
        {
            Caption = 'Type document';
            DataClassification = ToBeClassified;
        }
        
        field(10; "No. document"; Code[20])
        {
            Caption = 'N° document';
            TableRelation = if ("Type document" = const(Order)) "Purchase Header"."No." where ("Document Type" = const(Order))
                            else if ("Type document" = const("Blanket Order")) "Purchase Header"."No." where ("Document Type" = const("Blanket Order"));
        }
        field(20; "No. article"; Code[20])
        {
            Caption = 'No. article';
            TableRelation = Item;
        }
        field(30; "Ligne modifiee"; Boolean)
        {
            Caption = 'Ligne modifiée';
        }
        field(35; "Code utilisateur"; Code[50])
        {
            Caption = 'Code utilisateur';
            DataClassification = ToBeClassified;
            //Permet de supprimer les comparaisons de l'utilisateur à chaque nouvelle comparaison
        }
        field(40; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(50; "Quantite version A"; Decimal)
        {
            Caption = 'Quantité version A';
            BlankZero = true;
            DecimalPlaces = 0:5;
        }
        field(60; "Quantite version B"; Decimal)
        {
            Caption = 'Quantité version B';
            BlankZero = true;
            DecimalPlaces = 0:5;
        }
        field(65; "Quantite ecart (B-A)"; Decimal)
        {
            Caption = 'Quantité écart (B-A)';
            BlankZero = true;
            DecimalPlaces = 0:5;
        }
        field(70; "No. version A"; Integer)
        {
            Caption = 'No. version A';
        }
        field(80; "No. version B"; Integer)
        {
            Caption = 'No. version B';
        }
    }
    keys
    {
        key(PK; "Type document","No. document","No. article")
        {
            Clustered = true;
        }
        key(MyKey1; "Type document","No. document","Ligne modifiee")
        {
            
        }
        key(MyKey2; "Code utilisateur","Ligne modifiee")
        {
            
        }
    }
}
