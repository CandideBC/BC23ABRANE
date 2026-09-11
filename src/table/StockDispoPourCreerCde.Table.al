table 50036 "Stock dispo pour creer cde"
{
    // KAN.FHA 05/05/2020
    //   Cette table est utilisée sur les devis et commandes de vente pour que l'utilisateur puisse sélectionner quels magasins doivent etre pris en compte
    //   il souhaite créer les commandes d'achats. En effet, l'utilisateur peut soit décider de tout racheter, soit de tenir compte de ce qui se trouve en stock
    //   dans tel ou tel magasin (par défaut le système ne va regarder que ce qui est en stock dans le magasin de l'entete de document de vente).

    //KAN.FHA 03/04/2025 
    //Elle sert aussi sur un devis ou une commande de vente à lister les articles vendus et montrer le stock dispo de chaque article

    DrillDownPageID = "Stock dispo sur creer cde HA";

    fields
    {
        field(10; "Code utilisateur"; Code[50])
        {
        }
        field(20; "Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Type document';
        }
        field(30; "Document No."; Code[20])
        {
            Caption = 'N° document';
            TableRelation = "Sales Header"."No." where("Document Type" = field("Document Type"));
        }
        field(35; "Type ligne"; Option)
        {
            OptionMembers = Magasin,"Stock dispo";
        }
        field(40; "Code magasin"; Code[20])
        {
            Caption = 'Code magasin';
            TableRelation = Location;
        }
        field(41; "Nom magasin"; Text[100])
        {
            CalcFormula = lookup(Location.Name where(Code = field("Code magasin")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(45; "Tenir compte du stock"; Boolean)
        {
            trigger OnValidate()
            begin
                ChercherStockDispo();
            end;
        }
        field(50; "No. article"; Code[20])
        {
            Caption = 'N° article';
            Description = 'Pour les lignes dont le [Type ligne] est stock dispo';
            TableRelation = Item;
        }
        field(51; "Designation article"; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No." = field("No. article")));
            Caption = 'Désignation article';
            Editable = false;
            FieldClass = FlowField;
        }
        field(54; "Code variante"; Code[10])
        {
            TableRelation = "Item Variant".Code where("Item No." = field("No. article"));
        }
        field(55; "Designation variante"; Text[100])
        {
            CalcFormula = lookup("Item Variant".Description where(Code = field("Code variante"),
                                                                   "Item No." = field("No. article")));
            Caption = 'Désignation variante';
            Editable = false;
            FieldClass = FlowField;
        }
        field(58; Quantite; Decimal)
        {
            BlankZero = true;
            Caption = 'Quantité';
            DecimalPlaces = 0 : 2;
            Description = 'Utilisé lorsqu''on demande le stock dispo depuis un devis ou une commande';
            FieldClass = FlowField;
            CalcFormula = sum(TamponDetailDispoStock."Quantite vendue" where("Code utilisateur" = field("Code utilisateur"), "No. article" = field("No. article")));
            Editable = false;
        }

        field(70; "Quantite achetee"; Decimal)
        {
            BlankZero = true;
            Caption = 'Quantité achetée';
            FieldClass = FlowField;
            CalcFormula = sum(TamponDetailDispoStock."Quantite achetee" where("Code utilisateur" = field("Code utilisateur"), "No. article" = field("No. article")));
            Editable = false;

            DecimalPlaces = 0 : 2;
            Description = 'Pour les lignes dont le [Type ligne] est stock dispo';
        }
        field(80; "Qte prise sur stock"; Decimal)
        {
            BlankZero = true;
            Caption = 'Qté prise sur stock';
            FieldClass = FlowField;
            CalcFormula = sum(TamponDetailDispoStock."Quantite prise sur stock" where("Code utilisateur" = field("Code utilisateur"), "No. article" = field("No. article")));

            DecimalPlaces = 0 : 2;
            Description = 'Pour les lignes dont le [Type ligne] est stock dispo';
        }
        field(82; "Reste a definir (Qte)"; Decimal)
        {
            BlankZero = true;
            Caption = 'Reste à définir (Qté)';
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;
            CalcFormula = sum(TamponDetailDispoStock."Quantite non sourcee" where("Code utilisateur" = field("Code utilisateur"), "No. article" = field("No. article")));

            Description = 'Pour les lignes dont le [Type ligne] est stock dispo';
            //Si on vend 10 et qu'on n'a pas dit "Pris sur stock" sur la ligne commande ni fait aucun achat, alors cette colonne montre une valeur (la quantité commandée)
        }

        field(100; Stock; Decimal)
        {
            BlankZero = true;
            Caption = 'Stock';
            DecimalPlaces = 0 : 2;
            Description = 'Pour les lignes dont le [Type ligne] est stock dispo';
        }
        field(110; "Stock dispo"; Decimal)
        {
            BlankZero = true;
            Caption = 'Quantité dispo';
            DecimalPlaces = 0 : 2;
            Description = 'Pour les lignes dont le [Type ligne] est stock dispo';
        }
        field(112; "Quantite reservee"; Decimal)
        {
            BlankZero = true;
            Caption = 'Quantité réservée';
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;
            CalcFormula = sum(TamponDetailDispoStock."Quantite reservee" where("Code utilisateur" = field("Code utilisateur"), "No. article" = field("No. article"), "Quantite reservee" = filter(<> 0)));

            Description = 'Pour les lignes dont le [Type ligne] est stock dispo';
            //Si on vend 10 et qu'on n'a pas dit "Pris sur stock" sur la ligne commande ni fait aucun achat, alors cette colonne montre une valeur (la quantité commandée)
        }
        
        field(114; "Qte sur commande achat"; Decimal)
        {
            Caption = 'Qté sur commande achat';
            FieldClass = FlowField;

            CalcFormula = sum("Purchase Line"."Outstanding Qty. (Base)" where("Document Type" = const(Order),
                                                                            Type = const(Item),
                                                                            "No." = field("No. article"),
                                                                            "Location Code" = field("Code magasin"),
                                                                            "Drop Shipment" = const(false),
                                                                            "Variant Code" = field("Code variante")));
            Editable = false;
            DecimalPlaces = 0:5;
        }
        field(115; "Qte sur commande vente"; Decimal)
        {
            Caption = 'Qté sur commande vente';
            FieldClass = FlowField;
            DecimalPlaces = 0:5;
            CalcFormula = sum("Sales Line"."Outstanding Qty. (Base)" where("Document Type" = const(Order),
                                                                            Type = const(Item),
                                                                            "No." = field("No. article"),
                                                                            "Location Code" = field("Code magasin"),
                                                                            "Drop Shipment" = const(false),
                                                                            "Variant Code" = field("Code variante")));
            Editable = false;
        }
        field(116; "Qte sur devis 100%"; Decimal)
        {
            Caption = 'Qté sur devis 100%';
            FieldClass = FlowField;
            CalcFormula = sum(TamponDetailDispoStock."Quantite sur devis" where("Code utilisateur" = field("Code utilisateur"), "No. article" = field("No. article"), "Proba transformation"=const("100"),"Quantite sur devis" = filter(<> 0)));
            DecimalPlaces = 0 : 5;
            BlankZero = true;
            Editable = false;
        }

        field(120; "Qte en transit"; Decimal)
        {
            Caption = 'Qté en transit';
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Description = 'Pour les lignes dont le [Type ligne] est stock dispo';
        }
    }

    keys
    {

        key(Key1; "Code utilisateur", "Document Type", "Document No.", "Type ligne", "Code magasin", "No. article", "Code variante")
        {
            Clustered = true;
        }
        key(Key2; "Code utilisateur", "Document Type", "Document No.", "Type ligne", "No. article", "Code magasin")
        {
        }

        key(Key3; "Document Type", "Document No.", "Type ligne", "No. article")
        {
            SumIndexFields = "Stock dispo";
        }
        key(Key4; "Code utilisateur", "Document Type", "Document No.", "Code magasin","Stock dispo")
        {
        }
    }

    fieldgroups
    {
    }

    var
        LigneVente: Record "Sales Line";
        ChoixMagasin: Record "Stock dispo pour creer cde";
        Article: Record Item;
        QteDispo: Decimal;

    procedure ChercherStockDispo()
    begin
        LigneVente.SetCurrentKey("Document Type", "Document No.", Type, "Vendor No.");
        LigneVente.SetRange("Document Type", "Document Type");
        LigneVente.SetRange("Document No.", "Document No.");
        LigneVente.SetRange(Type, LigneVente.Type::Item);

        if not "Tenir compte du stock" then begin //On supprime le 'Stock dispo" (quantités dispo de chaque article sur le magasin).
            ChoixMagasin.SetRange("Code utilisateur", UserId);
            ChoixMagasin.SetRange("Document Type", "Document Type");
            ChoixMagasin.SetRange("Document No.", "Document No.");
            ChoixMagasin.SetRange("Type ligne", ChoixMagasin."Type ligne"::"Stock dispo");
            ChoixMagasin.SetRange("Code magasin", "Code magasin");
            ChoixMagasin.DeleteAll();

            //Si l'utilisateur ne souhaite pas tenir compte du stock d'aucun magasin, on repositionne la [Quantité à acheter] avec la Quantité du document
            ChoixMagasin.SetRange("Code utilisateur", UserId);
            ChoixMagasin.SetRange("Document Type", "Document Type");
            ChoixMagasin.SetRange("Document No.", "Document No.");
            ChoixMagasin.SetRange("Type ligne", ChoixMagasin."Type ligne"::Magasin);
            ChoixMagasin.SetRange("Tenir compte du stock", true);
            if LigneVente.FindSet(true) then
                repeat
                    if ChoixMagasin.IsEmpty then begin
                        LigneVente."Quantite a acheter" := LigneVente."Outstanding Quantity";
                        LigneVente.Modify(); 
                    end;
                until LigneVente.Next() = 0;

        end else
            if LigneVente.FindSet(true) then
                repeat
                    if Article.Get(LigneVente."No.") then
                        if not Article."Miscellaneous Item" then begin
                            Article.SetFilter("Location Filter", "Code magasin");
                            if "Code variante" <> '' then
                                Article.SetRange("Variant Filter", "Code variante")
                            else
                                Article.SetRange("Variant Filter");


                            Article.CalculerDispo(false,QteDispo);
                            if QteDispo > 0 then begin
                                ChoixMagasin.Init();
                                ChoixMagasin."Code utilisateur" := copystr(UserId, 1, 50);
                                ChoixMagasin."Document Type" := "Document Type";
                                ChoixMagasin."Document No." := "Document No.";
                                ChoixMagasin."Type ligne" := ChoixMagasin."Type ligne"::"Stock dispo";
                                ChoixMagasin."Code magasin" := "Code magasin";
                                ChoixMagasin."No. article" := LigneVente."No.";
                                ChoixMagasin."Code variante" := LigneVente."Variant Code";
                                ChoixMagasin."Stock dispo" := QteDispo;
                                if ChoixMagasin.Insert() then;
                            end;

                        end;
                    LigneVente.Modify(); //Inutile mais grace à cela, cela met à jour le FlowField "Stock dispo instant t" à l'affichage dans la sous-page
                until LigneVente.Next() = 0;

    end;
}

