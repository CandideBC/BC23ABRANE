page 50142 "Fiche colisage container"
{
    UsageCategory = Documents;
    ApplicationArea = All;
    Caption = 'Fiche colisage container';

    InsertAllowed = false;
    PageType = Document;
    SourceTable = Container;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'Général';
                field("No."; Rec."No.")
                {
                    ToolTip = 'N°';
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

                field("Code transporteur"; Rec."Code transporteur")
                {
                    ToolTip = 'Code transporteur';
                }


            }
            part(UC; "SF Ligne Colisage container")
            {
                ApplicationArea = all;
                SubPageLink = "No. container" = field("No.");
                SubPageView = sorting("No. container", "No. UC");
            }
            part(ContenuUC; "SF Contenu colisage container")
            {
                ApplicationArea = all;
                SubPageLink = "No. container" = field("No.");
            }
        }

    }

    actions
    {
        area(reporting)
        {
            /*
            action("Edition Liste de colisage")
            {
                Caption = 'Edition liste de colisage';
                ToolTip = 'Edition liste de colisage';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    EnteteColisage: Record "Entete colisage";
                begin
                    Rec.TestField("Packing Status", Rec."Packing Status"::"Terminé");
                    EnteteColisage.SetRange("No.", Rec."No.");
                    REPORT.RunModal(50032, true, true, EnteteColisage);
                end;
            }
            */
            /*
            action("Edition étiquette livraison")
            {
                Caption = 'Edition étiquette livraison';
                ToolTip = 'Edition étiquette livraison';
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    EnteteColisage: Record "Entete colisage";
                begin
                    Rec.TestField("Packing Status", Rec."Packing Status"::"Terminé");
                    EnteteColisage.SetRange("No.", Rec."No.");
                    REPORT.RunModal(50030, true, true, EnteteColisage);
                end;
            }
            */
            /*
            action("Edition Détail Palette")
            {
                Caption = 'Edition détail palette';
                ToolTip = 'Edition détail palette';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                var
                    EnteteColisage: Record "Entete colisage";
                begin
                    Rec.TestField("Packing Status", Rec."Packing Status"::"Terminé");
                    EnteteColisage.SetRange("No.", Rec."No.");
                    REPORT.RunModal(50031, true, true, EnteteColisage);
                end;
            }
            */
        }
    }



}

