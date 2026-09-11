table 50054 TamponPlanningBE
{
    Caption = 'TamponPlanningBE';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No. ligne"; Integer)
        {
            Caption = 'N° ligne';
        }
        field(10; "No. semaine"; Code[10])
        {
            Caption = 'N° semaine';
        }
        field(100; "Code dessinateur 1"; Code[20])
        {
            Caption = 'Code dessinateur';
        }
        field(110; "No. document D1"; Code[20])
        {
            Caption = 'N° doc';
        }
        field(120; "Nom chantier D1"; Text[250])
        {
            Caption = 'Nom chantier';
        }
        field(130; "Description de la demande D1"; Text[100])
        {
            Caption = 'Description de la demande';
        }
        field(140; "PJ D1 ?"; Text[3])
        {
            Caption = 'PJ ?';
            DataClassification = ToBeClassified;
        }
        field(150; "DLC D1"; Text[10])
        {
            Caption = 'DLC';
            DataClassification = ToBeClassified;
        }
        field(160; "Statut ligne D1"; Text[20])
        {
            Caption = 'Statut ligne';
            DataClassification = ToBeClassified;
        }
        field(200; "Code dessinateur 2"; Code[20])
        {
            Caption = 'Code dessinateur';
        }
        field(210; "No. document D2"; Code[20])
        {
            Caption = 'N° doc';
        }
        field(220; "Nom chantier D2"; Text[250])
        {
            Caption = 'Nom chantier';
        }
        field(230; "Description de la demande D2"; Text[100])
        {
            Caption = 'Description de la demande';
        }
        field(240; "PJ D2 ?"; Text[3])
        {
            Caption = 'PJ ?';
            DataClassification = ToBeClassified;
        }
        field(250; "DLC D2"; Text[10])
        {
            Caption = 'DLC';
            DataClassification = ToBeClassified;
        }
        field(260; "Statut ligne D2"; Text[20])
        {
            Caption = 'Statut ligne';
            DataClassification = ToBeClassified;
        }
        field(300; "Code dessinateur 3"; Code[20])
        {
            Caption = 'Code dessinateur';
        }
        field(310; "No. document D3"; Code[20])
        {
            Caption = 'N° doc';
        }
        field(320; "Nom chantier D3"; Text[250])
        {
            Caption = 'Nom chantier';
        }
        field(330; "Description de la demande D3"; Text[100])
        {
            Caption = 'Description de la demande';
        }
        field(340; "PJ D3 ?"; Text[3])
        {
            Caption = 'PJ ?';
            DataClassification = ToBeClassified;
        }
        field(350; "DLC D3"; Text[10])
        {
            Caption = 'DLC';
            DataClassification = ToBeClassified;
        }
        field(360; "Statut ligne D3"; Text[20])
        {
            Caption = 'Statut ligne';
            DataClassification = ToBeClassified;
        }

        field(400; "Code dessinateur 4"; Code[20])
        {
            Caption = 'Code dessinateur';
        }
        field(410; "No. document D4"; Code[20])
        {
            Caption = 'N° doc';
        }
        field(420; "Nom chantier D4"; Text[250])
        {
            Caption = 'Nom chantier';
        }
        field(430; "Description de la demande D4"; Text[100])
        {
            Caption = 'Description de la demande';
        }
        field(440; "PJ D4 ?"; Text[3])
        {
            Caption = 'PJ ?';
            DataClassification = ToBeClassified;
        }
        field(450; "DLC D4"; Text[10])
        {
            Caption = 'DLC';
            DataClassification = ToBeClassified;
        }
        field(460; "Statut ligne D4"; Text[20])
        {
            Caption = 'Statut ligne';
            DataClassification = ToBeClassified;
        }

        field(500; "Code dessinateur 5"; Code[20])
        {
            Caption = 'Code dessinateur';
        }
        field(510; "No. document D5"; Code[20])
        {
            Caption = 'N° doc';    
        }
        field(520; "Nom chantier D5"; Text[250])
        {
            Caption = 'Nom chantier';
        }
        field(530; "Description de la demande D5"; Text[100])
        {
            Caption = 'Description de la demande';
        }
        field(540; "PJ D5 ?"; Text[3])
        {
            Caption = 'PJ ?';
            DataClassification = ToBeClassified;
        }
        field(550; "DLC D5"; Text[10])
        {
            Caption = 'DLC';
            DataClassification = ToBeClassified;
        }
        field(560; "Statut ligne D5"; Text[20])
        {
            Caption = 'Statut ligne';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No. ligne")
        {
            Clustered = true;
        }
        key(MyKey1; "No. semaine","Code dessinateur 1")
        {
            
        }
        key(MyKey2; "No. semaine","Code dessinateur 2")
        {
            
        }
        key(MyKey3; "No. semaine","Code dessinateur 3")
        {
            
        }
        key(MyKey4; "No. semaine","Code dessinateur 4")
        {
            
        }
        key(MyKey5; "No. semaine","Code dessinateur 5")
        {
            
        }
        key(MyKey6; "No. semaine")
        {
            
        }
    }
}
