page 50100 "Fiche dossier BE"
{
    ApplicationArea = All;
    PageType = Card;
    //PromotedActionCategories = 'Nouveau document,Traitements,Etats,Naviguer';
    SourceTable = "Dossier BE";
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            group("Général")
            {
                field("Code"; Rec."No.")
                {
                    ToolTip = 'N°';
                    Editable = false;
                }
                field("Date demande"; Rec."Date demande")
                {
                    ToolTip = 'Date de création';
                    Editable = false;
                }
                field("Type document"; Rec."Type document")
                {
                    ToolTip = 'Type document';
                    Editable = false;
                    Visible = false;
                }
                field("No. document"; Rec."No. document")
                {
                    ToolTip = 'N° document';
                    Editable = false;
                }
                field("Nom du prospect/client"; Rec."Nom du prospect/client")
                {
                    Importance = Standard;
                    ToolTip = 'Nom du prospect/client';
                    Editable = not DosserLieADocument;
                }
                field(Commentaires; Rec.Commentaires)
                {
                    ApplicationArea = All;
                    Editable = not DosserLieADocument;
                    ToolTip = 'Commentaires issus du document de vente lorsque le dossier est rattaché à un document, saisie libre sinon.';
                }

                field("Code vendeur"; Rec."Code vendeur")
                {
                    ToolTip = 'Code vendeur';
                    Editable = not DosserLieADocument;
                }
                field("Annule"; Rec.Annule)
                {
                    ToolTip = 'Indique si le dossier a été annulé.';
                    Editable = false;
                    Visible = false;
                }
                field("Archive"; Rec.Archive)
                {
                    ToolTip = 'Indique si le dossier est archivé. Vous pouvez demander à désarchiver le dossier, le système le fera automatiquement si le dossier est lié à un document de vente dans lequel on rajouterait un nouveau DIV.';
                    Editable = false;
                    Visible = (Rec.Archive);
                }


                field("PJ sur serveur"; Rec."PJ sur serveur")
                {
                    ApplicationArea = All;
                    ToolTip = 'Les pièces jointes sont-elles sur le serveur ?';
                }
                field("Alerte decalage date"; Rec."Alerte decalage date")
                {
                    ApplicationArea = All;
                }
                field("Detail alerte"; Rec."Detail alerte")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                
                
                field("Alerte vue par BE"; Rec."Alerte vue par BE")
                {
                    ApplicationArea = All;
                    ToolTip = 'Permet au BE d''indiquer que la modification du délai a bien été prise en compte.';
                }

                /*
                field("Code dessinateur"; Rec."Code dessinateur")
                {
                    ApplicationArea = All;
                    ToolTip = 'Code dessinateur';
                }
                */
                field("Sem. debut traitement BE"; Rec."Sem. debut traitement BE")
                {
                    ApplicationArea = All;
                    ToolTip = 'Semaine à partir de laquelle le BE a prévu de traiter des fiches.';
                    Visible = false;
                }
                field("Sem. fin traitement BE"; Rec."Sem. fin traitement BE")
                {
                    ApplicationArea = All;
                    tooltip = 'Semaine à laquelle le BE a prévu de terminer de traiter les dernières fiches.';
                    Visible = false;
                }
                field("Nb fiches BE"; Rec."Nb fiches BE")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre total de fiches du dossier';
                }
                field(PctAvancementBE; PctAvancementBE)
                {
                    ApplicationArea = All;
                    Caption = '% avancement BE';
                    DecimalPlaces = 0:0;
                    Editable = false;
                    ToolTip = '% de fiches qui sont terminées ou annulées.';
                }
                field("Charge pour le BE (h)"; Rec."Charge pour le BE (h)")
                {
                    ApplicationArea = All;
                    Caption = 'Charge pour le BE(h)';
                    ToolTip = 'Somme des charges des lignes de fiches BE.';
                }
                
                group("Commentaires dossier BE")
                {
                    Caption = 'Commentaires dossier BE';
                    field(CommentairesDossierBE; CommentairesDossierBE)
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Standard;
                        MultiLine = true;
                        ShowCaption = false;
                        ToolTip = 'Indique les commentaires généraux concernant le dossier BE.';

                        trigger OnValidate()
                        begin
                            Rec.SetCommentairesDossierBE(CommentairesDossierBE);
                        end;
                    }
                }
            }

            part(ListeReferences; "SF Dossier BE")
            {
                Caption = 'Liste références';
                SubPageLink = "No. dossier BE" = field("No.");
            }

        }
        area(FactBoxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Documents joints';
                SubPageLink = "Table ID" = const(Database::"Dossier BE"),
                              "No." = field("No.");
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(AfficherDocument)
            {
                    Caption = 'Afficher document';
                    Tooltip = 'Affiche le document lié au dossier.';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = ViewOrder;
                    trigger OnAction()
                    begin
                        Rec.AfficherDocument();
                    end;
            }
            action(Desarchiver)
            {
                ApplicationArea = All;
                ToolTip = 'Refait passer le dossier dans la liste des dossiers non archivés.';
                Caption = 'Désarchiver';
                Visible = (Rec.Archive);
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Restore;
                
                trigger OnAction()
                begin
                    Rec.Desarchiver();
                end;
            }
        }

    }
    trigger OnOpenPage()
    begin
        DossierNonArchive := not Rec.Archive; 
        CurrPage.Editable(DossierNonArchive);
    end;

    trigger OnAfterGetRecord()
    begin
        CommentairesDossierBE := Rec.GetCommentairesDossierBE();

        DosserLieADocument := (Rec."No. document" <> '');
        DossierNonArchive := not Rec.Archive; 
        CurrPage.Editable(DossierNonArchive);
        PctAvancementBE := Rec.CalcAvancement();
    end;

    var
        PctAvancementBE: Decimal;
        CommentairesDossierBE: Text;
        DosserLieADocument: Boolean;
        DossierNonArchive: Boolean;

}

