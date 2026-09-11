pageextension 50121 "SalesQuoteArchiveExtension" extends "Sales Quote Archive"
{
    layout
    {
        addafter("Responsibility Center")
        {
            field(ASS;Rec.ASS)
            {
                ApplicationArea = All;
                ToolTip = 'SAV';
                Editable = false;
            }
            field("No. Series";Rec."No. Series")
            {
                ApplicationArea = All;
                ToolTip = 'Souche de N°';
                Editable = false;
            }
        }
        addafter("Prices Including VAT")
        {
            field("Factor Code";Rec."Factor Code")
            {
                ApplicationArea = All;
                Caption = 'Code banque';
                ToolTip = 'Code banque';
            }
            
        }
    }
    actions
    {
        addafter(Restore)
        {
            action("Créer document vente")
            {
                ApplicationArea = All;
                ToolTip = 'Créer document vente';
                            
                trigger OnAction()
                var
                    ArchiveMgt: Codeunit "Gestion archives doc ABRANE";
                begin
                    ArchiveMgt.CreateSalesDocument(Rec);

                end;
            }
        }
    }
}
