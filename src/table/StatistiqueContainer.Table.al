table 50044 "Statistique container"
{
    // KAN.FHA 10/02/2022
    //   Table vidée et remplie quand un utilisateur est sur un container et demande à en voir les statististiques

    Caption = 'Container';
    //DrillDownPageID = "Statistiques container";

    fields
    {
        field(1; "No. container"; Code[20])
        {
            Caption = 'N°';
            TableRelation = Container;
        }
        field(100; "No. commande achat"; Code[20])
        {
            Caption = 'N° commande achat';
            TableRelation = "Purchase Header"."No." where ("Document Type" = const (Order));
        }
        field(102; "Commentaire AIE"; Text[80])
        {
            CalcFormula = lookup ("Purchase Header"."Commentaires pour AIE" where ("Document Type" = const (Order),
                                                                                  "No." = field ("No. commande achat")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(103; "Commentaire commande"; Text[250])
        {
            CalcFormula = lookup ("Purchase Header".Commentaires where ("Document Type" = const (Order),
                                                                   "No." = field ("No. commande achat")));
            Caption = 'Commentaires';
            Description = 'X01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(105; "Montant commande"; Decimal)
        {
            CalcFormula = sum ("Purchase Line".Amount where ("Document Type" = const (Order),
                                                            "Document No." = field ("No. commande achat")));
            FieldClass = FlowField;
        }
        field(106; "Montant facture papier"; Decimal)
        {
            CalcFormula = sum ("Ligne container"."Montant facture (papier)" where ("No. container" = field ("No. container"),
                                                                                  "No. commande achat" = field ("No. commande achat")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(110; "Montant charge"; Decimal)
        {
            Caption = 'Montant chargé';
        }
        field(120; "Code devise"; Code[10])
        {
            TableRelation = Currency;
        }
        field(130; "Montant charge (DS)"; Decimal)
        {
            Caption = 'Montant chargé (DS)';
        }
        field(140; "Nb commande"; Decimal)
        {
            Description = '1 en dur pour faire la somme du nombre de commandes au niveau du container';
        }
        field(150; "Quantite totale"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum ("Ligne container".Quantite where ("No. container" = field ("No. container"),
                                                                "No. commande achat" = field ("No. commande achat")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No. container", "No. commande achat")
        {
            Clustered = true;
            SumIndexFields = "Nb commande", "Montant charge";
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No. container", "Nb commande", "Montant charge", "Code devise")
        {
        }
    }
}

