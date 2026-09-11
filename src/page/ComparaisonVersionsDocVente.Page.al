page 50130 ComparaisonVersionsDocVente
{
    ApplicationArea = All;
    Caption = 'Comparaison versions document vente';
    PageType = List;
    SourceTable = ComparaisonVersionsDocument;
    SourceTableView = sorting("Code utilisateur", "Ligne modifiee");
    UsageCategory = None;
    InsertAllowed = false;
    DeleteAllowed = false;
    //Editable = false;

    layout
    {
        area(content)
        {
            field(NbVersionsArchivees; NbVersionsArchivees)
            {
                ApplicationArea = All;
                Caption = 'Nombre archives';
                Editable = false;
                Enabled = false;
            }

            field(VersionA; VersionA)
            {
                ApplicationArea = All;
                Caption = 'Version A';
                ToolTip = 'Version de départ';
                trigger OnValidate()
                begin
                    if (VersionA <> 0) and (VersionB <> 0) then
                        if EnteteVente.Get(EnteteVente."Document Type"::Order, ComparerNumDoc) then
                            EnteteVente.ComparerVersionsArchives(VersionA, VersionB);

                end;
            }
            field(VersionB; VersionB)
            {
                ApplicationArea = All;
                Caption = 'Version B';

                trigger OnValidate()
                begin
                    if (VersionA <> 0) and (VersionB <> 0) then
                        if EnteteVente.Get(EnteteVente."Document Type"::Order, ComparerNumDoc) then
                            EnteteVente.ComparerVersionsArchives(VersionA, VersionB);
                end;
            }

            repeater(General)

            {
                field("Ligne modifiee"; Rec."Ligne modifiee")
                {
                    Editable = false;
                }
                field("No. article"; Rec."No. article")
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field("Quantite version A"; Rec."Quantite version A")
                {
                    Editable = false;
                }
                field("Quantite version B"; Rec."Quantite version B")
                {
                    Editable = false;
                }
                field("Quantite ecart (B-A)"; Rec."Quantite ecart (B-A)")
                {
                    ApplicationArea = All;
                }
                
            }
        }
    }

    actions
    {
        area(Processing)
        {
            /*
            action(Imprimer)
            {
                ApplicationArea = All;
                ToolTip = 'Vous permet d''imprimer le document comparant les deux versions que vous avez à l''écran.';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Print;
                trigger OnAction()
                var
                    EnteteVente:Record "Purchase Header";
                begin
                    EnteteVente.setrange("Document Type", Rec."Type document");
                    EnteteVente.Setrange("No.", Rec."No. document");
                    Report.run(Report::"Evolutions Commande Achat",true,false,EnteteAchat);
                end;
            }
            */
        }
    }

    procedure DefFiltreDocVente(pTypeDoc: integer; pNumDoc: Code[20])
    begin
        ComparerTypeDoc := pTypeDoc;
        ComparerNumDoc := pNumDoc;
        if not EnteteVente.Get(pTypeDoc, pNumDoc) then
            EnteteVente.init();
        EnteteVente.CalcFields("No. of Archived Versions");
        NbVersionsArchivees := EnteteVente."No. of Archived Versions";
    end;

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.SetRange("Code utilisateur", UserId);
        Rec.deleteall();
        Rec.FilterGroup(0);
        if NbVersionsArchivees > 1 then begin
            VersionA := NbVersionsArchivees - 1;
            VersionB := NbVersionsArchivees;
            EnteteVente.ComparerVersionsArchives(VersionA, VersionB);
        end;
    end;

    var
        EnteteVente: Record "Sales Header";
        VersionA: Integer;
        VersionB: Integer;
        NbVersionsArchivees: Integer;
        ComparerTypeDoc: Integer;
        ComparerNumDoc: Code[20];
}
