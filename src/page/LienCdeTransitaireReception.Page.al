page 50064 "Lien cde transitaire-reception"
{
    PageType = List;
    SourceTable = "Lien cde transitaire-reception";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. container"; Rec."No. container")
                {
                }
                field("No. commande transitaire"; Rec."No. commande transitaire")
                {
                    Visible = false;
                }
                field("No. bon de reception"; Rec."No. bon de reception")
                {
                }
                field("No. ligne bon reception"; Rec."No. ligne bon reception")
                {
                }
                field("No. commande marchandise"; Rec."No. commande marchandise")
                {
                }
                field("No. article"; Rec."No. article")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Quantite recue"; Rec."Quantite recue")
                {
                }
                field("Cout unitaire direct (DS)"; Rec."Cout unitaire direct (DS)")
                {
                }
                field("Montant recu ligne (DS)"; Rec."Montant recu ligne (DS)")
                {
                }
                field("Montant recu ce BR (DS)"; Rec."Montant recu ce BR (DS)")
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
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    NumCdeAchat: Code[20];
                begin
                    if Rec.GetFilter(Rec."No. commande transitaire") <> '' then
                        if Rec.GetRangeMin(Rec."No. commande transitaire") = Rec.GetRangeMax(Rec."No. commande transitaire") then begin
                            NumCdeAchat := Rec.GetRangeMin(Rec."No. commande transitaire");
                            Rec.ExtraireContainer(NumCdeAchat);
                        end;
                end;
            }
            action(EclaterLignesTransitaire)
            {
                Caption = 'EclaterLignesTransitaire';
                Image = Splitlines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = false;

                trigger OnAction()
                begin
                    Rec.EclaterLignesTransitaire();
                end;
            }
        }
    }
}

