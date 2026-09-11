table 50020 "Suivi container"
{

    fields
    {
        field(10; "Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Type document';
            //OptionCaption = 'Devis,Commande,Facture,Avoir,Commande ouverte,Retour';
            //OptionMembers = Devis,Commande,Facture,Avoir,"Commande ouverte",Retour;
        }
        field(20; "No."; Code[20])
        {
            TableRelation = "Purchase Header"."No." where ("Document Type" = field ("Document Type"));
        }
        field(30; "N° container / camion / vol"; Text[50])
        {
        }
        field(40; "Date commande"; Date)
        {
            CalcFormula = lookup ("Purchase Header"."Order Date" where ("Document Type" = field ("Document Type"),
                                                                       "No." = field ("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50; "Origine marchandise"; Code[10])
        {
            TableRelation = "Country/Region".Code;
        }
        field(55; "Libellé origine"; Text[50])
        {
            CalcFormula = lookup ("Country/Region".Name where (Code = field ("Origine marchandise")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60; "Pay-to Vendor No."; Code[20])
        {
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                if Vend.Get("Pay-to Vendor No.") then
                    "Pay-to Name" := Vend.Name
                else
                    "Pay-to Name" := '';
            end;
        }
        field(70; "Pay-to Name"; Text[100])
        {
        }
        field(80; "Code enseigne"; Code[20])
        {
            TableRelation = Enseigne;

            trigger OnValidate()
            var
                Enseigne: Record Enseigne;
            begin
                IF Enseigne.GET("Code enseigne") then
                    "Libellé enseigne" := Enseigne.Description
                else
                    "Libellé enseigne" := '';
            end;
        }
        field(85; "Libellé enseigne"; Text[50])
        {
        }
        field(90; "Date facture fournisseur"; Date)
        {
        }
        field(100; "N° facture fournisseur"; Code[20])
        {
        }
        field(110; "Montant total facture"; Decimal)
        {
        }
        field(120; "Montant acompte"; Decimal)
        {
        }
        field(130; "Date paiement acompte"; Date)
        {
        }
        field(140; "N° facture achat"; Code[20])
        {
            TableRelation = "Purch. Inv. Header"."No.";
        }
        field(150; "Date d'échéance fournisseur"; Date)
        {
        }
        field(160; "Date paiement solde par Abrane"; Date)
        {
        }
        field(170; Commentaires; Text[250])
        {
        }
        field(180; Transporteur; Code[20])
        {
            TableRelation = Vendor;
        }
        field(185; "N° BL/CMR/LTA"; Text[30])
        {
        }
        field(190; "Date N° BL/CMR/LTA"; Date)
        {
        }
        field(200; "Mode de transport"; Code[20])
        {
            TableRelation = "Table multiple".Code where (Type = const ("Mode de transport"));
        }
        field(210; "Date de livraison demandée"; Date)
        {
            CalcFormula = lookup ("Purchase Header"."Requested Receipt Date" where ("Document Type" = field ("Document Type"),
                                                                                   "No." = field ("No.")));
            FieldClass = FlowField;
        }
        field(220; "Date mise à dispo marchandise"; Date)
        {
        }
        field(230; "Date de départ du port"; Date)
        {
        }
        field(240; "Date d'arrivée au port"; Date)
        {
        }
        field(250; "Date de réception confirmée"; Date)
        {

            trigger OnValidate()
            begin
                if "Date de réception confirmée" <> 0D then
                    "Semaine de réception" := Date2DWY("Date de réception confirmée", 2);

                if not Modify() then
                    Insert();

                Suiv.Reset();
                Suiv.SetCurrentKey("Date de réception confirmée");
                Suiv.SetRange("Document Type", "Document Type");
                Suiv.SetRange("No.", "No.");
                Suiv.SetFilter("Date de réception confirmée", '<>%1', 0D);
                if Suiv.FindLast() then begin
                    Cde.Get("Document Type", "No.");

                    Cde.Validate("Promised Receipt Date", Suiv."Date de réception confirmée");
                    Cde.Modify();
                end;
            end;
        }
        field(260; "Lieu de déchargement"; Code[10])
        {
            TableRelation = Location;
        }
        field(270; "Livré en dépôt"; Boolean)
        {
        }
        field(274; "Heure de réception"; Code[20])
        {
            TableRelation = "Table multiple".Code where (Type = const ("Heure de réception"));
        }
        field(275; "Semaine de réception"; Integer)
        {
        }
        field(280; "Total Montant facture"; Decimal)
        {
            CalcFormula = sum ("Suivi container"."Montant total facture" where ("Document Type" = field ("Document Type"),
                                                                               "No." = field ("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(290; "Total Montant acompte"; Decimal)
        {
            CalcFormula = sum ("Suivi container"."Montant acompte" where ("Document Type" = field ("Document Type"),
                                                                         "No." = field ("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Document Type", "No.", "N° container / camion / vol")
        {
            SumIndexFields = "Montant total facture", "Montant acompte";
        }
        key(Key2; "No.")
        {
            Clustered = true;
        }
        key(Key3; "N° container / camion / vol")
        {
        }
        key(Key4; "Date de réception confirmée")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Vend: Record Vendor;
        Cde: Record "Purchase Header";
        Suiv: Record "Suivi container";
}

