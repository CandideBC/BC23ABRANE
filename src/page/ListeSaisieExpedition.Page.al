page 50124 "Liste saisie expedition"
{
    ApplicationArea = All;
    Caption = 'Liste saisie expédition';
    PageType = List;
    SourceTable = "Sales Header";
    SourceTableView = where("Document Type"= const(Order));
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "Fiche saisie expedition";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'N° commande';
                }
                //ICI
                field(PctPrepaSurStock; PctPrepaSurStock)
                {
                    ApplicationArea = All;
                    Caption = '% prépa / stock';
                    ToolTip = '% prépa / stock';
                    BlankZero = true;
                    DecimalPlaces = 0:0;
                }
                field(NbArticlesAPreparer; NbArticlesAPreparer)
                {
                    ApplicationArea = All;
                    Caption = 'Nb articles à préparer';
                    ToolTip = 'Nb articles à préparer';
                    BlankZero = true;
                    DecimalPlaces = 0:5;
                }
                field(PctExpedie; PctExpedie)
                {
                    ApplicationArea = All;
                    Caption = '% expédié';
                    BlankZero = true;
                    DecimalPlaces = 0:0;
                    ToolTip = '% expédié';
                }
                field("Completely Shipped"; Rec."Completely Shipped")
                {
                    ApplicationArea = All;
                    ToolTip = 'Complètement expédiée';
                }
                
                /*
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'N° du client qui a commandé.';
                    Editable = false;

                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ToolTip = 'Nom du destinataire 2';
                    Editable = false;
                }
                */

                field(Commentaire; Rec.Commentaire)
                {
                    ApplicationArea = All;
                    ToolTip = 'Commentaire';
                }
                field("Facturation en compta (O/N)"; Rec."Facturation en compta (O/N)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Facturation en compta (O/N)';
                }
                field("Nombre phases"; Rec."Nombre phases")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre de phases';
                }
                field("Nb affectations achats"; Rec."Nb affectations achats") //A REMPLACER PLUTOT PAR UN COMPTEUR DU NB DE COMMANDES ACHATS AFFECTEES
                {
                    ApplicationArea = All;
                    ToolTip = 'Nb affectations achats';
                }
                field("Date chargement"; Rec."Date chargement")
                {
                    ToolTip = 'Date de chargement';
                    //Editable = false;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ToolTip = 'Date de livraison demandée';
                }
                
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ToolTip = 'Nom du destinataire';

                }
                field("Ship-to Name 2"; Rec."Ship-to Name 2")
                {
                    ToolTip = 'Nom du destinataire 2';
                    Visible = false;

                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ToolTip = 'Adresse du destinataire';
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ToolTip = 'Adresse 2 du destinataire';
                }

                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ToolTip = 'Code postal du destinataire';
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ToolTip = 'Ville du destinataire';
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Code pays destinataire';
                }
                

                field("Nombre de colis"; Rec."Nombre de colis")
                {
                    ToolTip = 'Nombre de colis';

                }
                field("Nombre de palettes"; Rec."Nombre de palettes")
                {
                    ToolTip = 'Nombre de palettes';

                }
                field("Total Net Weight"; Rec."Total Net Weight")
                {
                    ToolTip = 'Poids net total';
                    Editable = false;
                }
                field("Poids brut total"; Rec."Poids brut total")
                {
                    ToolTip = 'Poids brut total';

                }
                


            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        PctExpedie := Rec.CalcPctExpedie(); //Fonction à développer qui ne renvoie rien pour le moment
        PctPrepaSurStock := Rec.CalcPctPrepaSurStock(); //Fonction à développer qui ne renvoie rien pour le moment
        NbArticlesAPreparer := Rec.CalcNbArticlesAPreparer(); //Fonction à développer qui ne renvoie rien pour le moment
    end;


    var
        PctExpedie: Decimal;
        PctPrepaSurStock: Decimal;
        NbArticlesAPreparer: Decimal;
}
