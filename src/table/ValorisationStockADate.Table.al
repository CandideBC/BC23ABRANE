table 50033 "Valorisation stock à date"
{

    fields
    {
        field(10; "No. article"; Code[20])
        {
            Caption = 'N° article';
            TableRelation = Item;
        }
        field(12; Designation; Text[50])
        {
            Caption = 'Désignation';
        }
        field(15; "Ref client"; Code[20])
        {
            TableRelation = "Reference client";
        }
        field(20; "Code magasin"; Code[10])
        {
            Caption = 'Code magasin';
        }
        field(22; "Date dernier mouvement"; Date)
        {
            Caption = 'Date dernier mouvement';
        }
        field(23; "Date dernier achat"; Date)
        {
            Caption = 'Date dernier achat';
        }
        field(25; "Stock au (Date)"; Date)
        {
            Caption = 'Stock au (Date)';
        }
        field(26; "Annee N"; Integer)
        {
            Caption = 'Année N';
        }
        field(30; "Quantite en stock magasin"; Decimal)
        {
            Caption = 'Quantite en stock magasin';
            DecimalPlaces = 0 : 5;
        }
        field(32; "Quantite stock tous magasins"; Decimal)
        {
            CalcFormula = sum ("Valorisation stock à date"."Quantite en stock magasin" where ("No. article" = field ("No. article")));
            Caption = 'Quantite stock tous magasins';
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
        }
        field(40; "Cout unitaire NAV"; Decimal)
        {
            Caption = 'Coût unitaire NAV';
        }
        field(50; "Valeur au cout unitaire NAV"; Decimal)
        {
            Caption = 'Valeur au coût unitaire NAV';
        }
        field(60; "Dernier prix achat"; Decimal)
        {
            Caption = 'Dernier prix achat';
        }
        field(61; "Date dernier prix achat"; Date)
        {
            Caption = 'Date dernier prix achat';
        }
        field(62; "Dernier prix achat N"; Decimal)
        {
            Caption = 'Dernier prix achat N';
        }
        field(63; "Date dernier prix achat N"; Date)
        {
            Caption = 'Date dernier prix achat N';
        }
        field(64; "Dernier prix achat N-1"; Decimal)
        {
            Caption = 'Dernier prix achat N-1';
        }
        field(65; "Date dernier prix achat N-1"; Date)
        {
            Caption = 'Date dernier prix achat N-1';
        }
        field(66; "Origine dernier achat N"; Code[10])
        {
            Caption = 'Origine dernier achat N';
        }
        field(67; "Origine dernier achat N-1"; Code[10])
        {
            Caption = 'Origine dernier achat N-1';
        }
        field(70; "Valeur au DPA"; Decimal)
        {
            Caption = 'Valeur au DPA';
        }
        field(90; "PMP recalcule"; Decimal)
        {
            Caption = 'PMP recalculé';
        }
        field(110; "Valeur au PMP recalcule"; Decimal)
        {
            Caption = 'Valeur au PMP recalculé';
            Editable = false;
        }
        field(200; "Ecart valeur PMP/NAV (Montant)"; Decimal)
        {
            Caption = 'Ecart valeur PMP/NAV (Montant)';
        }
        field(201; "Ecart absolu PMP/NAV (Mnt)"; Decimal)
        {
            Caption = 'Ecart absolu PMP/NAV (Mnt)';
        }
        field(210; "Ecart valeur PMP/NAV (%)"; Decimal)
        {
            Caption = 'Ecart valeur PMP/NAV (%)';
        }
        field(230; "% depreciation"; Decimal)
        {
            Caption = '% dépréciation';
        }
        field(500; Commentaire; Text[250])
        {
        }
        field(510; "Max Code Magasin"; Code[10])
        {
            CalcFormula = max ("Valorisation stock à date"."Code magasin" where ("No. article" = field ("No. article")));
            Description = 'Artifice pour ne calculer les valeurs que sur une ligne d''article et pas sur chaque ligne (plusieurs lignes si stock dans plusieurs magasins)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(995; "Filtre magasin conso"; Code[10])
        {
            FieldClass = FlowFilter;
        }
        field(1000; "Filtre date annee N"; Date)
        {
            Caption = 'Filtre date année N';
            FieldClass = FlowFilter;
        }
        field(1005; "Conso annee N"; Decimal)
        {
            CalcFormula = - sum ("Value Entry"."Invoiced Quantity" where ("Item Ledger Entry Type" = const (Sale),
                                                                        "Item No." = field ("No. article"),
                                                                        "Location Code" = field ("Filtre magasin conso"),
                                                                        "Drop Shipment" = const (false),
                                                                        "Posting Date" = field ("Filtre date annee N")));
            Caption = 'Conso année N';
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
        }
        field(1010; "Filtre date annee N-1"; Date)
        {
            Caption = 'Filtre date année N-1';
            FieldClass = FlowFilter;
        }
        field(1015; "Conso annee N-1"; Decimal)
        {
            CalcFormula = - sum ("Value Entry"."Invoiced Quantity" where ("Item Ledger Entry Type" = const (Sale),
                                                                        "Item No." = field ("No. article"),
                                                                        "Location Code" = field ("Filtre magasin conso"),
                                                                        "Drop Shipment" = const (false),
                                                                        "Posting Date" = field ("Filtre date annee N-1")));
            Caption = 'Conso année N-1';
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
        }
        field(1020; "Filtre date annee N-2"; Date)
        {
            Caption = 'Filtre date année N-2';
            FieldClass = FlowFilter;
        }
        field(1025; "Conso annee N-2"; Decimal)
        {
            CalcFormula = - sum ("Value Entry"."Invoiced Quantity" where ("Item Ledger Entry Type" = const (Sale),
                                                                        "Item No." = field ("No. article"),
                                                                        "Location Code" = field ("Filtre magasin conso"),
                                                                        "Drop Shipment" = const (false),
                                                                        "Posting Date" = field ("Filtre date annee N-2")));
            Caption = 'Conso année N-2';
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
        }
        field(1030; "Filtre date annee N-3"; Date)
        {
            Caption = 'Filtre date année N-3';
            FieldClass = FlowFilter;
        }
        field(1035; "Conso annee N-3"; Decimal)
        {
            CalcFormula = - sum ("Value Entry"."Invoiced Quantity" where ("Item Ledger Entry Type" = const (Sale),
                                                                        "Item No." = field ("No. article"),
                                                                        "Location Code" = field ("Filtre magasin conso"),
                                                                        "Drop Shipment" = const (false),
                                                                        "Posting Date" = field ("Filtre date annee N-3")));
            Caption = 'Conso année N-3';
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
        }
        field(1040; "Commentaire PMP"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "No. article", "Code magasin")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

