codeunit 50012 CalculerMontantACharger
{
    //Codeunit planifié par file d'attente
    //Ce traitement va faire 2 choses :
    //  - remplir  une table avec
    //          N° semaine      Fournisseur     Montant à charger
    //              18              F1              1000
    //              18              F2              1500
    //              19              F1               300
    // - remplir une autre table mais avec une présentation sous forme de matrice :
    //          Fournisseur     Semaine18          Semaine19
    //              F1              1000              300
    //              F2              1500    
    //La premiere table servira à choisir une semaine pour le chargement des containers (on verra le montant déjà prévu en chargement pour chaque semaine)
    //La 2e table est une vision plus "planning" des choses.
    //
    //Pour remplir ces 2 tables, on va balayer la table des commandes d'achat et remplir la 1ere table. 
    //Dans un 2e temps, on lira la première table pour remplir la 2e qui n'est qu'une autre manière de présenter les choses.
    //
    //27/05/2026 : on ajoute un calcul permettant d'orienter le type de transport à utiliser (VAN, Porteur, Semi, Container 20 ou 40 pieds)
    //Exemple : sur le pays Roumanie, on va définir un [Montant VAN] de 1500Eur. Tant que le montant à charger est sous les 1500Eur, c'est le VAN qui sera proposé
    //puis on passer à la "taille au-dessus", le porteur.
    //Pour les pays européens, on paramétrera VAN, Porteur et Semi, pour la Chine, ce seront les valeurs pour les 2 types de container. 
    trigger OnRun()
    var
        SemainierChargement: Record "Semainier chargement import";
        SemainierChargementDelete: Record "Semainier chargement import";
        PlanningChargementParFns: Record "Tampon reste a charger par sem";
        LigneTitre: Record "Tampon reste a charger par sem";
        EnteteAchat: Record "Purchase Header";
        LigneAchat: Record "Purchase Line";
        TauxChange: Record "Currency Exchange Rate";
        Fournisseur: Record Vendor;
        Pays: Record "Country/Region";
        RecRefLigneTitre: RecordRef;
        FieldRefLigneTitre: FieldRef;
        RecRefLigneFournisseur: RecordRef;
        FieldRefLigneFournisseur: FieldRef;
        RangSemaine: Integer;
        DateLundiCetteSemaine: date;
        LigneSupprimable: Boolean;
        TransportTerrestrePossible: Boolean;
        TransportMaritimePossible: Boolean;
        Lundi: Date;
        PremierLundiVoulu: Date;
        DernierLundiVoulu: Date;
        DateDebutAnnee: Date;
        DateSemaineChargement: Date;
        DateChargementMin: Date;
        DateChargementMax: Date;
        DateFinAnnee: Date;
        NouvelleDate: Date;

        MontantLigne: Decimal;
        MontantSemaine: Decimal;
        MontantFournisseur: Decimal;
        MontantTotal: Decimal;
        Ratio: Decimal;
        RatioInferieur: Decimal;
        Pct1: Decimal;
        Pct2: Decimal;
        Pct3: Decimal;
        JourSemaine: Integer;
        i: Integer;
        DelaiTransit: Text;
        DelaiTransitLbl: Label '<%1D>', Comment = '%1 = nombre de jours';
        RemplissageTerrestreLbl: label 'VAN %1% - Porteur %2% - Semi %3%';
        RemplissageMaritimeeLbl: label 'Container 20p %1% - Container 40p %2%';
    begin
        //Example de code pour utiliser RecRef et FieldRef
        /*
        Tampon.GET('ABRANE\DEVEX',-1,'');
        TamponRecref.OPEN(50048);
        TamponRecref.GETTABLE(Tampon);
        FOR i := 1 TO 52 DO
          BEGIN
            IF i MOD 3 = 0 THEN BEGIN
              MonFieldRef := TamponRecref.FIELD(100 + i * 10);
              MonFieldRef.VALUE := RANDOM(50000);
              TamponRecref.MODIFY;
            END;
          END;
        */
        //==========================================================
        //INITIALISATION - VIDAGE DES DONNEES A RECALCULER
        //==========================================================

        DateFinAnnee := DMY2DATE(31, 12, Date2DMY(Today, 3));

        SemainierChargement.Reset();
        SemainierChargement.ModifyAll("Mnt restant a charger", 0);
        SemainierChargement.ModifyAll("Mnt restant a charger liv. dir", 0);
        //KAN.FHA 20/05/2026 DEBUT
        SemainierChargement.ModifyAll("Budget approche", 0);
        //KAN.FHA 20/05/2026 FIN
        //KAN.FHA 27/05/2026 DEBUT
        //SemainierChargement.ModifyAll("Type transport pressenti", '');
        SemainierChargement.ModifyAll("Remplissages transport", '');
        //KAN.FHA 27/05/2026 FIN

        PlanningChargementParFns.Reset();
        PlanningChargementParFns.DeleteAll();

        DateDebutAnnee := DMY2Date(1, 1, Date2DMY(Today, 3));

        //==========================================================
        //CALCUL DU MONTANT A CHARGER PAR FNS ET PAR SEMAINE
        //==========================================================
        EnteteAchat.Reset();
        EnteteAchat.SetCurrentKey("Suivi container", "Suivi container OK", "Semaine chargement", EnteteAchat."No. fournisseur");
        EnteteAchat.SetRange("Suivi container", true);
        EnteteAchat.SetRange("Suivi container OK", false);
        EnteteAchat.SetRange("Document Type", EnteteAchat."Document Type"::Order);
        if EnteteAchat.FindSet(false) then begin
            DateChargementMin := 99991231D;
            DateChargementMax := 0D;
            EnteteAchat.CalcFields("Completely Received");
            repeat
                if not Pays.get(EnteteAchat."Buy-from Country/Region Code") then
                    Pays.Init();

                if not EnteteAchat."Completely Received" then begin
                    DateSemaineChargement := EnteteAchat."Date intention chargement";
                    if DateSemaineChargement <> 0D then begin
                        if DateSemaineChargement > DateChargementMax then
                            DateChargementMax := DateSemaineChargement;
                        if DateSemaineChargement < DateChargementMin then
                            DateChargementMin := DateSemaineChargement;

                        if not SemainierChargement.Get(DateSemaineChargement, EnteteAchat."Buy-from Vendor No.") then begin
                            SemainierChargement.Init();
                            SemainierChargement."Date debut semaine" := DateSemaineChargement;
                            SemainierChargement."No. semaine" := Date2DWY(SemainierChargement."Date debut semaine", 2);
                            SemainierChargement."No. fournisseur" := EnteteAchat."Buy-from Vendor No.";

                            if Pays."Delai transit (jours)" <> 0 then begin
                                DelaiTransit := StrSubstNo(DelaiTransitLbl, Pays."Delai transit (jours)");
                                NouvelleDate := CalcDate(DelaiTransit, SemainierChargement."Date debut semaine");
                                JourSemaine := Date2DWY(NouvelleDate, 1);
                                //On affiche des semaines donc la date de reception prevue calculée doit être le lundi de la semaine
                                while JourSemaine <> 1 do begin
                                    NouvelleDate := CalcDate('<+1D>', NouvelleDate);
                                    JourSemaine := Date2DWY(NouvelleDate, 1);
                                end;
                                SemainierChargement."Date semaine reception prevue" := NouvelleDate;
                            end else
                                SemainierChargement."Date semaine reception prevue" := SemainierChargement."Date debut semaine";
                            SemainierChargement."No. semaine reception prevue" := Date2DWY(SemainierChargement."Date semaine reception prevue", 2);
                            SemainierChargement.Insert();
                            MontantTotal := 0;
                            MontantFournisseur := 0;
                        end;

                        LigneAchat.SetRange("Document Type", EnteteAchat."Document Type");
                        LigneAchat.SetRange("Document No.", EnteteAchat."No.");
                        LigneAchat.SetRange("Ligne acompte", false);
                        if LigneAchat.FindSet(false) then
                            repeat
                                LigneAchat.CalcFields("Quantite en container");
                                if LigneAchat.Quantity <> 0 then begin
                                    MontantLigne := Round((LigneAchat.Quantity - LigneAchat."Quantite en container") / LigneAchat.Quantity * LigneAchat."Line Amount", 0.01);
                                    if EnteteAchat."Currency Code" <> '' then
                                        MontantLigne := TauxChange.ExchangeAmtFCYToLCY(EnteteAchat."Date intention chargement", EnteteAchat."Currency Code", MontantLigne, EnteteAchat."Currency Factor");
                                    if LigneAchat."Livraison directe" then
                                        SemainierChargement."Mnt restant a charger liv. dir" := SemainierChargement."Mnt restant a charger liv. dir" + MontantLigne
                                    else
                                        SemainierChargement."Mnt restant a charger" := SemainierChargement."Mnt restant a charger" + MontantLigne;
                                    //KAN.FHA 20/05/2026 DEBUT
                                    SemainierChargement."Budget approche" := round(Pays."% frais approche" / 100 * SemainierChargement."Mnt restant a charger", 0.01);
                                    //KAN.FHA 20/05/2026 FIN
                                    SemainierChargement.Modify();
                                end;

                            until LigneAchat.Next() = 0;
                    end;
                end;
            until EnteteAchat.Next() = 0;
        end;

        Commit();

        //==========================================================
        //CALCUL DU TAUX DE REMPLISSAGE de chaque type de transport
        //==========================================================
        if SemainierChargement.FindSet(true) then
            repeat
                if SemainierChargement."Budget approche" <> 0 then begin
                    if SemainierChargement."Code pays fournisseur" = '' then begin
                        Fournisseur.get(SemainierChargement."No. fournisseur");
                        SemainierChargement."Code pays fournisseur" := Fournisseur."Country/Region Code";
                        SemainierChargement.Modify();
                    end;

                    Pays.Get(SemainierChargement."Code pays fournisseur");
                    TransportTerrestrePossible := (Pays."Montant VAN" <> 0) or (Pays."Montant Porteur" <> 0) or (Pays."Montant Semi" <> 0);
                    TransportMaritimePossible := (Pays."Montant Container 20p" <> 0) or (Pays."Montant Container 40p" <> 0);

                    if TransportTerrestrePossible then begin
                        Pct1 := 0;
                        Pct2 := 0;
                        Pct3 := 0;
                        if Pays."Montant VAN" <> 0 then
                            Pct1 := round(SemainierChargement."Budget approche" / Pays."Montant VAN" * 100, 1);
                        if Pays."Montant Porteur" <> 0 then
                            Pct2 := round(SemainierChargement."Budget approche" / Pays."Montant Porteur" * 100, 1);
                        if Pays."Montant Semi" <> 0 then
                            Pct3 := round(SemainierChargement."Budget approche" / Pays."Montant Semi" * 100, 1);

                        SemainierChargement."Remplissages transport" :=
                            strsubstno(RemplissageTerrestreLbl, Pct1, Pct2, Pct3);

                        SemainierChargement.Modify();
                    end;

                    if TransportMaritimePossible then begin
                        Pct1 := 0;
                        Pct2 := 0;
                        if Pays."Montant Container 20p" <> 0 then
                            Pct1 := round(SemainierChargement."Budget approche" / Pays."Montant Container 20p" * 100, 1);
                        if Pays."Montant Container 40p" <> 0 then
                            Pct2 := round(SemainierChargement."Budget approche" / Pays."Montant Container 40p" * 100, 1);
                        SemainierChargement."Remplissages transport" := StrSubstNo(RemplissageMaritimeeLbl, Pct1, Pct2);
                        SemainierChargement.Modify();
                    end;

                    if not (TransportMaritimePossible or TransportTerrestrePossible) then begin
                        //SemainierChargement."Type transport pressenti" := '????';
                        SemainierChargement."Remplissages transport" := 'Vérifier montants transport sur pays ?';
                        SemainierChargement.Modify();
                    end;

                end;
            until SemainierChargement.Next() = 0;

        //==========================================================
        //REMPLISSAGE DE LA TABLE SERVANT A LA VUE PLANNING
        //==========================================================
        //Maintenant qu'on a listé toutes les semaines (eventuellement du passé) avec le montant à charger par fournisseur, on va remplir la table
        //servant uniquement à afficher le planning des 52 semaines à venir.
        //Contrairement au semainier, le planning ne doit pas tenir compte des montants en livraison directe
        PremierLundiVoulu := CalcDate('<-CW>', Today);
        DernierLundiVoulu := CalcDate('<+52W>', PremierLundiVoulu);

        if SemainierChargement.FindSet() then begin
            LigneTitre.Init();
            LigneTitre.Tri := -1;
            LigneTitre."No. fournisseur" := '';
            LigneTitre.Insert();

            RecRefLigneTitre.Open(50048);
            RecRefLigneTitre.GetTable(LigneTitre);

            //On va remplir la ligne de titre avec les N° de semaine correspondant aux semaines trouvées
            //Exemple : 50, 51, 52, 1 , 2
            i := 1;
            Lundi := PremierLundiVoulu;
            while Lundi <= DernierLundiVoulu do begin
                FieldRefLigneTitre := RecRefLigneTitre.Field(100 + (i * 10));
                FieldRefLigneTitre.Value := Date2DWY(Lundi, 2);
                i := i + 1;
                RecRefLigneTitre.Modify();
                Lundi := Lundi + 7;
            end;

            RecRefLigneFournisseur.Open(50048);

            repeat
                if not PlanningChargementParFns.Get(1, SemainierChargement."No. fournisseur") then begin
                    Fournisseur.Get(SemainierChargement."No. fournisseur");
                    Fournisseur.SetRange("Date Filter", DateDebutAnnee, Today);
                    Fournisseur.CalcFields("Purchases (LCY)");

                    PlanningChargementParFns.Init();
                    PlanningChargementParFns.Tri := 1;
                    PlanningChargementParFns."No. fournisseur" := SemainierChargement."No. fournisseur";
                    PlanningChargementParFns."Montant achats Annee N" := Fournisseur."Purchases (LCY)";
                    PlanningChargementParFns.Insert();
                    MontantTotal := 0;
                    MontantFournisseur := 0;
                end;

                RecRefLigneFournisseur.GetTable(PlanningChargementParFns);

                if (SemainierChargement."Date debut semaine" < PremierLundiVoulu) or (SemainierChargement."Date debut semaine" > DernierLundiVoulu) then begin
                    //On est avant ou apres les 52 semaines à venir
                    if (SemainierChargement."Date debut semaine" < PremierLundiVoulu) then
                        FieldRefLigneFournisseur := RecRefLigneFournisseur.Field(100) //Montant à charger avant les 52 semaines à venir
                    else
                        FieldRefLigneFournisseur := RecRefLigneFournisseur.Field(640); //Montant à charger après les 52 semaines à venir

                    MontantSemaine := SemainierChargement."Mnt restant a charger";
                    FieldRefLigneFournisseur.Value(MontantSemaine);
                    RecRefLigneFournisseur.Modify();

                end else begin //On est sur une des 52 semaines à venir
                    RangSemaine := (SemainierChargement."Date debut semaine" - PremierLundiVoulu) / 7 + 1;

                    FieldRefLigneTitre := RecRefLigneTitre.Field(100 + RangSemaine * 10);

                    FieldRefLigneFournisseur := RecRefLigneFournisseur.Field(100 + RangSemaine * 10);
                    MontantSemaine := SemainierChargement."Mnt restant a charger";
                    FieldRefLigneFournisseur.Value(MontantSemaine);
                    RecRefLigneFournisseur.Modify();
                end;

                //On met à jour le total sur la ligne fournisseur
                FieldRefLigneFournisseur := RecRefLigneFournisseur.Field(40);
                MontantFournisseur := FieldRefLigneFournisseur.Value;
                MontantFournisseur := MontantFournisseur + SemainierChargement."Mnt restant a charger";
                FieldRefLigneFournisseur.Value(MontantFournisseur);
                RecRefLigneFournisseur.Modify();

                //KAN.FHA 11/05/2026 DEBUT
                if SemainierChargement."Date debut semaine" <= DateFinAnnee then begin
                    //On met à jour le total Année N sur la ligne fournisseur
                    FieldRefLigneFournisseur := RecRefLigneFournisseur.Field(46);
                    MontantFournisseur := FieldRefLigneFournisseur.Value;
                    MontantFournisseur := MontantFournisseur + SemainierChargement."Mnt restant a charger";
                    FieldRefLigneFournisseur.Value(MontantFournisseur);

                    //On met à jour le total Année N en LIVDIR sur la ligne fournisseur
                    FieldRefLigneFournisseur := RecRefLigneFournisseur.Field(47);
                    MontantFournisseur := FieldRefLigneFournisseur.Value;
                    MontantFournisseur := MontantFournisseur + SemainierChargement."Mnt restant a charger liv. dir";
                    FieldRefLigneFournisseur.Value(MontantFournisseur);

                    RecRefLigneFournisseur.Modify();

                    //On met à jour le total général sur la ligne de titre
                    FieldRefLigneTitre := RecRefLigneTitre.Field(46); //Montant total restant à charger
                    MontantTotal := FieldRefLigneTitre.Value;
                    MontantTotal := MontantTotal + SemainierChargement."Mnt restant a charger";
                    FieldRefLigneTitre.Value(MontantTotal);

                    //On met à jour le total général LIV DIR sur la ligne de titre
                    FieldRefLigneTitre := RecRefLigneTitre.Field(47);
                    MontantTotal := FieldRefLigneTitre.Value;
                    MontantTotal := MontantTotal + SemainierChargement."Mnt restant a charger liv. dir";
                    FieldRefLigneTitre.Value(MontantTotal);
                    RecRefLigneTitre.Modify();
                end;
                //KAN.FHA 11/05/2026 FIN

                //KAN.FHA 07/05/2026 DEBUT
                //On met à jour le total LIVDIR sur la ligne fournisseur
                FieldRefLigneFournisseur := RecRefLigneFournisseur.Field(45);
                MontantFournisseur := FieldRefLigneFournisseur.Value;
                MontantFournisseur := MontantFournisseur + SemainierChargement."Mnt restant a charger liv. dir";
                FieldRefLigneFournisseur.Value(MontantFournisseur);
                RecRefLigneFournisseur.Modify();
                //KAN.FHA 07/05/2026 FIN

                //On met à jour le total général sur la ligne de titre
                FieldRefLigneTitre := RecRefLigneTitre.Field(40); //Montant total restant à charger
                MontantTotal := FieldRefLigneTitre.Value;
                MontantTotal := MontantTotal + SemainierChargement."Mnt restant a charger";
                FieldRefLigneTitre.Value(MontantTotal);
                RecRefLigneTitre.Modify();

                //KAN.FHA 07/05/2026 DEBUT
                //On met à jour le total général LIV DIR sur la ligne de titre
                FieldRefLigneTitre := RecRefLigneTitre.Field(45);
                MontantTotal := FieldRefLigneTitre.Value;
                MontantTotal := MontantTotal + SemainierChargement."Mnt restant a charger liv. dir";
                FieldRefLigneTitre.Value(MontantTotal);
                RecRefLigneTitre.Modify();
            until SemainierChargement.Next() = 0;

            //On finit en purgeant les semaines du passé sur lesquelles on n'a plus rien à charger
            //On pourrait avoir une commande sans montant mais restant à charger, on va donc se baser sur le nombre de commandes
            //associées à la semaine plutot que sur le montant restant à charger.
            //Rappel : pour éviter d'avoir des commandes entièrement recues qui soient comptées, l'algo ci-dessus ne prend pas en compte les commandes
            //entierement recues.
            Commit();
            SemainierChargement.Reset();
            DateLundiCetteSemaine := CalcDate('<-CW>', Today);
            if SemainierChargement.FindSet(false) then
                repeat
                    SemainierChargement.CalcFields("Nombre commandes");
                    LigneSupprimable := (SemainierChargement."Nombre commandes" = 0) and (SemainierChargement."Date debut semaine" < DateLundiCetteSemaine);

                    if LigneSupprimable then begin
                        SemainierChargementDelete.Get(SemainierChargement."Date debut semaine", SemainierChargement."No. fournisseur");
                        SemainierChargementDelete.Delete();
                    end;
                until SemainierChargement.Next() = 0;
        end;
    end;

}
