page 50046 "Saisie article nomenclature"
{
    PageType = List;
    SourceTable = "Creation/MAJ article";
    SourceTableView = sorting("Code utilisateur", "Type article") where("Type article" = const(Nomenclature));
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    Caption = 'N°';
                    ToolTip = 'N°';
                }
                field("Ref. client"; Rec."Ref. client")
                {
                    Caption = 'Réf. client';
                    ToolTip = 'Réf. client';
                }
                field("Complement ref. client"; Rec."Complement ref. client")
                {
                    caption = 'Complément réf. client';
                    ToolTip = 'Complément réf. client';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                }
                field("Description 2"; Rec."Description 2")
                {
                    ToolTip = 'Description 2';
                }
                field("Description anglaise"; Rec."Description anglaise")
                {
                    ToolTip = 'Description anglaise';
                }
                field("Description anglaise 2"; Rec."Description anglaise 2")
                {
                    ToolTip = 'Description anglaise 2';
                }
                field(Dimension; Rec.Dimension)
                {
                    ToolTip = 'Dimension';
                }
                field("Unit Of Measure"; Rec."Unit Of Measure")
                {
                    Caption = 'Unité de mesure';
                    ToolTip = 'Unité de mesure';
                }
                field(Phase; Rec.Phase)
                {
                    ApplicationArea = All;
                    ToolTip = 'Phase';
                }

                field("Code matiere"; Rec."Code matiere")
                {
                    Caption = 'Code matière';
                    ToolTip = 'Code matière';
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ToolTip = 'Unité de base';
                }
                field("Country/Region of Origin Code"; Rec."Country/Region of Origin Code")
                {
                    ToolTip = 'Code pays origine';
                }
                field("Eco Tax Furniture Code"; Rec."Eco Tax Furniture Code")
                {
                    ToolTip = 'Code taxe éco-mobilier';
                }
                field("Sales Type"; Rec."Sales Type")
                {
                    ToolTip = 'Type vente';
                }
                field("Sales Code"; Rec."Sales Code")
                {
                    ToolTip = 'Code vente';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Prix unitaire';
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    ApplicationArea = All;
                    ToolTip = 'Poids net';
                }

                field("Tariff No."; Rec."Tariff No.")
                {
                    ToolTip = 'N° nomenclature produit';
                }
                field(Picture; Rec.Picture)
                {
                    ToolTip = 'Image';
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Bloqué';
                }
            }
            part("Composants (du parent sélectionné)"; SFSaisieArticleNomenclature)
            {
                Caption = 'Composants (du parent sélectionné)';
                SubPageLink = "No. article parent" = field("No.");
            }
            part("Composants (tous parents)"; "SF tous composants crea nom.")
            {
                Caption = 'Composants (tous parents)';
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Extraire articles existants")
            {
                Caption = 'Extraire articles existants';
                ToolTip = 'Extraire articles existants';
                Image = "Filter";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CLEAR(ReportExtraireArticles);
                    ReportExtraireArticles.DefFiltreTypeArticle(Rec."Type article"::Nomenclature);
                    ReportExtraireArticles.RUN();
                end;
            }
            action("Créer/MAJ les articles")
            {
                Caption = 'Créer/MAJ les articles';
                ToolTip = 'Créer/MAJ les articles';
                Image = NewItem;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.CreerArticles();
                end;
            }
        }
        area(navigation)
        {
            action("Fiche article")
            {
                Caption = 'Fiche article';
                ToolTip = 'Fiche article';
                Image = Item;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Article.GET(Rec."No.") then
                        PAGE.RUN(PAGE::"Item Card", Article);
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Type article" := Rec."Type article"::Nomenclature;

        Rec."Base Unit of Measure" := InvSetup."Article : unite mesure/defaut";
        //Rec."Item Category Code" := InvSetup."Article : categorie/defaut";
        //Rec."Phys Invt Counting Period Code" := InvSetup."Article : code period inv./def";
    end;

    trigger OnOpenPage()
    var
        ParamUtil: Record "User Setup";
        NonAutoriseErr: Label 'Vous n''êtes pas autorisé(e) à utiliser ce module.';
    begin

        if not ParamUtil.get(UserId) then
            ParamUtil.Init();

        if not ParamUtil."Utiliser outil crea. articles" then
            error(NonAutoriseErr);

        Rec.FilterGroup(2);
        Rec.SetRange("Code utilisateur", UserId);
        Rec.FilterGroup(0);

        if not InvSetup.Get() then
            InvSetup.Init();
    end;

    var
        Article: Record Item;
        InvSetup: Record "Inventory Setup";
        ReportExtraireArticles: Report "Extraire articles pour MAJ";


}

