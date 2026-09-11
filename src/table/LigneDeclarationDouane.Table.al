table 50065 "Ligne declaration douane"
{
    Caption = 'Ligne declaration douane';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(10; "No. declaration"; Code[20])
        {
            Caption = 'No. declaration';
            TableRelation = "Declaration douane";
        }
        field(20; "No. ligne"; Integer)
        {
            Caption = 'N° ligne';
        }
        field(30; "No. article"; Code[20])
        {
            Caption = 'N° article';
            TableRelation = Item;
        }
        field(40; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(45; Quantite; Decimal)
        {
            Caption = 'Quantite';
        }
        field(50; "Valeur unitaire"; Decimal)
        {
            Caption = 'Valeur unitaire';
        }
        field(60; "Valeur ligne"; Decimal)
        {
            Caption = 'Valeur ligne';
        }
        field(65; "No. colisage"; Code[20])
        {
            Caption = 'N° colisage';
            TableRelation = "Entete colisage";
        }
        field(70; "Type UC"; Option)
        {
            Caption = 'Type UC';
            DataClassification = ToBeClassified;
            OptionMembers = " ",Palette,"Colis";
            OptionCaption = ' ,Palette,Colis';
        }
        
        field(80; "No. UC"; Code[10])
        {
            Caption = 'No. UC';
        }

    }
    keys
    {
        key(PK; "No. declaration")
        {
            Clustered = true;
        }
    }
}
