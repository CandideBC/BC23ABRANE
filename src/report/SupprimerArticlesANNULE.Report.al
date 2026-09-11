report 50063 "Supprimer Articles ANNULE"
{
    // Ce traitement supprime en masse tous les articles dont le champ [Réf Client] (champ "No. 2") vaut ANNULE.
    // Il effectue les contrôles standard du système mais sans renvoyer de message d'erreur. Au final, seuls les articles qu'on pourrait supprimer manuellement seront supprimés.

    ProcessingOnly = true;
    UsageCategory = None;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING ("Ref. client") WHERE ("Ref. client" = CONST ('ANNULE'));

            trigger OnAfterGetRecord()
            begin
                ArticlesANNULES := ArticlesANNULES + 1;
                ItemJnlLine.SetRange("Item No.", "No.");
                ItemJnlLine.DeleteAll(true);

                StdCostWksh.Reset();
                StdCostWksh.SetRange(Type, StdCostWksh.Type::Item);
                StdCostWksh.SetRange("No.", "No.");
                StdCostWksh.DeleteAll(true);

                RequisitionLine.SetCurrentKey(Type, "No.");
                RequisitionLine.SetRange(Type, RequisitionLine.Type::Item);
                RequisitionLine.SetRange("No.", "No.");

                BOMComp.Reset();
                BOMComp.SetCurrentKey(Type, "No.");
                BOMComp.SetRange(Type, BOMComp.Type::Item);
                BOMComp.SetRange("No.", "No.");
                if not BOMComp.IsEmpty then
                    CurrReport.Skip();

                PurchOrderLine.SetCurrentKey(Type, "No.");
                PurchOrderLine.SetRange(Type, PurchOrderLine.Type::Item);
                PurchOrderLine.SetRange("No.", "No.");
                if not PurchOrderLine.IsEmpty then
                    CurrReport.Skip();

                SalesOrderLine.SetCurrentKey(Type, "No.");
                SalesOrderLine.SetRange(Type, SalesOrderLine.Type::Item);
                SalesOrderLine.SetRange("No.", "No.");
                if not SalesOrderLine.IsEmpty then
                    CurrReport.Skip();

                TransLine.SetCurrentKey("Item No.");
                TransLine.SetRange("Item No.", "No.");
                if not TransLine.IsEmpty then
                    CurrReport.Skip();

                ProdBOMLine.Reset();
                ProdBOMLine.SetCurrentKey(Type, "No.");
                ProdBOMLine.SetRange(Type, ProdBOMLine.Type::Item);
                ProdBOMLine.SetRange("No.", "No.");
                if ProdBOMLine.Find('-') then
                    CurrReport.Skip();

                AsmHeader.SetCurrentKey("Document Type", "Item No.");
                AsmHeader.SetRange("Item No.", "No.");
                if not AsmHeader.IsEmpty then
                    CurrReport.Skip();

                AsmLine.SetCurrentKey(Type, "No.");
                AsmLine.SetRange(Type, AsmLine.Type::Item);
                AsmLine.SetRange("No.", "No.");
                if not AsmLine.IsEmpty then
                    CurrReport.Skip();

                ItemLedgEntry.Reset();
                ItemLedgEntry.SetCurrentKey("Item No.");
                ItemLedgEntry.SetRange("Item No.", Item."No.");
                AccountingPeriod.SetRange(Closed, false);
                if AccountingPeriod.Find('-') then
                    ItemLedgEntry.SetFilter("Posting Date", '>=%1', AccountingPeriod."Starting Date");
                if ItemLedgEntry.Find('-') then
                    CurrReport.Skip();

                ItemLedgEntry.Reset();
                ItemLedgEntry.SetCurrentKey("Item No.");
                ItemLedgEntry.SetRange("Item No.", Item."No.");
                ItemLedgEntry.SetRange("Completely Invoiced", false);
                if ItemLedgEntry.Find('-') then
                    CurrReport.Skip();

                ItemLedgEntry.SetRange("Completely Invoiced");

                ItemLedgEntry.SetCurrentKey("Item No.", Open);
                ItemLedgEntry.SetRange(Open, true);
                if ItemLedgEntry.Find('+') then
                    CurrReport.Skip();

                ItemLedgEntry.SetCurrentKey("Item No.", "Applied Entry to Adjust");
                ItemLedgEntry.SetRange(Open, false);
                ItemLedgEntry.SetRange("Applied Entry to Adjust", true);
                if ItemLedgEntry.Find('-') then
                    CurrReport.Skip();

                ItemLedgEntry.SetRange("Applied Entry to Adjust");

                if Item."Costing Method" = Item."Costing Method"::Average then begin
                    AvgCostAdjmt.Reset();
                    AvgCostAdjmt.SetRange("Item No.", Item."No.");
                    AvgCostAdjmt.SetRange("Cost Is Adjusted", false);
                    if AvgCostAdjmt.Find('-') then
                        CurrReport.Skip();
                end;

                Article.Get(Item."No.");
                Article.Delete(true);
                ArticlesANNULESSupprimes := ArticlesANNULESSupprimes + 1;
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

    trigger OnPostReport()
    begin
        Message(Format(ArticlesANNULESSupprimes) + ' articles ont pu être supprimés parmi les ' + Format(ArticlesANNULES) + ' articles qui étaient en Réf. client ANNULE.');
    end;

    trigger OnPreReport()
    begin
        if not UserSetup.Get(UserId) then
            UserSetup.Init();

        if not UserSetup."Supprimer articles annules" then
            Error(SupprNonAutoriseeErr);

        if not Confirm(ConfirmQst) then
            Error(CancelMsg);
    end;

    var
        ItemJnlLine: Record "Item Journal Line";
        StdCostWksh: Record "Standard Cost Worksheet";
        RequisitionLine: Record "Requisition Line";
        BOMComp: Record "BOM Component";
        PurchOrderLine: Record "Purchase Line";
        SalesOrderLine: Record "Sales Line";
        TransLine: Record "Transfer Line";
        ProdBOMLine: Record "Production BOM Line";
        AsmHeader: Record "Assembly Header";
        AsmLine: Record "Assembly Line";
        UserSetup: Record "User Setup";
        Article: Record Item;
        ItemLedgEntry: Record "Item Ledger Entry";
        AccountingPeriod: Record "Accounting Period";
        AvgCostAdjmt: Record "Avg. Cost Adjmt. Entry Point";

        SupprNonAutoriseeErr: Label 'Vous n''êtes pas autorisé à exécuter ce traitement.';
        ConfirmQst: Label 'Ce traitement va supprimer en masse tous les articles dont le champ [Réf Client] vaut ANNULE mais tout en respectant les contrôles de cohérence standards du logiciel : les articles encore en stock, présents sur des commandes ou ayant été mouvementés au cours de l''exercice ne seront pas supprimés.';
        CancelMsg: Label 'Traitement interrompu à la demande de l''utilisateur.';
        ArticlesANNULES: Integer;
        ArticlesANNULESSupprimes: Integer;
        
        
}

