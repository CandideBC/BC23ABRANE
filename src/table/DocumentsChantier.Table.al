table 50062 "Documents chantier"
{
    Caption = 'Documents chantier';
    DataClassification = ToBeClassified;
    //La liste des Commandes achat et Commandse vente de chaque Chantier est vidée et recrée chaque nuit après suppression des documents 
    //facturés (Codeunit50010 planifié)
    //La liste des documents validés d'un chantier se complète à chaque validation de document
    //Il reste ensuite les devis : ils s'ajoutent quand on lance un devis. Ils s'enlèvent quand on transforme un devis en commande.
    
    fields
    {
        field(10; "Code chantier"; Code[20])
        {
            Caption = 'Code chantier';
        }
        field(20; "Type document"; Option)
        {
            Caption = 'Type document';
            OptionMembers = " ","Commande achat","Facture achat","Avoir achat","Devis vente","Commande vente","Facture vente","Avoir vente";
            OptionCaption = ' ,Commande achat,Facture achat,Avoir achat,Devis vente,Commande vente,Facture vente,Avoir vente';
        }
        field(30; "No. document"; Code[20])
        {
            Caption = 'N° document';
            
        }
        field(40; Commentaires; Text[250])
        {
            Caption = 'Commentaires';
        }
        field(50; "Montant DS"; Decimal)
        {
            Caption = 'Montant DS';
        }
    }
    keys
    {
        key(PK; "Code chantier","Type document","No. document")
        {
            Clustered = true;
        }
    }
}
