table 50068 "UC Commande"
{
    Caption = 'UC Commande';
    DrillDownPageId = "UC Commande";

    fields
    {
        field(1; "No. commande"; Code[20])
        {
            Caption = 'N° commande';

        }
        field(10; "No. UC"; Code[20])
        {
            Caption = 'N° UC';
            TableRelation = "Unite colisage";
            ValidateTableRelation = false;
            trigger OnValidate()
            var
                UC: Record "Unite colisage";
                EnteteCommande: Record "Sales Header";
            begin
                if "No. UC" <> '' then
                    if "No. UC" = '+' then begin
                        EnteteCommande.Get(EnteteCommande."Document Type"::Order, Rec."No. commande");
                        UC.Init();
                        UC."No." := '';
                        UC.Insert(true);
                        UC."No. client" := EnteteCommande."Sell-to Customer No.";
                        UC.Modify();
                        Rec."No. UC" := UC."No.";
                    end else begin
                        UC.Get("No. UC");
                        Rec."Type UC" := UC."Type UC";
                        Rec.Longueur := UC.Longueur;
                        rec.Largeur := UC.Largeur;
                        Rec.Hauteur := UC.Hauteur;
                        Rec.Dimensions := UC.Dimensions;
                        Rec."No. client" := UC."No. client";
                        Rec."Numero camion" := UC."Numero camion expedition";
                        Rec.Numerotation := UC.Numerotation;
                    end;
            end;

        }
        field(20; "Type UC"; Option)
        {
            Caption = 'Type UC';
            DataClassification = ToBeClassified;
            OptionMembers = " ",Palette,"Colis";
            OptionCaption = ' ,Palette,Colis';
        }

        field(25; "No. client"; Code[20])
        {
            Caption = 'N° client';
            DataClassification = ToBeClassified;
            TableRelation = Customer;
            trigger OnValidate()
            begin
                CalcFields("Nom client");
            end;
        }
        field(26; "Nom client"; Text[100])
        {
            Caption = 'Nom client';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("No. client")));
        }

        field(30; Numerotation; Code[10])
        {
            Caption = 'Numérotation';
            DataClassification = ToBeClassified;
        }
        field(40; "Numero camion"; Code[20])
        {
            Caption = 'Numéro camion';
            DataClassification = ToBeClassified;
        }
        field(42; Longueur; Integer)
        {
            Caption = 'Longueur';
            DataClassification = ToBeClassified;
            MinValue = 0;
            BlankZero = true;
            trigger OnValidate()
            begin
                if (Longueur <> 0) and (Largeur <> 0) and (Hauteur <> 0) then
                    Dimensions := format(Longueur) + 'x' + Format(Largeur) + 'x' + Format(Hauteur)
                else
                    Dimensions := '';
            end;
        }
        field(44; Largeur; Integer)
        {
            Caption = 'Largeur';
            DataClassification = ToBeClassified;
            MinValue = 0;
            BlankZero = true;
            trigger OnValidate()
            begin
                if (Longueur <> 0) and (Largeur <> 0) and (Hauteur <> 0) then
                    Dimensions := format(Longueur) + 'x' + Format(Largeur) + 'x' + Format(Hauteur)
                else
                    Dimensions := '';
            end;
        }
        field(46; Hauteur; Integer)
        {
            Caption = 'Hauteur';
            DataClassification = ToBeClassified;
            MinValue = 0;
            BlankZero = true;
            trigger OnValidate()
            begin
                if (Longueur <> 0) and (Largeur <> 0) and (Hauteur <> 0) then
                    Dimensions := format(Longueur) + 'x' + Format(Largeur) + 'x' + Format(Hauteur)
                else
                    Dimensions := '';
            end;
        }

        field(50; Dimensions; Text[20])
        {
            Caption = 'Dimensions';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(60; "Poids brut"; Decimal)
        {
            Caption = 'Poids brut';
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "No. commande", "No. UC")
        {
            Clustered = true;
        }
        key(MyKey1; "No. client")
        {

        }
        key(MyKey2; "No. UC")
        {
            
        }

    }

    fieldgroups
    {
        fieldgroup(DropDown; "No. commande", Dimensions, Numerotation, "Numero camion")
        {

        }
    }

    trigger OnDelete()
    var
        PrepaColisage: Record "UC Commande";
        ContenuColisage: Record "Contenu colisage";
        UC: Record "Unite colisage";
        PaletteVide: Boolean;
    begin
        //Si on supprime une UC des UC de la commande, il faut vérifier si cette UC apparait est utilisée dans d'autres commandes.
        //S'il n'y a pas d'autre commande sur l'UC, on peut supprimer l'UC de la liste des UC.
        PrepaColisage.SetCurrentKey("No. UC");
        PrepaColisage.SetRange("No. UC",Rec."No. UC");
        PrepaColisage.SetFilter("No. commande",'<>%1',Rec."No. commande");
        PaletteVide := PrepaColisage.IsEmpty();

        if PaletteVide then begin
            ContenuColisage.SetCurrentKey("No. UC");
            ContenuColisage.SetRange("No. UC",Rec."No. UC");
            PaletteVide := ContenuColisage.IsEmpty;
        end;

        if PaletteVide then begin
            UC.Get("No. UC");
            UC.Delete();
        end;
    end;

    trigger OnInsert()
    var
        UC: Record "Unite colisage";
        EnteteCommande: Record "Sales Header";
    begin
        SalesSetup.Get();
        SalesSetup.TestField("No. UC");
        NoSeriesMgt.InitSeries(SalesSetup."No. UC", '', 0D, "No. UC", codFiller);
        EnteteCommande.Get(EnteteCommande."Document Type"::order,"No. commande");
        Rec."No. client" := EnteteCommande."Sell-to Customer No.";
    end;

    trigger OnModify()
    var
        UC: Record "Unite colisage";
    begin
        //A chaque fois qu'on crée une nouvelle palette dans une commande, on crée la palette dans la liste generale des palettes
        //(pour pouvoir ensuite la choisir dans une autre commande)
        if not UC.Get("No. UC") then begin
            UC.Init();
            UC.TransferFields(Rec);
            UC.Insert();
        end;
        UC.Longueur := Longueur;
        UC.Largeur := Largeur;
        UC.Hauteur := Hauteur;
        UC.Dimensions := Dimensions;
        UC.Numerotation := Numerotation;
        UC."Numero camion expedition" := "Numero camion";
        UC."Poids brut" := "Poids brut";
        UC."Type UC" := "Type UC";
        UC."No. client" := "No. client";
        UC.Modify();
    end;

    procedure ExtraireUCContainer()
    begin

    end;
    
    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        codFiller: Code[20];

}

