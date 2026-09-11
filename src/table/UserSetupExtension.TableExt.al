tableextension 50006 UserSetupExtension extends "User Setup"
{
    fields
    {
        field(50000; "Supprimer articles annules"; Boolean)
        {
            Caption = 'Supprimer articles annulés';
            DataClassification = ToBeClassified;
        }
        field(50010; "Modifier adresse sur factures"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Forcer cout sur document vente"; Boolean)
        {
            Caption = 'Forcer coût sur document vente';
            DataClassification = ToBeClassified;
            Description = 'Autorise l''utilisateur à venir modifer le cout unitaire d''un article divers sur une ligne de facture enregistrée ou un devis/une commande.';
        }
        field(50030; "Voir enseignes internes"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'La liste des enseignes ne montrera pas les enseignes internes aux utilisateurs qui ne sont pas cochés ici.';
        }
        field(50040; "Voir ecritures comptables"; Boolean)
        {
            Caption = 'Voir écritures comptables';
            DataClassification = ToBeClassified;
            Description = 'Solution en urgence en attendant d''avoir des autorisations dignes de ce nom...';
        }
        field(50050; "Supprimer ligne acompte"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50060; "Gerer case a cocher Stock"; Boolean)
        {
            Caption = 'Gérer case à cocher Stock';
            DataClassification = ToBeClassified;
            Description = 'Temporaire. Autorise l''utilisateur à cocher/décocher la case à cocher "Achat pour stock" sur les commandes achat et "Devis stock" sur les devis ventes.';
        }
        field(50070; "Changer chantier a la ligne"; Boolean)
        {
            Caption = 'Changer chantier à la ligne';
            DataClassification = ToBeClassified;
        }
        field(50080; "Voir CA groupes et enseignes"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50090; "Saisir OD CA sur enseignes"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50100; "Saisir montant deja verse"; Boolean)
        {
            Caption = 'Saisir montant déjà versé';
            DataClassification = ToBeClassified;
            Description = 'Autorise l''utilisateur à saisir le montant déjà versé sur les devis=>commande=>facture';
        }
        field(50110; "Saisir code douanier achat/vte"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 07/06/2021';
        }
        field(50120; "Modifier annee commande"; Boolean)
        {
            Caption = 'Modifier année commande';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 24/01/2023';
        }
        field(50130; "Utiliser feuille rentabilite"; Boolean)
        {
            Caption = 'Utiliser feuille rentabilité';
            DataClassification = ToBeClassified;
            Description = 'KAN.FHA 30/10/2023';
        }
        field(50140; "Editer clients en liste"; Boolean)
        {
            Caption = 'Editer clients en liste';
            DataClassification = ToBeClassified;
        }
        field(50142; "Editer fournisseurs en liste"; Boolean)
        {
            Caption = 'Editer fournisseurs en liste';
            DataClassification = ToBeClassified;
        }
        field(50150; "Completer fiches BE"; Boolean)
        {
            Caption = 'Compléter fiches BE';
            DataClassification = ToBeClassified;
            Description = 'Autorise l''utilisateur à venir compléter les réponses sur les fiches BE. - L''utilisateur Salle  de réunion a les droits sans être dessinateur';
        }
        field(50160; "Utilisateur logistique"; Boolean)
        {
            Caption = 'Utilisateur logistique';
            DataClassification = ToBeClassified;
            Description = 'Autorise l''utilisateur à venir saisir la [Quantité à expédier] sur le phasage des documents de vente avant de les expédier.';
        }
        field(50170; "MAJ Cond. pmnt/Devis+Cde"; Boolean)
        {
            Caption = 'MAJ Cond. pmt/Devis+cde';
            DataClassification = ToBeClassified;
            Description = 'Autorise l''utilisateur à venir modifier les conditions de paiement sur les devis et commandes de ventes.';
        }
        field(50180; "Utiliser outil crea. articles"; Boolean)
        {
            Caption = 'Utiliser outil créa. articles';
            DataClassification = ToBeClassified;
            Description = 'Autorise l''utilisateur à utiliser l''outil de création/mise à jour d''articles.';
        }
        field(50190; "Phaser reliquat"; Boolean)
        {
            Caption = 'Phaser reliquat';
            DataClassification = ToBeClassified;
        }


    }
}

