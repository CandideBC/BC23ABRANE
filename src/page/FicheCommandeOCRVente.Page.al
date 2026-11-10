page 50149 "Fiche commande OCR Vente"
{
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Entete OCR vente";

    layout
    {
        area(content)
        {
            group("Général")
            {
                Editable = (NOT Rec."Document OCR traite");
                field("No. commande client";Rec."No. commande client")
                {
                    Editable = false;
                    ToolTip = 'N° de la commande figurant sur la commande du client';
                }
                field("Date OCRisation"; Rec."Date OCRisation")
                {
                    Editable = false;
                    ToolTip = 'Date à laquelle le document a été envoyé à BC par le système OCR.';
                }
                field("Date commande"; Rec."Date commande")
                {
                    Editable = false;
                    ToolTip = 'Date commande';
                }
                /*
                field("No. contact societe"; Rec."No. contact societe")
                {
                }
                */
                field("No. donneur ordre"; Rec."No. donneur ordre")
                {
                    Editable = false;
                }
                field("Nom donneur d'ordre"; Rec."Nom donneur d'ordre")
                {
                }


                field("Type document NAV"; Rec."Type document NAV")
                {
                    Editable = false;
                }
                field("No. document NAV"; Rec."No. document NAV")
                {
                    Editable = false;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        EnteteDoc: Record "Sales Header";
                    begin
                        if Rec."No. document NAV" <> '' then
                            if EnteteDoc.Get(Rec."Type document NAV", Rec."No. document NAV") then 
                                PAGE.Run(PAGE::"Sales Quote", EnteteDoc);
                            
                    end;
                }
                field("Montant HT OCR"; Rec."Montant HT OCR")
                {
                    Editable = false;
                }
                field("Document OCR traite"; Rec."Document OCR traite")
                {
                    Editable = false;
                }
            }
            part("Lignes OCR"; "Sous-form document OCR Vente")
            {
                Caption = 'Lignes OCR';
                SubPageLink = "ID document OCR" = field("ID document OCR");
            }
            group(Client)
            {
                group(OCR)
                {
                    Caption = 'OCR';

                    field("Nom facturation OCR";Rec."Nom facturation OCR")
                    {
                        Editable = false;
                    }
                    field("Nom facturation 2 OCR";Rec."Nom facturation 2 OCR")
                    {
                        Editable = false;
                    }
                    field("Adresse facturation OCR";Rec."Adresse facturation OCR")
                    {
                        Editable = false;
                    }
                    field("Adresse facturation 2 OCR";Rec."Adresse facturation 2 OCR")
                    {
                        Editable = false;
                    }
                    field("CP facturation OCR";Rec."CP facturation OCR")
                    {
                        Editable = false;
                    }
                    field("Ville facturation OCR";Rec."Ville facturation OCR")
                    {
                        Editable = false;
                    }
                    field("Pays facturation OCR";Rec."Pays facturation OCR")
                    {
                        Editable = false;
                    }

                    field("Email facturation";Rec."Email facturation")
                    {
                        Editable = false;
                    }
                }
                group(NAV)
                {
                    Caption = 'NAV';
                    field(NoDonneurOrdre2; Rec."No. donneur ordre")
                    {
                    }
                    field("Nom client NAV"; Rec."Nom client NAV")
                    {
                    }
                    field("Nom client 2 NAV"; Rec."Nom client 2 NAV")
                    {
                    }
                    field("Adresse client NAV"; Rec."Adresse client NAV")
                    {
                    }
                    field("Adresse client 2 NAV"; Rec."Adresse client 2 NAV")
                    {
                    }
                    field("Code postal client NAV"; Rec."Code postal client NAV")
                    {
                    }
                    field("Ville client NAV"; Rec."Ville client NAV")
                    {
                    }
                    field("Code pays client NAV"; Rec."Code pays client NAV")
                    {
                    }
                }
            }
            group(Livraison)
            {
                Editable = (NOT Rec."Document OCR traite");
                group(Control1000000031)
                {
                    Caption = 'OCR';

                    field("Nom livraison OCR";Rec."Nom livraison OCR")
                    {
                        Editable = NouvelleAdresse;
                    }
                    field("Nom livraison 2 OCR";Rec."Nom livraison 2 OCR")
                    {
                        Editable = NouvelleAdresse;
                    }
                    field("Adresse livraison OCR";Rec."Adresse livraison OCR")
                    {
                        Editable = NouvelleAdresse;
                    }
                    field("Adresse livraison 2 OCR";Rec."Adresse livraison 2 OCR")
                    {
                        Editable = NouvelleAdresse;
                    }
                    field("CP livraison OCR";Rec."CP livraison OCR")
                    {
                        Editable = NouvelleAdresse;
                    }
                    field("Ville livraison OCR"; Rec."Ville livraison OCR")
                    {
                        Editable = NouvelleAdresse;
                    }
                    field("Code pays livraison OCR"; Rec."Code pays livraison OCR")
                    {
                        Editable = NouvelleAdresse;
                    }
                    field("No. telephone livraison"; Rec."No. telephone livraison")
                    {
                        Editable = NouvelleAdresse;
                    }

                }
                group(Control1000000032)
                {
                    Caption = 'NAV';
                    field("Code destinataire"; Rec."Code destinataire")
                    {
                    }
                    /*
                    field("Nom destinataire NAV"; Rec."Nom destinataire NAV")
                    {
                    }
                    field("Nom destinataire 2 NAV"; Rec."Nom destinataire 2 NAV")
                    {
                    }
                    field("Adresse destinataire NAV"; Rec."Adresse destinataire NAV")
                    {
                    }
                    field("Adresse destinataire 2 NAV"; Rec."Adresse destinataire 2 NAV")
                    {
                    }
                    field("Code postal destinataire NAV"; Rec."Code postal destinataire NAV")
                    {
                    }
                    field("Ville destinataire NAV"; Rec."Ville destinataire NAV")
                    {
                    }
                    field("Code pays destinataire NAV"; Rec."Code pays destinataire NAV")
                    {
                    }
                    */
                }
            }

        }
    }

    actions
    {
        area(processing)
        {


            action("Créer commande")
            {
                Caption = 'Créer devis';
                Image = NewOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.CreerCommandeVente();
                end;
            }
        }
    }

    var
        NouvelleAdresse: Boolean;
}

