tableextension 50009 LocationExtension extends Location
{
    fields
    {
        field(50000; "Reserved Location"; Boolean)
        {
            Caption = 'Reserved Location';
            DataClassification = ToBeClassified;
            Description = 'STC';

            trigger OnValidate()
            begin
                if "Linked Location Code" <> '' then
                    Error(ABR02Msg);
            end;
        }
        field(50010; "Linked Location Code"; Code[20])
        {
            Caption = 'Linked Location Code';
            DataClassification = ToBeClassified;
            Description = 'STC';
            TableRelation = Location.Code where ("Reserved Location" = filter (true));

            trigger OnValidate()
            begin
                if "Reserved Location" then
                    Error(ABR01Msg);
            end;
        }
        field(50030; "Magasin de rebut"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
        }
        field(50040; "Afficher dans stock"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
        }
        field(50045; "Magasin de transit"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
        }
        field(50050; "Magasin obsolete"; Boolean)
        {
            Caption = 'Magasin obsolète';
            DataClassification = ToBeClassified;
            Description = 'KAN';
        }
        field(50060; "Magasin bloque"; Boolean)
        {
            Caption = 'Magasin bloqué';
            DataClassification = ToBeClassified;
            Description = 'KAN';
        }
        field(50070; "Montrer stock sur creer cde"; Boolean)
        {
            Caption = 'Montrer stock sur créer cde';
            DataClassification = ToBeClassified;
            Description = 'KAN Si le magasin est coché, sur un devis/une commande de vente, lorsqu''on fait Créer commande achat, le système montre article par article le stock dispo sur les magasins qui sont cochés ici.';
        }
        field(50080; "Magasin client"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN Si coché, cela signifie que le magasin est propriété du client. Quand on vendra depuis ce magasin, la vente n''aura pas de prix mais pas de coût non plus.';
        }
    }

    var
        
        ABR01Msg: Label 'Vous ne pouvez pas sélectionner un magasin si le magasin est un magasin Réservé.';
        ABR02Msg: Label 'Vous ne pouvez pas cocher ce champ si vous avez un code magasin lié.';
}

