package kabam.rotmg.messaging.impl.outgoing {

import flash.utils.IDataOutput;

public class ShootAckCounter extends OutgoingMessage {
    public var time:int;
    public var amount:int;

    public function ShootAckCounter(id:uint, callback:Function) {
        super(id, callback);
    }

    override public function writeToOutput(data:IDataOutput) : void {
        data.writeInt(this.time);
        data.writeShort(this.amount);
    }

    override public function toString() : String {
        return formatToString("SHOOTACK_COUNTER", "time", "amount");
    }
}
}