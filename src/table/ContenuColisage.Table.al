table 50015 "Contenu colisage"
{
    Caption = 'Contenu colisage';
    //Cette table ne fait que rattacher des articles à un colisage global de vente, sans rattacher chaque article à telle ou telle unité de colisage.
    //En effet, parfois on a un colisage qui dit "3 palettes et 2 colis" pour 1200kg mais on ne sait quel article est sur quelle palette. Cas de l'UE en général.
    //Parfois, on va devoir détailler quel article est sur quelle palette et là c'est une autre table qui fait le lien; la table détail colisage.

    fields
    {
        field(1; "No. colisage"; Code[20])
        {
            Caption = 'N° colisage';
            TableRelation = "Entete colisage";
        }
        field(2; "No. ligne"; Integer)
        {
            Caption = 'N° ligne';
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'N° article';
            TableRelation = Item;

            trigger OnValidate()
            begin
                CheckPackingStatus();

                if "Shipment No." <> '' then begin
                    //Controle existence dans le BL
                    ShptLine.SetRange("Document No.", "Shipment No.");
                    ShptLine.SetRange(Type, Type);
                    ShptLine.SetRange("No.", "Item No.");
                    if not ShptLine.FindFirst() then
                        Error(Text003Err, "Item No.", "Shipment No.");

                    //Mettre à jour la ligne du BL
                    "Shipment Line No." := ShptLine."Line No.";
                    Description := ShptLine.Description;
                    "Description 2" := ShptLine."Description 2";
                    "Quantite UC" := ShptLine.Quantity;
                    //"Cross-Reference No." := ShptLine."Item Reference No.";
                end else
                    if "Order No." <> '' then begin
                        //Controle existence dans le BL
                        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                        SalesLine.SetRange("Document No.", "Order No.");
                        SalesLine.SetRange(Type, Type);
                        SalesLine.SetRange("No.", "Item No.");
                        if SalesLine.IsEmpty then
                            Error(Text006Err, "Item No.", "Order No.");
                    end;

                "Designation article" := '';
                if Type = Rec.Type::Item then begin
                    Item.Get("Item No.");
                    "Designation article" := Item.Description;
                end;
            end;
        }
        field(4; Description; Text[100])
        {
            Caption = 'Désignation';

            trigger OnValidate()
            begin
                CheckPackingStatus();
            end;
        }
        

        field(6; "Poids net unitaire invariable"; Decimal)
        {
            BlankZero = true;
            Caption = 'Poids net unitaire invariable (KG)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }

        field(7; "Poids brut unitaire"; Decimal)
        {
            BlankZero = true;
            Caption = 'Poids brut unitaire';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        
        field(9; "No. UC"; Code[20])
        {
            Caption = 'N° UC';
            TableRelation = "Detail colisage"."No. UC" where ("No. colisage" = field ("No. colisage"));

            trigger OnValidate()
            begin
                CheckPackingStatus();

                Package.Reset();
                Package.SetRange("No. colisage", "No. colisage");
                Package.SetRange("No. UC", "No. UC");
                if Package.FindFirst() then
                    "Poids brut ligne" := Package."Poids brut UC"
                else 
                    "Poids brut ligne" := 0;
                
            end;
        }
        field(10; "Quantite UC"; Decimal)
        {
            BlankZero = true;
            Caption = 'Quantité UC';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                CheckPackingStatus();
                "Poids net ligne" := "Poids net unitaire" * "Quantite UC";
            end;
        }
        field(11; "Poids brut ligne"; Decimal)
        {
            BlankZero = true;
            Caption = 'Poids brut ligne (KG)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(12; "Poids net ligne"; Decimal)
        {
            BlankZero = true;
            Caption = 'Poids net ligne (KG)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(20; "Shipment No."; Code[20])
        {
            Caption = 'N° livraison';
            TableRelation = "Sales Shipment Header";

            trigger OnLookup()
            begin
                if not EnteteColisage.Get("No. colisage") then
                    EnteteColisage.Init();
                ShptHeader.SetRange("Sell-to Customer No.", EnteteColisage."Sell-to Customer No.");

                Clear(fLookup);
                fLookup.SetTableView(ShptHeader);
                fLookup.LookupMode(true);
                if fLookup.RunModal() = ACTION::LookupOK then begin
                    fLookup.GetRecord(ShptHeader);
                    if ShptHeader."No." <> xRec."Shipment No." then                     
                        Validate("Shipment No.", ShptHeader."No.");
                end;

            end;

            trigger OnValidate()
            begin
                CheckPackingStatus();

                if "Shipment No." <> xRec."Shipment No." then begin
                    "Shipment Line No." := 0;
                    "Order No." := '';
                    "Order Line No." := 0;
                    "Item No." := '';
                    "Attached to Line No." := 0;
                    Description := '';
                    "Description 2" := '';
                    //"Cross-Reference No." := '';
                    "Quantite UC" := 0;
                    "Designation article" := '';
                end;
                if "Shipment No." <> '' then begin
                    ShptLine.SetRange("Document No.", "Shipment No.");
                    ShptLine.SetRange("Attached to Line No.", 0);
                    if ShptLine.FindSet() then
                        if ShptLine.Count = 1 then
                            Validate("Shipment Line No.", ShptLine."Line No.");
                end;
            end;
        }
        field(21; "Shipment Line No."; Integer)
        {
            BlankZero = true;
            Caption = 'N° ligne livraison';
            TableRelation = "Sales Shipment Line"."Line No." where ("Document No." = field ("Shipment No."));

            trigger OnValidate()
            begin
                CheckPackingStatus();

                if not ShptLine.Get("Shipment No.", "Shipment Line No.") then
                    Error(Text004Err, "Shipment Line No.", "Shipment No.");
                if (ShptLine."No. colisage" <> '') and (ShptLine."No. colisage" <> "No. colisage") then
                    Error(Text005Err, "Shipment Line No.", "Shipment No.", ShptLine."No. colisage");


                case ShptLine.Type of 
                    ShptLine.Type::" " : Type := Type::" "; 
                    shptLine.Type::"Charge (Item)" : Type := Type::"Charge (Item)";
                    ShptLine.Type::"G/L Account" : Type := Type::"G/L Account";
                    ShptLine.Type::Item : Type := Type::Item;
                    ShptLine.Type::Resource : Type := Type::Resource;
                end;
                "Attached to Line No." := "Attached to Line No.";
                "Order No." := ShptLine."Order No.";
                Description := ShptLine.Description;
                "Description 2" := ShptLine."Description 2";
                "Item No." := ShptLine."No.";
                //"Cross-Reference No." := ShptLine."Item Reference No.";
                "Quantite UC" := ShptLine.Quantity;
                "Poids net unitaire" := ShptLine."Net Weight";
                "Poids net ligne" := ShptLine.Quantity * ShptLine."Net Weight";

                "Order Line No." := ShptLine."Order Line No.";

                "Designation article" := '';
                if Type = Rec.Type::Item then begin
                    Item.Get("Item No.");
                    "Designation article" := Item.Description;
                end;
            end;
        }
        field(22; Type; Enum "Sales Line Type")
        {
            Caption = 'Type';
            //OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
            //OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";

            trigger OnValidate()
            begin
                CheckPackingStatus();
            end;
        }
        field(23; "Description 2"; Text[50])
        {
            Caption = 'Désignation 2';
            Editable = false;
        }
        field(24; "Designation article"; Text[100])
        {
            Caption = 'Désignation article';
            Editable = false;
        }
        field(25; "Quantite colisee totale"; Decimal)
        {
            CalcFormula = sum ("Contenu colisage"."Quantite UC" where ("Shipment No." = field ("Shipment No."),
                                                             "Shipment Line No." = field ("Shipment Line No."),
                                                             "Order No." = field ("Order No."),
                                                             "Order Line No." = field ("Order Line No.")));
            Caption = 'Qté colisée totale';
            Editable = false;
            FieldClass = FlowField;
            DecimalPlaces = 0:5;
        }
        field(26; "Qte expediee"; Decimal)
        {
            CalcFormula = lookup ("Sales Shipment Line".Quantity where ("Document No." = field ("Shipment No."),
                                                                       "Line No." = field ("Shipment Line No.")));
            Caption = 'Qté expédiée';
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Qte commandee"; Decimal)
        {
            CalcFormula = lookup ("Sales Line".Quantity where ("Document Type"=const(Order),"Document No." = field ("Order No."),
                                                                       "Line No." = field ("Order Line No.")));
            Caption = 'Qté commandée';
            Editable = false;
            FieldClass = FlowField;
            DecimalPlaces = 0:5;
        }
        field(40; "Type produit"; Option)
        {
            Caption = 'Type produit';
            DataClassification = ToBeClassified;
            OptionMembers = "Produit fini",Composant;
            OptionCaption = 'Produit fini,Composant';
        }
        field(44; "No. ligne regroupement"; Integer)
        {
            //Champ servant à faire la somme des poids nets et bruts d'un meuble à partir des poids de ses composants
            Caption = 'N° ligne regroupement';
            DataClassification = ToBeClassified;
            Description = 'Chaque composant d''un produit fini a comme N° ligne regroupement le N° de ligne du composé. Un produit isolé non composé a lieu même comme ligne de regroupent.';
        }
        
        field(80; "Attached to Line No."; Integer)
        {
            BlankZero = true;
            Caption = 'Attaché à la ligne n°';
            TableRelation = "Contenu colisage"."No. ligne" where ("No. colisage" = field ("No. colisage"));

            trigger OnValidate()
            begin
                CheckPackingStatus();
            end;
        }
        field(110; "Order No."; Code[20])
        {
            Caption = 'N° commande';
            TableRelation = "Sales Header"."No." where ("Document Type" = const (Order));

            trigger OnLookup()
            begin
                TestField("Shipment No.", '');
                if not EnteteColisage.Get("No. colisage") then
                    EnteteColisage.Init();
                SalesHeader.SetRange("Sell-to Customer No.", EnteteColisage."Sell-to Customer No.");
                SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                Clear(fLookupOrder);
                fLookupOrder.SetTableView(SalesHeader);
                fLookupOrder.LookupMode(true);
                if fLookupOrder.RunModal() = ACTION::LookupOK then begin
                    fLookupOrder.GetRecord(SalesHeader);
                    if SalesHeader."No." <> xRec."Order No." then begin
                        "Order No." := SalesHeader."No.";
                        "Order Line No." := 0;
                        Type := 0;
                        "Description 2" := '';
                        "Item No." := '';
                        Description := '';
                        //"Cross-Reference No." := '';
                    end;
                end;
            end;
            trigger OnValidate()
            begin
                CheckPackingStatus();

                TestField("Shipment No.", '');
                if "Order No." <> xRec."Order No." then
                    "Order Line No." := 0;
            end;
        }
        field(115; "Order Line No."; Integer)
        {
            BlankZero = true;
            Caption = 'N° ligne commande';
            TableRelation = "Sales Line"."Line No." where ("Document Type" = const (Order),
                                                           "Document No." = field ("Order No."),
                                                           Type = const (Item));

            trigger OnValidate()
            var
                AttachedSalesLine: Record "Sales Line";
                NewLineNo: Integer;
            begin
                CheckPackingStatus();
                if "Order Line No." <> 0 then begin
                    TestField("Order No.");
                    SalesLine.Get(SalesLine."Document Type"::Order, "Order No.", "Order Line No.");
                    "Item No." := SalesLine."No.";
                    Description := SalesLine.Description;
                    "Description 2" := SalesLine."Description 2";
                    if SalesLine.Type = SalesLine.Type::Item then begin
                        Item.Get(SalesLine."No.");
                        "Designation article" := Item.Description;
                    end else
                        "Designation article" := '';
                    //"Cross-Reference No." := SalesLine."Item Reference No.";
                    "Quantite UC" := SalesLine.Quantity;
                    case SalesLine.Type of 
                        SalesLine.Type::" " : Type := Type::" "; 
                        SalesLine.Type::"Charge (Item)" : Type := Type::"Charge (Item)";
                        SalesLine.Type::"G/L Account" : Type := Type::"G/L Account";
                        SalesLine.Type::Item : Type := Type::Item;
                        SalesLine.Type::Resource : Type := Type::Resource;
                    end;

                    "Attached to Line No." := SalesLine."Attached to Line No.";
                    "Poids net unitaire" := SalesLine."Net Weight";
                    "Poids net ligne" := SalesLine.Quantity * SalesLine."Net Weight";
                    AttachedSalesLine.SetRange("Document Type", AttachedSalesLine."Document Type"::Order);
                    AttachedSalesLine.SetRange("Document No.", "Order No.");
                    AttachedSalesLine.SetRange(Type, 0);
                    AttachedSalesLine.SetRange("Attached to Line No.", "Order Line No.");
                    if AttachedSalesLine.FindSet() then begin
                        NewLineNo := "No. ligne" + 10000;
                        repeat
                            ContenuColisage.Init();
                            ContenuColisage."No. colisage" := "No. colisage";
                            ContenuColisage."No. ligne" := NewLineNo;
                            ContenuColisage."Attached to Line No." := "No. ligne";
                            ContenuColisage."Item No." := AttachedSalesLine."No.";
                            ContenuColisage.Description := AttachedSalesLine.Description;
                            ContenuColisage."Description 2" := AttachedSalesLine."Description 2";
                            ContenuColisage."Designation article" := '';
                            //ContenuColisage."Cross-Reference No." := AttachedSalesLine."Item Reference No.";
                            ContenuColisage."Quantite UC" := 0;
                            case AttachedSalesLine.Type of 
                                AttachedSalesLine.Type::" " : Type := Type::" "; 
                                AttachedSalesLine.Type::"Charge (Item)" : Type := Type::"Charge (Item)";
                                AttachedSalesLine.Type::"G/L Account" : Type := Type::"G/L Account";
                                AttachedSalesLine.Type::Item : Type := Type::Item;
                                AttachedSalesLine.Type::Resource : Type := Type::Resource;
                            end;

                            ContenuColisage."Order No." := AttachedSalesLine."Document No.";
                            ContenuColisage."Order Line No." := AttachedSalesLine."Line No.";
                            ContenuColisage.Insert(true);
                            NewLineNo := NewLineNo + 10000;
                        until AttachedSalesLine.Next() = 0;
                    end;
                end;
            end;
        }


        field(119; "Poids net unitaire"; Decimal)
        {
            Caption = 'Poids net unitaire';
        }
        field(200; "Erreur validation BL"; Text[250])
        {
            Caption = 'Erreur validation BL';
            DataClassification = ToBeClassified;
        }
        
    }

    keys
    {
        key(Key1; "No. colisage", "No. ligne")
        {
            Clustered = true;
            SumIndexFields = "Poids net ligne","Poids brut ligne";
        }
        key(Key2; "No. colisage", "Item No.")
        {
        }

        key(Key3; "No. colisage", "No. UC")
        {
            SumIndexFields = "Poids net ligne";
        }
        key(Key4; "No. colisage", "Shipment No.", "Shipment Line No.", "Order No.", "Order Line No.")
        {
            SumIndexFields = "Quantite UC";
        }
        key(Key5; "No. colisage", "No. UC", "Shipment No.", "Shipment Line No.")
        {
            SumIndexFields = "Quantite UC";
        }
        key(Key6; "No. colisage", "No. UC", "Order No.", "Order Line No.")
        {
        }
        key(Key7; "No. colisage", "Order No.", "Order Line No.")
        {
        }
        key(MyKey8; "Shipment No.","Shipment Line No.")
        {
            SumIndexFields = "Quantite UC";
        }
        key(MyKey9; "Order No.","Order Line No.")
        {
            SumIndexFields = "Quantite UC";
        }
        key(MyKey10; "No. UC")
        {
            
        }

    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        EnteteColisage.Get("No. colisage");
        if EnteteColisage."Packing Status" = EnteteColisage."Packing Status"::Terminé then
            Error(Text001Err);

        ReleaseLine(Rec);
        //supprimer les lignes attachées
        ContenuColisage.SetRange("No. colisage", EnteteColisage."No.");
        ContenuColisage.SetRange("Attached to Line No.", "No. ligne");
        ContenuColisage.DeleteAll();
    end;

    trigger OnInsert()
    begin
        CheckPackingStatus();
        EnteteColisage.Get("No. colisage");
        BlockLine();
        Package.SetRange("No. colisage", "No. colisage");
        if Package.FindFirst() then
            Validate("No. UC", Package."No. UC");
    end;

    trigger OnModify()
    begin
        EnteteColisage.Get("No. colisage");
        if EnteteColisage."Packing Status" = EnteteColisage."Packing Status"::"Terminé" then
            Error(Text002Err);

        //Libérer la ligne du BL  précédent s'il n'est référencé sur une autre ligne colisage
        if (xRec."Shipment No." <> "Shipment No.") or (xRec."Shipment Line No." <> "Shipment Line No.") or
           (xRec."Order No." <> "Order No.") or (xRec."Order Line No." <> "Order Line No.")
        then
            ReleaseLine(xRec);
        BlockLine();

        //Repercuter sur les lignes attachées
        ContenuColisageLiee.Reset();
        ContenuColisageLiee.SetRange("No. colisage", "No. colisage");
        ContenuColisageLiee.SetRange("Attached to Line No.", "No. ligne");
        if ContenuColisageLiee.FindSet() then
            repeat
                ContenuColisageLiee.Validate("No. UC", "No. UC");
                ContenuColisageLiee.Modify();
            until ContenuColisageLiee.Next() = 0;
    end;

    var
        EnteteColisage: Record "Entete colisage";
        ContenuColisage: Record "Contenu colisage";
        ShptHeader: Record "Sales Shipment Header";
        ShptLine: Record "Sales Shipment Line";
        Package: Record "Detail colisage";
        ContenuColisageLiee: Record "Contenu colisage";
        Item: Record Item;
        SalesLine: Record "Sales Line";
        SalesHeader: Record "Sales Header";
        fLookup: Page "Posted Sales Shipments";
        fLookupOrder: Page "Sales List";
        bRelease: Boolean;
        Text001Err: Label 'Statut colisage "Terminé" - Suppression de ligne impossible';
        Text002Err: Label 'Statut colisage "Terminé" - modification impossible';
        Text003Err: Label 'Article %1 n''appartient pas au BL %2',Comment = '%1 = N° article ; %2 = N° BL';
        Text004Err: Label 'Ligne %1 n''existe pas pour le BL %2',Comment = '%1 = N° ligne ; %2 = N° BL';
        Text005Err: Label 'La ligne %1 du BL %2 est déjà associée à la liste de colisage %3',Comment = '%1 = N° ligne ; %2 = N° BL ; %3 = N° colisage';
        Text006Err: Label 'Article %1 n''appartient pas à la commande %2',Comment = '%1 = N° article ; %2 = N° commande';

    procedure ReleaseLine(pRec: Record "Contenu colisage")
    begin
        //Libérer la ligne du BL
        if pRec."Shipment No." <> '' then begin
            ContenuColisage.Reset();
            ContenuColisage.SetRange("Shipment No.", pRec."Shipment No.");
            ContenuColisage.SetRange("Shipment Line No.", pRec."Shipment Line No.");
            bRelease := true;
            if ContenuColisage.FindSet() then
                repeat
                    if (ContenuColisage."No. colisage" <> pRec."No. colisage") or
                       (ContenuColisage."No. ligne" <> pRec."No. ligne")
                    then
                        bRelease := false;
                until (ContenuColisage.Next() = 0) or not bRelease;
            if bRelease then
                if ShptLine.Get(pRec."Shipment No.", pRec."Shipment Line No.") then begin
                    ShptLine."Packing in Progress" := false;
                    ShptLine.Modify();
                end;
        end;
        if pRec."Order No." <> '' then begin
            ContenuColisage.Reset();
            ContenuColisage.SetRange("Order No.", pRec."Order No.");
            ContenuColisage.SetRange("Order Line No.", pRec."Order Line No.");
            bRelease := true;
            if ContenuColisage.FindSet() then
                repeat
                    if (ContenuColisage."No. colisage" <> pRec."No. colisage") or
                       (ContenuColisage."No. ligne" <> pRec."No. ligne")
                    then
                        bRelease := false;
                until (ContenuColisage.Next() = 0) or not bRelease;
            if bRelease then
                if SalesLine.Get(SalesLine."Document Type"::Order, pRec."Order No.", pRec."Order Line No.") then begin
                    SalesLine."Packing in Progress" := false;
                    SalesLine.Modify();
                end;
        end;
    end;

    procedure BlockLine()
    begin
        //Bloquer la ligne du BL  en cours
        if "Shipment No." <> '' then begin
            if ShptLine.Get("Shipment No.", "Shipment Line No.") then begin
                ShptLine."Packing in Progress" := true;
                ShptLine.Modify();
            end;
        end else
            //Bloquer la ligne de commande
            if "Order No." <> '' then
                if SalesLine.Get(SalesLine."Document Type"::Order, "Order No.", "Order Line No.") then begin
                    SalesLine."Packing in Progress" := true;
                    SalesLine.Modify();
                end;
    end;

    procedure CheckPackingStatus()
    var
        lEnteteColisage: Record "Entete colisage";
        lText001Err: Label 'Modification non autorisée en raison du statut du colisage';
    begin
        //NEG.NL05 DIAGONAL YCH 11/10/2010 RTC
        if lEnteteColisage.Get("No. colisage") and (lEnteteColisage."Packing Status" <> 0) then
            Error(lText001Err);
    end;
}

