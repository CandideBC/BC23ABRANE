pageextension 50026 UserSetupExtension extends "User Setup"
{

    layout
    {

        addafter("Service Resp. Ctr. Filter")
        {

            field("DEB Ventes cloturee"; Rec."Supprimer articles annules")
            {
                ToolTip = 'DEB Ventes clôturée';
            }
            field("Modifier adresse sur factures"; Rec."Modifier adresse sur factures")
            {
                ToolTip = 'Modifier adresse sur factures';
            }
            field("Voir enseignes internes"; Rec."Voir enseignes internes")
            {
                ToolTip = 'Voir enseignes internes';
            }
            field("Forcer cout sur document vente"; Rec."Forcer cout sur document vente")
            {
                ToolTip = 'Forcer coût sur document vente';
            }
            field("Voir ecritures comptables"; Rec."Voir ecritures comptables")
            {
                ToolTip = 'Voir écritures comptables';
            }
            field("Supprimer ligne acompte"; Rec."Supprimer ligne acompte")
            {
                ToolTip = 'Supprimer ligne acompte';
            }
            field("Gerer case a cocher Stock"; Rec."Gerer case a cocher Stock")
            {
                ToolTip = 'Gérer case à cocher Stock';
            }
            field("Changer chantier a la ligne"; Rec."Changer chantier a la ligne")
            {
                ToolTip = 'Changer chantier à la ligne';
            }
            field("Voir CA groupes et enseignes"; Rec."Voir CA groupes et enseignes")
            {
                ToolTip = 'Voir CA groupes et enseignes';
            }
            field("Saisir OD CA sur enseignes"; Rec."Saisir OD CA sur enseignes")
            {
                ToolTip = 'Saisir OD CA sur enseignes';
            }
            field("Saisir montant deja verse"; Rec."Saisir montant deja verse")
            {
                ToolTip = 'Saisir montant deja versé';
            }
            field("Saisir code douanier achat/vte"; Rec."Saisir code douanier achat/vte")
            {
                ToolTip = 'Saisir code douanier achat/vte';
            }
            field("Modifier annee commande"; Rec."Modifier annee commande")
            {
                ToolTip = 'Modifier année commande';
            }
            field("Utiliser feuille rentabilite"; Rec."Utiliser feuille rentabilite")
            {
                ToolTip = 'Utiliser feuille rentabilité';
            }
            field("Editer clients en liste"; Rec."Editer clients en liste")
            {
                ApplicationArea = All;
                ToolTip = 'Editer les clients en liste';
            }
            field("Editer fournisseurs en liste"; Rec."Editer fournisseurs en liste")
            {
                ApplicationArea = All;
                ToolTip = 'Editer les fournisseurs en liste';
            }
            field("Completer fiches BE"; Rec."Completer fiches BE")
            {
                ApplicationArea = All;
                ToolTip = 'Autorise l''utilisateur à compléter les fiches BE.';
            }
            field("Utilisateur logistique"; Rec."Utilisateur logistique")
            {
                ApplicationArea = All;
                ToolTip = 'Autorise l''utilisateur à saisir les quantités à expédier sur les phasages de vente.';
            }
            field("MAJ Cond. pmnt/Devis+Cde"; Rec."MAJ Cond. pmnt/Devis+Cde")
            {
                ApplicationArea = All;
                ToolTip = 'Autorise l''utilisateur à modifier les conditions de paiement sur les devis et commandes de vente.';
            }
            field("Utiliser outil crea. articles"; Rec."Utiliser outil crea. articles")
            {
                ApplicationArea = All;
                ToolTip = 'Autorise l''utilisateur à utiliser l''outil de création/mise à jour des articles.';
            }
            field("Phaser reliquat"; Rec."Phaser reliquat")
            {
                ApplicationArea = All;
                ToolTip = 'Permet sur les documents de vente de déplacer les articles en reliquat vers la phase 99';
            }
            
            
            
        }


    }





}

