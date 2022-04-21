package kabam.rotmg.account.core {
   public interface Account {
      function get creationDate() : Date;
      function set creationDate(param1:Date) : void;
      function getPlatformToken() : String;
      function setPlatformToken(param1:String) : void;
      function updateUser(userName:String, password:String, token:String,
                          secret:String, accessToken:String = "", accessTokenExpiry:int = -1) : void;
      function getUserName() : String;
      function getUserId() : String;
      function getPassword() : String;
      function getToken() : String;
      function getSecret() : String;
      function getCredentials() : Object;
      function getAccessToken() : String;
      function getAccessTokenExpiry() : int;
      function isRegistered() : Boolean;
      function clear() : void;
      function reportIntStat(param1:String, param2:int) : void;
      function getRequestPrefix() : String;
      function gameNetworkUserId() : String;
      function gameNetwork() : String;
      function playPlatform() : String;
      function getEntryTag() : String;
      function verify(param1:Boolean) : void;
      function isVerified() : Boolean;
      function getMoneyUserId() : String;
      function getMoneyAccessToken() : String;
   }
}
