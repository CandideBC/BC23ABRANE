table 50039 "Parametrage articles Codifab"
{
    // KAN.FHA 14/10/2020
    //   Les articles dont la combinaison [Code matiere]-[Code taxe Eco-mobilier] se trouvent dans cette table seront automatiquement cochés "Codifab" et pourront
    //   générer calcul de la taxe Codifab (en fonction du pays de facturation).

    Caption = 'Paramétrage articles Codifab';

    fields
    {
        field(10; "Code matiere"; Code[20])
        {
            Caption = 'Code matière';
            NotBlank = true;
            TableRelation = Matiere;

            trigger OnValidate()
            begin
                if (xRec."Code matiere" <> '') and ("Code taxe eco-mobilier" <> '') then
                    MAJArticle(xRec."Code matiere", "Code taxe eco-mobilier", 1); //Decocher

                if ("Code matiere" <> '') and ("Code taxe eco-mobilier" <> '') then
                    MAJArticle("Code matiere", "Code taxe eco-mobilier", 0); //Cocher
            end;
        }
        field(20; "Code taxe eco-mobilier"; Code[10])
        {
            Caption = 'Code taxe éco-mobilier';
            NotBlank = true;
            TableRelation = "Taxe eco-mobilier";

            trigger OnValidate()
            begin
                if (xRec."Code taxe eco-mobilier" <> '') and ("Code matiere" <> '') then
                    MAJArticle("Code matiere", xRec."Code taxe eco-mobilier", 1); //Decocher

                if ("Code matiere" <> '') and ("Code taxe eco-mobilier" <> '') then
                    MAJArticle("Code matiere", "Code taxe eco-mobilier", 0); //Cocher
            end;
        }
        field(25; "Filtre date"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(30; "Montant Codifab factures"; Decimal)
        {
            CalcFormula = sum ("Sales Invoice Line"."Montant taxe Codifab" where ("Code matiere article" = field ("Code matiere"),
                                                                                 "Eco Tax Furniture Code" = field ("Code taxe eco-mobilier"),
                                                                                 "Posting Date" = field ("Filtre date")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(40; "Montant Codifab avoirs"; Decimal)
        {
            CalcFormula = sum ("Sales Cr.Memo Line"."Montant taxe Codifab" where ("Code matiere article" = field ("Code matiere"),
                                                                                 "Eco Tax Furniture Code" = field ("Code taxe eco-mobilier"),
                                                                                 "Posting Date" = field ("Filtre date")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Code matiere", "Code taxe eco-mobilier")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        MAJArticle("Code matiere", "Code taxe eco-mobilier", 1); //Décocher
    end;

    trigger OnRename()
    begin
        Error(RenommerInterditErr);
    end;

    var
        Article: Record Item;
        RenommerInterditErr: Label 'Vous ne pouvez pas renommer, supprimez la ligne et recréez-la.';

    procedure MAJArticle(pCodeMatiere: Code[20]; pCodeTaxeEcoMobilier: Code[10]; pAction: Option Cocher,"Décocher")
    begin
        Article.SetCurrentKey("Code matiere", "Eco Tax Furniture Code");
        Article.SetRange(Article."Code matiere", "Code matiere");
        Article.SetRange("Eco Tax Furniture Code", "Code taxe eco-mobilier");
        if Article.FindSet(true) then
            repeat
                Article.Validate(Codifab, (pAction = pAction::Cocher));
                Article.Modify();
            until Article.Next() = 0;
    end;
}

