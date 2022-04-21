package kabam.rotmg.account.web.services {
import com.company.assembleegameclient.parameters.Parameters;

import kabam.lib.tasks.BaseTask;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.account.core.services.LoginTask;
   import kabam.rotmg.account.web.model.AccountData;
import kabam.rotmg.account.web.signals.LoginSuccessSignal;
import kabam.rotmg.appengine.api.AppEngineClient;
   
   public class WebLoginTask extends BaseTask implements LoginTask {
      [Inject]
      public var account:Account;
      [Inject]
      public var data:AccountData;
      [Inject]
      public var client:AppEngineClient;
      [Inject]
      public var loginSuccess:LoginSuccessSignal;
      
      public function WebLoginTask() {
         super();
      }
      
      override protected function startTask() : void {
         this.client.complete.addOnce(this.onComplete);
         if (this.data.secret != "") {
            this.client.sendRequest("/account/verify",{
               "game_net": "Unity",
               "play_platform": "Unity",
               "game_net_user_id": "",
               "guid": this.data.username,
               "secret": this.data.secret,
               "clientToken": Parameters.data.clientToken
            });
         } else {
            this.client.sendRequest("/account/verify",{
               "game_net": "Unity",
               "play_platform": "Unity",
               "game_net_user_id": "",
               "guid": this.data.username,
               "password": this.data.password,
               "clientToken": Parameters.data.clientToken
            });
         }
      }
      
      private function onComplete(success:Boolean, response:*) : void {
         if (success)
            this.updateUser(response);

         completeTask(success, response);
      }
      
      private function updateUser(response:String) : void {
         var xml:XML = XML(response);
         this.account.updateUser(this.data.username, this.data.password, "", this.data.secret,
                 xml.AccessToken,
                 xml.AccessTokenTimestamp + xml.AccessTokenExpiration * 1000);
         this.loginSuccess.dispatch();
      }
   }
}
