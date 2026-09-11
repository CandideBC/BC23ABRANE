page 50007 "Ecriture rentabilite"
{
    Caption = 'Ecriture rentabilité';
    Editable = false;
    PageType = List;
    SourceTable = "Ecriture rentabilite";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. sequence"; Rec."No. sequence")
                {
                    ApplicationArea = All;
                }
                field("Type ecriture"; Rec."Type ecriture")
                {
                    ApplicationArea = All;
                }
                field("Code chantier"; Rec."Code chantier")
                {
                    ApplicationArea = All;
                }
                field("Code groupe"; Rec."Code groupe")
                {
                    ApplicationArea = All;
                }
                field("Code enseigne"; Rec."Code enseigne")
                {
                    ApplicationArea = All;
                }
                field("Code operation"; Rec."Code operation")
                {
                    ApplicationArea = All;
                }
                field("Date comptabilisation"; Rec."Date comptabilisation")
                {
                    ApplicationArea = All;
                }
                field("Type document"; Rec."Type document")
                {
                    ApplicationArea = All;
                }
                field("No. document"; Rec."No. document")
                {
                    ApplicationArea = All;
                }
                field("No. ligne document"; Rec."No. ligne document")
                {
                    ApplicationArea = All;
                }
                field("Nature vente"; Rec."Nature vente")
                {
                    ApplicationArea = All;
                }
                field("Type de cout"; Rec."Type de cout")
                {
                    ApplicationArea = All;
                }
                field("Date compta. vente"; Rec."Date compta. vente")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Quantite; Rec.Quantite)
                {
                    ApplicationArea = All;
                }
                field("Cout total prevu (qte fact)"; Rec."Cout total prevu (qte fact)")
                {
                    ApplicationArea = All;
                }
                field("Cout total reel (qte fact)"; Rec."Cout total reel (qte fact)")
                {
                    ApplicationArea = All;
                }
                field("Montant unitaire (DS)"; Rec."Montant unitaire (DS)")
                {
                    ApplicationArea = All;
                }
                field("Montant total (DS)"; Rec."Montant total (DS)")
                {
                    ApplicationArea = All;
                }
                field("Cout fige"; Rec."Cout fige")
                {
                    ApplicationArea = All;
                }
                field("Cout fige par"; Rec."Cout fige par")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Corriger coût unitaire")
            {
                Caption = 'Corriger coût unitaire';
                Image = UpdateUnitCost;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    EcritureRenta.Get(rec."No. sequence");
                    EcritureRenta.CopyFilters(Rec);
                    EcritureRenta.SetRange("Type de cout", EcritureRenta."Type de cout"::Stock);
                    PAGE.Run(50056, EcritureRenta);
                end;
            }
        }
    }

    var
        EcritureRenta: Record "Ecriture rentabilite";
}

