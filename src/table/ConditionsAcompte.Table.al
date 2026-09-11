table 50038 "Conditions acompte"
{

    fields
    {
        field(1; Type; Option)
        {
            OptionMembers = Enseigne,Client;
        }
        field(10; "Code"; Code[20])
        {
            TableRelation = if (Type = const (Enseigne)) Enseigne
            else
            if (Type = const (Client)) Customer;
        }
        field(20; "Montant minimum"; Decimal)
        {
        }
        field(30; "% acompte demande"; Decimal)
        {
            Caption = '% acompte demandé';

            trigger OnValidate()
            begin
                /*Inutile FHA
                IF "% acompte demande" <> xRec."% acompte demande" THEN BEGIN
                  Client.RESET;
                  Client.SETCURRENTKEY("Code enseigne");
                  Client.SETRANGE("Code enseigne","Code enseigne");
                  IF Client.FINDSET(TRUE,FALSE) THEN
                    REPEAT
                      IF Client."% acompte demande" = xRec."% acompte demande" THEN BEGIN
                        Client."% acompte demande" := "% acompte demande";
                        Client.MODIFY;
                      END;
                    UNTIL Client.NEXT = 0;
                END;
                Inutile FHA*/

            end;
        }
    }

    keys
    {
        key(Key1; Type, "Code", "Montant minimum")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

