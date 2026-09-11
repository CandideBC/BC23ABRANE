table 50070 "Contenu colisage container"
{
    Caption = 'Contenu colisage container';
    //Cette table ne fait que rattacher des articles à un container global, sans rattacher chaque article à telle ou telle unité de colisage.

    fields
    {
        field(1; "No. container"; Code[20])
        {
            Caption = 'N° container';
            TableRelation = Container;
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
                /*
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
                */
            end;
        }
        field(4; Description; Text[100])
        {
            Caption = 'Désignation';

            trigger OnValidate()
            begin
                //CheckPackingStatus();
            end;
        }
        

        /*
        field(6; "Poids net unitaire invariable"; Decimal)
        {
            BlankZero = true;
            Caption = 'Poids net unitaire invariable (KG)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        */

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
            TableRelation = "UC container"."No. UC" where ("No. container" = field ("No. container"));

            trigger OnValidate()
            begin
                //CheckPackingStatus();

                UCContainer.Reset();
                UCContainer.SetRange("No. container", "No. container");
                UCContainer.SetRange("No. UC", "No. UC");
                if UCContainer.FindFirst() then
                    "Poids brut ligne" := UCContainer."Poids brut UC"
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
                //CheckPackingStatus();
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

        field(22; Type; Enum "Sales Line Type")
        {
            Caption = 'Type';
            //OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
            //OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";

            trigger OnValidate()
            begin
                //CheckPackingStatus();
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
        
        field(80; "Attached to Line No."; Integer)
        {
            BlankZero = true;
            Caption = 'Attaché à la ligne n°';
            TableRelation = "Contenu colisage container"."No. ligne" where ("No. container" = field ("No. container"));

            trigger OnValidate()
            begin
                //CheckPackingStatus();
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
        key(Key1; "No. container", "No. ligne")
        {
            Clustered = true;
            SumIndexFields = "Poids net ligne","Poids brut ligne";
        }
        key(Key2; "No. container", "Item No.")
        {
        }

        key(Key3; "No. container", "No. UC")
        {
            SumIndexFields = "Poids net ligne";
        }
        key(MyKey10; "No. UC")
        {
            
        }

    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        ContenuColisageContainer: Record "Contenu colisage container";
    begin
        Container.Get("No. container");
        if Container."Statut container" = Container."Statut container"::"Réceptionné" then
            Error(Text001Err);

        ContenuColisageContainer.SetRange("No. container", Rec."No. container");
        ContenuColisageContainer.SetRange("Attached to Line No.", "No. ligne");
        ContenuColisageContainer.DeleteAll();
    end;

    procedure EclaterLigne()
    var
        ContenuColisageNew: Record "Contenu colisage container";
    begin
        ContenuColisageNew.Init();
        ContenuColisageNew.TransferFields(Rec);
        ContenuColisageNew."No. ligne" := GetNextLineNo();
        //NumRec := ContenuColisageNew."No. ligne";
        ContenuColisageNew."Attached to Line No." := Rec."No. ligne";
        ContenuColisageNew."No. UC" := Rec."No. UC";
        ContenuColisageNew.Insert();
    end;


    procedure GetNextLineNo(): Integer;
        var
            lContenuColisage: Record "Contenu colisage container";
            Num: Decimal;

    begin
        lContenuColisage.Reset();
        lContenuColisage.SetRange("No. container", Rec."No. container");
        lContenuColisage.SetFilter("No. ligne", '>%1', Rec."No. ligne");
        if lContenuColisage.FindFirst() then begin
            Num := Round((lContenuColisage."No. ligne" - Rec."No. ligne") / 2, 1);
            exit(Rec."No. ligne" + Num);
        end else begin
            lContenuColisage.SetRange("No. ligne");
            if lContenuColisage.FindLast() then
                exit(lContenuColisage."No. ligne" + 10000)
            else
                exit(10000);
        end;
    end;

    var
        Container: Record Container;
        UCContainer: Record "UC container";
        Text001Err: Label 'Statut colisage "Terminé" - Suppression de ligne impossible';





}

