report 50061 "Calculer stock à date"
{
    // LEs articles ABRANE sont paramétrés en méthode Moyen mais il a été décidé avec le CAC qu'un calcul FIFO serait utilisé.
    // Ce n'est pas l'état de valo de stock de NAV qui est utilisé mais une méthode qui cherche les factures d'achats pour couvrir la qté en stock à la date souhaitée.
    // Si on avait 100 articles A1 en stock au 31/12/2021, le systeme va chercher les factures d'achats en remontant à partir de cette date.
    //   Il va trouver 60 articles A1 achetés à 12 EUR sur une facture de Novembre 2021
    //   Il va trouver une autre facture de 90 pièces à 10 Eur de septembre 2020.
    // 
    // ==>Il va prendre 60X12 + 40X10 = 1120Eur soit un "PMP recalculé" de 11,20Eur au 31/12/2021.
    // 
    // Le 31/12/2022, on lance le même calcul.
    // L'article n'a pas été acheté sur 2022 mais on en a vendu 50.
    // 
    // Dans une logique FIFO, on considererait que les 50 pieces restantes valent 12Eur (la dern facture d'achat couvre la qté en stock) mais ce n'est pas ainsi qu'on souhaite raisonner chez ABRANE.
    // 
    // Si l'article A1 n'a pas été acheté sur 2022 alors son PMP doit rester inchangé par rapport à 2021 (11,20Eur dans l'exemple).

    ProcessingOnly = true;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING ("No.") WHERE ("No." = FILTER ('102*'));
            RequestFilterFields = "No. 2", "No.";
            dataitem(Location; Location)
            {
                DataItemTableView = WHERE (Code = FILTER (<> '*C*'));

                trigger OnAfterGetRecord()
                begin
                    Item.SetRange("Location Filter", Location.Code);
                    Item.CalcFields("Net Change");
                    if Item."Net Change" <> 0 then begin
                        ListeStock.Init;
                        ListeStock."No. article" := Item."No.";
                        ListeStock.Designation := Item.Description;
                        ListeStock."Code magasin" := Location.Code;
                        ListeStock."Ref client" := Item."No. 2";
                        ListeStock."Annee N" := AnneeN;

                        ListeStock."Date dernier mouvement" := DateDernMouvement;

                        ListeStock."Dernier prix achat" := DPA;
                        ListeStock."Date dernier achat" := DateDernierAchat;

                        ListeStock."Dernier prix achat N" := DernierPrixAchatN;
                        ListeStock."Origine dernier achat N" := OrigineDernierPrixAchatN;

                        ListeStock."Date dernier prix achat N" := DateDernierPrixAchatN;
                        ListeStock."Dernier prix achat N-1" := DernierPrixAchatNMoinsUn;
                        ListeStock."Date dernier prix achat N-1" := DateDernierPrixAchatNMoinsUn;

                        ListeStock."Origine dernier achat N-1" := OrigineDernierPrixAchatNMoinsUn;

                        ListeStock."% depreciation" := PctDepreciationRetenu;
                        ListeStock."Stock au (Date)" := DateValeurStock;
                        ListeStock."Quantite en stock magasin" := Item."Net Change";
                        ListeStock."Cout unitaire NAV" := Item."Unit Cost";
                        ListeStock."Valeur au cout unitaire NAV" := Round(ListeStock."Quantite en stock magasin" * Item."Unit Cost", 0.01);

                        ListeStock."Dernier prix achat" := DPA;
                        ListeStock."Valeur au DPA" := Round(ListeStock."Quantite en stock magasin" * ListeStock."Dernier prix achat", 0.01);

                        ListeStock."PMP recalcule" := CoutMoyenAvecFrais;
                        ListeStock."Valeur au PMP recalcule" := Round(ListeStock."Quantite en stock magasin" * CoutMoyenAvecFrais, 0.01);

                        ListeStock.Commentaire := PasAssezDeFactures;
                        ListeStock."Commentaire PMP" := CommentairePMP;

                        ListeStock."Ecart valeur PMP/NAV (Montant)" := ListeStock."Valeur au PMP recalcule" - ListeStock."Valeur au cout unitaire NAV";
                        if ListeStock."Valeur au cout unitaire NAV" <> 0 then
                            ListeStock."Ecart valeur PMP/NAV (%)" := Round(ListeStock."Ecart valeur PMP/NAV (Montant)" / ListeStock."Valeur au cout unitaire NAV" * 100, 0.01)
                        else
                            ListeStock."Ecart valeur PMP/NAV (%)" := 100;
                        ListeStock.Insert;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //Si l'article n'a pas été acheté depuis la fin d'exercice précédent, on ne recalcule pas le PMP, on prend le PMP de la fin d'exercice précédent
                //(attention, on parle de PMP dans une logique FIFO mais on ne veut pas que le PMP change si des sorties ont été effectuées sur l'exercice).
                CalcFields("Date dernier achat");

                CommentairePMP := '';
                DPA := 0;
                DateDernierAchat := 0D;

                PMPFinExerciceNMoinsUn := 0;
                RecalculerPMP := (Item."Date dernier achat" > DateFinExerciceNMoinsUn);
                if not RecalculerPMP then begin //Chercher le PMP à la date de fin d'exercice précédent
                    if HistoriquePMP.Get(Item."No.", DateFinExerciceNMoinsUn) then begin
                        PMPFinExerciceNMoinsUn := HistoriquePMP."PMP recalcule";
                        CommentairePMP := 'PMP Inchangé / Année N-1';
                    end else
                        RecalculerPMP := true;
                end;

                LigneFactAchat.Reset();
                LigneFactAchat.SetCurrentKey(Type, "No.", "SAV fournisseur", "Posting Date");
                LigneFactAchat.SetRange(Type, LigneFactAchat.Type::Item);
                LigneFactAchat.SetRange("No.", Item."No.");
                LigneFactAchat.SetRange("SAV fournisseur", false);
                LigneFactAchat.SetFilter(Quantity, '<>%1', 0);
                if LigneFactAchat.FindLast() then begin
                    DPA := LigneFactAchat."Unit Cost (LCY)";
                    DateDernierAchat := LigneFactAchat."Posting Date";
                end;

                OrigineDernierPrixAchatN := '';
                OrigineDernierPrixAchatNMoinsUn := '';
                DernierPrixAchatN := 0;
                DernierPrixAchatNMoinsUn := 0;
                DateDernierPrixAchatN := 0D;
                DateDernierPrixAchatNMoinsUn := 0D;

                LigneFactAchat.Reset();
                LigneFactAchat.SetCurrentKey(Type, "No.", "SAV fournisseur", "Posting Date");
                LigneFactAchat.SetRange(Type, LigneFactAchat.Type::Item);
                LigneFactAchat.SetRange("No.", Item."No.");
                LigneFactAchat.SetRange("SAV fournisseur", false);
                LigneFactAchat.SetFilter(Quantity, '<>%1', 0);
                LigneFactAchat.SetRange("Posting Date", 0D, DateFinExerciceNMoinsUn);
                if LigneFactAchat.FindLast() then begin
                    EnteteFactAchat.Get(LigneFactAchat."Document No.");
                    OrigineDernierPrixAchatNMoinsUn := EnteteFactAchat."Buy-from Country/Region Code";
                    DernierPrixAchatNMoinsUn := LigneFactAchat."Unit Cost (LCY)";
                    DateDernierPrixAchatNMoinsUn := LigneFactAchat."Posting Date";
                end;

                LigneFactAchat.SetRange("Posting Date", DateDebutExerciceN, DateFinExerciceN);
                if LigneFactAchat.FindLast() then begin
                    EnteteFactAchat.Get(LigneFactAchat."Document No.");
                    OrigineDernierPrixAchatN := EnteteFactAchat."Buy-from Country/Region Code";
                    DernierPrixAchatN := LigneFactAchat."Unit Cost (LCY)";
                    DateDernierPrixAchatN := LigneFactAchat."Posting Date";
                end;

                Window.Update(1, "No.");

                Item.SetFilter("Location Filter", '<>*C*');
                Item.CalcFields("Net Change");
                QteEnStock := Item."Net Change";

                QteTrouvee := 0;
                MontantAchatsAvecFrais := 0;
                DateDernMouvement := 0D;

                EcrArt2.Reset();
                EcrArt2.SetCurrentKey("Item No.", "Posting Date");
                EcrArt2.SetRange("Item No.", Item."No.");
                EcrArt2.SetRange("Posting Date", 0D, DateValeurStock);
                if EcrArt2.FindLast() then
                    DateDernMouvement := EcrArt2."Posting Date";

                DateDernEntreeAchat := 0D;

                EcritureArticle.SetCurrentKey("Item No.", Positive, "Posting Date");
                EcritureArticle.Ascending(false);
                EcritureArticle.SetRange(Positive, true);
                EcritureArticle.SetRange("Entry Type", EcritureArticle."Entry Type"::Purchase);
                EcritureArticle.SetRange("Posting Date", 0D, DateValeurStock);
                EcritureArticle.SetRange("Item No.", "No.");
                if EcritureArticle.FindSet(false) then begin
                    DateDernEntreeAchat := EcritureArticle."Posting Date";
                    PctDepreciationRetenu := 0;
                    if DateDernEntreeAchat < DateMaxPourDepreciation3 then
                        PctDepreciationRetenu := PctDepreciation3
                    else
                        if DateDernEntreeAchat < DateMaxPourDepreciation2 then
                            PctDepreciationRetenu := PctDepreciation2
                        else
                            if DateDernEntreeAchat < DateMaxPourDepreciation1 then
                                PctDepreciationRetenu := PctDepreciation1;

                    repeat
                        if EcritureArticle.Quantity > 0 then begin
                            QteTrouvee := QteTrouvee + EcritureArticle.Quantity;
                            if QteTrouvee <= QteEnStock then begin
                                QteRestantAValoriser := EcritureArticle.Quantity; //Sert juste à savoir si on doit tout prendre plus bas au niveau des écritures valeur.
                            end else begin
                                QteRestantAValoriser := EcritureArticle.Quantity - (QteTrouvee - QteEnStock); //Là le champ QteRestantAValoriser a un sens, on tombe par ex sur une ligne de 1000 mais il faut en prendre que 22.
                            end;

                            DetailValeurStock.Init();
                            DetailValeurStock."No. article" := EcritureArticle."Item No.";
                            DetailValeurStock."No. ecriture article" := EcritureArticle."Entry No.";
                            DetailValeurStock."Type document" := DetailValeurStock."Type document"::"Achat marchandise";
                            DetailValeurStock."No. document" := EcritureArticle."Document No.";
                            DetailValeurStock."No. ligne document" := EcritureArticle."Document Line No.";
                            if EcritureArticle.Quantity <= QteRestantAValoriser then
                                DetailValeurStock.Quantite := EcritureArticle.Quantity
                            else
                                DetailValeurStock.Quantite := QteRestantAValoriser;
                            EcritureArticle.CalcFields("Cost Amount (Expected)", "Cost Amount (Actual)");
                            if DetailValeurStock.Quantite <> 0 then
                                DetailValeurStock."Cout unitaire" := Round(EcritureArticle."Cost Amount (Expected)" + EcritureArticle."Cost Amount (Actual)" / EcritureArticle.Quantity, 0.01);

                            if QteTrouvee <= QteEnStock then
                                DetailValeurStock."Cout total" := (EcritureArticle."Cost Amount (Expected)" + EcritureArticle."Cost Amount (Actual)")
                            else
                                DetailValeurStock."Cout total" := Round((EcritureArticle."Cost Amount (Expected)" + EcritureArticle."Cost Amount (Actual)") / EcritureArticle.Quantity * QteRestantAValoriser, 0.01);

                            DetailValeurStock."Date comptabilisation" := EcritureArticle."Posting Date";
                            DetailValeurStock.Insert();
                            MontantAchatsAvecFrais := MontantAchatsAvecFrais + DetailValeurStock."Cout total";
                            if RecalculerPMP and (DetailValeurStock.Quantite <> 0) then begin
                                TexteAjout := Format(DetailValeurStock.Quantite) + 'x' + Format(Round(DetailValeurStock."Cout total" / DetailValeurStock.Quantite, 0.01)) + ' EUR (' + EcritureArticle."Document No." + ')';
                                if StrLen(CommentairePMP + ' ' + TexteAjout) <= 250 then
                                    CommentairePMP := CommentairePMP + ' ' + TexteAjout
                                else
                                    CommentairePMP := 'Trop de factures pour en donner le détail, voir dans NAV.';
                            end;
                        end;
                    until (EcritureArticle.Next() = 0) or (QteTrouvee >= QteEnStock);
                end;

                PasAssezDeFactures := '';

                if QteTrouvee < QteEnStock then begin
                    PasAssezDeFactures := 'Manque des factures pour ' + Format(QteEnStock - QteTrouvee);

                    //La quantité pour laquelle on ne trouve pas de factures d'achat va être valorisée au coût unitaire de NAV (qui est peut-être faux mais c'est la seule valeur dont on dispose et elle inclut les frais annexes).
                    DetailValeurStock.Init();
                    DetailValeurStock."No. article" := Item."No.";
                    DetailValeurStock."No. ecriture article" := 0;
                    DetailValeurStock."Type document" := DetailValeurStock."Type document"::"Factures manquantes";
                    DetailValeurStock."No. document" := '';
                    DetailValeurStock."No. ligne document" := 0;
                    DetailValeurStock.Quantite := (QteEnStock - QteTrouvee);
                    DetailValeurStock."Cout unitaire" := Item."Unit Cost";
                    DetailValeurStock."Cout total" := (QteEnStock - QteTrouvee) * Item."Unit Cost";
                    DetailValeurStock."Date comptabilisation" := Today;
                    DetailValeurStock.Insert();
                    MontantAchatsAvecFrais := MontantAchatsAvecFrais + DetailValeurStock."Cout total";
                end;

                if RecalculerPMP then begin //Si l'article a été racheté depuis la fin d'exercice précédent, on a recalculé le nouveau PMP et on le prend
                    if QteEnStock <> 0 then
                        CoutMoyenAvecFrais := Round(MontantAchatsAvecFrais / QteEnStock, 0.00001)
                    else
                        CoutMoyenAvecFrais := 0;
                end else
                    //On a donné le détail du stock en quantité mais pour la valeur, c'est le PMP valable à la fin d'année précédente qui doit être pris (pas les factures d'achats couvrant la qté présente en stock
                    //car le PMP recalculé serait alors faux en cas de sorties sur l'exercice N
                    CoutMoyenAvecFrais := PMPFinExerciceNMoinsUn;
            end;

            trigger OnPostDataItem()
            begin
                Commit();
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Date Filter", 0D, DateValeurStock);

                ListeStock.Reset();
                ListeStock.DeleteAll();

                DetailValeurStock.Reset();
                DetailValeurStock.DeleteAll();

                PctDepreciation1 := 25;
                PctDepreciation2 := 60;
                PctDepreciation3 := 100;
                DateMaxPourDepreciation1 := CalcDate('<-1Y>', DateValeurStock);
                DateMaxPourDepreciation2 := CalcDate('<-2Y>', DateValeurStock);
                DateMaxPourDepreciation3 := CalcDate('<-3Y>', DateValeurStock);

                Window.Open(TextWindow);

                PeriodeComptable.SetRange("New Fiscal Year", true);
                //PeriodeComptable.SETRANGE("Starting Date",0D,TODAY);
                PeriodeComptable.SetRange("Starting Date", 0D, DateValeurStock);
                PeriodeComptable.FindLast();
                DateFinExerciceN := CalcDate('<+1Y-1D>', PeriodeComptable."Starting Date");
                DateDebutExerciceN := PeriodeComptable."Starting Date";
                DateFinExerciceNMoinsUn := CalcDate('<-1Y>', DateFinExerciceN);

                AnneeN := Date2DMY(DateDebutExerciceN, 3);
            end;
        }
        dataitem("Valorisation stock à date"; "Valorisation stock à date")
        {

            trigger OnAfterGetRecord()
            begin
                CalcFields("Quantite stock tous magasins", "Max Code Magasin");
                if "Max Code Magasin" = "Code magasin" then begin
                    "Valeur au cout unitaire NAV" := Round("Quantite stock tous magasins" * "Cout unitaire NAV", 0.01);
                    "Valeur au DPA" := Round("Quantite stock tous magasins" * "Dernier prix achat", 0.01);
                    "Valeur au PMP recalcule" := Round("Quantite stock tous magasins" * "PMP recalcule", 0.01);
                    "Ecart valeur PMP/NAV (Montant)" := "Valeur au PMP recalcule" - "Valeur au cout unitaire NAV";
                    "Ecart absolu PMP/NAV (Mnt)" := Abs("Ecart valeur PMP/NAV (Montant)");
                    if "Valeur au cout unitaire NAV" <> 0 then
                        "Ecart valeur PMP/NAV (%)" := Round("Ecart valeur PMP/NAV (Montant)" / "Valeur au cout unitaire NAV" * 100, 0.01)
                    else
                        "Ecart valeur PMP/NAV (%)" := 100;
                end else begin
                    "Valeur au cout unitaire NAV" := 0;
                    "Valeur au DPA" := 0;
                    "Valeur au PMP recalcule" := 0;
                    "Ecart valeur PMP/NAV (Montant)" := 0;
                    "Ecart absolu PMP/NAV (Mnt)" := 0;
                    "Ecart valeur PMP/NAV (%)" := 0;
                end;

                Modify();
            end;

            trigger OnPostDataItem()
            begin
                Window.Close();
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(DateValeurStock; DateValeurStock)
                {
                    Caption = 'En date du';
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            DateValeurStock := Today;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        EcritureArticle.SetCurrentKey("Item No.", Positive, "Posting Date");
        EcritureArticle.Ascending(false);
        EcritureArticle.SetRange(Positive, true);
        EcritureArticle.SetRange("Entry Type", EcritureArticle."Entry Type"::Purchase);
        EcritureArticle.SetRange("Posting Date", 0D, DateValeurStock);
    end;

    var
        ListeStock: Record "Valorisation stock à date";
        DPA: Decimal;
        QteTrouvee: Decimal;
        MontantAchatsAvecFrais: Decimal;
        MontantLigneDS: Decimal;
        QteEnStock: Decimal;
        TauxChange: Record "Currency Exchange Rate";
        QteRestantAValoriser: Decimal;
        PasAssezDeFactures: Text[250];
        CoutMoyenAvecFrais: Decimal;
        EcritureArticle: Record "Item Ledger Entry";
        LigneFactAchat: Record "Purch. Inv. Line";
        DateValeurStock: Date;
        DateDernMouvement: Date;
        EcrArt2: Record "Item Ledger Entry";
        DetailValeurStock: Record "Détail valeur stock à date";
        DateDernEntreeAchat: Date;
        PctDepreciation1: Decimal;
        PctDepreciation2: Decimal;
        PctDepreciation3: Decimal;
        PctDepreciationRetenu: Decimal;
        DateMaxPourDepreciation1: Date;
        DateMaxPourDepreciation2: Date;
        DateMaxPourDepreciation3: Date;
        Window: Dialog;
        TextWindow: Label '###Article ###1#';
        PeriodeComptable: Record "Accounting Period";
        DateDebutExerciceN: Date;
        DateFinExerciceN: Date;
        DateFinExerciceNMoinsUn: Date;
        PMPFinExerciceNMoinsUn: Decimal;
        RecalculerPMP: Boolean;
        HistoriquePMP: Record "Historique PMP article";
        DateDernierAchat: Date;
        DernierPrixAchatN: Decimal;
        OrigineDernierPrixAchatN: Code[10];
        DateDernierPrixAchatN: Date;
        DernierPrixAchatNMoinsUn: Decimal;
        OrigineDernierPrixAchatNMoinsUn: Code[10];
        DateDernierPrixAchatNMoinsUn: Date;
        EnteteFactAchat: Record "Purch. Inv. Header";
        CommentairePMP: Text[250];
        TexteAjout: Text[50];
        AnneeN: Integer;
}

