page 50151 WS_LigneOCRVente
{
    DelayedInsert = true;
    PageType = API;
    APIPublisher = 'sanipousse';
    APIGroup = 'shop';
    APIVersion = 'v1.0';
    EntityName = 'wsLigneocrvente';
    EntitySetName = 'wsLigneocrventes';
    ;
    SourceTable = "Ligne OCR vente";

    layout
    {
        area(content)
        {
            repeater("Général")
            {
                field(id; Rec.SystemId) 
                {
                }
                field(systemModifiedAt;Rec.SystemModifiedAt)
                {
                }

                field(noDocumentOCR; Rec."No. document OCR")
                {
                }
                field(dateDocumentOCR; Rec."Date document OCR")
                {
                }
                field(emailExpediteur; Rec."Email expediteur")
                {
                }
                field(noDocumentClient; Rec."No. document client")
                {
                }
                field(urlDocument; Rec."URL document")
                {
                }
                field(guidSociete; Rec."GUID Societe")
                {
                }
                field(noTvaSocieteOCR; Rec."No. TVA Societe OCR")
                {
                }
                field(nomClientOCR; Rec."Nom client OCR")
                {
                }
                field(nomClient2OCR; Rec."Nom client 2 OCR")
                {
                }
                field(adresseClientOCR; Rec."Adresse client OCR")
                {
                }
                field(adresseClient2OCR; Rec."Adresse client 2 OCR")
                {
                }
                field(codePostalClientOCR; Rec."Code postal client OCR")
                {
                }
                field(villeClientOCR; Rec."Ville client OCR")
                {
                }
                field(codePaysClientOCR; Rec."Code pays client OCR")
                {
                }
                field(guidPersonne; Rec."GUID Personne")
                {
                }
                field(guidDestinataire; Rec."GUID Destinataire")
                {
                }
                field(nomDestinataireOCR; Rec."Nom destinataire OCR")
                {
                }
                field(nomDestinataire2OCR; Rec."Nom destinataire 2 OCR")
                {
                }
                field(adresseDestinataireOCR; Rec."Adresse destinataire OCR")
                {
                }
                field(adresseDestinataire2OCR; Rec."Adresse destinataire 2 OCR")
                {
                }
                field(codePostalDestinataireOCR; Rec."Code postal destinataire OCR")
                {
                }
                field(villeDestinataireOCR; Rec."Ville destinataire OCR")
                {
                }
                field(codePaysDestinataireOCR; Rec."Code pays destinataire OCR")
                {
                }
                field(noTelephoneDestinataireOCR; Rec."No. telephone destinataire OCR")
                {
                }
                field(emailLivraison; Rec."EMail livraison")
                {
                }
                field(commentaireValideur; Rec."Commentaire valideur")
                {
                }
                field(montantHTOCR; Rec."Montant HT OCR")
                {
                }
                field(montantPortHTOCR; Rec."Montant port HT OCR")
                {
                }
                field(montantTvaOCR; Rec."Montant TVA OCR")
                {
                }
                field(totalTtcOCR; Rec."Total TTC OCR")
                {
                }
                field(noLigne; Rec."No. ligne")
                {
                }
                field(noArticle; Rec."No. article")
                {
                }
                field(codeVariante; Rec."Code variante")
                {
                }
                field(designationArticleOCR; Rec."Designation article OCR")
                {
                }
                field(quantite; Rec.Quantite)
                {
                }
                field(codeUnite; Rec."Code unite")
                {
                }
                field(prixUnitaireOCR; Rec."Prix unitaire OCR")
                {
                }
                field(pourcentageRemiseLigne; Rec."% remise ligne")
                {
                }
                field(montantLigneHTOCR; Rec."Montant ligne HT (OCR)")
                {
                }
            }
        }
    }

    actions
    {
    }
}

