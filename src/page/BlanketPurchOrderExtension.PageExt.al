pageextension 50143 "Blanket Purch.Order Extension" extends "Blanket Purchase Order"
{
    layout
    {
        modify("No.")
        {
            Visible = true;
            Editable = false;
        }
        movebefore("Buy-from"; "No.")

        movebefore("Buy-from Address"; "Buy-from Vendor No.", "Buy-from Vendor Name")
        moveafter("Buy-from City"; "Buy-from Post Code")

        addafter("Buy-from")
        {
            group(Donnees)
            {
                Caption = 'Données';
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

            }
        }


        moveafter("Code enseigne"; "Location Code")
        moveafter("Location Code"; "Purchaser Code")

        addafter(Donnees)
        {
            group(Dates)
            {
                Caption = 'Dates';
                field("Date validite"; Rec."Date validite")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date de validité';
                }
                field("Date intention chargement"; Rec."Date intention chargement")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date intention chargement';
                }
            }
        }

        movebefore("Date validite"; "Document Date", "Order Date")

        addafter(Dates)
        {
            group(DescriptionTravail)
            {
                Caption = 'Description du travail';
                field(Commentaires; Rec.Commentaires)
                {
                    ApplicationArea = All;
                    ToolTip = 'Commentaires qui seront repris sur les commandes achats créées depuis la commande cadre.';
                }
            }

        }

        moveafter(Commentaires; "Language Code", "No. of Archived Versions")

        movebefore("No."; Status)

        modify("Order Address Code")
        {
            Visible = false;
        }
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
        modify("Buy-from Contact No.")
        {
            Visible = false;
        }
        modify(BuyFromContactPhoneNo)
        {
            Visible = false;
        }
        modify(BuyFromContactMobilePhoneNo)
        {
            Visible = false;
        }
        modify("Buy-from Contact")
        {
            Visible = false;
        }

        modify("Due Date")
        {
            Visible = false;
        }
        modify("Vendor Order No.")
        {
            Visible = false;
        }

        modify("Vendor Shipment No.")
        {
            Visible = false;
        }
        modify("Language Code")
        {
            Visible = true;
        }
        modify("Invoice Details")
        {
            Visible = false;
        }
        modify("Shipping and Payment")
        {
            Visible = false;
        }
        modify("Foreign Trade")
        {
            Visible = false;
        }
    }
    actions
    {

        movebefore(MakeOrder_Promoted; Print_Promoted)

        modify(CopyDocument_Promoted)
        {
            Visible = false;
        }
        modify("Request Approval")
        {
            Visible = false;
        }
        modify(CalculateInvoiceDiscount_Promoted)
        {
            Visible = false;
        }
        modify(CalculateInvoiceDiscount)
        {
            Visible = false;
        }
        modify(Approvals)
        {
            Visible = false;
        }
        modify(Dimensions_Promoted)
        {
            Visible = false;
        }
        modify(Dimensions)
        {
            Visible = false;
        }

        addafter(MakeOrder_Promoted)
        {
            actionref(ExtraireCdeType; ActionExtraireCdeType)
            {

            }
            actionref(TraduireFRA;TraduireEnFRA)
            {

            }
            actionref(TraduireENU;TraduireEnENU)
            {
                
            }
        }

        addafter(MakeOrder)
        {
            action(ActionExtraireCdeType)
            {
                ApplicationArea = Suite;
                Caption = 'Extraire commande type';
                Ellipsis = true;
                //Image = VendorCode;
                ToolTip = 'Extraire un document type lié à ce fournisseur pour ajouter des articles à votre commande cadre.';


                trigger OnAction()
                var
                    StdVendPurchCode: Record "Standard Vendor Purchase Code";
                begin
                    StdVendPurchCode.InsertPurchLines(Rec);
                end;
            }

        }
        addafter("Archi&ve Document")
        {
            group(Traduire)
            {
                Caption = 'Traduire';

                action(TraduireEnFRA)
                {
                    ApplicationArea = All;
                    Caption = 'FRA';
                    ToolTip = 'Traduire les désignations en français';
                    Image = Translate;
                    //Promoted = true;
                    //PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        rec.MAJDescriptionsEnFRA();
                    end;
                }
                action(TraduireEnENU)
                {
                    ApplicationArea = All;
                    Caption = 'ENU';
                    ToolTip = 'Traduire les désignations en anglais';
                    Image = Translate;
                    //Promoted = true;
                    //PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        rec.MAJDescriptionsEnENU();
                    end;
                }
            }



        }

        modify(Reopen)
        {
            ShortcutKey = 'Ctrl+Q';
        }

    }
}