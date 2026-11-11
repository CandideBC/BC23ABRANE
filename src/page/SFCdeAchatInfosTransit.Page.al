page 50063 "SF Cde achat : infos transit."
{
    Caption = 'Infos fact. transitaire';
    ApplicationArea = All;
    DelayedInsert = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Lien cde transitaire-reception";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. container"; Rec."No. container")
                {
                    ApplicationArea = All;
                    ToolTip = 'N° container';
                    Editable = false;
                }
                field("No. bon de reception"; Rec."No. bon de reception")
                {
                    ApplicationArea = All;
                    ToolTip = 'N° bon de réception';
                    Editable = false;
                }
                field("No. ligne bon reception"; Rec."No. ligne bon reception")
                {
                    ApplicationArea = All;
                    ToolTip = 'N° ligne bon de réception';
                    Editable = false;
                }
                field("No. commande marchandise"; Rec."No. commande marchandise")
                {
                    ApplicationArea = All;
                    ToolTip = 'N° commande marchandise';
                    Editable = false;
                }
                field("No. article"; Rec."No. article")
                {
                    ApplicationArea = All;
                    ToolTip = 'N° article';
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Description';
                    Editable = false;
                }
                field("Quantite recue"; Rec."Quantite recue")
                {
                    ApplicationArea = All;
                    ToolTip = 'Quantité reçue';
                    Editable = false;
                }
                field("Cout unitaire direct (DS)"; Rec."Cout unitaire direct (DS)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Coût unitaire direct en devise société';
                    Editable = false;
                }
                field("Montant recu ligne (DS)"; Rec."Montant recu ligne (DS)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Montant reçu ligne en devise société';
                    Editable = false;
                }
                field("Montant recu ce BR (DS)"; Rec."Montant recu ce BR (DS)")
                {
                    ToolTip = 'Montant reçu sur ce BR en devise société';
                    ApplicationArea = All;
                }
                field("Montant recu total (DS)"; Rec."Montant recu total (DS)")
                {
                    ToolTip = 'Montant reçu total en devise société';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Extraire container")
            {
                Caption = 'Extraire container';
                Image = GetLines;
                //Promoted = true;
                //PromotedCategory = Process;
                //PromotedIsBig = true;

                trigger OnAction()
                var
                    NumCdeAchat: Code[20];
                begin
                    rec.ExtraireContainer(Rec."No. commande transitaire");
                end;
            }
            action("Eclater lignes")
            {
                Caption = 'Eclater lignes';
                Image = Splitlines;

                trigger OnAction()
                begin
                    rec.EclaterLignesTransitaire();
                end;
            }
        }
    }
}

