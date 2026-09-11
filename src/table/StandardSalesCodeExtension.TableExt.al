tableextension 50042 StandardSalesCodeExtension extends "Standard Sales Code"
{
    fields
    {
        field(50000; "Groupe prix client"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Price Group";

            trigger OnValidate()
            var
                Client: Record Customer;
                StdCustSalesCode: Record "Standard Customer Sales Code";
            begin
                if "Groupe prix client" = xRec."Groupe prix client" then
                    exit;

                if "Groupe prix client" <> '' then
                    TestField("No. client", '');

                Client.Reset();
                Client.SetCurrentKey("Customer Price Group");

                if "Groupe prix client" <> '' then begin
                    Client.SetRange("Customer Price Group", "Groupe prix client");
                    if Client.FindSet(false) then
                        repeat
                            if not StdCustSalesCode.Get(Client."No.", Code) then begin
                                StdCustSalesCode.Init();
                                StdCustSalesCode."Customer No." := Client."No.";
                                StdCustSalesCode.Code := Code;
                                StdCustSalesCode.Description := Description;
                                StdCustSalesCode.Insert();
                            end;
                        until Client.Next() = 0;
                end else begin
                    Client.SetRange("Customer Price Group", xRec."Groupe prix client");
                    if Client.FindSet(false) then
                        repeat
                            if StdCustSalesCode.Get(Client."No.", Code) then
                                StdCustSalesCode.Delete(true);
                        until Client.Next() = 0;

                end;
            end;
        }
        field(50010; "No. client"; Code[20])
        {
            Caption = 'N° client';
            DataClassification = ToBeClassified;
            TableRelation = Customer;

            trigger OnValidate()
            var
                StdCustSalesCode: Record "Standard Customer Sales Code";
            begin
                CalcFields("Nom du client");
                if "No. client" = xRec."No. client" then
                    exit;

                if "No. client" <> '' then begin
                    TestField("Groupe prix client", '');
                    if not StdCustSalesCode.Get("No. client", Code) then begin
                        StdCustSalesCode.Init();
                        StdCustSalesCode."Customer No." := "No. client";
                        StdCustSalesCode.Code := Code;
                        StdCustSalesCode.Description := Description;
                        StdCustSalesCode.Insert();
                    end;
                end else
                    if StdCustSalesCode.Get("No. client", Code) then
                        StdCustSalesCode.Delete(true);

            end;
        }
        field(50011; "Nom du client"; Text[100])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("No. client")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50020; "Code enseigne"; Code[20])
        {
            Caption = 'Code enseigne';
            DataClassification = ToBeClassified;
            TableRelation = Enseigne;
            trigger OnValidate()
            var
                LigneDocStd: Record "Standard Sales Line";
            begin
                LigneDocStd.SetRange("Standard Sales Code",Rec.Code);
                if LigneDocStd.FindSet(true) then
                    repeat
                        LigneDocStd."Code enseigne" := Rec."Code enseigne";
                        LigneDocStd.Modify();
                    until LigneDocStd.Next() = 0;
            end;
        }

        field(50222; "Devis Stock"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'KAN';
        }
    }
}

