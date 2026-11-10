page 50062 WSChantiersLMF
{
    ApplicationArea = All;
    Caption = 'WSChantiersLMF';
    PageType = List;
    SourceTable = Chantier;
    SourceTableView = sorting("Code enseigne", "Chantier archive", Cloture) where ("Code enseigne" = const('LEROY_MERLIN'));
    UsageCategory = None;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    //Cette page est publiée en tant que WS et utilisée par l'OCRisation des cdes LEROYMERLIN pour identifier quel magasin Leroy Merlin a commandé
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                }
                field("Nom chantier"; Rec."Nom chantier")
                {
                }
                field("Nom chantier 2"; Rec."Nom chantier 2")
                {
                }
                field("Adresse chantier"; Rec."Adresse chantier")
                {
                }
                field("Adresse chantier 2"; Rec."Adresse chantier 2")
                {
                }
                field("Code postal chantier"; Rec."Code postal chantier")
                {
                }
                field("Ville chantier"; Rec."Ville chantier")
                {
                }
                field("Code pays chantier"; Rec."Code pays chantier")
                {
                }
            }
        }
    }
}
