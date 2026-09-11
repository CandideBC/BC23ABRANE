pageextension 50027 PostedSalesShipmentExtension extends "Posted Sales Shipment"
{

    layout
    {
        addafter("No.")
        {
            field("Annee commande"; Rec."Annee commande")
            {
                ApplicationArea = All;
                ToolTip = 'Année commande';
                Editable = false;
            }
            
        }

        addafter("Shipment Date")
        {
            field(Phase; Rec.Phase)
            {
                ApplicationArea = All;
                ToolTip = 'N° de la phase qui a été expédiée.';
            }
            field("Libelle phase"; Rec."Libelle phase")
            {
                ApplicationArea = All;
                ToolTip = 'Libellé de la phase qui a été expédiée.';
            }
            
            
            field("Code magasin remise en stock"; Rec."Code magasin remise en stock")
            {
                ToolTip = 'Code magasin remise en stock';
            }
            field("Date remise en stock"; Rec."Date remise en stock")
            {
                ToolTip = 'Date remise en stock';
            }
            field("Comments"; Rec.Comments)
            {
                ToolTip = 'Commentaires';
            }

            field("No. And Location Name"; Rec."No. And Location Name")
            {
                ToolTip = 'N° et nom du magasin';
            }
            field("Range No."; Rec."Range No.")
            {
                ToolTip = 'Range No.';
            }
            field("Total Net Weight"; Rec."Total Net Weight")
            {
                ToolTip = 'Poids net total';
            }
            field("Poids brut total";Rec."Poids brut total")
            {
                ToolTip = 'Poids brut total';
            }
            field("Nbre colisages"; Rec."Nbre colisages")
            {
                ApplicationArea = All;
                ToolTip = 'Nombre de colisages liés à ce BL.';
            }
            

            field("Nombre de colis";Rec."Nombre de colis")
            {
                ToolTip = 'Nombre de colis';
            }
            field("Nombre de palettes";Rec."Nombre de palettes")
            {
                ToolTip = 'N° palette';
            }
            field("Facturation en compta (O/N)"; Rec."Facturation en compta (O/N)")
            {
                ToolTip = 'Facturation en compta';
            }
            field("Commentaire factu."; Rec."Commentaire factu.")
            {
                ToolTip = 'Facturation en compta';
            }
        }        
    }

    actions
    {
        modify(CertificateOfSupplyDetails)
        {
            Visible = false;
        }
        modify(PrintCertificateofSupply)
        {
            Visible = false;
        }
        modify("&Track Package")
        {
            Visible = false;
        }
        addafter("Update Document")
        {
            action("Créer colisage")
            {
                Caption = 'Créer colisage';
                ToolTip = 'Liste de colisage';
                Image = ItemTracking;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //RunObject = Page 50029;
                trigger OnAction()
                begin
                    Rec.CreerColisage(true);
                end;

            }

            action("Remettre en stock")
            {
                Caption = 'Remettre en stock';
                ToolTip = 'Remettre en stock';
                Promoted = true;
                PromotedIsBig=true;
                Image = ReturnReceipt;
                
                trigger OnAction()
                begin
                    Rec.RemettreEnStock();
                end;                
            }
        }
    }

}

