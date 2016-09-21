package bones
{
	import vk.APIConnection;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import starling.core.Starling;
	import starling.display.Stage;
	
	/**
	 * ...
	 * @author Catfish Studio
	 */
	[SWF(width="860", height="730", frameRate="60", backgroundColor="#ffffff", allowFullscreen="true")]
	public class Main extends Sprite 
	{
		private var _starling:Starling;
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
		}
		
	}
	
}