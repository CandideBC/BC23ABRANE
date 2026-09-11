table 50067 "Prepa colisage"
{
    Caption = 'Préparation colisage';
    //Cette table permet de rattacher une ou plusieurs unités de colisage (palette/colis) à une ligne de commande de vente.
    //Cette etape n'est pas obligatoire, on peut directement valider une commande en bon de livraison.
    

    fields
    {

        field(10; "No. commande"; Code[20])
        {
            Caption = 'N° commande';
            TableRelation = "Sales Header"."No." where("Document Type" = const(Order));
        }
        field(15; "No. ligne commande"; Integer)
        {
            BlankZero = true;
            Caption = 'N° ligne commande';
            TableRelation = "Sales Line"."Line No." where("Document Type" = const(Order),
                                                           "Document No." = field("No. commande"),
                                                           Type = const(Item));
        }
        field(20; "No. UC"; Code[20])
        {
            Caption = 'N° UC';
            TableRelation = "Unite colisage";

        }
        field(21;Numerotation; Code[10])
        {
            Caption = 'Numérotation';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                recPrepa: Record "Prepa colisage";
                UC: Record "Unite colisage";
            begin
                recPrepa.SetCurrentKey("No. commande", "No. UC");
                recPrepa.SetRange("No. commande",Rec."No. commande");
                recPrepa.SetRange("No. UC",Rec."No. UC");
                recPrepa.SetFilter("No. ligne commande",'<>%1',Rec."No. ligne commande");
                recPrepa.ModifyAll(Numerotation,Rec.Numerotation);

                UC.Get(Rec."No. UC");
                UC.Numerotation := Rec.Numerotation;
                UC.Modify();
            end;
        }
        field(22;"Numero camion"; Code[20])
        {
            Caption = 'Numéro camion';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                recPrepa: Record "Prepa colisage";
                UC: Record "Unite colisage";
            begin
                recPrepa.SetCurrentKey("No. commande", "No. UC");
                recPrepa.SetRange("No. commande",Rec."No. commande");
                recPrepa.SetRange("No. UC",Rec."No. UC");
                recPrepa.SetFilter("No. ligne commande",'<>%1',Rec."No. ligne commande");
                recPrepa.ModifyAll("Numero camion",Rec."Numero camion");

                UC.Get(Rec."No. UC");
                UC."Numero camion" := Rec."Numero camion";
                UC.Modify();
            end;
        }
        field(23; "Type UC"; Option)
        {
            Caption = 'Type UC';
            DataClassification = ToBeClassified;
            OptionMembers = " ",Palette,"Colis";
            OptionCaption = ' ,Palette,Colis';
            trigger OnValidate()
            var
                recPrepa: Record "Prepa colisage";
                UC: Record "Unite colisage";
            begin
                recPrepa.SetCurrentKey("No. commande", "No. UC");
                recPrepa.SetRange("No. commande",Rec."No. commande");
                recPrepa.SetRange("No. UC",Rec."No. UC");
                recPrepa.SetFilter("No. ligne commande",'<>%1',Rec."No. ligne commande");
                recPrepa.ModifyAll("Type UC",Rec."Type UC");

                UC.Get(Rec."No. UC");
                UC."Type UC" := Rec."Type UC";
                UC.Modify();
            end;
        }
        field(25; Phase; Integer)
        {
            Caption = 'Phase';
        }
        field(30; "No. article"; Code[20])
        {
            Caption = 'N° article';
            TableRelation = Item;

        }
        field(40; Designation; Text[100])
        {
            Caption = 'Désignation';
        }

        field(41; "Designation 2"; Text[50])
        {
            Caption = 'Désignation 2';
            Editable = false;
        }
        field(50; "Quantite dans UC"; Decimal)
        {
            BlankZero = true;
            Caption = 'Quantité dans UC';
            DecimalPlaces = 0 : 5;
        }

    }

    keys
    {
        key(PK; "No. commande", "No. ligne commande", "No. UC")
        {
            Clustered = true;
            SumIndexFields = "Quantite dans UC";
        }
        key(MyKey1; "No. commande",Phase)
        {
            
        }
        key(MyKey2; "No. commande","No. UC")
        {
            
        }
    }

    fieldgroups
    {
    }

}

