package kabam.rotmg.messaging.impl.outgoing {
   import flash.utils.IDataOutput;
   import kabam.rotmg.messaging.impl.data.WorldPosData;
   
   public class PlayerShoot extends OutgoingMessage {

      public var time_:int;
      public var bulletId_:uint;
      public var containerType_:int;
      public var startingPos_:WorldPosData;
      public var angle_:Number;
      public var burstId:int;
      public var unknown1:int;
      
      public function PlayerShoot(param1:uint, param2:Function) {
         this.startingPos_ = new WorldPosData();
         unknown1 = 255;
         super(param1,param2);
      }
      
      override public function writeToOutput(param1:IDataOutput) : void {
         param1.writeInt(this.time_);
         param1.writeShort(this.bulletId_);
         param1.writeShort(this.containerType_);
         param1.writeByte(this.unknown1);
         this.startingPos_.writeToOutput(param1);
         param1.writeFloat(this.angle_);
         param1.writeByte(this.burstId);
      }
      
      override public function toString() : String {
         return formatToString("PLAYERSHOOT","time_","bulletId_","containerType_","startingPos_","angle_","speedMult_","lifeMult_","isBurst");
      }
   }
}
