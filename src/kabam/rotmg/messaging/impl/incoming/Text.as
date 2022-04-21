package kabam.rotmg.messaging.impl.incoming {
   import flash.utils.IDataInput;
   
   public class Text extends IncomingMessage {
      public var name_:String;
      public var objectId_:int;
      public var numStars_:int;
      public var bubbleTime_:uint;
      public var recipient_:String;
      public var text_:String;
      public var cleanText_:String;
      public var isSupporter:Boolean = false;
      public var starBg:int;
      
      public function Text(id:uint, callback:Function) {
         this.name_ = "";
         this.text_ = "";
         this.cleanText_ = "";
         super(id, callback);
      }
      
      override public function parseFromInput(input:IDataInput) : void {
         this.name_ = input.readUTF();
         this.objectId_ = input.readInt();
         this.numStars_ = input.readShort();
         this.bubbleTime_ = input.readUnsignedByte();
         this.recipient_ = input.readUTF();
         this.text_ = input.readUTF();
         this.cleanText_ = input.readUTF();
         this.isSupporter = input.readBoolean();
         this.starBg = input.readInt();
      }
      
      override public function toString() : String {
         return formatToString("TEXT","name_","objectId_","numStars_",
                 "bubbleTime_","recipient_","text_","cleanText_",
                 "isSupporter","starBg");
      }
   }
}
