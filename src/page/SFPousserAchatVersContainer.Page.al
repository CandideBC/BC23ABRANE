page 50061 "SFPousser achat vers container"
{
    // OnValidate du cout unitaire direct on avait le code suivant finalement enlevé
    // //On veut interdire sur cet écran le fait de mettre à jour le cout unitaire s'il contenait deja une valeur...
    // //KAN.FHA 07/0/2023 DEBUT
    // IF xRec."Direct Unit Cost" <> 0 THEN
    //   ERROR(MAJCoutUnitaireErr,FIELDCAPTION("Direct Unit Cost"));
    // //KAN.FHA 07/0/2023 FIN

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "Purchase Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                    ToolTip = 'N° ligne';
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                    ToolTip = 'Type';
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ToolTip = 'N°';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ToolTip = 'Description';
                }
                field(Quantity; Rec.Quantity)
                {
                    BlankZero = true;
                    Editable = false;
                    ToolTip = 'Quantité';
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                    BlankZero = true;
                    Editable = false;
                    ToolTip = 'Quantité restante';
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    Editable = false;
                    ToolTip = 'Coût unitaire direct';
                }
                field("Nomenclature produits"; Rec."Nomenclature produits")
                {
                    ToolTip = 'Nomenclature produits';
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    ToolTip = 'Poids net';
                }
                field("Quantite en container"; Rec."Quantite en container")
                {
                    ToolTip = 'Quantité en container';
                    Editable = false;
                }
                field("Quantite vers container"; Rec."Quantite vers container")
                {
                    ToolTip = 'Quantité vers container';
                }
                field("Montant vers container"; Rec."Montant vers container")
                {
                    Editable = false;
                    ToolTip = 'Montant vers container';
                }
                field("Cout unitaire facture (papier)"; Rec."Cout unitaire facture (papier)")
                {
                    ToolTip = 'Coût unitaire facture (papier)';
                }
                field("Montant facture (papier)"; Rec."Montant facture (papier)")
                {
                    Editable = false;
                    ToolTip = 'Montant facture (papier)';
                }
            }
        }
    }

    actions
    {
    }

    var
        
}

