page 50056 "MAJ ecriture rentabilite"
{
    ApplicationArea = All;
    UsageCategory=Lists;
    Caption = 'Correction coût unitaire pris sur stock';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Ecriture rentabilite";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. sequence"; Rec."No. sequence")
                {
                    ToolTip = 'N° séquence';
                    Editable = false;
                }
                field("Type ecriture"; Rec."Type ecriture")
                {
                    ToolTip = 'Type écriture';
                    Editable = false;
                }
                field("Code chantier"; Rec."Code chantier")
                {
                    ToolTip = 'Code chantier';
                    Editable = false;
                }
                field("Code groupe"; Rec."Code groupe")
                {
                    ToolTip = 'Code groupe';
                    Editable = false;
                    Visible = false;
                }
                field("Code enseigne"; Rec."Code enseigne")
                {
                    ToolTip = 'Code enseigne';
                    Editable = false;
                    Visible = false;
                }
                field("Code operation"; Rec."Code operation")
                {
                    ToolTip = 'Code opération';
                    Editable = false;
                    Visible = false;
                }
                field("Date comptabilisation"; Rec."Date comptabilisation")
                {
                    ToolTip = 'Date comptabilisation';
                    Editable = false;
                }
                field("Cout total prevu (qte fact)"; Rec."Cout total prevu (qte fact)")
                {
                    ToolTip = 'Coût total prévu (qté fact)';
                }
                field("Cout total reel (qte fact)"; Rec."Cout total reel (qte fact)")
                {
                    ToolTip = 'Coût total réel (qté fact)';
                }
                field("Type document"; Rec."Type document")
                {
                    ToolTip = 'Type document';
                    Editable = false;
                }
                field("No. document"; Rec."No. document")
                {
                    ToolTip = 'N° document';
                    Editable = false;
                }
                field("No. ligne document"; Rec."No. ligne document")
                {
                    ToolTip = 'N° ligne document';
                    Editable = false;
                }
                field("Nature vente"; Rec."Nature vente")
                {
                    ToolTip = 'Nature vente';
                    Editable = false;
                }
                field("Type de cout"; Rec."Type de cout")
                {
                    ToolTip = 'Type de coût';
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'N°';
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                    Editable = false;
                }
                field(Quantite; Rec.Quantite)
                {
                    ToolTip = 'Quantité';
                    Editable = false;
                }
                field("Cout fige"; Rec."Cout fige")
                {
                    ToolTip = 'Coût figé';
                    Editable = false;
                }
                field("Montant unitaire (DS)"; Rec."Montant unitaire (DS)")
                {
                    ToolTip = 'Montant unitaire (DS)';
                    Editable = false;
                }
                field("Montant total (DS)"; Rec."Montant total (DS)")
                {
                    ToolTip = 'Montant total (DS)';
                    Editable = false;
                }
                field("Nouveau cout unitaire (force)"; Rec."Nouveau cout unitaire (force)")
                {
                    ToolTip = 'Nouveau coût unitaire (forcé)';
                }
            }
        }
    }

    actions
    {
    }
}

