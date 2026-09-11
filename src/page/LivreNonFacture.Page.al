page 50050 "Livre non facture"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Livré non facturé';
    Editable = false;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Sales Line";
    SourceTableView = sorting("Document Type", "Document No.", "Line No.")
                      where("Document Type" = const(Order),
                            "Shipped Not Invoiced" = filter(<> 0));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'N° document';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'N° donneur d''ordre';
                }
                field("Nom du client"; Rec."Nom du client")
                {
                    ToolTip = 'Nom du client';
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'N° ligne';
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Type';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'N°';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ToolTip = 'Code variante';
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Code magasin';
                    Visible = true;
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Quantité';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Code unité';
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ToolTip = 'Montant ligne';
                    BlankZero = true;
                }
                field("Quantity Shipped"; Rec."Quantity Shipped")
                {
                    ToolTip = 'Quantité expédiée';
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    ToolTip = 'Quantité facturée';
                }
                field("Qty. Shipped Not Invd. (Base)"; Rec."Qty. Shipped Not Invd. (Base)")
                {
                    ToolTip = 'Qté livrée non facturée (Base)';
                }
                field("Shipped Not Invoiced"; Rec."Shipped Not Invoiced")
                {
                    ToolTip = 'Livré non facturé';
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                    ToolTip = 'Quantité restante';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Ligne")
            {
                Caption = '&Line';
                Image = Line;
                action("Afficher document")
                {
                    Caption = 'Afficher document';
                    ToolTip = 'Afficher document';
                    Image = View;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction()
                    begin
                        SalesHeader.Get(Rec."Document Type", Rec."Document No.");
                        case Rec."Document Type" of
                            Rec."Document Type"::Quote:
                                PAGE.Run(PAGE::"Sales Quote", SalesHeader);
                            Rec."Document Type"::Order:
                                PAGE.Run(PAGE::"Sales Order", SalesHeader);
                            Rec."Document Type"::Invoice:
                                PAGE.Run(PAGE::"Sales Invoice", SalesHeader);
                            Rec."Document Type"::"Return Order":
                                PAGE.Run(PAGE::"Sales Return Order", SalesHeader);
                            Rec."Document Type"::"Credit Memo":
                                PAGE.Run(PAGE::"Sales Credit Memo", SalesHeader);
                            Rec."Document Type"::"Blanket Order":
                                PAGE.Run(PAGE::"Blanket Sales Order", SalesHeader);
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Clear(ShortcutDimCode);
    end;

    var
        SalesHeader: Record "Sales Header";
        ShortcutDimCode: array[8] of Code[20];
}

