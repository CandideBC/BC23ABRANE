page 50059 "Suivi SAV Fournisseur"
{
    CardPageID = "Posted Purchase Receipt";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Purch. Rcpt. Header";
    SourceTableView = SORTING ("SAV Type", "Vu controle SAV / Avoir") WHERE ("SAV Type"=CONST(FOURNISSEUR), "Vu controle SAV / Avoir"=CONST(false), "Commande en container"=CONST(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field("Order No."; Rec."Order No.")
                {
                    Editable = false;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    Editable = false;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    Editable = false;
                }
                field(Comments; Rec.Comments)
                {
                    Editable = false;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    Editable = false;
                }
                field("Commentaire AIE"; Rec."Commentaire AIE")
                {
                    Editable = false;
                }
                field("Vu controle SAV / Avoir"; Rec."Vu controle SAV / Avoir")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnModifyRecord(): Boolean
    begin
        //KAN.FHA 24/03/2022 DEBUT
        CODEUNIT.RUN(CODEUNIT::"Purch. Rcpt. Header - Edit", Rec);
        EXIT(FALSE);
        //KAN.FHA 24/03/2022 FIN
    end;
}

