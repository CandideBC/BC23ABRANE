pageextension 50056 "SalesOrderArchivesExtension" extends "Sales Order Archives"
{
    layout
    {


        
        addafter("Shipment Date")
        {
            field(Comments; Rec.Comments)
            {
                ApplicationArea = All;
                ToolTip = 'Commentaires';
            }
            field(Ass; Rec.ASS)
            {
                ApplicationArea = All;
                ToolTip = 'SAV';
            }
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = All;
                ToolTip = 'N° souche validation';
            }
            field("Montant archive"; Rec."Montant archive")
            {
                ApplicationArea = All;
                ToolTip = 'Montant archivé';
            }
            
        }

    }
}
