tableextension 50028 ReturnShipmentHeaderExtension extends "Return Shipment Header"
{
    fields
    {
        field(50008; "No. container"; Code[20])
        {
            Caption = 'N° container';
            DataClassification = ToBeClassified;
            Description = 'Utilisé uniquement au moment de la réception pour récupérer sur le bon de réception le N° de container. Au final, une commande aura vu passer plusieurs valeurs dans ce champ si elle se trouvait dans plusieurs containers.';
            TableRelation = Container;
        }
    }
    keys
    {
        key(MyKey1; "No. container")
        {
            
        }
    }
}

