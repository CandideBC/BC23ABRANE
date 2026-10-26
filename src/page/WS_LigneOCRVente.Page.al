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
                field(SystemId; Rec.SystemId) 
                {
                }
                field(SystemModifiedAt;Rec.SystemModifiedAt)
                {
                }

                field(No_document_OCR; Rec."No. document OCR")
                {
                }
                field(Date_document_OCR; Rec."Date document OCR")
                {
                }
                field(Email_expediteur; Rec."Email expediteur")
                {
                }
                field(No_document_client; Rec."No. document client")
                {
                }
                field(URL_document; Rec."URL document")
                {
                }
                field(GUID_Societe; Rec."GUID Societe")
                {
                }
                field(No_TVA_Societe_OCR; Rec."No. TVA Societe OCR")
                {
                }
                field(Nom_client_OCR; Rec."Nom client OCR")
                {
                }
                field(Nom_client_2_OCR; Rec."Nom client 2 OCR")
                {
                }
                field(Adresse_client_OCR; Rec."Adresse client OCR")
                {
                }
                field(Adresse_client_2_OCR; Rec."Adresse client 2 OCR")
                {
                }
                field(Code_postal_client_OCR; Rec."Code postal client OCR")
                {
                }
                field(Ville_client_OCR; Rec."Ville client OCR")
                {
                }
                field(Code_pays_client_OCR; Rec."Code pays client OCR")
                {
                }
                field(GUID_Personne; Rec."GUID Personne")
                {
                }
                field(GUID_Destinataire; Rec."GUID Destinataire")
                {
                }
                field(Nom_destinataire_OCR; Rec."Nom destinataire OCR")
                {
                }
                field(Nom_destinataire_2_OCR; Rec."Nom destinataire 2 OCR")
                {
                }
                field(Adresse_destinataire_OCR; Rec."Adresse destinataire OCR")
                {
                }
                field(Adresse_destinataire_2_OCR; Rec."Adresse destinataire 2 OCR")
                {
                }
                field(Code_postal_destinataire_OCR; Rec."Code postal destinataire OCR")
                {
                }
                field(Ville_destinataire_OCR; Rec."Ville destinataire OCR")
                {
                }
                field(Code_pays_destinataire_OCR; Rec."Code pays destinataire OCR")
                {
                }
                field(No_telephone_destinataire_OCR; Rec."No. telephone destinataire OCR")
                {
                }
                field(EMail_livraison; Rec."EMail livraison")
                {
                }
                field(Commentaire_valideur; Rec."Commentaire valideur")
                {
                }
                field(Montant_HT_OCR; Rec."Montant HT OCR")
                {
                }
                field(Montant_port_HT_OCR; Rec."Montant port HT OCR")
                {
                }
                field(Montant_TVA_OCR; Rec."Montant TVA OCR")
                {
                }
                field(Total_TTC_OCR; Rec."Total TTC OCR")
                {
                }
                field(No_ligne; Rec."No. ligne")
                {
                }
                field(No_article; Rec."No. article")
                {
                }
                field(Code_variante; Rec."Code variante")
                {
                }
                field(Designation_article_OCR; Rec."Designation article OCR")
                {
                }
                field(Quantite; Rec.Quantite)
                {
                }
                field(Code_unite; Rec."Code unite")
                {
                }
                field(Prix_unitaire_OCR; Rec."Prix unitaire OCR")
                {
                }
                field(Percent_remise_ligne; Rec."% remise ligne")
                {
                }
                field(Montant_ligne_HT_OCR; Rec."Montant ligne HT (OCR)")
                {
                }
            }
        }
    }

    actions
    {
    }
}

