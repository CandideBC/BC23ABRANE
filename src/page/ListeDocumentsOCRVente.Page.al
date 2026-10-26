page 50148 "Liste documents OCR Vente"
{
    CardPageID = "Fiche document OCR Vente";
    Editable = false;
    PageType = List;
    SourceTable = "Entete OCR vente";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater("Général")
            {
                field("No."; Rec."No.")
                {
                }
                field("Document OCR traite"; Rec."Document OCR traite")
                {
                }
                field("No. document NAV"; Rec."No. document NAV")
                {
                }
                field("Date OCRisation"; Rec."Date OCRisation")
                {
                }
                field("Date document"; Rec."Date document")
                {
                }
                field("No. document client"; Rec."No. document client")
                {
                }
                field("No. donneur ordre"; Rec."No. donneur ordre")
                {
                }
                field("No. contact societe"; Rec."No. contact societe")
                {
                }
                field("No. contact personne"; Rec."No. contact personne")
                {
                }
                field("Nom client OCR"; Rec."Nom client OCR")
                {
                }
                field("Nom client 2 OCR"; Rec."Nom client 2 OCR")
                {
                }
                field("Adresse client OCR"; Rec."Adresse client OCR")
                {
                    //The property BlankZero is only supported on fields of type BigInteger, Boolean, Integer, Decimal, Duration, Enum, and Option.
                    //BlankZero = true;
                }
                field("Adresse client 2 OCR"; Rec."Adresse client 2 OCR")
                {
                    Caption = 'Montant HT calculé NAV';
                }
                field("Code postal client OCR"; Rec."Code postal client OCR")
                {
                }
                field("Ville client OCR"; Rec."Ville client OCR")
                {
                }
                field("Montant HT OCR"; Rec."Montant HT OCR")
                {
                }
                field("Montant port HT OCR"; Rec."Montant port HT OCR")
                {
                }
                field("Montant TVA OCR"; Rec."Montant TVA OCR")
                {
                }
                field("Total TTC OCR"; Rec."Total TTC OCR")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Montant HT NAV (hors port)");
        //MontantHTCalculeNAV := "Montant HT NAV (hors port)" + "Montant port HT";
    end;

    var
        MontantHTCalculeNAV: Decimal;
        TexteLigne: Text[30];
}

