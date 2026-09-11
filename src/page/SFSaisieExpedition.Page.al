page 50125 "SF Saisie expedition"
{
    Caption = 'Lignes commandes';
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Sales Line";
    SourceTableView = sorting("Document Type", "Document No.", Type, "No.", "System-Created Entry") where("Document Type" = filter(Order),Type=const(Item));
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Type; Rec.Type)
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Indique le type de la ligne.';
                    Editable = false;
                }

                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Indique le N° de compte ou d''article.';
                    Editable = false;
                }

                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indique la variante de l''article';
                    Visible = false;
                    Editable = false;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Indique la désignation.';
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Indique la désignation 2.';
                    Visible = false;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Location;
                    Editable = false;
                    ToolTip = 'Indique le magasin depuis lequel la ligne sera livrée.';
                    Visible = false;


                }
                field(Phase; Rec.Phase)
                {
                    ApplicationArea = All;
                    ToolTip = 'Phase';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    Editable = false;
                    ToolTip = 'Indique la quantité vendue.';

                }

                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Indique l''unité dans la laquelle l''article est vendu.';
                    Visible = false;
                }
                field("Qty. to Ship"; Rec."Qty. to Ship")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    ToolTip = 'Indique la quantité que vous voulez expédier.';
                }

                field("No. UC"; Rec."No. UC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Vous pouvez soit choisir une UC existante, soit taper + pour en créer une nouvelle.';
                }
                field("Quantite prepa colisage"; Rec."Quantite prepa colisage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indique quelle quantité de la ligne est déjà en préparation.';
                }
                
                
                field("Quantity Shipped"; Rec."Quantity Shipped")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    QuickEntry = false;
                    ToolTip = 'Indique la quantité qui a déjà été expédiée.';

                    trigger OnDrillDown()
                    var
                        SalesShipmentLine: Record "Sales Shipment Line";
                    begin
                        SalesShipmentLine.SetCurrentKey("Document No.", "No.", "Shipment Date");
                        SalesShipmentLine.SetRange("Order No.", Rec."Document No.");
                        SalesShipmentLine.SetRange("Order Line No.", Rec."Line No.");
                        SalesShipmentLine.SetFilter(Quantity, '<>%1', 0);
                        Page.RunModal(0, SalesShipmentLine);
                    end;
                }

                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    ToolTip = 'Specifies how many units of the item on the line have been posted as invoiced.';

                    trigger OnDrillDown()
                    var
                        SalesInvoiceLine: Record "Sales Invoice Line";
                    begin
                        SalesInvoiceLine.SetCurrentKey("Document No.", "No.", "Posting Date");
                        SalesInvoiceLine.SetRange("Order No.", Rec."Document No.");
                        SalesInvoiceLine.SetRange("Order Line No.", Rec."Line No.");
                        SalesInvoiceLine.SetFilter(Quantity, '<>%1', 0);
                        Page.RunModal(0, SalesInvoiceLine);
                    end;
                }

                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the line number.';
                    Visible = false;
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    Caption = 'Unit Gross Weight';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the gross weight of one unit of the item. In the sales statistics window, the gross weight on the line is included in the total gross weight of all the lines for the particular sales document.';
                    Visible = false;
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    Caption = 'Unit Net Weight';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the net weight of one unit of the item. In the sales statistics window, the net weight on the line is included in the total net weight of all the lines for the particular sales document.';
                    Visible = false;
                }
            }
        }
    }




    actions
    {
        area(processing)
        {

            group("&Line")
            {
                Caption = '&Ligne';
                Image = Line;
                group("Fonctions")
                {
                    /*
                    Caption = 'Fonctions';
                    Image = "Action";
                    action(Reserve)
                    {
                        ApplicationArea = Reservation;
                        Caption = '&Reserve';
                        Ellipsis = true;
                        Image = Reserve;
                        Enabled = Rec.Type = Rec.Type::Item;
                        ToolTip = 'Reserve the quantity of the selected item that is required on the document line from which you opened this page. This action is available only for lines that contain an item.';

                        trigger OnAction()
                        begin
                            Rec.Find();
                            Rec.ShowReservation();
                        end;
                    }
                    */
                }
            }
        }
    }
}



