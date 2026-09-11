report 50072 "Extraire DEB Achats"
{
    // //Les articles dont le code douanier est 99999999 ne sont pas des articles à déclarer, ce sont des prestations dont les montants doivent etre saupoudrés sur les vrais articles
    // //Dans un premier temps, on va extraire toutes les lignes de la facture (et rassembler les différentes informations), que la ligne soit un article ou une prestation.
    // //Plus tard, on ira voir pour chaque facture extraire si on a des lignes de vrais articles (nomenclature <> 999999) ou non.
    // //  Si une facture a des articles et des prestations, on saupoudre les prestations sur le montant des articles
    // //  Si une facture n'a que des articles de prestations, on garde les lignes car cela sera analysé et traité manuellement
    // 
    // //Exemple : on a vendu 10 tables à 100 EUR pièces (de nomenclature douanière 789456123).
    // //Sur la meme facture, on a acheté la pose de ces tables pour 500Eur. La pose consiste en un article dont le code douanier est 999999 qui ne doit pas etre declaré.
    // //On va alors declarer sur la DEB l'achat de 10 tables à 150Eur.

    ProcessingOnly = true;

    dataset
    {
        dataitem("Country/Region"; "Country/Region")
        {
            DataItemTableView = sorting ("Intrastat Code") where ("Intrastat Code" = filter (<> ''));
            dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
            {
                DataItemLink = "Pay-to Country/Region Code" = field (Code);
                DataItemTableView = sorting ("Concernee DEB", "Periode validation DEB", "Posting Date") where ("Concernee DEB" = const (true), "Periode validation DEB" = filter (0D));
                dataitem("Sales Invoice Line"; "Sales Invoice Line")
                {
                    DataItemLink = "Document No." = field ("No.");

                    trigger OnAfterGetRecord()
                    begin
                        if "Linked to line" <> 0 then
                            CurrReport.Skip();

                        if Quantity = 0 then
                            CurrReport.Skip();

                        if "Ligne deduction acompte" then
                            CurrReport.Skip();

                        CodeDouanier := '';

                        if Type = Type::Item then begin
                            if "Nomenclature produits" <> '' then
                                CodeDouanier := "Nomenclature produits"
                            else begin
                                if not Item.Get("No.") then
                                    Item.Init();
                                CodeDouanier := Item."Tariff No.";

                            end;
                        end else 
                            CodeDouanier := CodeDouanierFictif;
                        

                        LigneDEB.Init();
                        LigneDEB."Date debut periode comptable" := DateDEB;
                        LigneDEB."Type ligne DEB" := LigneDEB."Type ligne DEB"::"Réception";
                        LigneDEB.Date := "Purch. Inv. Header"."Posting Date";
                        LigneDEB."Type document" := LigneDEB."Type document"::Facture;
                        LigneDEB."No. document" := "Document No.";
                        LigneDEB."No. ligne document" := "Line No.";
                        LigneDEB."Country/Region Code" := "Purch. Inv. Header"."Buy-from Country/Region Code";
                        LigneDEB."Transaction Type" := "Transaction Type";
                        LigneDEB."Transport Method" := "Transport Method";
                        LigneDEB."Item No." := "No.";
                        LigneDEB."Entry/Exit Point" := "Exit Point";
                        LigneDEB.Area := Area;
                        LigneDEB."Transaction Specification" := "Transaction Specification";
                        LigneDEB."Shipment Method Code" := "Purch. Inv. Header"."Shipment Method Code";
                        LigneDEB."VAT Registration No." := Fournisseur."VAT Registration No.";
                        LigneDEB."Tariff No." := CodeDouanier;
                        if LigneDEB."Tariff No." = CodeDouanierFictif then
                            LigneDEB."Code douanier fictif" := true;
                        LigneDEB."No. nomenclature reduit" := CopyStr(LigneDEB."Tariff No.", 1, 8);

                        if Type = Type::Item then begin
                            if not Item.Get("No.") then
                                Item.Init();

                            if LigneDEB."Tariff No." <> '' then begin
                                TariffNumber.Get(LigneDEB."Tariff No.");
                                LigneDEB."Item Description" := TariffNumber.Description;
                                //LigneDEB."Supplementary Units" := TariffNumber."Supplementary Units";
                            end else
                                LigneDEB."Item Description" := '';

                            if Item."Miscellaneous Item" then begin
                                LigneDEB.Name := Description;
                                LigneDEB."Country/Region of Origin Code" := "Country/Region of Origin Code";
                            end else begin
                                LigneDEB.Name := Item.Description;
                                LigneDEB."Country/Region of Origin Code" := Item."Country/Region of Origin Code";
                            end;

                            LigneDEB."Net Weight" := "Net Weight";
                            LigneDEB.Quantity := Round(Quantity, 0.00001);
                            LigneDEB."Total Weight" := Round(LigneDEB."Net Weight" * LigneDEB.Quantity, 0.00001);

                            if (LigneDEB."Total Weight" > 0) and (LigneDEB."Total Weight" < 1) then
                                LigneDEB."Total Weight" := 1;

                            if LigneDEB."Transaction Type" = '' then
                                LigneDEB."Transaction Type" := '11';
                            if LigneDEB."Transport Method" = '' then
                                LigneDEB."Transport Method" := '3';
                            if LigneDEB."Transaction Specification" = '' then
                                LigneDEB."Transaction Specification" := '21';

                            if (LigneDEB."Tariff No." <> '') and (LigneDEB."Item Description" = '') then begin
                                TariffNumber.Get(LigneDEB."Tariff No.");
                                LigneDEB."Item Description" := TariffNumber.Description;
                            end;

                        end;

                        if LigneDEB."Tariff No." = CodeDouanierFictif then
                            LigneDEB.Validate("Montants autres (ligne)", "Sales Invoice Line".Amount)
                        else
                            LigneDEB.Validate("Montant marchandise (ligne)", "Sales Invoice Line".Amount);

                        LigneDEB.Insert();


                    end;
                }

                trigger OnAfterGetRecord()
                var
                    
                begin
                    //if "Purch. Inv. Header"."Facture acompte" then
                    //    CurrReport.Skip();

                    Fournisseur.Get("Buy-from Vendor No.");
                end;

                trigger OnPreDataItem()
                begin
                    SetRange("Purch. Inv. Header"."Posting Date", 0D, DateComptaMax);
                end;
            }
            dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
            {
                DataItemLink = "Pay-to Country/Region Code" = field (Code);
                DataItemTableView = sorting("Concerne DEB", "Periode validation DEB") where ("Concerne DEB" = const (true), "Periode validation DEB" = filter (0D));

                //DataItemTableView = sorting ("Ship-to Country/Region Code", "Concerne DEB", "Periode validation DEB", "Posting Date") where ("Concerne DEB" = const (true), "Periode validation DEB" = filter (0D));
                dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
                {
                    DataItemLink = "Document No." = field ("No.");

                    trigger OnAfterGetRecord()
                    begin
                        if Quantity = 0 then
                            CurrReport.Skip();
                    end;
                }

                trigger OnPreDataItem()
                begin
                    SetRange("Posting Date", 0D, DateComptaMax);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //Ne pas prendre les francais
                if "Country/Region".Code = InfoSoc."Country/Region Code" then
                    CurrReport.Skip();
            end;

            trigger OnPostDataItem()
            begin
                Commit(); //On n'a fait qu'extraire les lignes de facture et avoirs.
            end;
        }
        dataitem("Ligne DEB"; "Ligne DEB")
        {
            DataItemTableView = sorting ("Date debut periode comptable", "Type ligne DEB", "Type document", "No. document", "No. ligne document") where ("Type ligne DEB" = const (Réception), "Type document" = const (Facture));

            trigger OnAfterGetRecord()
            begin
                if "Ligne DEB"."No. document" <> NumDoc then begin
                    EnteteFacture.Get("No. document");
                    EnteteFacture.CalcFields("DEB : que des 999999", Amount, "DEB : montant 999999");
                    QueDesLignes999999 := EnteteFacture."DEB : que des 999999";
                    MontantDes999999 := EnteteFacture."DEB : montant 999999";
                    MontantTotalDocument := EnteteFacture.Amount;
                    //MontantTotalDocument := EnteteFacture.Amount - EnteteFacture.MontantAcompte();
                    PlusGrosMontantLigne := 0;
                    NumLignePlusGrosMontant := 0;
                    TotalMontantsAutresSaupoudre := 0;
                end;

                //Si toutes les lignes de la facture sont des codes douaniers 999999, on ne va pas saupoudrer leur montant sur d'autres lignes et on ne va pas les supprimer
                //Si on a des lignes 999999 et des autres, on saupoudre les montants des 999999 sur les autres puis on supprimera les lignes 9999999
                if (MontantDes999999 <> 0) and (not QueDesLignes999999) then 
                    if not "Ligne DEB"."Code douanier fictif" then begin
                        //Si on a un ecart d'arrondi à la fin, on le mettra sur la ligne ayant le plus gros montant de marchandise
                        if "Ligne DEB"."Montant marchandise (ligne)" >= PlusGrosMontantLigne then begin //>= et non > car si on n'a qu"une ligne de marchandise remisée à zéro, on aurait aucune ligne sur laquelle saupoudrer
                            PlusGrosMontantLigne := "Ligne DEB"."Montant marchandise (ligne)";
                            NumLignePlusGrosMontant := "Ligne DEB"."No. ligne document";
                        end;

                        "Ligne DEB".Validate("Montants autres (ligne)", Round("Ligne DEB"."Montant marchandise (ligne)" / MontantTotalDocument * MontantDes999999, 0.01));
                        "Ligne DEB".Modify();

                        TotalMontantsAutresSaupoudre := TotalMontantsAutresSaupoudre + "Ligne DEB"."Montants autres (ligne)";

                        //Si on est sur la la derniere ligne de la facture, on peut affecter l'ecart d'arrondi à la ligne de plus gros montant de marchandise
                        CalcFields("Ligne DEB"."Num Derniere ligne facture");
                        if "Ligne DEB"."No. ligne document" = "Ligne DEB"."Num Derniere ligne facture" then
                            if TotalMontantsAutresSaupoudre <> MontantDes999999 then begin
                                LigneDEBPourEcartArrondi.Get("Date debut periode comptable", "Type ligne DEB", "No. document", NumLignePlusGrosMontant);
                                LigneDEBPourEcartArrondi.Validate("Montants autres (ligne)", LigneDEBPourEcartArrondi."Montants autres (ligne)" + (MontantDes999999 - TotalMontantsAutresSaupoudre));
                                LigneDEBPourEcartArrondi.Modify();
                            end;
                        //On peut supprimer les lignes
                        LigneDEBPourSuppression.Reset();
                        LigneDEBPourSuppression.SetCurrentKey("Type ligne DEB", "Type document", "No. document", "Code douanier fictif", "No. ligne document");
                        LigneDEBPourSuppression.SetRange("Type ligne DEB", "Type ligne DEB");
                        LigneDEBPourSuppression.SetRange("Type document", "Type document");
                        LigneDEBPourSuppression.SetRange("No. document", "No. document");
                        LigneDEBPourSuppression.SetRange("Code douanier fictif", true);
                        LigneDEBPourSuppression.DeleteAll();
                    end;
                

                NumDoc := "Ligne DEB"."No. document";
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Date debut periode comptable", DateDEB);

                NumDoc := '';
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    var
        
        
        
        

    begin
    end;

    trigger OnPreReport()
    begin
        if DateDEB = 0D then
            Error(AucunePeriodeOuverteErr);

        InfoSoc.Get();

        LigneDEB.SetRange("Date debut periode comptable", DateDEB);
        LigneDEB.SetRange("Type ligne DEB",LigneDEB."Type ligne DEB"::"Réception");
        LigneDEB.DeleteAll();

        DateComptaMax := CalcDate('<+1M-1D>', DateDEB);

        CodeDouanierFictif := '99999999';
    end;

    var
        Item: Record Item;
        LigneDEB: Record "Ligne DEB";
        Fournisseur: Record Vendor;
        InfoSoc: Record "Company Information";
        EnteteFacture: Record "Sales Invoice Header";
        TariffNumber: Record "Tariff Number";
        LigneDEBPourEcartArrondi: Record "Ligne DEB";
        LigneDEBPourSuppression: Record "Ligne DEB";        AucunePeriodeOuverteErr: Label 'Aucune période comptable n''a été trouvée pour laquelle la DEB n''ait pas déjà été validée.';
    
        
        DateDEB: Date;
        CodeDouanier: Text[20];
        CodeDouanierFictif: Text[20];
        NumDoc: Code[20];
        
        QueDesLignes999999: Boolean;
        MontantTotalDocument: Decimal;
        NumLignePlusGrosMontant: Integer;
        PlusGrosMontantLigne: Decimal;
        MontantDes999999: Decimal;
        TotalMontantsAutresSaupoudre: Decimal;

        DateComptaMax: Date;

    procedure DefPeriode(pDate: Date)
    begin
        DateDEB := pDate;
    end;
}

