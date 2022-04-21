package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

import kabam.rotmg.messaging.impl.data.WorldPosData;

public class CreepMoveMessage extends OutgoingMessage {
    public var time:int;
    public var pos:WorldPosData;
    public var hold:Boolean;

    public function CreepMoveMessage(id:uint, callback:Function) {
        super(id, callback);
    }

    override public function writeToOutput(output:IDataOutput) : void {
        output.writeInt(this.time);
        this.pos.writeToOutput(output);
        output.writeBoolean(this.hold);
    }
}
}
