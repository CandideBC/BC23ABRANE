page 50148 "Liste documents OCR Vente"
{
    CardPageID = "Fiche document OCR Vente";
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
                field("No."; Rec."No.")
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
                field("Date document"; Rec."Date document")
                {
                    ToolTip = 'Indique la date sur le document';
                }
                field("No. document client"; Rec."No. document client")
                {
                    ToolTip = 'Indique le N° identifiant le document chez le client.';
                }
                field("No. donneur ordre"; Rec."No. donneur ordre")
                {
                    ToolTip = 'Indique quel N° client (BC) a envoyé le document.';
                }
                field("No. contact societe"; Rec."No. contact societe")
                {
                    ToolTip = 'Indique le N° contact société correspondant au client';
                }
                field("No. contact personne"; Rec."No. contact personne")
                {
                    ToolTip = 'Indique quelle personne a envoyé le document';
                }
                field("Nom client OCR"; Rec."Nom client OCR")
                {
                    ToolTip = 'Indique le nom de client détecté sur le document OCRisé, potentiellement différent de la valeur se trouvant dans BC.';
                }
                field("Nom client 2 OCR"; Rec."Nom client 2 OCR")
                {
                    ToolTip = 'Indique le complément de nom de client détecté sur le document OCRisé, potentiellement différent de la valeur se trouvant dans BC.';
                }
                field("Adresse client OCR"; Rec."Adresse client OCR")
                {
                    ToolTip = 'Indique l''adresse détectée sur le document OCRisé, potentiellement différente de la valeur se trouvant dans BC.';
                }
                field("Adresse client 2 OCR"; Rec."Adresse client 2 OCR")
                {
                    Caption = 'Adresse client 2 OCR';
                    ToolTip = 'Indique le complément de nom de client détecté sur le document OCRisé, potentiellement différent de la valeur se trouvant dans BC.';
                }
                field("Code postal client OCR"; Rec."Code postal client OCR")
                {
                    ToolTip = 'Indique le code postal du client détecté sur le document OCRisé, potentiellement différent de la valeur se trouvant dans BC.';
                }
                field("Ville client OCR"; Rec."Ville client OCR")
                {
                    ToolTip = 'Indique la ville du client détectée sur le document OCRisé, potentiellement différente de la valeur se trouvant dans BC.';
                }
                field("Montant HT OCR"; Rec."Montant HT OCR")
                {
                    ToolTip = 'Indique le montant HT tel que lu par l''ORC. Potentiellement différent de la valeur calculée par BC.';
                }
                field("Montant port HT OCR"; Rec."Montant port HT OCR")
                {
                    ToolTip = 'Indique le montant du port détecté par l''OCR';
                }
                field("Montant TVA OCR"; Rec."Montant TVA OCR")
                {
                    ToolTip = 'Indique le montant de TVA détecté sur le document OCRisé, potentiellement différent de la valeur calculée par BC.';
                }
                field("Total TTC OCR"; Rec."Total TTC OCR")
                {
                    ToolTip = 'Indique le total TTC détecté sur le document OCRisé, potentiellement différent de la valeur calculée par BC.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Montant HT NAV (hors port)");
        //MontantHTCalculeNAV := "Montant HT NAV (hors port)" + "Montant port HT";
    end;

    var
        MontantHTCalculeNAV: Decimal;
        TexteLigne: Text[30];
}

