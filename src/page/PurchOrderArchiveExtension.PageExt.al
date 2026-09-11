pageextension 50123 "PurchOrderArchiveExtension" extends "Purchase Order Archive"
{
    layout
    {

    }
    actions
    {
        addafter(Print)
        {
            action("Créer document achat")
            {
                ApplicationArea = All;
                ToolTip = 'Créer document vente';
                Image = CopyDocument;
                            
                trigger OnAction()
                var
                    ArchiveMgt: Codeunit "Gestion archives doc ABRANE";
                begin
                    ArchiveMgt.CreatePurchDocument(Rec);

                end;
            }
        }
    }
}
