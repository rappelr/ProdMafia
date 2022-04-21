package kabam.rotmg.messaging.impl.incoming {
   import flash.utils.IDataInput;
   import kabam.rotmg.messaging.impl.data.WorldPosData;
   
   public class ServerPlayerShoot extends IncomingMessage {
      public var bulletId_:uint;
      public var ownerId_:int;
      public var containerType_:int;
      public var startingPos_:WorldPosData;
      public var angle_:Number;
      public var damage_:int;
      public var creepObjId:int;
      public var isMultiShotCreep:Boolean;
      public var shotCount:int;
      public var angleIncRad:int;
      
      public function ServerPlayerShoot(param1:uint, param2:Function) {
         this.startingPos_ = new WorldPosData();
         super(param1, param2);
      }
      
      override public function parseFromInput(input:IDataInput) : void {
         this.bulletId_ = input.readUnsignedByte();
         this.ownerId_ = input.readInt();
         this.containerType_ = input.readInt();
         this.startingPos_.parseFromInput(input);
         this.angle_ = input.readFloat();
         this.damage_ = input.readShort();
         this.creepObjId = input.readInt();
         this.isMultiShotCreep = input.readBoolean();
         if (input.bytesAvailable > 0) {
            this.shotCount = input.readByte();
            this.angleIncRad = input.readInt();
         }
      }
      
      override public function toString() : String {
         return formatToString("SHOOT","bulletId_","ownerId_","containerType_","startingPos_","angle_","damage_");
      }
   }
}
