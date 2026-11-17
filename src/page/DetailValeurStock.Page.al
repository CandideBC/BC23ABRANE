page 50066 "Detail valeur stock PMP"
{
    PageType = List;
    SourceTable = "Detail valeur stock a date";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. article"; Rec."No. article")
                {
                }
                field("No. ecriture article"; Rec."No. ecriture article")
                {
                }
                field("Type document"; Rec."Type document")
                {
                }
                field("Date comptabilisation"; Rec."Date comptabilisation")
                {
                }
                field("Factures manquantes"; Rec."Factures manquantes")
                {
                }
                field(Quantite; Rec.Quantite)
                {
                }
                field("Cout unitaire"; Rec."Cout unitaire")
                {
                }
                field("Cout total"; Rec."Cout total")
                {
                }
            }
        }
    }

    actions
    {
    }
}

