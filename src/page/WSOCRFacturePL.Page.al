page 50154 "WS OCR Facture PL"
{
    APIGroup = 'ocr';
    APIPublisher = 'abrane';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'wsOCRFacturePL';
    DelayedInsert = true;
    EntityName = 'ligneFacturePL';
    EntitySetName = 'lignesFacturePL';
    PageType = API;
    SourceTable = "OCR Facture PL";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(idOCR; Rec."ID OCR")
                {
                    Caption = 'ID OCR';
                }
                field(idLigneOCR; Rec."ID ligne OCR")
                {
                    Caption = 'ID ligne OCR';
                }
                field(noFournisseur; Rec."No. fournisseur")
                {
                    Caption = 'No. fournisseur';
                }
                field(nomFournisseur; Rec."Nom fournisseur")
                {
                    Caption = 'Nom fournisseur';
                }
                field(noFacture; Rec."No. facture")
                {
                    Caption = 'N° facture';
                }
                field(dateFacture; Rec."Date facture")
                {
                    Caption = 'Date facture';
                }
                field(referenceArticle; Rec."Reference article")
                {
                    Caption = 'Reference article';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(quantite; Rec.Quantite)
                {
                    Caption = 'Quantite';
                }
                field(prixUnitaire; Rec."Prix unitaire")
                {
                    Caption = 'Prinx unitaire';
                }
                field(prixTotal; Rec."Prix total")
                {
                    Caption = 'Prix total';
                }
                field(Incoterm; Rec.Incoterm)
                {
                    ApplicationArea = All;
                }
                
                field(hsCode; Rec."HS Code")
                {
                    Caption = 'HS Code';
                }

                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }

            }
        }
    }
}
