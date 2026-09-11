pageextension 50115 ItemReferenceEntriesExtension extends "Item Reference Entries"
{
    layout
    {
        modify("Variant Code")
        {
            Visible = false;
        }
        
        addafter("Reference Type No.")
        {
            field("Nom client/fournisseur"; Rec."Nom client/fournisseur")
            {
                ToolTip = 'Nom client/fournisseur';
            }

        }
        addafter(Description)
        {

            field("Customer Price Group";Rec."Customer Price Group")
            {
                ToolTip = 'Groupe prix client';
            }
        }
            

    }
    actions
    {


    }
}

