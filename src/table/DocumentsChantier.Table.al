table 50062 "Documents chantier"
{
    Caption = 'Documents chantier';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Liste documents chantier";
    //La liste des Commandes achat et Commandse vente de chaque Chantier est vidée et recrée chaque nuit après suppression des documents 
    //facturés (Codeunit50010 planifié)
    //La liste des documents validés d'un chantier se complète à chaque validation de document
    //Il reste ensuite les devis : ils s'ajoutent quand on lance un devis. Ils s'enlèvent quand on transforme un devis en commande.
    
    fields
    {
        field(10; "Code chantier"; Code[20])
        {
            Caption = 'Code chantier';
        }
        field(20; "Type document"; Option)
        {
            Caption = 'Type document';
            OptionMembers = " ","Commande achat","Facture achat","Avoir achat","Devis vente","Commande vente","Facture vente","Avoir vente";
            OptionCaption = ' ,Commande achat,Facture achat,Avoir achat,Devis vente,Commande vente,Facture vente,Avoir vente';
        }
        field(30; "No. document"; Code[20])
        {
            Caption = 'N° document';
            
        }
        field(40; Commentaires; Text[250])
        {
            Caption = 'Commentaires';
        }
        field(50; "Montant DS"; Decimal)
        {
            Caption = 'Montant DS';
        }
    }


    keys
    {
        key(PK; "Code chantier","Type document","No. document")
        {
            Clustered = true;
        }
    }

    procedure AfficherDocument()
    var
        EnteteAchat: Record "Purchase Header";
        EnteteVente: Record "Sales Header";
        EnteteFactureAchat: Record "Purch. Inv. Header";
        EnteteAvoirAchat: Record "Purch. Cr. Memo Hdr.";
        EnteteFactureVente: Record "Sales Invoice Header";
        EnteteAvoirVente: Record "Sales Cr.Memo Header";
    begin
        case
            "Type document" of
                Rec."Type document"::"Commande achat":
                        if EnteteAchat.get(EnteteAchat."Document Type"::order,Rec."No. document") then begin
                            EnteteAchat.SetRecFilter();
                            Page.Run(Page::"Purchase Order",EnteteAchat);
                        end;
                Rec."Type document"::"Facture achat":
                        if EnteteFactureAchat.get(Rec."No. document") then begin
                            EnteteFactureAchat.SetRecFilter();
                            Page.Run(Page::"Posted Purchase Invoice",EnteteFactureAchat);
                        end;
                Rec."Type document"::"Avoir achat":
                        if EnteteAvoirAchat.get(Rec."No. document") then begin
                            EnteteAvoirAchat.SetRecFilter();
                            Page.Run(Page::"Posted Purchase Credit Memo",EnteteAvoirAchat);
                        end;

                Rec."Type document"::"Devis vente":
                        if EnteteVente.get(EnteteVente."Document Type"::Quote,Rec."No. document") then begin
                            EnteteVente.SetRecFilter();
                            Page.Run(Page::"Sales Quote",EnteteVente);
                        end;

                Rec."Type document"::"Commande vente":
                        if EnteteVente.get(EnteteVente."Document Type"::Order,Rec."No. document") then begin
                            EnteteVente.SetRecFilter();
                            Page.Run(Page::"Sales Order",EnteteVente);
                        end;

                Rec."Type document"::"Facture vente":
                        if EnteteFactureVente.get(Rec."No. document") then begin
                            EnteteFactureVente.SetRecFilter();
                            Page.Run(Page::"Posted Sales Invoice",EnteteFactureVente);
                        end;
                
                Rec."Type document"::"Avoir vente":
                        if EnteteAvoirVente.get(Rec."No. document") then begin
                            EnteteAvoirVente.SetRecFilter();
                            Page.Run(Page::"Posted Sales Credit Memo",EnteteAvoirVente);
                        end;
        end;
    end;
}
