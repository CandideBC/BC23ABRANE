codeunit 50016 GestionAttachments
{
    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", OnBeforeDrillDown, '', false, false)]
    local procedure DocumentAttachmentFactbox_OnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        DossierBE: Record "Dossier BE";
        Container: Record Container;
    begin
        case DocumentAttachment."Table ID" of
            database::"Dossier BE":
                begin
                    RecRef.Open(database::"Dossier BE");
                    if DossierBE.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(DossierBE);
                end;
            database::Container:
                begin
                    RecRef.Open(database::Container);
                    if Container.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(Container);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", OnAfterOpenForRecRef, '', false, false)]
    local procedure DocumentAttachmentDetails_OnAfterOpenForRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        MonFieldRef: FieldRef;
        RecNo: Code[20];
    begin
        case RecRef.Number of
            database::"Dossier BE":
                begin
                    MonFieldRef := RecRef.Field(10);
                    RecNo := MonFieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
            database::Container:
                begin
                    MonFieldRef := RecRef.Field(1);
                    RecNo := MonFieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", OnAfterInitFieldsFromRecRef, '', false, false)]
    local procedure DocumentAttachment_OnAfterInitFieldsFromRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        MonFieldRef: FieldRef;
        RecNo: Code[20];

    begin
        case RecRef.Number of
            Database::"Dossier BE":
                begin
                    MonFieldRef := RecRef.Field(10);
                    RecNo := MonFieldRef.Value();
                    DocumentAttachment.Validate("No.", RecNo);
                end;
            Database::Container:
                begin
                    MonFieldRef := RecRef.Field(1);
                    RecNo := MonFieldRef.Value();
                    DocumentAttachment.Validate("No.", RecNo);
                end;
        end;
    end;
}
