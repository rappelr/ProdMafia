package kabam.rotmg.messaging.impl.incoming {
   import flash.utils.IDataInput;
   
   public class Notification extends IncomingMessage {
      public static const STAT_INCREASE:int = 0;
      public static const SERVER_MESSAGE:int = 1;
      public static const ERROR_MESSAGE:int = 2;
      public static const NO_DISAPPEAR:int = 3;
      public static const UI_NOTIFICATION:int = 4;
      public static const QUEUE:int = 5;
      public static const OBJECT_STATUS_TEXT:int = 6;
      public static const DEATH:int = 7;
      public static const DUNGEON:int = 8;

      public var effect:int;
      public var extraValue:int;
      public var message:String;
      public var uiNotificationType:int;
      public var portalIdx:int;
      public var portalObjId:int;
      public var position:int;
      public var objectId_:int;
      public var color:int;
      public var pictureObjType:int;

      public function Notification(param1:uint, param2:Function) {
         super(param1,param2);
      }
      
      override public function parseFromInput(input:IDataInput) : void {
         this.effect = input.readByte();
         this.extraValue = input.readByte();
         if (this.effect != QUEUE)
            this.message = input.readUTF();

         switch (this.effect) {
            case UI_NOTIFICATION:
                 this.uiNotificationType = input.readShort();
                 break;
            case QUEUE:
                 this.portalIdx = input.readShort();
                 this.portalObjId = input.readShort();
                 this.position = input.readShort();
                 break;
            case OBJECT_STATUS_TEXT:
                 this.objectId_ = input.readInt();
                 this.color = input.readInt();
                 break;
            case DEATH:
            case DUNGEON:
                 this.pictureObjType = input.readInt();
                 break;
         }
      }
      
      override public function toString() : String {
         return formatToString("NOTIFICATION","objectId_","message");
      }
   }
}
