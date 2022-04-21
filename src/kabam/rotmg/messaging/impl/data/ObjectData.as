package kabam.rotmg.messaging.impl.data {
import com.company.assembleegameclient.util.TimeUtil;

import flash.utils.IDataInput;
   
   public class ObjectData {
       
      
      public var objectType_:int;
      
      public var status_:ObjectStatusData;
      
      public function ObjectData() {
         this.status_ = new ObjectStatusData();
         super();
      }
      
      public function parseFromInput(param1:IDataInput) : void {
         this.objectType_ = param1.readUnsignedShort();
         this.status_.parseFromInput(param1);
         if (this.objectType_ == 0xabd2)
            trace(TimeUtil.getTrueTime(), "Obj read 0xabd2", this.status_);
      }
      
      public function toString() : String {
         return "objectType_: " + this.objectType_ + " status_: " + this.status_;
      }
   }
}
