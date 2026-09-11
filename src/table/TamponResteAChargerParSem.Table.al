table 50048 "Tampon reste a charger par sem"
{
    //Cette table sert à afficher le planning de chargement des 52 semaines à venir fournisseur par fournisseur.
    fields
    {
        /*FHA 07/05/2026
        field(10; "Code utilisateur"; Code[50])
        {
        }
        07/05/2026*/
        field(20; Tri; Integer)
        {
            Caption = 'Tri';
            Description = '0 pour la ligne de titre, 1 pour les lignes montrant un N° fns';
        }
        field(30; "No. fournisseur"; Code[20])
        {
            Caption = 'N° fournisseur';
            Description = 'Si vide = Première ligne contenant les N° de semaine en fonction du filtre en entrée';
            //A remettre TableRelation = Vendor;
        }
        field(31; "Nom du fournisseur"; Text[100])
        {
            CalcFormula = lookup (Vendor.Name where ("No." = field ("No. fournisseur")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(35; "Montant achats Annee N"; Decimal)
        {
            Caption = 'Montant achats Année N';
            DataClassification = ToBeClassified;
            Editable = false;
            BlankZero = true;
            DecimalPlaces = 2:2;
        }
        
        field(40; "Mnt total restant a charger"; Decimal)
        {
            Caption = 'Mnt total restant à charger';
        }
        field(45; "Mnt restant liv dir"; Decimal)
        {
            Caption = 'Mnt restant liv dir';
        }
        field(46; "Mnt restant a charger Annee N"; Decimal)
        {
            Caption = 'Mnt restant à charger Année N';
        }
        field(47; "Mnt restant liv dir Annee N"; Decimal)
        {
            Caption = 'Mnt restant liv dir Année N';
        }
        //KAN.FHA 11/05/2026 DEBUT
        //field(58; "Filtre semaine"; Text[20])
        //{
        //}
        //KAN.FHA 11/05/2026 FIN
        field(100; Avant; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }

        field(110; "Semaine 1"; Decimal)
        {
            BlankZero = true;
            Caption = 'Semaine';
            DecimalPlaces = 0 : 2;
            Description = 'Si le filtre en entrée demande d''afficher les semaines 27 à 32, cette colonne contiendra le montant restant à charger de la semaine 27.';
            Editable = false;
        }
        field(120; "Semaine 2"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(130; "Semaine 3"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(140; "Semaine 4"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(150; "Semaine 5"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(160; "Semaine 6"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(170; "Semaine 7"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(180; "Semaine 8"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(190; "Semaine 9"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(200; "Semaine 10"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(210; "Semaine 11"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(220; "Semaine 12"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(230; "Semaine 13"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(240; "Semaine 14"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(250; "Semaine 15"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(260; "Semaine 16"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(270; "Semaine 17"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(280; "Semaine 18"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(290; "Semaine 19"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(300; "Semaine 20"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(310; "Semaine 21"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(320; "Semaine 22"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(330; "Semaine 23"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(340; "Semaine 24"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(350; "Semaine 25"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(360; "Semaine 26"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(370; "Semaine 27"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(380; "Semaine 28"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(390; "Semaine 29"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(400; "Semaine 30"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(410; "Semaine 31"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(420; "Semaine 32"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(430; "Semaine 33"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(440; "Semaine 34"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(450; "Semaine 35"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(460; "Semaine 36"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(470; "Semaine 37"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(480; "Semaine 38"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(490; "Semaine 39"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(500; "Semaine 40"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(510; "Semaine 41"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(520; "Semaine 42"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(530; "Semaine 43"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(540; "Semaine 44"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(550; "Semaine 45"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(560; "Semaine 46"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(570; "Semaine 47"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(580; "Semaine 48"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(590; "Semaine 49"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(600; "Semaine 50"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(610; "Semaine 51"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(620; "Semaine 52"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(630; "Semaine 53"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(640; Apres; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
            Caption = 'Après';
        }
    }

    keys
    {
        key(Key1; Tri, "No. fournisseur")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

