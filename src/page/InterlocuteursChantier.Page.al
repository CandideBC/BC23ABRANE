page 50033 InterlocuteursChantier
{
    ApplicationArea = All;
    Caption = 'Interlocuteurs Chantier';
    DataCaptionExpression = rec."Code chantier";
    PageType = List;
    SourceTable = "Interlocuteurs Chantier";
    UsageCategory = None;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Type interlocuteur"; Rec."Type interlocuteur")
                {
                    ApplicationArea = All;
                    ToolTip = 'Choisissez Enseigne si vous voulez choisir un interlocuteur connu au niveau de l''enseigne. Sinon, vous pouvez indiquer un interlocuteur propre à ce chantier';
                }
                
                field("No. interlocuteur"; Rec."No. interlocuteur")
                {
                    ToolTip = 'Specifies the value of the N° interlocuteur field.';
                }
                field("Code appellation"; Rec."Code appellation")
                {
                    ToolTip = 'Specifies the value of the Code appellation field.';
                    Editable = (Rec."Type interlocuteur" = rec."Type interlocuteur"::Autre);
                }
                field("Nom complet"; Rec."Nom complet")
                {
                    ToolTip = 'Specifies the value of the Nom complet field.';
                    Editable = (Rec."Type interlocuteur" = rec."Type interlocuteur"::Autre);
                }
                field(Fonction; Rec.Fonction)
                {
                    ToolTip = 'Specifies the value of the Fonction field.';
                    Editable = (Rec."Type interlocuteur" = rec."Type interlocuteur"::Autre);
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the value of the Email field.';
                    Editable = (Rec."Type interlocuteur" = rec."Type interlocuteur"::Autre);
                }
                field("No. telephone"; Rec."No. telephone")
                {
                    ToolTip = 'Specifies the value of the No. téléphone field.';
                    Editable = (Rec."Type interlocuteur" = rec."Type interlocuteur"::Autre);
                }
                field("No. telephone mobile"; Rec."No. telephone mobile")
                {
                    ToolTip = 'Specifies the value of the N° téléphone mobile field.';
                    Editable = (Rec."Type interlocuteur" = rec."Type interlocuteur"::Autre);
                }
                field("Code chantier";Rec."Code chantier")
                {
                    ToolTip = 'Indique le code chantier.';
                }
                field("Envoi devis/ARC";Rec."Envoi devis/ARC")
                {
                    ApplicationArea = All;
                    ToolTip = 'L''interlocuteur est-il destinataire des devis et accusés de réception de commande ?';
                }
                field("Envoi facture";Rec."Envoi facture")
                {
                    ApplicationArea = All;
                    ToolTip = 'L''interlocuteur est-il destinataire des factures ?';
                }
                field("Relances paiements";Rec."Relances paiements")
                {
                    ApplicationArea = All;
                    ToolTip = 'L''interlocuteur est-il destinataire des relances (paiements) ?';
                }
                

            }
        }
    }
}
