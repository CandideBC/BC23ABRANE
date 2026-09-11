page 50055 "Planning chargement par sem."
{
    Caption = 'Montant à charger par semaine et par fournisseur';
    PageType = List;
    SourceTable = "Tampon reste a charger par sem";
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Tri; Rec.Tri)
                {
                    Visible = false;
                    ToolTip = 'Tri';
                    Editable = false;
                }
                field("No. fournisseur"; Rec."No. fournisseur")
                {
                    ToolTip = 'N° fournisseur';
                    Editable = false;
                }
                field("Nom du fournisseur"; Rec."Nom du fournisseur")
                {
                    ToolTip = 'Nom du fournisseur';
                    Editable = false;
                    trigger OnDrillDown()
                    begin
                        //Pour empecher de valider sa selection juste en cliquant sur le code (trop rapide)
                        error('');
                    end;
                }
                field("Mnt total restant a charger"; Rec."Mnt total restant a charger")
                {
                    ToolTip = 'Mnt total restant à charger';
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        PageListeCde: Page "Cdes achats container a faire";
                    begin
                        EnteteAchat.Reset();
                        EnteteAchat.SetCurrentKey("Document Type", "Suivi container", "Suivi container OK", "Semaine chargement", EnteteAchat."Buy-from Vendor No.");
                        EnteteAchat.SetRange("Document Type", EnteteAchat."Document Type"::Order);
                        EnteteAchat.SetRange("Suivi container", true);
                        EnteteAchat.SetRange("Suivi container OK", false);
                        EnteteAchat.SetRange("Semaine chargement", Rec.Tri);
                        EnteteAchat.SetRange("Buy-from Vendor No.", Rec."No. fournisseur");
                        Clear(PageListeCde);
                        PageListeCde.SetTableView(EnteteAchat);
                        PageListeCde.Run();
                    end;
                }
                field("Mnt restant liv dir"; Rec."Mnt restant liv dir")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Mnt total restant en livraison directe';
                }
                field(MntRestantTotal; Rec."Mnt total restant a charger" + Rec."Mnt restant liv dir")
                {
                    ApplicationArea = All;
                    Caption = 'Mnt restant total';
                    ToolTip = 'Mnt total restant';
                    Editable = false;
                }
                /*
                field("Montant achats Annee N"; Rec."Montant achats Annee N")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Montant des achats cumulés depuis le 1er janvier.';
                }
                field("Mnt restant a charger Annee N"; Rec."Mnt restant a charger Annee N")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Montant restant à charger hors livraisons directes (commandes dont la date de chargement est cette année).';
                }
                field("Mnt restant liv dir Annee N"; Rec."Mnt restant liv dir Annee N")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Montant restant à charger en livraison directe (commandes dont la date de chargement est cette année).';
                }
                field(VolumeAchatsAnneeN; Rec."Montant achats Annee N" + Rec."Mnt restant a charger Annee N" + Rec."Mnt restant liv dir Annee N")
                {
                    ApplicationArea = All;
                    Caption = 'Volume Achats Année N';
                    ToolTip = 'Montant global des achats déjà facturés et engagés pour cette année.';
                }
                */

                field(Avant; Rec.Avant)
                {
                    ApplicationArea = All;
                    ShowCaption = true;
                    ToolTip = 'Cumul des montants avant la première semaine affichée (retards).';
                }
                
                field("Semaine 1"; Rec."Semaine 1")
                {
                    ShowCaption = false;
                }
                field("Semaine 2"; Rec."Semaine 2")
                {
                    ShowCaption = false;
                }
                field("Semaine 3"; Rec."Semaine 3")
                {
                    ShowCaption = false;
                }
                field("Semaine 4"; Rec."Semaine 4")
                {
                    ShowCaption = false;
                }
                field("Semaine 5"; Rec."Semaine 5")
                {
                    ShowCaption = false;
                }
                field("Semaine 6"; Rec."Semaine 6")
                {
                    ShowCaption = false;
                }
                field("Semaine 7"; Rec."Semaine 7")
                {
                    ShowCaption = false;
                }
                field("Semaine 8"; Rec."Semaine 8")
                {
                    ShowCaption = false;
                }
                field("Semaine 9"; Rec."Semaine 9")
                {
                    ShowCaption = false;
                }
                field("Semaine 10"; Rec."Semaine 10")
                {
                    ShowCaption = false;
                }
                field("Semaine 11"; Rec."Semaine 11")
                {
                    ShowCaption = false;
                }
                field("Semaine 12"; Rec."Semaine 12")
                {
                    ShowCaption = false;
                }
                field("Semaine 13"; Rec."Semaine 13")
                {
                    ShowCaption = false;
                }
                field("Semaine 14"; Rec."Semaine 14")
                {
                    ShowCaption = false;
                }
                field("Semaine 15"; Rec."Semaine 15")
                {
                    ShowCaption = false;
                }
                field("Semaine 16"; Rec."Semaine 16")
                {
                    ShowCaption = false;
                }
                field("Semaine 17"; Rec."Semaine 17")
                {
                    ShowCaption = false;
                }
                field("Semaine 18"; Rec."Semaine 18")
                {
                    ShowCaption = false;
                }
                field("Semaine 19"; Rec."Semaine 19")
                {
                    ShowCaption = false;
                }
                field("Semaine 20"; Rec."Semaine 20")
                {
                    ShowCaption = false;
                }
                field("Semaine 21"; Rec."Semaine 21")
                {
                    ShowCaption = false;
                }
                field("Semaine 22"; Rec."Semaine 22")
                {
                    ShowCaption = false;
                }
                field("Semaine 23"; Rec."Semaine 23")
                {
                    ShowCaption = false;
                }
                field("Semaine 24"; Rec."Semaine 24")
                {
                    ShowCaption = false;
                }
                field("Semaine 25"; Rec."Semaine 25")
                {
                    ShowCaption = false;
                }
                field("Semaine 26"; Rec."Semaine 26")
                {
                    ShowCaption = false;
                }
                field("Semaine 27"; Rec."Semaine 27")
                {
                    ShowCaption = false;
                }
                field("Semaine 28"; Rec."Semaine 28")
                {
                    ShowCaption = false;
                }
                field("Semaine 29"; Rec."Semaine 29")
                {
                    ShowCaption = false;
                }
                field("Semaine 30"; Rec."Semaine 30")
                {
                    ShowCaption = false;
                }
                field("Semaine 31"; Rec."Semaine 31")
                {
                    ShowCaption = false;
                }
                field("Semaine 32"; Rec."Semaine 32")
                {
                    ShowCaption = false;
                }
                field("Semaine 33"; Rec."Semaine 33")
                {
                    ShowCaption = false;
                }
                field("Semaine 34"; Rec."Semaine 34")
                {
                    ShowCaption = false;
                }
                field("Semaine 35"; Rec."Semaine 35")
                {
                    ShowCaption = false;
                }
                field("Semaine 36"; Rec."Semaine 36")
                {
                    ShowCaption = false;
                }
                field("Semaine 37"; Rec."Semaine 37")
                {
                    ShowCaption = false;
                }
                field("Semaine 38"; Rec."Semaine 38")
                {
                    ShowCaption = false;
                }
                field("Semaine 39"; Rec."Semaine 39")
                {
                    ShowCaption = false;
                }
                field("Semaine 40"; Rec."Semaine 40")
                {
                    ShowCaption = false;
                }
                field("Semaine 41"; Rec."Semaine 41")
                {
                    ShowCaption = false;
                }
                field("Semaine 42"; Rec."Semaine 42")
                {
                    ShowCaption = false;
                }
                field("Semaine 43"; Rec."Semaine 43")
                {
                    ShowCaption = false;
                }
                field("Semaine 44"; Rec."Semaine 44")
                {
                    ShowCaption = false;
                }
                field("Semaine 45"; Rec."Semaine 45")
                {
                    ShowCaption = false;
                }
                field("Semaine 46"; Rec."Semaine 46")
                {
                    ShowCaption = false;
                }
                field("Semaine 47"; Rec."Semaine 47")
                {
                    ShowCaption = false;
                }
                field("Semaine 48"; Rec."Semaine 48")
                {
                    ShowCaption = false;
                }
                field("Semaine 49"; Rec."Semaine 49")
                {
                    ShowCaption = false;
                }
                field("Semaine 50"; Rec."Semaine 50")
                {
                    ShowCaption = false;
                }
                field("Semaine 51"; Rec."Semaine 51")
                {
                    ShowCaption = false;
                }
                field("Semaine 52"; Rec."Semaine 52")
                {
                    ShowCaption = false;
                }
                field("Semaine 53"; Rec."Semaine 53")
                {
                    ShowCaption = false;
                }
                field(Apres; Rec.Apres)
                {
                    ApplicationArea = All;
                    ShowCaption = true;
                    ToolTip = 'Cumul des montants après la dernière semaine affichée.';
                }
            }
            part(SFSuivi; "SF Montant a charger par sem")
            {
                SubPageLink = "Buy-from Vendor No." = field("No. fournisseur");
                              //"Semaine chargement" = field(filter("Filtre semaine"));
                SubPageView = where("Document Type" = const(Order),
                                    "Suivi container" = const(true),
                                    "Suivi container OK" = const(false));
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Recalculer)
            {
                Caption = 'Recalculer';
                ToolTip = 'Recalculer';
                Image = Recalculate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                //Entete: Record "Purchase Header";
                begin
                    //KAN.FHA 07/05/2026
                    //Entete.CalculerResteAChargerParSemParFns(Rec."Filtre semaine");
                    //KAN.FHA 07/05/2026 FIN
                    Codeunit.run(Codeunit::CalculerMontantACharger);
                    CurrPage.Update(false);
                end;
            }

        }
    }

    var
        EnteteAchat: Record "Purchase Header";
}

