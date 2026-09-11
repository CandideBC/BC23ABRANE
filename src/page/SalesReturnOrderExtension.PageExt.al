pageextension 50106 SalesReturnOrderExtension extends "Sales Return Order"
{
    layout
    {

        modify("Campaign No.")
        {
            Visible = false;
        }

        modify("Responsibility Center")
        {
            Visible = false;
        }

        modify("Assigned User ID")
        {
            Visible = false;
        }

        modify("Job Queue Status")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
                        
        addafter("Salesperson Code")
        {
            field("Code chantier"; Rec."Code chantier")
            {
                ApplicationArea = All;
                ToolTip = 'Code chantier';
            }
            field("Code groupe"; Rec."Code groupe")
            {
                ApplicationArea = All;
                ToolTip = 'Code groupe';
            }
            
            field("Code enseigne"; Rec."Code enseigne")
            {
                ApplicationArea = All;
                ToolTip = 'Code enseigne';
            }
            field("Code operation"; Rec."Code operation")
            {
                ApplicationArea = All;
                ToolTip = 'Code opération';
            }

        }
        addafter(Status)
        {
            field("Range No."; Rec."Range No.")
            {
                ApplicationArea = All;
                ToolTip = 'Code rayon';
            }
            field("Reason Code"; Rec."Reason Code")
            {
                ApplicationArea = All;
                ToolTip = 'Code motif';
            }
            field(Commentaire; Rec.Commentaire)
            {
                ApplicationArea = All;
                ToolTip = 'Commentaires';
            }
        }
        addafter("Bill-to")
        {
            field("Invoice-to Code"; Rec."Invoice-to Code")
            {
                ApplicationArea = All;
                ToolTip = 'Code adresse facturation';
            }
        }
        addafter("Applies-to ID")
        {
            field(Factoring;Rec.Factoring)
            {
                ApplicationArea = All;
                ToolTip = 'Factoring';
            }
        }
        addafter("Shipment Date")
        {
            field("Total Net Weight"; Rec."Total Net Weight")
            {
                ApplicationArea = All;
                ToolTip = 'Poids net total';
            }

            field("Poids brut total"; Rec."Poids brut total")
            {
                ApplicationArea = All;
                ToolTip = 'Poids brut total';
            }
            field("Nombre de colis"; Rec."Nombre de colis")
            {
                ApplicationArea = All;
                ToolTip = 'Nombre de colis';
            }
            field("Nombre de palettes"; Rec."Nombre de palettes")
            {
                ApplicationArea = All;
                ToolTip = 'N° palette';
            }
        }
    }
    actions
    {
        addlast(processing)
        {
            action("Calculer Poids total")
            {
                ApplicationArea = All;
                ToolTip = 'Calculer poids total';
                Promoted=true;
                Image=SuggestNumber;
                PromotedCategory=Process;
                trigger OnAction()
                begin
                    WeightCalculate();
                end;
            }
        }
    }

    procedure WeightCalculate();
    var
        l_SalesLine : Record 37;
        l_TotalNetWeight : Decimal;
        l_TotalGrossWeight : Decimal;
    begin
        //>>DIA@NDE 19/02/15  Fonction calulant le ppids total des lignes d'articles
        l_TotalNetWeight := 0;
        l_TotalGrossWeight := 0;
        l_SalesLine.SETRANGE("Document Type",l_SalesLine."Document Type"::"Return Order");
        l_SalesLine.SETRANGE("Document No.",Rec."No.");
        l_SalesLine.SETRANGE(Type,l_SalesLine.Type::Item);
        l_SalesLine.SETRANGE("Ligne eclatee",false);
        if l_SalesLine.FINDSET(false) then 
            repeat
                l_TotalNetWeight := l_TotalNetWeight + (l_SalesLine."Net Weight" * l_SalesLine."Return Qty. to Receive");
                l_TotalGrossWeight := l_TotalGrossWeight + (l_SalesLine."Gross Weight" * l_SalesLine."Return Qty. to Receive");
            until l_SalesLine.NEXT() = 0;
        Rec."Total Net Weight" := l_TotalNetWeight;
        Rec."Poids brut total" := l_TotalGrossWeight;
    end;

}
