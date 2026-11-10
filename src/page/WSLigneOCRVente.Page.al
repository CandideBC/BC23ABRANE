page 50151 WS_LigneOCRVente
{
    DelayedInsert = true;
    PageType = API;
    APIPublisher = 'abrane';
    APIGroup = 'ocr';
    APIVersion = 'v1.0';
    EntityName = 'ligneOcrVente';
    EntitySetName = 'lignesOcrVente';
    SourceTable = "Ligne OCR vente";
    InsertAllowed = true;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater("Général")
            {


                field(idDocumentOCR; Rec."ID document OCR")
                {
                }
                field(noCommandeClient; Rec."No. commande client")
                {
                }
                field(dateCommandeOCR; Rec."Date commande OCR")
                {
                }
                field(demandeur; Rec.Demandeur)
                {
                    ApplicationArea = All;
                }
                field(codeChantier; Rec."Code chantier")
                {
                    ApplicationArea = All;
                }


                field(nomFacturationOCR; Rec."Nom facturation OCR")
                {
                }
                field(nomFacturation2OCR; Rec."Nom facturation 2 OCR")
                {
                }
                field(adresseFacturationOCR; Rec."Adresse facturation OCR")
                {
                }
                field(adresseFacturation2OCR; Rec."Adresse facturation 2 OCR")
                {
                }
                field(cpFacturationOCR; Rec."CP facturation OCR")
                {
                }
                field(villeFacturationOCR; Rec."Ville facturation OCR")
                {
                }
                field(paysFacturationOCR; Rec."Pays facturation OCR")
                {
                }
                field(emailFacturation; Rec."Email facturation")
                {
                }


                field(nomLivraisonOCR; Rec."Nom livraison OCR")
                {
                }
                field(nomLivraison2OCR; Rec."Nom livraison 2 OCR")
                {
                }
                field(adresseLivraisonOCR; Rec."Adresse livraison OCR")
                {
                }
                field(adresseLivraison2OCR; Rec."Adresse livraison 2 OCR")
                {
                }
                field(cpLivraisonOCR; Rec."CP livraison OCR")
                {
                }
                field(villeLivraisonOCR; Rec."Ville livraison OCR")
                {
                }
                field(paysLivraisonOCR; Rec."Pays livraison OCR")
                {
                }
                field(noTelephoneLivraisonOCR; Rec."No. telephone livraison OCR")
                {
                }
                field(montantHTOCR; Rec."Montant HT OCR")
                {
                }
                field(rayon; Rec.Rayon)
                {
                    ApplicationArea = All;
                }

                field(idLigneDocumentOCR; Rec."ID ligne document OCR")
                {
                }
                field(noArticle; Rec."Reference article client")
                {
                }
                /*
                field(codeVariante; Rec."Code variante")
                {
                }
                */
                field(designationArticleOCR; Rec."Designation article OCR")
                {
                }
                field(prixUnitaireOCR; Rec."Prix unitaire OCR")
                {
                }
                field(uniteOCR; Rec.Unite)
                {
                }
                field(quantite; Rec.Quantite)
                {
                }
                field(montantLigneHTOCR; Rec."Montant ligne HT (OCR)")
                {
                }
                field(dateLivraisonDemandee; Rec."Date livraison demandee")
                {
                    ApplicationArea = All;
                }

                field(id; Rec.SystemId)
                {
                    Editable = false;
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                }
            }
        }
    }

    actions
    {
    }
}

