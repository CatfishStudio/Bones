package bones.dice 
{
	import flash.system.*;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	import bones.data.Atlases;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Dice extends Sprite 
	{
		private var image:Image;
		private var data:Array = [];
		
		public function Dice() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveStage);
			//addEventListener(TouchEvent.TOUCH, onUnitTouch);
			
		}
		
		private function onRemoveStage(e:Event):void 
		{
			super.dispose();
			System.gc();
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			image = new Image(Atlases.textureAtlas.getTexture("dice1012.png"));
			addChild(image);
		}
		
	}

}