table 50041 "Ligne container"
{
    Caption = 'Ligne container';
    DrillDownPageID = 50094;

    fields
    {
        field(1; "No. container"; Code[20])
        {
            Caption = 'N° container';
            TableRelation = Container;
        }
        field(10; "No. ligne"; Integer)
        {
            Caption = 'N° ligne';
        }
        field(20; "No. commande achat"; Code[20])
        {
            Caption = 'N° commande achat';
            TableRelation = "Purchase Header"."No." where("Document Type" = const(Order),
                                                           "Suivi container" = const(true));
        }
        field(30; "No. ligne commande achat"; Integer)
        {
            Caption = 'N°  ligne commande achat';
            TableRelation = "Purchase Line"."Line No." where("Document Type" = const(Order),
                                                              "Document No." = field("No. commande achat"),
                                                              Type = filter(Item | "Charge (Item)"));

            trigger OnValidate()
            begin
                if LigneAchat.Get(LigneAchat."Document Type"::Order, "No. commande achat", "No. ligne commande achat") then begin
                    "No." := LigneAchat."No.";
                    Description := LigneAchat.Description;
                    LigneAchat.CalcFields("Quantite en container");
                    Quantite := LigneAchat.Quantity - LigneAchat."Quantite en container";
                end;
            end;
        }
        field(35; Type; Option)
        {
            Caption = 'Type';
            OptionMembers = Article,"Frais annexes","Compte général";
        }
        field(40; "No."; Code[20])
        {
            Caption = 'N°';
            TableRelation = if (Type = const(Article)) Item
            else
            if (Type = const("Compte général")) "G/L Account" where("Direct Posting" = const(true),
                                                                                        "Account Type" = const(Posting),
                                                                                        Blocked = const(false))
            else
            if (Type = const("Frais annexes")) "Item Charge";
        }
        field(50; Description; Text[100])
        {
            Caption = 'Désignation';
        }
        field(60; "Nomenclature produits"; Code[20])
        {
            Caption = 'Nomenclature produits';
            TableRelation = "Tariff Number";

            trigger OnValidate()
            var

                
            begin
                LigneAchat.Get(LigneAchat."Document Type"::Order, "No. commande achat", "No. ligne commande achat");
                LigneAchat."Nomenclature produits" := "Nomenclature produits";
                LigneAchat.Modify();
            end;
        }
        field(70; "Poids net unitaire"; Decimal)
        {
            BlankZero = true;
            Caption = 'Poids net unitaire';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            var
                LienAchatVente: Record "Affectations achat vente";
                LigneVente: Record "Sales Line";
            begin
                Article.Get("No.");
                Article.TestField("Miscellaneous Item");
                LigneAchat.Get(LigneAchat."Document Type"::Order, "No. commande achat", "No. ligne commande achat");
                LigneAchat."Net Weight" := "Poids net unitaire";
                LigneAchat.Modify();

                //KAN.FHA 24/10/2022 DEBUT
                LienAchatVente.Reset();
                LienAchatVente.SetRange("No. document achat", "No. commande achat");
                LienAchatVente.SetRange("No. ligne document achat", "No. ligne commande achat");
                if LienAchatVente.FindSet(true) then
                    repeat
                        if LigneVente.Get(LienAchatVente."Type document vente", LienAchatVente."No. document vente", LienAchatVente."No. ligne document vente") then begin
                            LigneVente."Net Weight" := "Poids net unitaire";
                            LigneVente.Modify();
                        end;

                    until LienAchatVente.Next() = 0;
                //KAN.FHA 24/10/2022 FIN
            end;
        }
        field(100; Quantite; Decimal)
        {
            BlankZero = true;
            Caption = 'Quantité';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            var
                QteErr: Label 'La quantité ne peut pas être inférieure à la quantité déjà reçue.';
                Qte2Err: Label 'Vous ne pouvez pas mettre en container plus que la quantité restante de la commande d''achat.';
                Qte3Err: Label 'Vous ne pouvez pas saisir de quantité négative car la quantité de la ligne de commande d''achat est positive.';
                Qte4Err: Label 'Vous ne pouvez pas saisir de quantité positive car la quantité de la ligne de commande d''achat est négative.';
            begin
                if Abs(Quantite) < Abs("Quantite recue") then
                    Error(QteErr);

                LigneAchat.Get(LigneAchat."Document Type"::Order, "No. commande achat", "No. ligne commande achat");
                if LigneAchat.Quantity >= 0 then begin
                    if Quantite > LigneAchat."Outstanding Quantity" then
                        Error(Qte2Err);
                    if Quantite < 0 then
                        Error(Qte3Err);

                end else begin
                    if Quantite < LigneAchat."Outstanding Quantity" then
                        Error(Qte2Err);
                    if Quantite > 0 then
                        Error(Qte4Err);
                end;

                "Quantite restante" := Quantite - "Quantite recue";

                "Qte a recevoir" := "Quantite restante";

                CalcMontantFacturePapier();
            end;
        }
        field(115; "Qte a recevoir"; Decimal)
        {
            BlankZero = true;
            Caption = 'Qté à recevoir';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            var
                Qte1Err: Label 'La quantité à recevoir doit être positive et ne peut pas supérieure à la quantité restante.';
                
            begin
                if CurrFieldNo = FieldNo("Qte a recevoir") then begin
                    EnteteContainer.Get("No. container");
                    EnteteContainer.TestField("Statut container", EnteteContainer."Statut container"::"En cours");
                end;

                if Quantite > 0 then begin
                    if ("Qte a recevoir" > "Quantite restante") or ("Qte a recevoir" < 0) then
                        Error(Qte1Err)
                end else
                    if Quantite < 0 then 
                        if ("Qte a recevoir" < "Quantite restante") or ("Qte a recevoir" > 0) then
                            Error(Qte1Err)
                    
            end;
        }
        field(118; "Quantite recue"; Decimal)
        {
            BlankZero = true;
            Caption = 'Quantité reçue';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(119; "Quantite restante"; Decimal)
        {
            BlankZero = true;
            Caption = 'Quantité restante';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(120; "Code acheteur"; Code[20])
        {
            CalcFormula = lookup("Purchase Header"."Purchaser Code" where("Document Type" = const(Order),
                                                                           "No." = field("No. commande achat")));
            Caption = 'Code acheteur';
            Editable = false;
            FieldClass = FlowField;
        }
        field(125; "Code enseigne"; Code[20])
        {
            CalcFormula = lookup("Purchase Line"."Code enseigne" where("Document Type" = const(Order),
                                                                        "Document No." = field("No. commande achat"),
                                                                        "Line No." = field("No. ligne commande achat")));
            Caption = 'Code enseigne';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Enseigne;
        }
        field(130; Commentaire; Text[250])
        {
            CalcFormula = lookup("Purchase Header".Commentaires where("Document Type" = const(Order),
                                                                   "No." = field("No. commande achat")));
            Caption = 'Commentaire';
            FieldClass = FlowField;
        }
        field(134; "Qte a retourner"; Decimal)
        {
            BlankZero = true;
            Caption = 'Qté à retourner';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            var
                Qte1Err: Label 'La quantité à retourner doit être positive et ne peut pas supérieure à la quantité reçue.';
                Qte2Err: Label 'Vous ne pouvez pas retourner plus de %1.',Comment ='%1 = Quantité';
                QteRetournable: Decimal;
                DeuxiemeRetourQst: Label 'Un retour a déjà été créé ou validé pour cette ligne de container. Etes-vous certain de vouloir créer un nouveau retour pour cette ligne de container ?';
                OperationInterrompueErr: Label 'Opération interrompue à la demande de l''utilisateur.';
            begin
                if CurrFieldNo = FieldNo("Qte a retourner") then begin
                    EnteteContainer.Get("No. container");
                    EnteteContainer.TestField("Statut container", EnteteContainer."Statut container"::"Réceptionné");
                end;

                if Quantite <> 0 then begin
                    CalcFields("Qte sur retour", "Qte retournee");
                    if ("Qte sur retour" <> 0) or ("Qte retournee" <> 0) then
                        if not Confirm(DeuxiemeRetourQst, false) then
                            Error(OperationInterrompueErr);
                    if ("Qte a retourner" > "Quantite recue") or ("Qte a retourner" < 0) then
                        Error(Qte1Err);
                    QteRetournable := "Quantite recue" - ("Qte sur retour" + "Qte retournee");
                    if ("Qte a retourner" > QteRetournable) then
                        Error(Qte2Err, QteRetournable);
                end;
            end;
        }
        field(135; "Qte sur retour"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Purchase Line"."Outstanding Quantity" where("Document Type" = const("Return Order"),
                                                                            "No. container" = field("No. container"),
                                                                            "No. ligne container" = field("No. ligne")));
            Caption = 'Qté sur retour';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(136; "Qte retournee"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Return Shipment Line"."Quantity (Base)" where("No. container" = field("No. container"),
                                                                              "No. ligne container" = field("No. ligne")));
            Caption = 'Qté retournée';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(140; "No. fournisseur"; Code[20])
        {
            CalcFormula = lookup("Purchase Header"."Buy-from Vendor No." where("Document Type" = const(Order),
                                                                                "No." = field("No. commande achat")));
            Caption = 'N° fournisseur';
            FieldClass = FlowField;
        }
        field(150; "No. facture fournisseur"; Code[35])
        {
            Caption = 'N° facture fournisseur';
        }
        field(160; "Cout unitaire direct"; Decimal)
        {
            Caption = 'Coût unitaire direct';

            trigger OnValidate()
            var
                MAJCoutInterditeErr: Label 'Il n''est pas possible de mettre à jour le coût d''achat sur le container si la commande d''achat fait déjà mention d''un coût d''achat.';
            begin
                //KAN.FHA 01/03/2023 DEBUT
                //Si on a deja un coût sur la ligne de commande, interdiction de mettre à jour le cout sur le container
                if "Cout unitaire direct" <> xRec."Cout unitaire direct" then begin
                    LigneAchat.Get(LigneAchat."Document Type"::Order, "No. commande achat", "No. ligne commande achat");
                    if LigneAchat."Direct Unit Cost" <> 0 then
                        Error(MAJCoutInterditeErr);
                    //KAN.FHA 01/03/2023 FIN
                    if ("Cout unitaire direct" <> 0) and (xRec."Cout unitaire direct" = 0) then
                        if LigneAchat."Direct Unit Cost" = 0 then begin
                            LigneAchat.SuspendStatusCheck(true);
                            LigneAchat.DejMiseAjourCoutDepuisContainer(true);
                            LigneAchat.Validate("Direct Unit Cost", "Cout unitaire direct");
                            LigneAchat.SuspendStatusCheck(false);
                            LigneAchat.DejMiseAjourCoutDepuisContainer(false);
                            LigneAchat.Modify();
                        end;
                end;

            end;
        }
        field(161; "Code devise"; Code[10])
        {
            Caption = 'Code devise';
            TableRelation = Currency;
        }
        field(170; "Cout unitaire facture (papier)"; Decimal)
        {
            BlankZero = true;
            Caption = 'Coût unitaire facture (papier)';
            Description = 'KAN.FHA 01/03/2023';

            trigger OnValidate()
            begin
                CalcMontantFacturePapier();
            end;
        }
        field(180; "Montant facture (papier)"; Decimal)
        {
            BlankZero = true;
            Caption = 'Montant facture (papier)';
            Description = 'KAN.FHA 01/03/2023';
        }
    }

    keys
    {
        key(Key1; "No. container", "No. ligne")
        {
            Clustered = true;
            SumIndexFields = "Montant facture (papier)", Quantite;
        }
        key(Key2; "No. commande achat", "No. ligne commande achat")
        {
            SumIndexFields = Quantite, "Quantite restante";
        }
        key(Key3; "No. container", "No. commande achat")
        {
            SumIndexFields = "Montant facture (papier)", Quantite;
        }
        key(Key4; "No.")
        {
        }
        key(Key5; Type, "No. container")
        {
            SumIndexFields = "Quantite restante";
        }
        key(Key6; Type, "No.")
        {
            SumIndexFields = "Quantite restante";
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No. container", "No. fournisseur", "Code acheteur")
        {
        }
    }

    trigger OnDelete()
    var

    begin
        if LigneAchat.Get(LigneAchat."Document Type"::Order, "No. commande achat", "No. ligne commande achat") then
            if LigneAchat."Suivi container OK" then begin
                LigneAchat."Suivi container OK" := false;
                LigneAchat.Modify();
            end;
    end;

    var
        LigneAchat: Record "Purchase Line";
        EnteteContainer: Record Container;
        Article: Record Item;
        EnteteAchat: Record "Purchase Header";
        Currency: Record Currency;

    procedure CalcMontantFacturePapier()
    begin
        EnteteAchat.Get(EnteteAchat."Document Type"::Order, "No. commande achat");
        if EnteteAchat."Currency Code" = '' then
            "Montant facture (papier)" := Round(Quantite * "Cout unitaire facture (papier)", 0.01)
        else begin
            Currency.Get(EnteteAchat."Currency Code");
            "Montant facture (papier)" := Round(Quantite * "Cout unitaire facture (papier)", Currency."Amount Rounding Precision")
        end;
    end;
}

