page 50031 EditerLigneDocEnreg
{
    ApplicationArea = All;
    Caption = 'Editer ligne document enregistré';
    PageType = List;
    SourceTable = "Editer ligne doc. enregistre";
    UsageCategory = None;
    InsertAllowed = false;
    DeleteAllowed = false;

    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No. ligne document"; Rec."No. ligne document")
                {
                    Editable = false;
                    ToolTip = 'Indique le N° de ligne du document d''origine';
                }
                field("Type"; Rec."Type")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Annee commande"; Rec."Annee commande")
                {
                    ToolTip = 'Specifies the value of the Année commande field.';
                }
            }
        }
    }
    trigger OnModifyRecord(): Boolean
    var
        CodeunitMAJ: Codeunit "Editer ligne doc. enreg.";
        MAJNecessaire: Boolean;
    begin
        MAJNecessaire := false;
        if Rec."Annee commande" <> xRec."Annee commande" then 
            MAJNecessaire := true;
        
        if MAJNecessaire then
            CodeunitMAJ.Run(Rec);
    end;
}
