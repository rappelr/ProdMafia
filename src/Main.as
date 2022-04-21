package {
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.util.AssetLoader;
import com.company.assembleegameclient.util.StageProxy;
import com.company.util.KeyCodes;

import flash.display.LoaderInfo;
import flash.display.Sprite;
import flash.display.Stage;
import flash.display.StageDisplayState;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.KeyboardEvent;

import io.decagames.rotmg.dailyQuests.config.DailyQuestsConfig;
import io.decagames.rotmg.nexusShop.config.NexusShopConfig;
import io.decagames.rotmg.pets.config.PetsConfig;
import io.decagames.rotmg.seasonalEvent.config.SeasonalEventConfig;
import io.decagames.rotmg.social.config.SocialConfig;
import io.decagames.rotmg.supportCampaign.config.SupportCampaignConfig;
import io.decagames.rotmg.tos.config.ToSConfig;

import kabam.lib.net.NetConfig;
import kabam.rotmg.account.AccountConfig;
import kabam.rotmg.appengine.AppEngineConfig;
import kabam.rotmg.application.ApplicationConfig;
import kabam.rotmg.application.ApplicationSpecificConfig;
import kabam.rotmg.arena.ArenaConfig;
import kabam.rotmg.assets.AssetsConfig;
import kabam.rotmg.build.BuildConfig;
import kabam.rotmg.characters.CharactersConfig;
import kabam.rotmg.classes.ClassesConfig;
import kabam.rotmg.core.CoreConfig;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.dailyLogin.config.DailyLoginConfig;
import kabam.rotmg.death.DeathConfig;
import kabam.rotmg.dialogs.DialogsConfig;
import kabam.rotmg.errors.ErrorConfig;
import kabam.rotmg.external.ExternalConfig;
import kabam.rotmg.fame.FameConfig;
import kabam.rotmg.game.GameConfig;
import kabam.rotmg.language.LanguageConfig;
import kabam.rotmg.legends.LegendsConfig;
import kabam.rotmg.minimap.MiniMapConfig;
import kabam.rotmg.mysterybox.MysteryBoxConfig;
import kabam.rotmg.news.NewsConfig;
import kabam.rotmg.packages.PackageConfig;
import kabam.rotmg.promotions.PromotionsConfig;
import kabam.rotmg.protip.ProTipConfig;
import kabam.rotmg.servers.ServersConfig;
import kabam.rotmg.stage3D.Stage3DConfig;
import kabam.rotmg.startup.StartupConfig;
import kabam.rotmg.startup.control.StartupSignal;
import kabam.rotmg.text.TextConfig;
import kabam.rotmg.tooltips.TooltipsConfig;
import kabam.rotmg.ui.UIConfig;

import robotlegs.bender.bundles.mvcs.MVCSBundle;
import robotlegs.bender.extensions.signalCommandMap.SignalCommandMapExtension;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.LogLevel;

[SWF(frameRate="60", backgroundColor="#000000", width="800", height="600")]
public class Main extends Sprite {
   public static var STAGE:Stage;
   public static var sWidth:Number = 800;
   public static var sHeight:Number = 600;
   public static var focus:Boolean = true;

   protected var context:IContext;

   public function Main() {
      super();

      if (stage) {
         stage.addEventListener(Event.RESIZE, this.onStageResize, false, 0, true);
         this.setup();
      } else addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
   }

   private function setup() : void {
      stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
      stage.scaleMode = StageScaleMode.EXACT_FIT;
      this.createContext();
      new AssetLoader().load();
      this.context.injector.getInstance(StartupSignal).dispatch();
      STAGE = stage;
      STAGE.frameRate = Parameters.data.customFPS;
      addFocusListeners();
      Parameters.root = root;
      if (Parameters.data.fullscreen)
         stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
   }

   private function addFocusListeners() : void {
      stage.addEventListener(Event.ACTIVATE, onActivate,false,0,true);
      stage.addEventListener(Event.DEACTIVATE, onDeactivate,false,0,true);
   }

   private function createContext() : void {
      this.context = new StaticInjectorContext();
      this.context.injector.map(LoaderInfo).toValue(root.stage.root.loaderInfo);
      var stageProxy:StageProxy = new StageProxy(this);
      this.context.injector.map(StageProxy).toValue(stageProxy);
      this.context.extend(MVCSBundle, SignalCommandMapExtension)
              .configure(BuildConfig, StartupConfig, NetConfig, AssetsConfig,
                      DialogsConfig, ApplicationConfig, LanguageConfig, TextConfig,
                      AppEngineConfig, AccountConfig, ErrorConfig, CoreConfig,
                      ApplicationSpecificConfig, DeathConfig, CharactersConfig, ServersConfig,
                      GameConfig, UIConfig, MiniMapConfig, LegendsConfig, NewsConfig, FameConfig,
                      TooltipsConfig, PromotionsConfig, ProTipConfig, ClassesConfig, PackageConfig,
                      PetsConfig, DailyLoginConfig, Stage3DConfig, ArenaConfig, ExternalConfig,
                      MysteryBoxConfig, DailyQuestsConfig, SocialConfig, NexusShopConfig, ToSConfig,
                      SupportCampaignConfig, SeasonalEventConfig, this);
      this.context.logLevel = LogLevel.DEBUG;
   }

   public function onStageResize(_:Event) : void {
      this.scaleX = stage.stageWidth / 800;
      this.scaleY = stage.stageHeight / 600;
      this.x = (800 - stage.stageWidth) / 2;
      this.y = (600 - stage.stageHeight) / 2;
      sWidth = stage.stageWidth;
      sHeight = stage.stageHeight;
   }

   private function onAddedToStage(_:Event) : void {
      stage.addEventListener(Event.RESIZE, this.onStageResize, false, 0, true);
      removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
      this.setup();
   }

   private static function onActivate(_:Event) : void {
      focus = true;
   }

   private static function onDeactivate(_:Event) : void {
      focus = false;
   }

   private static function onKeyDown(keyEvent:KeyboardEvent) : void {
      if (keyEvent.keyCode == KeyCodes.ESCAPE)
         keyEvent.preventDefault();
   }
}
}
