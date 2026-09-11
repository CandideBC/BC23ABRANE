codeunit 50013 AutresTriggersTable
{
    Permissions =
                tabledata "Sales Invoice Header" = rm, 
                tabledata "Sales Invoice line" = rm,
                tabledata "Sales Cr.Memo Header" = rm,
                tabledata "Sales Cr.Memo Line" = rm,
                tabledata "Cust. Ledger Entry" = rm,
                tabledata "Purch. Inv. Line" = rm;
    trigger OnRun()
    begin
    end;

    procedure CountryRegionOnAfterValidatePaysCodifab(Rec: Record "Country/Region";xRec: Record "Country/Region")
    var
        ParamVente : Record "Sales & Receivables Setup";
        EnteteFactureVente : Record "Sales Invoice Header";
        LigneFactureVente : Record "Sales Invoice Line";
        EnteteAvoirVente : Record "Sales Cr.Memo Header";
        Article : Record Item;
        LigneAvoirVente : record "Sales Cr.Memo Line";
    begin
                
        if Rec."Pays Codifab" <> xRec."Pays Codifab" then begin
            ParamVente.GET();
            ParamVente.TESTFIELD("% taxe Codifab");
            EnteteFactureVente.SETCURRENTKEY("Bill-to Country/Region Code");
            EnteteFactureVente.SETRANGE("Bill-to Country/Region Code",Rec.Code);
            if EnteteFactureVente.FINDSET(false) then
            repeat
                LigneFactureVente.SETRANGE("Document No.",EnteteFactureVente."No.");
                LigneFactureVente.SETRANGE(Type,LigneFactureVente.Type::Item);
                if LigneFactureVente.FINDSET(true) then
                repeat
                    if not Article.GET(LigneFactureVente."No.") then
                    Article.INIT();
                    if Rec."Pays Codifab" and Article.Codifab and not (EnteteFactureVente.ASS) and (STRPOS(EnteteFactureVente."No.",'SAV') = 0) then
                    LigneFactureVente."Montant taxe Codifab" := ROUND(ParamVente."% taxe Codifab" / 100 * LigneFactureVente."Montant ligne HT (DS)",0.01)
                    else
                    LigneFactureVente."Montant taxe Codifab" := 0;
        
                until LigneFactureVente.NEXT() = 0;
        
            until EnteteFactureVente.NEXT() = 0;
        
            EnteteAvoirVente.SETCURRENTKEY("Bill-to Country/Region Code");
            EnteteAvoirVente.SETRANGE("Bill-to Country/Region Code",Rec.Code);
            if EnteteAvoirVente.FINDSET(false) then
            repeat
                LigneAvoirVente.SETRANGE("Document No.",EnteteAvoirVente."No.");
                LigneAvoirVente.SETRANGE(Type,LigneAvoirVente.Type::Item);
                if LigneAvoirVente.FINDSET(true) then
                repeat
                    if not Article.GET(LigneAvoirVente."No.") then
                    Article.INIT();
                    if Rec."Pays Codifab" and Article.Codifab and not (EnteteAvoirVente.ASS) and (STRPOS(EnteteAvoirVente."No.",'SAV') = 0) then
                    LigneAvoirVente."Montant taxe Codifab" := ROUND(ParamVente."% taxe Codifab" / 100 * LigneAvoirVente."Montant ligne HT (DS)",0.01)
                    else
                    LigneAvoirVente."Montant taxe Codifab" := 0;
        
                until LigneAvoirVente.NEXT() = 0;
        
            until EnteteAvoirVente.NEXT() = 0;
        
        end;
    end;
    procedure GLAccountOnAfterValidateExclureRentabilite(Rec: Record "G/L Account";xRec: Record "G/L Account")
    var
        LigneFactVente: Record "Sales Invoice Line";
        LigneAvoirVente: Record "Sales Cr.Memo Line";
    begin
        //KAN.FHA 29/10/2021 DEBUT
        LigneFactVente.SETCURRENTKEY(Type,"No.");
        LigneFactVente.SETRANGE(Type,LigneFactVente.Type::"G/L Account");
        LigneFactVente.SETRANGE("No.",Rec."No.");
        LigneFactVente.MODIFYALL("Exclure de la rentabilite",Rec."Exclure de la rentabilite");
        //KAN.FHA 29/10/2021 FIN
        
        //KAN.FHA 29/10/2021 DEBUT
        LigneAvoirVente.SETCURRENTKEY(Type,"No.");
        LigneAvoirVente.SETRANGE(Type,LigneAvoirVente.Type::"G/L Account");
        LigneAvoirVente.SETRANGE("No.",Rec."No.");
        LigneAvoirVente.MODIFYALL("Exclure de la rentabilite",Rec."Exclure de la rentabilite");
        //KAN.FHA 29/10/2021 FIN
    end;

    procedure SalesInvoiceHeaderOnAfterValidatePaymentTermsCode(var Rec: Record "Sales Invoice Header")
    var
        PaymentTerms: Record "Payment Terms";
    begin
        if (Rec."Payment Terms Code" <> '') and (Rec."Document Date" <> 0D) then begin
            PaymentTerms.GET(Rec."Payment Terms Code");
            Rec."Due Date" := CALCDATE(PaymentTerms."Due Date Calculation",Rec."Document Date");
            Rec."Pmt. Discount Date" := CALCDATE(PaymentTerms."Discount Date Calculation",Rec."Document Date");
            Rec.VALIDATE("Due Date");
            Rec.VALIDATE("Pmt. Discount Date");
            Rec.Modify();
        end;
    end;

    procedure SalesInvoiceHeaderOnAfterValidateDueDate(Rec: Record "Sales Invoice Header")
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgEntry.SETRANGE("Document No.",Rec."No.");
        CustLedgEntry.SETFILTER("Document Type",'Invoice');
        CustLedgEntry.SETRANGE("Customer No.",Rec."Bill-to Customer No.");
        if CustLedgEntry.FINDSET(true) then begin
            CustLedgEntry."Due Date" := Rec."Due Date";
            CustLedgEntry.MODIFY();
        end;
    end;

    procedure SalesInvoiceHeaderOnAfterValidatePaymentDiscDate(Rec: Record "Sales Invoice Header")
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgEntry.SETRANGE("Document No.",Rec."No.");
        CustLedgEntry.SETFILTER("Document Type",'Invoice');
        CustLedgEntry.SETRANGE("Customer No.",Rec."Bill-to Customer No.");
        if CustLedgEntry.FINDSET(true) then begin
            CustLedgEntry."Pmt. Discount Date" := Rec."Pmt. Discount Date";
            CustLedgEntry.MODIFY();
        end;
    end;

    procedure SalesInvoiceHeaderOnAfterValidatePaymentMethodCode(Rec: Record "Sales Invoice Header")
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgEntry.SETRANGE("Document No.",Rec."No.");
        CustLedgEntry.SETFILTER("Document Type",'Invoice');
        CustLedgEntry.SETRANGE("Customer No.",Rec."Bill-to Customer No.");
        if CustLedgEntry.FINDSET(true) then begin
            CustLedgEntry."Payment Method Code" := Rec."Payment Method Code";
            CustLedgEntry.MODIFY();
        end;
    end;

    procedure SalesInvoiceHeaderOnAfterValidateAnneeCommande(Rec: Record "Sales Invoice Header";xRec: Record "Sales Invoice Header")
    var
        LigneFactVente: Record "Sales Invoice Line";
    begin
        if Rec."Annee commande" <> xRec."Annee commande" then begin
            LigneFactVente.SetRange("Document No.", Rec."No.");
            if LigneFactVente.FindSet(true) then
                repeat
                    LigneFactVente."Annee commande" := Rec."Annee commande";
                    LigneFactVente.Modify();
                until LigneFactVente.Next() = 0;
        end;
    end;

    procedure SalesInvoiceHeaderOnAfterValidateCodeGroupe(Rec: Record "Sales Invoice Header";xRec: Record "Sales Invoice Header")
    var
        LigneFactVente: Record "Sales Invoice Line";
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        //KAN.FHA 20/06/2020 DEBUT
        if Rec."Code groupe" <> xRec."Code groupe" then begin
            LigneFactVente.SETRANGE("Document No.",Rec."No.");
            if LigneFactVente.FINDSET(true) then
            repeat
                LigneFactVente."Code groupe" := Rec."Code groupe";
                LigneFactVente.MODIFY();
                LigneFactVente.VerifChampsAffaire();
            until LigneFactVente.NEXT() = 0;
        end;

        //KAN.FHA 10/09/2020 DEBUT
        CustLedgEntry.SETRANGE("Document No.",Rec."No.");
        CustLedgEntry.SETFILTER("Document Type",'Invoice');
        CustLedgEntry.SETRANGE("Customer No.",Rec."Bill-to Customer No.");
        if CustLedgEntry.FINDSET(true) then begin
            CustLedgEntry."Code groupe" := Rec."Code groupe";
            CustLedgEntry.MODIFY();
        end;
        //KAN.FHA 10/09/2020 FIN
    end;

    procedure SalesInvoiceHeaderOnAfterValidateCodeEnseigne(Rec: Record "Sales Invoice Header";xRec: Record "Sales Invoice Header")
    var
        Enseigne: Record Enseigne;
        LigneFactVente: Record "Sales Invoice Line";
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        //KAN.FHA 11/09/2020 DEBUT
        if (Rec."Code enseigne" <> '') and (Rec."Code groupe" = '') then begin
            Enseigne.Get(Rec."Code enseigne");
            Rec.Validate("Code groupe", Enseigne."Code groupe");
            Rec.Modify();
        end;
        //KAN.FHA 11/09/2020 FIN

        //KAN.FHA 20/06/2020 DEBUT
        if Rec."Code enseigne" <> xRec."Code enseigne" then begin
            LigneFactVente.SetRange(LigneFactVente."Document No.", Rec."No.");
            if LigneFactVente.FindSet(true) then
                repeat
                    LigneFactVente."Code enseigne" := Rec."Code enseigne";
                    LigneFactVente.Modify();
                    LigneFactVente.VerifChampsAffaire();
                until LigneFactVente.Next() = 0;
        end;

        //KAN.FHA 10/09/2020 DEBUT
        CustLedgEntry.SetRange("Document No.", Rec."No.");
        CustLedgEntry.SetFilter("Document Type", 'Invoice');
        CustLedgEntry.SetRange("Customer No.", Rec."Bill-to Customer No.");
        if CustLedgEntry.FindSet(true) then begin
            CustLedgEntry."Nouveau Code enseigne" := Rec."Code enseigne";
            CustLedgEntry.Modify();
        end;
        //KAN.FHA 10/09/2020 FIN 
    end;

    procedure SalesInvoiceHeaderOnAfterValidateCodeOperation(Rec: Record "Sales Invoice Header";xRec: Record "Sales Invoice Header")
    var
        LigneFactVente: Record "Sales Invoice Line";
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        //KAN.FHA 20/06/2020 DEBUT
        if Rec."Code operation" <> xRec."Code operation" then begin
            LigneFactVente.SetRange("Document No.", Rec."No.");
            if LigneFactVente.FindSet(true) then
                repeat
                    LigneFactVente."Code operation" := Rec."Code operation";
                    LigneFactVente.Modify();
                until LigneFactVente.Next() = 0;
        end;

        //KAN.FHA 10/09/2020 DEBUT
        CustLedgEntry.SetRange("Document No.", Rec."No.");
        CustLedgEntry.SetFilter("Document Type", 'Invoice');
        CustLedgEntry.SetRange("Customer No.", Rec."Bill-to Customer No.");
        if CustLedgEntry.FindSet(true) then begin
            CustLedgEntry."Code operation" := Rec."Code operation";
            CustLedgEntry.Modify();
        end;
        //KAN.FHA 10/09/2020 FIN
    end;

    procedure SalesInvoiceHeaderOnAfterValidateCodeChantier(Rec: Record "Sales Invoice Header";xRec: Record "Sales Invoice Header")
    var
        LigneFactVente: Record "Sales Invoice Line";
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        if Rec."Code chantier" <> xRec."Code chantier" then begin
            LigneFactVente.SetRange("Document No.", Rec."No.");
            if LigneFactVente.FindSet(true) then
                repeat
                    LigneFactVente."Code chantier" := Rec."Code chantier";
                    LigneFactVente.Modify();
                    LigneFactVente.VerifChampsAffaire();
                until LigneFactVente.Next() = 0;
        end;

        //KAN.FHA 10/09/2020 DEBUT
        CustLedgEntry.SetRange("Document No.", Rec."No.");
        CustLedgEntry.SetFilter("Document Type", 'Invoice');
        CustLedgEntry.SetRange("Customer No.", Rec."Bill-to Customer No.");
        if CustLedgEntry.FindSet(true) then begin
            CustLedgEntry."Code chantier" := Rec."Code chantier";
            CustLedgEntry.Modify();
        end;
        //KAN.FHA 10/09/2020 FIN
    end;

    procedure SalesInvoiceHeaderOnAfterValidateMontantDejaVerseTTC(Rec: Record "Sales Invoice Header";xRec: Record "Sales Invoice Header")
    var
        UserSetup: Record "User Setup";
        ModifMontantVerseErr: Label 'Vous n''avez pas les autorisations pour modifier ce champ.';
    begin

        //KAN.FHA 02/06/2021 DEBUT
        if not UserSetup.Get(UserId) then
            UserSetup.Init();

        if not UserSetup."Saisir montant deja verse" then
            Error(ModifMontantVerseErr);

        Rec.modify();
        //KAN.FHA 02/06/2021 FIN
    end;

    procedure SalesInvoiceLineOnAfterValidateCodeGroupe(Rec: Record "Sales Invoice Line")
    var
    begin
        Rec.VerifChampsAffaire();
    end;

    procedure SalesInvoiceLineOnAfterValidateCodeEnseigne(Rec: Record "Sales Invoice Line")
    var
    begin
        Rec.VerifChampsAffaire();
    end;

    procedure SalesInvoiceLineOnAfterValidateCodeChantier(Rec: Record "Sales Invoice Line")
    var
    begin
        Rec.VerifChampsAffaire();
    end;

    
    procedure SalesCrMemoHeaderOnAfterValidateCodeGroupe(Rec: Record "Sales Cr.Memo Header";xRec: Record "Sales Cr.Memo Header")
    var
        LigneAvoirVente: Record "Sales Cr.Memo Line";
        CustLedgEntry : Record "Cust. Ledger Entry";
        
    begin
                        //KAN.FHA 21/06/2020
        if Rec."Code groupe" <> xRec."Code groupe" then begin
            LigneAvoirVente.SetRange("Document No.", Rec."No.");
            if LigneAvoirVente.FindSet(true) then
                repeat
                    LigneAvoirVente."Code groupe" := Rec."Code groupe";
                    LigneAvoirVente.Modify();
                    LigneAvoirVente.VerifChampsAffaire();
                until LigneAvoirVente.Next() = 0;
        end;

        //KAN.FHA 10/09/2020 DEBUT
        CustLedgEntry.SetRange("Document No.", Rec."No.");
        CustLedgEntry.SetRange("Document Type", CustLedgEntry."Document Type"::"Credit Memo");
        CustLedgEntry.SetRange("Customer No.", Rec."Bill-to Customer No.");
        if CustLedgEntry.FindSet(true) then begin
            CustLedgEntry."Code groupe" := Rec."Code groupe";
            CustLedgEntry.Modify();
        end;
        //KAN.FHA 10/09/2020 FIN
    end;

    procedure SalesCrMemoHeaderOnAfterValidateCodeEnseigne(Rec: Record "Sales Cr.Memo Header";xRec: Record "Sales Cr.Memo Header")
    var
        Enseigne: Record Enseigne;
        LigneAvoirVente: Record "Sales Cr.Memo Line";
        CustLedgEntry: Record "Cust. Ledger Entry";

    begin
                        //KAN.FHA 11/09/2020 DEBUT
        if (Rec."Code enseigne" <> '') and (Rec."Code groupe" = '') then begin
            Enseigne.Get(Rec."Code enseigne");
            Rec.Validate("Code groupe", Enseigne."Code groupe");
        end;
        //KAN.FHA 11/09/2020 FIN

        //KAN.FHA 20/06/2020 DEBUT
        if Rec."Code enseigne" <> xRec."Code enseigne" then begin
            LigneAvoirVente.SetRange(LigneAvoirVente."Document No.", Rec."No.");
            if LigneAvoirVente.FindSet(true) then
                repeat
                    LigneAvoirVente."Code enseigne" := Rec."Code enseigne";
                    LigneAvoirVente.Modify();
                    LigneAvoirVente.VerifChampsAffaire();
                until LigneAvoirVente.Next() = 0;
        end;

        //KAN.FHA 10/09/2020 DEBUT
        CustLedgEntry.SetRange("Document No.", Rec."No.");
        CustLedgEntry.SetRange("Document Type", CustLedgEntry."Document Type"::"Credit Memo");
        CustLedgEntry.SetRange("Customer No.", Rec."Bill-to Customer No.");
        if CustLedgEntry.FindSet(true) then begin
            CustLedgEntry."Nouveau Code enseigne" := Rec."Code enseigne";
            CustLedgEntry.Modify();
        end;
        //KAN.FHA 10/09/2020 FIN
    end;

    procedure SalesCrMemoHeaderOnAfterValidateCodeOperation(Rec: Record "Sales Cr.Memo Header";xRec: Record "Sales Cr.Memo Header")
    var
        LigneAvoirVente: Record "Sales Cr.Memo Line";
        CustLedgEntry : Record "Cust. Ledger Entry";

    begin
                        //KAN.FHA 20/06/2020 DEBUT
        if Rec."Code operation" <> xRec."Code operation" then begin
            LigneAvoirVente.SetRange("Document No.", Rec."No.");
            if LigneAvoirVente.FindSet(true) then
                repeat
                    LigneAvoirVente."Code operation" := Rec."Code operation";
                    LigneAvoirVente.Modify();
                until LigneAvoirVente.Next() = 0;
        end;

        //KAN.FHA 10/09/2020 DEBUT
        CustLedgEntry.SetRange("Document No.", Rec."No.");
        CustLedgEntry.SetRange("Document Type", CustLedgEntry."Document Type"::"Credit Memo");
        CustLedgEntry.SetRange("Customer No.", Rec."Bill-to Customer No.");
        if CustLedgEntry.FindSet(true) then begin
            CustLedgEntry."Code operation" := Rec."Code operation";
            CustLedgEntry.Modify();
        end;
        //KAN.FHA 10/09/2020 FIN
    end;

    procedure SalesCrMemoHeaderOnAfterValidateCodeChantier(Rec: Record "Sales Cr.Memo Header";xRec: Record "Sales Cr.Memo Header")
    var
        LigneAvoirVente: Record "Sales Cr.Memo Line";
        CustLedgEntry : Record "Cust. Ledger Entry";

    begin
        if Rec."Code chantier" <> xRec."Code chantier" then begin
            LigneAvoirVente.SetRange("Document No.", Rec."No.");
            if LigneAvoirVente.FindSet(true) then
                repeat
                    LigneAvoirVente."Code chantier" := Rec."Code chantier";
                    LigneAvoirVente.Modify();
                    LigneAvoirVente.VerifChampsAffaire();
                until LigneAvoirVente.Next() = 0;
        end;

        //KAN.FHA 10/09/2020 DEBUT
        CustLedgEntry.SetRange("Document No.", Rec."No.");
        CustLedgEntry.SetRange("Document Type", CustLedgEntry."Document Type"::"Credit Memo");
        CustLedgEntry.SetRange("Customer No.", Rec."Bill-to Customer No.");
        if CustLedgEntry.FindSet(true) then begin
            CustLedgEntry."Code chantier" := Rec."Code chantier";
            CustLedgEntry.Modify();
        end;
        //KAN.FHA 10/09/2020 FIN
    end;

    procedure PurchInvoiceHeaderOnValidateAnneeCommande(Rec: Record "Purch. Inv. Header")
    var
        LigneFactAchat: Record "Purch. Inv. Line";
    begin
        LigneFactAchat.SetRange("Document No.", Rec."No.");
        if LigneFactAchat.FindSet(true) then
            repeat
                LigneFactAchat."Annee commande" := Rec."Annee commande";
                LigneFactAchat.Modify();
            until LigneFactAchat.Next() = 0;
    end;

    procedure PurchInvoiceHeaderOnValidateCodeGroupe(Rec: Record "Purch. Inv. Header")
    var
        LigneFactAchat: Record "Purch. Inv. Line";
    begin
        LigneFactAchat.SetRange("Document No.", Rec."No.");
        if LigneFactAchat.FindSet(true) then
            repeat
                LigneFactAchat."Code groupe" := Rec."Code groupe";
                LigneFactAchat.Modify();
            until LigneFactAchat.Next() = 0;
    end;
    procedure PurchInvoiceHeaderOnValidateCodeEnseigne(Rec: Record "Purch. Inv. Header")
    var
        LigneFactAchat: Record "Purch. Inv. Line";
    begin
        LigneFactAchat.SetRange("Document No.", Rec."No.");
        if LigneFactAchat.FindSet(true) then
            repeat
                LigneFactAchat."Code enseigne" := Rec."Code enseigne";
                LigneFactAchat.Modify();
            until LigneFactAchat.Next() = 0;
    end;

    procedure PurchInvoiceHeaderOnValidateCodeOperation(Rec: Record "Purch. Inv. Header")
    var
        LigneFactAchat: Record "Purch. Inv. Line";
    begin
        LigneFactAchat.SetRange("Document No.", Rec."No.");
        if LigneFactAchat.FindSet(true) then
            repeat
                LigneFactAchat."Code operation" := Rec."Code operation";
                LigneFactAchat.Modify();
            until LigneFactAchat.Next() = 0;
    end;

    procedure PurchInvoiceHeaderOnValidateCodeChantier(Rec: Record "Purch. Inv. Header")
    var
        LigneFactAchat: Record "Purch. Inv. Line";
    begin
        LigneFactAchat.SetRange("Document No.", Rec."No.");
        if LigneFactAchat.FindSet(true) then
            repeat
                LigneFactAchat."Code chantier" := Rec."Code chantier";
                LigneFactAchat.Modify();
            until LigneFactAchat.Next() = 0;
    end;    

    procedure PurchInvoiceHeaderOnValidateAchatPourStock(Rec: Record "Purch. Inv. Header")
    var
        LigneFactAchat: Record "Purch. Cr. Memo Line";
    begin
        LigneFactAchat.Reset();
        LigneFactAchat.SetRange("Document No.", Rec."No.");
        if LigneFactAchat.FindSet(true) then
            repeat
                if LigneFactAchat."No." <> '' then begin
                    LigneFactAchat."Achat pour stock" := Rec."Achat pour stock";
                    LigneFactAchat.Modify();
                end;
            until LigneFactAchat.Next() = 0;
    end;

        procedure PurchCrMemoHeaderOnValidateCodeGroupe(Rec: Record "Purch. Cr. Memo Hdr.")
    var
        LigneAvoirAchat: Record "Purch. Cr. Memo Line";
    begin
        LigneAvoirAchat.SetRange("Document No.", Rec."No.");
        if LigneAvoirAchat.FindSet(true) then
            repeat
                LigneAvoirAchat."Code groupe" := Rec."Code groupe";
                LigneAvoirAchat.Modify();
            until LigneAvoirAchat.Next() = 0;
    end;
    procedure PurchCrMemoHeaderOnValidateCodeEnseigne(Rec: Record "Purch. Cr. Memo Hdr.")
    var
        LigneAvoirAchat: Record "Purch. Cr. Memo Line";
    begin
        LigneAvoirAchat.SetRange("Document No.", Rec."No.");
        if LigneAvoirAchat.FindSet(true) then
            repeat
                LigneAvoirAchat."Code enseigne" := Rec."Code enseigne";
                LigneAvoirAchat.Modify();
            until LigneAvoirAchat.Next() = 0;
    end;

    procedure PurchCrMemoHeaderOnValidateCodeOperation(Rec: Record "Purch. Cr. Memo Hdr.")
    var
        LigneAvoirAchat: Record "Purch. Cr. Memo Line";
    begin
        LigneAvoirAchat.SetRange("Document No.", Rec."No.");
        if LigneAvoirAchat.FindSet(true) then
            repeat
                LigneAvoirAchat."Code operation" := Rec."Code operation";
                LigneAvoirAchat.Modify();
            until LigneAvoirAchat.Next() = 0;
    end;

    procedure PurchCrMemoHeaderOnValidateCodeChantier(Rec: Record "Purch. Cr. Memo Hdr.")
    var
        LigneAvoirAchat: Record "Purch. Cr. Memo Line";
    begin
        LigneAvoirAchat.SetRange("Document No.", Rec."No.");
        if LigneAvoirAchat.FindSet(true) then
            repeat
                LigneAvoirAchat."Code chantier" := Rec."Code chantier";
                LigneAvoirAchat.Modify();
            until LigneAvoirAchat.Next() = 0;
    end;    

    procedure PurchCrMemoHeaderOnValidateAchatPourStock(Rec: Record "Purch. Cr. Memo Hdr.")
    var
        LigneAvoirAchat: Record "Purch. Cr. Memo Line";
        AchatPourStockOuChantierQst: Label 'Un achat pour stock ne peut pas être affecté à un chantier. Le système va vider le Code chantier. Confirmez-vous ?';
        OperationInterrompueErr: Label 'Opération interrompue à la demande de l''utilisateur.';
    begin
        if Rec."Achat pour stock" and (Rec."Code chantier" <> '') then
            if CONFIRM(AchatPourStockOuChantierQst) then
                Rec.VALIDATE("Code chantier",'')
            else
                ERROR(OperationInterrompueErr);

        LigneAvoirAchat.RESET();
        LigneAvoirAchat.SETRANGE("Document No.",Rec."No.");
        if LigneAvoirAchat.FINDSET(true) then
            repeat
                 if LigneAvoirAchat."No." <> '' then begin
                    LigneAvoirAchat."Achat pour stock" := Rec."Achat pour stock";
                    LigneAvoirAchat.MODIFY();
                end;
            until LigneAvoirAchat.NEXT() = 0;
    end;

}
