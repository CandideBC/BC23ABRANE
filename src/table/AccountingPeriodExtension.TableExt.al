tableextension 50012 AccountingPeriodExtension extends "Accounting Period"
{
    fields
    {
        field(50000; "DEB Ventes cloturee"; Boolean)
        {
            Caption = 'DEB Ventes clôturée';
            DataClassification = ToBeClassified;
        }
        field(50010; "DEB Achats cloturee"; Boolean)
        {
            Caption = 'DEB Achats clôturée';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
    
        key(Key5; "DEB Ventes cloturee")
        {
        }
        key(Key6; "DEB Achats cloturee")
        {
        }
    }

    
    procedure VerifPremierePeriodeDEBVentesNonValidee(pDateSelectionnee: Date)
    var
        PeriodeComptable: Record "Accounting Period";
        DateIncorrecteErr: Label 'La prochaine période comptable pour laquelle vous devez déclarer la DEB Ventes est : %1.',Comment ='%1 = date début période comptable';
    begin
        //L'utilisateur se positionne sur une période comptable non validée et peut demander à extraire les ventes non encore déclarées.
        //Cela les rattachera à la période sélectionnée.
        //Cette fonction verifie uniquement que l'utilisateur ne s'est pas mis sur Mars 2023 alors que janvier 2023 n'a pas encore été validé (il doit donc se mettre sur janvier 2023)
        PeriodeComptable.SetCurrentKey(PeriodeComptable."DEB Ventes cloturee");
        PeriodeComptable.SetRange("DEB Ventes cloturee", false);
        PeriodeComptable.FindFirst();
        if PeriodeComptable."Starting Date" <> pDateSelectionnee then
            Error(DateIncorrecteErr, PeriodeComptable.Name);
    end;
    procedure VerifPremierePeriodeDEBAchatsNonValidee(pDateSelectionnee: Date)
    var
        PeriodeComptable: Record "Accounting Period";
        DateIncorrecteErr: Label 'La prochaine période comptable pour laquelle vous devez déclarer la DEB Achats est : %1.',Comment ='%1 = date début période comptable';
    begin
        //L'utilisateur se positionne sur une période comptable non validée et peut demander à extraire les achats non encore déclarés.
        //Cela les rattachera à la période sélectionnée.
        //Cette fonction verifie uniquement que l'utilisateur ne s'est pas mis sur Mars 2023 alors que janvier 2023 n'a pas encore été validé (il doit donc se mettre sur janvier 2023)
        PeriodeComptable.SetCurrentKey(PeriodeComptable."DEB Achats cloturee");
        PeriodeComptable.SetRange("DEB Achats cloturee", false);
        PeriodeComptable.FindFirst();
        if PeriodeComptable."Starting Date" <> pDateSelectionnee then
            Error(DateIncorrecteErr, PeriodeComptable.Name);
    end;

    procedure CloturerDEBVentes()
    var
        LigneDEB: Record "Ligne DEB";
        EnteteFactVente: Record "Sales Invoice Header";
        DateFin: Date;
        
        NumDoc: Code[20];
        
        CloturerDEBVentesQst: Label 'Voulez-vous clôturer la DEB pour la partie Ventes pour la période allant du %1 au %2 ?',Comment='%1 = Date début ; %2 = Date fin';
    begin
        VerifPremierePeriodeDEBVentesNonValidee("Starting Date");

        DateFin := CalcDate('<+1M-1D>', "Starting Date");
        if not Confirm(CloturerDEBVentesQst, true, "Starting Date", DateFin) then
            exit;

        "DEB Ventes cloturee" := true;

        LigneDEB.SetRange("Date debut periode comptable", "Starting Date");
        LigneDEB.SetRange("Type ligne DEB", LigneDEB."Type ligne DEB"::"Expédition");
        if LigneDEB.FindSet(false) then begin
            NumDoc := '';
            repeat
                if LigneDEB."No. document" <> NumDoc then 
                    case LigneDEB."Type document" of
                        LigneDEB."Type document"::Facture:
                            begin
                                EnteteFactVente.Get(LigneDEB."No. document");
                                EnteteFactVente."Periode validation DEB" := "Starting Date";
                                EnteteFactVente.Modify();
                            end;
                    end;

                
                NumDoc := LigneDEB."No. document";
            until LigneDEB.Next() = 0;
        end;
    end;

    procedure CloturerDEBAchats()
    var
        LigneDEB: Record "Ligne DEB";
        EnteteFactAchat: Record "Purch. Inv. Header";
        DateFin: Date;
        
        NumDoc: Code[20];
        
        CloturerDEBAchatsQst: Label 'Voulez-vous clôturer la DEB pour la partie Achats pour la période allant du %1 au %2 ?',Comment='%1 = Date début ; %2 = Date fin';
    begin
        VerifPremierePeriodeDEBAchatsNonValidee("Starting Date");

        DateFin := CalcDate('<+1M-1D>', "Starting Date");
        if not Confirm(CloturerDEBAchatsQst, true, "Starting Date", DateFin) then
            exit;

        "DEB Ventes cloturee" := true;

        LigneDEB.SetRange("Date debut periode comptable", "Starting Date");
        LigneDEB.SetRange("Type ligne DEB", LigneDEB."Type ligne DEB"::"Réception");
        if LigneDEB.FindSet(false) then begin
            NumDoc := '';
            repeat
                if LigneDEB."No. document" <> NumDoc then 
                    case LigneDEB."Type document" of
                        LigneDEB."Type document"::Facture:
                            begin
                                EnteteFactAchat.Get(LigneDEB."No. document");
                                EnteteFactAchat."Periode validation DEB" := "Starting Date";
                                EnteteFactAchat.Modify();
                            end;
                    end;

                
                NumDoc := LigneDEB."No. document";
            until LigneDEB.Next() = 0;
        end;
    end;



}

