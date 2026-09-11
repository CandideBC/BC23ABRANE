page 50014 "Eco Tax Furniture Posted"
{
    Caption = 'Eco Tax Furniture posted';
    PageType = ListPlus;
    RefreshOnActivate = true;
    SourceTable = "Eco Tax Furniture posted";

    layout
    {
        area(content)
        {
            group("Filtre période")
            {
                Caption = 'Filtre date';
                field("Date Debut"; Rec."Date Debut")
                {
                    Caption = 'Date début';
                    Editable = false;
                }
                field("Date fin"; Rec."Date fin")
                {
                    Caption = 'Date fin';
                    Editable = false;
                }
            }
            repeater(Group)
            {
                Editable = false;
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'N° ligne';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Type document';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'N° document';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ToolTip = 'Code vendeur';
                }
                field("Document Line No."; Rec."Document Line No.")
                {
                    ToolTip = 'N° ligne document';
                }
                field("Item No"; Rec."Item No")
                {
                    ToolTip = 'N° article';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                }
                field("Product Code"; Rec."Product Code")
                {
                }
                field("Code matiere"; Rec."Code matiere")
                {
                    ToolTip = 'Code matière';
                }
                field("Unit Tax Amount"; Rec."Unit Tax Amount")
                {
                    ToolTip = 'Montant taxe unitaire';
                    DecimalPlaces = 2 : 4;
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    ToolTip = 'Poids net';
                }
                field("Tax Amount"; Rec."Tax Amount")
                {
                    ToolTip = 'Montant taxe';
                }
                field("Family tax"; Rec."Family tax")
                {
                    ToolTip = 'Famille taxe';
                }
                field("Sub Family Tax"; Rec."Sub Family Tax")
                {
                    ToolTip = 'Sous-famille taxe';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Quantité';
                }
                field("Eco Tax Furniture Code"; Rec."Eco Tax Furniture Code")
                {
                    ToolTip = 'Code taxe éco mobilier';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("<Action1000000012>")
            {
                Caption = 'Update';
                Image = CreateLinesFromJob;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Update Eco Tax posted";
            }
        }
    }

    var
        DateFilterDebut: Date;
        DateFilterFin: Date;
        Total: Decimal;
}

