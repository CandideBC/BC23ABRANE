codeunit 50011 ArchiverDossiersBE
//Codeunit planifié dans la file d'attente des travaux ou lancer manuellement
{
    trigger OnRun()
    var
        DossierBE: Record "Dossier BE";
        DossierBE_MAJ: Record "Dossier BE";
        LigneDossierBE: Record "Ligne fiche BE";
        DossierArchivable: Boolean;
        NbDossiersArchives: Integer;
        ArchiverDossiersBEQst: Label 'Voulez-vous archiver les dossiers BE ? Seuls les dossiers dont toutes les fiches sont Annulées, Terminés ou "BE Fournisseur" seront archivés';
        DossiersArchivesMsg:  Label '%1 dossiers ont été archivés', Comment = '%1 = Nombre de dossiers';
    begin
        if GuiAllowed then
            if not Confirm(ArchiverDossiersBEQst, true) then
                exit;
        DossierBE.SetCurrentKey(Archive);
        DossierBE.SetRange(Archive, false); //On ne regarde que les dossiers non archivés
        if DossierBE.FindSet(false) then
            repeat
                LigneDossierBE.SetRange("No. dossier BE", DossierBE."No.");
                if LigneDossierBE.FindSet(false) then begin
                    DossierArchivable := true;
                    repeat
                        DossierArchivable := DossierArchivable and
                             (LigneDossierBE."Statut ligne" in [LigneDossierBE."Statut ligne"::"Annnulé", 
                                LigneDossierBE."Statut ligne"::"Terminé", LigneDossierBE."Statut ligne"::"BE fournisseur",LigneDossierBE."Statut ligne"::"Pas de fiche"])
                    until (LigneDossierBE.Next() = 0) or (not DossierArchivable);
                    if DossierArchivable then begin
                        DossierBE_MAJ.Get(DossierBE."No.");
                        DossierBE_MAJ.Archive := true;
                        DossierBE_MAJ.Modify();
                        NbDossiersArchives := NbDossiersArchives + 1;
                    end;
                end;
            until DossierBE.Next() = 0;

        if GuiAllowed then
            Message(DossiersArchivesMsg,NbDossiersArchives);
    end;
}