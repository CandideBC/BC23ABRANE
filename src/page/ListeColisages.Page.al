page 50029 "Liste colisages"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Liste colisages';
    CardPageID = "Fiche colisage";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Entete colisage";
    SourceTableView = sorting("No.")
                      order(descending);

    layout
    {
        area(content)
        {
            repeater(Control50000)
            {
                ShowCaption = false;

                field("No."; Rec."No.")
                {
                    ToolTip = 'N°';
                }
                field(Expedie; Rec.Expedie)
                {
                    ApplicationArea = All;
                    ToolTip = 'Indique si le colisage a été expédié.';
                }
                
                field("Packing Status"; Rec."Packing Status")
                {
                    ToolTip = 'Statut colisage';
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ToolTip = 'Date création';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'N° donneur d''ordre';
                }
                field("No. commande"; Rec."No. commande")
                {
                    ToolTip = 'N° commande';
                }
                field("No. expedition enregistree"; Rec."No. expedition enregistree")
                {
                    ApplicationArea = All;
                    ToolTip = 'N° du BL';
                }
                field(Phase; Rec.Phase)
                {
                    ApplicationArea = All;
                    ToolTip = 'Phase';
                }
                
                field("Ship-To Address Code"; Rec."Ship-To Address Code")
                {
                    ToolTip = 'Code destinataire';
                }
                field("Ship-To Name"; Rec."Ship-To Name")
                {
                    ToolTip = 'Nom destinataire';
                }
                field("Ship-To Name 2"; Rec."Ship-To Name 2")
                {
                    ToolTip = 'Nom 2 destinataire';
                    Visible = false;
                }
                field("Ship-To Address"; Rec."Ship-To Address")
                {
                    ToolTip = 'Adresse destinataire';
                }
                field("Ship-To Address 2"; Rec."Ship-To Address 2")
                {
                    ToolTip = 'Adresse 2 destinataire';
                }
                field("Ship-To City"; Rec."Ship-To City")
                {
                    ToolTip = 'Ville destinataire';
                }
                field("Ship-To Post Code"; Rec."Ship-To Post Code")
                {
                    ToolTip = 'Code postal destinataire';
                }
                field("Ship-To County Code"; Rec."Ship-To County Code")
                {
                    ToolTip = 'Code région';
                }
                field("Ship-To Country Code"; Rec."Ship-To Country Code")
                {
                    ToolTip = 'Code pays destinataire';
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ToolTip = 'Votre référence';
                }
                field("Nombre de colis"; Rec."Nombre de colis")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre de colis';
                }
                field("Nombre de palettes"; Rec."Nombre de palettes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre de palettes';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Nouveau)
            {
                Caption = 'Nouveau';
                ToolTip = 'Nouveau';
                Image = NewDocument;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if SalesShptHeader."No." <> '' then
                        NewPackingShpt(SalesShptHeader)
                    else
                        if SalesShptHeader."No." <> '' then
                            NewPacking(SalesHeader)
                        else
                            NewPackingFree();
                end;
            }
        }
        area(reporting)
        {
            action("Edition Liste de colisage")
            {
                Caption = 'Edition Liste de colisage';
                ToolTip = 'Edition Liste de colisage';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                var
                    Packing: Record "Entete colisage";
                begin
                    Rec.TestField("Packing Status", Rec."Packing Status"::"Terminé");
                    Packing.SetRange("No.", Rec."No.");
                    REPORT.RunModal(50032, true, true, Packing);
                end;
            }
            action("Edition Détail Palette")
            {
                Caption = 'Edition Détail Palette';
                ToolTip = 'Edition Détail Palette';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                var
                    Packing: Record "Entete colisage";
                begin
                    Rec.TestField("Packing Status", Rec."Packing Status"::"Terminé");
                    Packing.SetRange("No.", Rec."No.");
                    REPORT.RunModal(50031, true, true, Packing);
                end;
            }
            action("Edition Etiquette Livraison")
            {
                Caption = 'Edition Etiquette Livraison';
                ToolTip = 'Edition Etiquette Livraison';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                var
                    Packing: Record "Entete colisage";
                begin
                    Rec.TestField("Packing Status", Rec."Packing Status"::"Terminé");
                    Packing.SetRange("No.", Rec."No.");
                    REPORT.RunModal(50030, true, true, Packing);
                end;
            }
        }
    }

    /*
    trigger OnOpenPage()
    begin
        Rec.SetRange("Document No. Exists");
        Rec.SetRange("Order No. Exists");
        if SalesHeader."No." <> '' then begin
            Rec.SetRange("Order No. Filter", SalesHeader."No.");
            Rec.SetRange("Order No. Exists", true);
        end;
        if SalesShptHeader."No." <> '' then begin
            Rec.SetRange("Document No. Filter", SalesShptHeader."No.");
            Rec.SetRange("Document No. Exists", true);
        end;
    end;
    */

    var
        SalesHeader: Record "Sales Header";
        SalesShptHeader: Record "Sales Shipment Header";

    procedure SetOrder(pRec: Record "Sales Header")
    begin
        SalesHeader := pRec;
    end;

    procedure NewPacking(pHeader: Record "Sales Header")
    var
        Packing: Record "Entete colisage";
        ContenuColisage: Record "Contenu colisage";
        SalesLines: Record "Sales Line";
        fCard: Page "Fiche colisage";
        iNumLig: Integer;

        Text002Err: Label 'Pas de quantité ouverte pour cette commande %1', Comment = '%1 = No.';
    begin
        Packing.Init();
        Packing."Sell-to Customer No." := pHeader."Sell-to Customer No.";
        Packing."Ship-To Address Code" := pHeader."Ship-to Code";
        Packing."Ship-To Name" := pHeader."Ship-to Name";
        Packing."Ship-To Name 2" := pHeader."Ship-to Name 2";
        Packing."Ship-To Address" := pHeader."Ship-to Address";
        Packing."Ship-To Address 2" := pHeader."Ship-to Address 2";
        Packing."Ship-To City" := pHeader."Ship-to City";
        Packing."Ship-To Post Code" := pHeader."Ship-to Post Code";
        Packing."Ship-To County Code" := pHeader."Ship-to County";
        Packing."Ship-To Country Code" := pHeader."Ship-to Country/Region Code";
        Packing."Your Reference" := pHeader."External Document No.";
        //Packing."Bill-To Customer No." := pHeader."Bill-to Customer No.";
        //  Packing."Phone No." := "Sell-to Phone No.";
        //  Packing."Fax No." := "Sell-to Fax No.";
        //  Packing.Email := "Sell-to E-Mail";
        Packing."Code magasin" := pHeader."Location Code";

        SalesLines.SetRange("Document Type", SalesLines."Document Type"::Order);
        SalesLines.SetRange("Document No.", pHeader."No.");
        SalesLines.SetRange(Type, SalesLines.Type::Item);
        SalesLines.SetFilter("Outstanding Quantity", '<>0');
        if not SalesLines.Find('-') then
            Error(Text002Err, pHeader."No.");

        Packing.Insert(true);
        iNumLig := 0;
        repeat
            ContenuColisage.Init();
            ContenuColisage."No. colisage" := Packing."No.";
            iNumLig += 10000;
            ContenuColisage."No. ligne" := iNumLig;

            //ContenuColisage.Type := SalesLines.Type;
            case Saleslines.Type of
                SalesLines.Type::" ":
                    ContenuColisage.Type := ContenuColisage.Type::" ";
                SalesLines.Type::"Charge (Item)":
                    ContenuColisage.Type := ContenuColisage.Type::"Charge (Item)";
                SalesLines.Type::"Fixed Asset":
                    ContenuColisage.Type := ContenuColisage.Type::"Fixed Asset";
                SalesLines.Type::"G/L Account":
                    ContenuColisage.Type := ContenuColisage.Type::"G/L Account";
                SalesLines.Type::Item:
                    ContenuColisage.Type := ContenuColisage.Type::Item;
                SalesLines.Type::Resource:
                    ContenuColisage.Type := ContenuColisage.Type::Resource;
            end;
            ContenuColisage.Validate("Item No.", SalesLines."No.");
            ContenuColisage.Description := SalesLines.Description;
            ContenuColisage."Description 2" := SalesLines."Description 2";
            //ContenuColisage."Cross-Reference No." := SalesLines."Item Reference No.";
            ContenuColisage."Quantite UC" := SalesLines."Outstanding Quantity";
            ContenuColisage."Order No." := SalesLines."Document No.";
            ContenuColisage."Order Line No." := SalesLines."Line No.";

            ContenuColisage.Insert();
        until SalesLines.Next() = 0;
        Commit();
        Packing.SetRange("No.", Packing."No.");
        fCard.SetTableView(Packing);
        fCard.RunModal();
    end;

    procedure SetShipment(pRec: Record "Sales Shipment Header")
    begin
        SalesShptHeader := pRec;
    end;

    procedure NewPackingShpt(pHeader: Record "Sales Shipment Header")
    var

        EnteteColisage: Record "Entete colisage";
        ContenuColisage: Record "Contenu colisage";
        ShptLines: Record "Sales Shipment Line";

        fCard: Page "Fiche colisage";
        iNumLig: Integer;
        Text002Err: Label 'Il n''y a aucun article livré dans le BL %1', Comment = '%1 = N° BL';
    begin
        EnteteColisage.Init();
        EnteteColisage."Sell-to Customer No." := pHeader."Sell-to Customer No.";
        EnteteColisage."Ship-To Address Code" := pHeader."Ship-to Code";
        EnteteColisage."Ship-To Name" := pHeader."Ship-to Name";
        EnteteColisage."Ship-To Name 2" := pHeader."Ship-to Name 2";
        EnteteColisage."Ship-To Address" := pHeader."Ship-to Address";
        EnteteColisage."Ship-To Address 2" := pHeader."Ship-to Address 2";
        EnteteColisage."Ship-To City" := pHeader."Ship-to City";
        EnteteColisage."Ship-To Post Code" := pHeader."Ship-to Post Code";
        EnteteColisage."Ship-To County Code" := pHeader."Ship-to County";
        EnteteColisage."Ship-To Country Code" := pHeader."Ship-to Country/Region Code";
        EnteteColisage."Your Reference" := pHeader."External Document No.";
        //EnteteColisage."Bill-To Customer No." := pHeader."Bill-to Customer No.";
        EnteteColisage."Phone No." := Rec."Phone No.";
        EnteteColisage.Email := Rec.Email;
        EnteteColisage."Code magasin" := pHeader."Location Code";

        ShptLines.SetRange("Document No.", pHeader."No.");
        ShptLines.SetRange(Type, ShptLines.Type::Item);
        ShptLines.SetRange(Correction, false);
        ShptLines.SetFilter(Quantity, '<>0');
        if not ShptLines.Find('-') then
            Error(Text002Err, pHeader."No.");

        EnteteColisage.Insert(true);
        iNumLig := 0;
        repeat
            ContenuColisage.Init();
            ContenuColisage."No. colisage" := EnteteColisage."No.";
            iNumLig += 10000;
            ContenuColisage."No. ligne" := iNumLig;
            //ContenuColisage.Type := ShptLines.Type;
            case Shptlines.Type of
                ShptLines.Type::" ":
                    ContenuColisage.Type := ContenuColisage.Type::" ";
                ShptLines.Type::"Charge (Item)":
                    ContenuColisage.Type := ContenuColisage.Type::"Charge (Item)";
                ShptLines.Type::"Fixed Asset":
                    ContenuColisage.Type := ContenuColisage.Type::"Fixed Asset";
                ShptLines.Type::"G/L Account":
                    ContenuColisage.Type := ContenuColisage.Type::"G/L Account";
                ShptLines.Type::Item:
                    ContenuColisage.Type := ContenuColisage.Type::Item;
                ShptLines.Type::Resource:
                    ContenuColisage.Type := ContenuColisage.Type::Resource;
            end;

            ContenuColisage.Validate("Item No.", ShptLines."No.");
            ContenuColisage.Description := ShptLines.Description;
            ContenuColisage."Description 2" := ShptLines."Description 2";
            //ContenuColisage."Cross-Reference No." := ShptLines."Item Reference No.";
            ContenuColisage."Quantite UC" := ShptLines.Quantity;
            ContenuColisage."Shipment No." := ShptLines."Document No.";
            ContenuColisage."Shipment Line No." := ShptLines."Line No.";
            ContenuColisage."Order No." := ShptLines."Order No.";
            ContenuColisage."Order Line No." := ShptLines."Order Line No.";

            ContenuColisage.Insert();
        until ShptLines.Next() = 0;
        Commit();
        EnteteColisage.SetRange("No.", EnteteColisage."No.");
        fCard.SetTableView(EnteteColisage);
        fCard.RunModal();
    end;

    procedure NewPackingFree()
    var
        EnteteColisage: Record "Entete colisage";
        fCard: Page "Fiche colisage";
    begin
        EnteteColisage.Init();
        EnteteColisage.Insert(true);
        Commit();
        EnteteColisage.SetRange("No.", EnteteColisage."No.");
        fCard.SetTableView(EnteteColisage);
        fCard.RunModal();
    end;
}

