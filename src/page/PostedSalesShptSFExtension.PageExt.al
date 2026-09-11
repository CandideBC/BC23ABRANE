pageextension 50028 PostedSalesShptSFExtension extends "Posted Sales Shpt. Subform"
{

    layout
    {
        addafter("Unit of Measure")
        {

            field("Quantite a remettre en stock";REC."Quantite a remettre en stock" )
            {
                ToolTip = 'Quantité à remettre en stock';
                Editable = true;
            }
            field("Quantite deja remise en stock";REC."Quantite deja remise en stock" )
            {
                ToolTip = 'Quantité déja remise en stock';
            }
            field("Quantite deja livree";Rec."Quantite deja livree")
            {
                ApplicationArea = All;
                BlankZero = true;
                DecimalPlaces = 0:5;
                ToolTip = 'Quantité déjà livrée précédemment';
            }
            field("Quantite commandee"; Rec."Quantite commandee")
            {
                ApplicationArea = All;
                BlankZero = true;
                DecimalPlaces = 0:5;
                ToolTip = 'Quantité commandée au moment où le BL a été généré.';
            }

            field("Quantite colisee"; Rec."Quantite colisee")
            {
                ApplicationArea = All;
                ToolTip = 'Quantité mise en colis/palettes.';
            }
            
            
            field("Line No."; Rec."Line No.")
            {
                ToolTip = 'N° ligne';
            }

        }


        
    }

    actions
    {
        addafter(UndoShipment)
        {
            action("Transférer les lignes sélectionnées")
            {
                /*
                    CaptionML=FRA=&Transfrer les lignes slectionnes;
                      Image=TransferToLines;
                      OnAction=VAR
                                 SalesShp@1000000000 : Record 111;
                               BEGIN
                                 SalesShp.COPY(Rec);
                                 CurrPage.SETSELECTIONFILTER(SalesShp);
                                 SalesShp.TransferLines(SalesShp);
                               END
                */
                Caption = 'Transférer les lignes sélectionnées';
                ToolTip = 'Transférer les lignes sélectionnées';
                //Image = PrintInstallment;
                
                trigger OnAction()
                var
                    SalesShp: Record "Sales Shipment Line";
                    
                begin
                    SalesShp.COPY(Rec);
                    CurrPage.SETSELECTIONFILTER(SalesShp);
                    SalesShp.TransferLine(SalesShp);
                    
                end;

            }
            action("Affectations achats/ventes")
            {
                Caption = 'Affectations achats/ventes';
                ToolTip = 'Affectations achats/ventes';
                Image = PrintInstallment;
                ShortcutKey = 'Ctrl+D';
                RunObject=page "Affectations achat vente";
                RunPageLink= "No. document achat"=field("Document No."),"No. ligne document achat"=field("Line No.");

            }
        }
    }     
}

