page 50131 SuiviAchatsParDocVente
{
    ApplicationArea = All;
    Caption = 'Suivi des achats / document vente';
    PageType = List;
    SourceTable = TamponCdesAchatsParDocVente;
    UsageCategory = None;
    Editable = false;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No. commande achat"; Rec."No. commande achat")
                {
                    ToolTip = 'N° de la commande d''achat';
                }
                field("No. fournisseur"; Rec."No. fournisseur")
                {
                    ToolTip = 'N° du fournisseur chez qui a été passée la commande.';
                }
                field("Nom fournisseur"; Rec."Nom fournisseur")
                {
                    ToolTip = 'Nom du fournisseur chez qui a été passée la commande.';
                }
                field("Date semaine chargement"; Rec."Date semaine chargement")
                {
                    ToolTip = 'Date de chargement indiquée sur la commande.';
                    Visible = false;
                }
                field("Semaine chargement"; Rec."Semaine chargement")
                {
                    ApplicationArea = All;
                    ToolTip = 'Semaine de chargement';
                }
                
                field("Date chargement confirmee"; Rec."Date chargement confirmee")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date de chargement indiquée par le service d''import/export.';
                }
                
                field("Date reception prevue"; Rec."Date reception prevue")
                {
                    ToolTip = 'Date de réception prévue de la commande.';
                }
                field(Commentaires; Rec.Commentaires)
                {
                    ApplicationArea = All;
                    ToolTip = 'Commentaires de la commande achat';
                }
                
            }
            part(SFSuiviAchats;SFSuiviAchatsParDocVente)
            {
                SubPageLink = "No. commande achat" = field("No. commande achat");
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.setrange("Code utilisateur",UserId);
        rec.FilterGroup(0);
    end;
}
