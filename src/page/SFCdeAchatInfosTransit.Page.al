page 50063 "SF Cde achat : infos transit."
{
    Caption = 'Infos fact. transitaire';
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
                    Editable = false;
                }
                field("No. bon de reception"; Rec."No. bon de reception")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No. ligne bon reception"; Rec."No. ligne bon reception")
                {
                    Editable = false;
                }
                field("No. commande marchandise"; Rec."No. commande marchandise")
                {
                    Editable = false;
                }
                field("No. article"; Rec."No. article")
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field("Quantite recue"; Rec."Quantite recue")
                {
                    Editable = false;
                }
                field("Cout unitaire direct (DS)"; Rec."Cout unitaire direct (DS)")
                {
                    Editable = false;
                }
                field("Montant recu ligne (DS)"; Rec."Montant recu ligne (DS)")
                {
                    Editable = false;
                }
                field("Montant recu ce BR (DS)"; Rec."Montant recu ce BR (DS)")
                {
                }
                field("Montant recu total (DS)"; Rec."Montant recu total (DS)")
                {
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
                //Promoted = true;

                trigger OnAction()
                begin
                    rec.EclaterLignesTransitaire();
                end;
            }
        }
    }
}

