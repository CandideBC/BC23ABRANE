page 50092 "SF Montant a charger par sem"
{
    Caption = 'Commandes';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "Purchase Header";
    SourceTableView = sorting("Document Type", "Suivi container", "Suivi container OK", "Semaine chargement", "Buy-from Vendor No.")
                      where("Suivi container" = const(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ToolTip = 'N°';
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'N° preneur d''ordre';
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    Editable = false;
                    ToolTip = 'Nom preneur d''ordre';
                }
                field(Commentaires; Rec.Commentaires)
                {
                    Editable = false;
                    ToolTip = 'Commentaires';
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    Editable = false;
                    ToolTip = 'Code acheteur';
                }


                field(CalcMontantRestantACharger; MontantACharger)
                {
                    Caption = 'Montant restant à charger';
                    ToolTip = 'Montant restant à charger';
                    Editable = false;
                }
                field(PoidsNetACharger; PoidsNetACharger)
                {
                    Caption = 'Poids restant à charger';
                    ToolTip = 'Poids restant à charger';
                    Editable = false;
                    BlankZero = true;
                }
                field(LignesSansCout; LignesSansCout)
                {
                    Caption = 'Lignes sans coût';
                    ToolTip = 'Lignes sans coût';
                    Editable = false;
                    BlankZero = true;
                }
                field(NbLignesSansPoids; NbLignesSansPoids)
                {
                    Caption = 'Lignes sans poids';
                    ToolTip = 'Lignes sans poids net';
                    Editable = false;
                    BlankZero = true;
                }
                field(NbDIVSansHSCode; NbDIVSansHSCode)
                {
                    Caption = 'Lignes sans HS Code';
                    ToolTip = 'Lignes sans HS Code';
                    Editable = false;
                    BlankZero = true;
                }
                field("Date intention chargement"; Rec."Date intention chargement")
                {
                    Caption = 'Date intention chargement';
                    ToolTip = 'Date de la semaine de chargement';
                    //Editable = false;

                }
                field("Semaine chargement"; Rec."Semaine chargement")
                {
                    BlankZero = true;
                    Editable = false;
                    ToolTip = 'Semaine chargement';
                }
                field("Date chargement confirmee"; Rec."Date chargement confirmee")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date chargement confirmée';
                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    Caption = 'Date réception prévue';
                    Editable = false;
                    //Visible = false;
                    ToolTip = 'Date réception prévue';
                }
                field("Commentaires pour AIE"; Rec."Commentaires pour AIE")
                {
                    ToolTip = 'Commentaires pour AIE';
                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }
                field("Livraison directe"; Rec."Livraison directe")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indique si la commande est en livraison directe.';
                }

                field("Commentaires prev. transport"; Rec."Commentaires prev. transport")
                {
                    ToolTip = 'Commentaires prev. transport';

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }

                field("No. doc. vente"; Rec."No. doc. vente")
                {
                    Caption = 'N° doc vente';
                    ToolTip = 'N° doc vente';
                    Editable = false;
                }
                field("Info phases";Rec."Info phases")
                {
                    ApplicationArea = All;
                    ToolTip = 'Informations concernant la phase du document de vente lié.';
                    Editable = false;
                }
                field("Date livraison chantier";Rec."Date livraison chantier")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date livraison chantier';
                    Editable = false;
                }
                
                
                field(NumerosDossiersBE; NumerosDossiersBE)
                {
                    Caption = 'Dossier(s) BE';
                    ToolTip = 'Indique le(s) dossier(s) BE lié(s).';
                    Editable = false;

                }

                field("Commentaires suivi production"; Rec."Commentaires suivi production")
                {
                    ToolTip = 'Commentaires suivi production';

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }

                field("Buy-from City"; Rec."Buy-from City")
                {
                    ToolTip = 'Ville preneur d''ordre';
                    Editable = false;
                    Visible = false;
                }
                field("Buy-from Country/Region Code"; Rec."Buy-from Country/Region Code")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Code pays preneur d''ordre';
                }
                field("Order Date"; Rec."Order Date")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Date commande';
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Date réception demandée';
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Date réception confirmée';
                }
                field("Semaine reception prevue"; Rec."Semaine reception prevue")
                {
                    BlankZero = true;
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Semaine réception prévue';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Ouvrir commande achat")
            {
                Caption = 'Ouvrir commande achat';
                ToolTip = 'Ouvrir commande achat';
                RunObject = Page "Purchase Order";
                RunPageLink = "No." = field("No.");
            }
            action("Ouvrir document vente")
            {
                Caption = 'Ouvrir document vente';
                ToolTip = 'Ouvrir document vente';

                trigger OnAction()
                var
                    DocumentExistePlusMsg: Label 'Le document %1 n''existe plus, impossible de l''afficher.',Comment = '%1 = Type et N° de document de vente';
                begin
                    if Rec."No. doc. vente" <> '' then 
                            case Rec."Type doc. vente" of
                                Rec."Type doc. vente"::Quote : 
                                    if EnteteVente.Get(EnteteVente."Document Type"::Quote, Rec."No. doc. vente") then
                                        PAGE.Run(PAGE::"Sales Quote", EnteteVente);
                                rec."Type doc. vente"::Order : 
                                    if EnteteVente.Get(EnteteVente."Document Type"::Order, Rec."No. doc. vente") then
                                        PAGE.Run(PAGE::"Sales Order", EnteteVente);
                                else
                                    Error(DocumentExistePlusMsg,Rec."No. doc. vente");
                            end;
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.CalcValeursResteACharger(MontantACharger, PoidsNetACharger, LignesSansCout, NbDIVSansHSCode, NbLignesSansPoids);
        if Rec."Info phases" ='Multiple' then
            DateLivDemandeeTxt := '';
    end;

    var
        EnteteVente: Record "Sales Header";
        NumerosDossiersBE: Text[80];
        DateLivDemandeeTxt: Text[20];
        MontantACharger: Decimal;
        PoidsNetACharger: Decimal;
        LignesSansCout: Integer;
        NbDIVSansHSCode: Integer;
        NbLignesSansPoids: Integer;

}

