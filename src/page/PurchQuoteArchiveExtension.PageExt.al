pageextension 50122 "PurchQuoteArchiveExtension" extends "Purchase Quote Archive"
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
