page 50153 "WS OCR Packing List"
{
    APIGroup = 'ocr';
    APIPublisher = 'abrane';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'wsOCRPackingList';
    DelayedInsert = true;
    EntityName = 'lignePackingList';
    EntitySetName = 'lignesPackingList';
    PageType = API;
    SourceTable = "OCR Packing List";
    
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
                field(noPackingList; Rec."No. packing list")
                {
                    Caption = 'No. packing list';
                }
                field(datePackingList; Rec."Date packing list")
                {
                    Caption = 'Date packing list';
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
                field(noUC; Rec."No. UC")
                {
                    Caption = 'No. UC';
                }
                field(dimensionsUC; Rec."Dimensions UC")
                {
                    Caption = 'Dimensions UC';
                }
                field(poidsNetUC; Rec."Poids net UC")
                {
                    Caption = 'Poids net UC';
                }
                field(poidsBrutUC; Rec."Poids brut UC")
                {
                    Caption = 'Poids brut UC';
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
