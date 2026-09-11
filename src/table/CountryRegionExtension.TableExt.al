tableextension 50002 CountryRegionExtension extends "Country/Region"
{
    
    fields
    {
        field(50000; "Pays Codifab"; Boolean)
        {
            DataClassification = ToBeClassified;
            
            trigger OnValidate()
            var
              AutresTriggerCodeunit : Codeunit AutresTriggersTable;

            begin;
              AutresTriggerCodeunit.CountryRegionOnAfterValidatePaysCodifab(Rec,xRec);  
            end;
        }
        field(50010; "Language Code"; Code[10])
        {
            Caption = 'Code langue';
            DataClassification = ToBeClassified;
            TableRelation = Language;
        }
        field(50020; "Soumis eco-contribution"; Boolean)
        {
            Caption = 'Soumis éco-contribution';
            DataClassification = ToBeClassified;
            
        }
        field(50030; "SIRET obligatoire"; Boolean)
        {
            Caption = 'SIRET obligatoire';
            DataClassification = ToBeClassified;
            
        }
        field(50040; "No. TVA intracom. oblig."; Boolean)
        {
            Caption = 'N° TVA intracom. obligatoire';
            DataClassification = ToBeClassified;
        }
        field(50050; "Delai transit (jours)"; Integer)
        {
            Caption = 'Délai transit (jours)';
            DataClassification = ToBeClassified;
        }
        field(50060; "% frais approche"; Decimal)
        {
            Caption = '% frais approche';
            DataClassification = ToBeClassified;
            BlankZero = true;
            DecimalPlaces = 0:2;
        }
        field(50070; "Montant VAN"; Decimal)
        {
            Caption = 'Montant VAN';
            DataClassification = ToBeClassified;
            BlankZero = true;
            DecimalPlaces = 0:2;
        }
        field(50080; "Montant Porteur"; Decimal)
        {
            Caption = 'Montant Porteur';
            DataClassification = ToBeClassified;
            BlankZero = true;
            DecimalPlaces = 0:2;
        }
        field(50090; "Montant Semi"; Decimal)
        {
            Caption = 'Montant Semi';
            DataClassification = ToBeClassified;
            BlankZero = true;
            DecimalPlaces = 0:2;
        }
        field(50100; "Montant Container 20p"; Decimal)
        {
            Caption = 'Montant Container 20p';
            DataClassification = ToBeClassified;
            BlankZero = true;
            DecimalPlaces = 0:2;
        }
        field(50110; "Montant Container 40p"; Decimal)
        {
            Caption = 'Montant Container 40p';
            DataClassification = ToBeClassified;
            BlankZero = true;
            DecimalPlaces = 0:2;
        }
        
        
        
    }
    
}


