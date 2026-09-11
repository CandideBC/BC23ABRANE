table 50013 TamponCdesAchatsParDocVente
{
    Caption = 'Tampon commandes achats par document vente';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code utilisateur"; Code[50])
        {
            Caption = 'Code utilisateur';
        }
        field(2; "Type document vente"; Enum "Sales Document Type")
        {
            Caption = 'Type document';
        }
        field(10; "No. document vente"; Code[20])
        {
            Caption = 'N° document';
        }
        field(20; "No. commande achat"; Code[20])
        {
            Caption = 'N° commande achat';
            TableRelation = "Purchase Header"."No." where ("Document Type"=const(Order));
        }
        field(30; "No. fournisseur"; Code[20])
        {
            Caption = 'N° fournisseur';
            TableRelation = Vendor;
        }
        field(40; "Nom fournisseur"; Text[100])
        {
            Caption = 'Nom fournisseur';
        }
        field(50; "Date semaine chargement"; Date)
        {
            Caption = 'Date semaine chargement';
        }
        field(51; "Semaine chargement"; Integer)
        {
            Caption = 'Semaine chargement';
            BlankZero = true;
        }
        
        field(55; "Date chargement confirmee"; Date)
        {
            Caption = 'Date chargement confirmée';
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Header"."Date chargement confirmee" where ("Document Type"=const(Order),"No."=field("No. commande achat")));
            Editable = false;
        }
        field(60; "Date reception prevue"; Date)
        {
            Caption = 'Date réception prévue';
        }
        field(70; "Commentaires"; Text[250])
        {
            Caption = 'Commentaires';
        }
    }
    keys
    {
        key(PK; "Code utilisateur", "Type document vente", "No. document vente","No. commande achat")
        {
            Clustered = true;
        }

    }
}
