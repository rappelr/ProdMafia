package kabam.rotmg.messaging.impl.outgoing {

import flash.utils.IDataOutput;

public class ChangeAllyShoot extends OutgoingMessage {
   public var toggle:int;

   public function ChangeAllyShoot(id:uint, callback:Function) {
      super(id, callback);
   }

   override public function writeToOutput(data:IDataOutput) : void {
      data.writeInt(this.toggle);
   }

   override public function toString() : String {
      return formatToString("CHANGE_ALLY_SHOOT", "toggle");
   }
}
}