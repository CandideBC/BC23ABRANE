page 50080 "Enseignes"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageID = "Fiche enseigne";
    PageType = List;
    SourceTable = Enseigne;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Code';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Description';
                }
                field("Prefixe chantier"; Rec."Prefixe chantier")
                {
                    ApplicationArea = All;
                    ToolTip = 'Préfixe chantier';
                }
                field("Code groupe"; Rec."Code groupe")
                {
                    ApplicationArea = All;
                    ToolTip = 'Code groupe';
                }
                field("Concept obligatoire"; Rec."Concept obligatoire")
                {
                    ApplicationArea = All;
                    ToolTip = 'Concept obligatoire';
                }
                field("Code conditions paiement"; Rec."Code conditions paiement")
                {
                    ApplicationArea = All;
                    ToolTip = 'Conditions de paiement';
                }
                field("Code cond. paiement acomptes"; Rec."Code cond. paiement acomptes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Conditions de paiement des acomptes';
                }
                field("Code cond. paiement situation"; Rec."Code cond. paiement situation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Conditions de paiement des situations';
                }
                field("% acompte situation"; Rec."% acompte situation")
                {
                    ApplicationArea = All;
                    ToolTip = '% acompte situation';
                    BlankZero = true;
                }
                
                field("Montant factures ventes"; Rec."Montant factures ventes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Montant factures ventes';
                    Visible = UserAutorise;
                }
                field("Montant avoirs ventes"; Rec."Montant avoirs ventes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Montant avoirs ventes';
                    Visible = UserAutorise;
                }
                field("Montant factures ventes - Montant avoirs ventes"; Rec."Montant factures ventes" - Rec."Montant avoirs ventes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Montant des factures de ventes moins Montant des avoirs de ventes';
                    BlankZero = true;
                    Caption = 'Chiffre d''affaires';
                    Visible = UserAutorise;
                }
                field("OD Chiffre affaires"; Rec."OD Chiffre affaires")
                {
                    ToolTip = 'OD Chiffre d''affaires';
                }
                field("Montant factures ventes-Montant avoirs ventes+OD Chiffre affaires"; Rec."Montant factures ventes" - Rec."Montant avoirs ventes" + Rec."OD Chiffre affaires")
                {
                    BlankZero = true;
                    Caption = 'CA total';
                    ToolTip = 'Montant factures ventes - Montant avoirs ventes + OD Chiffre affaires';                }
                field("Montant reste a livrer"; Rec."Montant reste a livrer")
                {
                    ToolTip = 'Montant reste a livrer';
                }
                field("Montant livre non facture"; Rec."Montant livre non facture")
                {
                    ToolTip = 'Montant livré non facturé'; 
                }
                field("Montant acomptes en cours"; Rec."Montant acomptes en cours")
                {
                    ToolTip = 'Montant acomptes en cours';              
                }
                field("Facture non paye"; Rec."Facture non paye")
                {
                    ToolTip = 'Facturé non payé';                
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(Phases)
            {
                ApplicationArea = All;
                Caption = 'Phases';
                ToolTip = 'Phases';
                Image = JobLines;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "Phases enseigne";
                RunPageLink = "Code enseigne" = field(Code);
            }
            action("Conditions d'acomptes")
            {
                Caption = 'Conditions d''acomptes';
                ToolTip = 'Conditions d''acomptes';
                Image = PrepaymentPercentages;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Conditions acompte";
                RunPageLink = Type = const (Enseigne),
                              Code = field (Code);
            }

            action("OD Chiffre d'affaires")
            {
                Caption = 'OD Chiffre d''affaires';
                ToolTip = 'OD Chiffre d''affaires';
                Image = Balance;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "OD CA Enseigne";
                RunPageLink = "Code enseigne" = field (Code);
                RunPageView = sorting ("Code enseigne");
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not ParamUtil.Get(UserId) then
            ParamUtil.Init();

        UserAutorise := ParamUtil."Voir CA groupes et enseignes";

        if not ParamUtil."Voir enseignes internes" then begin
            rec.FilterGroup(2);
            rec.SetCurrentKey("Enseigne interne");
            rec.SetRange("Enseigne interne", false);
            rec.FilterGroup(0);
        end;
    end;

    var
        ParamUtil: Record "User Setup";
        UserAutorise: Boolean;
}

