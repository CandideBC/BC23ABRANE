report 50071 "MAJ suivi container / achats"
{
    ApplicationArea = All;
    UsageCategory = None;
    // Ce traitement est lancé à la demande par l'assistante Import/Export.
    // Il vérifie pour chaque ligne d'achat coché "Suivi container" que la quantité achetée se trouve bien en container. Si c'est le cas, le traitement coche sur la ligne de commande d'achat le champ "Suivi container OK".
    // Dans un deuxième temps, le système parcourt toutes les commandes d'achats (entetes) qui sont en "Suivi container" et coche/décoche le champ "Suivi container OK" (de l'entête cette fois) selon que toutes les lignes de chaque commande
    // sont OK ou non.

    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem("Purchase Line"; "Purchase Line")
        {
            DataItemTableView = sorting ("Suivi container") where ("Document Type" = const (Order), "Suivi container" = const (true));

            trigger OnAfterGetRecord()
            begin
                //KAN.FHA 03/11/2022 DEBUT
                //IF Type <> Type::Item THEN
                //  CurrReport.SKIP;
                //Remplacé par :
                if Quantity = 0 then
                    CurrReport.Skip();
                //KAN.FHA 03/11/2022 FIN

                if "Purchase Line"."Outstanding Quantity" = 0 then
                    SuiviOK := true
                else begin
                    CalcFields("Quantite en container");
                    SuiviOK := ("Quantite en container" = Quantity);
                end;

                if "Purchase Line"."Suivi container OK" <> SuiviOK then begin
                    LigneAchat.Get("Purchase Line"."Document Type", "Purchase Line"."Document No.", "Purchase Line"."Line No.");
                    LigneAchat."Suivi container OK" := SuiviOK;
                    LigneAchat.Modify();
                end;
            end;

            trigger OnPostDataItem()
            begin
                Commit();
            end;
        }
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = sorting ("Suivi container", "Suivi container OK") where ("Document Type" = const (Order), "Suivi container" = const (true));

            trigger OnAfterGetRecord()
            begin
                CalcFields("Existe ligne container non OK");
                SuiviOK := not "Existe ligne container non OK";
            if "Suivi container OK" <> SuiviOK then begin
                    EnteteAchat.Get("Purchase Header"."Document Type", "Purchase Header"."No.");
                    EnteteAchat."Suivi container OK" := SuiviOK;
                    EnteteAchat.Modify();
                end;
            end;

            trigger OnPostDataItem()
            var
                MiseAJourEffectueeLbl: Label 'Mise à jour effectuée.';
            begin
                Message(MiseAJourEffectueeLbl);
            end;
        }
    }

    requestpage
    {

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

    var
        LigneAchat: Record "Purchase Line";
        EnteteAchat: Record "Purchase Header";
        SuiviOK: Boolean;
        
        
}

