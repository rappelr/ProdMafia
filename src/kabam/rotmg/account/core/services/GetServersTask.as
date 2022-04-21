package kabam.rotmg.account.core.services {
import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;

public class GetServersTask extends BaseTask {
   [Inject]
   public var account:Account;
   [Inject]
   public var client:AppEngineClient;

   public function GetServersTask() {
      super();
   }

   override protected function startTask() : void {
      this.sendRequest();
   }

   private function sendRequest() : void {
      this.client.complete.addOnce(this.onComplete);
      this.client.sendRequest("/account/servers",{
         "accessToken": this.account.getAccessToken(),
         "game_net": "Unity",
         "play_platform": "Unity",
         "game_net_user_id": ""
      });
   }

   private function onComplete(_:Boolean, __:*) : void {
      completeTask(true);
   }
}
}
