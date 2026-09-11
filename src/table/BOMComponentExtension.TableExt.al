tableextension 50037 BOMComponentExtension extends "BOM Component"
{
    fields
    {
        field(50000; "Reference externe client"; Code[20])
        {
            Caption = 'Référence externe client';
            DataClassification = ToBeClassified;
            Description = 'proposition évolution';
            TableRelation = "Item Reference"."Reference No." where ("Item No." = field ("No."),
                                                                                "Reference Type" = const (Customer));
        }
    }

    procedure CopyBOMComponentFromItem(ToItemNo: Code[20]) : Boolean;
    var
      BOMComponent : Record "BOM Component";
      NewBOMComponent : Record "BOM Component";
      Item : Record Item;
      FromItem : Record Item;
      ToItem : Record Item;
      ItemList : Page "Item List";
    begin
      CLEAR(ItemList);

      ToItem.GET(ToItemNo);
      ToItem.TESTFIELD("No. client final");

      Item.RESET();
      Item.SETCURRENTKEY("No. client final");
      Item.SETRANGE("Assembly BOM"    , true);
      Item.SETRANGE("No. client final", ToItem."No. client final");
      ItemList.SETTABLEVIEW(Item);
      ItemList.LOOKUPMODE(true);

      if ItemList.RUNMODAL() = ACTION::LookupOK then
        ItemList.GETRECORD(Item);

      FromItem.GET(Item."No.");
      FromItem.TESTFIELD("No. client final", ToItem."No. client final");
      FromItem.CALCFIELDS("Assembly BOM");
      FromItem.TESTFIELD("Assembly BOM", true);
      BOMComponent.RESET();
      BOMComponent.SETRANGE("Parent Item No.", FromItem."No.");

      if BOMComponent.FindSet() then
        repeat
            NewBOMComponent.INIT();
            NewBOMComponent.VALIDATE("Parent Item No."         , ToItemNo);
            NewBOMComponent.VALIDATE("Line No."                , BOMComponent."Line No.");
            NewBOMComponent.VALIDATE(Type                      , BOMComponent.Type);
            NewBOMComponent.VALIDATE("No."                     , BOMComponent."No.");
            NewBOMComponent.VALIDATE(Description               , BOMComponent.Description);
            NewBOMComponent.VALIDATE("Unit of Measure Code"    , BOMComponent."Unit of Measure Code");
            NewBOMComponent.VALIDATE("Quantity per"            , BOMComponent."Quantity per");
            NewBOMComponent.VALIDATE(Position                  , BOMComponent.Position);
            NewBOMComponent.VALIDATE("Position 2"              , BOMComponent."Position 2");
            NewBOMComponent.VALIDATE("Position 3"              , BOMComponent."Position 3");
            NewBOMComponent.VALIDATE("Machine No."             , BOMComponent."Machine No.");
            NewBOMComponent.VALIDATE("Lead-Time Offset"        , BOMComponent."Lead-Time Offset");
            NewBOMComponent.VALIDATE("Resource Usage Type"     , BOMComponent."Resource Usage Type");
            NewBOMComponent.VALIDATE("Variant Code"            , BOMComponent."Variant Code");
            NewBOMComponent.VALIDATE("Reference externe client", BOMComponent."Reference externe client");
            NewBOMComponent.INSERT();
        until BOMComponent.NEXT() = 0;

      exit(true);
    end;

    procedure CalcPoids(pAfficherMessage : Boolean);
    var
        BOMComponent : Record "BOM Component";
        Item: Record item;
        Text0001Msg : Label 'Le poids de l''article nomenclaturé a été modifié.';
        
        PoidsTotal : Decimal;
    begin
      BOMComponent.SETRANGE("Parent Item No.","Parent Item No.");
      PoidsTotal := 0;
      if BOMComponent.FINDSET(false) then 
        repeat
            Item.GET(BOMComponent."No.");
            PoidsTotal := (Item."Net Weight" * BOMComponent."Quantity per") + PoidsTotal;
        until BOMComponent.NEXT() = 0;

      Item.RESET();
      Item.GET("Parent Item No.");
      Item."Net Weight" := PoidsTotal;
      Item."Gross Weight" := PoidsTotal;
      Item.MODIFY();

      if pAfficherMessage then
        MESSAGE(Text0001Msg);
    end;



}

