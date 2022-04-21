package kabam.rotmg.messaging.impl.incoming {
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class MapInfo extends IncomingMessage {
      public var width_:int;
      public var height_:int;
      public var name_:String;
      public var displayName_:String;
      public var realmName_:String;
      public var difficulty_:int;
      public var fp_:uint;
      public var background_:int;
      public var allowPlayerTeleport_:Boolean;
      public var showDisplays_:Boolean;
      public var maxPlayers_:int;
      public var gameOpenedTime_:int;
      public var version:String;
      
      public function MapInfo(param1:uint, param2:Function) {
         super(param1,param2);
      }
      
      override public function parseFromInput(param1:IDataInput) : void {
         this.width_ = param1.readInt();
         this.height_ = param1.readInt();
         this.name_ = param1.readUTF();
         this.displayName_ = param1.readUTF();
         this.realmName_ = param1.readUTF();
         this.fp_ = param1.readUnsignedInt();
         this.background_ = param1.readInt();
         this.difficulty_ = param1.readInt();
         this.allowPlayerTeleport_ = param1.readBoolean();
         this.showDisplays_ = param1.readBoolean();
         this.maxPlayers_ = param1.readShort();
         this.gameOpenedTime_ = param1.readUnsignedInt();
         this.version = param1.readUTF();
      }
      
      override public function toString() : String {
         return formatToString("MAPINFO","width_","height_","name_","displayName_","realmName_","fp_","background_","allowPlayerTeleport_","showDisplays_","clientXML_","extraXML_","maxPlayers_","connectionGuid_","gameOpenedTime_");
      }
   }
}
