page 50150 "Sous-form document OCR Vente"
{
    PageType = ListPart;
    SourceTable = "Ligne OCR vente";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ID ligne document OCR";Rec."ID ligne document OCR")
                {
                }
                field("Reference article client"; Rec."Reference article client")
                {
                    ApplicationArea = All;
                }
                field("No. article BC"; Rec."No. article BC")
                {
                    ApplicationArea = All;
                }
                
                
                /*
                field("Code variante"; Rec."Code variante")
                {
                }
                */
                field("Designation article OCR"; Rec."Designation article OCR")
                {
                }
                field("Designation article BC"; Rec."Designation article BC")
                {
                }
                /*
                field("Designation variante NAV"; Rec."Designation variante NAV")
                {
                }
                */
                field(Quantite; Rec.Quantite)
                {
                }
                field(Unite;Rec.Unite)
                {
                }
                field("Article bloque"; Rec."Article bloque")
                {
                }
                field("Prix unitaire OCR"; Rec."Prix unitaire OCR")
                {
                }
                field("% remise ligne"; Rec."% remise ligne")
                {
                }
                field("Montant ligne HT (OCR)"; Rec."Montant ligne HT (OCR)")
                {
                }
                field("Alerte stock"; Rec."Alerte stock")
                {
                }
            }
        }
    }

    actions
    {
    }
}

