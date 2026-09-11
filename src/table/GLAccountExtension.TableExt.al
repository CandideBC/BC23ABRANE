tableextension 50010 GLAccountExtension extends "G/L Account"
{
    fields
    {
        field(50000; ISEcotax; Boolean)
        {
            CalcFormula = exist ("Taxe eco-mobilier" where ("Account No." = field ("No.")));
            FieldClass = FlowField;
        }
        field(50010; "Exclure de la rentabilite"; Boolean)
        {
            Caption = 'Exclure de la rentabilité';
            DataClassification = ToBeClassified;
            Description = 'Pour les comptes d''acompte 419. Lignes de factures ne seront pas prises en compte dans le CA des chantiers.';

            trigger OnValidate()
            var
                LigneVente: Record "Sales Line";
                AutresTriggersTablesCodeunit : Codeunit AutresTriggersTable;
                

            begin
                
                //KAN.FHA 29/10/2021 DEBUT
                LigneVente.RESET();
                LigneVente.SETCURRENTKEY(Type,"No.","Variant Code","Drop Shipment","Location Code","Document Type","Shipment Date");
                LigneVente.SETRANGE(Type,LigneVente.Type::"G/L Account");
                LigneVente.SETRANGE("No.","No.");
                LigneVente.MODIFYALL("Exclure de la rentabilite","Exclure de la rentabilite");
                //KAN.FHA 29/10/2021 FIN
                
                AutresTriggersTablesCodeunit.GLAccountOnAfterValidateExclureRentabilite(rec,xRec);

                

            end;
        }
    }
}

