pageextension 50117 ItemReferenceListExtension extends "Item Reference List"
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
        addafter("Item No.")
        {
            field("Complément réf. client";Rec."Complément réf. client")
            {
                ToolTip = 'Complément réf. client';
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

