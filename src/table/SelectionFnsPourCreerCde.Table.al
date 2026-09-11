table 50035 "Selection fns pour creer cde"
{
    // KAN.FHA 22/04/2020
    //   Cette table est utilisée sur les devis et commandes de vente pour que l'utilisateur puisse sélectionner pour quels fournisseurs présents sur sa vente
    //   il souhaite créer les commandes d'achats.
    //KAN.FHA 27/05/2025 La clé primaire d'origine (Utilisateur+N° fns) a été modifiée car on peut avoir besoin parfois de faire la chose suivante :
    //  - le système a trouvé la liste de fns suivante parmi les articles du document de vente : F1, F2 et F3
    //  - l'utilisateur veut se mettre sur la ligne du fournisseur F3 et pouvoir dire que ces articles seront finalement achetés chez F1... ce qui générait un doublon
    //    avec l'ancienne clé primaire.
    //  Avec la nouvelle clé primaire, il va se retrouver dans cet exemple avec une liste F1, F2 et F1 à nouveau, ce qui est sans conséquence, il peut fermer et rouvrir
    //  l'écran s'il le souhaite pour ne voir plus que F1, F2 mais meme s'il ne le fait pas, c'est sans conséquence.
    fields
    {
        field(10; "Code utilisateur"; Code[50])
        {
        }
        field(20; "Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Type document';
        }
        field(30; "Document No."; Code[20])
        {
            Caption = 'N° document';
            TableRelation = "Sales Header"."No." where("Document Type" = field("Document Type"));
        }
        field(40; "No. fournisseur"; Code[20])
        {
            Caption = 'N° fournisseur';
            TableRelation = Vendor;
            trigger OnValidate()
            var
                Fournisseur: Record Vendor;
                LigneVente: Record "Sales Line";
                SelectionFns: Record "Selection fns pour creer cde";

            begin
                If Fournisseur.Get(rec."No. fournisseur") then begin
                    "Nom fournisseur" := Fournisseur.Name;
                    "Fournisseur divers" := Fournisseur."Fournisseur divers";
                end else
                    "Nom fournisseur" := '';


                if "No. fournisseur" <> xRec."No. fournisseur" then begin
                    //Si le fournisseur F1 est déjà présent sur une autre ligne mais que l'utilisateur indique que les articles normalement achetés
                    //chez le fns F2 vont aussi être achetés chez F1, on va se retrouver avec 2 lignes portant le même N° fns.
                    //Il faut alors aller voir si la premiere ligne est cochée "Créer commande", aller cocher les lignes ventes en "Créer commande" si c'était le cas
                    //et ne pas mettre "Créer commande" sur la ligne en cours pour éviter de créer 2 fois la commande. 
                    SelectionFns.setrange("Code utilisateur", "Code utilisateur");
                    SelectionFns.SetRange("No. fournisseur", "No. fournisseur");
                    if SelectionFns.FindSet(false) then begin
                        "Creer nouvelle commande" := false;
                        "Ajouter a la cde No." := '';
                    end else
                        SelectionFns.Init();

                    LigneVente.SetRange("Document Type", rec."Document Type");
                    LigneVente.SetRange("Document No.", rec."Document No.");
                    if LigneVente.FindSet(true) then
                        repeat
                            if LigneVente."Vendor No." = xrec."No. fournisseur" then begin
                                LigneVente."Vendor No." := "No. fournisseur";
                                LigneVente."Creer cde achat" := SelectionFns."Creer nouvelle commande";
                                LigneVente."Ajouter à cde achat No." := SelectionFns."Ajouter a la cde No.";
                                LigneVente.Modify();
                            end;
                        until LigneVente.Next() = 0;
                end;
            end;

        }
        field(41; "Nom fournisseur"; Text[100])
        {
            Editable = false;
        }
        field(42; "No. ligne"; Integer)
        {
            Caption = 'N° ligne';
            DataClassification = ToBeClassified;
        }

        field(44; "Fournisseur divers"; Boolean)
        {
            Caption = 'Fournisseur divers';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(47; "Code pays origine"; Code[10])
        {
            Caption = 'Code pays d''origine';
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
            trigger OnValidate()
            begin
                TestField("Fournisseur divers", true);
            end;
        }

        field(50; "Creer nouvelle commande"; Boolean)
        {
            Caption = 'Créer nouvelle commande';
            trigger OnValidate()
            var
                QteAAcheter: Decimal;
            begin
                if "Creer nouvelle commande" then
                    "Ajouter a la cde No." := '';
                LigneVente.SetCurrentKey("Document Type", "Document No.", Type, "Vendor No.");
                LigneVente.SetRange("Document Type", "Document Type");
                LigneVente.SetRange("Document No.", "Document No.");
                LigneVente.SetRange(Type, LigneVente.Type::Item);
                LigneVente.SetRange("Vendor No.", "No. fournisseur");
                if LigneVente.FindSet(true) then
                    repeat
                        LigneVente."Creer cde achat" := "Creer nouvelle commande";
                        if "Creer nouvelle commande" then
                            LigneVente."Ajouter à cde achat No." := '';
                        //KAN.FHA 22/04/2026 DEBUT    
                        LigneVente.CalcFields("Quantite affectee");
                        QteAAcheter := LigneVente."Outstanding Quantity" - LigneVente."Quantite affectee";
                        if QteAAcheter < 0 then
                            QteAAcheter := 0;
                        if QteAAcheter > 0 then begin
                            LigneVente."Ajouter à cde achat No." := "Ajouter a la cde No.";
                            LigneVente."Creer cde achat" := "Creer nouvelle commande";
                            LigneVente."Quantite a acheter" := QteAAcheter;
                        end else begin
                            LigneVente."Ajouter à cde achat No." := '';
                            LigneVente."Creer cde achat" := false;
                            LigneVente."Quantite a acheter" := 0;
                        end;
                        //KAN.FHA 22/04/2026 FIN
                        LigneVente.Modify();
                    until LigneVente.Next() = 0;
            end;
        }
        field(55; "Ajouter a la cde No."; Code[20])
        {
            Caption = 'Ajouter à la cde N°';
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No." where("Document Type" = const(Order), "Buy-from Vendor No." = field("No. fournisseur"));
            trigger OnValidate()
            var
                QteAAcheter: Decimal;
            begin
                if "Ajouter a la cde No." <> '' then
                    "Creer nouvelle commande" := false;
                LigneVente.Reset();
                LigneVente.SetCurrentKey("Document Type", "Document No.", Type, "Vendor No.");
                LigneVente.SetRange("Document Type", "Document Type");
                LigneVente.SetRange("Document No.", "Document No.");
                LigneVente.SetRange(Type, LigneVente.Type::Item);
                LigneVente.SetRange("Vendor No.", "No. fournisseur");
                if LigneVente.FindSet(true) then
                    repeat
                        //KAN.FHA 22/04/2026 DEBUT
                        /*
                        LigneVente.CalcFields("Nb affectations achats");
                        if LigneVente."Nb affectations achats" = 0 then begin
                            LigneVente."Ajouter à cde achat No." := "Ajouter a la cde No.";
                            LigneVente."Creer cde achat" := "Creer nouvelle commande";
                        end else begin
                            LigneVente."Ajouter à cde achat No." := '';
                            LigneVente."Creer cde achat" := false;
                        end;
                        */
                        //Lignes remplacees par :
                        LigneVente.CalcFields("Quantite affectee");
                        QteAAcheter := LigneVente."Outstanding Quantity" - LigneVente."Quantite affectee";
                        if QteAAcheter < 0 then
                            QteAAcheter := 0;
                        if QteAAcheter > 0 then begin
                            LigneVente."Ajouter à cde achat No." := "Ajouter a la cde No.";
                            LigneVente."Creer cde achat" := "Creer nouvelle commande";
                            LigneVente."Quantite a acheter" := QteAAcheter;
                        end else begin
                            LigneVente."Ajouter à cde achat No." := '';
                            LigneVente."Creer cde achat" := false;
                            LigneVente."Quantite a acheter" := 0;
                        end;
                        LigneVente.Modify();
                    until LigneVente.Next() = 0;
            end;
        }

        field(60; "Nombre lignes concernees"; Integer)
        {
            CalcFormula = count("Sales Line" where("Document Type" = field("Document Type"),
                                                    "Document No." = field("Document No."),
                                                    "Vendor No." = field("No. fournisseur")));
            Caption = 'Nombre lignes concernées';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(PK; "Code utilisateur", "No. ligne")
        {
            Clustered = true;
        }
        key(MyKey2; "Code utilisateur", "No. fournisseur")
        {

        }
    }

    fieldgroups
    {
    }

    var
        LigneVente: Record "Sales Line";
        Fournisseur: Record Vendor;

    procedure SelectionnerTous()
    var
        ListeFns: Record "Selection fns pour creer cde";
    begin
        ListeFns.SetRange("Code utilisateur", UserId);
        ListeFns.ModifyAll("Creer nouvelle commande", true);
        ListeFns.ModifyAll("Ajouter a la cde No.", '');
        MAJLignesVentes(true);
    end;

    procedure DeselectionnerTous()
    var
        ListeFns: Record "Selection fns pour creer cde";
    begin
        ListeFns.SetRange("Code utilisateur", UserId);
        ListeFns.ModifyAll("Creer nouvelle commande", false);
        MAJLignesVentes(false);
    end;

    procedure MAJLignesVentes(pMAJ: Boolean)
    begin
        LigneVente.SetCurrentKey("Document Type", "Document No.", Type, "Vendor No.");
        LigneVente.SetRange("Document Type", "Document Type");
        LigneVente.SetRange("Document No.", "Document No.");
        LigneVente.SetRange(Type, LigneVente.Type::Item);
        //LigneVente.SetRange("Vendor No.", "No. fournisseur");
        if LigneVente.FindSet(true) then
            repeat
                LigneVente."Creer cde achat" := pMAJ;
                LigneVente.Modify();
            until LigneVente.Next() = 0;
    end;
}

