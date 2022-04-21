package kabam.rotmg.core.service {
import com.company.assembleegameclient.parameters.Parameters;

import kabam.lib.tasks.BaseTask;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.appengine.api.AppEngineClient;
   
   public class VerifyAccessTokenTask extends BaseTask {
      [Inject]
      public var account:Account;
      [Inject]
      public var client:AppEngineClient;
      
      public function VerifyAccessTokenTask() {
         super();
      }
      
      override protected function startTask() : void {
         this.client.complete.addOnce(this.onComplete);
         this.client.sendRequest("/account/verifyAccessTokenClient", {
            "clientToken": Parameters.data.clientToken,
            "accessToken": this.account.getAccessToken(),
            "game_net": "Unity",
            "play_platform": "Unity",
            "game_net_user_id": ""
         });
      }
      
      private function onComplete(param1:Boolean, param2:*) : void {
         completeTask(true, param2);
      }
   }
}
