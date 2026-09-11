page 50032 InterlocuteursEnseigne
{
    ApplicationArea = All;
    Caption = 'Interlocuteurs enseigne';
    PageType = List;
    SourceTable = "Interlocuteurs Enseigne";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Indique la valeur du champ N°.';
                }

                field("Code appellation"; Rec."Code appellation")
                {
                    ToolTip = 'Indique la valeur du champ Code appellation';
                }
                field("Nom complet"; Rec."Nom complet")
                {
                    ToolTip = 'Indique la valeur du champ Nom complet.';
                }
                field(Fonction; Rec.Fonction)
                {
                    ToolTip = 'Indique la valeur du champ Fonction.';
                }
                field("No. telephone mobile"; Rec."No. telephone mobile")
                {
                    ToolTip = 'Indique la valeur du champ N° téléphone mobile';
                }
                field("No. telephone"; Rec."No. telephone")
                {
                    ToolTip = 'Indique la valeur du champ N° téléphone.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ToolTip = 'Indique la valeur du champ Email.';
                }
                field("Date dern. modification"; Rec."Date dern. modification")
                {
                    ToolTip = 'Indique la valeur du champ Date dern. modification.';
                }

                field("Envoi devis/ARC"; Rec."Envoi devis/ARC")
                {
                    ApplicationArea = All;
                    ToolTip = 'L''interlocuteur est-il destinataire des devis et accusés de réception de commande ?';
                }
                field("Envoi facture"; Rec."Envoi facture")
                {
                    ApplicationArea = All;
                    ToolTip = 'L''interlocuteur est-il destinataire des factures ?';
                }
                field("Relances paiements"; Rec."Relances paiements")
                {
                    ApplicationArea = All;
                    ToolTip = 'L''interlocuteur est-il destinataire des relances (paiements) ?';
                }
                field("Nombre chantiers interlocuteur"; Rec."Nombre chantiers interlocuteur")
                {
                    ToolTip = 'Nombre de chantiers où cet interlocuteur a été référencé.';
                }
            }
        }
    }
}
