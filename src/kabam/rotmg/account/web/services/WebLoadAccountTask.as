package kabam.rotmg.account.web.services {
import com.company.assembleegameclient.util.GUID;

import flash.net.SharedObject;

import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.services.LoadAccountTask;
import kabam.rotmg.account.web.model.AccountData;
import kabam.rotmg.appengine.api.AppEngineClient;

public class WebLoadAccountTask extends BaseTask implements LoadAccountTask {


    public function WebLoadAccountTask() {
        super();
    }
    [Inject]
    public var account:Account;
    [Inject]
    public var client:AppEngineClient;
    private var data:AccountData;

    override protected function startTask():void {
        this.getAccountData();
        if (this.data.username) {
            this.setAccountDataThenComplete();
        } else {
            this.setGuestPasswordAndComplete();
        }
    }

    private function getAccountData():void {
        var loginSO:Object = null;
        this.data = new AccountData();
        try {
            loginSO = SharedObject.getLocal("login", "/");
            loginSO.data["GUID"] && (this.data.username = loginSO.data["GUID"]);
            loginSO.data["Password"] && (this.data.password = loginSO.data["Password"]);
            loginSO.data["Token"] && (this.data.token = loginSO.data["Token"]);
            loginSO.data["Secret"] && (this.data.secret = loginSO.data["Secret"]);
            loginSO.data["AccessToken"] && (this.data.accessToken = loginSO.data["AccessToken"]);
            loginSO.data["AccessTokenExpiry"] && (this.data.accessTokenExpiry = loginSO.data["AccessTokenExpiry"]);
            if (loginSO.data.hasOwnProperty("Name"))
                this.data.name = loginSO.data["Name"];
        } catch (error:Error) {
            trace(error.message);
            data.username = null;
            data.password = null;
            data.token = null;
            data.secret = null;
            data.accessToken = null;
            data.accessTokenExpiry = 0;
        }
    }

    private function setAccountDataThenComplete():void {
        this.account.updateUser(this.data.username, this.data.password, this.data.token, this.data.secret, this.data.accessToken, this.data.accessTokenExpiry);
        this.account.verify(false);
        completeTask(true);
    }

    private function setGuestPasswordAndComplete():void {
        this.account.updateUser(GUID.create(), null, "", "");
        completeTask(true);
    }
}
}
