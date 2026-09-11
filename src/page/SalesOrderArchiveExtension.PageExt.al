pageextension 50127 "SalesOrderArchiveExtension" extends "Sales Order Archive"
{
    layout
    {

        addafter(Status)
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
            field("Factor Code";Rec."Factor Code")
            {
                ApplicationArea = All;
                ToolTip = 'Code banque';
            }
            field("Montant archive"; Rec."Montant archive")
            {
                ApplicationArea = All;
                ToolTip = 'Montant archivé';
            }
            
            
        }

    }
    actions
    {
        addlast(processing)
        {
            action(CreerDocVente)
            {
                ToolTip = 'Créer document vente';
                ApplicationArea = All;
                Image = CopyDocument;
                trigger OnAction()
                var
                    ArchiveMgt: Codeunit "Gestion archives doc ABRANE";
                begin
                    //<C04.01 DIAG.RGO 05/08/2014>
                    ArchiveMgt.CreateSalesDocument(Rec);
                    //</C04.01 DIAG.RGO 05/08/2014>
                end;
            }
        }
    }
}
