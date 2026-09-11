report 50050 "Extraire articles pour MAJ"
{
    // FHA 29/11/2019 Ce report est appele depuis les pages 50045 et 50046

    ProcessingOnly = true;

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "Ref. client", "No.";

            trigger OnAfterGetRecord()
            begin
                CalcFields("Assembly BOM");
                if ("Assembly BOM") and (FiltreTypeArticle = FiltreTypeArticle::Normal) then
                    CurrReport.Skip();

                if (not "Assembly BOM") and (FiltreTypeArticle = FiltreTypeArticle::Nomenclature) then
                    CurrReport.Skip();

                if SaisieArticle.Get(Item."No.") then
                    SaisieArticle.Delete(true);

                SaisieArticle.Init();
                SaisieArticle."Type article" := FiltreTypeArticle;
                SaisieArticle."Code utilisateur" := copystr(UserId, 1, 50);
                SaisieArticle.TransferFields(Item);
                SaisieArticle.Insert();

                if SaisieArticle."Vendor No." <> '' then begin
                    PrixAchat.SetRange("Item No.", SaisieArticle."No.");
                    PrixAchat.SetRange("Vendor No.", SaisieArticle."Vendor No.");
                    if PrixAchat.FindLast() then
                        SaisieArticle."Prix achat" := PrixAchat."Direct Unit Cost";
                end;

                PrixVente.SetRange("Item No.", SaisieArticle."No.");
                PrixVente.SetRange("Starting Date", 0D, Today);
                PrixVente.SetFilter("Ending Date", '%1|>=%2', 0D, Today);
                PrixVente.SetRange("Sales Type", PrixVente."Sales Type"::"Customer Price Group");
                if PrixVente.FindLast() then begin
                    SaisieArticle."Sales Type" := SaisieArticle."Sales Type"::"Groupe prix client";
                    SaisieArticle."Sales Code" := PrixVente."Sales Code";
                    SaisieArticle."Unit Price" := PrixVente."Unit Price";
                end else begin
                    PrixVente.SetRange("Sales Type", PrixVente."Sales Type"::Customer);
                    if PrixVente.FindLast() then begin
                        SaisieArticle."Sales Type" := SaisieArticle."Sales Type"::Client;
                        SaisieArticle."Sales Code" := PrixVente."Sales Code";
                        SaisieArticle."Unit Price" := PrixVente."Unit Price";
                    end;
                end;

                ReferenceExterne.SetRange("Item No.", SaisieArticle."No.");
                ReferenceExterne.SetRange("Reference Type", ReferenceExterne."Reference Type"::Customer);
                if ReferenceExterne.FindFirst() then
                    SaisieArticle."Reference externe client" := ReferenceExterne."Reference No.";

                //FHA.09/01/2020 DEBUT
                if TraductionArticle.Get(Item."No.", '', 'ENU') then begin
                    SaisieArticle."Description anglaise" := TraductionArticle.Description;
                    SaisieArticle."Description anglaise 2" := TraductionArticle."Description 2";
                end;
                //FHA.09/01/2020 FIN

                //FHA.15/01/2020 DEBUT
                SaisieArticle.Blocked := Blocked;
                //FHA.15/01/2020 FIN
                SaisieArticle.Modify();

                if "Assembly BOM" then begin
                    BOMComponent.SetRange("Parent Item No.", SaisieArticle."No.");
                    BOMComponent.SetRange(Type, BOMComponent.Type::Item);
                    if BOMComponent.FindSet(false) then
                        repeat
                            ComposantSaisieArticle.Init();
                            ComposantSaisieArticle."No. article parent" := BOMComponent."Parent Item No.";
                            ComposantSaisieArticle."Line No." := BOMComponent."Line No.";
                            ComposantSaisieArticle."N° article" := BOMComponent."No.";
                            ComposantSaisieArticle.Quantite := BOMComponent."Quantity per";
                            ComposantSaisieArticle."Code utilisateur" := COPYSTR(UserId, 1, 50);
                            ComposantSaisieArticle.Insert();
                        until BOMComponent.Next() = 0;
                end;
            end;

            trigger OnPreDataItem()
            begin
                SaisieArticle.SetCurrentKey("Code utilisateur", "Type article");
                SaisieArticle.SetRange("Code utilisateur", UserId);
                SaisieArticle.SetRange("Type article", FiltreTypeArticle);
                SaisieArticle.DeleteAll(true);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        SaisieArticle: Record "Creation/MAJ article";
        PrixVente: Record "Sales Price";
        ReferenceExterne: Record "Item Reference";
        PrixAchat: Record "Purchase Price";
        BOMComponent: Record "BOM Component";
        ComposantSaisieArticle: Record "Nomenclature saisie article";
        TraductionArticle: Record "Item Translation";
        FiltreTypeArticle: Option Normal,Nomenclature;

    procedure DefFiltreTypeArticle(pTypeArticle: Option Normal,Nomenclature)
    begin
        FiltreTypeArticle := pTypeArticle;
    end;
}

