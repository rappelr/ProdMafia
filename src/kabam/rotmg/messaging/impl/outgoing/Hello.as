package kabam.rotmg.messaging.impl.outgoing {
import com.company.assembleegameclient.parameters.Parameters;

import flash.utils.ByteArray;
   import flash.utils.IDataOutput;
   
   public class Hello extends OutgoingMessage {
      public var buildVersion_:String;
      public var gameId_:int = 0;
      public var keyTime_:int = 0;
      public var key_:ByteArray;
      public var entrytag_:String = "";
      public var gameNet:String = "";
      public var gameNetUserId:String = "";
      public var userToken:String = "";
      public var accessToken:String = "";

      public function Hello(param1:uint, param2:Function) {
         this.buildVersion_ = "";
         this.key_ = new ByteArray();
         super(param1,param2);
      }
      
      override public function writeToOutput(param1:IDataOutput) : void {
         param1.writeUTF(this.buildVersion_);
         param1.writeInt(this.gameId_);
         param1.writeUTF(this.accessToken);
         param1.writeInt(this.keyTime_);
         param1.writeShort(this.key_.length);
         param1.writeBytes(this.key_);
         param1.writeUTF(this.entrytag_);
         param1.writeUTF(this.gameNet);
         param1.writeUTF(this.gameNetUserId);
         param1.writeUTF(this.userToken);
         param1.writeUTF(Parameters.CLIENT_TOKEN);
      }
      
      override public function toString() : String {
         return formatToString("HELLO",
                 "buildVersion_","gameId_","accessToken", "keyTime_",
                 "key_","mapJSON_","entrytag_","gameNet","gameNetUserId",
                 "playPlatform","platformToken","userToken");
      }
   }
}
