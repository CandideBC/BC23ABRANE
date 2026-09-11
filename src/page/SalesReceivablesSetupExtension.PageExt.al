pageextension 50076 SalesReceivablesSetupExtension extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Archive Quotes")
        {
            field("PctTaxeCodifab"; Rec."% taxe Codifab")
            {
                ApplicationArea = All;
                ToolTip = '% taxe Codifab';
            }
            field("Code cond. relance par def."; Rec."Code cond. relance par def.")
            {
                ApplicationArea = All;
                ToolTip = 'Code cond. relance par déf.';
            }
            field("Code cond. interets par def."; Rec."Code cond. interets par def.")
            {
                ApplicationArea = All;
                ToolTip = 'Code cond. intérêts par déf.';
            }
            field("Code mode reglement par def."; Rec."Code mode reglement par def.")
            {
                ApplicationArea = All;
                ToolTip = 'Code mode règlement par déf.';
            }

            field("Nature transaction vente"; Rec."Nature transaction vente")
            {
                ApplicationArea = All;
                ToolTip = 'Nature transaction vente';
            }
            field("Regime vente"; Rec."Regime vente")
            {
                ApplicationArea = All;
                ToolTip = 'Régime vente';
            }
            field("Departement destination"; Rec."Departement destination")
            {
                ApplicationArea = All;
                ToolTip = 'Département destination';
            }
            field("Nom fichier CGV"; Rec."Nom fichier CGV")
            {
                ApplicationArea = All;
                ToolTip = 'Nom fichier CGV';
            }
            field("Racine dossier affaires"; Rec."Racine dossier affaires")
            {
                ApplicationArea = All;
                ToolTip = 'Racine dossier affaires';
            }
            field("Delai creation fact. situ"; Rec."Delai creation fact. situ")
            {
                ApplicationArea = All;
                ToolTip = 'Combien de jours après la date de chargement la facture de situation doit-elle être créée ?';
            }
            field("Date dern. verif situ."; Rec."Date dern. verif situ.")
            {
                ApplicationArea = All;
            }
            
            

        }
        addafter("Direct Debit Mandate Nos.")
        {
            field("ASS Order Nos."; Rec."ASS Order Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'N° commande SAV';
            }
            field("ASS Invoice Nos."; Rec."ASS Invoice Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'N° facture SAV';
            }
            field("ASS Posted Invoice Nos."; Rec."ASS Posted Invoice Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'N° facture enregistrée SAV';
            }
            field("ASS Credit Memo Nos."; Rec."ASS Credit Memo Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'N° avoir SAV';
            }
            field("ASS Posted CrMemo Nos."; Rec."ASS Posted Credit Memo Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'N° avoir enregistré SAV';
            }
            field("No. colisage"; Rec."No. colisage")
            {
                ApplicationArea = All;
                ToolTip = 'N° colisage';
            }
            field("No. UC"; Rec."No. UC")
            {
                ApplicationArea = All;
                ToolTip = 'N° UC';
            }       
            field("No. fiche BE"; Rec."No. fiche BE")
            {
                ApplicationArea = All;
                ToolTip = 'N° fiche BE';
            }
                 

        }
        addlast(Archiving) // Existing control on the page
        {
            group("Affacturage") 
            {
                field("Notice Factor FR"; Rec."Notice Factor FR")
                {
                    ApplicationArea = All;
                    ToolTip = 'Notice Factor FR';
                }            
                field("Notice Factor FR 2"; Rec."Notice Factor FR 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Notice Factor FR 2';
                }            
                field("Notice Factor FR 3"; Rec."Notice Factor FR 3")
                {
                    ApplicationArea = All;
                    ToolTip = 'Notice Factor FR 3';
                }            

            } 
        }
        
    }
}

