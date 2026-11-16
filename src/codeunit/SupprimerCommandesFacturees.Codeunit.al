codeunit 50010 SupprimerCommandesFacturees
{
    var
        SupprQst: Label 'Voulez-vous supprimer les commandes achats et ventes complètement facturées ?';
    trigger OnRun()
    var
        LigneAchat: Record "Purchase Line";
        EnteteAchat: Record "Purchase Header";
        LigneVente: Record "Sales Line";
        ListeDocChantier: Record "Documents chantier";
    begin
        if not Confirm(SupprQst) then
            exit;

        Report.run(Report::"Delete Invoiced Purch. Orders");
        Commit();
        Report.Run(Report::"Delete Invoiced Sales Orders");
        Commit();

        //On vide la liste des commandes d'achats restantes pour tous les chantiers
        ListeDocChantier.Reset();
        ListeDocChantier.SetRange("Type document",ListeDocChantier."Type document"::"Commande achat");
        ListeDocChantier.DeleteAll();

        LigneAchat.Reset();
        LigneAchat.SetCurrentKey(TypeDoc, "Code chantier");
        LigneAchat.SetRange(TypeDoc,LigneAchat.TypeDoc::Order);
        if LigneAchat.FindSet(false) then 
            repeat
                if LigneAchat."Code chantier" <> '' then
                    if not ListeDocChantier.Get(LigneAchat."Code chantier",ListeDocChantier."Type document"::"Commande achat",LigneAchat."Document No.") then begin
                        ListeDocChantier.Init();
                        ListeDocChantier."Code chantier" := LigneAchat."Code chantier";
                        ListeDocChantier."Type document" := ListeDocChantier."Type document"::"Commande achat";
                        ListeDocChantier."No. document" := LigneAchat."Document No.";
                        if EnteteAchat.Get(LigneAchat."Document Type",LigneAchat."Document No.") then
                            ListeDocChantier.Commentaires := EnteteAchat.Commentaires;
                        ListeDocChantier.Insert();
                    end;
            until LigneAchat.Next() = 0;

        //On vide la liste des commandes de vente restantes pour tous les chantiers
        ListeDocChantier.Reset();
        ListeDocChantier.SetRange("Type document",ListeDocChantier."Type document"::"Commande vente");
        ListeDocChantier.DeleteAll();

        LigneVente.Reset();
        LigneVente.SetCurrentKey(TypeDocDuplique, "Code chantier");
        LigneVente.SetRange(TypeDocDuplique,LigneVente.TypeDocDuplique::Order);
        if LigneVente.FindSet(false) then 
            repeat
                if LigneVente."Code chantier" <> '' then
                    if not ListeDocChantier.Get(LigneVente."Code chantier",ListeDocChantier."Type document"::"Commande achat",LigneVente."Document No.") then begin
                        ListeDocChantier.Init();
                        ListeDocChantier."Code chantier" := LigneVente."Code chantier";
                        ListeDocChantier."Type document" := ListeDocChantier."Type document"::"Commande achat";
                        ListeDocChantier."No. document" := LigneVente."Document No.";
                        if EnteteAchat.Get(LigneVente."Document Type",LigneVente."Document No.") then
                            ListeDocChantier.Commentaires := EnteteAchat.Commentaires;
                        ListeDocChantier.Insert();
                    end;
            until LigneVente.Next() = 0;

    end;
}
