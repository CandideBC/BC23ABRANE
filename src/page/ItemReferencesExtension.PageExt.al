pageextension 50116 ItemReferencesExtension extends "Item References"
{
    layout
    {
        modify("Variant Code")
        {
            Visible = false;
        }
        

        addafter(Description)
        {
            field("Nom client/fournisseur"; Rec."Nom client/fournisseur")
            {
                ToolTip = 'Nom client/fournisseur';
            }
            field("Customer Price Group";Rec."Customer Price Group")
            {
                ToolTip = 'Groupe prix client';
            }
        }
            

    }
    actions
    {
        addlast(Processing)
        {
            action(CopierReferencesExternes)
            {
                ApplicationArea = All;
                Caption = 'Copier références externes';
                Promoted=true;
                PromotedIsBig=true;
                Image=CopyItem;
                PromotedCategory=Process;



                
                trigger OnAction()
                var
                    recRefExterne : Record "Item Reference";
                    repCopieRefExterne : Report "Copy Item Cross Reference";
                    
                begin
                    //DIA.ABRA.REF NBE 08/12/2014 DEBUT
                    CLEAR(recRefExterne);
                    CLEAR(repCopieRefExterne);
                    CurrPage.SETSELECTIONFILTER(recRefExterne);
                    repCopieRefExterne.fctInitValue(recRefExterne);
                    repCopieRefExterne.RUNMODAL();
                    //DIA.ABRA.REF NBE 08/12/2014 FIN

                end;
            }
        }
    }
}

