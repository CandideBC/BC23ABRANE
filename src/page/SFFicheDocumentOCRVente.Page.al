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
                field("No. ligne"; Rec."No. ligne")
                {
                }
                field("No. article"; Rec."No. article")
                {
                }
                field("Code variante"; Rec."Code variante")
                {
                }
                field("Designation article OCR"; Rec."Designation article OCR")
                {
                }
                field("Designation article NAV"; Rec."Designation article NAV")
                {
                }
                field("Designation variante NAV"; Rec."Designation variante NAV")
                {
                }
                field(Quantite; Rec.Quantite)
                {
                }
                field("Code unite"; Rec."Code unite")
                {
                }
                field("Unite inconnue"; Rec."Unite inconnue")
                {
                    Editable = false;
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

