page 50149 "Fiche document OCR Vente"
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
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field("Date OCRisation"; Rec."Date OCRisation")
                {
                    Editable = false;
                }
                field("Date document"; Rec."Date document")
                {
                    Editable = false;
                }
                field("No. document client"; Rec."No. document client")
                {
                }
                field("No. contact societe"; Rec."No. contact societe")
                {
                }
                field("No. donneur ordre"; Rec."No. donneur ordre")
                {
                    Editable = false;
                }
                field("Nom donneur d'ordre"; Rec."Nom donneur d'ordre")
                {
                }
                field("No. contact personne"; Rec."No. contact personne")
                {
                }
                field("Nom contact personne"; Rec."Nom contact personne")
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
                            if EnteteDoc.Get(Rec."Type document NAV", Rec."No. document NAV") then begin
                                PAGE.Run(PAGE::"Sales Quote", EnteteDoc);
                            end;
                    end;
                }
                field("Montant HT OCR"; Rec."Montant HT OCR")
                {
                    Editable = false;
                }
                field("Montant HT NAV (hors port)"; Rec."Montant HT NAV (hors port)")
                {
                    Editable = false;
                }
                field("Montant port HT OCR"; Rec."Montant port HT OCR")
                {
                    Editable = false;
                }
                field("Montant TVA OCR"; Rec."Montant TVA OCR")
                {
                    Editable = false;
                }
                field("Total TTC OCR"; Rec."Total TTC OCR")
                {
                    Editable = false;
                }
                field("URL document"; Rec."URL document")
                {
                    Editable = false;
                    ExtendedDatatype = URL;
                }
                field("Commentaire valideur"; Rec."Commentaire valideur")
                {
                }
                field("Document OCR traite"; Rec."Document OCR traite")
                {
                    Editable = false;
                }
            }
            part("Lignes OCR"; "Sous-form document OCR Vente")
            {
                Caption = 'Lignes OCR';
                SubPageLink = "No. document OCR" = FIELD("No.");
            }
            group(Client)
            {
                group(OCR)
                {
                    Caption = 'OCR';
                    field("GUID Societe"; Rec."GUID Societe")
                    {
                        Editable = false;
                    }
                    field("Nom client OCR"; Rec."Nom client OCR")
                    {
                        Editable = false;
                    }
                    field("Nom client 2 OCR"; Rec."Nom client 2 OCR")
                    {
                        Editable = false;
                    }
                    field("Adresse client OCR"; Rec."Adresse client OCR")
                    {
                        Editable = false;
                    }
                    field("Adresse client 2 OCR"; Rec."Adresse client 2 OCR")
                    {
                        Editable = false;
                    }
                    field("Code postal client OCR"; Rec."Code postal client OCR")
                    {
                        Editable = false;
                    }
                    field("Ville client OCR"; Rec."Ville client OCR")
                    {
                        Editable = false;
                    }
                    field("Code pays client OCR"; Rec."Code pays client OCR")
                    {
                        Editable = false;
                    }
                    field("GUID Personne"; Rec."GUID Personne")
                    {
                        Editable = false;
                    }
                    field("Email expediteur"; Rec."Email expediteur")
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
                    field("GUID destinataire"; Rec."GUID destinataire")
                    {
                        Editable = false;
                    }
                    field("Nom destinataire OCR"; Rec."Nom destinataire OCR")
                    {
                        Editable = NouvelleAdresse;
                    }
                    field("Nom destinataire 2 OCR"; Rec."Nom destinataire 2 OCR")
                    {
                        Editable = NouvelleAdresse;
                    }
                    field("Adresse destinataire OCR"; Rec."Adresse destinataire OCR")
                    {
                        Editable = NouvelleAdresse;
                    }
                    field("Adresse destinataire 2 OCR"; Rec."Adresse destinataire 2 OCR")
                    {
                        Editable = NouvelleAdresse;
                    }
                    field("Code postal destinataire OCR"; Rec."Code postal destinataire OCR")
                    {
                        Editable = NouvelleAdresse;
                    }
                    field("Ville destinataire OCR"; Rec."Ville destinataire OCR")
                    {
                        Editable = NouvelleAdresse;
                    }
                    field("Code pays destinataire OCR"; Rec."Code pays destinataire OCR")
                    {
                        Editable = NouvelleAdresse;
                    }
                    field("No. telephone destinataire"; Rec."No. telephone destinataire")
                    {
                        Editable = NouvelleAdresse;
                    }
                    field("EMail livraison"; Rec."EMail livraison")
                    {
                        Editable = false;
                    }
                }
                group(Control1000000032)
                {
                    Caption = 'NAV';
                    field("Code destinataire"; Rec."Code destinataire")
                    {
                    }
                    field(NomPourTranspAdr1Liv; Rec."Nom pour transporteur")
                    {
                    }
                    field(AdrPourTranspAdr1Liv; Rec."Adresse pour transporteur")
                    {
                    }
                    field(Adr2PourTranspAdr1Liv; Rec."Adresse 2 pour transporteur")
                    {
                    }
                    field(CPPourTranspAdr1Liv; Rec."Code postal pour transporteur")
                    {
                    }
                    field(VillePourTranspAdr1Liv; Rec."Ville pour transporteur")
                    {
                    }
                    field("Nom contact pour transporteur"; Rec."Nom contact pour transporteur")
                    {
                        ApplicationArea = All;
                    }
                    field("Prenom contact pour transport."; Rec."Prenom contact pour transport.")
                    {
                        ApplicationArea = All;
                    }
                    field("No. tel. prioritaire livraison"; Rec."No. tel. prioritaire livraison")
                    {
                        ApplicationArea = All;
                    }
                    field("Autre No. telephone livraison"; Rec."Autre No. telephone livraison")
                    {
                        ApplicationArea = All;
                    }
                    field(EMailLivraisonLiv1; Rec."EMail livraison")
                    {
                        ApplicationArea = All;
                    }
                    field("Instruction livraison 1"; Rec."Instruction livraison 1")
                    {
                        ApplicationArea = All;
                    }
                    field("Instruction livraison 2"; Rec."Instruction livraison 2")
                    {
                        ApplicationArea = All;
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
            group("Création nouveau client")
            {
                Caption = 'Création nouveau client';
                field("Creer client No."; Rec."Creer client No.")
                {
                }
                field("Nom nouveau client"; Rec."Nom nouveau client")
                {
                }
                field("Nom 2 nouveau client"; Rec."Nom 2 nouveau client")
                {
                }
                field("Adresse nouveau client"; Rec."Adresse nouveau client")
                {
                }
                field("Adresse 2 nouveau client"; Rec."Adresse 2 nouveau client")
                {
                }
                field("Code postal nouveau client"; Rec."Code postal nouveau client")
                {
                }
                field("Ville nouveau client"; Rec."Ville nouveau client")
                {
                }
                field("Code pays nouveau client"; Rec."Code pays nouveau client")
                {
                }
                field("Code etablissement nouv. clt"; Rec."Code etablissement nouv. clt")
                {
                }
                group(Transporteur)
                {
                    Caption = 'Transporteur';
                    field(NomPourTranspAdr1; Rec."Nom pour transporteur")
                    {
                    }
                    field(AdrPourTranspAdr1; Rec."Adresse pour transporteur")
                    {
                    }
                    field(Adr2PourTranspAdr1; Rec."Adresse 2 pour transporteur")
                    {
                    }
                    field(CPPourTranspAdr1; Rec."Code postal pour transporteur")
                    {
                    }
                    field(VillePourTranspAdr1; Rec."Ville pour transporteur")
                    {
                    }
                }
            }
            group("Création nouvelle adresse")
            {
                Caption = 'Création nouvelle adresse';
                field("Creer nouvelle adresse"; Rec."Creer nouvelle adresse")
                {
                }
                group(Adresse)
                {
                    Caption = 'Adresse';
                    field("Nom nouveau destinataire"; Rec."Nom nouveau destinataire")
                    {
                    }
                    field("Nom 2 nouveau destinataire"; Rec."Nom 2 nouveau destinataire")
                    {
                    }
                    field("Adresse nouveau destinataire"; Rec."Adresse nouveau destinataire")
                    {
                    }
                    field("Adresse 2 nouveau destinataire"; Rec."Adresse 2 nouveau destinataire")
                    {
                    }
                    field("Code postal nouveau dest."; Rec."Code postal nouveau dest.")
                    {
                    }
                    field("Ville nouveau destinataire"; Rec."Ville nouveau destinataire")
                    {
                    }
                    field("Code pays nouveau dest."; Rec."Code pays nouveau dest.")
                    {
                    }
                    field("Instr.  livraison 1 nouv. dest"; Rec."Instr.  livraison 1 nouv. dest")
                    {
                    }
                    field("Instr.  livraison 2 nouv. dest"; Rec."Instr.  livraison 2 nouv. dest")
                    {
                    }
                    field("Tel. priorit. livr nouv. dest"; Rec."Tel. priorit. livr nouv. dest")
                    {
                    }
                    field("E-mail nouveau destinataire"; Rec."E-mail nouveau destinataire")
                    {
                    }
                }
                group(Control1000000085)
                {
                    Caption = 'Transporteur';
                    field("Nom pour transporteur"; Rec."Nom pour transporteur")
                    {
                    }
                    field("Adresse pour transporteur"; Rec."Adresse pour transporteur")
                    {
                    }
                    field("Adresse 2 pour transporteur"; Rec."Adresse 2 pour transporteur")
                    {
                    }
                    field("Code postal pour transporteur"; Rec."Code postal pour transporteur")
                    {
                    }
                    field("Ville pour transporteur"; Rec."Ville pour transporteur")
                    {
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Créer client")
            {
                Caption = 'Créer client';
                Image = NewCustomer;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.CreerClient();
                end;
            }
            /*
            action("Créer l'adresse")
            {
                Caption = 'Créer l''adresse';
                Image = ShipAddress;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.CreerAdrDest();
                end;
            }
            */
            action("Créer devis")
            {
                Caption = 'Créer devis';
                Image = NewOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.CreerDocumentVente();
                end;
            }
        }
    }

    var
        NouvelleAdresse: Boolean;
}

