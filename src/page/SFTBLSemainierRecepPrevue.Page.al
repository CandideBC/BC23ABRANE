page 50138 "SF TBL Semainier recep prevue"
{
    ApplicationArea = All;
    Caption = 'Réceptions import';
    PageType = ListPart;
    SourceTable = "Semainier chargement import";
    SourceTableView = sorting("Date semaine reception prevue", "No. fournisseur","Reste a charger") where ("Reste a charger" = const(true));
    UsageCategory = None;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Nom du fournisseur"; Rec."Nom du fournisseur")
                {
                    ToolTip = 'Nom du fournisseur';
                    trigger OnDrillDown()
                    begin
                        error('');
                    end;
                }
                field("Mnt restant a charger liv. dir"; Rec."Mnt restant a charger liv. dir")
                {
                    ApplicationArea = All;
                    ToolTip = 'Montant restant à charger en livraison directe';
                }
                field("Mnt restant a charger"; Rec."Mnt restant a charger")
                {
                    ToolTip = 'Montant restant à charger';
                }
                field("Nombre commandes"; Rec."Nombre commandes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre de commandes concernées';
                    trigger OnDrillDown()
                    begin
                        AfficherCommandesAchat();
                    end;
                }

                field("No. semaine reception prevue"; Rec."No. semaine reception prevue")
                {
                    ApplicationArea = All;
                    ToolTip = 'N° semaine réception prévue';
                    Visible = false;
                }

                field("No. fournisseur"; Rec."No. fournisseur")
                {
                    ToolTip = 'N° fournisseur';
                    Visible = false;
                }
                field("No. semaine"; Rec."No. semaine")
                {
                    Caption = 'Semaine chargement';
                    ToolTip = 'N° de semaine';
                    Visible = false;
                }
                field("Remplissages transport"; Rec."Remplissages transport")
                {
                    ToolTip = 'Remplissages transport';
                    ApplicationArea = All;
                }


            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(AfficherCommandes)
            {
                ApplicationArea = All;
                Caption = 'Commandes';
                ToolTip = 'Affiche les commandes d''achats liées.';
                trigger OnAction()
                begin
                    AfficherCommandesAchat();
                end;
            }
        }

    }

    procedure AfficherCommandesAchat()
    var
        EnteteAchat: Record "Purchase Header";

    begin
        EnteteAchat.SetCurrentKey("No. fournisseur", "Suivi container", "Suivi container OK", "Date intention chargement");
        EnteteAchat.SetRange("No. fournisseur", Rec."No. fournisseur");
        EnteteAchat.SetRange("Suivi container", true);
        EnteteAchat.SetRange("Suivi container OK", false);
        EnteteAchat.SetRange("Date intention chargement", Rec."Date debut semaine");
        Page.Run(page::"Purchase Order List", EnteteAchat);

    end;
}
