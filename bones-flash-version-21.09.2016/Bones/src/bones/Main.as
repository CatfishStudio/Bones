package bones
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display3D.Context3DRenderMode;
	import flash.geom.Rectangle;
	
	
	import starling.core.Starling;
	import starling.display.Stage;
	
	import bones.data.Constants;
	import bones.vkAPI.VK;
	import vk.APIConnection;
	/**
	 * ...
	 * @author Catfish Studio
	 */
	[SWF(width="860", height="730", frameRate="60", backgroundColor="#ffffff", allowFullscreen="true")]
	public class Main extends Sprite 
	{
		private var starling:Starling;
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			vkInit();
			initStarling();
		}
		
		/* Иникиализация ВКонтакте */
		private function vkInit():void
		{
			var flashVars: Object = stage.loaderInfo.parameters as Object;
			VK.vkConnection = new APIConnection(flashVars);
		}
		
		private function initStarling():void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			//stage.addEventListener (Event.RESIZE, resizeListenerFlash);
			starling = new Starling(Game, stage, null, null, Context3DRenderMode.SOFTWARE);
			starling.antiAliasing = 1;
			starling.start();
		}
		
		private function resizeListenerFlash(event:Event):void
		{
			Starling.current.viewPort = new Rectangle (0, 0, stage.stageWidth, stage.stageHeight);
			starling.stage.stageWidth = Constants.GAME_WINDOW_WIDTH;
			starling.stage.stageHeight = Constants.GAME_WINDOW_HEIGHT;
		}
		
	}
	
}