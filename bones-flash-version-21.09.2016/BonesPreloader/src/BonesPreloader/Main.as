package BonesPreloader
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Catfish Studio
	 */
	[SWF(width="860", height="730", frameRate="30", backgroundColor="#ffffff")]
	public class Main extends Sprite 
	{
		[Embed(source = '../../assets/background.jpg')]
		private var BackgroundImage:Class;
		private var backgroundBitmap:Bitmap = new BackgroundImage();
		private var progressText:Label;
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addChild(backgroundBitmap);
			
			progressText = new Label(660, 650, 300, 70, "Monotype Corsiva", 25, 0xFFFF80, "Загрузка 0%", false);
			progressText.text = "Загрузка 100%";
			this.addChild(progressText);
		}
		
		public function setValue(valuePercent:int):void
		{
			progressText.text = "Загрузка " + valuePercent.toString() + "%";
		}
		
		public function setText(valueText:String):void
		{
			progressText.text = valueText;
		}
		
		public function getValue():String
		{
			return progressText.text;
		}
	}
	
}