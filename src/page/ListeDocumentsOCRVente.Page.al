page 50148 "Liste documents OCR Vente"
{
    CardPageID = "Fiche commande OCR Vente";
    Editable = false;
    PageType = List;
    SourceTable = "Entete OCR vente";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater("Général")
            {
                field("No. commande client";Rec."No. commande client")
                {
                    ToolTip = 'N°';
                }
                field("Document OCR traite"; Rec."Document OCR traite")
                {
                    ToolTip = 'Indique si le document OCR a été traité.';
                }
                field("No. document NAV"; Rec."No. document NAV")
                {
                    ToolTip = 'Indique le N° de document vente qui a été créé dans BC.';
                }
                field("Date OCRisation"; Rec."Date OCRisation")
                {
                    ToolTip = 'Indique la date à laquelle le document a été OCRisé';
                }
                field("Date commande";Rec."Date commande")
                {
                    ToolTip = 'Indique la date sur le document';
                }

                field("No. donneur ordre"; Rec."No. donneur ordre")
                {
                    ToolTip = 'Indique quel N° client (BC) a envoyé le document.';
                }


                field("Nom facturation OCR";Rec."Nom facturation OCR")
                {
                    ToolTip = 'Indique le nom de client détecté sur le document OCRisé, potentiellement différent de la valeur se trouvant dans BC.';
                }
                field("Nom facturation 2 OCR";Rec."Nom facturation 2 OCR")
                {
                    ToolTip = 'Indique le complément de nom de client détecté sur le document OCRisé, potentiellement différent de la valeur se trouvant dans BC.';
                }
                field("Adresse facturation OCR";Rec."Adresse facturation OCR")
                {
                    ToolTip = 'Indique l''adresse détectée sur le document OCRisé, potentiellement différente de la valeur se trouvant dans BC.';
                }
                field("Adresse facturation 2 OCR";Rec."Adresse facturation 2 OCR")
                {
                    Caption = 'Adresse facturation 2 OCR';
                    ToolTip = 'Indique le complément d''adresse de facturation détecté sur le document OCRisé, potentiellement différent de la valeur se trouvant dans BC.';
                }
                field("CP facturation OCR";Rec."CP facturation OCR")
                {
                    ToolTip = 'Indique le code postal du client détecté sur le document OCRisé, potentiellement différent de la valeur se trouvant dans BC.';
                }
                field("Ville facturation OCR";Rec."Ville facturation OCR")
                {
                    ToolTip = 'Indique la ville du client détectée sur le document OCRisé, potentiellement différente de la valeur se trouvant dans BC.';
                }
                field("Montant HT OCR"; Rec."Montant HT OCR")
                {
                    ToolTip = 'Indique le montant HT tel que lu par l''ORC. Potentiellement différent de la valeur calculée par BC.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        //Rec.CalcFields("Montant HT BC");
        //MontantHTCalculeNAV := "Montant HT NAV (hors port)" + "Montant port HT";
    end;

    var
}

