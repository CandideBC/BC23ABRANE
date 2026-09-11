page 50122 ComparaisonVersionsCdeAchat
{
    ApplicationArea = All;
    Caption = 'Comparaison Versions Commande Achat';
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
                        if EnteteAchat.Get(EnteteAchat."Document Type"::Order,ComparerNoCde) then
                            EnteteAchat.ComparerVersionsArchives(VersionA,VersionB);
                        
                end;
            }
            field(VersionB; VersionB)
            {
                ApplicationArea = All;
                Caption = 'Version B';

                trigger OnValidate()
                begin
                    if (VersionA <> 0) and (VersionB <> 0) then 
                        if EnteteAchat.Get(EnteteAchat."Document Type"::Order,ComparerNoCde) then
                            EnteteAchat.ComparerVersionsArchives(VersionA,VersionB);
                end;
            }

            repeater(General)
            
            {
                field("Ligne modifiee"; Rec."Ligne modifiee")
                {
                    Editable = false;
                    ToolTip = 'Indique si la quantité a évolué entre la version A et la version B.';
                }
                field("No. article"; Rec."No. article")
                {
                    Editable = false;
                    ToolTip = 'N° article';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ToolTip = 'Description';
                }
                field("Quantite version A"; Rec."Quantite version A")
                {
                    Editable = false;
                    ToolTip = 'Quantité dans la version A';
                }
                field("Quantite version B"; Rec."Quantite version B")
                {
                    Editable = false;
                    ToolTip = 'Quantité dans la version B';
                }
                field("Quantite ecart (B-A)"; Rec."Quantite ecart (B-A)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Variation de quantité (Quantité version B moins Quantité version A';
                }
                
            }
        }
    }

    actions
    {
        area(Processing)
        {
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
                    EnteteAchat:Record "Purchase Header";
                begin
                    EnteteAchat.setrange("Document Type", Rec."Type document");
                    EnteteAchat.Setrange("No.", Rec."No. document");
                    Report.run(Report::"Evolutions Commande Achat",true,false,EnteteAchat);
                end;
            }
        }
    }

    procedure DefFiltreNumCde(pNumCde: Code[20])
    begin
        ComparerNoCde := pnumCde;
        if not EnteteAchat.Get(EnteteAchat."Document Type"::Order,pNumCde) then
            EnteteAchat.init();
        EnteteAchat.CalcFields("No. of Archived Versions");
        NbVersionsArchivees := EnteteAchat."No. of Archived Versions";


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
            EnteteAchat.ComparerVersionsArchives(VersionA,VersionB);
        end;
    end;

    var
        EnteteAchat: Record "Purchase Header";
        VersionA: Integer;
        VersionB: Integer;
        NbVersionsArchivees:Integer;
        ComparerNoCde: Code[20];
}
